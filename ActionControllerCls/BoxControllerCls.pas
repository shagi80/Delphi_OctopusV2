unit BoxControllerCls;

interface

uses
  DocumentCls, BoxCls, DragObjectCls, OrderItemCls, BoxItemCls, OrderCls,
  Contnrs, Types;

type
  TOnChangeModel = procedure (Sender: TObject; UpdateInterface: boolean) of object;

  TBoxController = class(TObject)
  private
    FDocument: TDocument;
    FOnChangeModel: TOnChangeModel;
    FAddItem: TOrderItem;
    function AddBox: Tbox;
    function ChangeBox: TBox;
    function Save(DoUpdate: boolean): boolean;
    procedure AddSelectItem(Sender: TObject);
    procedure AddSelectAndMarkItems(Sender: TObject);
    procedure AddItemPopupPrepare(X, Y: integer);
    procedure AfterAddItems(Sender: TObject);
    function CheckModify: boolean;
  public
    constructor Create(Document: TDocument);
    property OnChangeModel: TOnChangeModel write FOnChangeModel;
    procedure BoxNew(Sender: TObject);
    procedure BoxNewAndLoadPart(Sender: TObject);
    procedure BoxLoadPart(Sender: TObject);
    procedure BoxLoadPartAuto(Sender: TObject);
    procedure BoxSaveInContainer(Sender: TObject);
    procedure BoxUnloadPart(Sender: TObject);
    procedure BoxDelete(Sender: TObject);
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
    procedure OnDragDrop(Sender: TObject; DragObject: TOrderDragObject);
  end;

implementation

uses
  BoxForm, OrdersForm, Dialogs, TranslatorCls, GlobalSettingsCls, Controls,
  ContainerCls, ContainerForm, SysUtils, BoxItemAddForm, Windows,
  FindInShipmentCls, BoxAutoCreateForm;


constructor TBoxController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FAddItem := nil;
end;

function TBoxController.AddBox: TBox;
var
  Text: string;
  NewBox, Box: TBox;
  Container: TContainer;
begin
  Result := nil;
  Container := frmContainers.CurrentContainer;
  Box := frmBox.Box;
  Text := Translator.GetInstance.TranslateMessage(
    6, 'Добавить новую группу коробок в контейнер')
    + ' "' + frmContainers.CurrentContainer.Title + '" ?';
  if not (MessageDlg(Text, mtWarning, [mbOk, mbCancel], 0) = mrOk) then Exit;
  if (FDocument.Containers.SearchBox(Box.BoxCode) <> nil) then begin
    Text := Translator.GetInstance.TranslateMessage(
      7, 'Группа с таким кодом уже существует !');
    MessageDlg(Text, mtWarning, [mbOk], 0);
    Exit;
  end;
  NewBox := TBox.Create;
  NewBox.Copy(Box);
  Container.Add(NewBox);
  //frmBox.ParentBox := NewBox;
  frmBox.Box := NewBox;
  Result := NewBox;
end;

function TBoxController.ChangeBox: TBox;
var
  Text: string;
  ParentBox, Box, SearchBox: TBox;
begin
  Result := nil;
  Box := frmBox.Box;
  ParentBox := frmBox.ParentBox;
  SearchBox := FDocument.Containers.SearchBox(Box.BoxCode);
  if (SearchBox <> nil) and(SearchBox <> ParentBox) then begin
    Text := Translator.GetInstance.TranslateMessage(
      7, 'Группа с таким кодом уже существует !');
    MessageDlg(Text, mtWarning, [mbOk], 0);
    Exit;
  end;
  ParentBox.Copy(Box);
  frmBox.Modified := False;
  Result := ParentBox;
end;

function TBoxController.Save(DoUpdate: boolean): boolean;
var
  NewBox: TBox;
  Text: string;
begin
  Result := False;
  if Length(frmBox.Box.BoxCode) = 0 then begin
    Text := Translator.GetInstance.TranslateMessage(
      3, 'Коробка должна иметь номер !');
    MessageDlg(Text, mtWarning, [mbOk], 0);
    Exit;
  end;
  if frmBox.ParentBox = nil then NewBox := Self.AddBox
    else NewBox := Self.ChangeBox;
  if (DoUpdate) and (NewBox <> nil) then begin
    frmContainers.RefreshGrid(Self);
    frmContainers.ShowBox(NewBox);
    frmOrders.RefreshGrid(Self);
    if Assigned(Self.FOnChangeModel) then FOnChangeModel(Self, True);
  end;
  Result := (NewBox <> nil);
