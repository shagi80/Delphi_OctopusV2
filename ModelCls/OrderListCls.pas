unit OrderListCls;

interface

uses
  SysUtils, Contnrs, OrderCls;

type

  {  ласс списка заказов.

    ћетоды Add и Insert обеспечивают добавление новых записей в структуру
    только после проверки отсутстви€ в структуре элемента с таким же
    TOrder.Title. ѕри наличии такой записи добавление не происходит. }

  TOrderList = class(TObjectList)
  private
    function GetOrderByTitle(title: string): TOrder;
  protected
    function GetItem(ind: integer): TOrder; overload;
    procedure SetItem(ind: integer; AObject: TOrder);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[ind: integer]: TOrder read GetItem write SetItem; default;
    property OrderByTitle[Title: string]: TOrder read GetOrderByTitle;
    function First: TOrder;
    function Last: TOrder;
    function Extract(Item: TObject): TOrder;
    function Add(newItem: TOrder): Integer;
    function IndByTitle(title: string): integer;
    procedure Insert(Index: Integer; newItem: TOrder);
  end;


implementation


constructor TOrderList.Create;
begin
  inherited Create(True);
end;

destructor TOrderList.Destroy;
begin
  inherited Destroy;
end;


function TOrderList.IndByTitle(title: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < self.Count) and (self.Items[i].Title <> title) do inc(i);
  if (i < self.Count) and (self.Items[i].Title = title) then
    Result := i;
end;

function TOrderList.GetItem(ind: Integer): TOrder;
begin
  Result := TOrder(inherited GetItem(ind));
end;

procedure TOrderList.SetItem(ind: Integer; AObject: TOrder);
begin
  inherited SetItem(ind, AObject);
end;

function TOrderList.GetOrderByTitle(Title: string): TOrder;
var
  Ind: integer;
begin
  Result := nil;
  Ind := Self.IndByTitle(Title);
  if Ind >= 0  then Result := Self.Items[Ind];
end;


function TOrderList.First: TOrder;
begin
  Result := TOrder(inherited First);
end;

function TOrderList.Last: TOrder;
begin
  Result := TOrder(inherited Last);
end;

function TOrderList.Extract(Item: TObject): TOrder;
begin
  Result := TOrder(inherited Extract(Item));
end;

function TOrderList.Add(newItem: TOrder): Integer;
begin
  Result := inherited Add(newItem)
end;

procedure TOrderList.Insert(Index: Integer; newItem: TOrder);
var
  ind: integer;
begin
  ind := IndByTitle(newItem.Title);
  if ind < 0 then inherited Insert(index, newItem)
    else raise EAbstractError.Create('Order title duplicated !');
end;

end.
