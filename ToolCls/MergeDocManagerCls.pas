unit MergeDocManagerCls;

interface

uses
  DocumentCls, PartListCls, OrderListCls, ContainerListCls, ContainerCls,
  OrderCls;

type
  TOrderStorageRec = record
    OldOrder: TOrder;
    NewOrder: TOrder;
  end;

  TOrderStorage = array of TOrderStorageRec;

  TMergeDocManager = class(TObject)
  private
    FDocument: TDocument;
    FOrderStorage: TOrderStorage;
    procedure UniqueOrderTitle(Order: TOrder);
    procedure CopyParts(Parts: TPartList);
    procedure CopyOrders(Orders: TOrderList);
    procedure CopyContainers(Containers: TContainerList;
      TargetContainer: TContainer);
    function MergeWith1C(FileName: string): boolean;
    function MergeWithOctopus(FileName: string; TargetContainer: TContainer): boolean;
    function GetNewOrder(OldOrder: TOrder): TOrder;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    function Merge(FileName: string; TargetContainer: TContainer): boolean;
  end;

implementation

uses
  SysUtils, DocLoaderCls, BoxCls, SelectOrdersForm, PartCls, OrderItemCls,
  Dialogs, Forms, Classes, Controls, BoxItemCls, MergeFileSettingsForm;


constructor TMergeDocManager.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  SetLength(FOrderStorage, 0);
end;

destructor TMergeDocManager.Destroy;
begin
  FDocument := nil;
  SetLength(FOrderStorage, 0);
  inherited Destroy;
end;

procedure TMergeDocManager.UniqueOrderTitle(Order: TOrder);
var
  SearchOrder: TOrder;
begin
  if FDocument.Orders.Count = 0 then Exit;
  repeat
    SearchOrder := FDocument.Orders.OrderByTitle[Order.Title];
    if (SearchOrder = nil) then Break;
    Order.Title := Order.Title + '_1';
  until False;
end;

function TMergeDocManager.GetNewOrder(OldOrder: TOrder): TOrder;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to High(Self.FOrderStorage) do
    if FOrderStorage[I].OldOrder = OldOrder then begin
      Result := FOrderStorage[I].NewOrder;
      Exit;
    end;
end;


procedure TMergeDocManager.CopyParts(Parts: TPartList);
var
  I: integer;
  Part: TPart;
begin
  for I := 0 to Parts.Count - 1 do begin
    Part := FDocument.Parts.Items[Parts.Items[I].Code];
    if Part = nil then begin
      Part := TPart.Create(Parts.Items[I]);
      FDocument.Parts.Add(Part);
    end;
  end;
end;

procedure TMergeDocManager.CopyOrders(Orders: TOrderList);
var
  J, I: integer;
  Order: TOrder;
  NewOrder: TOrder;
  Part: TPart;
  NewOrderItem: TOrderItem;
begin
  SetLength(FOrderStorage, 0);
  SetLength(FOrderStorage, Orders.Count);
  for J := 0 to Orders.Count - 1 do begin
    Order := Orders.Items[J];
    NewOrder := TOrder.Create;
    NewOrder.Title := Order.Title;
    UniqueOrderTitle(NewOrder);
    for I := 0 to Order.Count - 1 do begin
      Part := FDocument.Parts.Items[Order.Items[I].Part.Code];
      NewOrderItem := TOrderItem.Create(Part);
      NewOrderItem.OrderCount := Order.Items[I].OrderCount;
      NewOrder.Add(NewOrderItem);
    end;
    FDocument.Orders.Add(NewOrder);
    FOrderStorage[J].OldOrder := Order;
    FOrderStorage[J].NewOrder := NewOrder;
  end;
end;

procedure TMergeDocManager.CopyContainers(Containers: TContainerList;
      TargetContainer: TContainer);
var
  ContInd, BoxInd, ItemInd: Integer;
  Container, NewContainer: TContainer;
  Box, NewBox: TBox;
  Item, NewItem: TBoxItem;
  Part: TPart;
  Order: TOrder;
