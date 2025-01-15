unit GrossWeightSettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ContainerCls;

type
  TfrmGrossWeightSettings = class(TForm)
    pnValue: TPanel;
    Label1: TLabel;
    edNewGross: TEdit;
    Panel1: TPanel;
    pnByPackWeight: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lbMinForByPackWeight: TLabel;
    pnByPackMinWeight: TPanel;
    lbCaptionByPackMinWeight: TLabel;
    Label6: TLabel;
    lbMinForByPackMinWeight: TLabel;
    Label8: TLabel;
    procedure pnByPackMinWeightClick(Sender: TObject);
    procedure pnByPackWeightClick(Sender: TObject);
    procedure edNewGrossKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FContainer: TContainer;
    FSelectedMode: integer;
    FMinPackWeight: real;
    procedure PanelClick(Panel: TPanel);
  public
    { Public declarations }
    function CursorInClien(X, Y: integer; Control: TWinControl): boolean;
    function GetNewGross(Container: TContainer; var NewGross: real): integer;
  end;

var
  frmGrossWeightSettings: TfrmGrossWeightSettings;

implementation

{$R *.dfm}

uses
  TranslatorCls, GrossManagerCls, GlobalSettingsCls;

procedure TfrmGrossWeightSettings.edNewGrossKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

function TfrmGrossWeightSettings.CursorInClien(X, Y: integer; Control: TWinControl): boolean;
begin
  Result := False;
  if (Control = pnByPackWeight) or (Control.Parent = pnByPackWeight) then begin
    Result := True;
    pnByPackWeight.Color := rgb(220, 250, 250);
  end else pnByPackWeight.Color := clBtnFace;
  if (Control = pnByPackMinWeight) or (Control.Parent = pnByPackMinWeight) then begin
    Result := True;
    pnByPackMinWeight.Color := rgb(220, 250, 250)
  end else pnByPackMinWeight.Color := clBtnFace;
  if Result then begin
    if Screen.Cursor = crDefault then Screen.Cursor := crHandPoint
  end else
    if Screen.Cursor <> crDefault then Screen.Cursor := crDefault;
end;

//

procedure TfrmGrossWeightSettings.PanelClick(Panel: TPanel);
var
  GrossManager: TGrossManager;
  MinGross: real;
  NewGross: real;
begin
  Panel.Visible := False;
  Sleep(50);
  Panel.Visible := True;
  GrossManager := TGrossManager.Create(FContainer);
  MinGross := MaxInt;
  if Panel = Self.pnByPackWeight then begin
    FSelectedMode := 1;
    MinGross := GrossManager.GetMinTotalGross(0);
  end;
  if Panel = Self.pnByPackMinWeight then begin
    FSelectedMode := 2;
    MinGross := GrossManager.GetMinTotalGross(FMinPackWeight);
  end;
  //
  NewGross := StrToFloatDef(edNewGross.Text, 0);
  if NewGross > MinGross  then ModalResult := mrOk
    else begin
      MessageDlg(Translator.GetInstance.TranslateMessage(
        105, 'Этот вес не может быть достигнут') + ' !',
        mtWarning, [mbOk], 0);
      FSelectedMode := 0;
    end;
  //
  GrossManager.Free;
end;

procedure TfrmGrossWeightSettings.pnByPackMinWeightClick(Sender: TObject);
begin
  Self.PanelClick(Self.pnByPackMinWeight);
end;

procedure TfrmGrossWeightSettings.pnByPackWeightClick(Sender: TObject);
begin
  Self.PanelClick(Self.pnByPackWeight);
end;

//

function TfrmGrossWeightSettings.GetNewGross(Container: TContainer;
  var NewGross: real): integer;
var
  GrossManager: TGrossManager;
begin
  Result := 0;
  if (Container = nil) or (Container.Count = 0) then Exit;
  FContainer := Container;
  FMinPackWeight := GlobalSettings.GetInstance.MinPackWeight;
  GrossManager := TGrossManager.Create(FContainer);
  Self.lbMinForByPackWeight.Caption := Translator.GetInstance.TranslateMessage(
    103, 'Минимально возможный вес') + ': '
    + FloatToStr(GrossManager.GetMinTotalGross(0)) + ' '
    + Translator.GetInstance.TranslateWord('кг');
  Self.lbMinForByPackMinWeight.Caption := Translator.GetInstance.TranslateMessage(
    103, 'Минимально возможный вес') + ': '
    + FloatToStr(GrossManager.GetMinTotalGross(0.01)) + ' '
    + Translator.GetInstance.TranslateWord('кг');
  GrossManager.Free;
  lbCaptionByPackMinWeight.Caption := Translator.GetInstance.TranslateMessage(
    104, 'Использовать минимальный вес упаковки') + ' ('
    + FloatToStr(FMinPackWeight) + ' '
    + Translator.GetInstance.TranslateWord('кг') + ')';
  Self.edNewGross.Text := FloatToStr(FContainer.RealGrossWeight);

  FSelectedMode := 0;
  Self.ShowModal;
  if FSelectedMode > 0 then NewGross := StrToFloatDef(Self.edNewGross.Text, 0);
  Result := FSelectedMode;
  FContainer := nil;
  FMinPackWeight := 0;
end;


end.
