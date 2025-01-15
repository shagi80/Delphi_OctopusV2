unit PrintOrderControllerCls;

interface

uses
   OrderCls, DocumentCls, OrderListCls, frxClass;

const
  PrintFormFile = 'PrintForm/OrderList.fr3';

type
  TPrintOrderController = class(TObject)
  private
    FDocument: TDocument;
    FOrderList: TOrderList;
    procedure CannotPrintMessage;
    procedure CreateOrderData(Source, Target: TOrder; SortTitleInd: integer; CopyMode: integer);
    procedure PrintOrders(OrderList: TOrderList);
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetMasterNext(Sender: TObject);
    procedure ResizePrintModeForm;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure PrintAll(Sender: TObject);
    procedure PrintCurrent(Sender: TObject);
    procedure PrintSelect(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, OrderItemCls,
 SysUtils, OrdersForm, Forms, GlobalSettingsCls, PrintDataModule,
 WaitingForm;

const
  SortNone =  -1;
  SortRussian =  0;
  SortEnglish = 1;
  SortChinese = 2;
  OrderCopyAll = 0;
  OrderCopyNotLoad = 1;
  OrderCopyOverload = 2;
  OrderCopyUnderload = 3;

constructor TPrintOrderController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FOrderList := nil;
end;

destructor TPrintOrderController.Destroy;
begin
  FDocument := nil;
  inherited Destroy;
end;

procedure TPrintOrderController.CannotPrintMessage;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    44, 'Нет данных для печати' + ' !');
  MessageDlg(Text, mtWarning, [mbOk], 0);
end;

procedure TPrintOrderController.ResizePrintModeForm;
begin
  frmPrintMode.pnBottom.Visible := False;
  frmPrintMode.Width := frmPrintMode.imgPrint.Width + 10;
  frmPrintMode.Height := frmPrintMode.imgPrint.Height + 30;
  frmPrintMode.Left := trunc((Screen.Width - frmPrintMode.Width) / 2);
  frmPrintMode.Top := trunc((Screen.Height - frmPrintMode.Height) / 2);
end;

// Подготоака данных

procedure TPrintOrderController.CreateOrderData(Source, Target: TOrder; SortTitleInd: integer; CopyMode: integer);
var
  I, J: integer;
  Finder: TFindInShipment;
  CanAdd: boolean;
  NewItem, Item: TOrderItem;
  LoadCount: real;
  TitleCurrent, TitleNew: widestring;
begin
  Finder := TFindInShipment.Create(FDocument);
  for I := 0 to Source.Count - 1 do begin
    Item := TOrderItem(Source.Items[I]);
    if CopyMode = OrderCopyAll then LoadCount := 0
      else LoadCount := Finder.CountForOrder(Source, Item.Part);
    CanAdd := False;
    // Отбор по загруженному количеству.
    case CopyMode of
      OrderCopyAll: CanAdd := True;
      OrderCopyNotLoad: CanAdd := (LoadCount = 0);
      OrderCopyOverload: CanAdd := (LoadCount > Item.OrderCount);
      OrderCopyUnderload: CanAdd := (LoadCount < Item.OrderCount);
    end;
    // Создание элеиентов
    if CanAdd then begin
      NewItem := TOrderItem.Create(Item.Part);
      NewItem.OrderCount := Item.OrderCount;
      if (Target.Count = 0) or (SortTitleInd = SortNone) then Target.Add(NewItem)
        else begin
          J := 0;
          TitleNew := NewItem.Part.GetTranslatedTitle(SortTitleInd);
          repeat
            TitleCurrent := Target.Items[J].Part.GetTranslatedTitle(SortTitleInd);
            inc(j);
          until (J = Target.Count) or (TitleNew < TitleCurrent);
          if J = Target.Count then Target.Add(NewItem)
            else Target.Insert(J - 1, NewItem);
        end;
    end;
  end;
  Finder.Free;
end;

procedure TPrintOrderController.PrintOrders(OrderList: TOrderList);
var
  FileName: string;
begin
  Self.ResizePrintModeForm;
  if (OrderList = nil) or (OrderList.Count = 0) then begin
    frmPrintMode.Close;
    Self.CannotPrintMessage;
    Exit;
  end;
  FileName := ExtractFilePath(Application.ExeName) + 'PrintForm/OrderList.fr3';
  if FileExists(FileName) then begin
    FOrderList := OrderList;
    with dmPrint do begin
      frmWaiting.WaitPrint;
      frxDataSetMaster.RangeEndCount := OrderList.Count;
      frxDataSetMaster.First;
      frxDataSetMaster.OnNext := Self.frxDataSetMasterNext;
      frxDataSetDetail.RangeEndCount := OrderList.Items[0].Count;
      frxDataSetDetail.First;
      frxDataSetDetail.OnNext := nil;

      frxReport.OnGetValue := Self.frxDataSetMasterGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      frxReport.ShowPreparedReport;
    end;
    FOrderList := nil;
  end else Self.CannotPrintMessage;
  frmPrintMode.Close;
end;

// Настройка компонентов frx

procedure TPrintOrderController.frxDataSetMasterNext(Sender: TObject);
var
  OrderInd: integer;
begin
  OrderInd := dmPrint.frxDataSetMaster.RecNo;
  if OrderInd < FOrderList.Count then begin
    dmPrint.frxDataSetDetail.RangeEndCount := FOrderList.Items[OrderInd].Count;
    dmPrint.frxDataSetDetail.First;
  end;
end;

procedure TPrintOrderController.frxDataSetMasterGetValue(const VarName: string;
  var Value: Variant);
var
  OrderInd, ItemInd: integer;
  Item: TOrderItem;
  LocTranslator: TTranslatorSingleton;
  Finder: TFindInShipment;
