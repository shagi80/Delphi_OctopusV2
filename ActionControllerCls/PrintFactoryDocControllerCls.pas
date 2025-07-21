unit PrintFactoryDocControllerCls;

interface

uses
   BoxCls, DocumentCls, BoxItemCls, frxClass, Classes, ContainerCls,
   TntStdCtrls, TntClasses;


type
  TFactoryDocPrintMode = (fdpmNone, fdpmOrder, fdpmBalance);

  TPrintFactoryDocController = class(TObject)
  private
    FDocument: TDocument;
    FFactoryOrders: TContainer;
    FMode: TFactoryDocPrintMode;
    procedure CannotPrintMessage;
    function PreparyFactoriesList(var Factories: TTntStringList): boolean;
    procedure Print(FactoryOrders: TContainer);
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetMasterNext(Sender: TObject);
    procedure frxDataSetDetailGetValue(const VarName: string; var Value: Variant);
    procedure ResizePrintModeForm;
    function PrepareData(var FactoryOrders: TContainer): boolean;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure PrintFactoryOrder(Sender: TObject);
    procedure PrintFactoryBalance(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, OrderItemCls,
 SysUtils, OrdersForm, Forms, GlobalSettingsCls, PrintDataModule,
 WaitingForm;


constructor TPrintFactoryDocController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FFactoryOrders := nil;
  FMode := fdpmNone;
end;

destructor TPrintFactoryDocController.Destroy;
begin
  FDocument := nil;
  inherited Destroy;
end;

procedure TPrintFactoryDocController.CannotPrintMessage;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    44, 'Нет данных для печати' + ' !');
  MessageDlg(Text, mtWarning, [mbOk], 0);
end;

procedure TPrintFactoryDocController.ResizePrintModeForm;
begin
  frmPrintMode.pnBottom.Visible := False;
  frmPrintMode.Width := frmPrintMode.imgPrint.Width + 10;
  frmPrintMode.Height := frmPrintMode.imgPrint.Height + 30;
  frmPrintMode.Left := trunc((Screen.Width - frmPrintMode.Width) / 2);
  frmPrintMode.Top := trunc((Screen.Height - frmPrintMode.Height) / 2);
end;

// Подготоака данных

procedure TPrintFactoryDocController.Print(FactoryOrders: TContainer);
var
  FileName: string;
begin
  Self.ResizePrintModeForm;
  if (FactoryOrders = nil) or (FactoryOrders.Count = 0) then begin
    frmPrintMode.Close;
    Self.CannotPrintMessage;
    Exit;
  end;
  case Self.FMode of
    fdpmNone: Exit;
    fdpmOrder: FileName := ExtractFilePath(Application.ExeName)
      + 'PrintForm/FactoryOrder.fr3';
    fdpmBalance: FileName := ExtractFilePath(Application.ExeName)
      + 'PrintForm/FactoryBalance.fr3';
  end;
  if FileExists(FileName) then begin
    FFactoryOrders := FactoryOrders;
    with dmPrint do begin
      frmWaiting.WaitPrint;
      frxDataSetMaster.RangeEndCount := FactoryOrders.Count;
      frxDataSetMaster.First;
      frxDataSetMaster.OnNext := Self.frxDataSetMasterNext;
      frxDataSetMaster.OnGetValue := Self.frxDataSetMasterGetValue;

      frxDataSetDetail.RangeEndCount := FFactoryOrders.Items[0].Count;
      frxDataSetDetail.First;
      frxDataSetDetail.OnNext := nil;
      frxDataSetDetail.OnGetValue := Self.frxDataSetDetailGetValue;

      frxDataSetSubDetail.OnNext := nil;
      frxDataSetSubDetail.OnGetValue := nil;

      frxReport.LoadFromFile(FileName);
      frxReport.Variables['ReportTitle'] := '''' + FFactoryOrders.Title + '''';
      frxReport.Variables['FileName'] := '''' + FDocument.InvoiceNumber + '''';
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      frxReport.ShowPreparedReport;
    end;
    FFactoryOrders := nil;
  end else Self.CannotPrintMessage;
  frmPrintMode.ShowMainPage;
