unit PartListUpdateForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, TntGrids, OctopusGridCls, StdCtrls,
  Buttons, ExtCtrls, ImgList, PartListCls, PartCls, CheckLst;

type
  TValueRec = record
    PropName: string;
    PropCode: integer;
    OldValue: widestring;
    NewValue: widestring;
  end;

  TValueRecList = array of TValueRec;

  TfrmPartListUpdate = class(TForm)
    ImageList1: TImageList;
    pnBottom: TPanel;
    btnCreate: TBitBtn;
    pnMain: TPanel;
    lbCaption: TLabel;
    grParts: TOctopusStringGrid;
    pnViewTools: TPanel;
    pnToolBar: TPanel;
    ToolBar1: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    ToolButton1: TToolButton;
    btnCheckAll: TToolButton;
    btnUncheckAll: TToolButton;
    btnInvertCheck: TToolButton;
    pnLeft: TPanel;
    cbValidatedFields: TCheckListBox;
    Label1: TLabel;
    Splitter1: TSplitter;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FSorted: boolean;
    FCurrentParts: TPartList;
    FNewParts: TPartList;
    procedure RefreshHeader(Sender: TObject);
    function ComparePart(Current, New: TPart; var DifList: TValueRecList): boolean;
    procedure UpdatecValidatedFields;
    function WriteChages: boolean;
  public
    { Public declarations }
    function UpdatePaerts(Caption: string; Current: TPartList; New: TPartList): boolean;
  published
    procedure RefreshGrid(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure btnInvertCheckClick(Sender: TObject);
  end;

var
  frmPartListUpdate: TfrmPartListUpdate;

implementation

{$R *.dfm}

uses
  TranslatorCls, OrderItemCls, FindInShipmentCls, GlobalSettingsCls;

procedure TfrmPartListUpdate.FormCreate(Sender: TObject);
begin
  FCurrentParts := nil;
  FNewParts := nil;
  FSorted := False;
  grParts.EditableCells := [];
  grParts.Colored := True;
  Self.btnColored.Down := True;
  grParts.WordWrap := False;
  Self.btnCreate.WordWrap := grParts.WordWrap;
  grParts.ColWidths[0] := 30;
  grParts.ColWidths[1] := 70;
  grParts.ColWidths[3] := 100;
  grParts.CheckListStyle := True;
end;

procedure TfrmPartListUpdate.FormResize(Sender: TObject);
var
  I, ColWidth: Integer;
begin
  // Подбор ширины столбца Наименование.
  grParts.ColWidths[2] := trunc(grParts.ClientWidth * 0.2);
  grParts.ColWidths[4] := trunc(grParts.ClientWidth * 0.25);
  ColWidth := 0;
  for I := 0 to grParts.ColCount - 1 do
    if I <> 5 then
      ColWidth := ColWidth + grParts.ColWidths[I] + 1;
  grParts.ColWidths[5] := grParts.ClientWidth - ColWidth - 2;
  if grParts.ColWidths[5] < 70 then grParts.ColWidths[5] := 70;
  grParts.Repaint;
  //
  btnCreate.Left := trunc((pnBottom.ClientWidth - btnCreate.Width) / 2);
end;

procedure TfrmPartListUpdate.ViewButtonsClick(Sender: TObject);
begin
  grParts.Colored := Self.btnColored.Down;
  grParts.WordWrap := btnWrap.Down;
  grParts.Repaint;
end;

procedure TfrmPartListUpdate.btnCheckAllClick(Sender: TObject);
begin
  grParts.SelectAll;
  grParts.Repaint;
end;

procedure TfrmPartListUpdate.btnUncheckAllClick(Sender: TObject);
begin
   grParts.UnselectAll;
   grParts.Repaint;
end;

procedure TfrmPartListUpdate.btnInvertCheckClick(Sender: TObject);
begin
   grParts.ChangeSelection;
   grParts.Repaint;
end;

// Вспомогательные операции сравнения.

procedure TfrmPartListUpdate.UpdatecValidatedFields;
var
  LocalTranslator: TTranslatorSingleton;
  I: Integer;
begin
  LocalTranslator := Translator.GetInstance;
  cbValidatedFields.Items.Clear;
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Наименование'), TObject(1));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Полн наимнование'), TObject(2));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Англ наименование'), TObject(3));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Наимее поставщика'), TObject(4));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Ед изм'), TObject(5));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Вес, кг'), TObject(6));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Объем,м3'), TObject(7));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('BOM'), TObject(8));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Код ТНВЭД'), TObject(9));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Цена постаыщика'), TObject(10));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateMessage(87, 'FOB цена'), TObject(11));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateMessage(88, 'CFR цена'), TObject(12));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('Вид тары'), TObject(13));
  cbValidatedFields.Items.AddObject(
    LocalTranslator.TranslateWord('В коробке'), TObject(14));
  for I := 0 to cbValidatedFields.Items.Count - 1 do
    cbValidatedFields.Checked[I] := True;
