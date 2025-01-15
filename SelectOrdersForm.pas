unit SelectOrdersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, CheckLst, Buttons, ExtCtrls,
  OrderListCls, ImgList;

type
  TfrmSelectOrders = class(TForm)
    pnMain: TPanel;
    pnButtons: TPanel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    chblOrders: TCheckListBox;
    ToolBar1: TToolBar;
    btnSelectAll: TToolButton;
    btnUnselectAll: TToolButton;
    btnInvertSelection: TToolButton;
    imlButtons: TImageList;
    lbFilename: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetOrders(Orders: TOrderList; filename: string = '');
  end;

var
  frmSelectOrders: TfrmSelectOrders;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls;

procedure TfrmSelectOrders.SetOrders(Orders: TOrderList; filename: string = '');
var
  I: integer;
begin
  if Length(filename) = 0 then
    lbFilename.Caption := Translator.GetInstance.TranslateMessage(
      9, 'Заказы в текущем файле:')
  else
    lbFilename.Caption := Translator.GetInstance.TranslateMessage(
      10, 'Заказы в файле') + '"' + filename + '":';
  Self.chblOrders.Items.Clear;
  for I := 0 to Orders.Count - 1 do
    Self.chblOrders.Items.AddObject(Orders.Items[I].Title, Orders.Items[I]);
end;

procedure TfrmSelectOrders.btnOkClick(Sender: TObject);
var
  I: integer;
begin
  Self.ModalResult := mrCancel;
  for I := 0 to Self.chblOrders.Items.Count - 1 do
    if Self.chblOrders.Checked[I] then
      Self.ModalResult := mrOk;
end;

procedure TfrmSelectOrders.btnSelectAllClick(Sender: TObject);
var
  I: integer;
  SenderName: string;
begin
  SenderName := TControl(Sender).Name;
  for I := 0 to Self.chblOrders.Items.Count - 1 do begin
    if SenderName = 'btnSelectAll' then Self.chblOrders.Checked[I] := True;
    if SenderName = 'btnUnselectAll' then Self.chblOrders.Checked[I] := False;
    if SenderName = 'btnInvertSelection' then  Self.chblOrders.Checked[I] := not Self.chblOrders.Checked[I];
  end;
end;

end.
