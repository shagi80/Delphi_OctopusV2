unit InputForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfrmInput = class(TForm)
    pnMain: TPanel;
    lbText: TLabel;
    pnString: TPanel;
    pnInteger: TPanel;
    edString: TEdit;
    btnClearString: TSpeedButton;
    pnButtons: TPanel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    lbHint: TLabel;
    edInteger: TEdit;
    UpDown1: TUpDown;
    procedure edStringKeyPress(Sender: TObject; var Key: Char);
    procedure btnClearStringClick(Sender: TObject);
  private
    { Private declarations }
    procedure HidePanels;
    procedure SetHint(Value: string);
    procedure NotCheck(Sender: TObject);
    procedure CheckString(Sender: TObject);
    procedure CheckStringAndInt(Sender: TObject);
    procedure SetEditorOnly;
    procedure SetNotEmptyHint(NotEmpty: boolean);
  public
    { Public declarations }
    function GetString(Text: string; var Value: string; NotEmpty: Boolean = True): boolean;
    function GetReal(Text: string; var Value: real; NotEmpty: Boolean = True): boolean;
    function GetStringAndInteger(Text: string; var Value: string;
      var Count: integer; NotEmpty: Boolean = True): boolean;
  end;

var
  frmInput: TfrmInput;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls;

var
  msgStringEmptyWarning: string = 'Значение не может быть пустым';
  msgStringIntegerEmptyWarning: string = 'Значения должны быть указаны';

procedure TfrmInput.SetHint(Value: string);
begin
  if Length(Value) > 0 then lbHint.Caption := '* - ' + AnsiLowerCase(Value) + '.'
    else lbHint.Caption := '';
end;

procedure TfrmInput.NotCheck(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TfrmInput.CheckString(Sender: TObject);
begin
  if Length(edString.Text) = 0 then begin
    MessageDlg(msgStringEmptyWarning +' !', mtWarning, [mbOk], 0);
    Self.ModalResult := mrNone;
  end else Self.ModalResult := mrOk;
end;

procedure TfrmInput.CheckStringAndInt(Sender: TObject);
begin
  if (Length(edString.Text) = 0) or (StrToIntDef(edInteger.Text, 0) = 0)
    or (StrToIntDef(edInteger.Text, 0) < 0) then begin
      MessageDlg(msgStringIntegerEmptyWarning +' !', mtWarning, [mbOk], 0);
      Self.ModalResult := mrNone;
  end else Self.ModalResult := mrOk;
end;

procedure TfrmInput.edStringKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

procedure TfrmInput.btnClearStringClick(Sender: TObject);
begin
  Self.edString.Text := '';
end;

procedure TfrmInput.HidePanels;
var
  I: integer;
begin
  for I := 0 to pnMain.ControlCount - 1 do
    if pnMain.Controls[I] is TPanel then TPanel(pnMain.Controls[I]).Visible := False;
end;

procedure TfrmInput.SetEditorOnly;
begin
  Self.HidePanels;
  Self.pnString.Visible := True;
  Self.pnMain.Height := 110;
  Self.Height := 200;
end;

procedure TfrmInput.SetNotEmptyHint(NotEmpty: boolean);
begin
  msgStringEmptyWarning := Translator.GetInstance.TranslateMessage(
      11, msgStringEmptyWarning);
  if NotEmpty then begin
    Self.SetHint(msgStringEmptyWarning);
    Self.btnOk.OnClick := Self.CheckString;
  end else begin
    Self.SetHint('');
    Self.btnOk.OnClick := Self.NotCheck;
  end;
end;

//

function TfrmInput.GetString(Text: string; var Value: string; NotEmpty: Boolean = True): boolean;
begin
  Self.SetEditorOnly;
  Self.SetNotEmptyHint(NotEmpty);
  Self.lbText.Caption := Text;
  Self.edString.Text := Value;
  Self.edString.OnKeyPress := nil;
  if ShowModal = mrOk then begin
    Value := edString.Text;
    Result := True;
  end else Result := False;
end;

function TfrmInput.GetReal(Text: string; var Value: real; NotEmpty: Boolean = True): boolean;
begin
  Self.SetEditorOnly;
  Self.SetNotEmptyHint(NotEmpty);
  Self.lbText.Caption := Text;
  Self.edString.Text := FloatToStr(Value);
  Self.edString.OnKeyPress := Self.edStringKeyPress;
  if ShowModal = mrOk then begin
    Value := StrToFloatDef(edString.Text, 0);
    Result := True;
  end else Result := False;
end;

function TfrmInput.GetStringAndInteger(Text: string; var Value: string;
  var Count: integer; NotEmpty: Boolean = True): boolean;
begin
  Self.HidePanels;
  Self.lbText.Caption := Text;
  Self.edInteger.Text := IntToStr(Count);
  Self.pnInteger.Visible := True;
  Self.edString.Text := Value;
  Self.pnString.Visible := True;
  Self.edString.OnKeyPress := nil;
  Self.pnMain.Height := 160;
  Self.Height := 240;
  msgStringEmptyWarning := Translator.GetInstance.TranslateMessage(
      37, msgStringIntegerEmptyWarning);
  if NotEmpty then begin
    Self.SetHint(msgStringEmptyWarning);
    Self.btnOk.OnClick := Self.CheckStringAndInt;
  end else begin
    Self.SetHint('');
    Self.btnOk.OnClick := Self.NotCheck;
  end;
  if ShowModal = mrOk then begin
    Value := edString.Text;
    Count := StrToIntDef(edInteger.Text, 0);
    Result := True;
  end else Result := False;
end;

end.