begin
  NewContainer := nil;
  for ContInd := 0 to Containers.Count - 1 do begin
    Container := Containers.Items[ContInd];
    if TargetContainer = nil then begin
      NewContainer := TContainer.Create;
      NewContainer.Title := Container.Title;
      while FDocument.Containers.ContainerByTitle[NewContainer.Title] <> nil do
        NewContainer.Title := NewContainer.Title + '_1';
      NewContainer.MaxWeight := Container.MaxWeight;
      NewContainer.MaxVolume := Container.MaxVolume;
    end;
    for BoxInd := 0 to Container.Count - 1 do begin
      Box := Container.Items[BoxInd];
      NewBox := TBox.Create;
      NewBox.BoxCode := Box.BoxCode;
      while FDocument.Containers.SearchBox(NewBox.BoxCode) <> nil do
        NewBox.BoxCode := NewBox.BoxCode + '_1';
      NewBox.BoxCount := Box.BoxCount;
      NewBox.GroupGrossWeight := Box.GroupGrossWeight;
      for ItemInd := 0 to Box.Count - 1 do begin
        Item := Box.Items[ItemInd];
        Part := FDocument.Parts.Items[Item.Part.Code];
        Order := Self.GetNewOrder(Item.Order);
        NewItem := TBoxItem.Create(Order, Part);
        NewItem.OrderCount := Item.OrderCount;
        NewBox.Add(NewItem);
      end;
      if NewContainer <> nil then NewContainer.Add(NewBox)
        else if TargetContainer <> nil then TargetContainer.Add(NewBox);
    end;
    if NewContainer <> nil then FDocument.Containers.Add(NewContainer);
  end;
end;


function TMergeDocManager.MergeWith1C(FileName: string): boolean;
var
  Loader: TDocLoader;
  Container: TContainer;
  NewOrder: TOrder;
begin
  Result := False;
  Loader := TDocLoader.Create(FileName);
  NewOrder := TOrder.Create;
  if Loader.LoadOrderFrom1C(NewOrder, FDocument) then begin
    Container := nil;
    if not frmMergeFileSettings.GetSettings(NewOrder, nil, Container, FileName) then begin
      NewOrder.Free;
      Exit;
    end;
    Result := True;
    UniqueOrderTitle(NewOrder);
    FDocument.Orders.Add(NewOrder);
    if FDocument.Containers.Count = 0 then begin
      Container := TContainer.Create;
      Container.Title := FDocument.GetNewContainerTitle;
      FDocument.Containers.Add(Container);
    end;
  end else NewOrder.Free;
end;

function TMergeDocManager.MergeWithOctopus(FileName: string;
  TargetContainer: TContainer): boolean;
var
  NewDocument: TDocument;
  Container: TContainer;
begin
  Result := False;
  NewDocument := TDocument.Create;
  if not NewDocument.LoadFromFile(FileName) then begin
    NewDocument.Free;
    Exit;
  end;
  //
  if not frmMergeFileSettings.GetSettings(NewDocument.Orders,
    NewDocument.Containers, TargetContainer, FileName) then begin
      NewDocument.Free;
      Exit;
    end;
  //
  if NewDocument.Parts.Count > 0 then CopyParts(NewDocument.Parts);
  if NewDocument.Orders.Count > 0 then CopyOrders(NewDocument.Orders);
  if NewDocument.Containers.Count > 0 then CopyContainers(NewDocument.Containers, TargetContainer);
  //
  if (FDocument.Orders.Count > 0) and (FDocument.Containers.Count = 0) then begin
    Container := TContainer.Create;
    Container.Title := FDocument.GetNewContainerTitle;
    FDocument.Containers.Add(Container);
  end;
  NewDocument.Free;
  Result := True;
end;

function TMergeDocManager.Merge(FileName: string; TargetContainer: TContainer): boolean;
var
  Loader: TDocLoader;
begin
  Result := False;
  if not FileExists(FileName) then Exit;
  Loader := TDocLoader.Create(FileName);
  if Loader.FileIs1C then Result := Self.MergeWith1C(FileName)
    else Result := Self.MergeWithOctopus(FileName, TargetContainer);
  Loader.Free;
end;

end.
