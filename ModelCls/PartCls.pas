unit PartCls;

interface

type

  //  ласс информации о детали
  //
  // FLinkCount обеспечивает хранение кол-ва ссылок на экземпл€р класса
  //  proc IncLinkCount - увеличиваетк количество ссылок
  //  proc DecLinkCount - уменьшает кол-во ссылок и вызыввает деструтор
  //    при достижении нул€
  //
  // prop NetUnit - признак весовой единицы измерени€ (г, кг, т)
  //
  // func GetTranslatedTitle - получение наименвоани€ детали в соответствии
  // с €зыком
  //  0 - русское
  //  1 - английское
  //  2 - наименование поставщика

  TPart = class(TObject)
  private
    FCode: string;
    FLinkCount: integer;
    FShortTitle: string;
    FTitle: array [0..2] of widestring;
    FUnit: string;
    FWeight: real;
    FVolume: real;
    FPrice: array [0..2] of real;
    FBOMCode: string;
    FCustomCode: string;
    FCountInBox: real;
    FBoxType: string;
    function GetTitle(ind: integer): widestring;
    procedure SetTitle(ind: integer; newTitle: widestring);
    function CheckNetUnit: boolean;
    function GetNetCoefficient: extended;
    function GetPrice(ind: integer): real;
    procedure SetPrice(ind: integer; newPrice: real);
    const NET_UNITS: array [0..2] of string = ('г', 'кг', 'т');
  public
    constructor Create(code: string); overload;
    constructor Create(Part: TPart); overload;
    destructor Destroy; override;
    property Code: string read FCode write FCode;
    property LinkCount: integer read FLinkCount;
    procedure IncLinkCount;
    procedure DecLinkCount(destroyIfCan: boolean=false);
    property ShortTitle: string read FShortTitle write FShortTitle;
    property RusName: widestring index 0 read GetTitle write SetTitle;
    property EngName: widestring index 1 read GetTitle write SetTitle;
    property ChinName: widestring index 2 read GetTitle write SetTitle;
    property PartUnit: string read FUnit write FUnit;
    function GetTranslatedTitle(language: integer): widestring;
    property NetUnit: boolean read CheckNetUnit;
    property NetCoefficient: extended read GetNetCoefficient;
    property SupplierPrice: real index 0 read GetPrice write SetPrice;
    property FOBPrice: real index 1 read GetPrice write SetPrice;
    property CFRPrice: real index 2 read GetPrice write SetPrice;
    property BOM: string read FBOMCode write FBOMCode;
    property CustomCode: string read FCustomCode write FCustomCode;
    property CountInBox: real read FCountInBox write FCountInBox;
    property BoxType: string read FBoxType write FBoxType;
    property Weight: real read FWeight write FWeight;
    property Volume: real read FVolume write FVolume;
  end;

implementation

uses
  SysUtils, Dialogs;

constructor TPart.Create(code: string);
begin
  inherited Create;
  FCode := code;
  FLinkCount := 0
end;

constructor TPart.Create(Part: TPart);
var
  I: integer;
begin
  inherited Create;
  FCode := Part.FCode;
  FLinkCount := 0;
  FShortTitle := Part.FShortTitle;
  for I := 0 to High(Part.FTitle) do FTitle[I] := Part.FTitle[I];
  FUnit := Part.FUnit;
  FWeight := Part.FWeight;
  FVolume := Part.FVolume;
  for I := 0 to High(Part.FPrice) do FPrice[I] := Part.FPrice[I];
  FBOMCode := Part.FBOMCode;
  FCustomCode := Part.FCustomCode;
  FCountInBox := Part.FCountInBox;
  FBoxType := Part.FBoxType;
end;


destructor TPart.Destroy;
begin
  inherited Destroy;
end;

procedure TPart.IncLinkCount;
begin
  inc(FLinkCount);
end;

procedure TPart.DecLinkCount(destroyIfCan: boolean=false);
begin
  dec(FLinkCount);
  if (FLinkCount <= 0) and (destroyIfCan) then self.Destroy;
end;

function TPart.GetTitle(ind: integer): widestring;
begin
  if ind = 2 then Result := UTF8Decode(Ftitle[ind])
    else Result := Ftitle[ind];
end;

procedure TPart.SetTitle(ind: integer; newTitle: widestring);
begin
  FTitle[ind] := newTitle;
end;

function TPart.CheckNetUnit: boolean;
var
  i: integer;
begin
  Result := False;
  for I := 0 to high(NET_UNITS) do
    if LowerCase(FUnit) = NET_UNITS[i] then begin
      Result := True;
      Break;
    end;
end;

function TPart.GetNetCoefficient: extended;
var
  coef: extended;
begin
  coef := 0;
  if LowerCase(FUnit) = 'г' then coef := 1e-3
    else if LowerCase(FUnit) = 'кг' then coef := 1
      else if LowerCase(FUnit) = 'г' then coef := 1e3;
  Result := coef;
end;

function TPart.GetPrice(ind: integer): real;
begin
  Result := FPrice[ind];
end;

procedure TPart.SetPrice(ind: integer; newPrice: real);
begin
  FPrice[ind] := newPrice;
end;

function TPart.GetTranslatedTitle(language: integer): widestring;
begin
  try
    Result := GetTitle(language);
    if (Length(Result) = 0) then begin
      if language = 2 then Result := FTitle[1];
      if (Length(Result) = 0) then Result := FTitle[0];
    end;
  except
    Result := '';
  end;
end;

end.
