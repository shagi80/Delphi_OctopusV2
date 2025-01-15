unit ContainerListCls;

interface

uses
  SysUtils, Contnrs, ContainerCls, BoxCls, OrderCls, OrderItemCls;

type

  // Класс списка контейнеров.
  // Методы Add и Insert обеспечивают добавление новых записей в структуру
  // только после проверки отсутствия в структуре элемента с таким же
  // Title. При наличии такой записи добавление не происходит.

  TContainerList = class(TObjectList)
  private
    function GetContainerByTitle(Title: string): TContainer;
    function IndByTitle(title: string): integer;
  protected
    function GetItem(ind: integer): TContainer; overload;
    procedure SetItem(ind: integer; AObject: TContainer);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[ind: integer]: TContainer read GetItem write SetItem; default;
    property ContainerByTitle[Title: string]: TContainer read GetContainerByTitle;
    function First: TContainer;
    function Last: TContainer;
    function Extract(Item: TObject): TContainer;
    function Add(newItem: TContainer): Integer;
    procedure Insert(Index: Integer; newItem: TContainer);
    function SearchBox(Number: string): TBox;
    function ExtractOrder(Order: TOrder): integer;
    function ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem): integer;
  end;


implementation

uses
  BoxItemCls;


constructor TContainerList.Create;
begin
  inherited Create(True);
end;

destructor TContainerList.Destroy;
begin
  inherited Destroy;
end;


function TContainerList.GetItem(ind: Integer): TContainer;
begin
  Result := TContainer(inherited GetItem(ind));
end;

procedure TContainerList.SetItem(ind: Integer; AObject: TContainer);
begin
  inherited SetItem(ind, AObject);
end;

function TContainerList.GetContainerByTitle(Title: string): TContainer;
var
  Ind: integer;
begin
  Result := nil;
  Ind := Self.IndByTitle(Title);
  if Ind >= 0  then Result := Self.Items[Ind];
end;


function TContainerList.First: TContainer;
begin
  Result := TContainer(inherited First);
end;

function TContainerList.Last: TContainer;
begin
  Result := TContainer(inherited Last);
end;

function TContainerList.Extract(Item: TObject): TContainer;
begin
  Result := TContainer(inherited Extract(Item));
end;

function TContainerList.IndByTitle(title: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < self.Count) and (self.Items[i].Title <> title) do inc(i);
  if (i < self.Count) and (self.Items[i].Title = title) then
    Result := i;
end;

function TContainerList.Add(newItem: TContainer): Integer;
var
  index: integer;
begin
  index := IndByTitle(newItem.Title);
  if index < 0 then Result := inherited Add(newItem)
    else raise EAbstractError.Create('Container title duplicated !');
end;

procedure TContainerList.Insert(Index: Integer; newItem: TContainer);
var
  ind: integer;
begin
  ind := IndByTitle(newItem.Title);
  if ind < 0 then inherited Insert(index, newItem)
    else raise EAbstractError.Create('Container title duplicated !');
end;


function TContainerList.SearchBox(Number: string): TBox;
var
  I, Ind: integer;
begin
  Result := nil;
  for I := 0 to Self.Count - 1 do begin
    Ind := Self.Items[I].IndByCode(Number);
    if Ind >= 0 then begin
      Result := Self.Items[I].Items[Ind];
      Exit;
    end;
  end;
end;

function TContainerList.ExtractOrder(Order: TOrder): integer;
var
  ContInd, BoxInd: integer;
  Box: TBox;
begin
  Result := 0;
  for ContInd := 0 to Self.Count - 1 do begin
    BoxInd := 0;
    while BoxInd < Self.Items[ContInd].Count do begin
      Box := Self.Items[ContInd].Items[BoxInd];
      Result := Result + Box.ExtractOrder(Order);
      if Box.Count = 0 then Self.Items[ContInd].Delete(BoxInd)
        else inc(BoxInd);
    end;
  end;
end;

function TContainerList.ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem): integer;
var
  ContInd, BoxInd: integer;
  Box: TBox;
begin
  Result := 0;
  for ContInd := 0 to Self.Count - 1 do begin
    BoxInd := 0;
    while BoxInd < Self.Items[ContInd].Count do begin
      Box := Self.Items[ContInd].Items[BoxInd];
      Result := Result + Box.ExtractOrderItem(Order, OrderItem);
      if Box.Count = 0 then Self.Items[ContInd].Delete(BoxInd)
        else inc(BoxInd);
    end;
  end;
end;

end.