end;

function TfrmPartListUpdate.ComparePart(Current, New: TPart;
  var DifList: TValueRecList): boolean;
var
  LocalTranslator: TTranslatorSingleton;
begin
  LocalTranslator := Translator.GetInstance;
  SetLength(DifList, 0);
  if (cbValidatedFields.Checked[0]) and (Current.ShortTitle <> New.ShortTitle) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Наименование');
    DifList[high(DifList)].PropCode := 1;
    DifList[high(DifList)].OldValue := Current.ShortTitle;
    DifList[high(DifList)].NewValue :=  New.ShortTitle;
  end;
  if (cbValidatedFields.Checked[1]) and (Current.RusName <> New.RusName) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Полн наимнование');
    DifList[high(DifList)].PropCode := 2;
    DifList[high(DifList)].OldValue := Current.RusName;
    DifList[high(DifList)].NewValue :=  New.RusName;
  end;
  if (cbValidatedFields.Checked[2]) and (Current.EngName <> New.EngName) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Англ наименование');
    DifList[high(DifList)].PropCode := 3;
    DifList[high(DifList)].OldValue := Current.EngName;
    DifList[high(DifList)].NewValue :=  New.EngName;
  end;
  if (cbValidatedFields.Checked[3]) and (Current.ChinName <> New.ChinName) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Наимее поставщика');
    DifList[high(DifList)].PropCode := 4;
    DifList[high(DifList)].OldValue := Current.ChinName;
    DifList[high(DifList)].NewValue :=  New.ChinName;
  end;
  if (cbValidatedFields.Checked[4]) and (Current.PartUnit <> New.PartUnit) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Ед изм');
    DifList[high(DifList)].PropCode := 5;
    DifList[high(DifList)].OldValue := Current.PartUnit;
    DifList[high(DifList)].NewValue :=  New.PartUnit;
  end;
  if (cbValidatedFields.Checked[5]) and (Current.Weight <> New.Weight) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Вес, кг');
    DifList[high(DifList)].PropCode := 6;
    DifList[high(DifList)].OldValue := FloatToStr(Current.Weight);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.Weight);
  end;
  if (cbValidatedFields.Checked[6]) and (Current.Volume <> New.Volume) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Объем,м3');
    DifList[high(DifList)].PropCode := 7;
    DifList[high(DifList)].OldValue := FloatToStr(Current.Volume);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.Volume);
  end;
  if (cbValidatedFields.Checked[7]) and (Current.BOM <> New.BOM) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('BOM');
    DifList[high(DifList)].PropCode := 8;
    DifList[high(DifList)].OldValue := Current.BOM;
    DifList[high(DifList)].NewValue :=  New.BOM;
  end;
  if (cbValidatedFields.Checked[8]) and (Current.CustomCode <> New.CustomCode) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Код ТНВЭД');
    DifList[high(DifList)].PropCode := 9;
    DifList[high(DifList)].OldValue := Current.CustomCode;
    DifList[high(DifList)].NewValue :=  New.CustomCode;
  end;
  if (cbValidatedFields.Checked[9]) and (Current.SupplierPrice <> New.SupplierPrice) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Цена постаыщика');
    DifList[high(DifList)].PropCode := 10;
    DifList[high(DifList)].OldValue := FloatToStr(Current.SupplierPrice);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.SupplierPrice);
  end;
  if (cbValidatedFields.Checked[10]) and (Current.FOBPrice <> New.FOBPrice) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateMessage(87, 'FOB цена');
    DifList[high(DifList)].PropCode := 11;
    DifList[high(DifList)].OldValue := FloatToStr(Current.FOBPrice);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.FOBPrice);
  end;
  if (cbValidatedFields.Checked[11]) and (Current.CFRPrice <> New.CFRPrice) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateMessage(88, 'CFR цена');
    DifList[high(DifList)].PropCode := 12;
    DifList[high(DifList)].OldValue := FloatToStr(Current.CFRPrice);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.CFRPrice);
  end;
  if (cbValidatedFields.Checked[12]) and (Current.BoxType <> New.BoxType) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('Вид тары');
    DifList[high(DifList)].PropCode := 13;
    DifList[high(DifList)].OldValue := Current.BoxType;
    DifList[high(DifList)].NewValue := New.BoxType;
  end;
  if (cbValidatedFields.Checked[13]) and (Current.CountInBox <> New.CountInBox) then begin
    SetLength(DifList, high(DifList) + 2);
    DifList[high(DifList)].PropName := LocalTranslator.TranslateWord('В коробке');
    DifList[high(DifList)].PropCode := 14;
    DifList[high(DifList)].OldValue := FloatToStr(Current.CFRPrice);
    DifList[high(DifList)].NewValue :=  FloatToStr(New.CFRPrice);
  end;
  Result := (high(DifList) >= 0);
