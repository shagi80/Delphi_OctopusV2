unit PriceChangeSetiingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmPriceChangeSetiings = class(TForm)
    pnValue: TPanel;
    Label1: TLabel;
    edNewCost: TEdit;
    Panel1: TPanel;
    Label8: TLabel;
    pnByAll: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pnBySelected: TPanel;
    lbCaptionByPackMinWeight: TLabel;
    Label6: TLabel;
    pnBySettings: TPanel;
    Label4: TLabel;
    Label5: TLabel;
  private
    { Private declarations }
    FSelectedMode: integer;
  public
    { Public declarations }
    function CursorInClien(X, Y: integer; Control: TWinControl): boolean;
    function GetNewCost(HaveSelectedParts, HaveSettingParts: boolean; var NewCost: real): integer;
  published
    procedure edNewCostKeyPress(Sender: TObject; var Key: Char);
    procedure ModePanelClick(Sender: TObject);
  end;

var
  frmPriceChangeSetiings: TfrmPriceChangeSetiings;

implementation

{$R *.dfm}

uses
  TranslatorCls;

procedure TfrmPriceChangeSetiings.edNewCostKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

function TfrmPriceChangeSetiings.CursorInClien(X, Y: integer; Control: TWinControl): boolean;
begin
  Result := False;
  if (Control = pnByAll) or (Control.Parent = pnByAll) then begin
    Result := True;
    pnByAll.Color := rgb(220, 250, 250);
  end else pnByAll.Color := clBtnFace;
  if (Control = pnBySelected) or (Control.Parent = pnBySelected) then begin
    Result := True;
    pnBySelected.Color := rgb(220, 250, 250)
  end else pnBySelected.Color := clBtnFace;
  if (Control = pnBySettings) or (Control.Parent = pnBySettings) then begin
    Result := True;
    pnBySettings.Color := rgb(220, 250, 250)
  end else pnBySettings.Color := clBtnFace;
  if Result then begin
    if Screen.Cursor = crDefault then Screen.Cursor := crHandPoint
  end else
    if Screen.Cursor <> crDefault then Screen.Cursor := crDefault;
end;

//

procedure TfrmPriceChangeSetiings.ModePanelClick(Sender: TObject);
var
  Panel: TPanel;
begin
  if (Sender is TPanel) then Panel := TPanel(Sender)
    else Panel := TPanel((Sender as TControl).Parent);
  Panel.Visible := False;
  Sleep(50);
  Panel.Visible := True;
  if Panel = pnByAll then FSelectedMode := 1;
  if Panel = pnBySelected then FSelectedMode := 2;
  if Panel = pnBySettings then FSelectedMode := 3;
  //
  if StrToFloatDef(edNewCost.Text, 0) > 0 then ModalResult := mrOk
    else begin
      MessageDlg(Translator.GetInstance.TranslateMessage(
        71, '¬ведена некорректна€ сумма') + ' !',
        mtWarning, [mbOk], 0);
      FSelectedMode := 0;
    end;
end;

//

function TfrmPriceChangeSetiings.GetNewCost(HaveSelectedParts, HaveSettingParts: boolean;
  var NewCost: real): integer;
var
  I: integer;
begin
  Result := 0;
  Self.edNewCost.Text := FloatToStr(NewCost);
  Self.pnBySelected.Enabled := HaveSelectedParts;
  for I := 0 to pnBySelected.ControlCount - 1 do
    pnBySelected.Controls[I].Enabled := HaveSelectedParts;
  Self.pnBySettings.Enabled := HaveSettingParts;
  for I := 0 to pnBySettings.ControlCount - 1 do
    pnBySettings.Controls[I].Enabled := HaveSettingParts;

  FSelectedMode := 0;
  Self.ShowModal;
  if FSelectedMode > 0 then NewCost := StrToFloatDef(Self.edNewCost.Text, 0);
  Result := FSelectedMode;
end;

end.
