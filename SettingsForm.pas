unit SettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, CheckLst, Grids, ValEdit;

type
  TfrmSettings = class(TForm)
    pcSettings: TPageControl;
    pnButtons: TPanel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    tsMain: TTabSheet;
    tsRound: TTabSheet;
    tsPrice: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cbView: TComboBox;
    cbLanguage: TComboBox;
    Label3: TLabel;
    edAccesPassword: TEdit;
    cbAccesSettings: TCheckListBox;
    btnUpdateAccess: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edPriceAccuracy: TEdit;
    edVolumeAccuracy: TEdit;
    edWeightAccuracy: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    lbWeightAccuracy: TLabel;
    lbVolumeAccuracy: TLabel;
    lbPriceAccuracy: TLabel;
    edAccuracyFile: TEdit;
    btnChangeAccuracyFile: TSpeedButton;
    vleAccuracy: TValueListEditor;
    Label9: TLabel;
    Label10: TLabel;
    edDefFOB: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edCFRCoef: TEdit;
    Label13: TLabel;
    edPriceFile: TEdit;
    btnChangePriceFile: TSpeedButton;
    vlePriceSettings: TValueListEditor;
    cbFOBForCFR: TCheckBox;
    lbCantChangeAccuracy: TLabel;
    lbCantChangePrice: TLabel;
    Label14: TLabel;
    cbShowCountInOrder: TComboBox;
    Label15: TLabel;
    cbFixPackBoxWeight: TCheckBox;
    Label16: TLabel;
    cbMarkedZerousPack: TCheckBox;
    Label17: TLabel;
    edMinPackWeight: TEdit;
    procedure btnChangeAccuracyFileClick(Sender: TObject);
    procedure btnChangePriceFileClick(Sender: TObject);
    procedure btnUpdateAccessClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateAccuracyExample(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateAccessList;
    function GetFileName: string;
    procedure SetAccuracyFile(FileName: string);
    procedure SetPriceFile(FileName: string);
  public
    { Public declarations }
  published
    procedure edIntegerKeyPress(Sender: TObject; var Key: Char);
    procedure edFloatKeyPress(Sender: TObject; var Key: Char);
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

uses
  GlobalSettingsCls, ViewControllerCls, TranslatorCls, AccesManagerCls;


procedure TfrmSettings.UpdateAccessList;
var
  I: integer;
  Strs: TStringList;
begin
  Strs := TStringList.Create;
  AccesManager.GetInstance.GetStrings(Strs);
  cbAccesSettings.Clear;
  for I := 0 to Strs.Count - 1 do begin
    cbAccesSettings.Items.Add(Strs.Names[I]);
    cbAccesSettings.Checked[I] := (StrToIntDef(Strs.ValueFromIndex[I], 0) = 1);
  end;
  cbAccesSettings.Enabled := (AccesManager.GetInstance.CanEditSettings);
  Strs.Free;
end;

procedure TfrmSettings.edIntegerKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not (ord(Key) in ToolsKey) then Key := chr(0);
end;

procedure TfrmSettings.edFloatKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

procedure TfrmSettings.btnChangeAccuracyFileClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := Self.GetFileName;
  if Length(FileName) > 0 then Self.SetAccuracyFile(FileName);
end;

procedure TfrmSettings.btnChangePriceFileClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := Self.GetFileName;
  if Length(FileName) > 0 then Self.SetPriceFile(FileName);
end;

procedure TfrmSettings.btnUpdateAccessClick(Sender: TObject);
begin
  AccesManager.GetInstance.SetAccessLevel(edAccesPassword.Text);
  Self.UpdateAccessList;
end;

procedure TfrmSettings.UpdateAccuracyExample(Sender: TObject);

  function GetMask(Accuracy: integer): string;
  var
    Mask: string;
    I: integer;
  begin
    if Accuracy = 0 then Result := '0'
      else begin
        Mask := '0.0';
        for I := 1 to Accuracy - 1 do Mask := Mask + '0';
        Result := Mask;
      end;
  end;

begin
  Self.lbWeightAccuracy.Caption := GetMask(StrToIntDef(
    Self.edWeightAccuracy.Text, 0));
  Self.lbVolumeAccuracy.Caption := GetMask(StrToIntDef(
    Self.edVolumeAccuracy.Text, 0));
  Self.lbPriceAccuracy.Caption := GetMask(StrToIntDef(
    Self.edPriceAccuracy.Text, 0));
end;

function TfrmSettings.GetFileName: string;
var
  OpenDlg: TOpenDialog;
begin
  Result := '';
  OpenDlg := TOpenDialog.Create(Self);
  OpenDlg.Title := Translator.GetInstance.TranslateMessage(
    86, 'Выберите файл CDL');
  Opendlg.Filter := 'Codelist files (*.cdl)|*.cdl|Text files (*.txt)|*.txt';
  if OpenDlg.Execute then Result := OpenDlg.FileName;  
  OpenDlg.Free;
end;

procedure TfrmSettings.SetAccuracyFile(FileName: string);
begin
  Self.vleAccuracy.Strings.Clear;
  if FileExists(FileName) then begin
    Self.edAccuracyFile.Text := FileName;
    Self.vleAccuracy.Strings.LoadFromFile(FileName);
  end else begin
    Self.edAccuracyFile.Text := '';
  end;
end;

procedure TfrmSettings.SetPriceFile(FileName: string);
begin
  Self.vlePriceSettings.Strings.Clear;
  if FileExists(FileName) then begin
    Self.edPriceFile.Text := FileName;
    Self.vlePriceSettings.Strings.LoadFromFile(FileName);
  end else begin
    Self.edPriceFile.Text := '';
  end;
end;

//

procedure TfrmSettings.FormShow(Sender: TObject);
var
  ViewController: TViewController;
  Settings: TSettingsSingleton;
begin
  Settings := GlobalSettings.GetInstance;
  Self.pcSettings.ActivePage := Self.tsMain;
  //
  ViewController := TViewController.Create(Self);
  ViewController.UpdatrViewList(Self.cbView);
  ViewController.Free;
  cbView.ItemIndex := Settings.DefaultView;
  //
  cbLanguage.Clear;
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Русский'));
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Английский'));
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Наименование поставщика'));
  cbLanguage.ItemIndex := Settings.Language;
  //
  edAccesPassword.Text := Settings.AccessPassword;
  Self.UpdateAccessList;
  //
  cbShowCountInOrder.Clear;
  cbShowCountInOrder.Items.Add(Translator.GetInstance.TranslateMessage
    (94, 'Загруженное количество'));
  cbShowCountInOrder.Items.Add(Translator.GetInstance.TranslateMessage
    (95, ' Незагруженное количество'));
  if Settings.ShowNotloadCountInOrder then cbShowCountInOrder.ItemIndex := 1
    else cbShowCountInOrder.ItemIndex := 0;
  //
  cbFixPackBoxWeight.Checked := Settings.FixBoxPackWeightForChange;
  //
  cbMarkedZerousPack.Checked := Settings.MarkedZerousPack;
  //
  edMinPackWeight.Text := FloatToStr(Settings.MinPackWeight);
  //
  edWeightAccuracy.Text := IntToStr(Settings.WeightAccuracy);
  edVolumeAccuracy.Text := IntToStr(Settings.VolumeAccuracy);
  edPriceAccuracy.Text := IntToStr(Settings.MoneyAccuracy);
  Self.UpdateAccuracyExample(Self);
  //
  vleAccuracy.TitleCaptions.Clear;
  vleAccuracy.TitleCaptions.Add(Translator.GetInstance.TranslateWord('Код 1С'));
  vleAccuracy.TitleCaptions.Add(Translator.GetInstance.TranslateWord('Множитель'));
  Self.SetAccuracyFile(Settings.MultiplierFileName);
  //
  edDefFOB.Text := FloatToStr(Settings.DefFOBPrice);
  cbFOBForCFR.Checked := Settings.UseFOBForCFR;
  edCFRCoef.Text := FloatToStr(Settings.CFRPriceFactor);
  //
  vlePriceSettings.TitleCaptions.Clear;
  vlePriceSettings.TitleCaptions.Add(Translator.GetInstance.TranslateWord('Код 1С'));
  vlePriceSettings.TitleCaptions.Add(Translator.GetInstance.TranslateWord('Множитель'));
  Self.SetPriceFile(Settings.PricedDistributionFileName);
  //
  tsPrice.Enabled := AccesManager.GetInstance.CanEditSettings;
  tsRound.Enabled := AccesManager.GetInstance.CanEditSettings;
  lbCantChangeAccuracy.Visible := not AccesManager.GetInstance.CanEditSettings;
  lbCantChangePrice.Visible := not AccesManager.GetInstance.CanEditSettings;
end;

procedure TfrmSettings.btnOkClick(Sender: TObject);
var
  Settings: TSettingsSingleton;
begin
  // Общие настройки.
  Settings := GlobalSettings.GetInstance;
  Settings.Language := Self.cbLanguage.ItemIndex;
  Settings.DefaultView := Self.cbView.ItemIndex;
  Settings.AccessPassword := Self.edAccesPassword.Text;
  Settings.ShowNotloadCountInOrder := (cbShowCountInOrder.ItemIndex = 1);
  Settings.FixBoxPackWeightForChange := Self.cbFixPackBoxWeight.Checked;
  Settings.MarkedZerousPack := Self.cbMarkedZerousPack.Checked;
  Settings.MinPackWeight := StrToFloatDef(edMinPackWeight.Text, 0.01);
  // Настройки суперадминистратора.
  AccesManager.GetInstance.SetAccessLevel(Settings.AccessPassword);
  if AccesManager.GetInstance.CanEditSettings then begin
    AccesManager.GetInstance.CanEditParts := cbAccesSettings.Checked[0];
    AccesManager.GetInstance.CanEditOrders := cbAccesSettings.Checked[1];
    AccesManager.GetInstance.CanEditContainers := cbAccesSettings.Checked[2];
    AccesManager.GetInstance.CanEditBoxes := cbAccesSettings.Checked[3];
    AccesManager.GetInstance.CanEditInvoice := cbAccesSettings.Checked[4];
  end;
  Settings.WeightAccuracy := StrToIntDef(Self.edWeightAccuracy.Text, 0);
  Settings.VolumeAccuracy := StrToIntDef(Self.edVolumeAccuracy.Text, 0);
  Settings.MoneyAccuracy := StrToIntDef(Self.edPriceAccuracy.Text, 0);
  Settings.MultiplierFileName := Self.edAccuracyFile.Text;
  Settings.DefFOBPrice := StrToFloatDef(Self.edDefFOB.Text, 0);
  Settings.UseFOBForCFR := Self.cbFOBForCFR.Checked;
  Settings.CFRPriceFactor := StrToFloatDef(Self.edCFRCoef.Text, 0);
  Settings.PricedDistributionFileName := Self.edPriceFile.Text;
  Settings.Save;
  Self.ModalResult := mrOk;
end;


end.
