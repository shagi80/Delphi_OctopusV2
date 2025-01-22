unit OrderControllerCls;

interface

uses
  DocumentCls, OrderCls, PartListCls, OrderItemCls, PartCls;

type
  TOnChangeModel = procedure (Sender: TObject; UpdateInterface: boolean) of object;

  TOrderController = class(TObject)
  private
    FDocument: TDocument;
    FOnChangeModel: TOnChangeModel;
    function AddEmpty: integer;
    function AddFromFile: integer;
    function AddFrom1C(FileName: string): integer;
    function AddFrom1CAndMultiple: integer;
    function AddFromOtherFile(FileName: string): integer;
    function GetNewOrderTitle(Order: TOrder): string;
    procedure RefreshAllGrids;
    function GetOrderFrom1CFile(FileName: string = ''): TOrder;
    function AddNewOrderItem(Item: TOrderItem): TOrderItem;
    function GetFileName: string;
    procedure ChangeModelEvent(UpdateInterface: boolean);
    function SetOrderCount(Item: TOrderItem; Value: real; ARow: integer): boolean;
    function SetBoxCount(Item: TOrderItem; Value: real; ARow: integer): boolean;
  public
    constructor Create(Document: TDocument);
    procedure OrderAddExecute(Sender: TObject);
    procedure OrderSaveTo1C(Sender: TObject);
    procedure OrderEditPartExecute(Sender: TObject);
    procedure OrderConcateExecute(Sender: TObject);
    procedure OrderRenameExecute(Sender: TObject);
    procedure OrderDeleteExecute(Sender: TObject);
    procedure OrderAddPartExecute(Sender: TObject);
    procedure OrderAddPartFromFileExecute(Sender: TObject);
    procedure OrderCopyPartExecute(Sender: TObject);
    procedure OrderDeletePartExecute(Sender: TObject);
    procedure OrderSearchPartExecute(Sender: TObject);
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
    property OnChangeModel: TOnChangeModel read FOnChangeModel write FOnChangeModel;
  end;

implementation

uses
  Forms, Classes, Grids, Dialogs, OrdersForm, InputForm, TranslatorCls,
  GlobalSettingsCls, DocLoaderCls, SysUtils, SelectOrdersForm, Controls,
  BoxForm, ContainerForm, PartEditorForm, PartPropertyForm, InvoiceForm,
  PartListForm, Contnrs,  FindInShipmentCls, SearchForm, DocSaverCls,
  MultiplierManagerCls;

constructor TOrderController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
end;

function TOrderController.GetNewOrderTitle(Order: TOrder): string;
var
  Title, Text1, Text2: string;
  SearchOrder: TOrder;
begin
  Result := '';
  if Order = nil then Title := FDocument.GetNewOrderTitle
    else Title := Order.Title;
  Text1 := Translator.GetInstance.TranslateMessage(
    13, 'Укажите заголовок заказа');
  repeat
    if not frmInput.GetString(Text1, Title) then Exit;
    SearchOrder := FDocument.Orders.OrderByTitle[Title];
    if (SearchOrder = nil) or (SearchOrder = Order) then Break;
    Text2 := Translator.GetInstance.TranslateMessage(
      14, 'Заказ с таким именем уже существует !');
    MessageDlg(Text2, mtWarning, [mbOk], 0);
  until False;
  Result := Title;
end;

function TOrderController.GetOrderFrom1CFile(FileName: string = ''): TOrder;
var
  Order: TOrder;
  Loader: TDocLoader;
begin
  Result := nil;
  if Length(FileName) = 0 then FileName := Self.GetFileName;
  if Length(FileName) = 0 then Exit;
  Loader := TDocLoader.Create(FileName);
  Order := TOrder.Create;
  if Loader.LoadOrderFrom1C(Order, FDocument) then
    Result := Order else Order.Free;
  Loader.Destroy;
end;

function TOrderController.GetFileName: string;
var
  OpenDlg: TOpenDialog;
