unit BoxForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, TntGrids, OctopusGridCls, ImgList,
  BoxCls, Buttons, DocumentCls, StdCtrls, BoxItemCls, OrderItemCls, OrderCls,
  DragObjectCls, Menus;

type
  TOnModifiedBoxForm = procedure (Sender: TObject) of object;
  TOnSelectItem = procedure (Sender: TObject) of object;
  TOnDragDrop = procedure (Sender: TObject; DragObject: TOrderDragObject) of object;

  TfrmBox = class(TForm)
    pnTop: TPanel;
    grBox: TOctopusStringGrid;
    pnBoxProperty: TPanel;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    rbtnGroupWeight: TRadioButton;
    rbtnBoxWeight: TRadioButton;
    rbtnPackWeight: TRadioButton;
    edGroupWeight: TEdit;
    edBoxWeight: TEdit;
    edPackWeight: TEdit;
    edBoxNumber: TEdit;
    edBoxCount: TEdit;
    UpDown1: TUpDown;
    Label4: TLabel;
    edNetWeight: TEdit;
    Label5: TLabel;
    imPackWeightWarning: TImage;
    btnNewBoxCode: TSpeedButton;
    lbPackWeightWarning: TLabel;
    imOneGrossWarning: TImage;
    lbOneGrossWarning: TLabel;
    imGroupGrossWarning: TImage;
    lbGroupGrossWarning: TLabel;
    pnEditTools: TPanel;
    tbEditTools: TToolBar;
    btnNewBox: TToolButton;
    btnLoadPart: TToolButton;
    ToolButton5: TToolButton;
    btnNewBoxAndLoad: TToolButton;
    ToolButton7: TToolButton;
    btnSaveBox: TToolButton;
    btnUnloadPart: TToolButton;
    btnDeleteBox: TToolButton;
    ToolButton6: TToolButton;
    pnViewTools: TPanel;
    tbView: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    pmAddItem: TPopupMenu;
    miOnlySet: TMenuItem;
    miSelAndMark: TMenuItem;
    btnAddPartAuto: TToolButton;
    procedure grBoxSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure grBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure grBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure edBoxNumberChange(Sender: TObject);
    procedure btnNewBoxCodeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FEditMode: boolean;
    FBox: TBox;
    FParentBox: TBox;
    FDocument: TDocument;
    FSorted: boolean;
    FModified: boolean;
    FBlockEditorChange: boolean;
    FOnModifiedBoxForm: TOnModifiedBoxForm;
    FOnSelectItem: TOnSelectItem;
    FOnDragDrop: TOnDragDrop;
    procedure SetEditMode(EditMode: boolean);
    procedure RefreshGridHeader(Language: integer);
    procedure SetModified(Value: boolean);
    procedure CheckWeight;
    procedure SetBox(Box: TBox);
    function GetSelectItem: TBoxItem;
  public
    property Document: TDocument read FDocument write FDocument;
    property Box: TBox read FBox write SetBox;
    property ParentBox: TBox read FParentBox write FParentBox;
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnModifiedBoxForm: TOnModifiedBoxForm read FOnModifiedBoxForm write FOnModifiedBoxForm;
    property OnSelectItem: TOnSelectItem read FOnSelectItem write FOnSelectItem;
    property Modified: boolean read FModified write SetModified;
    property SelectItem: TBoxItem read GetSelectItem;
    procedure ExtractOrder(Order: TOrder);
    procedure ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem);
    property OnDragDrop: TOnDragDrop read FOnDragDrop write FOnDragDrop;
  published
    procedure RefreshData(Sender: TObject);
    procedure RefreshBoxDataPanel(Sender: TObject);
    procedure RefreshGrid(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
    procedure SelectWeightControl(Sender: TObject);
    procedure edWeightChange(Sender: TObject);
  end;

var
  frmBox: TfrmBox;

implementation

{$R *.dfm}
uses
  Math, TranslatorCls, GlobalSettingsCls;

// Сеттеры.

procedure TfrmBox.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  pnBoxProperty.Enabled := FEditMode;
  if FEditMode then grBox.EditableCells := [4]
    else grBox.EditableCells := [];
  pnEditTools.Visible := FEditMode;
  pnEditTools.Top := 0;
  RefreshGrid(Self);
end;

procedure TfrmBox.SetBox(Box: TBox);
begin
  FParentBox := Box;
  if Box = nil then begin
    Self.FParentBox := nil;
    Self.FBox.ClearBox;
    FBox.BoxCode := FDocument.GetNewBoxNumber;
    Self.Caption := Translator.GetInstance.TranslateMessage(
      91, 'Новая группа коробок');
  end else begin
    FBox.Copy(Box);
    Self.Caption := Translator.GetInstance.TranslateMessage(
      92, 'Изменение группы коробок') + ' "' + FBox.BoxCode + '"';
  end;
  Self.RefreshData(Self);
  Self.SetModified(False);
end;

procedure TfrmBox.SetModified(Value: boolean);
begin
  Self.FModified := (FBox.Count > 0) and (Value);
  if Assigned(FOnModifiedBoxForm) then FOnModifiedBoxForm(Self);
end;

function TfrmBox.GetSelectItem;
begin
  Result := nil;
  if FBox = nil then Exit;
  if grBox.Selection.Top > 0 then
    Result := TBoxItem(grBox.Objects[1, grBox.Selection.Top]);
end;

// События формы.

procedure TfrmBox.FormCreate(Sender: TObject);
begin
  FDocument := nil;
  FParentBox := nil;
  FBox := TBox.Create;
  SetEditMode(False);
  Self.btnWrap.Down := Self.grBox.WordWrap;
  Self.btnColored.Down := Self.grBox.Colored;
  Self.FSorted := True;
  SelectWeightControl(Self.rbtnPackWeight);
  grBox.WordWrap := True;
  Self.btnWrap.Down := grBox.WordWrap;
  grBox.ColWidths[0] := 30;
  grBox.ColWidths[1] := 70;
  grBox.ColAlign[3] := DT_CENTER;
  grBox.ColWidths[3] := 30;
  grBox.ColAlign[4] := DT_RIGHT;
  Self.SetModified(False);
  FBlockEditorChange := False;
end;

procedure TfrmBox.FormDeactivate(Sender: TObject);
begin
  if (goEditing in grBox.Options) and (grBox.Row > 0) then grBox.Col := 0;
end;

procedure TfrmBox.FormDestroy(Sender: TObject);
begin
  FBox.Free;
end;

procedure TfrmBox.FormResize(Sender: TObject);
var
  I, ColWidth: integer;
begin
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grBox.ColCount - 1 do
    if I <> 2 then
      ColWidth := ColWidth + grBox.ColWidths[I] + 1;
  grBox.ColWidths[2] := grBox.ClientWidth - ColWidth - 2;
  if grBox.ColWidths[2] < 70 then grBox.ColWidths[2] := 70;
  grBox.Repaint;
end;

// События таблицы и настройки вида таблицы.

procedure TfrmBox.ViewButtonsClick(Sender: TObject);
begin
  grBox.Colored := Self.btnColored.Down;
  grBox.WordWrap := btnWrap.Down;
  grBox.Repaint;
end;

procedure TfrmBox.grBoxSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  grBox.Selection := TGridRect(Rect(ACol, ARow, ACol, ARow));
  if Assigned(Self.FOnSelectItem) then FOnSelectItem(Self);
end;

// События перетаскивания в таблицу.

procedure TfrmBox.grBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Source is TOrderDragObject) then
   if Assigned(FOnDragDrop) then FOnDragDrop(Self, TOrderDragObject(Source));
