unit ContainerCls;

interface

uses
  SysUtils, Contnrs, Classes, BoxCls;

type

  //  ласс контейнера (группа коробок).
  // ћетоды Add, Insert и SetItem провер€ют существование коробки с таким же
  // Code перед выполнением. ‘актические веса и обхем - расчетные величины.

  TContainer = class(TObjectList)
  private
    FTitle: string;
    FMaxWeight: real;
    FMaxVolume: real;
    function GetRealNetWeight: real;
    function GetRealGrossWeight: real;
    function GetRealVolume: real;
    function GetTotalBoxCount: integer;
  protected
    function GetItem(ind: integer): TBox; overload;
    procedure SetItem(ind: integer; AObject: TBox);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[ind: integer]: TBox read GetItem write SetItem; default;
    function First: TBox;
    function Last: TBox;
    function Extract(Item: TObject): TBox;
    function Add(newItem: TBox): Integer;
    function IndByCode(boxCode: string): integer;
    procedure Insert(Index: Integer; newItem: TBox);
    property Title: string read FTitle write FTitle;
    property MaxWeight: real read FMaxWeight write FMaxWeight;
    property MaxVolume: real read FMaxVolume write FMaxVolume;
    property RealNetWeight: real read GetRealNetWeight;
    property RealGrossWeight: real read GetRealGrossWeight;
    property RealVolume: real read GetRealVolume;
    property TotalBoxCount: integer read GetTotalBoxCount;
  end;

implementation

uses
  Math, GlobalSettingsCls;

constructor TContainer.Create;
begin
  inherited Create(True);
end;

destructor TContainer.Destroy;
begin
  inherited Destroy;
end;

function TContainer.IndByCode(boxCode: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i <  self.Count) and (Items[i].BoxCode <> boxCode) do inc(i);
  if (i <  self.Count) and (Items[i].BoxCode = boxCode) then Result := i;
end;

function TContainer.GetRealNetWeight: real;
var
  i: integer;
  net: real;
begin
  net := 0;
  for I := 0 to self.Count - 1 do net := net + Items[i].GroupNetWeight;
  Result := SimpleRoundTo(net, -GlobalSettings.GetInstance.WeightAccuracy);
end;

function TContainer.GetRealGrossWeight: real;
var
  i: integer;
  net: real;
begin
  net := 0;
  for I := 0 to self.Count - 1 do net := net + Items[i].GroupGrossWeight;
  Result := SimpleRoundTo(net, -GlobalSettings.GetInstance.WeightAccuracy);
end;

function TContainer.GetRealVolume: real;
var
  i: integer;
  vol: real;
begin
  vol := 0;
  for I := 0 to self.Count - 1 do vol := vol + Items[i].Volume;
  Result := SimpleRoundTo(vol, -GlobalSettings.GetInstance.VolumeAccuracy);
end;

function TContainer.GetItem(ind: Integer): TBox;
begin
  Result := TBox(inherited GetItem(ind));
end;

procedure TContainer.SetItem(ind: Integer; AObject: TBox);
begin
  if self.IndByCode(AObject.BoxCode) < 0 then
    inherited SetItem(ind, AObject)
  else raise EAccessViolation.Create('Box code duplicate !');
end;

function TContainer.First: TBox;
begin
  Result := TBox(inherited First);
end;

function TContainer.Last: TBox;
begin
  Result := TBox(inherited Last);
end;

function TContainer.Extract(Item: TObject): TBox;
begin
  Result := TBox(inherited Extract(Item));
end;

function TContainer.Add(newItem: TBox): Integer;
var
  ind: integer;
begin
  ind := self.IndByCode(newItem.BoxCode);
  if ind < 0 then Result := inherited Add(newItem) else Result :=-1;
end;

procedure TContainer.Insert(Index: Integer; newItem: TBox);
var
  ind: integer;
begin
  ind := self.IndByCode(newItem.BoxCode);
  if ind < 0 then inherited Insert(index, newItem)
    else raise EAccessViolation.Create('Box code duplicate !');
end;

function TContainer.GetTotalBoxCount: integer;
var
  I, Count: integer;
begin
  Count := 0;
  for I := 0 to self.Count - 1 do Count := Count + Items[I].BoxCount;
  Result := Count;
end;

end.