begin
  Result := '';
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.Title := Translator.GetInstance.TranslateMessage(
    15, 'Выбор файла');
  OpenDlg.Filter := 'Text files|*.txt';
  if OpenDlg.Execute then Result := OpenDlg.FileName;
  OpenDlg.Free;
end;

procedure TOrderController.RefreshAllGrids;
begin
  frmOrders.RefreshGrid(Self);
  frmPartProperty.RefreshGrid(Self);
  frmBox.RefreshData(Self);
  frmContainers.RefreshGrid(Self);
  frmInvoice.RefreshGrid(Self);
end;

procedure TOrderController.ChangeModelEvent(UpdateInterface: Boolean);
begin
  if Assigned(Self.FOnChangeModel) then
    Self.FOnChangeModel(Self, UpdateInterface);
end;

// Операции с заказом

function TOrderController.AddEmpty: integer;
var
  Title: string;
  Order: TOrder;
begin
  Result := -1;
  Title := Self.GetNewOrderTitle(nil);
  if Length(Title) = 0 then Exit;
  Order := TOrder.Create;
  Order.Title := Title;
  Result := FDocument.Orders.Add(Order);
end;

function TOrderController.AddFromFile: integer;
var
  Loader: TDocLoader;
  FileName: string;
begin
  Result := -1;
  FileName := Self.GetFileName;
  if Length(FileName) = 0 then Exit;
  // Определение типа файла.
  Loader := TDocLoader.Create(FileName);
  if Loader.FileIs1C then Result := AddFrom1C(FileName)
    else Result := AddFromOtherFile(FileName);
  Loader.Free;
end;

function TOrderController.AddFrom1C(FileName: string): integer;
var
  Order: TOrder;
  SearchOrder: TOrder;
begin
  Result := -1;
  Order := Self.GetOrderFrom1CFile(FileName);
  if Order = nil then Exit;
  // Исключение повторящющихся заголовков
  repeat
    SearchOrder := FDocument.Orders.OrderByTitle[Order.Title];
    if (SearchOrder = nil) then Break;
    Order.Title := Order.Title + '_1';
  until False;
  Result := FDocument.Orders.Add(Order);
end;

function TOrderController.AddFrom1CAndMultiple: integer;
var
  Order: TOrder;
  I, Mult: integer;
  Title, Text1, Text2: string;
  SearchOrder: TOrder;
  MultiplierManager: TMultiplierManager;
  NewCount: real;
begin
  Result := -1;
  Order := Self.GetOrderFrom1CFile;
  if Order = nil then Exit;
  // Подготовка запроса заголовка и множителя
  Title := Order.Title;
  Text1 := Translator.GetInstance.TranslateMessage(
    36, 'Введите заголовок и множитель');
  Mult := 1000;
  // Исключение повторяющихся заголовков
  repeat
    if not frmInput.GetStringAndInteger(Text1, Title, Mult) then begin
      Order.Free;
      Exit;
    end;
    SearchOrder := FDocument.Orders.OrderByTitle[Title];
    if (SearchOrder = nil) then Break;
    Text2 := Translator.GetInstance.TranslateMessage(
      14, 'Заказ с таким именем уже существует !');
    MessageDlg(Text2, mtWarning, [mbOk], 0);
  until False;
  // Умножение элементов на множитель
  MultiplierManager := TMultiplierManager.Create;
  if MultiplierManager.LoadFromFile then begin
    Text1 := '';
    for I := 0 to Order.Count - 1 do begin
      NewCount := Order.Items[I].OrderCount * Mult;
      if MultiplierManager.PartCountRoundUp(Order.Items[I].Part.Code, NewCount) then
        Text1 := Text1 + ' - ' + Order.Items[I].Part.GetTranslatedTitle(
          GlobalSettings.GetInstance.Language) + chr(13);
      Order.Items[I].OrderCount := NewCount;
    end;
    if Length(Text1) > 0 then begin
      Title := Translator.GetInstance.TranslateMessage(
        69, 'Количества деталей, перечисленных ниже, будут округлены') + ':' + chr(13);
      MessageDlg(Title + Text1, mtInformation, [mbOk], 0);
    end;
  end;
  MultiplierManager.Free;
  Result := FDocument.Orders.Add(Order);