end;

procedure TfrmBox.grBoxDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (FEditMode) and (Source is TOrderDragObject);
end;

// Соббытия панели свойств коробки.

procedure TfrmBox.btnNewBoxCodeClick(Sender: TObject);
begin
  if FDocument <> nil then
    Self.edBoxNumber.Text := FDocument.GetNewBoxNumber;
end;

procedure TfrmBox.edBoxNumberChange(Sender: TObject);
begin
  if FBox = nil then Exit;
  Self.FBox.BoxCode := edBoxNumber.Text;
  Self.SetModified(True);
end;

procedure TfrmBox.edWeightChange(Sender: TObject);
var
  Count: integer;
begin
  if Self.FBlockEditorChange then Exit;
  Count := StrToIntDef(edBoxCount.Text, 0);

  if Count <= 0 then begin
    Count := FBox.BoxCount;
    edBoxCount.Text := IntToStr(Count);
    Exit;
  end else FBox.BoxCount := Count;
  if rbtnGroupWeight.Checked  then begin
    FBox.GroupGrossWeight := StrToFloatDef(edGroupWeight.Text, 0);
    edBoxWeight.Text := FloatToStr(FBox.OneBoxGrossWeight);
    edPackWeight.Text := FloatToStr(FBox.PackageWeight);
    Self.SetModified(True);
  end;
  if (rbtnBoxWeight.Checked) or (TControl(Sender).Name = 'edBoxCount') then begin
    FBox.SetTotalGrossByOneBoxGross(StrToFloatDef(edBoxWeight.Text, 0));
    edGroupWeight.Text := FloatToStr(FBox.GroupGrossWeight);
    edPackWeight.Text := FloatToStr(FBox.PackageWeight);
    Self.SetModified(True);
  end;
  if (rbtnPackWeight.Checked) or (TControl(Sender).Name = 'edBoxCount') then begin
    FBox.SetTotalGrossByOneBoxPack(StrToFloatDef(edPackWeight.Text, 0));
    edGroupWeight.Text := FloatToStr(FBox.GroupGrossWeight);
    edBoxWeight.Text := FloatToStr(FBox.OneBoxGrossWeight);
    Self.SetModified(True);
  end;
  edNetWeight.Text := FloatToStr(FBox.OneBoxNetWeight) + ' / ' +
    FloatToStr(FBox.GroupNetWeight);
  Self.CheckWeight;


