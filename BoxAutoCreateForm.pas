unit BoxAutoCreateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Contnrs, Grids, TntGrids, OctopusGridCls,
  ContainerCls, DocumentCls, BoxCls, OrderCls, BoxItemCls, ImgList, TntStdCtrls,
  ComCtrls, ToolWin;

type
  TfrmBoxAutoCreate = class(TForm)
    pnBottom: TPanel;
    pnMain: TPanel;
    btnCreate: TBitBtn;
    grBoxes: TOctopusStringGrid;
    lbCaption: TLabel;
    pnWarning: TPanel;
    btnRetryWarning: TSpeedButton;
    Label2: TLabel;
    pnViewTools: TPanel;
    pnToolBar: TPanel;
    ToolBar1: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    btnSort: TToolButton;
    ToolButton1: TToolButton;
    btnCheckAll: TToolButton;
    btnUncheckAll: TToolButton;
    btnInvertCheck: TToolButton;
    ImageList1: TImageList;
    procedure grBoxesKeyPress(Sender: TObject; var Key: Char);
    procedure pnViewToolsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ChageItemCount(NewValue: real; ARow: integer; Box: TBox; Item: TBoxItem);
    procedure ChangeBoxCount(NewValue: real; ARow: integer; Box: TBox);
    procedure ChangeGrossWeight(NewValue: real; ARow: integer; Box: TBox);
    procedure ChangePackWeight(NewValue: real; ARow: integer; Box: TBox);
    procedure SetRowMark(Box: TBox; ARow: integer);
  private
    { Private declarations }
    FDocument: TDocument;
    FBoxes: TContainer;
    FSorted: boolean;
    procedure RefreshHeader(Sender: TObject);
    procedure RefreshGrid(Sender: TObject);
    function GetRowMark(Box: TBox): TEditableCellSet;
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
  public
    { Public declarations }
    property Document: TDocument write FDocument;
    function CreateBoxes(Order: TOrder; ItemList: TObjectList; Container: TContainer): boolean;
  published
    procedure CheckContainer(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure btnInvertCheckClick(Sender: TObject);
  end;

var
  frmBoxAutoCreate: TfrmBoxAutoCreate;

implementation

{$R *.dfm}

uses
  TranslatorCls, OrderItemCls, FindInShipmentCls, GlobalSettingsCls;

procedure TfrmBoxAutoCreate.FormCreate(Sender: TObject);
var
  I: integer;
begin
  FDocument := nil;
  FBoxes := nil;
  FSorted := False;
  grBoxes.EditableCells := [3, 4, 6, 7];
  grBoxes.Colored := True;
  Self.btnColored.Down := True;
  grBoxes.WordWrap := False;
  Self.btnCreate.WordWrap := grBoxes.WordWrap;
  grBoxes.ColWidths[0] := 30;
  grBoxes.ColAlign[2] := DT_CENTER;
  grBoxes.ColWidths[2] := 30;
  grBoxes.OnEndEdit := Self.OnEndEditGrid;
  grBoxes.CheckListStyle := True;
  for I := 3 to grBoxes.ColCount - 1 do grBoxes.ColAlign[I] := DT_RIGHT;
  pnWarning.Visible := False;
end;

procedure TfrmBoxAutoCreate.FormResize(Sender: TObject);
var
  I, ColWidth: Integer;
begin
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grBoxes.ColCount - 1 do
    if I <> 1 then
      ColWidth := ColWidth + grBoxes.ColWidths[I] + 1;
  grBoxes.ColWidths[1] := grBoxes.ClientWidth - ColWidth - 2;
  if grBoxes.ColWidths[1] < 70 then grBoxes.ColWidths[1] := 70;
  grBoxes.Repaint;
  //
  btnCreate.Left := trunc((pnBottom.ClientWidth - btnCreate.Width) / 2);
end;

procedure TfrmBoxAutoCreate.ViewButtonsClick(Sender: TObject);
begin
  grBoxes.Colored := Self.btnColored.Down;
  grBoxes.WordWrap := btnWrap.Down;
  grBoxes.Repaint;
end;

procedure TfrmBoxAutoCreate.btnSortClick(Sender: TObject);
begin
  Self.FSorted := Self.btnSort.Down;
  Self.RefreshGrid(Self);
end;

procedure TfrmBoxAutoCreate.btnCheckAllClick(Sender: TObject);
begin
  grBoxes.SelectAll;
  grBoxes.Repaint;
end;

procedure TfrmBoxAutoCreate.btnUncheckAllClick(Sender: TObject);
begin
   grBoxes.UnselectAll;
   grBoxes.Repaint;
end;

procedure TfrmBoxAutoCreate.btnInvertCheckClick(Sender: TObject);
begin
   grBoxes.ChangeSelection;
   grBoxes.Repaint;
end;

// Изменения в таблице.

procedure TfrmBoxAutoCreate.ChageItemCount(NewValue: real; ARow: integer;
  Box: TBox; Item: TBoxItem);
var
  PackWeight: real;
begin
  PackWeight := Box.PackageWeight;
  Item.OrderCount := NewValue;
  if (GlobalSettings.GetInstance.FixBoxPackWeightForChange) then begin
    Box.SetTotalGrossByOneBoxPack(PackWeight);
    grBoxes.Cells[6, ARow] := FloatToStr(Box.GroupGrossWeight);
  end else
    grBoxes.Cells[7, ARow] := FloatToStr(Box.PackageWeight);
  grBoxes.Cells[5, ARow] := FloatToStr(Box.GroupNetWeight);
  grBoxes.Cells[8, ARow] := FloatToStr(Box.Volume);
end;

procedure TfrmBoxAutoCreate.ChangeBoxCount(NewValue: real; ARow: integer;
  Box: TBox);
var
  PackWeight: real;
begin
  PackWeight := Box.PackageWeight;
  Box.BoxCount := trunc(NewValue);
  if (GlobalSettings.GetInstance.FixBoxPackWeightForChange) then begin
    Box.SetTotalGrossByOneBoxPack(PackWeight);
    grBoxes.Cells[6, ARow] := FloatToStr(Box.GroupGrossWeight);
  end else
    grBoxes.Cells[7, ARow] := FloatToStr(Box.PackageWeight);
  grBoxes.Cells[5, ARow] := FloatToStr(Box.GroupNetWeight);
  grBoxes.Cells[8, ARow] := FloatToStr(Box.Volume);
end;

procedure TfrmBoxAutoCreate.ChangeGrossWeight(NewValue: real; ARow: integer;
  Box: TBox);
begin
  Box.GroupGrossWeight := NewValue;
  grBoxes.Cells[7, ARow] := FloatToStr(Box.PackageWeight);
  grBoxes.Cells[8, ARow] := FloatToStr(Box.Volume);
end;

procedure TfrmBoxAutoCreate.ChangePackWeight(NewValue: real; ARow: integer;
  Box: TBox);
begin
  Box.SetTotalGrossByOneBoxPack(NewValue);
  grBoxes.Cells[6, ARow] := FloatToStr(Box.GroupGrossWeight);
  grBoxes.Cells[8, ARow] := FloatToStr(Box.Volume);
end;

procedure TfrmBoxAutoCreate.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Item: TBoxItem;
  Box: TBox;
  NewValue, OldValue: real;
  Text: string;
begin
  Box := TBox(grBoxes.Objects[1, ARow]);
  Item := TBoxItem(grBoxes.Objects[2, ARow]);
  if (Item <> nil) and (Box <> nil) then begin
    NewValue := StrToFloatDef(Value, 0);
    OldValue := 0;
    case ACol of
      3: OldValue := Item.OrderCount;
      4: OldValue := Box.BoxCount;
      6: OldValue := Box.GroupGrossWeight;
      7: OldValue := Box.PackageWeight;
    end;
    if NewValue = OldValue then Exit;
    if NewValue <= 0 then begin
      grBoxes.Cells[ACol, ARow] := FloatToStr(OldValue);
      Text := Translator.GetInstance.TranslateMessage(
        2, 'Значение не может быть нулем и меньше нуля !',);
      MessageDlg(Text, mtWarning, [mbOk], 0);
      Exit;
    end;
    case ACol of
      3: Self.ChageItemCount(NewValue, ARow, Box, Item);
      4: Self.ChangeBoxCount(NewValue, ARow, Box);
      6: Self.ChangeGrossWeight(NewValue, ARow, Box);
      7: Self.ChangePackWeight(NewValue, ARow, Box);
    end;
    SetRowMark(Box, ARow);
    grBoxes.Repaint;
  end;
end;


procedure TfrmBoxAutoCreate.pnViewToolsClick(Sender: TObject);
begin

end;

// Обновление.

procedure TfrmBoxAutoCreate.RefreshHeader(Sender: TObject);
begin
  grBoxes.Cells[0,0] := '№';
  grBoxes.Cells[1,0] :=
    Translator.GetInstance.TranslateWord('Наименование');
  grBoxes.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Ед.');
  grBoxes.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Кол-во');
  grBoxes.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Кол.мест');
  grBoxes.Cells[5,0] :=
    Translator.GetInstance.TranslateWord('Нетто,кг');
  grBoxes.Cells[6,0] :=
    Translator.GetInstance.TranslateWord('Брутто,кг');
  grBoxes.Cells[7,0] :=
    Translator.GetInstance.TranslateWord('Уп-ка,кг');
  grBoxes.Cells[8,0] :=
    Translator.GetInstance.TranslateWord('Объем,м3');
end;

procedure TfrmBoxAutoCreate.CheckContainer(Sender: TObject);
var
  Ind: integer;
begin
  pnWarning.Visible := False;
  if ((FBoxes = nil) or (FBoxes.Count = 0)) then Exit;
  for Ind := 1 to FBoxes.Count - 1 do
    if (GetRowMark(FBoxes.Items[Ind]) <> []) then begin
      pnWarning.Visible := True;
      Exit;
    end;
end;

function TfrmBoxAutoCreate.GetRowMark(Box: TBox): TEditableCellSet;
begin
  Result := [];
  if Box.GroupGrossWeight < Box.GroupNetWeight then
    Result := Result + [6];
  if GlobalSettings.GetInstance.MarkedZerousPack then begin
    if Box.PackageWeight <= 0 then Result := Result + [7];
  end else begin
    if Box.PackageWeight < 0 then Result := Result + [7];
  end;
end;

procedure TfrmBoxAutoCreate.grBoxesKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

procedure TfrmBoxAutoCreate.SetRowMark(Box: TBox; ARow: integer);
begin
  grBoxes.SetCellMark(ARow, Self.GetRowMark(Box));
end;

procedure TfrmBoxAutoCreate.RefreshGrid(Sender: TObject);
var
  Item: TBoxItem;
  Box: TBox;
  I, ARow: integer;
  Marks: TEditableCellSet;
begin
  grBoxes.Clear;
  Self.RefreshHeader(Self);
  pnWarning.Visible := False;
  grBoxes.Enabled := (FBoxes <> nil) and (FBoxes.Count > 0);
  if (FBoxes = nil) or (FBoxes.Count = 0) then begin
    grBoxes.RowCount := 2;
    Exit;
  end;
  grBoxes.RowCount := FBoxes.Count + 1;
  for I := 0 to FBoxes.Count - 1 do begin
    ARow := I + 1;
    Box := FBoxes.Items[I];
    Item := Box.Items[0];
    grBoxes.Cells[0, ARow] := IntToStr(ARow);
    grBoxes.Cells[1, ARow] := Item.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language);
    grBoxes.Cells[2, ARow] := Item.Part.PartUnit;
    grBoxes.Cells[3, ARow] := FloatToStr(Item.OrderCount);
    grBoxes.Cells[4, ARow] := IntToStr(Box.BoxCount);
    grBoxes.Cells[5, ARow] := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask,
      Box.GroupNetWeight);
    grBoxes.Cells[6, ARow] := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask,
      Box.GroupGrossWeight);
    grBoxes.Cells[7, ARow] := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask,
      Box.PackageWeight);
    grBoxes.Cells[8, ARow] := FormatFloat(
      GlobalSettings.GetInstance.VolumeAccuracyMask,
      Box.Volume);
    // Установка цыета строки
    if ARow mod 2 = 0 then grBoxes.SetRowColor(ARow, rgb(240, 240, 230));
    // Запись обьектов
    grBoxes.Objects[1, ARow] := Box;
    grBoxes.Objects[2, ARow] := Item;
    // Установка маркировки ошибок в параметрах коробки.
    Marks := Self.GetRowMark(Box);
    if Marks <> [] then grBoxes.SetCellMark(ARow, Marks);
  end;
  if Self.FSorted then grBoxes.Sort(1);
  if not pnWarning.Visible then CheckContainer(Self);
  Self.FormResize(Self);
