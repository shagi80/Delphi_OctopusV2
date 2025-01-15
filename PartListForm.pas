unit PartListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls, Grids, TntGrids,
  OctopusGridCls, ImgList, PartListCls, PartCls, Contnrs, OrderCls, TntStdCtrls;

type
  TfrmPartList = class(TForm)
    pnButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    pnMain: TPanel;
    lbCaption: TLabel;
    Splitter1: TSplitter;
    pnLeft: TPanel;
    pnRight: TPanel;
    grParts: TOctopusStringGrid;
    grSelectedParts: TOctopusStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    imlButtons: TImageList;
    pnMiddle: TPanel;
    btnMove: TSpeedButton;
    btnRemoveAll: TSpeedButton;
    btnRemove: TSpeedButton;
    dlgOpen: TOpenDialog;
    Panel1: TPanel;
    pnFilter: TPanel;
    edSearch: TTntEdit;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    pnToolBar: TPanel;
    ToolBar1: TToolBar;
    btnWordWrap: TToolButton;
    btnColored: TToolButton;
    btnSort: TToolButton;
    ToolButton1: TToolButton;
    cbAllParts: TCheckBox;
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure cbAllPartsClick(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure grPartsDblClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
    procedure RefreshHeader(Sender: TObject);
    procedure RefreshGrid(Grid: TOctopusStringGrid; Parts: TObjectList);
  private
    { Private declarations }
    FSorted: boolean;
    FParts: TPartList;
    FSelectedParts: TObjectList;
    FCurOrder: TOrder;
    FFileName: string;
    procedure ResizeGrid(Grid: TTntStringGrid);
    procedure SetCaptionText;
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
  public
    { Public declarations }
    function SelectFromPartsList(Parts: TPartList; SelectedParts: TObjectList;
      CurOrder: TOrder; FileName: string = ''): boolean;
  end;

var
  frmPartList: TfrmPartList;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, OrderItemCls;

procedure TfrmPartList.FormCreate(Sender: TObject);
begin
  grParts.Colored := True;
  grSelectedParts.Colored := True;
  grSelectedParts.ColAlign[2] := DT_RIGHT;
  grSelectedParts.EditableCells := [2];
  grSelectedParts.OnEndEdit := Self.OnEndEditGrid;
  btnColored.Down := True;
  FSorted := True;
  btnSort.Down := True;
  FParts := nil;
  FSelectedParts := nil;
  Self.FCurOrder := nil;
end;

procedure TfrmPartList.FormResize(Sender: TObject);
begin
  btnOk.Left := trunc(Self.ClientWidth / 2) - btnOk.Width - 3;
  btnCancel.Left := trunc(Self.ClientWidth / 2) + 3;
  Self.ResizeGrid(Self.grParts);
  Self.ResizeGrid(Self.grSelectedParts);
end;


procedure TfrmPartList.btnSearchClick(Sender: TObject);
begin
  Self.RefreshGrid(Self.grParts, Self.FParts);
end;

procedure TfrmPartList.btnSortClick(Sender: TObject);
begin
  Self.FSorted := Self.btnSort.Down;
  Self.RefreshGrid(Self.grParts, FParts);
  Self.RefreshGrid(Self.grSelectedParts, FSelectedParts);
end;

procedure TfrmPartList.cbAllPartsClick(Sender: TObject);
begin
  Self.SetCaptionText;
  Self.RefreshGrid(Self.grParts, Self.FParts);
end;

procedure TfrmPartList.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then RefreshGrid(grParts, FParts)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then
      RefreshGrid(grParts, FParts);
end;

procedure TfrmPartList.ViewButtonsClick(Sender: TObject);
begin
  grParts.Colored := btnColored.Down;
  grSelectedParts.Colored := btnColored.Down;
  grParts.WordWrap := btnWordWrap.Down;
  grSelectedParts.WordWrap := btnWordWrap.Down;
  grParts.Repaint;
  grSelectedParts.Repaint;
end;

procedure TfrmPartList.ResizeGrid(Grid: TTntStringGrid);
var
  I, Width: Integer;
begin
  Width := Grid.ColWidths[0];
  for I := 2 to Grid.ColCount - 1 do Width := Width + Grid.ColWidths[I];
  Grid.ColWidths[1] := Grid.ClientWidth - Width - Grid.ColCount;
end;

procedure TfrmPartList.SetCaptionText;
var
  Text: string;
begin
  if Length(FFileName) = 0 then begin
    if cbAllParts.Checked then
      Text := Translator.GetInstance.TranslateMessage(
        38, 'Все детали в текущем файле')
    else Text := Translator.GetInstance.TranslateMessage(
        31, 'Детали в текущем файле, не входящие в заказ')
         + ' "' + FCurOrder.Title + '"';
  end else
    if cbAllParts.Checked then
      Text := Translator.GetInstance.TranslateMessage(
        39, 'Все детали в файле') + ' "' + FFileName + '"'
    else Text := Translator.GetInstance.TranslateMessage(
        40, 'Детали в файле') + ' "' + FFileName + '" '
        + Translator.GetInstance.TranslateMessage(
        41, 'не входящие в заказ') + ' "' + FCurOrder.Title + '"';
  lbCaption.Caption := Text;
end;

procedure TfrmPartList.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Item: TOrderItem;
begin
  if (ACol = 2) and (ARow < grSelectedParts.RowCount) and (ARow > 0) then begin
    Item := TOrderItem(grSelectedParts.Objects[1, ARow]);
    if Item <> nil then Item.OrderCount := StrToFloatDef(Value, 0);
  end;
end;

procedure TfrmPartList.grPartsDblClick(Sender: TObject);
var
  Item: TOrderItem;
begin
  if (grParts.Row > 0) and (grParts.Objects[1, grParts.Row] <> nil) then begin
    Item := TOrderItem.Create(TPart(grParts.Objects[1, grParts.Row]));
    Item.OrderCount := 0;
    FSelectedParts.Add(Item);
    Self.RefreshGrid(Self.grSelectedParts, FSelectedParts);
  end;
end;

procedure TfrmPartList.btnClearSearchClick(Sender: TObject);
begin
  if Length(edSearch.Text) > 0 then begin
    edSearch.Text := '';
    Self.RefreshGrid(Self.grParts, Self.FParts);
  end;
end;

procedure TfrmPartList.btnRemoveAllClick(Sender: TObject);
begin
  while FSelectedParts.Count > 0 do
    FSelectedParts.Delete(0);
  Self.RefreshGrid(Self.grSelectedParts, FSelectedParts);
end;

procedure TfrmPartList.btnRemoveClick(Sender: TObject);
begin
  if (grSelectedParts.Row > 0) then
    if grSelectedParts.Objects[1, grSelectedParts.Row] <> nil then begin
      FSelectedParts.Remove(grSelectedParts.Objects[1, grSelectedParts.Row]);
      Self.RefreshGrid(Self.grSelectedParts, FSelectedParts);
    end;
end;


procedure TfrmPartList.RefreshHeader(Sender: TObject);
begin
  grParts.Cells[0, 0] := '№';
  grSelectedParts.Cells[0, 0] := '№';
  grParts.Cells[1, 0] := Translator.GetInstance.TranslateWord('Наименование');
  grSelectedParts.Cells[1, 0] := Translator.GetInstance.TranslateWord('Наименование');
  grSelectedParts.Cells[2, 0] := Translator.GetInstance.TranslateWord('Кол-во');
  grParts.ColWidths[0] := 30;
  grSelectedParts.ColWidths[0] := 30;
end;

procedure TfrmPartList.RefreshGrid(Grid: TOctopusStringGrid; Parts: TObjectList);
var
  I, Row: integer;
  CanAdd: boolean;
begin
  Grid.Clear;
  Self.RefreshHeader(Self);
  Grid.SelectCell(MaxInt, MaxInt);
  Grid.Enabled := (Parts.Count > 0);
  Grid.RowCount := 2;
  if Parts.Count = 0 then Exit;
  Row := 0;
  for I := 0 to Parts.Count - 1 do begin
    CanAdd := (Grid = grSelectedParts) or (FCurOrder = nil)
      or (Self.cbAllParts.Checked)
      or (FCurOrder.IndByCode(TPart(Parts.Items[I]).Code) < 0);
    if (Grid = Self.grParts) and (Length(edSearch.Text) > 0) then
      CanAdd := (pos(WideUpperCase(edSearch.Text),
        WideUpperCase(TPart(Parts.Items[I]).GetTranslatedTitle(
          GlobalSettings.GetInstance.Language))) > 0);
    if CanAdd then begin
      Inc(Row);
      if (Parts.Items[I] is TPart) then begin
        Grid.Cells[1, Row] := TPart(Parts.Items[I]).GetTranslatedTitle(
          GlobalSettings.GetInstance.Language);
      end else begin
        Grid.Cells[1, Row] := TOrderItem(Parts.Items[I]).Part.GetTranslatedTitle(
          GlobalSettings.GetInstance.Language);
        Grid.Cells[2, Row] := FloatToStr(TOrderItem(Parts.Items[I]).OrderCount);
      end;
      Grid.Objects[1, Row] := Parts.Items[I];
    end;
  end;
  Grid.Enabled := (Row > 0);
  if Row > 0 then begin
    Grid.RowCount := Row + 1;
    if Self.FSorted then Grid.Sort(1);
    for I := 1 to Grid.RowCount - 1 do begin
      Grid.Cells[0, I] := IntTostr(I);
      if I mod 2 = 0 then Grid.SetRowColor(I, rgb(240, 240, 230));
    end;
  end;
  Self.ResizeGrid(Grid);
end;


function TfrmPartList.SelectFromPartsList(Parts: TPartList;
  SelectedParts: TObjectList; CurOrder: TOrder; FileName: string = ''): boolean;
begin
  Self.FParts := Parts;
  Self.FSelectedParts := SelectedParts;
  Self.FCurOrder := CurOrder;
  Self.FFileName := ExtractFileName(FileName);
  cbAllParts.Checked := (FCurOrder = nil);
  cbAllParts.Enabled := (FCurOrder <> nil);
  Self.SetCaptionText;
  Self.edSearch.Text := '';

  Self.RefreshGrid(Self.grParts, FParts);
  Self.RefreshGrid(Self.grSelectedParts, FSelectedParts);
  Result := (Self.ShowModal = mrOk);
  grParts.Clear;
  grSelectedParts.Clear;
end;


end.
