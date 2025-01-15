unit PrintModeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, StdCtrls, jpeg, ExtCtrls, CategoryButtons,
  StdActns, ActnList, DocumentCls, OrderCls, OrderListCls, Buttons, CheckLst,
  Contnrs, frxClass, frxpngimage, TntStdCtrls;

type
  TfrmPrintMode = class(TForm)
    pnMain: TPanel;
    pcMain: TPageControl;
    tsModePrint: TTabSheet;
    tsSelectCheck: TTabSheet;
    pnImage: TPanel;
    imgPrint: TImage;
    catbtnPrintMode: TCategoryButtons;
    actPrint: TActionList;
    OrderAll: TAction;
    OrderCurrent: TAction;
    OrderSelect: TAction;
    ContainerAll: TAction;
    ContainerCurrent: TAction;
    ContainerSelect: TAction;
    LabelAll: TAction;
    LabelSelectContainer: TAction;
    LabelCurrentContainer: TAction;
    LabelSelect: TAction;
    pnTitle: TPanel;
    lbPrintMode: TLabel;
    btnCollapse: TSpeedButton;
    pnSelectTitle: TPanel;
    lbSelectCheck: TLabel;
    cbCheck: TCheckListBox;
    pnBottom: TPanel;
    btnNext: TBitBtn;
    btnGoPrevios: TBitBtn;
    tsSelectRadio: TTabSheet;
    pnSortTitle: TPanel;
    lbSelectRadio: TLabel;
    rgRadio: TRadioGroup;
    tsModeExport: TTabSheet;
    Panel1: TPanel;
    lbExportMode: TLabel;
    catbtnExportMode: TCategoryButtons;
    ExportFor1C: TAction;
    ExportForInvoice: TAction;
    imgExport: TImage;
    ExportForCustomCode: TAction;
    tsInvoiceSettings: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbBuyer: TComboBox;
    cbPort: TComboBox;
    Label6: TLabel;
    edContNum: TEdit;
    edInvNum: TEdit;
    PrintInvoiceAll: TAction;
    Label7: TLabel;
    edInvDate: TDateTimePicker;
    cbSupplier: TTntComboBox;
    Label8: TLabel;
    edSpecNum: TEdit;
    procedure btnCollapseClick(Sender: TObject);
    procedure btnGoPreviosClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FWaitEvent: boolean;
    FGoNext: boolean;
    FGoPrevios: boolean;
    FDoClose: boolean;
    FLastButtonCaption: string;
    FMode: integer;
    procedure WMClose(var Msg: TWMClose); message WM_CLOSE;
    function WaitForwardStep: boolean;
    procedure CollapseAll;
    function GetRadioMode(var SelectMode: integer; ItIsLastStep: boolean = True): boolean;
  public
    { Public declarations }
    procedure ShowMainPage;
    procedure ShowPrintMaster;
    procedure ShowExportMaster;
    function GetSortMode(var SortMode: integer; ItIsLastStep: boolean = True): boolean;
    function GetBoxSortMode(var SortMode: integer; ItIsLastStep: boolean = True): boolean;
    function GetOrderCopyMode(var CopyMode: integer; ItIsLastStep: boolean = True): boolean;
    function SetCheckList(ObjectList: TObjectList): boolean;
    function GetExportMode(var ExportMode: integer; ItIsLastStep: boolean = True): boolean;
    function GetInvoiceSettings(var SupplierId: integer; var BuyerId: integer;
      var PortId: integer; var ContNum: string; var InvNum: string;
      var InvDate: TDate; var SpecNum: string): boolean;
  end;

var
  frmPrintMode: TfrmPrintMode;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls, OrderItemCls, OrdersForm,
  ContainerCls, EntitiesBaseCls;


procedure TfrmPrintMode.FormCreate(Sender: TObject);
begin
  Self.CollapseAll;
  FWaitEvent := False;
  FGoNext := False;
  FGoPrevios := False;
  FDoClose := False;
  FMode := -1;
end;

procedure TfrmPrintMode.FormShow(Sender: TObject);
begin
  Self.Height := 440;
  Self.Width := 480;
  Self.Left := trunc((Screen.Width - Self.Width) / 2);
  Self.Top := trunc((Screen.Height - Self.Height) / 2);
  Self.ShowMainPage;
  Self.catbtnPrintMode.SelectedItem := nil;
  Self.catbtnExportMode.SelectedItem := nil;
end;

procedure TfrmPrintMode.ShowMainPage;
begin
  pnBottom.Visible := False;
  case FMode of
    0: pcMain.ActivePage := Self.tsModePrint;
    1: pcMain.ActivePage := Self.tsModeExport;
  end;
end;

procedure TfrmPrintMode.CollapseAll;
var
  I: integer;
begin
  for I := 0 to catbtnPrintMode.Categories.Count - 1 do
    catbtnPrintMode.Categories.Items[I].Collapsed := True;
end;

//

procedure TfrmPrintMode.WMClose(var Msg: TWMClose);
begin
  if not FWaitEvent then Self.Close
    else if Msg.Msg = WM_CLOSE then FDoClose := True;
end;