end;

procedure TBoxController.AddSelectItem(Sender: TObject);
var
  BoxItem: TBoxItem;
  Finder: TFindInShipment;
  Count: real;
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
  // Если добавляется первый элемент в группу считаем кол-во коробок
  if (frmBox.Box.Count = 0) and (Sender <> nil)
     and (FAddItem.Part.CountInBox > 0) and (FAddItem.Part.CountInBox < Count) then
      frmBox.Box.BoxCount := trunc(count / FAddItem.Part.CountInBox);
  frmBox.Box.Add(BoxItem);
  if Sender <> nil then  Self.AfterAddItems(Self);
end;

procedure TBoxController.AddSelectAndMarkItems(Sender: TObject);
var
  BoxItem: TBoxItem;
  OrdersObjects: TObjectList;
  I: Integer;
  Finder: TFindInShipment;
  Count: real;
  OrderItem: TOrderItem;
begin
  if (frmOrders.CurrentOrder = nil) or (Self.FAddItem = nil) then Exit;
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
        frmBox.Box.Add(BoxItem);
      end;
  Self.AfterAddItems(Self);
  OrdersObjects.Free;
end;

procedure TBoxController.AddItemPopupPrepare(X, Y: integer);
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
  frmBox.miSelAndMark.Caption := Translator.GetInstance.TranslateMessage(
    93, '- выбрвнный и отмеченные')
    + ' (' + IntToStr(OrdersObjects.Count) + ')';
  frmBox.miOnlySet.OnClick := Self.AddSelectItem;
  frmBox.miSelAndMark.OnClick := Self.AddSelectAndMarkItems;
  if X = -1 then begin
    GetCursorPos(pt);
    frmBox.pmAddItem.Popup(pt.X, pt.Y);
  end else frmBox.pmAddItem.Popup(X, Y);
  OrdersObjects.Free;
end;

procedure TBoxController.AfterAddItems(Sender: TObject);
begin
  if (frmBox.rbtnPackWeight.Checked) then
    frmBox.Box.SetTotalGrossByOneBoxPack(
      StrToFloatDef(frmBox.edPackWeight.Text, 0));
  frmBox.RefreshData(Self);
  frmBox.Modified := True;
  Self.FAddItem := nil;
  frmOrders.grOrder.UnselectAll;
  frmOrders.grOrder.Repaint;
end;

function TBoxController.CheckModify: boolean;
var
  Mode: integer;
  Text: string;
begin
  Result := True;
  Text := Translator.GetInstance.TranslateMessage(
    4, 'Вы уже работаете с группой коробок')
    + ' "' + frmBox.Box.BoxCode + '".' + chr(13) +
    Translator.GetInstance.TranslateMessage(
      5, 'Сохранить изменения в этой группе в контейнере ?');
  if frmBox.Modified then begin
    Mode := MessageDlg(Text, mtWarning, [mbYes, mbNo, mbCancel], 0);
    case Mode of
      mrYes: Result := Self.Save(False);
      mrNo: ;
      mrCancel: Result :=  False;
    end;
  end;
end;

//

procedure TBoxController.BoxNew(Sender: TObject);
begin
  if Self.CheckModify then frmBox.Box := nil;
end;

procedure TBoxController.BoxNewAndLoadPart(Sender: TObject);
var
  Pt: TPoint;
begin
  if (frmOrders.CurrentOrder = nil) or (frmOrders.SelectItem = nil) then Exit;
  if Self.CheckModify then begin
    frmBox.Box := nil;
    Self.FAddItem := frmOrders.SelectItem;
    Pt.X := frmBox.btnNewBoxAndLoad.Left + trunc(frmBox.btnNewBoxAndLoad.Width / 2);
    Pt.Y := frmBox.btnNewBoxAndLoad.Top + trunc(frmBox.btnNewBoxAndLoad.Height / 2);
    Pt := frmBox.ClientToScreen(Pt);
    AddItemPopupPrepare(Pt.X, Pt.Y);
  end;
end;

