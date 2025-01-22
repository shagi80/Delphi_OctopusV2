unit ContainerControllerCls;

interface

uses
  DocumentCls, OrderCls, PartListCls, OrderItemCls, PartCls, ContainerCls,
  BoxItemCls, BoxCls, DragObjectCls;

type
  TOnChangeModel = procedure (Sender: TObject; UpdateInterface: boolean) of object;

  TContainerController = class(TObject)
  private
    FDocument: TDocument;
    FOnChangeModel: TOnChangeModel;
    FAddItem: TOrderItem;
    FRecipientBox: TBox;
    FSeparateBox: boolean;
    procedure ChangeModelEvent(UpdateInterface: boolean);
    function SetNewContainerProperty(Container: TContainer): boolean;
    procedure AddSelectItem(Sender: TObject);
    procedure AddSelectAndMarkItems(Sender: TObject);
    procedure AddItemPopupPrepare(X, Y: integer);
    procedure AfterAddItems(Sender: TObject; PackWeight: real);
    procedure ChageItemCount(NewValue: real; ARow: integer; Box: TBox; Item: TBoxItem);
    procedure ChangeBoxCount(NewValue: real; ARow: integer; Box: TBox);
    procedure ChangeGrossWeight(NewValue: real; ARow: integer; Box: TBox);
    procedure ChangePackWeight(NewValue: real; ARow: integer; Box: TBox);
  public
    constructor Create(Document: TDocument);
    property OnChangeModel: TOnChangeModel read FOnChangeModel write FOnChangeModel;
    procedure ContainerAdd(Sender: TObject);
    procedure ContainerEdit(Sender: TObject);
    procedure ContainerDelete(Sender: TObject);
    procedure ContainerAddAiiInOne(Sender: TObject);
    procedure ContainerAddSeparately(Sender: TObject);
    procedure ContainerLoadInBox(Sender: TObject);
    procedure ContainerEditBox(Sender: TObject);
    procedure ContainerUnloadFromBox(Sender: TObject);
    procedure ContainerDeleteBox(Sender: TObject);
    procedure SearchPart(Sender: TObject);
    procedure ContainerDblClick(Column: integer);
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
    procedure OnDragDrop(Sender: TObject; DragObject: TOrderDragObject;
      RecepientBox: TBox; Separate: boolean = False);
    procedure ContainerAddInOneSelect(Sender: TObject);
    procedure ContainerAddInOneMark(Sender: TObject);
    procedure ContainerChangeGross(Sender: TObject);
  end;

implementation

uses
  Classes, Grids, Dialogs, OrdersForm, InputForm, TranslatorCls,
  GlobalSettingsCls, DocLoaderCls, SysUtils, Controls, Forms,
  BoxForm, ContainerForm, PartEditorForm, PartPropertyForm, InvoiceForm,
  PartListForm, Contnrs,  SearchForm, ContainerEditForm,
  FindInShipmentCls, Types, Windows, GrossManagerCls, GrossWeightSettingsForm;

constructor TContainerController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FAddItem := nil;
  FRecipientBox := nil;
  FSeparateBox := False;
end;

procedure TContainerController.ChangeModelEvent(UpdateInterface: Boolean);
begin
  if Assigned(Self.FOnChangeModel) then
    Self.FOnChangeModel(Self, UpdateInterface);
end;

function TContainerController.SetNewContainerProperty(Container: TContainer): boolean;
var
  Title, Text: string;
  Gross, Volume: real;
  SearchContainer: TContainer;
begin
  Result := False;
  Title := Container.Title;
  Gross := Container.MaxWeight;
  Volume := Container.MaxVolume;
  repeat
    if not frmContainerEdit.EditContainer(Title, Gross, Volume) then Exit;
    SearchContainer := FDocument.Containers.ContainerByTitle[Title];
    if (SearchContainer = nil) or (SearchContainer = Container) then Break;
    Text := Translator.GetInstance.TranslateMessage(
      84, 'Контейнер с таким номером уже существует') + ' !';
    MessageDlg(Text, mtWarning, [mbOk], 0);
  until False;
  Container.Title := Title;
  Container.MaxWeight := Gross;
  Container.MaxVolume := Volume;
  Result := True;
end;

// Добавление в контейнер.

procedure TContainerController.AddSelectItem(Sender: TObject);
var
  BoxItem: TBoxItem;
  Finder: TFindInShipment;
  Count, PackWeight: real;
