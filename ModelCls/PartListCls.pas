unit PartListCls;

interface

uses
   SysUtils, Contnrs, PartCls;

type

  //  ласс списка деталей.
  // ѕерегружаемое свойство Items обеспечивает доступ по индексу
  // и по полю Code класса TPart

  TPartList = class(TObjectList)
  protected
    function GetIndexByCode(code: string): integer;
    function GetItem(Index: Integer): TPart; overload;
    procedure SetItem(Index: Integer; AObject: TPart); overload;
    function GetItem(code: string): TPart; overload;
    procedure SetItem(code: string; AObject: TPart);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[code: string]: TPart read GetItem write SetItem; default;
    property Items[Index: Integer]: TPart read GetItem write SetItem; default;
    function First: TPart;
    function Last: TPart;
    function Extract(Item: TObject): TPart;
    function Add(newPart: TPart): Integer;
    procedure Insert(Index: Integer; newPart: TPart);
  end;


implementation

constructor TPartList.Create;
begin
  inherited Create(True);
end;

destructor TPartList.Destroy;
begin
  inherited Destroy;
end;

function TPartList.GetIndexByCode(code: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < self.Count) and
    (TPart(inherited Items[i]).Code <> code) do inc(i);
  if (i < self.Count) and
    (TPart(inherited Items[i]).Code = code) then
      Result := i;
end;

function TPartList.GetItem(Index: Integer): TPart;
begin
  Result := TPart(inherited GetItem(Index));
end;

procedure TPartList.SetItem(Index: Integer; AObject: TPart);
begin
  inherited SetITem(Index, AObject);
end;

function TPartList.GetItem(code: string): TPart;
var
  index: integer;
begin
  index := GetIndexByCode(code);
  if index >= 0  then Result := TPart(inherited GetItem(index))
    else Result := nil;
end;

procedure TPartList.SetItem(code: string; AObject: TPart);
var
  index: integer;
begin
  index := GetIndexByCode(code);
  if index >= 0  then inherited SetITem(index, AObject)
    else raise EAccessViolation.Create('Item code out of list !');
end;

function TPartList.First: TPart;
begin
  Result := TPart(inherited First);
end;

function TPartList.Last: TPart;
begin
  Result := TPart(inherited Last);
end;

function TPartList.Extract(Item: TObject): TPart;
begin
  Result := TPart(inherited Extract(Item));
end;

function TPartList.Add(newPart: TPart): integer;
begin
  if GetIndexByCode(newPart.Code) < 0 then Result := inherited Add(newPart)
    else raise EAbstractError.Create('Part code duplicate !');
end;

procedure TpartList.Insert(Index: Integer; newPart: TPart);
begin
  if GetIndexByCode(newPart.Code) < 0 then inherited Insert(Index, newPart)
    else raise EAbstractError.Create('Part code duplicate !');
end;

end.

