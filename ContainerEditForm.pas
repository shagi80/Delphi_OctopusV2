unit ContainerEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DocumentCls;

type
  TfrmContainerEdit = class(TForm)
    pnButtons: TPanel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    pnMain: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edVolume: TEdit;
    edGross: TEdit;
    edTitle: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure edGrossKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function EditContainer(var Title: string;
      var Gross: real; var Volume: real): boolean;
  end;

var
  frmContainerEdit: TfrmContainerEdit;

implementation

{$R *.dfm}

uses TranslatorCls;

procedure TfrmContainerEdit.btnOkClick(Sender: TObject);
var
  Text: string;
begin
  Text := '';
  if Length(edTitle.Text) = 0 then
    Text := Text + '- ' + Translator.GetInstance.TranslateMessage(
      81, 'Номер - обязательное поле') + chr(13);
  if StrToFloatDef(edGross.Text, 0) <= 0 then
    Text := Text + '- ' + Translator.GetInstance.TranslateMessage(
      82, 'Макс вес не может быть меньше или равно нулю') + chr(13);
  if Length(edVolume.Text) = 0 then
    Text := Text + '- ' + Translator.GetInstance.TranslateMessage(
      83, 'Макс объём не может быть меньше или равно нулю') + chr(13);
  if Length(Text) = 0 then Self.ModalResult := mrOk
    else MessageDlg(Translator.GetInstance.TranslateMessage(
      26, 'Ошибки') + ' :' + chr(13) + Text, mtWarning, [mbOk], 0);
end;

procedure TfrmContainerEdit.edGrossKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

//

function TfrmContainerEdit.EditContainer(var Title: string;
  var Gross: real; var Volume: real): boolean;
begin
  edTitle.Text := Title;
  edGross.Text := FloatToStr(Gross);
  edVolume.Text := FloatToStr(Volume);
  Result := (Self.ShowModal = mrOk);
  if Result then begin
    Title := edTitle.Text;
    Gross := StrToFloatDef(edGross.Text, 0);
    Volume := StrToFloatDef(edVolume.Text, 0);
  end
end;

end.