procedure TfrmPrintMode.btnCollapseClick(Sender: TObject);
begin
  Self.CollapseAll;
end;

procedure TfrmPrintMode.btnGoPreviosClick(Sender: TObject);
begin
  FGoPrevios := True;
end;

procedure TfrmPrintMode.btnNextClick(Sender: TObject);
var
  I: integer;
begin
  if pcMain.ActivePage = Self.tsSelectCheck then begin
    for I := 0 to cbCheck.Items.Count - 1 do
      if cbCheck.Checked[I] then FGoNext := True;
  end else FGoNext := True;

end;

function TfrmPrintMode.WaitForwardStep: boolean;
begin
  FWaitEvent := True;
  repeat
    Application.ProcessMessages;
  until (FGoNext = True) or (FGoPrevios = True) or (FDoClose = True);
  if FDoClose then Self.Close;
  Result := (FGoNext = True);
  FWaitEvent := False;
  FGoNext := False;
  FGoPrevios := False;
end;

//

procedure TfrmPrintMode.ShowPrintMaster;
begin
  FMode := 0;
  imgPrint.Visible := True;
  imgExport.Visible := False;
  Self.Caption := Translator.GetInstance.TranslateWord('Печать');
  lbPrintMode.Caption := Translator.GetInstance.TranslateMessage(
    61, 'Выберите, что вы хотите напечатать');
  Self.catbtnPrintMode.Categories.Items[0].Caption :=
    Translator.GetInstance.TranslateMessage(
      63, 'Печать заказов');
  Self.catbtnPrintMode.Categories.Items[1].Caption :=
    Translator.GetInstance.TranslateMessage(
      64, 'Печать списка коробок');
  Self.catbtnPrintMode.Categories.Items[2].Caption :=
    Translator.GetInstance.TranslateMessage(
      65, 'Печать ярлыков');
  Self.catbtnPrintMode.Categories.Items[3].Caption :=
    Translator.GetInstance.TranslateMessage(
      89, 'Печать инвойса');
  FLastButtonCaption := Translator.GetInstance.TranslateWord('Печать');
  Self.ShowModal;
end;

procedure TfrmPrintMode.ShowExportMaster;
begin
  FMode := 1;
  imgPrint.Visible := False;
  imgExport.Visible := True;
  Self.Caption := Translator.GetInstance.TranslateWord('Экспорт');
  lbExportMode.Caption := Translator.GetInstance.TranslateMessage(
    62, 'Выберите, что вы хотите экспортировать');
  Self.catbtnPrintMode.Categories.Items[0].Caption :=
    Translator.GetInstance.TranslateMessage(
      66, 'Шаблоны экспорта');
  FLastButtonCaption := Translator.GetInstance.TranslateWord('Экспорт');
  Self.ShowModal;
end;

//         

function TfrmPrintMode.GetRadioMode(var SelectMode: integer; ItIsLastStep: boolean = True): boolean;
begin
  rgRadio.Height := rgRadio.Items.Count * 35;
  rgRadio.ItemIndex := SelectMode + 1;
  if ItIsLastStep then begin
    btnNext.Font.Style := btnNext.Font.Style + [fsBold];
    btnNext.Caption := Translator.GetInstance.TranslateWord(FLastButtonCaption);
  end else begin
    btnNext.Font.Style := btnNext.Font.Style - [fsBold];
    btnNext.Caption := Translator.GetInstance.TranslateWord('Далее');
  end;
  pnBottom.Visible := True;
  pcMain.ActivePage := Self.tsSelectRadio;
  Result := WaitForwardStep;
  if Result then SelectMode := rgRadio.ItemIndex - 1;
  rgRadio.Items.Clear;
end;

function TfrmPrintMode.GetSortMode(var SortMode: integer; ItIsLastStep: boolean = True): boolean;
begin
  lbSelectRadio.Caption := Translator.GetInstance.TranslateMessage(
    54, 'Укажите порядок сортировки' + ':');
  rgRadio.Items.Clear;
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    46, 'без сортировки'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    47, 'по полному русскому наименованию'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    48, 'по английскому наименованию'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    49, 'по наименованию поставщика'));
  Result := GetRadioMode(SortMode, ItIsLastStep);
end;

function TfrmPrintMode.GetBoxSortMode(var SortMode: integer; ItIsLastStep: boolean = True): boolean;
begin
  lbSelectRadio.Caption := Translator.GetInstance.TranslateMessage(
    54, 'Укажите порядок сортировки' + ':');
  rgRadio.Items.Clear;
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    46, 'без сортировки'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    56, 'по номеру группы коробок'));
  Result := GetRadioMode(SortMode, ItIsLastStep);
end;