end;

// Запись изменений.

function TfrmPartListUpdate.WriteChages: boolean;
var
  ARow: integer;
  Current, New: TPart;
  PropCode: integer;
begin
  Result := False;
  for ARow := 0 to grParts.RowCount - 1 do
    if grParts.CheckRowSelection(ARow) then begin
      Current := TPart(grParts.Objects[1, ARow]);
      New := TPart(grParts.Objects[2, ARow]);
      PropCode := Integer(grParts.Objects[3, ARow]);
      if (Current = nil) and (New = nil) and (PropCode = 0) then Continue;
      Result := True;
      case PropCode of
        1: Current.ShortTitle := New.ShortTitle;
        2: Current.RusName := New.RusName;
        3: Current.EngName := New.EngName;
        4: Current.ChinName := New.ChinName;
        5: Current.PartUnit := New.PartUnit;
        6: Current.Weight := New.Weight;
        7: Current.Volume := New.Volume;
        8: Current.BOM := New.BOM;
        9: Current.CustomCode := New.CustomCode;
        10: Current.SupplierPrice := New.SupplierPrice;
        11: Current.FOBPrice := New.FOBPrice;
        12: Current.CFRPrice := New.CFRPrice;
        13: Current.BoxType := New.BoxType;
        14: Current.CountInBox := New.CountInBox;
      end;
    end;

end;

// Обновление таблицы.

procedure TfrmPartListUpdate.RefreshHeader(Sender: TObject);
begin
  grParts.Cells[0,0] := '№';
  grParts.Cells[1,0] :=
    Translator.GetInstance.TranslateWord('Код 1С');
  grParts.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Наименование');
  grParts.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Свойство');
  grParts.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Старое значкение');
  grParts.Cells[5,0] :=
    Translator.GetInstance.TranslateWord('Новое значение');
end;

procedure TfrmPartListUpdate.RefreshGrid(Sender: TObject);
var
  I,j, ARow, PartNum: integer;
  Current, New: TPart;
  DifList: TValueRecList;
begin
  grParts.Clear;
  grParts.RowCount := 2;
  Self.RefreshHeader(Self);
  grParts.Enabled := (FCurrentParts <> nil) and (FCurrentParts.Count > 0)
    and (FNewParts <> nil) and (FNewParts.Count > 0);
  if not (grParts.Enabled) then Exit;
  ARow := 0;
  PartNum := 0;
  for I := 0 to FCurrentParts.Count - 1 do begin
    Current := FCurrentParts.Items[I];
    New := FNewParts.Items[Current.Code];
    if (New = nil) or (not ComparePart(Current, New, DifList)) then Continue;
    // Вывод данных о расхождениях.
    Inc(ARow);
    for J := 0 to high(DifList) do begin
      grParts.Cells[0, ARow + J] := IntToStr(ARow);
      if J = 0 then begin
        Inc(PartNum);
        grParts.Cells[1, ARow + J] := Current.Code;
        grParts.Cells[2, ARow + J] := Current.GetTranslatedTitle(
          GlobalSettings.GetInstance.Language);
      end;
      grParts.Cells[3, ARow + J] := DifList[J].PropName;
      grParts.Cells[4, ARow + J] := DifList[J].OldValue;
      grParts.Cells[5, ARow + J] := DifList[J].NewValue;
      // Сохраняем объекты.
      grParts.Objects[1, ARow + J] := Current;
      grParts.Objects[2, ARow + J] := New;
      grParts.Objects[3, ARow + J] := TObject(DifList[J].PropCode);
      // Устанавливаем цвет строки.
      if (PartNum mod 2) = 0 then grParts.SetRowColor(ARow + j, rgb(240, 240, 230));
    end;
    ARow := ARow + high(DifList);
  end;
  //if Self.FSorted then grParts.Sort(2);
  if ARow > 0 then grParts.RowCount := ARow + 1;
  grParts.Enabled := (ARow > 0);
  Self.FormResize(Self);
end;

// Основная процедура.

function TfrmPartListUpdate.UpdatePaerts(Caption: string; Current: TPartList;
  New: TPartList): boolean;
begin
  Result := False;
  Self.lbCaption.Caption := Translator.GetInstance.TranslateMessage(
    101, 'Обновление из файла') + ': "' + Caption + '"';
  FCurrentParts := Current;
  FNewParts := New;
  Self.UpdatecValidatedFields;
  Self.RefreshGrid(Self);
  Self.Width := trunc(Screen.Width * 0.8);
  //
  if ShowModal = mrOk then Result := Self.WriteChages;
  FCurrentParts := nil;
  FNewParts := nil;
end;


end.