end;

procedure TfrmBox.SelectWeightControl(Sender: TObject);
var
  ControlName: string;
begin
  ControlName := TControl(Sender).Name;
  if (ControlName = 'rbtnGroupWeight') or (ControlName = 'edGroupWeight') then
    Self.rbtnGroupWeight.Checked := True;
  if (ControlName = 'rbtnBoxWeight') or (ControlName = 'edBoxWeight') then
    Self.rbtnBoxWeight.Checked := True;
  if (ControlName = 'rbtnPackWeight') or (ControlName = 'edPackWeight') then
    Self.rbtnPackWeight.Checked := True;
  //Self.edGroupWeight.Enabled := Self.rbtnGroupWeight.Checked;
  //Self.edBoxWeight.Enabled := Self.rbtnBoxWeight.Checked;
  //Self.edPackWeight.Enabled := Self.rbtnPackWeight.Checked;
end;

procedure TfrmBox.CheckWeight;
begin
  // Показ предупреждений об ошибках в весе
  if GlobalSettings.GetInstance.MarkedZerousPack then
    imPackWeightWarning.Visible := (StrToFloatdef(edPackWeight.Text, 0) <= 0)
  else
    imPackWeightWarning.Visible := (StrToFloatdef(edPackWeight.Text, 0) < 0);
  Self.lbPackWeightWarning.Visible := Self.imPackWeightWarning.Visible;
  Self.imGroupGrossWarning.Visible := (FBox.GroupGrossWeight < FBox.GroupNetWeight);
  Self.lbGroupGrossWarning.Visible := Self.imGroupGrossWarning.Visible;
  Self.imOneGrossWarning.Visible := Self.imGroupGrossWarning.Visible;
  Self.lbOneGrossWarning.Visible := Self.imGroupGrossWarning.Visible;