begin
  if (frmOrders.CurrentOrder = nil) or (Self.FAddItem = nil) then Exit;
  BoxItem := TBoxItem.Create(frmOrders.CurrentOrder, Self.FAddItem.Part);
  // Высчитываем незагруженное количество
  Finder := TFindInShipment.Create(Self.FDocument);
  Count := Finder.CountForOrder(frmOrders.CurrentOrder, Self.FAddItem.Part);
  Finder.Free;
  Count := FAddItem.OrderCount - Count;
  if Count <= 0 then Count := 1;
  BoxItem.OrderCount := Count;
  // Если целевая коробка Nil создаем ее
  if FRecipientBox = nil then begin
    FRecipientBox := TBox.Create;
    FRecipientBox.BoxCode := FDocument.GetNewBoxNumber;
    frmContainers.CurrentContainer.Add(FRecipientBox);
  end;
  PackWeight := FRecipientBox.PackageWeight;
  // Если добавляется первый элемент в группу считаем кол-во коробок
  if (FAddItem.Part.CountInBox > 0) and (FAddItem.Part.CountInBox < Count) then
    if ((Sender <> nil) or ((Sender = nil) and (Self.FSeparateBox)))
     and (FRecipientBox.Count = 0) then begin
      FRecipientBox.BoxCount := trunc(count / FAddItem.Part.CountInBox);
      BoxItem.OrderCount := FRecipientBox.BoxCount * FAddItem.Part.CountInBox;
     end;
  FRecipientBox.Add(BoxItem);
  if Sender <> nil then  Self.AfterAddItems(Self, PackWeight);
end;

procedure TContainerController.AddSelectAndMarkItems(Sender: TObject);
var
  BoxItem: TBoxItem;
  OrdersObjects: TObjectList;
  I: Integer;
  Finder: TFindInShipment;
  Count, PackWeight: real;
  OrderItem: TOrderItem;
  NewBox: TBox;
begin
  if (frmOrders.CurrentOrder = nil) or (Self.FAddItem = nil) then Exit;
  if FRecipientBox = nil then PackWeight := 0
    else PackWeight := FRecipientBox.PackageWeight;
  OrdersObjects := TObjectList.Create(False);
  Self.AddSelectItem(nil);
  frmOrders.grOrder.GetSelectedObjects(1, OrdersObjects);
  if OrdersObjects.Count > 0 then
    for I := 0 to OrdersObjects.Count - 1 do
      if (OrdersObjects[I] <> Self.FAddItem ) then begin
        OrderItem := TOrderItem(OrdersObjects[I]);
        BoxItem := TBoxItem.Create(frmOrders.CurrentOrder, OrderItem.Part);
        // Высчитываем незагруженное количество
        Finder := TFindInShipment.Create(Self.FDocument);
        Count := Finder.CountForOrder(frmOrders.CurrentOrder, OrderItem.Part);
        Finder.Free;
        Count := OrderItem.OrderCount - Count;
        if Count <= 0 then Count := 1;
        BoxItem.OrderCount := Count;
        // Добавляем элемент в коробку.
        if not FSeparateBox then FRecipientBox.Add(BoxItem)
          else begin
            NewBox := TBox.Create;
            NewBox.BoxCode := FDocument.GetNewBoxNumber;
            NewBox.Add(BoxItem);
            // Cчитаем кол-во коробок
            if (BoxItem.Part.CountInBox > 0) and (BoxItem.Part.CountInBox < Count) then begin
              NewBox.BoxCount := trunc(BoxItem.OrderCount / BoxItem.Part.CountInBox);
              BoxItem.OrderCount := NewBox.BoxCount * BoxItem.Part.CountInBox;
            end;
            frmContainers.CurrentContainer.Add(NewBox);
            Self.FRecipientBox := NewBox;
          end;
      end;
  Self.AfterAddItems(Self, PackWeight);
  OrdersObjects.Free;
end;

procedure TContainerController.AddItemPopupPrepare(X, Y: integer);
var
  OrdersObjects: TObjectList;
  pt: TPoint;
begin
  OrdersObjects := TObjectList.Create(False);
  frmOrders.grOrder.GetSelectedObjects(1, OrdersObjects);
  if OrdersObjects.Count = 0 then begin
    Self.AddSelectItem(Self);
    Exit;
  end;
  frmContainers.miSelAndMark.Caption := Translator.GetInstance.TranslateMessage(
    93, '- выбрвнный и отмеченные')
    + ' (' + IntToStr(OrdersObjects.Count) + ')';
  frmContainers.miOnlySet.OnClick := Self.AddSelectItem;
  frmContainers.miSelAndMark.OnClick := Self.AddSelectAndMarkItems;
  if X = -1 then begin
    GetCursorPos(pt);
    frmContainers.pmAddItem.Popup(pt.X, pt.Y);
  end else frmBox.pmAddItem.Popup(X, Y);
  OrdersObjects.Free;
