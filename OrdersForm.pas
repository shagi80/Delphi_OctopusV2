unit OrdersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Tabs, StdCtrls, TntStdCtrls, Buttons, ComCtrls, ToolWin,
  ExtCtrls, ImgList, Grids, TntGrids, OctopusGridCls, PartCls, OrderCls,
  OrderItemCls, DocumentCls;

type
  TOnSelectItem = procedure (OrderItem: TOrderItem) of object;
  TOnDoubleClick  = procedure (Sender: TObject) of object;

  TfrmOrders = class(TForm)
    grOrder: TOctopusStringGrid;
    ImageList1: TImageList;
    pnBottom: TPanel;
    lbTotalLabel1: TLabel;
    lbTotalLabel2: TLabel;
    lbTotalData1: TLabel;
    lbTotalData2: TLabel;
    pnTop: TPanel;
    pnToolBar: TPanel;
    tsOrderList: TTabSet;
    pnViewTools: TPanel;
    pnSearch: TPanel;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    edSearch: TTntEdit;
    tbView: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    btnSort: TToolButton;
    ToolButton1: TToolButton;
    btnShowAll: TToolButton;
    btnNotLoad: TToolButton;
    btnOverload: TToolButton;
    btnUnderload: TToolButton;
    pnEditTools: TPanel;
    tbEdit: TToolBar;
    btnOrderAdd: TToolButton;
    btnOrderCancate: TToolButton;
    btnOrderDelete: TToolButton;
    ToolButton2: TToolButton;
    btnPartAdd: TToolButton;
    btnPartDelete: TToolButton;
    btnOrderEditTitle: TToolButton;
    btnPartEdit: TToolButton;
    ppNewOrder: TPopupMenu;
    miNewEmpty: TMenuItem;
    miNewFromFile: TMenuItem;
    pmAddPart: TPopupMenu;
    miNewPart: TMenuItem;
    miCopyPart: TMenuItem;
    miAddPart: TMenuItem;
    miAddFromOther: TMenuItem;
    N1: TMenuItem;
    miNew1CMult: TMenuItem;
    ToolButton3: TToolButton;
    btnSearchPart: TToolButton;
    btnOrderSave: TToolButton;
    Label3: TLabel;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    btnPartListUpdate: TToolButton;
    procedure grOrderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure grOrderDblClick(Sender: TObject);
    procedure grOrderStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure grOrderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure grOrderSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnClearSearchClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tsOrderListChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
  private
    { Private declarations }
    FCurOrder: TOrder;
    FEditMode: boolean;
    FBoxCreatorMode: boolean;
    FSorted: boolean;
    FDocument: TDocument;
    FOnSelectItem: TOnSelectItem;
    FOnDoubleClick: TOnDoubleClick;
    FGridPosition: TPoint;
    procedure SetEditMode(EditMode: boolean);
    procedure SetBoxCreatorMode(BoxCreatorMode: boolean);
    procedure SetDocument(Document: TDocument);
    procedure RefreshGridHeader(Language: integer);
    function GetSelectItem: TOrderItem;
    procedure RefreshSumPanel(Sender: TObject);
  public
    { Public declarations }
    property Document: TDocument read FDocument write SetDocument;
    property CurrentOrder: TOrder read FCurOrder;
    property SelectItem: TOrderItem read GetSelectItem;
    property EditMode: boolean read FEditMode write SetEditMode;
    property BoxCreatorMode: boolean read FBoxCreatorMode write SetBoxCreatorMode;
    property OnSelectItem: TOnSelectItem read FOnSelectItem write FOnSelectItem;
    property OnDoubleClick: TOnDoubleClick read FOnDoubleClick write FOnDoubleClick;
    function ShowOrder(Order: TOrder): boolean;
    function ShowOrderItem(OrderItem: TOrderItem): boolean;
    procedure SetGridRowColor(LoadCount, ItemCount: real; ARow: integer);
  published
    procedure RefreshTabs(Sender: TObject);
    procedure RefreshGrid(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
  end;

var
  frmOrders: TfrmOrders;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls, BoxItemCls,
  DragObjectCls, PartPropertyForm, WaitingForm;

// Геттеры и сеттеры.

procedure TfrmOrders.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  if FEditMode then grOrder.EditableCells := [2, 4]
    else grOrder.EditableCells := [];
  Self.pnEditTools.Visible := FEditMode;
  Self.pnEditTools.Top := 0;
  RefreshGrid(Self);
end;

procedure TfrmOrders.SetBoxCreatorMode(BoxCreatorMode: boolean);
begin
  FBoxCreatorMode := BoxCreatorMode;
  if FBoxCreatorMode then begin
    grOrder.ColCount := 5;
    grOrder.ColAlign[4] := DT_RIGHT;
  end else grOrder.ColCount := 4;
  grOrder.CheckListStyle := FBoxCreatorMode;
  RefreshGrid(Self);
end;

procedure TfrmOrders.SetDocument(Document: TDocument);
begin
  FDocument := Document;
  FCurOrder := nil;
  if FDocument.Orders.Count = 0 then begin
    edSearch.Text := '';
    FCurOrder := nil;
    RefreshGrid(Self);
    tsOrderList.Tabs.Clear;
    Exit;
  end;
  RefreshTabs(Self);
end;

function TfrmOrders.GetSelectItem: TOrderItem;
begin
  Result := nil;
  if FCurOrder = nil then Exit;
  if grOrder.Selection.Top > 0 then
    Result := TOrderItem(grOrder.Objects[1, grOrder.Selection.Top]);
end;

// События формы.

procedure TfrmOrders.FormCreate(Sender: TObject);
begin
  FDocument := nil;
  FCurOrder := nil;
  FSorted := False;
  FBoxCreatorMode := False;
  grOrder.ColCount := 4;
  grOrder.CheckListStyle := False;
  FEditMode := False;
  grOrder.EditableCells := [];
  Self.pnEditTools.Visible := False;
  Self.btnWrap.Down := Self.grOrder.WordWrap;
  Self.btnColored.Down := Self.grOrder.Colored;
  Self.btnSort.Down := FSorted;
  grOrder.ColWidths[0] := 30;
  grOrder.ColAlign[2] := DT_RIGHT;
  grOrder.ColAlign[3] := DT_RIGHT;
  Self.FGridPosition.X := -1;
  Self.FGridPosition.Y := -1;
end;

procedure TfrmOrders.FormResize(Sender: TObject);
var
  I, ColWidth: integer;
begin
  // Поизционирование строки поиска.
  Self.pnSearch.Width := Self.pnTop.ClientWidth - Self.pnToolBar.Width - 10;
  if Self.pnSearch.Width > 200 then Self.pnSearch.Width := 200;
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grOrder.ColCount - 1 do
    if I <> 1 then
      ColWidth := ColWidth + grOrder.ColWidths[I] + 1;
  grOrder.ColWidths[1] := grOrder.ClientWidth - ColWidth - 2;
  if grOrder.ColWidths[1] < 70 then grOrder.ColWidths[1] := 70;
  grOrder.Repaint;
end;

procedure TfrmOrders.FormShow(Sender: TObject);
begin
  RefreshTabs(Self);
end;

// События таблицы и табсета

procedure TfrmOrders.tsOrderListChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if NewTab >= 0 then begin
    FCurOrder := TOrder(Self.tsOrderList.Tabs.Objects[NewTab]);
    RefreshGrid(Self);
  end;
end;

procedure TfrmOrders.grOrderSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  grOrder.Selection := TGridRect(Rect(ACol, ARow, ACol, ARow));
  if ARow < 0  then Exit;
  if Assigned(Self.FOnSelectItem) and (grOrder.Objects[1, ARow] <> nil) then
    Self.FOnSelectItem(TOrderItem(grOrder.Objects[1, ARow]));
end;

procedure TfrmOrders.ViewButtonsClick(Sender: TObject);
begin
  grOrder.Colored := Self.btnColored.Down;
  grOrder.WordWrap := btnWrap.Down;
  grOrder.Repaint;
end;

procedure TfrmOrders.btnClearSearchClick(Sender: TObject);
begin
  if Length(edSearch.Text) >0 then begin
    edSearch.Text := '';
    Self.RefreshGrid(Self);
  end;
end;

procedure TfrmOrders.btnSortClick(Sender: TObject);
begin
  Self.FSorted := Self.btnSort.Down;
  Self.RefreshGrid(Self);
end;

procedure TfrmOrders.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then RefreshGrid(Self)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then RefreshGrid(Self);
end;

procedure TfrmOrders.grOrderDblClick(Sender: TObject);
begin
  if Assigned(FOnDoubleClick) then FOnDoubleClick(Self);
end;

// Обработка перетаскивания ячейки табилцы.

procedure TfrmOrders.grOrderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.FGridPosition.X := X;
  Self.FGridPosition.Y := Y;
end;

procedure TfrmOrders.grOrderMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  ARow: integer;
  RowObject: TObject;
begin
  if grOrder.Dragging then Exit;
  if not FBoxCreatorMode then Exit;
  if not (ssLeft in Shift) then Exit;
  if (ABS(FGridPosition.X - X) > 3) or (ABS(FGridPosition.Y - Y) > 3) then begin
    ARow := grOrder.MouseCoord(X, Y).Y;
    if (ARow > 0) and (ARow < grOrder.RowCount) then begin
      RowObject := grOrder.Objects[1, ARow];
      if Assigned(RowObject) then grOrder.BeginDrag(False);
    end
  end;
end;

procedure TfrmOrders.grOrderStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if (Self.FBoxCreatorMode) and (grOrder.Row > 0) then
    DragObject := TOrderDragObject.Create(Self.FCurOrder,
      TOrderItem(grOrder.Objects[1, grOrder.Row]));
end;

// Процедура обновления.

procedure TfrmOrders.SetGridRowColor(LoadCount, ItemCount: real; ARow: integer);
begin
  if LoadCount = 0 then
    grOrder.SetRowColor(ARow, rgb(240, 128, 128))
  else if LoadCount < ItemCount then
    grOrder.SetRowColor(ARow, rgb(240, 230, 140))
  else if LoadCount > ItemCount then
    grOrder.SetRowColor(ARow, rgb(144, 238, 144))
  else
    grOrder.SetRowColor(ARow, clWhite);
end;

procedure TfrmOrders.RefreshTabs(Sender: TObject);
var
  I: integer;
begin
  if not Self.Visible then Exit;
  tsOrderList.Tabs.Clear;
  if (FDocument = nil) or (FDocument.Orders.Count = 0) then begin
    Self.FCurOrder := nil;
    Self.RefreshGrid(Self);
    Exit;
  end;
  for I := 0 to FDocument.Orders.Count - 1 do
    Self.tsOrderList.Tabs.AddObject(FDocument.Orders.Items[I].Title,
      FDocument.Orders.Items[I]);
  tsOrderList.TabIndex := 0;
end;

procedure TfrmOrders.RefreshGridHeader(Language: integer);
begin
  if not FBoxCreatorMode then begin
    grOrder.Cells[0, 0] := '№';
  end else begin
    grOrder.Cells[0, 0] := '';
    grOrder.Cells[4, 0] := Translator.GetInstance.TranslateWord(
      'В коробке');
  end;
  grOrder.Cells[1, 0] := Translator.GetInstance.TranslateWord(
    'Наименование');
  grOrder.Cells[2, 0] := Translator.GetInstance.TranslateWord(
    'Заказ');
  if True then
  if not GlobalSettings.GetInstance.ShowNotloadCountInOrder then
    grOrder.Cells[3, 0] := Translator.GetInstance.TranslateWord('Загруж')
  else
    grOrder.Cells[3, 0] := Translator.GetInstance.TranslateWord('Не загруж');
end;

procedure TfrmOrders.RefreshGrid(Sender: TObject);
var
  Language: integer;
  I, ARow, TopRow: integer;
  Item: TOrderItem;
  AddRow: boolean;
  Finder: TFindInShipment;
  LoadCount: real;
begin
  grOrder.Options := grOrder.Options - [goEditing];
  grOrder.DoExit;
  if not Self.Visible then Exit;
  TopRow := grOrder.TopRow;
  Self.grOrder.Clear;
  Language := GlobalSettings.GetInstance.Language;
  Self.RefreshGridHeader(Language);
  grOrder.Enabled := (FCurOrder <> nil);
  grOrder.SelectCell(MaxInt, MaxInt);
  if Assigned(Self.FOnSelectItem) then FOnSelectItem(nil);
  if ((FCurOrder = nil) or (FCurOrder.Count = 0)) then begin
    grOrder.RowCount := 2;
    Self.RefreshSumPanel(Self);
    Self.FormResize(Self);
    Exit;
  end;

  Perform(WM_SETREDRAW, 0, 0);

  Finder := TFindInShipment.Create(FDocument);
  grOrder.RowCount := FCurOrder.Count + 1;
  ARow := 1;
  for I := 0 to FCurOrder.Count - 1 do begin
    Item := TOrderItem(FCurOrder.Items[I]);
    LoadCount := Finder.CountForOrder(FcurOrder, Item.Part);
    AddRow := True;
    // Отбор по полю поиска.
    if Length(edSearch.Text) > 0 then
      AddRow := (pos(WideUpperCase(edSearch.Text),
        WideUpperCase(Item.Part.GetTranslatedTitle(Language))) > 0);
    // Отбор по загруженному количеству.
    if not Self.btnShowAll.Down then begin
      AddRow := False;
      if (Self.btnNotLoad.Down) and (LoadCount = 0) then
        AddRow := True
      else if (Self.btnOverload.Down) and (LoadCount > Item.OrderCount) then
        AddRow := True
      else if (Self.btnUnderload.Down) and (LoadCount < Item.OrderCount) then
        AddRow := True;
    end;
    // Вывод строки.
    if AddRow then begin
      grOrder.Cells[1, ARow] := Item.Part.GetTranslatedTitle(Language);
      grOrder.Cells[2, ARow] := FloatToStr(Item.OrderCount);
      if not GlobalSettings.GetInstance.ShowNotloadCountInOrder then
        grOrder.Cells[3, ARow] := FloatToStr(LoadCount)
      else
        grOrder.Cells[3, ARow] := FloatToStr(Item.OrderCount - LoadCount);
      if Self.FBoxCreatorMode then
        grOrder.Cells[4, ARow] := FloatToStr(Item.Part.CountInBox);
      Self.SetGridRowColor(LoadCount, Item.OrderCount, Arow);
      Self.grOrder.Objects[1, ARow] := Item;
      inc(ARow);
      frmWaiting.NextStep(Self);
    end;
  end;
  Self.RefreshSumPanel(Self);
  grOrder.Enabled := (ARow > 1);
  if ARow > 1 then begin
    grOrder.RowCount := ARow;
    Self.lbTotalData2.Caption := IntToStr(ARow - 1);
  end else begin
    grOrder.RowCount := 2;
    Self.lbTotalData2.Caption := '0';
  end;
  if Self.FSorted then grOrder.Sort(1);
  if ARow > 1 then
    for I := 1 to grOrder.RowCount - 1 do grOrder.Cells[0, I] := IntToStr(I);
  Finder.Free;
  OnResize(Self);
  if (TopRow < (grOrder.RowCount - 1))
    and (grOrder.RowCount > grOrder.VisibleRowCount) then
      grOrder.TopRow := TopRow;

  Perform(WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
end;

procedure TfrmOrders.RefreshSumPanel(Sender: TObject);
begin
  Self.pnBottom.Visible := ((FCurOrder <> nil) and (FCurOrder.Count > 0));
  if FCurOrder = nil then Exit;  
  Self.lbTotalData1.Caption := IntToStr(FCurOrder.Count);
  Self.lbTotalData2.Caption := IntToStr(grOrder.RowCount - 1);
end;

// Функции посика и выделениея в таблице

function TfrmOrders.ShowOrder(Order: TOrder): boolean;
var
  I: integer;
begin
  Result := False;
  if Order = nil then Exit;
  for I := 0 to Self.tsOrderList.Tabs.Count - 1 do
    if TOrder(Self.tsOrderList.Tabs.Objects[I]) = Order then begin
      Result := True;
      Self.tsOrderList.TabIndex := I;
      Self.FCurOrder := Order;
      Break;
    end;
end;

function TfrmOrders.ShowOrderItem(OrderItem: TOrderItem): boolean;
var
  ARow, I: integer;
  Order: TOrder;
begin
  Result := False;
  if OrderItem = nil then Exit;
  Self.edSearch.Text := '';
  Self.btnShowAll.Down := True;
  for I := 0 to Self.tsOrderList.Tabs.Count - 1 do begin
    Order := TOrder(Self.tsOrderList.Tabs.Objects[I]);
    if Order.IndexOf(OrderItem) >= 0 then begin
      if Self.tsOrderList.TabIndex <> I then tsOrderList.TabIndex := I;
      grOrder.ScrollToObject(1, OrderItem);
      ARow := grOrder.Row;
      if ARow > 0  then
        if Assigned(FOnSelectItem) and (grOrder.Objects[1, ARow] <> nil) then
          FOnSelectItem(TOrderItem(grOrder.Objects[1, ARow]));
      Result := True;
      Exit;
    end;
  end;
end;

end.
