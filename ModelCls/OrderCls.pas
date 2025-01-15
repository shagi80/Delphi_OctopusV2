unit OrderCls;

interface

uses
  SysUtils, Contnrs, OrderItemCls;

type

  // Класс инфомрации о идничном заказе.
  // Методы Add и Insert обеспечивают добавление новых записей в структуру
  // только после проверки отсутствия в структуре элемента с таким же
  // TPart.Code. При наличии такой записи добавление не происходит -
  // суммируются занчения OrderCount.

  TOrder = class(TObjectList)
  private
    FTitle: string;
    FFixedTotalSupplierCost: real;
  protected
    function GetItem(ind: integer): TOrderItem; overload;
    procedure SetItem(ind: integer; AObject: TOrderItem);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Title: string read FTitle write FTitle;
    property FixedTotalSupplierCost: real read FFixedTotalSupplierCost
      write FFixedTotalSupplierCost;
    property Items[ind: integer]: TOrderItem read GetItem write SetItem; default;
    function First: TOrderItem;
    function Last: TOrderItem;
    function Extract(Item: TObject): TOrderItem;
    function Add(newItem: TOrderItem): Integer;
    function IndByCode(code: string): integer;
    procedure Insert(Index: Integer; newItem: TOrderItem);
    function AddFromOther(Source: TOrder): Integer;
  end;

implementation


constructor TOrder.Create;
begin
  inherited Create(True);
end;

destructor TOrder.Destroy;
begin
  inherited Destroy;
end;


function TOrder.GetItem(ind: Integer): TOrderItem;
begin
  Result := TOrderItem(inherited GetItem(ind));
end;

procedure TOrder.SetItem(ind: Integer; AObject: TOrderItem);
begin
  inherited SetItem(ind, AObject);
end;


function TOrder.First: TOrderItem;
begin
  Result := TOrderItem(inherited First);
end;

function TOrder.Last: TOrderItem;
begin
  Result := TOrderItem(inherited Last);
end;

function TOrder.Extract(Item: TObject): TOrderItem;
begin
  Result := TOrderItem(inherited Extract(Item));
end;

function TOrder.IndByCode(code: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < self.Count) and (self.Items[i].Part.Code <> code) do inc(i);
  if (i < self.Count) and (self.Items[i].Part.Code = code) then
    Result := i;
end;

function TOrder.Add(newItem: TOrderItem): Integer;
var
  index: integer;
begin
  index := IndByCode(newItem.Part.Code);
  if index >= 0 then begin
    Items[index].OrderCount := Items[index].OrderCount + newItem.OrderCount;
    Result := Index;
  end else Result := inherited Add(newItem);
end;

procedure TOrder.Insert(Index: Integer; newItem: TOrderItem);
var
  ind: integer;
begin
  ind := IndByCode(newItem.Part.Code);
  if ind >= 0 then
    Items[ind].OrderCount := Items[ind].OrderCount + newItem.OrderCount
  else inherited Insert(index, newItem);
end;


function TOrder.AddFromOther(Source: TOrder): Integer;
var
  I: integer;
  Item: TOrderItem;
begin
  for I := 0 to Source.Count - 1 do begin
    Item := TOrderItem.Create(Source.Items[I].Part);
    Item.OrderCount := Source.Items[I].OrderCount;
    Self.Add(Item);
  end;
  Result := Source.Count;
end;

end.
