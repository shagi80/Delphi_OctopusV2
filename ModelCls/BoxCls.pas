unit BoxCls;

interface

uses
  SysUtils, Contnrs, BoxItemCls, OrderCls, OrderItemCls;

type

  // Класс единичной коробки.
  // Методы Add и Insert обеспечивают добавление новых записей в структуру
  // только после проверки отсутствия в структуре элемента с таким же
  // Part и таким же Order. При наличии такой записи добавление
  // не происходит - суммируется количество в поле OrderCount.
  // Вес нетто и обхем - расчетный величины (prop NetWeigth и Volume).

  TBox = class(TObjectList)
  private
    FBoxCode: string;
    FGrossWeight: real;
    FBoxCount: integer;
    function IndexOf(box: TBoxItem): integer;
    function GetNetWeight: real;
    function GetVolume: real;
    function CheckMultipart: boolean;
    function GetPackWeight: real;
    function GetOneBoxGrossWeight: real;
    function GetOneBoxNetWeight: real;
  protected
    function GetItem(ind: integer): TBoxItem; overload;
    procedure SetItem(ind: integer; AObject: TBoxItem);  overload;
  public
    constructor Create;
    destructor Destroy; override;
    property Items[ind: integer]: TBoxItem read GetItem write SetItem; default;
    function First: TBoxItem;
    function Last: TBoxItem;
    function Extract(Item: TObject): TBoxItem;
    function Add(newItem: TBoxItem): Integer;
    procedure Insert(Index: Integer; newItem: TBoxItem);
    procedure Copy(Box: TBox);
    procedure ClearBox;
    property BoxCode: string read FBoxCode write FBoxCode;
    property GroupGrossWeight: real read FGrossWeight write FGrossWeight;
    property BoxCount: integer read FBoxCount write FBoxCount;
    property GroupNetWeight: real read GetNetWeight;
    property Volume: real read GetVolume;
    property IsMultipart: boolean read CheckMultipart;
    property PackageWeight: real read GetPackWeight;
    property OneBoxGrossWeight: real read GetOneBoxGrossWeight;
    property OneBoxNetWeight: real read GetOneBoxNetWeight;
    function ExtractOrder(Order: TOrder): integer;
    function ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem): integer;
    procedure SetTotalGrossByOneBoxGross(OneBoxGross: real);
    procedure SetTotalGrossByOneBoxPack(OneBoxPack: real);
  end;

implementation

uses
  Math, GlobalSettingsCls, Dialogs;

constructor TBox.Create;
begin
  inherited Create(True);
  Self.FBoxCount := 1;
  Self.FBoxCode := '';
end;

destructor TBox.Destroy;
begin
  inherited Destroy;
end;


function TBox.IndexOf(box: TBoxItem): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < self.Count) do begin
    if (Items[i].Part = box.Part) and (Items[i].Order = box.Order) then begin
      Result := i;
      Break;
    end;
    inc(i);
  end;
end;

function TBox.GetItem(ind: Integer): TBoxItem;
begin
  Result := TBoxItem(inherited GetItem(ind));
end;

procedure TBox.SetItem(ind: Integer; AObject: TBoxItem);
begin
  inherited SetItem(ind, AObject);
end;

function TBox.GetNetWeight: real;
var
  i: integer;
  net: real;
begin
  if Self = nil then begin
    Result := 0;
    Exit;
  end;
  net := 0;
  for I := 0 to self.Count - 1 do
    if Items[i].Part.NetUnit then
      net := net + Items[i].OrderCount * Items[i].Part.NetCoefficient
    else
      net := net + Items[i].OrderCount * Items[i].Part.Weight;
  Result := SimpleRoundTo(net, -GlobalSettings.GetInstance.WeightAccuracy);
end;

function TBox.GetVolume: real;
var
  i: integer;
  vol: real;
begin
  vol := 0;
  for I := 0 to self.Count - 1 do
    vol := vol + Items[i].OrderCount * Items[i].Part.Volume;
  Result := SimpleRoundTo(vol, -GlobalSettings.GetInstance.VolumeAccuracy);
end;

function TBox.CheckMultipart: boolean;
begin
  Result := (self.Count > 1);
end;

function TBox.GetPackWeight: real;
var
  PackageWeight: real;