end;

// Основная процедура.

function TfrmBoxAutoCreate.CreateBoxes(Order: TOrder; ItemList: TObjectList; Container: TContainer): boolean;
var
  I: integer;
  Box: TBox;
  BoxItem: TBoxItem;
  Finder: TFindInShipment;
  NewBoxes: TObjectList;
begin
  Result := False;
  Self.lbCaption.Caption := Translator.GetInstance.TranslateMessage(
    100, 'Детали из заказа') + ' : "' + Order.Title + '"';
  FBoxes := TContainer.Create;
  Finder := TFindInShipment.Create(FDocument);
  for I := 0 to ItemList.Count - 1 do begin
    BoxItem := TBoxItem.Create(Order, TOrderItem(ItemList.Items[I]).Part);
    BoxItem.OrderCount := TOrderItem(ItemList.Items[I]).OrderCount
      - Finder.CountForOrder(Order, TOrderItem(ItemList.Items[I]).Part);
    if BoxItem.OrderCount = 0 then BoxItem.OrderCount := 1;
    Box := TBox.Create;
    // Cчитаем кол-во коробок
    if (BoxItem.Part.CountInBox > 0) and (BoxItem.Part.CountInBox < BoxItem.OrderCount) then begin
      Box.BoxCount := trunc(BoxItem.OrderCount / BoxItem.Part.CountInBox);
      BoxItem.OrderCount := Box.BoxCount * BoxItem.Part.CountInBox;
    end;
    Box.Add(BoxItem);
    Box.GroupGrossWeight := Box.GroupNetWeight;
    Box.BoxCode := IntToStr(I + 1);
    FBoxes.Add(Box);
  end;
  Finder.Free;
  Self.RefreshGrid(Self);
  grBoxes.SelectAll;
  // Запись коробок в контейнер.
  if Self.ShowModal <> mrOk then Exit;
  NewBoxes := TObjectList.Create(False);
  grBoxes.GetSelectedObjects(1, NewBoxes);
  for I := 0 to NewBoxes.Count - 1 do begin
    Box := TBox.Create;
    Box.Copy(TBox(NewBoxes.Items[I]));
    Box.BoxCode := FDocument.GetNewBoxNumber;
    Container.Add(Box);
  end;
  NewBoxes.Free;
  FBoxes.Free;
  Result := True;
end;

end.
