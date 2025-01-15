unit ContainerGridFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, TntGrids, OctopusGridCls, Tabs, StdCtrls, TntStdCtrls,
  Buttons, ComCtrls, ToolWin, ExtCtrls, ContainerListCls,
  ContainerCls, DocumentCls, PartCls, ImgList;

type
  TOnSelectItem = procedure (Part: TPart) of object;

  TfrmContainers = class(TFrame)
    pnBotttom: TPanel;
    lbTotalLabel1: TLabel;
    lbTotalLabel2: TLabel;
    lbTotalData1: TLabel;
    lbTotalData2: TLabel;
    pnTop: TPanel;
    pnToolBar: TPanel;
    ToolBar1: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    pnSearch: TPanel;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    edSearch: TTntEdit;
    tsContainerList: TTabSet;
    grContainer: TOctopusStringGrid;
    ImageList1: TImageList;
    lbTotalLabel3: TLabel;
    lbTotalLabel4: TLabel;
    lbTotalData3: TLabel;
    lbTotalData4: TLabel;
    ToolButton1: TToolButton;
    btnCheckListMode: TToolButton;
    ToolButton3: TToolButton;
    btnCheckAll: TToolButton;
    btnUncheckAll: TToolButton;
    btnInvertCheck: TToolButton;
    procedure btnInvertCheckClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnCheckListModeClick(Sender: TObject);
    procedure btnColoredClick(Sender: TObject);
    procedure tsContainerListChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure btnWrapClick(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure grContainerSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FrameResize(Sender: TObject);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  published
    procedure RefreshGrid(Sende: TObject);
  private
    { Private declarations }
    FCurContainer: TContainer;
    FDocument: TDocument;
    FOnSelectItem: TOnSelectItem;
    FEditMode: boolean;
    procedure RefreshHeader(Language: integer);
    procedure SetEditMode(EditMode: boolean);
    procedure UpdateGrid(Container: TContainer);
    procedure SetCheckButtonsEnabled(Value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateData(Document: TDocument);
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnSelectItem: TOnSelectItem read FOnSelectItem write FOnSelectItem;
  end;

implementation

{$R *.dfm}


uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls, BoxItemCls, BoxCls,
  Math;


constructor TfrmContainers.Create(AOwner: TComponent);
var
  I: integer;
begin
  inherited Create(AOwner);
  FCurContainer := nil;
  SetEditMode(False);
  grContainer.Colored := True;
  Self.btnWrap.Down := grContainer.WordWrap;
  Self.btnColored.Down := grContainer.Colored;
  Self.btnCheckListMode.Down := grContainer.CheckListStyle;
  Self.SetCheckButtonsEnabled(grContainer.CheckListStyle);
  grContainer.ColWidths[0] := 30;
  grContainer.ColAlign[4] := DT_CENTER;
  grContainer.ColWidths[4] := 30;
  for I := 5 to grContainer.ColCount - 1 do grContainer.ColAlign[I] := DT_RIGHT;
end;

procedure TfrmContainers.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then Self.RefreshGrid(Self)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then Self.RefreshGrid(Self);
end;

procedure TfrmContainers.FrameResize(Sender: TObject);
var
  I, ColWidth: integer;
begin
  // Поизционирование строки поиска.
  Self.pnSearch.Width := Self.pnTop.ClientWidth - Self.pnToolBar.Width;
  if Self.pnSearch.Width > 200 then Self.pnSearch.Width := 200;
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grContainer.ColCount - 1 do
    if I <> 3 then
      ColWidth := ColWidth + grContainer.ColWidths[I] + 1;
  grContainer.ColWidths[3] := grContainer.ClientWidth - ColWidth - 2;
  if grContainer.ColWidths[3] < 70 then grContainer.ColWidths[3] := 70;
  grContainer.Repaint;
end;

procedure TfrmContainers.grContainerSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Assigned(Self.FOnSelectItem) and (grContainer.Objects[2, ARow] <> nil) then
    Self.FOnSelectItem(TBoxItem(grContainer.Objects[2, ARow]).Part);
end;

procedure TfrmContainers.btnCheckAllClick(Sender: TObject);
begin
  grContainer.SelectAll;
  grContainer.Repaint;
end;

procedure TfrmContainers.btnCheckListModeClick(Sender: TObject);
begin
  Self.grContainer.CheckListStyle := Self.btnCheckListMode.Down;
  if Self.btnCheckListMode.Down then grContainer.UnselectAll;
  Self.SetCheckButtonsEnabled(grContainer.CheckListStyle);
  grContainer.Repaint;
end;

procedure TfrmContainers.btnClearSearchClick(Sender: TObject);
begin
  edSearch.Text := '';
  Self.RefreshGrid(Self);
end;

procedure TfrmContainers.btnColoredClick(Sender: TObject);
begin
  grContainer.Colored := Self.btnColored.Down;
  grContainer.Repaint;
end;

procedure TfrmContainers.btnInvertCheckClick(Sender: TObject);
begin
   grContainer.ChangeSelection;
   grContainer.Repaint;
end;

procedure TfrmContainers.btnUncheckAllClick(Sender: TObject);
begin
   grContainer.UnselectAll;
   grContainer.Repaint;
end;

procedure TfrmContainers.btnWrapClick(Sender: TObject);
begin
  grContainer.WordWrap := Self.btnWrap.Down;
  grContainer.Repaint;
end;

procedure TfrmContainers.SetCheckButtonsEnabled(Value: Boolean);
begin
  Self.btnCheckAll.Enabled := Value;
  Self.btnUncheckAll.Enabled := Value;
  Self.btnInvertCheck.Enabled := Value;
end;

procedure TfrmContainers.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
end;

procedure TfrmContainers.UpdateData(Document: TDocument);
var
  I: integer;
begin
  FDocument := Document;
  Self.tsContainerList.Tabs.Clear;
  Self.Visible := (FDocument.Containers.Count > 0);
  if FDocument.Containers.Count = 0 then begin
    Self.grContainer.Clear;
    Exit;
  end;
  for I := 0 to FDocument.Containers.Count - 1 do
    Self.tsContainerList.Tabs.AddObject(FDocument.Containers.Items[I].Title,
      FDocument.Containers.Items[I]);
  Self.tsContainerList.TabIndex := 0;
end;

procedure TfrmContainers.tsContainerListChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if NewTab >= 0 then begin
    FCurContainer := TContainer(Self.tsContainerList.Tabs.Objects[NewTab]);
    Self.UpdateGrid(FCurContainer);
  end;
end;

procedure TfrmContainers.UpdateGrid(Container: TContainer);
begin
  Self.FCurContainer := Container;
  Self.RefreshGrid(Self);
end;

procedure TfrmContainers.RefreshHeader(Language: integer);
begin
  grContainer.Cells[0,0] := '№';
  grContainer.Cells[1,0] :=
    Translator.GetInstance.TranslateWord('Гр.№', language);
  grContainer.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Заказ', language);
  grContainer.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Наименование', language);
  grContainer.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Ед.', language);
  grContainer.Cells[5,0] :=
    Translator.GetInstance.TranslateWord('Кол-во', language);
  grContainer.Cells[6,0] :=
    Translator.GetInstance.TranslateWord('Кол.мест', language);
  grContainer.Cells[7,0] :=
    Translator.GetInstance.TranslateWord('Нетто,кг', language);
  grContainer.Cells[8,0] :=
    Translator.GetInstance.TranslateWord('Брутто,кг', language);
  grContainer.Cells[9,0] :=
    Translator.GetInstance.TranslateWord('Уп-ка,кг', language);
  grContainer.Cells[10,0] :=
    Translator.GetInstance.TranslateWord('Объем,м3', language);
end;

procedure TfrmContainers.RefreshGrid(Sende: TObject);
var
  Language: integer;
  I, J, ARow, BoxNumber: integer;
  Box: TBox;
  Item: TBoxItem;
  AddRow: boolean;
  IsFirstRow: boolean;
  PackageWeight: real;
begin
  Self.grContainer.Clear;
  Language := GlobalSettings.GetInstance.Language;
  Self.RefreshHeader(Language);
  grContainer.Enabled := (FCurContainer <> nil) and (grContainer.RowCount > 0);
  grContainer.RowCount := 2;
  if ((FCurContainer = nil) or (FCurContainer.Count = 0)) then Exit;
  ARow := 1;
  BoxNumber := 0;
  for I := 0 to FCurContainer.Count - 1 do begin
    Box := TBox(FCurContainer.Items[I]);
    IsFirstRow := True;
    for J := 0 to Box.Count - 1 do begin
      Item := TBoxItem(Box.Items[J]);
      AddRow := True;
      // Отбор по полю поиска.
      if Length(edSearch.Text) > 0 then
        AddRow := (pos(WideUpperCase(edSearch.Text),
          WideUpperCase(Item.Part.GetTranslatedTitle(Language))) > 0);
      // Вывод строки.
      if AddRow then begin
        if IsFirstRow then begin
          IsFirstRow := False;
          Inc(BoxNumber);
          grContainer.Cells[0, ARow] := IntToStr(BoxNumber);
          grContainer.Cells[1, ARow] := Box.BoxCode;
          grContainer.Cells[6, ARow] := IntToStr(Box.BoxCount);
          grContainer.Cells[7, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            Box.NetWeight);
          grContainer.Cells[8, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            Box.GrossWeight);
          PackageWeight := (Box.GrossWeight - Box.NetWeight) / Box.BoxCount;
          PackageWeight := SimpleRoundTo(
            PackageWeight,
            -GlobalSettings.GetInstance.WeightAccuracy);
          grContainer.Cells[9, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            PackageWeight);
          grContainer.Cells[10, ARow] := FormatFloat(
            GlobalSettings.GetInstance.VolumeAccuracyMask,
            Box.Volume);
        end;
        grContainer.Cells[2, ARow] := Item.Order.Title;
        grContainer.Cells[3, ARow] := Item.Part.GetTranslatedTitle(
          GlobalSettings.GetInstance.Language);
        grContainer.Cells[4, ARow] := Translator.GetInstance.TranslateWord(
          Item.Part.PartUnit, GlobalSettings.GetInstance.Language);
        grContainer.Cells[5, ARow] := FloatToStr(Item.OrderCount);

        if BoxNumber mod 2 = 0 then
          grContainer.SetRowColor(ARow, rgb(240, 240, 230));

        Self.grContainer.Objects[1, ARow] := Box;
        Self.grContainer.Objects[2, ARow] := Item;
        grContainer.RowCount := grContainer.RowCount + 1;
        inc(ARow);
      end;
    end;
  end;
  grContainer.Enabled := (ARow > 1);
  if ARow > 1 then begin
    grContainer.RowCount := ARow;
    Self.lbTotalData1.Caption := IntToStr(FCurContainer.TotalBoxCount);
    Self.lbTotalData2.Caption := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask,
      FCurContainer.RealNetWeight);
    Self.lbTotalData3.Caption := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask,
      FCurContainer.MaxWeight)
      + ' / ' +
      FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
        FCurContainer.RealGrossWeight);
    if FCurContainer.RealGrossWeight > FCurContainer.MaxWeight then
      Self.lbTotalData3.Font.Color := clRed
    else
      Self.lbTotalData3.Font.Color := clBlack;
    Self.lbTotalData4.Caption := FormatFloat(
      GlobalSettings.GetInstance.VolumeAccuracyMask,
      FCurContainer.MaxVolume)
      + ' / ' +
      FormatFloat(GlobalSettings.GetInstance.VolumeAccuracyMask,
        FCurContainer.RealVolume);
    if FCurContainer.RealVolume > FCurContainer.MaxVolume then
      Self.lbTotalData4.Font.Color := clRed
    else
      Self.lbTotalData4.Font.Color := clBlack;
  end;
  Self.pnBotttom.Visible := (ARow > 1);
  grContainer.Repaint;
  grContainer.Selection := TGridRect(Rect(-1, -1, -1, -1));
end;

end.