end;

function TOrderController.AddFromOtherFile(FileName: string): integer;
var
  NewOrder, SelectedOrder, SearchOrder: TOrder;
  OrderItem: TOrderItem;
  OtherDocument: TDocument;
  NewPart, OtherPart, SearchPart: TPart;
  I, J: integer;
  Loader: TDocLoader;
  Title: string;
begin
  Result := -1;
  if Length(FileName) = 0 then Exit;
  // Загрузка документа из файла
  Loader := TDocLoader.Create(FileName);
  OtherDocument := TDocument.Create;
  if Loader.Load(OtherDocument) then
    if OtherDocument.Orders.Count > 0 then begin
      // Вывод окна выбора
      frmSelectOrders.SetOrders(OtherDocument.Orders, ExtractFilename(FileName));
      if frmSelectOrders.ShowModal = mrOk then
        // Перебор выбранных заказов
        for I := 0 to frmSelectOrders.chblOrders.Items.Count - 1 do
          if frmSelectOrders.chblOrders.Checked[I] then begin
            SelectedOrder := TOrder(frmSelectOrders.chblOrders.Items.Objects[I]);
            // Обеспечиваем уникальность заголовка
            Title := SelectedOrder.Title;
            repeat
              SearchOrder := FDocument.Orders.OrderByTitle[Title];
              if (SearchOrder = nil) then Break;
              Title := Title + '_1';
            until False;
            // Создаем новый заказ
            NewOrder := TOrder.Create;
            NewOrder.Title := Title;
            // Обеспечиваем перенос деталей из внешнего заказа
            for J := 0 to SelectedOrder.Count - 1 do begin
              // Добавляем внешние детали в текущий файл без дублирования
              OtherPart := SelectedOrder.Items[J].Part;
              SearchPart := FDocument.Parts.Items[OtherPart.Code];
              if SearchPart = nil then begin
                NewPart := TPart.Create(OtherPart);
                FDocument.Parts.Add(NewPart);
              end else
                NewPart := SearchPart;
              // Создаем элемент заказа
              OrderItem := TOrderItem.Create(NewPart);
              OrderItem.OrderCount := SelectedOrder.Items[J].OrderCount;
              NewOrder.Add(OrderItem);
            end;
            // Добавляем заказ
            Result := FDocument.Orders.Add(NewOrder);
          end;
    end else
        MessageDlg(Translator.GetInstance.TranslateMessage(
          16, 'В этом файле нет заказов !'), mtWarning, [mbOk], 0);
  Loader.Destroy;
  OtherDocument.Destroy;
end;

procedure TOrderController.OrderAddExecute(Sender: TObject);
var
  SenderName: string;
  Mode, OrderInd: integer;
begin
  SenderName := TControl(Sender).Name;
  Mode := 1;
  if SenderName = 'OrderNewFromFile'  then Mode := 2;
  if SenderName = 'OrderNewFrom1CAndMultiple' then Mode := 3;
  OrderInd := -1;
  case Mode of
    1: OrderInd := Self.AddEmpty;
    2: OrderInd := Self.AddFromFile;
    3: OrderInd := Self.AddFrom1CAndMultiple;
  end;
  if (OrderInd >= 0) then begin
    frmOrders.RefreshTabs(Self);
    frmOrders.RefreshGrid(Self);
    frmOrders.ShowOrder(FDocument.Orders[OrderInd]);
    Self.ChangeModelEvent(True);
  end;
end;

procedure TOrderController.OrderRenameExecute(Sender: TObject);
var
  Title: string;
  Order: TOrder;
