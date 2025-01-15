unit MultiplierManagerCls;

interface

uses
  Forms, SysUtils, Classes;

type
  TMultiplierManager = class(TObject)
  private
    FData: TStringList;
    function GetFactor(code: string): real;
    procedure SetFactor(code: string; Factor: real);
  public
    constructor Create;
    destructor Destroy; override;
    property PartMultiplierFactors: TStringList read FData write FData;
    property Factor[code: string]: real read GetFactor write SetFactor;
    function LoadFromFile: boolean;
    procedure SaveToFile(fileName: string);
    function PartCountRoundUp(Code: string; var Count: real): boolean;
  end;

implementation

uses
  GlobalSettingsCls, TranslatorCls, Dialogs;


constructor TMultiplierManager.Create;
begin
  inherited Create;
  FData := TStringList.Create;
end;

destructor TMultiplierManager.Destroy;
begin
  FData.Free;
  inherited Destroy;
end;

function TMultiplierManager.LoadFromFile: boolean;
var
  FileName: string;
begin
  Result := False;
  FileName := ExtractFilePath(Application.ExeName) +
    GlobalSettings.GetInstance.MultiplierFileName;
  if not FileExists(FileName) then begin
    MessageDlg(Translator.GetInstance.TranslateMessage(
      73, 'Не найден файл с настройками округления') + ' !',
      mtWarning, [mbOk], 0);
    Exit;
  end;
  FData.Clear;
  try
    FData.LoadFromFile(FileName);
    Result := True;
  finally
    //
  end;
end;

procedure TMultiplierManager.SaveToFile(fileName: string);
begin
  Fdata.SaveToFile(FileName);
end;

function TMultiplierManager.GetFactor(code: string): real;
begin
  Result := StrToFloatDef(FData.Values[code], 1);
end;

procedure TMultiplierManager.SetFactor(code: string; Factor: real);
begin
  FData.Values[Code] := FloatToStr(Factor);
end;

function TMultiplierManager.PartCountRoundUp(Code: string; var Count: real): boolean;
var
  CurFactor: real;
begin
  Result := False;
  if FData.Count = 0 then Exit;  
  CurFactor := Self.GetFactor(Code);
  if CurFactor <> 1 then
    if frac(Count/CurFactor) <> 0 then
      Count := (int(Count/CurFactor) + 1) * CurFactor;
  Result := (CurFactor <> 1);
end;


end.