end;

procedure TContainerController.AfterAddItems(Sender: TObject; PackWeight: real);
begin
  if GlobalSettings.GetInstance.FixBoxPackWeightForChange then
    Self.FRecipientBox.SetTotalGrossByOneBoxPack(PackWeight);
  frmContainers.RefreshGrid(Self);
  frmContainers.ShowBox(Self.FRecipientBox);
  frmOrders.grOrder.UnselectAll;
  frmOrders.RefreshGrid(Self);
  FAddItem := nil;
  FRecipientBox := nil;
  FSeparateBox := False;
  if Assigned(FOnChangeModel) then FOnChangeModel(Self, True);
end;

// Изменения в таблице.

procedure TContainerController.ChageItemCount(NewValue: real; ARow: integer;
  Box: TBox; Item: TBoxItem);
var
  PackWeight: real;
begin
  PackWeight := Box.PackageWeight;
  Item.OrderCount := NewValue;
  if (GlobalSettings.GetInstance.FixBoxPackWeightForChange) then begin
    Box.SetTotalGrossByOneBoxPack(PackWeight);
    frmContainers.grContainer.Cells[8, ARow] := FloatToStr(Box.GroupGrossWeight);
  end else
    frmContainers.grContainer.Cells[9, ARow] := FloatToStr(Box.PackageWeight);
  frmContainers.grContainer.Cells[7, ARow] := FloatToStr(Box.GroupNetWeight);
  frmContainers.grContainer.Cells[10, ARow] := FloatToStr(Box.Volume);
  if Item.Order = frmOrders.CurrentOrder then frmOrders.RefreshGrid(Self);
end;

procedure TContainerController.ChangeBoxCount(NewValue: real; ARow: integer;
  Box: TBox);
var
  PackWeight: real;
begin
  PackWeight := Box.PackageWeight;
  Box.BoxCount := trunc(NewValue);
  if (GlobalSettings.GetInstance.FixBoxPackWeightForChange) then begin
    Box.SetTotalGrossByOneBoxPack(PackWeight);
    frmContainers.grContainer.Cells[8, ARow] := FloatToStr(Box.GroupGrossWeight);
  end else
    frmContainers.grContainer.Cells[9, ARow] := FloatToStr(Box.PackageWeight);
  frmContainers.grContainer.Cells[7, ARow] := FloatToStr(Box.GroupNetWeight);
  frmContainers.grContainer.Cells[10, ARow] := FloatToStr(Box.Volume);
end;

procedure TContainerController.ChangeGrossWeight(NewValue: real; ARow: integer;
  Box: TBox);
begin
  Box.GroupGrossWeight := NewValue;
  frmContainers.grContainer.Cells[9, ARow] := FloatToStr(Box.PackageWeight);
  frmContainers.grContainer.Cells[10, ARow] := FloatToStr(Box.Volume);
end;

procedure TContainerController.ChangePackWeight(NewValue: real; ARow: integer;
  Box: TBox);
begin
  Box.SetTotalGrossByOneBoxPack(NewValue);
  frmContainers.grContainer.Cells[8, ARow] := FloatToStr(Box.GroupGrossWeight);
  frmContainers.grContainer.Cells[10, ARow] := FloatToStr(Box.Volume);
end;

// Операции с контйнерами

procedure TContainerController.ContainerAdd(Sender: TObject);
var
  Container: TContainer;
begin
  Container := TContainer.Create;
  Container.Title := FDocument.GetNewContainerTitle;
  Container.MaxWeight := GlobalSettings.GetInstance.DefContainerGross;
  Container.MaxVolume := GlobalSettings.GetInstance.DefContainerVolume;
  if not Self.SetNewContainerProperty(Container) then begin
    Container.Free;
    Exit;
  end;
  FDocument.Containers.Add(Container);
  frmContainers.RefreshTabs(Self);
  frmContainers.ShowContainer(Container);
  Self.ChangeModelEvent(True);
end;

procedure TContainerController.ContainerEdit(Sender: TObject);
var
  Container: TContainer;
