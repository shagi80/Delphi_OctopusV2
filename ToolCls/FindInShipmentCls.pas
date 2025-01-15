unit FindInShipmentCls;

interface

uses
  OrderCls, PartCls, DocumentCls, OrderListCls, ContainerListCls, ContainerCls,
  BoxCls, OrderItemCls;

type
  TSearchResultItem = record
    Order: TOrder;
    OrderItem: TOrderItem;
    Container: TContainer;
    Box: TBox;
    Part: TPart;
    Count: real;
  end;

  TSearchResultList = array of TSearchResultItem;

  TSearchResult = class(TObject)
  private
    FItems: TSearchResultList;
    function GetCount: integer;
    function GetItem(Ind: integer): TSearchResultItem;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[Ind: integer]: TSearchResultItem read GetItem;
    property Count: integer read GetCount;
    procedure Add(Container: TContainer; Box: TBox; Part: TPart; Count: real); overload;
    procedure Add(Order: TOrder; OrderItem: TOrderItem; Count: real); overload;
  end;

  TFindInShipment = class(TObject)
  private
    FOrders: TOrderList;
    FContainer: TContainerList;
  public
    constructor Create(Document: TDocument);
    function CountForOrder(Order: TOrder; Part: TPart): real;
    function CountForOrderByTitle(OrderTitle, PartCode: string): real;
    function SearchForOrder(Order: TOrder; Part: TPart;
      var SearchResult: TSearchResult): boolean;
    function SearchPartInOrders(Part: TPart; var SearchResult: TSearchResult): boolean;
    function SearchPartInContainers(Part: TPart; var SearchResult: TSearchResult): boolean;
    function FindPartInOrder(Part: TPart; Order: TOrder): TOrderItem;
    function SearchTitleInOrders(Title: widestring; var SearchResult: TSearchResult;
      Language: integer): boolean;
    function SearchTitleInContainers(Title: widestring; var SearchResult: TSearchResult;
      Language: integer): boolean;
  end;

implementation

uses
  BoxItemCls, WideStrUtils, SysUtils, GlobalSettingsCls, Dialogs;

// Класс для хранения списка объектов - результат поиска

constructor TSearchResult.Create;
begin
  inherited Create;
  SetLength(Self.FItems, 0);
end;

destructor TSearchResult.Destroy;
begin
  SetLength(Self.FItems, 0);
  inherited Destroy;
end;

function TSearchResult.GetCount;
begin
  Result := High(Self.FItems) + 1;
end;

function TSearchResult.GetItem(Ind: Integer): TSearchResultItem;
begin
  Result := FItems[Ind];
end;

procedure TSearchResult.Add(Container: TContainer; Box: TBox; Part: TPart; Count: Real);
begin
  SetLength(Self.FItems, High(Self.FItems) + 2);
  Self.FItems[High(Self.FItems)].Order := nil;
  Self.FItems[High(Self.FItems)].Container := Container;
  Self.FItems[High(Self.FItems)].Box := Box;
  Self.FItems[High(Self.FItems)].Part := Part;
  Self.FItems[High(Self.FItems)].Count := Count;
end;

procedure TSearchResult.Add(Order: TOrder; OrderItem: TOrderItem; Count: Real);
begin
  SetLength(Self.FItems, High(Self.FItems) + 2);
  Self.FItems[High(Self.FItems)].Order := Order;
  Self.FItems[High(Self.FItems)].OrderItem := OrderItem;
  Self.FItems[High(Self.FItems)].Container := nil;
  Self.FItems[High(Self.FItems)].Box := nil;
  Self.FItems[High(Self.FItems)].Part := OrderItem.Part;
  Self.FItems[High(Self.FItems)].Count := Count;
end;

// Класс - инструмент поиска

constructor TFindInShipment.Create(Document: TDocument);
begin
  inherited Create;
  FContainer := Document.Containers;
  FOrders := Document.Orders;
end;

// Поиск детали в заказе

function TFindInShipment.FindPartInOrder(Part: TPart; Order: TOrder): TOrderItem;
var
  I: integer;
begin
  Result := nil;
  for I := 0 to Order.Count - 1 do
    if Order.Items[I].Part = Part then begin
      Result := Order.Items[I];
      Exit;
    end;
end;

// Подсчет количества элемента заказа

function TFindInShipment.CountForOrder(Order: TOrder; Part: TPart): real;
var
  ContInd, BoxInd, ItemInd: integer;
  Sum: real;
  BoxItem: TBoxItem;
begin
  Sum := 0;
  for ContInd := 0 to FContainer.Count - 1 do
    for BoxInd := 0 to FContainer.Items[ContInd].Count - 1 do
      for ItemInd := 0 to FContainer.Items[ContInd].Items[BoxInd].Count - 1 do begin
        BoxItem := FContainer.Items[ContInd].Items[BoxInd].Items[ItemInd];
        if ((Order = nil) or (BoxItem.Order = Order)) and (BoxItem.Part = Part) then
          Sum := Sum + BoxItem.OrderCount;
      end;
  Result := Sum;
end;

function TFindInShipment.CountForOrderByTitle(OrderTitle, PartCode: string): real;
var
  ContInd, BoxInd, ItemInd: integer;
  Sum: real;
  BoxItem: TBoxItem;
begin
  Sum := 0;
  for ContInd := 0 to FContainer.Count - 1 do
    for BoxInd := 0 to FContainer.Items[ContInd].Count - 1 do
      for ItemInd := 0 to FContainer.Items[ContInd].Items[BoxInd].Count - 1 do begin
        BoxItem := FContainer.Items[ContInd].Items[BoxInd].Items[ItemInd];
        if ((Length(OrderTitle) = 0) or (BoxItem.Order.Title = OrderTitle))
          and (BoxItem.Part.Code = PartCode) then
            Sum := Sum + BoxItem.OrderCount;
      end;
  Result := Sum;