end;

function TPrintFactoryDocController.PreparyFactoriesList(
  var Factories: TTntStringList): boolean;
var
  I: integer;
  FactoryName: widestring;
begin
  Factories.Clear;
  for I := 0 to Self.FDocument.Parts.Count - 1 do begin
    FactoryName := FDocument.Parts.Items[I].Factory;
    if (Length(FactoryName) > 0) and (Factories.IndexOf(FactoryName) < 0) then
      Factories.Add(FactoryName);
  end;
  Result := Factories.Count > 0;
end;

function TPrintFactoryDocController.PrepareData(
  var FactoryOrders: TContainer): boolean;
var
  Factories: TTntStringList;
  I, J, K: integer;
  FactoryOrder: TBox;
  FactoryOrderItem: TBoxItem;
  Finder: TFindInShipment;
begin
  Result := False;
  // Получаем список всех производителей
  Factories := TTntStringList.Create;
  if not Self.PreparyFactoriesList(Factories) then begin
    Self.CannotPrintMessage;
    Factories.Free;
    Exit;
  end;
  // Предлагаем выбрать производителей
  if not frmPrintMode.SetCheckList(Factories) then begin
    Factories.Free;
    frmPrintMode.ShowMainPage;
    Exit;
  end;
  // Получакм вабранных производителей
  Factories.Clear;
  for I := 0 to frmPrintMode.cbCheck.Items.Count - 1 do
    if frmPrintMode.cbCheck.Checked[I] then
      Factories.Add(frmPrintMode.cbCheck.Items.Strings[I]);
  // Формируем данные для документа в зависимости от выбранного режима
  Finder := TFindInShipment.Create(FDocument);
  for I := 0 to Factories.Count - 1 do
    for J := 0 to FDocument.Orders.Count - 1 do
      for K := 0 to FDocument.Orders[J].Count - 1 do
        if FDocument.Orders[J].Items[K].Part.Factory
          = Factories.Strings[I] then begin
            FactoryOrder := FactoryOrders.BoxByCode[Factories.Strings[I]];
            if not Assigned(FactoryOrder) then begin
              FactoryOrder := TBox.Create;
              FactoryOrder.BoxCode := Factories.Strings[I];
              FactoryOrders.Add(FactoryOrder);
            end;
            FactoryOrderItem := TBoxItem.Create(FDocument.Orders[J],
              FDocument.Orders[J].Items[K].Part);
            // В зависимости от выбранного режима печати получаем или заканное
            // или загруженное количетсво
            if Self.FMode = fdpmBalance then
              FactoryOrderItem.OrderCount := Finder.CountForOrder(
                FDocument.Orders[J], FDocument.Orders[J].Items[K].Part)
            else
              FactoryOrderItem.OrderCount :=
                FDocument.Orders[J].Items[K].OrderCount;
            // Считаем общее количество
            FactoryOrderItem.TotalCost := FactoryOrderItem.OrderCount
                * FactoryOrderItem.Part.SupplierPrice;
            FactoryOrder.Add(FactoryOrderItem);
          end;
  Finder.Free;
  Factories.Free;
  Result := True;
end;

// Настройка компонентов frx

procedure TPrintFactoryDocController.frxDataSetMasterNext(Sender: TObject);
var
  FactoryInd: integer;
begin
  FactoryInd := dmPrint.frxDataSetMaster.RecNo;
  if FactoryInd < FFactoryOrders.Count then begin
    dmPrint.frxDataSetDetail.RangeEndCount :=
      FFactoryOrders.Items[FactoryInd].Count;
    dmPrint.frxDataSetDetail.First;
  end;
end;