begin
  Order := frmOrders.CurrentOrder;
  Title := Self.GetNewOrderTitle(Order);
  if Length(Title) = 0 then Exit;
  Order.Title := Title;
  frmOrders.RefreshTabs(Self);
  frmOrders.ShowOrder(Order);
  frmContainers.RefreshGrid(Self);
  frmBox.RefreshGrid(Self);
  Self.ChangeModelEvent(False);
end;

procedure TOrderController.OrderConcateExecute(Sender: TObject);
var
  I: integer;
  Order: TOrder;
  ItemCount: Integer;
begin
  ItemCount := 0;
  if frmOrders.CurrentOrder = nil then Exit;
  frmSelectOrders.SetOrders(FDocument.Orders);
  if frmSelectOrders.ShowModal = mrOk then begin
    Order := frmOrders.CurrentOrder;
    for I := 0 to frmSelectOrders.chblOrders.Items.Count - 1 do
      if frmSelectOrders.chblOrders.Checked[I] then
        ItemCount := ItemCount + Order.AddFromOther(
          TOrder(frmSelectOrders.chblOrders.Items.Objects[I]));
    frmOrders.RefreshTabs(Self);
    frmOrders.RefreshGrid(Self);
    frmOrders.ShowOrder(Order);
    MessageDlg(Translator.GetInstance.TranslateMessage(
      18, 'Изменено / добавлено элементов'
      ) + ': ' + IntToStr(ItemCount), mtInformation, [mbOk], 0);
    Self.ChangeModelEvent(True);
  end;
end;

procedure TOrderController.OrderDeleteExecute(Sender: TObject);
var
  Text: string;
  Res: integer;