begin
  if frmContainers.CurrentContainer = nil then Exit;
  Container := frmContainers.CurrentContainer;
  if not Self.SetNewContainerProperty(Container) then Exit;
  frmContainers.RefreshTabs(Self);
  frmContainers.RefreshSumPanel(Self);
  Self.ChangeModelEvent(False);
end;

procedure TContainerController.ContainerDelete(Sender: TObject);
var
  Container: TContainer;
  Text: string;
begin
  if frmContainers.CurrentContainer = nil then Exit;
  Container := frmContainers.CurrentContainer;
  Text := Translator.GetInstance.TranslateMessage(
    90, 'Вы действительно хотите удалить контейнер')
    + ' "' + Container.Title + '" ?';
  if MessageDlg(Text, mtConfirmation, [mbYes, mbNo] , 0) <> mrYes then Exit;
  frmBox.Box := nil;
  FDocument.Containers.Extract(Container);
  Container.Free;
  frmContainers.RefreshTabs(Self);
  frmOrders.RefreshGrid(Self);
  frmInvoice.RefreshGrid(Self);
  Self.ChangeModelEvent(True);
end;

procedure TContainerController.SearchPart(Sender: TObject);
begin
  if (frmContainers.CurrentContainer = nil) or (frmContainers.SelectBoxItem = nil) then Exit;
  SearchForm.frmSearch.SearchBoxItem(frmContainers.SelectBoxItem);
end;

procedure TContainerController.ContainerChangeGross(Sender: TObject);
var
  GrossManager: TGrossManager;
  NewGross: real;
  Mode: integer;
begin
  if (frmContainers.CurrentContainer = nil)
    and (frmContainers.CurrentContainer.RealGrossWeight = 0) then Exit;
  GrossManager := TGrossManager.Create(frmContainers.CurrentContainer);
  {Text := Translator.GetInstance.TranslateMessage(
    102, 'Укажите требуемый вес брутто');
  NewGross := frmContainers.CurrentContainer.RealGrossWeight;
  if not frmInput.GetReal(Text, NewGross, True) then Exit; }
  NewGross := 0;
  Mode := frmGrossWeightSettings.GetNewGross(frmContainers.CurrentContainer,
    NewGross);
  if Mode = 0 then Exit;
  case Mode of
    1: NewGross := GrossManager.DistributeByPackWeight(NewGross);
    2: NewGross := GrossManager.DistributeByMinPackWeight(
        GlobalSettings.GetInstance.MinPackWeight, NewGross);
  end;
  if NewGross > 0 then begin
    if frmBox.Visible then frmBox.Box := nil;
    frmContainers.RefreshGrid(Self);
    frmInvoice.RefreshGrid(Self);
    ChangeModelEvent(False);
  end else
    MessageDlg(Translator.GetInstance.TranslateMessage(
      106, 'Ошибка пересчета - нулевой коэффициент') + '', mtWarning, [mbOk], 0);
  GrossManager.Free;
end;

// Операции с коробками

procedure TContainerController.ContainerDblClick(Column: integer);
begin
  if frmBox.Visible then Exit;
  if frmContainers.SelectBox = nil then Exit;
  frmBox.Left := trunc((Screen.Width - frmBox.Width) / 2);
  frmBox.Top := trunc((Screen.Height - frmBox.Height) / 2);
  frmBox.Box := frmContainers.SelectBox;
  frmBox.ShowModal;
  frmBox.Box := nil;
end;

procedure TContainerController.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Item: TBoxItem;
  Box: TBox;
  NewValue, OldValue: real;
  Text: string;
  BoxRow: integer;
begin
  BoxRow := Integer(frmContainers.grContainer.Objects[3, ARow]);
  if (ACol <> 5) and (BoxRow <> ARow) then begin
    frmContainers.grContainer.Cells[ACol, ARow] := '';
    Exit;
  end;
  Box := TBox(frmContainers.grContainer.Objects[1, ARow]);
  Item := TBoxItem(frmContainers.grContainer.Objects[2, ARow]);
  if (Item <> nil) and (Box <> nil) then begin
    NewValue := StrToFloatDef(Value, 0);
    OldValue := 0;
    case ACol of
      5: OldValue := Item.OrderCount;
      6: OldValue := Box.BoxCount;
      8: OldValue := Box.GroupGrossWeight;
      9: OldValue := Box.PackageWeight;
    end;
    if NewValue = OldValue then Exit;
    if NewValue <= 0 then begin
      frmContainers.grContainer.Cells[ACol, ARow] := FloatToStr(OldValue);
      Text := Translator.GetInstance.TranslateMessage(
        2, 'Значение не может быть нулем и меньше нуля !',);
      MessageDlg(Text, mtWarning, [mbOk], 0);
      Exit;
    end;
    case ACol of
      5: Self.ChageItemCount(NewValue,
        Integer(frmContainers.grContainer.Objects[3, ARow]), Box, Item);
      6: Self.ChangeBoxCount(NewValue, ARow, Box);
      8: Self.ChangeGrossWeight(NewValue, ARow, Box);
      9: Self.ChangePackWeight(NewValue, ARow, Box);
    end;
    if ACol <> 5 then frmContainers.SetRowMark(Box, ARow)
      else frmContainers.SetRowMark(Box,
        Integer(frmContainers.grContainer.Objects[3, ARow]));
    frmContainers.grContainer.Repaint;
    if Assigned(FOnChangeModel) then FOnChangeModel(Self, True);
  end;
