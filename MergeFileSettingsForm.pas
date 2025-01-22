unit MergeFileSettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ContainerCls, OrderListCls,
  ContainerListCls;

type
  TfrmMergeFileSettings = class(TForm)
    pnMain: TPanel;
    lbFile: TLabel;
    Label2: TLabel;
    lbOrders: TListBox;
    pnContainers: TPanel;
    Label3: TLabel;
    lbContainers: TListBox;
    cbAllBoxInOne: TCheckBox;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetSettings(Orders: TObject; Containers: TContainerList;
      var CurrentContainer: TContainer; FileName: string): boolean;
  end;

var
  frmMergeFileSettings: TfrmMergeFileSettings;

implementation

{$R *.dfm}

uses
  TranslatorCls, OrderCls;

function TfrmMergeFileSettings.GetSettings(Orders: TObject;
  Containers: TContainerList; var CurrentContainer: TContainer;
  FileName: string): boolean;
var
  I: integer;
begin
  lbFile.Caption := Translator.GetInstance.TranslateMessage(
    108, 'Содержимое файла') + ' :' + ExtractFileName(FileName);
  lbOrders.Items.Clear;
  if (Orders is TOrder) then
    lbOrders.Items.Add(TOrder(Orders).Title)
  else
    for I := 0 to TOrderList(Orders).Count - 1 do
      lbOrders.Items.Add(TOrderList(Orders).Items[I].Title);
  lbContainers.Items.Clear;
  if Containers <> nil then
    for I := 0 to Containers.Count - 1 do
      lbContainers.Items.Add(Containers.Items[I].Title);
  pnContainers.Visible := (lbContainers.Items.Count > 0);
  if pnContainers.Visible then Self.Height := 430 else
    Self.Height := 430 - pnContainers.Height;
  cbAllBoxInOne.Enabled := (CurrentContainer <> nil);
  cbAllBoxInOne.Checked := False;

  Self.Top := trunc((Screen.Height - Self.Height) / 2);
  Result := (Self.ShowModal = mrOk);
  if CurrentContainer <> nil then
    if not cbAllBoxInOne.Checked then CurrentContainer := nil;
end;


end.
