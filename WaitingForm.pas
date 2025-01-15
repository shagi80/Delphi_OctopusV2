unit WaitingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls;

type
  TfrmWaiting = class(TForm)
    lbCaption: TLabel;
    pbProgress: TProgressBar;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NextStep(Sender: TObject);
    procedure WaitTableUpdate;
    procedure WaitPrint;
  end;

var
  frmWaiting: TfrmWaiting;

implementation

{$R *.dfm}

uses
  TranslatorCls;

procedure TfrmWaiting.WaitTableUpdate;
begin
  Self.lbCaption.Caption := Translator.GetInstance.TranslateMessage(
    57, 'Обновление данных') + ' ...';
  pbProgress.Max := 300;
  Self.Show;
  Application.ProcessMessages;
end;

procedure TfrmWaiting.WaitPrint;
begin
  Self.lbCaption.Caption := Translator.GetInstance.TranslateMessage(
    58, 'Подготовка отчета') + ' ...';
  pbProgress.Max := 10000;
  Self.Show;
  Application.ProcessMessages;
end;


procedure TfrmWaiting.FormShow(Sender: TObject);
begin
  pbProgress.Position := 0;
end;

procedure TfrmWaiting.NextStep(Sender: TObject);
begin
  if not Self.Showing then Exit;
  pbProgress.Position := pbProgress.Position + 1;
  if pbProgress.Position >= pbProgress.Max then
    pbProgress.Position := 0;
  Application.ProcessMessages;
end;

end.