end;

procedure TContainerController.OnDragDrop(Sender: TObject; DragObject: TOrderDragObject;
      RecepientBox: TBox; Separate: boolean = False);
begin
  if (Sender = nil) or (DragObject = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := RecepientBox;
  Self.FSeparateBox := Separate;
  Self.AddItemPopupPrepare(-1, -1);
end;

procedure TContainerController.ContainerAddAiiInOne(Sender: TObject);
begin
  if (frmContainers.CurrentContainer = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := nil;
  Self.FSeparateBox := False;
  Self.AddItemPopupPrepare(-1, -1);
end;

procedure TContainerController.ContainerAddSeparately(Sender: TObject);
begin
  if (frmContainers.CurrentContainer = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := nil;
  Self.FSeparateBox := True;
  Self.AddItemPopupPrepare(-1, -1);
end;

procedure TContainerController.ContainerLoadInBox(Sender: TObject);
begin
  if (frmContainers.SelectBox = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := frmContainers.SelectBox;
  Self.FSeparateBox := False;
  Self.AddItemPopupPrepare(-1, -1);
end;

procedure TContainerController.ContainerEditBox(Sender: TObject);
begin
  ContainerDblClick(1);
end;

procedure TContainerController.ContainerUnloadFromBox(Sender: TObject);
var
  Text: string;
begin
  if (frmContainers.SelectBox = nil) or (frmContainers.SelectBoxItem = nil) then Exit;
  Text := Translator.GetInstance.TranslateMessage(
    99, 'Вы действительно хотите удалить эту деталь из коробки') + ' ?';
  if MessageDlg(Text, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit;
  frmContainers.SelectBox.Extract(frmContainers.SelectBoxItem);
  frmContainers.SelectBoxItem.Free;
  if (frmContainers.SelectBox.Count = 0) then begin
    if frmBox.ParentBox = frmContainers.SelectBox then frmBox.Box := nil;
    frmContainers.CurrentContainer.Extract(frmContainers.SelectBox);
    frmContainers.SelectBox.Free;
  end;
  frmOrders.RefreshGrid(Self);
  frmContainers.RefreshGrid(Self);
  if Assigned(FOnChangeModel) then FOnChangeModel(Self, True);
end;

procedure TContainerController.ContainerDeleteBox(Sender: TObject);
var
  Text: string;
begin
  if (frmContainers.SelectBox = nil) then Exit;
  Text := Translator.GetInstance.TranslateMessage(
    8, 'Вы действительно хотите удалить эту группу коробок ?');
  if MessageDlg(Text, mtWarning, [mbOk, mbCancel], 0) <> mrOk then Exit;
  if frmBox.ParentBox = frmContainers.SelectBox then frmBox.Box := nil;
  frmContainers.CurrentContainer.Extract(frmContainers.SelectBox);
  frmContainers.SelectBox.Free;
  frmOrders.RefreshGrid(Self);
  frmContainers.RefreshGrid(Self);
  if Assigned(FOnChangeModel) then FOnChangeModel(Self, True);
end;

procedure TContainerController.ContainerAddInOneSelect(Sender: TObject);
begin
  if (frmContainers.SelectBox = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := frmContainers.SelectBox;
  Self.FSeparateBox := False;
  Self.AddSelectItem(Self);
end;

procedure TContainerController.ContainerAddInOneMark(Sender: TObject);
begin
  if (frmContainers.SelectBox = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.FRecipientBox := frmContainers.SelectBox;
  Self.FSeparateBox := False;
  Self.AddSelectAndMarkItems(Self);
end;


end.