end;

// Процедуры "внешнего" удаления из коробки.

procedure TfrmBox.ExtractOrder(Order: TOrder);
begin
  Self.FBox.ExtractOrder(Order);
  if FBox.Count = 0 then Self.SetBox(nil);
end;

procedure TfrmBox.ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem);
begin
  Self.FBox.ExtractOrderItem(Order, OrderItem);
  if FBox.Count = 0 then Self.SetBox(nil);
end;

// Процедуры обновления.

procedure TfrmBox.RefreshData(Sender: TObject);
begin
  //if not  Self.Visible then Exit;
  RefreshBoxDataPanel(Self);
  RefreshGrid(Self);
end;

procedure TfrmBox.RefreshBoxDataPanel(Sender: TObject);
begin
  Self.FBlockEditorChange := True;
  edBoxNumber.Text := FBox.BoxCode;
  self.UpDown1.Position := FBox.BoxCount;
  edBoxCount.Text := IntToStr(FBox.BoxCount);
  edNetWeight.Text := FloatToStr(FBox.OneBoxNetWeight) + ' / ' +
    FloatToStr(FBox.GroupNetWeight);
  edGroupWeight.Text := FloatToStr(FBox.GroupGrossWeight);
  edPackWeight.Text := FloatToStr(FBox.PackageWeight);
  edBoxWeight.Text := FloatToStr(FBox.OneBoxGrossWeight);
  Self.CheckWeight;
  Self.FBlockEditorChange := False;
end;

procedure TfrmBox.RefreshGridHeader(Language: integer);
begin
  grBox.Cells[0,0] := '№';
  grBox.Cells[1,0] :=
    Translator.GetInstance.TranslateWord('Заказ');
  grBox.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Наименование');
  grBox.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Ед.');
  grBox.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Кол-во');
end;

procedure TfrmBox.RefreshGrid(Sender: TObject);
var
  Language: integer;
  I, ARow: integer;
  Item: TBoxItem;
begin
  //if not Self.Visible then Exit;
  grBox.Clear;
  Language := GlobalSettings.GetInstance.Language;
  RefreshGridHeader(Language);
  //grBox.Enabled := (FBox.Count > 0);
  //grBox.Selection := TGridRect(Rect(MaxInt, MaxInt, MaxInt, MaxInt));
  if Assigned(Self.FOnSelectItem) then FOnSelectItem(Self);
  if (FBox.Count = 0) then begin
    grBox.Rows[1].Clear;
    grBox.RowCount := 2;
    FormResize(Self);
    Exit;
  end;
  grBox.RowCount := FBox.Count + 1;

  //Perform(WM_SETREDRAW, 0, 0);

  ARow := 1;
  for I := 0 to Box.Count - 1 do begin
    Item := TBoxItem(Box.Items[I]);
    grBox.Cells[1, ARow] := Item.Order.Title;
    grBox.Cells[2, ARow] := Item.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language);
    grBox.Cells[3, ARow] := Translator.GetInstance.TranslateWord(
      Item.Part.PartUnit);
    grBox.Cells[4, ARow] := FloatToStr(Item.OrderCount);
    if ARow mod 2 = 0 then
      grBox.SetRowColor(ARow, rgb(240, 240, 230));
    Self.grBox.Objects[1, ARow] := Item;
    inc(ARow);
  end;
  grBox.Enabled := (ARow > 1);
  if Self.FSorted then grBox.Sort(1);
  if ARow > 1 then begin
    for I := 1 to grBox.RowCount - 1 do
      grBox.Cells[0, I] := IntToStr(I);
  end;
  Self.FormResize(Self);
  //grBox.Selection := TGridRect(Rect(MaxInt, MaxInt, MaxInt, MaxInt));

  //Perform(WM_SETREDRAW, 1, 0);
  //RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
end;

end.