begin
  Value := '??';
  frmWaiting.NextStep(Self);
  LocTranslator := Translator.GetInstance;
  OrderInd := dmPrint.frxDataSetMaster.RecNo;
  //
  if VarName = 'ReportTitle' then Value := LocTranslator.TranslateWord('Заказы');
  if VarName = 'FileName' then Value := LocTranslator.TranslateWord('из файла')
    + ' ' + FDocument.FileName;
  if VarName = 'hdrRow' then Value := '№';
  if VarName = 'hdrCode' then Value := LocTranslator.TranslateWord('Код 1С');
  if VarName = 'hdrTitle' then Value := LocTranslator.TranslateWord('Наименование');
  if VarName = 'hdrUnit' then Value := LocTranslator.TranslateWord('Ед.');
  if VarName = 'hdrOrderCount' then Value := LocTranslator.TranslateWord('Заказано');
  if VarName = 'hdrLoadCount' then Value := LocTranslator.TranslateWord('Загружено');
  if VarName = 'hdrBalance' then Value := LocTranslator.TranslateWord('Баланс');
  if VarName = 'OrderTitle' then Value := LocTranslator.TranslateWord('Заказ')
    + ': ' + FOrderList.Items[OrderInd].Title;
  //
  ItemInd := dmPrint.frxDataSetDetail.RecNo;
  if ItemInd >= FOrderList.Items[OrderInd].Count then Exit;
  Item := FOrderList.Items[OrderInd].Items[ItemInd];
  if VarName = 'Row' then Value := ItemInd + 1;
  if VarName = 'Code' then Value := Item.Part.Code;
  if VarName = 'Title' then Value := Item.Part.GetTranslatedTitle(
    GlobalSettings.GetInstance.Language);
  if VarName = 'Unit' then Value := LocTranslator.TranslateWord(
    Item.Part.PartUnit);
  if VarName = 'OrderCount' then Value := Item.OrderCount;
  if VarName = 'LoadCount' then begin
    Finder := TFindInShipment.Create(FDocument);
    Value := Finder.CountForOrderByTitle(FOrderList.Items[OrderInd].Title, Item.Part.Code);
    Finder.Free;
  end;
  if VarName = 'Balance' then begin
    Finder := TFindInShipment.Create(FDocument);
    Value := Finder.CountForOrderByTitle(FOrderList.Items[OrderInd].Title, Item.Part.Code)
      - Item.OrderCount;
    Finder.Free;
  end;
end;

//

procedure TPrintOrderController.PrintAll(Sender: TObject);
var
  OrderList: TOrderList;
  Order: TOrder;
  CopyMode, SortMode, I: Integer;
begin
  if FDocument.Orders.Count = 0 then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  CopyMode := OrderCopyAll;
  SortMode := SortNone;
  repeat
    if not frmPrintMode.GetSortMode(SortMode, False) then begin
      frmPrintMode.ShowMainPage;
      Exit;
    end;
  until frmPrintMode.GetOrderCopyMode(CopyMode);
  OrderList := TOrderList.Create;
  for I := 0 to FDocument.Orders.Count - 1 do begin
    Order := TOrder.Create;
    Order.Title := FDocument.Orders.Items[I].Title;
    CreateOrderData(FDocument.Orders.Items[I], Order, SortMode, CopyMode);
    OrderList.Add(Order);
  end;
  Self.PrintOrders(OrderList);
  OrderList.Free;
end;

procedure TPrintOrderController.PrintCurrent(Sender: TObject);
var
  OrderList: TOrderList;
  Order: TOrder;
  CopyMode, SortMode: Integer;
begin
  if frmOrders.CurrentOrder = nil then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  CopyMode := OrderCopyAll;
  SortMode := SortNone;
  repeat
    if not frmPrintMode.GetSortMode(SortMode, False) then begin
      frmPrintMode.ShowMainPage;
      Exit;
    end;
  until frmPrintMode.GetOrderCopyMode(CopyMode);
  OrderList := TOrderList.Create;
  Order := TOrder.Create;
  Order.Title := frmOrders.CurrentOrder.Title;
  Self.CreateOrderData(frmOrders.CurrentOrder, Order, SortMode, CopyMode);
  OrderList.Add(Order);
  Self.PrintOrders(OrderList);
  OrderList.Free;
end;

procedure TPrintOrderController.PrintSelect(Sender: TObject);
var
  OrderList: TOrderList;
  I, Step, CopyMode, SortMode: integer;
  Order: TOrder;
begin
  if FDocument.Orders.Count = 0 then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  Step := 0;
  CopyMode := OrderCopyAll;
  SortMode := SortNone;
  repeat
    if Step = 0 then
      if frmPrintMode.GetSortMode(SortMode, False) then inc(Step)
        else begin
          frmPrintMode.ShowMainPage;
          Exit;
        end;
    if Step = 1 then
      if frmPrintMode.GetOrderCopyMode(CopyMode, False) then inc(Step) else dec(Step);
    if Step = 2 then
      if frmPrintMode.SetCheckList(FDocument.Orders) then inc(Step) else dec(Step);
  until Step = 3;
  OrderList := TOrderList.Create;
  for I := 0 to frmPrintMode.cbCheck.Items.Count - 1 do
    if frmPrintMode.cbCheck.Checked[I] then begin
      Order := TOrder.Create;
      Order.Title := TOrder(frmPrintMode.cbCheck.Items.Objects[I]).Title;
      CreateOrderData(TOrder(frmPrintMode.cbCheck.Items.Objects[I]),
        Order, SortMode, CopyMode);
      OrderList.Add(Order);
    end;
  if OrderList.Count > 0 then
    Self.PrintOrders(OrderList);
  OrderList.Free;
end;



end.