begin
  if frmOrders.CurrentOrder = nil then Exit;
  Text := Translator.GetInstance.TranslateMessage(
    19, 'Вы действительно хотите удалить заказ')
    + ' "' + frmOrders.CurrentOrder.Title + '" ?'
    + chr(13) + Translator.GetInstance.TranslateMessage(
    20, 'Все загруженные детали будут выгружены !');
  if MessageDlg(Text, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then begin
    // Выгружаем из контейнеров
    Res := FDocument.Containers.ExtractOrder(frmOrders.CurrentOrder);
    // Удаляем из редактируемой коробки
    frmBox.ExtractOrder(frmOrders.CurrentOrder);
    // Удаляем заказ из списка заказов
    FDocument.Orders.Extract(frmOrders.CurrentOrder);
    // Удаляем обхект
    frmOrders.CurrentOrder.Free;
    // Обновляем отображение
    frmOrders.RefreshTabs(Self);
    frmContainers.RefreshTabs(Self);
    frmBox.RefreshData(Self);
    frmInvoice.RefreshGrid(Self);

    Self.ChangeModelEvent(True);
    if Res > 0  then begin
      Text := Translator.GetInstance.TranslateMessage(
        21, 'Выгружено позиций')
        + ': ' + IntToStr(Res);
      MessageDlg(Text, mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TOrderController.OrderSaveTo1C(Sender: TObject);
var
  Saver: TDocSaver;
  SaveDlg: TOpenDialog;
begin
  if frmOrders.CurrentOrder = nil then Exit;
  SaveDlg := TSaveDialog.Create(nil);
  SaveDlg.Title := Translator.GetInstance.TranslateMessage(
    59, 'Укажите имя файла');
  SaveDlg.Filter := 'Text files|*.txt';
  SaveDlg.DefaultExt := '*.txt';
  if SaveDlg.Execute then begin
    Saver := TDocSaver.Create(SaveDlg.FileName);
    Saver.SaveOrderTo1C(frmOrders.CurrentOrder);
    Saver.Destroy;
  end;
end;

// Операции с элементом заказа

function TOrderController.AddNewOrderItem(Item: TOrderItem): TOrderItem;
var
  OrderItem: TOrderItem;
  Ind: integer;
begin
  // Проверяем осуществование детали в текущем заказе
  Ind := frmOrders.CurrentOrder.IndByCode(Item.Part.Code);
  if Ind < 0 then begin
    OrderItem := TOrderItem.Create(Item.Part);
    OrderItem.OrderCount := Item.OrderCount;
    frmOrders.CurrentOrder.Add(OrderItem);
  end else begin
    OrderItem := frmOrders.CurrentOrder.Items[Ind];
    OrderItem.OrderCount := OrderItem.OrderCount + Item.OrderCount;
  end;
  Result := OrderItem;
end;

procedure TOrderController.OrderAddPartExecute(Sender: TObject);
var
  SelectedParts: TObjectList;
  Item, NewItem: TOrderItem;
  I: integer;
begin
  if frmOrders.CurrentOrder = nil then Exit;
  SelectedParts := TObjectList.Create(False);
  if PartListForm.frmPartList.SelectFromPartsList(FDocument.Parts,
    SelectedParts, frmOrders.CurrentOrder) then
    if (SelectedParts.Count > 0) then begin
      NewItem := nil;
      for I := 0 to SelectedParts.Count - 1 do begin
        Item := TOrderItem(SelectedParts.Items[I]);
        NewItem := AddNewOrderItem(Item);
      end;
      frmOrders.RefreshGrid(Self);
      frmOrders.ShowOrderItem(NewItem);
      Self.ChangeModelEvent(True);
    end;
  SelectedParts.Free;
end;

procedure TOrderController.OrderAddPartFromFileExecute(Sender: TObject);
var
  SelectedParts: TObjectList;
  SelectedItem, NewItem: TOrderItem;
  I: integer;
  Loader: TDocLoader;
  SearchPart, NewPart: TPart;
  Parts: TPartList;
  FileName: string;
begin
  if frmOrders.CurrentOrder = nil then Exit;
  // Загружаем детали из внешнего файла
  FileName := Self.GetFileName;
  if Length(FileName) = 0 then Exit;
  Loader := TDocLoader.Create(FileName);
  Parts := TPartList.Create;
  if not Loader.GetPartListFrom1CFile(Parts) then begin
    Loader.Free;
    Parts.Free;
    Exit;
  end;
  // Выводи окно выбора детали
  SelectedParts := TObjectList.Create(False);
  if PartListForm.frmPartList.SelectFromPartsList(Parts, SelectedParts,
    frmOrders.CurrentOrder, FileName) then
    if (SelectedParts.Count > 0) then begin
      NewItem := nil;
      for I := 0 to SelectedParts.Count - 1 do begin
        // Проход по списку выбранных деталей
        SelectedItem := TOrderItem(SelectedParts.Items[I]);
        SearchPart := FDocument.Parts.Items[SelectedItem.Part.Code];
        // Проверяем наличие детали с таким кодом в текущем документа
        // Если детали нет - создаем ее
        if SearchPart = nil then begin
          NewPart := TPart.Create(SelectedItem.Part);
          FDocument.Parts.Add(NewPart);
        end else NewPart := SearchPart;
        SelectedItem.Part := NewPart;
        // Добавлякем деталь в текущий заказ
        NewItem := Self.AddNewOrderItem(SelectedItem);
      end;
      frmOrders.RefreshGrid(Self);
      frmOrders.ShowOrderItem(NewItem);
      Self.ChangeModelEvent(True);
    end;
  SelectedParts.Free;
  Parts.Free;
  Loader.Free;
end;

procedure TOrderController.OrderEditPartExecute(Sender: TObject);
var
  SelRow: integer;
begin
  if frmOrders.SelectItem = nil then Exit;
  frmOrders.grOrder.Options := frmOrders.grOrder.Options - [goEditing];
  //SelCol := frmOrders.grOrder.Selection.Left;
  SelRow := frmOrders.grOrder.Selection.Top;
  if frmPartEditor.EditPart(frmOrders.SelectItem.Part, Self.FDocument) <> nil then begin
    Self.RefreshAllGrids;
    frmOrders.grOrder.SelectCell(1, SelRow);
    Self.ChangeModelEvent(False);
  end;
end;

procedure TOrderController.OrderCopyPartExecute(Sender: TObject);
var
  LastOrderItem: TOrderItem;
  Msg: string;
begin
  LastOrderItem := frmPartEditor.CopyPart(frmOrders.SelectItem.Part, FDocument);
  if LastOrderItem <> nil then begin
    RefreshAllGrids;
    Msg := Translator.GetInstance.TranslateMessage(
      28, 'Показать деталь в последнем заказе') + ' ?';
    if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      frmOrders.ShowOrderItem(LastOrderItem);
    Self.ChangeModelEvent(True);
  end;
end;

procedure TOrderController.OrderDeletePartExecute(Sender: TObject);
var
  Text: string;
begin
  if frmOrders.SelectItem = nil then Exit;
  Text := Translator.GetInstance.TranslateMessage(
    22, 'Вы действительно хотите удалить из заказа деталь')
    + ' "' + frmOrders.SelectItem.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language) + '" ?'
    + chr(13) + Translator.GetInstance.TranslateMessage(
    23, 'Эта деталь будет выгружена из всех контейнеров !');
  if MessageDlg(Text, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then begin
    // Выгуражем из контейнеров
    FDocument.Containers.ExtractOrderItem(frmOrders.CurrentOrder, frmOrders.SelectItem);
    // Выгружаем из редактируемой коробки
    frmBox.ExtractOrderItem(frmOrders.CurrentOrder, frmOrders.SelectItem);
    // Удаляем из заказа
    frmOrders.CurrentOrder.Extract(frmOrders.SelectItem);
    // Уничтожаем объект
    frmOrders.SelectItem.Free;

    Self.RefreshAllGrids;
    Self.ChangeModelEvent(True);
  end;
end;

function TOrderController.SetOrderCount(Item: TOrderItem; Value: real; ARow: integer): boolean;
var
  Finder: TFindInShipment;
  LoadCount: real;
begin
  Result := False;
  if Value = Item.OrderCount then Exit;
  Item.OrderCount := Value;
  Finder := TFindInShipment.Create(FDocument);
  LoadCount := Finder.CountForOrder(frmOrders.CurrentOrder, Item.Part);
  Finder.Free;
  frmOrders.SetGridRowColor(LoadCount, Item.OrderCount, ARow );
  frmOrders.grOrder.Repaint;
  Result := True;
end;

function TOrderController.SetBoxCount(Item: TOrderItem; Value: real; ARow: integer): boolean;
begin
  Result := False;
  if Value = Item.Part.CountInBox then Exit;
  Item.Part.CountInBox := Value;
  frmPartProperty.RefreshGrid(Self);
  Result := True;
end;

procedure TOrderController.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Item: TOrderItem;
  NewValue: real;
  Update: boolean;
begin
  Item := TOrderItem(frmOrders.grOrder.Objects[1, ARow]);
  NewValue := StrToFloatDef(Value, 0);
  Update := False;
  if Item <> nil then begin
    case ACol of
      2: Update := Self.SetOrderCount(Item, NewValue, ARow);
      4: Update := Self.SetBoxCount(Item, NewValue, ARow);
    end;
  end;
  if NewValue <= 0 then frmOrders.grOrder.Cells[ACol, ARow] := '0';
  if Update then Self.ChangeModelEvent(False);
  
end;

// Поиск элемента заказа в конейтерах

procedure TOrderController.OrderSearchPartExecute(Sender: TObject);
begin
  if (frmOrders.CurrentOrder = nil) or (frmOrders.SelectItem = nil) then Exit;
  SearchForm.frmSearch.SearchOrderItem(frmOrders.CurrentOrder,
    frmOrders.SelectItem.Part);
end;

end.