function TfrmPrintMode.GetOrderCopyMode(var CopyMode: integer; ItIsLastStep: boolean = True): boolean;
begin
  lbSelectRadio.Caption := Translator.GetInstance.TranslateMessage(
    55, 'Выберите условия выборки строк из заказа' + ':');
  rgRadio.Items.Clear;
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    50, 'все детали'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    51, 'только незагруженные'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    52, 'только перегруженные'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    53, 'только недозагруженные'));
  rgRadio.ItemIndex := CopyMode;
  if ItIsLastStep then begin
    btnNext.Font.Style := btnNext.Font.Style + [fsBold];
    btnNext.Caption := Translator.GetInstance.TranslateWord(FLastButtonCaption);
  end else begin
    btnNext.Font.Style := btnNext.Font.Style - [fsBold];
    btnNext.Caption := Translator.GetInstance.TranslateWord('Далее');
  end;
  pnBottom.Visible := True;
  pcMain.ActivePage := Self.tsSelectRadio;
  Result := WaitForwardStep;
  if Result then CopyMode := rgRadio.ItemIndex;
  rgRadio.Items.Clear;
end;

function TfrmPrintMode.SetCheckList(ObjectList: TObjectList): boolean;
var
  I: integer;
  Title: string;
begin
  lbSelectCheck.Caption := Translator.GetInstance.TranslateMessage(
    45, 'Выберите элементы для печати' + ':');
  cbCheck.Items.Clear;
  for I := 0 to ObjectList.Count - 1 do begin
    if (ObjectList.Items[I] is TOrder) then
      Title := TOrder(ObjectList.Items[I]).Title;
    if (ObjectList.Items[I] is TContainer) then
      Title := TContainer(ObjectList.Items[I]).Title;
    cbCheck.Items.AddObject(Title, ObjectList.Items[I]);
  end;
  btnNext.Font.Style := btnNext.Font.Style + [fsBold];
  btnNext.Caption := Translator.GetInstance.TranslateWord(FLastButtonCaption);
  pnBottom.Visible := True;
  pcMain.ActivePage := Self.tsSelectCheck;
  Result := WaitForwardStep;
end;

function TfrmPrintMode.GetExportMode(var ExportMode: integer; ItIsLastStep: boolean = True): boolean;
begin
  lbSelectRadio.Caption := Translator.GetInstance.TranslateMessage(
    80, 'Укажите формат выгрузки' + ':');
  rgRadio.Items.Clear;
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    75, 'в формате XLS'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    76, 'в формате ODT'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    77, 'в формате ODS'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    78, 'в формате PDF'));
  rgRadio.Items.Add(Translator.GetInstance.TranslateMessage(
    79, 'в формате TXT'));
  Result := GetRadioMode(ExportMode, ItIsLastStep);
  ExportMode := ExportMode + 1;
end;

function TfrmPrintMode.GetInvoiceSettings(var SupplierId: integer; var BuyerId: integer;
  var PortId: integer; var ContNum: string; var InvNum: string;
  var InvDate: TDate; var SpecNum: string): boolean;
var
  EntitiesBase: TEntitiesBase;
  Entities: TEntitiesArray;
  OneEntitie: TEntitiesRec;
  Ports: TPortsArray;
  Title: widestring;
  I: integer;
begin
  EntitiesBase := TEntitiesBase.Create;
  Self.cbSupplier.Clear;
  Self.cbBuyer.Clear;
  if EntitiesBase.GetEntities(Entities) then
    for I := 0 to High(Entities) do begin
      OneEntitie := Entities[I];
      if GlobalSettings.GetInstance.Language = 0 then Title := OneEntitie.RusName
        else Title := OneEntitie.EngName;
      if OneEntitie.IsSupplier then Self.cbSupplier.AddItem(
        Title, TObject(OneEntitie.id))
      else Self.cbBuyer.AddItem(Title, TObject(OneEntitie.id))
    end;
  if SupplierId < cbSupplier.Items.Count then cbSupplier.ItemIndex := SupplierId;
  if BuyerId < cbBuyer.Items.Count then cbBuyer.ItemIndex := BuyerId;
  Self.cbPort.Clear;
  if EntitiesBase.GetPorts(Ports) then
    for I := 0 to High(Ports) do Self.cbPort.AddItem(Ports[I], TObject(I + 1));
  if PortId < cbPort.Items.Count then cbPort.ItemIndex := PortId;
  EntitiesBase.Free;
  Self.edContNum.Text := ContNum;
  Self.edInvNum.Text := InvNum;
  Self.edInvDate.Date := InvDate;
  Self.edSpecNum.Text := SpecNum;
  //
  btnNext.Font.Style := btnNext.Font.Style + [fsBold];
  btnNext.Caption := Translator.GetInstance.TranslateWord(FLastButtonCaption);
  pnBottom.Visible := True;
  pcMain.ActivePage := Self.tsInvoiceSettings;
  Result := Self.WaitForwardStep;
  if Result then begin
    if cbSupplier.ItemIndex >= 0 then
      SupplierId := Integer(cbSupplier.Items.Objects[cbSupplier.ItemIndex]);
    if cbBuyer.ItemIndex >= 0 then
      BuyerId := Integer(cbBuyer.Items.Objects[cbBuyer.ItemIndex]);
    if cbPort.ItemIndex >= 0 then
      PortId := Integer(cbPort.Items.Objects[cbPort.ItemIndex]);
    ContNum := edContNum.Text;
    InvNum := edInvNum.Text;
    InvDate := edInvDate.Date;
    SpecNum := edSpecNum.Text;
  end;
end;


end.
