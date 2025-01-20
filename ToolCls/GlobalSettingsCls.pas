unit GlobalSettingsCls;

interface

{ Класс глобальных настроек. Singleton.

  OnLanguageCode - событие изменения языка.}

uses
  Classes;

type
  TSettingsSingleton = class(TObject)
  private
    FBaseDir: string;
    FLanguage: integer;
    FWeightAccuracy: integer;
    FMoneyAccuracy: integer;
    FVolumeAccuracy: integer;
    FOnLanguageChangeEvent : TNotifyEvent;
    FDefView: integer;
    FUseFOBForCFR: boolean;
    FDefFOBPrice: real;
    FCFRPriceFactor: real;
    FMultiplierFileName: string;
    FPricedDistributionFileName: string;
    FDefContainerGross: real;
    FDefContainerVolume: real;
    FAccessPassword: string;
    FShowNotloadCountInOrder: boolean;
    FFixBoxPackWeightForChange: boolean;
    FMarkedZerousPack: boolean;
    FMinPackWeight: real;
    FDefFileName: string;
    const INI_FILENAME: string = 'global.ini';
    procedure LoadFromIni;
    procedure SetLanguage(language: integer);
    class var FInstance: TSettingsSingleton;
    function GetAccuracyMask(ind: integer): string;
    function UniverseStrToFloat(val: string; Def: real): real;
  public
    class function GetInstance: TSettingsSingleton;
    class procedure DestroyInstance;
    property BaseDir: string read FBaseDir;
    property Language: integer read FLanguage write SetLanguage;
    property OnLanguageChange: TNotifyEvent read FOnLanguageChangeEvent
      write FOnLanguageChangeEvent;
    property WeightAccuracy: integer read FWeightAccuracy write FWeightAccuracy;
    property MoneyAccuracy: integer read FMoneyAccuracy write FMoneyAccuracy;
    property VolumeAccuracy: integer read FVolumeAccuracy write FVolumeAccuracy;
    property WeightAccuracyMask: string index 0 read GetAccuracyMask;
    property VolumeAccuracyMask: string index 1 read GetAccuracyMask;
    property MoneyAccuracyMask: string index 2 read GetAccuracyMask;
    property DefaultView: integer read FDefView write FDefView;
    property UseFOBForCFR: boolean read FUseFOBForCFR write FUseFOBForCFR;
    property DefFOBPrice: real read FDefFOBPrice write FDefFOBPrice;
    property CFRPriceFactor: real read FCFRPriceFactor write FCFRPriceFactor;
    property MultiplierFileName: string read FMultiplierFileName
      write FMultiplierFileName;
    property PricedDistributionFileName: string read FPricedDistributionFileName
      write FPricedDistributionFileName;
    property DefContainerGross: real read FDefContainerGross write
      FDefContainerGross;
    property DefContainerVolume: real read FDefContainerVolume write
      FDefContainerVolume;
    property AccessPassword: string read FAccessPassword write FAccessPassword;
    property ShowNotloadCountInOrder: boolean read FShowNotloadCountInOrder
      write FShowNotloadCountInOrder;
    property FixBoxPackWeightForChange: boolean read FFixBoxPackWeightForChange
      write FFixBoxPackWeightForChange;
    property MarkedZerousPack: boolean read FMarkedZerousPack
      write FMarkedZerousPack;
    property MinPackWeight: real read FMinPackWeight write FMinPackWeight;
    property DefFileNmae: string read FDefFileName write FDefFileName;
    procedure Save;
  end;

  TSettings = class of TSettingsSingleton;

var
  GlobalSettings: TSettings;

implementation

uses IniFiles, SysUtils, Forms, Dialogs;

const
  fnMultiplier = 'multiplier.cdl';
  fnPriceDistribution = 'price_distribution.cdl';


class procedure TSettingsSingleton.DestroyInstance;
begin
  if Assigned(FInstance) then FInstance.Free;
end;

class function TSettingsSingleton.GetInstance: TSettingsSingleton;
begin
  if not Assigned(FInstance) then begin
    FInstance :=  TSettingsSingleton.Create;
    FInstance.LoadFromIni;
  end;
  Result := FInstance;
end;

//

function TSettingsSingleton.UniverseStrToFloat(val: string; Def: real): real;
const
  Dot = '.';
  Comma = ',';
begin
  if DecimalSeparator = Dot then
    val := StringReplace(val, Comma , Dot, [rfReplaceAll])
  else
    val := StringReplace(val, Dot , Comma, [rfReplaceAll]);
  Result := StrToFloatDef(val, Def);
end;

procedure TSettingsSingleton.LoadFromIni;
var
  IniFile: TIniFile;
  FileName, Val: string;