procedure TPrintFactoryDocController.frxDataSetMasterGetValue(const VarName: string;
  var Value: Variant);
var
  FactoryOrder: TBox;
  LocTranslator: TTranslatorSingleton;
begin
  Value := '??';
  LocTranslator := Translator.GetInstance;
  FactoryOrder := FFactoryOrders.Items[dmPrint.frxDataSetMaster.RecNo];
  if VarName = 'Factory' then Value := FactoryOrder.BoxCode;
  if VarName = 'OrderName' then Value := LocTranslator.TranslateWord('Заказ');
  if VarName = 'ItemTitle' then Value := LocTranslator.TranslateWord('Наименование');
  if VarName = 'Unit' then Value := LocTranslator.TranslateWord('Ед.');
  if VarName = 'Count' then
    case Self.FMode of
      fdpmNone: Value := 'Error';
      fdpmOrder: Value := LocTranslator.TranslateWord('Заказано');                   
      fdpmBalance: Value := LocTranslator.TranslateWord('Загружено');
    end;
  if VarName = 'PcsPrice' then
    Value := LocTranslator.TranslateWord('Цена производителя');
  if VarName = 'TotalCost' then
    Value := LocTranslator.TranslateWord('Сумма');
end;

procedure TPrintFactoryDocController.frxDataSetDetailGetValue(const VarName: string;
  var Value: Variant);
var
  FactoryOrder: TBox;
  FactoryOrderItem: TBoxItem;
  LocTranslator: TTranslatorSingleton;
begin
  Value := '??';
  frmWaiting.NextStep(Self);
  LocTranslator := Translator.GetInstance;
  FactoryOrder := FFactoryOrders.Items[dmPrint.frxDataSetMaster.RecNo];
  FactoryOrderItem := FactoryOrder.Items[dmPrint.frxDataSetDetail.RecNo];
  if VarName = 'OrderName' then Value := FactoryOrderItem.Order.Title;
  if VarName = 'ItemTitle' then Value := FactoryOrderItem.Part.GetTranslatedTitle(
    GlobalSettings.GetInstance.Language);
  if VarName = 'Unit' then Value := LocTranslator.TranslateWord(
    FactoryOrderItem.Part.PartUnit);
  if VarName = 'Count' then Value := FactoryOrderItem.OrderCount;
  if VarName = 'PcsPrice' then Value := FactoryOrderItem.Part.SupplierPrice;
  if VarName = 'TotalCost' then Value := FactoryOrderItem.TotalCost;
end;

//

procedure TPrintFactoryDocController.PrintFactoryOrder(Sender: TObject);
var
  FactoryOrders: TContainer;
  I: integer;
begin
  Self.FMode := fdpmOrder;
  if FDocument.Orders.Count = 0 then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  FactoryOrders := TContainer.Create;
  FactoryOrders.Title := Translator.GetInstance.TranslateMessage(
    113, 'Заказ поставщику');
  if (PrepareData(FactoryOrders)) and (FactoryOrders.Count > 0) then begin
    for I := 0 to FactoryOrders.Count - 1 do
      FactoryOrders.Items[I].SortByNameAndOrder;
    Self.Print(FactoryOrders);
  end;
  FactoryOrders.Free;
end;

procedure TPrintFactoryDocController.PrintFactoryBalance(Sender: TObject);
var
  FactoryOrders: TContainer;
  I: integer;
begin
  Self.FMode := fdpmBalance;
  if FDocument.Containers.Count = 0 then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  FactoryOrders := TContainer.Create;
  FactoryOrders.Title := Translator.GetInstance.TranslateMessage(
    114, 'Заказ поставщику');
  if (PrepareData(FactoryOrders)) and (FactoryOrders.Count > 0) then begin
    for I := 0 to FactoryOrders.Count - 1 do
      FactoryOrders.Items[I].SortByNameAndOrder;
    Self.Print(FactoryOrders);
  end;
  FactoryOrders.Free;
end;

end.
