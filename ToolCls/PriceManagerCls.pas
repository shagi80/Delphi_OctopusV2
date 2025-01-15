unit PriceManagerCls;

interface

uses
  PartCls;

type
  TPriceManager = class(TObject)
  public
    constructor Create;
    function MakeCFRFromFOB(Part: TPart): real;
  end;

implementation

uses
  GlobalSettingsCls, Math;

constructor TPriceManager.Create;
begin
  inherited Create;
end;

function TPriceManager.MakeCFRFromFOB(Part: TPart): real;
var
  FOBPrice, CFRPrice: real;
begin
  FOBPrice := Part.FOBPrice;
  if FOBPrice = 0 then FOBPrice := GlobalSettings.GetInstance.DefFOBPrice;
  CFRPrice := FOBPrice;
  if GlobalSettings.GetInstance.CFRPriceFactor <> 0 then
    CFRPrice := CFRPrice * GlobalSettings.GetInstance.CFRPriceFactor;
  CFRPrice := SimpleRoundTo(CFRPrice, -GlobalSettings.GetInstance.MoneyAccuracy);
  Part.CFRPrice := CFRPrice;
  Result := Part.CFRPrice;
end;

end.