end;

// Поиск элемента заказа в контейнерах

function TFindInShipment.SearchForOrder(Order: TOrder; Part: TPart;
      var SearchResult: TSearchResult): boolean;
var
  ContInd, BoxInd, ItemInd: integer;
  BoxItem: TBoxItem;
begin
  for ContInd := 0 to FContainer.Count - 1 do
    for BoxInd := 0 to FContainer.Items[ContInd].Count - 1 do
      for ItemInd := 0 to FContainer.Items[ContInd].Items[BoxInd].Count - 1 do begin
        BoxItem := FContainer.Items[ContInd].Items[BoxInd].Items[ItemInd];
        if (BoxItem.Order = Order) and (BoxItem.Part = Part) then
          SearchResult.Add(FContainer.Items[ContInd],
            FContainer.Items[ContInd].Items[BoxInd],
            BoxItem.Part,
            BoxItem.OrderCount);
      end;
  Result := (SearchResult.Count > 0);
end;

// Поиск детали в заказах и в контейнерах

function TFindInShipment.SearchPartInOrders(Part: TPart;
      var SearchResult: TSearchResult): boolean;
var
  OrderInd, ItemInd: integer;
  OrderItem: TOrderItem;
begin
  for OrderInd := 0 to FOrders.Count - 1 do
    for ItemInd := 0 to FOrders.Items[OrderInd].Count - 1 do begin
      OrderItem := FOrders.Items[OrderInd].Items[ItemInd];
      if (OrderItem.Part = Part) then
        SearchResult.Add(FOrders.Items[OrderInd], OrderItem, OrderItem.OrderCount);
    end;
  Result := (SearchResult.Count > 0);
end;

function TFindInShipment.SearchPartInContainers(Part: TPart;
      var SearchResult: TSearchResult): boolean;
var
  ContInd, BoxInd, ItemInd: integer;
  BoxItem: TBoxItem;
begin
  for ContInd := 0 to FContainer.Count - 1 do
    for BoxInd := 0 to FContainer.Items[ContInd].Count - 1 do
      for ItemInd := 0 to FContainer.Items[ContInd].Items[BoxInd].Count - 1 do begin
        BoxItem := FContainer.Items[ContInd].Items[BoxInd].Items[ItemInd];
        if (BoxItem.Part = Part) then
          SearchResult.Add(FContainer.Items[ContInd],
            FContainer.Items[ContInd].Items[BoxInd],
            BoxItem.Part,
            BoxItem.OrderCount);
      end;
  Result := (SearchResult.Count > 0);
end;

//  Поиск детали по наименованию в заказах и в контейнерах

function TFindInShipment.SearchTitleInOrders(Title: widestring;
      var SearchResult: TSearchResult; Language: integer): boolean;
var
  OrderInd, ItemInd: integer;
  OrderItem: TOrderItem;
  IsSearch: boolean;
begin
  for OrderInd := 0 to FOrders.Count - 1 do
    for ItemInd := 0 to FOrders.Items[OrderInd].Count - 1 do begin
      OrderItem := FOrders.Items[OrderInd].Items[ItemInd];
      IsSearch := False;
      case Language of
        0: IsSearch := ((pos(WideUpperCase(Title), WideUpperCase(OrderItem.Part.RusName)) > 0)
          or (pos(WideUpperCase(Title), WideUpperCase(OrderItem.Part.ShortTitle)) > 0));
        1: IsSearch := (pos(WideUpperCase(Title), WideUpperCase(OrderItem.Part.EngName)) > 0);
        2: IsSearch := (pos(WideUpperCase(Title), WideUpperCase(OrderItem.Part.ChinName)) > 0);
      end;
      if IsSearch then
        SearchResult.Add(FOrders.Items[OrderInd], OrderItem, OrderItem.OrderCount);
    end;
  Result := (SearchResult.Count > 0);
end;

function TFindInShipment.SearchTitleInContainers(Title: widestring;
      var SearchResult: TSearchResult; Language: integer): boolean;
var
  ContInd, BoxInd, ItemInd: integer;
  BoxItem: TBoxItem;
  IsSearch: boolean;
begin
  for ContInd := 0 to FContainer.Count - 1 do
    for BoxInd := 0 to FContainer.Items[ContInd].Count - 1 do
      for ItemInd := 0 to FContainer.Items[ContInd].Items[BoxInd].Count - 1 do begin
        BoxItem := FContainer.Items[ContInd].Items[BoxInd].Items[ItemInd];
        IsSearch := False;
        case Language of
          0: IsSearch := (pos(WideUpperCase(Title), WideUpperCase(BoxItem.Part.RusName)) > 0)
            or (pos(WideUpperCase(Title), WideUpperCase(BoxItem.Part.ShortTitle)) > 0);
          1: IsSearch := (pos(WideUpperCase(Title), WideUpperCase(BoxItem.Part.EngName)) > 0);
          2: IsSearch := (pos(WideUpperCase(Title), WideUpperCase(BoxItem.Part.ChinName)) > 0);
        end;
        if IsSearch then
          SearchResult.Add(FContainer.Items[ContInd],
            FContainer.Items[ContInd].Items[BoxInd],
            BoxItem.Part, BoxItem.OrderCount);
      end;
  Result := (SearchResult.Count > 0);
end;

end.