begin
  FBaseDir := ExtractFilePath(Application.ExeName);
  filename := FBaseDir + INI_FILENAME;
  if FileExists(filename)then begin
    IniFile := TIniFile.Create(filename);
    FLanguage := IniFile.ReadInteger('MAIN', 'LANGUAGE', 0);
    FDefView := IniFile.ReadInteger('MAIN','DEF_VIEW', 0);
    FAccessPassword := IniFile.ReadString('MAIN', 'ACCESSPSW', '');
    FShowNotloadCountInOrder := IniFile.ReadBool('MAIN',
      'SHOW_NOTLOAD_COUNT_IN_ORDER', True);
    FFixBoxPackWeightForChange := IniFile.ReadBool('MAIN',
      'FIX_BOX_PACK_WEIGHT', True);
    FMarkedZerousPack := IniFile.ReadBool('MAIN',
      'MARKED_ZEROUS_PACK', True);
    Val := IniFile.ReadString('MAIN', 'MIN_PACK_WEIGHT', '');
    FMinPackWeight := Self.UniverseStrToFloat(val, 0.001);
    FDefFileName := IniFile.ReadString('MAIN', 'DEFAULT_FILE', '');
    FWeightAccuracy := IniFile.ReadInteger('ACCURACY', 'WEIGHT', 3);
    FMoneyAccuracy := IniFile.ReadInteger('ACCURACY', 'MONEY', 2);
    FVolumeAccuracy := IniFile.ReadInteger('ACCURACY', 'VOLUME', 3);
    FMultiplierFileName := IniFile.ReadString('ACCURACY',
      'MULTIPLIER_FILE', FBaseDir + fnMultiplier);
    FUseFOBForCFR := IniFile.ReadBool('PRICE', 'FOB_FOR_CFR', True);
    Val := IniFile.ReadString('PRICE', 'DEF_FOB', '');
    FDefFOBPrice := Self.UniverseStrToFloat(val, 0.01);
    Val := IniFile.ReadString('PRICE', 'CFR_FACTOR', '');
    FCFRPriceFactor :=  Self.UniverseStrToFloat(val, 7.3);
    FPricedDistributionFileName := IniFile.ReadString('PRICE',
      'DISTRIBUTION_FILE', FBaseDir + fnPriceDistribution);
    FDefContainerGross := IniFile.ReadFloat('CONTAINER', 'DEF_GROSS', 25000);
    FDefContainerVolume := IniFile.ReadFloat('CONTAINER', 'DEF_VOLUME', 70);
    IniFile.Free;
    // Если файлы из настроек не существуют пробуем найти их в конрневом катлоге
    if not FileExists(Self.FMultiplierFileName) then begin
      Self.FMultiplierFileName := FBaseDir + fnMultiplier;
      if not FileExists(FMultiplierFileName) then FMultiplierFileName := '';
    end;
    if not FileExists(Self.FPricedDistributionFileName) then begin
      Self.FPricedDistributionFileName := FBaseDir + fnPriceDistribution;
      if not FileExists(FPricedDistributionFileName) then FPricedDistributionFileName := '';
    end;
  end else begin
    FLanguage := 1;
    FShowNotloadCountInOrder := True;
    FFixBoxPackWeightForChange := True;
    FMarkedZerousPack := True;
    FWeightAccuracy := 4;
    FMoneyAccuracy := 4;
    FVolumeAccuracy := 4;
    FDefView := 2;
    FUseFOBForCFR := True;
    FDefFOBPrice := 0.01;
    FCFRPriceFactor := 7.3;
    FPricedDistributionFileName := FBaseDir + fnPriceDistribution;
    FMultiplierFileName := FBaseDir + fnMultiplier;
    FDefContainerGross := 25000;
    FDefContainerVolume := 70;
    FAccessPassword := '';
    FMinPackWeight := 0.01;
    FDefFileName := '';
  end;
end;

procedure TSettingsSingleton.Save;
var
  IniFile: TIniFile;
  FileName: string;
begin
  FBaseDir := ExtractFilePath(Application.ExeName);
  filename := FBaseDir + INI_FILENAME;
  IniFile := TIniFile.Create(filename);
  IniFile.WriteInteger('MAIN', 'LANGUAGE', FLanguage);
  IniFile.WriteInteger('MAIN','DEF_VIEW', FDefView);
  IniFile.WriteBool('MAIN', 'SHOW_NOTLOAD_COUNT_IN_ORDER', FShowNotloadCountInOrder);
  IniFile.WriteString('MAIN', 'ACCESSPSW', FAccessPassword);
  IniFile.WriteBool('MAIN', 'FIX_BOX_PACK_WEIGHT', FFixBoxPackWeightForChange);
  IniFile.WriteFloat('MAIN', 'MIN_PACK_WEIGHT', FMinPackWeight);
  IniFile.WriteBool('MAIN', 'MARKED_ZEROUS_PACK', FMarkedZerousPack);
  IniFile.WriteString('MAIN', 'DEFAULT_FILE', FDefFileName);
  IniFile.WriteInteger('ACCURACY', 'WEIGHT', FWeightAccuracy);
  IniFile.WriteInteger('ACCURACY', 'MONEY', FMoneyAccuracy);
  IniFile.WriteInteger('ACCURACY', 'VOLUME', FVolumeAccuracy);
  IniFile.WriteString('ACCURACY', 'MULTIPLIER_FILE', FMultiplierFileName);
  IniFile.WriteBool('PRICE', 'FOB_FOR_CFR', FUseFOBForCFR);
  IniFile.WriteFloat('PRICE', 'DEF_FOB', FDefFOBPrice);
  IniFile.WriteFloat('PRICE', 'CFR_FACTOR', FCFRPriceFactor);;
  IniFile.WriteString('PRICE', 'DISTRIBUTION_FILE', FPricedDistributionFileName);
  IniFile.WriteFloat('CONTAINER', 'DEF_GROSS', FDefContainerGross);
  IniFile.WriteFloat('CONTAINER', 'DEF_VOLUME', FDefContainerVolume);
  IniFile.Free;
end;

procedure TSettingsSingleton.SetLanguage(language: Integer);
begin
  if language <> self.FLanguage then begin
    self.FLanguage := language;
    if Assigned(FOnLanguageChangeEvent) then FOnLanguageChangeEvent(self);
  end;
end;

function TSettingsSingleton.GetAccuracyMask(Ind: integer): string;
var
  I, M: integer;
  Mask: string;
begin
  Mask := '#########0.0';
  M := 0;
  case Ind of
    0: M := Self.FWeightAccuracy;
    1: M := Self.FVolumeAccuracy;
    2: M := Self.FMoneyAccuracy;
  end;
  if M > 0 then begin
    for I := 1 to M - 1 do Mask := Mask + '#';
    Result := Mask;
  end else Result := '############';
end;


end.