begin
  PackageWeight := (FGrossWeight - Self.GetNetWeight) / FBoxCount;
  Result := SimpleRoundTo(
    PackageWeight,
    -GlobalSettings.GetInstance.WeightAccuracy);
end;

function TBox.GetOneBoxGrossWeight: real;
var
  OneBoxWeight: real;
begin
  OneBoxWeight := FGrossWeight / FBoxCount;
  Result := SimpleRoundTo(
    OneBoxWeight,
    -GlobalSettings.GetInstance.WeightAccuracy);
end;

function TBox.GetOneBoxNetWeight: real;
var
  OneBoxWeight: real;
begin
  OneBoxWeight := Self.GetNetWeight / FBoxCount;
  Result := SimpleRoundTo(
    OneBoxWeight,
    -GlobalSettings.GetInstance.WeightAccuracy);
end;


function TBox.First: TBoxItem;
begin
  Result := TBoxItem(inherited First);
end;

function TBox.Last: TBoxItem;
begin
  Result := TBoxItem(inherited Last);
end;

function TBox.Extract(Item: TObject): TBoxItem;
begin
  Result := TBoxItem(inherited Extract(Item));
end;

function TBox.Add(newItem: TBoxItem): Integer;
var
  ind: integer;
begin
  ind := self.IndexOf(newItem);
  if ind >= 0 then begin
    Items[ind].OrderCount := Items[ind].OrderCount + newItem.OrderCount;
    Result := ind;
  end else Result := inherited Add(newItem);
end;

procedure TBox.Insert(Index: Integer; newItem: TBoxItem);
var
  ind: integer;
begin
  ind := IndexOf(newItem);
  if ind < 0 then inherited Insert(index, newItem)
    else raise EAbstractError.Create('Box code duplicated !');
end;


procedure Tbox.Copy(Box: TBox);
var
  I: integer;
  BoxItem: TBoxItem;
begin
  if Box = nil then Exit;
  Self.FBoxCode := Box.FBoxCode;
  Self.FGrossWeight := Box.FGrossWeight;
  Self.FBoxCount := Box.FBoxCount;
  Self.Clear;
  for I := 0 to Box.Count - 1 do begin
    BoxItem := TBoxItem.Create(Box.Items[I].Order, Box.Items[I].Part);
    BoxItem.OrderCount := Box.Items[I].OrderCount;
    Self.Add(BoxItem);
  end;
end;

procedure TBox.ClearBox;
begin
  Self.Clear;
  FBoxCode := '';
  FBoxCount := 1;
  FGrossWeight := 0;
  FGrossWeight := 0;
end;

function TBox.ExtractOrder(Order: TOrder): integer;
var
  ItemInd: integer;
  BoxItem: TBoxItem;
begin
  Result := 0;
  ItemInd := 0;
  while ItemInd < Self.Count do begin
    BoxItem := Self.Items[ItemInd];
    if BoxItem.Order = Order then begin
      Self.Delete(ItemInd);
      inc(Result);
    end else inc(ItemInd);
  end;
end;

function TBox.ExtractOrderItem(Order: TOrder; OrderItem: TOrderItem): integer;
var
  ItemInd: integer;
  BoxItem: TBoxItem;
begin
  Result := 0;
  ItemInd := 0;
  while ItemInd < Self.Count do begin
    BoxItem := Self.Items[ItemInd];
    if (BoxItem.Order = Order) and (BoxItem.Part = OrderItem.Part) then begin
      Self.Delete(ItemInd);
      inc(Result);
    end else inc(ItemInd);
  end;
end;

procedure TBox.SetTotalGrossByOneBoxGross(OneBoxGross: real);
begin
  Self.FGrossWeight := Self.FBoxCount * OneBoxGross;
  Self.FGrossWeight := SimpleRoundTo(Self.FGrossWeight,
    -GlobalSettings.GetInstance.WeightAccuracy);
end;

procedure TBox.SetTotalGrossByOneBoxPack(OneBoxPack: real);
begin
  Self.FGrossWeight := Self.GetNetWeight + Self.FBoxCount * OneBoxPack;
  Self.FGrossWeight := SimpleRoundTo(Self.FGrossWeight,
    -GlobalSettings.GetInstance.WeightAccuracy);
end;

end.