procedure TBoxController.BoxLoadPart(Sender: TObject);
begin
  if (frmOrders.CurrentOrder = nil) or (frmOrders.SelectItem = nil) then Exit;
  Self.FAddItem := frmOrders.SelectItem;
  Self.AddItemPopupPrepare(-1, -1);
end;

procedure TBoxController.BoxLoadPartAuto(Sender: TObject);
var
  SelectedItem: TObjectList;
  Box: TBox;
begin
  if (frmOrders.CurrentOrder = nil) or (frmOrders.SelectItem = nil)
    or (frmContainers.CurrentContainer = nil ) then Exit;
  if Self.CheckModify then begin
    SelectedItem := TObjectList.Create(False);
    frmOrders.grOrder.GetSelectedObjects(1, SelectedItem);
    if SelectedItem.Count = 0 then begin
      frmBox.Box := nil;
      Self.FAddItem := frmOrders.SelectItem;
      Self.AddSelectItem(Self);
      Self.Save(True);
      Exit;
    end;
    if frmBoxAutoCreate.CreateBoxes(frmOrders.CurrentOrder, SelectedItem,
      frmContainers.CurrentContainer) then begin
        frmOrders.RefreshGrid(Self);
        frmContainers.RefreshGrid(Self);
        Box := frmContainers.CurrentContainer.Last;
        frmContainers.ShowBox(Box);
        frmBox.Box := Box;
      end;
    SelectedItem.Free;
  end;
end;

procedure TBoxController.BoxSaveInContainer(Sender: TObject);
begin
  Self.Save(True);
end;

procedure TBoxController.BoxUnloadPart(Sender: TObject);
begin
  if (frmBox.Box <> nil) and (frmBox.SelectItem <> nil) then begin
    frmBox.Box.Remove(frmBox.SelectItem);
    frmBox.RefreshData(Self);
    frmBox.Modified := True;
  end;
end;

procedure TBoxController.BoxDelete(Sender: TObject);
var
  Text: string;
  ContInd, BoxInd: integer;
  Container: TContainer;
begin
  if frmBox.ParentBox <> nil then begin
    Text := Translator.GetInstance.TranslateMessage(
      8, 'Вы действительно хотите удалить эту группу коробок ?');
    if MessageDlg(Text, mtWarning, [mbOk, mbCancel], 0) = mrOk then begin
      for ContInd := 0 to FDocument.Containers.Count - 1 do begin
        Container := FDocument.Containers.Items[ContInd];
        BoxInd := Container.IndexOf(frmBox.ParentBox);
        if BoxInd >= 0 then begin
          Container.Delete(BoxInd);
          frmContainers.ShowContainer(Container);
          frmOrders.RefreshGrid(Self);
          if Assigned(Self.FOnChangeModel) then FOnChangeModel(Self, True);
          Break;
        end;
      end;
    end else Exit;
  end;
  frmBox.Box := nil;
end;

procedure TBoxController.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Item: TBoxItem;
  NewValue: real;
  Text: string;
begin
  Item := TBoxItem(frmBox.grBox.Objects[1, ARow]);
  if Item <> nil then begin
    NewValue := StrToFloatDef(Value, 0);
    if NewValue = Item.OrderCount then Exit;
    if NewValue <= 0 then begin
      frmBox.grBox.Cells[ACol, ARow] := FloatToStr(Item.OrderCount);
      Text := Translator.GetInstance.TranslateMessage(
        2, 'Значение не может быть нулем и меньше нуля !',);
      MessageDlg(Text, mtWarning, [mbOk], 0);
      Exit;
    end;
    Item.OrderCount := NewValue;
    frmBox.Modified := True;
    if (frmBox.rbtnPackWeight.Checked) then
      frmBox.Box.SetTotalGrossByOneBoxPack(
        StrToFloatDef(frmBox.edPackWeight.Text, 0));
    frmBox.RefreshData(Self);
  end;
end;

procedure TBoxController.OnDragDrop(Sender: TObject; DragObject: TOrderDragObject);
begin
  if (Sender = nil) or (DragObject = nil) then Exit;
  if (Sender is TfrmBox) then begin
    Self.FAddItem := frmOrders.SelectItem;
    Self.AddItemPopupPrepare(-1, -1);
  end;
end;

end.
