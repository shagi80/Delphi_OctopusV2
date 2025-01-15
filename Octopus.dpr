program Octopus;

uses
  Forms,
  Windows,
  MainForm in 'MainForm.pas' {frmMain},
  PartPropertyForm in 'PartPropertyForm.pas' {frmPartProperty},
  OrdersForm in 'OrdersForm.pas' {frmOrders},
  ContainerForm in 'ContainerForm.pas' {frmContainers},
  BoxForm in 'BoxForm.pas' {frmBox},
  InvoiceForm in 'InvoiceForm.pas' {frmInvoice},
  ViewControllerCls in 'ActionControllerCls\ViewControllerCls.pas',
  BoxCls in 'ModelCls\BoxCls.pas',
  BoxItemCls in 'ModelCls\BoxItemCls.pas',
  ContainerCls in 'ModelCls\ContainerCls.pas',
  ContainerListCls in 'ModelCls\ContainerListCls.pas',
  DocumentCls in 'ModelCls\DocumentCls.pas',
  OrderCls in 'ModelCls\OrderCls.pas',
  OrderItemCls in 'ModelCls\OrderItemCls.pas',
  OrderListCls in 'ModelCls\OrderListCls.pas',
  PartCls in 'ModelCls\PartCls.pas',
  PartListCls in 'ModelCls\PartListCls.pas',
  FindInShipmentCls in 'ToolCls\FindInShipmentCls.pas',
  FormTranslatorCls in 'ToolCls\FormTranslatorCls.pas',
  GlobalSettingsCls in 'ToolCls\GlobalSettingsCls.pas',
  TranslatorCls in 'ToolCls\TranslatorCls.pas',
  SQLite3 in 'Source\SQLite3.pas',
  SQLite3Utils in 'Source\SQLite3Utils.pas',
  SQLite3Wrap in 'Source\SQLite3Wrap.pas',
  OctopusGridCls in 'ControlCls\OctopusGridCls.pas',
  FileControllerCls in 'ActionControllerCls\FileControllerCls.pas',
  DragObjectCls in 'ModelCls\DragObjectCls.pas',
  OrderControllerCls in 'ActionControllerCls\OrderControllerCls.pas',
  BoxControllerCls in 'ActionControllerCls\BoxControllerCls.pas',
  AccesManagerCls in 'ToolCls\AccesManagerCls.pas',
  InputForm in 'InputForm.pas' {frmInput},
  SelectOrdersForm in 'SelectOrdersForm.pas' {frmSelectOrders},
  PartEditorForm in 'PartEditorForm.pas' {frmPartEditor},
  PartControllerCls in 'ActionControllerCls\PartControllerCls.pas',
  PartListForm in 'PartListForm.pas' {frmPartList},
  SearchForm in 'SearchForm.pas' {frmSearch},
  PrintModeForm in 'PrintModeForm.pas' {frmPrintMode},
  PrintOrderControllerCls in 'ActionControllerCls\PrintOrderControllerCls.pas',
  PrintContainerControllerCls in 'ActionControllerCls\PrintContainerControllerCls.pas',
  PrintDataModule in 'PrintDataModule.pas' {dmPrint: TDataModule},
  WaitingForm in 'WaitingForm.pas' {frmWaiting},
  DocLoaderCls in 'ToolCls\DocLoaderCls.pas',
  DocSaverCls in 'ToolCls\DocSaverCls.pas',
  ContainerControllerCls in 'ActionControllerCls\ContainerControllerCls.pas',
  ExportControllerCls in 'ActionControllerCls\ExportControllerCls.pas',
  MultiplierManagerCls in 'ToolCls\MultiplierManagerCls.pas',
  InvoiceCls in 'ModelCls\InvoiceCls.pas',
  InvoiceControllerCls in 'ActionControllerCls\InvoiceControllerCls.pas',
  LoggerCls in 'ToolCls\LoggerCls.pas',
  ContainerEditForm in 'ContainerEditForm.pas' {frmContainerEdit},
  SettingsForm in 'SettingsForm.pas' {frmSettings},
  EntitiesBaseCls in 'ToolCls\EntitiesBaseCls.pas',
  PrintInvoiceControllerCls in 'ActionControllerCls\PrintInvoiceControllerCls.pas',
  BoxAutoCreateForm in 'BoxAutoCreateForm.pas' {frmBoxAutoCreate},
  PartListUpdateForm in 'PartListUpdateForm.pas' {frmPartListUpdate},
  GrossManagerCls in 'ToolCls\GrossManagerCls.pas',
  GrossWeightSettingsForm in 'GrossWeightSettingsForm.pas' {frmGrossWeightSettings},
  PriceChangeSetiingsForm in 'PriceChangeSetiingsForm.pas' {frmPriceChangeSetiings},
  AboutForm in 'AboutForm.pas' {frmAbout};

{$R *.res}
var
  HM: THandle;

function Check: boolean;
const
  MutexName = 'OctopusV2_Mutex';
begin
  HM := OpenMutex(MUTEX_ALL_ACCESS, false, MutexName);
  Result := (HM <> 0);
  if HM = 0 then
    HM := CreateMutex(nil, false, MutexName);
end;

begin
  if Check then begin 
    Application.MessageBox('ATTENTION!!! The program is already running !',
      'Octopus V2',0);
    Exit;
  end;
  Application.Initialize;
  Application.Title := 'OctopusV2';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPartProperty, frmPartProperty);
  Application.CreateForm(TfrmOrders, frmOrders);
  Application.CreateForm(TfrmContainers, frmContainers);
  Application.CreateForm(TfrmBox, frmBox);
  Application.CreateForm(TfrmInvoice, frmInvoice);
  Application.CreateForm(TfrmInput, frmInput);
  Application.CreateForm(TfrmSelectOrders, frmSelectOrders);
  Application.CreateForm(TfrmPartEditor, frmPartEditor);
  Application.CreateForm(TfrmPartList, frmPartList);
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.CreateForm(TfrmPrintMode, frmPrintMode);
  Application.CreateForm(TdmPrint, dmPrint);
  Application.CreateForm(TfrmWaiting, frmWaiting);
  Application.CreateForm(TfrmContainerEdit, frmContainerEdit);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmBoxAutoCreate, frmBoxAutoCreate);
  Application.CreateForm(TfrmPartListUpdate, frmPartListUpdate);
  Application.CreateForm(TfrmGrossWeightSettings, frmGrossWeightSettings);
  Application.CreateForm(TfrmPriceChangeSetiings, frmPriceChangeSetiings);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
