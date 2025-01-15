unit GrossManagerCls;

interface

uses
  ContainerCls, BoxCls;

type
  TBufferRec = record
    Box: TBox;
    BaseCoef: real;
    GroupCoef: real;
    PackDec: real;
    NewPack: real;
    NewGross: real;
  end;

  TBuffer = array of TBufferRec;

  TGrossManager = class(TObject)
  private
    FContainer: TContainer;
    procedure ClearBuffer(Buffer: TBuffer);
    function CalculateBuffer(Buffer: TBuffer; DifferenceCoef: real;
      DefPackWeight: real=0): real;
  public
    constructor Create(Container: TContainer);
    destructor Destroy; override;
    function GetMinTotalGross(MinPackWeight: real): real;
    function DistributeByPackWeight(NewGross: real): real;
    function DistributeByMinPackWeight(MinPackWeight, NewGross: real): real;
  end;

implementation

uses
  GlobalSettingsCls, Math;

constructor TGrossManager.Create(Container: TContainer);
begin
  inherited Create;
  FContainer := Container;
end;

destructor TGrossManager.Destroy;
begin
  FContainer := nil;
  inherited Destroy;
end;

function TGrossManager.GetMinTotalGross(MinPackWeight: real): real;
var
  I: integer;
  Sum: real;
begin
  if MinPackWeight <= 0 then
    Result := FContainer.RealNetWeight
  else begin
    Sum := FContainer.RealNetWeight;
    for I := 0 to FContainer.Count - 1 do
      Sum := Sum + FContainer.Items[I].BoxCount * MinPackWeight;
    Result := Sum;
  end;
  Result := roundto(Result, - GlobalSettings.GetInstance.WeightAccuracy);
end;

procedure TGrossManager.ClearBuffer(Buffer: TBuffer);
var
  I: integer;
begin
  for I := 0 to high(Buffer) do Buffer[I].Box := nil;
  SetLength(Buffer, 0);
end;

//

function TGrossManager.CalculateBuffer(Buffer: TBuffer; DifferenceCoef: real;
      DefPackWeight: real=0): real;
var
  I: integer;
  Box: TBox;
begin
  // Итоговый расчет.
  Result := FContainer.RealNetWeight;
  for I := 0 to high(Buffer) do begin
    Box := Buffer[I].Box;
    Buffer[I].GroupCoef := DifferenceCoef * Buffer[I].BaseCoef;
    Buffer[I].PackDec := Buffer[I].GroupCoef / Box.BoxCount;
    if DefPackWeight > 0 then
      Buffer[I].NewPack := DefPackWeight
    else
      Buffer[I].NewPack := (Box.GroupGrossWeight - Box.GroupNetWeight)
        / Box.BoxCount;
    Buffer[I].NewPack := Buffer[I].NewPack - Buffer[I].PackDec;
    Box.GroupGrossWeight := Box.GroupNetWeight + Buffer[I].NewPack * Box.BoxCount;
    Box.GroupGrossWeight := roundto(Box.GroupGrossWeight,
      - GlobalSettings.GetInstance.WeightAccuracy);
    Result := Result + Buffer[I].NewPack * Box.BoxCount;
  end;
end;

function TGrossManager.DistributeByPackWeight(NewGross: real): real;
var
  Buffer: TBuffer;
  I: integer;
  Box: TBox;
  Difference, BaseSum: real;
begin
  // Проверяем возможность вычислений.
  Result := 0;
  if Self.GetMinTotalGross(0) > NewGross then Exit;
  // Расчет разницы.
  Difference := FContainer.RealGrossWeight - NewGross;
  SetLength(Buffer, FContainer.Count);
  // Расчет базового коэффициента.
  BaseSum := 0;
  for I := 0 to high(Buffer) do begin
    Box := FContainer.Items[I];
    Buffer[I].Box := Box;
    Buffer[I].BaseCoef := Box.GroupGrossWeight - Box.GroupNetWeight;
    BaseSum := BaseSum + Buffer[I].BaseCoef;
  end;
  // Итоговый расчет.
  if BaseSum = 0 then Exit;
  Result := CalculateBuffer(Buffer, Difference / BaseSum);
  Self.ClearBuffer(Buffer);
end;

function TGrossManager.DistributeByMinPackWeight(MinPackWeight, NewGross: real): real;
var
  Buffer: TBuffer;
  I: integer;
  Box: TBox;
  Difference, BaseSum, MinNet, Gross: real;
begin
  // Проверяем возможность вычислений.
  Result := 0;
  Gross := GetMinTotalGross(MinPackWeight);
  if Gross > NewGross then Exit;
  // Расчет разницы.
  Difference := Gross - NewGross;
  SetLength(Buffer, FContainer.Count);
  //
  MinNet := MaxInt;
  for I := 0 to FContainer.Count - 1 do
    if FContainer.Items[I].GroupNetWeight < MinNet then
      MinNet := FContainer.Items[I].GroupNetWeight;
  // Расчет базового коэффициента.
  BaseSum := 0;
  for I := 0 to high(Buffer) do begin
    Box := FContainer.Items[I];
    Buffer[I].Box := Box;
    Buffer[I].BaseCoef := Box.GroupNetWeight - MinNet;
    BaseSum := BaseSum + Buffer[I].BaseCoef;
  end;
  // Итоговый расчет.
  if BaseSum = 0 then Exit;
  Result := CalculateBuffer(Buffer, Difference / BaseSum, MinPackWeight);
  Self.ClearBuffer(Buffer);
end;


end.
