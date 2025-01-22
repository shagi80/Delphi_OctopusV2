unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, Menus, ImgList, StdActns,
  ActnList, OrderItemCls, DocumentCls, FileControllerCls, BoxCls, OrderCls,
  PartCls, AppEvnts;

const
  VERSION = 'Octopus 2.0';

type
  TfrmMain = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    lbSearch: TLabel;
    edSearch: TEdit;
    ToolButton1: TToolButton;
    btnSearch: TToolButton;
    btnSearchClear: TToolButton;
    ToolBar2: TToolBar;
    Label2: TLabel;
    cbView: TComboBox;
    mmMain: TMainMenu;
    FileItem: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    MenuItem1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    miView: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowTileItem2: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    dlgFileOpen: TOpenDialog;
    actMain: TActionList;
    FileNew: TAction;
    FileOpen: TAction;
    FileSave: TAction;
    FileSaveAs: TAction;
    FileExit: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout: TAction;
    imgMain: TImageList;
    ToolBar3: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    FilePrint: TAction;
    FileExport: TAction;
    SearchStart: TAction;
    SearchClear: TAction;
    ViewChange: TAction;
    dlgFileSave: TSaveDialog;
    miOrders: TMenuItem;
    miContainers: TMenuItem;
    ViewView: TAction;
    ViewBoxCreator: TAction;
    ViewInvoice: TAction;
    N2: TMenuItem;
    miViewPanels: TMenuItem;
    ViewPartForm: TAction;
    ViewOrdersForm: TAction;
    ViewBoxForm: TAction;
    ViewContainersForm: TAction;
    ViewInvoiceForm: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    OrderAdd: TAction;
    N8: TMenuItem;
    OrderDelete: TAction;
    OrderConcate: TAction;
    OrderAddPart: TAction;
    OrderDeletePart: TAction;
    OrderCopyPart: TAction;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    miOrderAddPart: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    OrderSearchPart: TAction;
    N15: TMenuItem;
    N16: TMenuItem;
    BoxNew: TAction;
    BoxLoadPart: TAction;
    BoxLoadPartAuto: TAction;
    BoxSaveInContainer: TAction;
    miBox: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    BoxUnloadPart: TAction;
    BoxDelete: TAction;
    OrderRename: TAction;
    OrderEditPart: TAction;
    OrderNewFromFile: TAction;
    N17: TMenuItem;
    N110: TMenuItem;
    Octopus1: TMenuItem;
    PartNew: TAction;
    PartEdit: TAction;
    PartCopy: TAction;
    PartDelete: TAction;
    PartSearch: TAction;
    OrderAddPartFromOther: TAction;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    miPart: TMenuItem;
    N12: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    OrderNewFrom1CAndMultiple: TAction;
    OrderSaveTo1C: TAction;
    N33: TMenuItem;
    ContainerSearchPart: TAction;
    Export1: TMenuItem;
    Print1: TMenuItem;
    N34: TMenuItem;
    InvoiceSearchPart: TAction;
    N35: TMenuItem;
    miInvoice: TMenuItem;
    N37: TMenuItem;
    miSeAmount: TMenuItem;
    N38: TMenuItem;
    ContainerAdd: TAction;
    ContainerEdit: TAction;
    ContainerDelete: TAction;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    InvoiceEditPart: TAction;
    N46: TMenuItem;
    HelpSettings: TAction;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    BoxNewAndLoad: TAction;
    N44: TMenuItem;
    N45: TMenuItem;
    N52: TMenuItem;
    ContainerAddBoxAndLoadPart: TAction;
    ContainerLoadPartToBox: TAction;
    ContaiinerLoadParAuto: TAction;
    ContainerUnloadPart: TAction;
    ContainerDeleteBox: TAction;
    N19: TMenuItem;
    ContainerAddBoxAndLoadPart1: TMenuItem;
    ContaiinerLoadParAuto1: TMenuItem;
    ContainerLoadPartToBox1: TMenuItem;
    ContainerUnloadPart1: TMenuItem;
    ContainerUnloadPart2: TMenuItem;
    ContainerEditBox: TAction;
    ContainerEditBox1: TMenuItem;
    N53: TMenuItem;
    ContainerAddInBoxSelect: TAction;
    ContainerAddInBoxMark: TAction;
    PartListUpdate: TAction;
    ContainerChangeGross: TAction;
    ContainerChangeGross1: TMenuItem;
    N54: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    InvoiceChageTotalCost: TAction;
    FileMerge: TAction;
    FileMerge1: TMenuItem;
    N36: TMenuItem;
    procedure FileMergeExecute(Sender: TObject);
    procedure HelpAboutExecute(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure HelpSettingsExecute(Sender: TObject);
    procedure FileExportExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileExitExecute(Sender: TObject);
    procedure FilePrintExecute(Sender: TObject);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchClearExecute(Sender: TObject);
    procedure SearchStartExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDocument: TDocument;
    procedure OnNewDocument(Sender: TObject);
    procedure OnSaveDocument(Sender: TObject);
    procedure OnChangeDataModel(Sender: TObject; UpdateInterface: boolean);
    procedure OnSelectOrderItem(OrderItem: TOrderItem);
    procedure OnSelectInvoicePart(Part: TPart);
    procedure OnSelectBox(Box: TBox);
    procedure OnChangeLanguage(Sender: TObject);
  public
    { Public declarations }
    FileController: TFileController;
    property Document: TDocument read FDocument;
  published
    procedure UpdateInterface(Sender: TObject);
    procedure UpdateAccesMode(Sender: TObject);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  ViewControllerCls, OrdersForm, ContainerForm, BoxForm, PartPropertyForm,
  InvoiceForm, OrderControllerCls, BoxControllerCls, PartControllerCls,
  AccesManagerCls, GlobalSettingsCls, WaitingForm, SearchForm, LoggerCls,
  PrintModeForm, PrintOrderControllerCls, PrintContainerControllerCls,
  ContainerControllerCls, ExportControllerCls, InvoiceControllerCls,
  SettingsForm, FormTranslatorCls, ContainerEditForm, InputForm, PartEditorForm,
  PartListForm, PrintInvoiceControllerCls, BoxItemAddForm, BoxAutoCreateForm,
  PartListUpdateForm, PartListCls, DocLoaderCls, GrossWeightSettingsForm,
  PriceChangeSetiingsForm, AboutForm, MergeDocManagerCls;

var
  ViewController: TViewController;
  OrderController: TOrderController;
  BoxController: TBoxController;
  PartController: TPartController;
  PrintOrderController: TPrintOrderController;
  PrintContainerController: TPrintContainerController;
  ContainerController: TContainerController;
  ExportController: TExportController;
  InvoiceController: TInvoiceController;
  PrintInvoiceController: TPrintInvoiceController;

//

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Screen.OnActiveControlChange := UpdateInterface;
  Logger := TLogger.Create('log.txt');
  // Создание объектов.
  FDocument := TDocument.Create;
  ViewController := TViewController.Create(Self);
  FileController := TFileController.Create(FDocument, dlgFileSave, dlgFileOpen);
  PartController := TPartController.Create(FDocument);
  OrderController := TOrderController.Create(FDocument);
  BoxController := TBoxController.Create(FDocument);
  ContainerController := TContainerController.Create(FDocument);
  PrintOrderController := TPrintOrderController.Create(FDocument);
  PrintContainerController := TPrintContainerController.Create(FDocument);
  ExportController := TExportController.Create(FDocument);
  InvoiceController := TInvoiceController.Create(FDocument);
  PrintInvoiceController := TPrintInvoiceController.Create(FDocument);
  //
  {if DecimalSeparator <> ',' then begin
    Application.UpdateFormatSettings := False;
    DecimalSeparator := ','
  end;}
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveControlChange := nil;
  Logger.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // Подключение TAction к контроллерам.
  ViewPartForm.OnExecute := ViewController.ShowFormExecute;
  ViewOrdersForm.OnExecute := ViewController.ShowFormExecute;
  ViewBoxForm.OnExecute := ViewController.ShowFormExecute;
  ViewContainersForm.OnExecute := ViewController.ShowFormExecute;
  ViewInvoiceForm.OnExecute := ViewController.ShowFormExecute;
  ViewView.OnExecute := ViewController.ViewChangeExecute;
  ViewBoxCreator.OnExecute := ViewController.ViewChangeExecute;
  ViewInvoice.OnExecute := ViewController.ViewChangeExecute;
  cbView.OnChange := ViewController.ViewChangeExecute;

  FileNew.OnExecute := FileController.NewDocument;
  FileOpen.OnExecute := FileController.LoadDocument;
  FileSave.OnExecute := FileController.SaveDocument;
  FileSaveAs.OnExecute := FileController.SaveAsDocument;
  FileController.OnSaveDocument := OnSaveDocument;

  PartNew.OnExecute := PartController.PartNewExecute;
  PartCopy.OnExecute := PartController.PartCopyExecute;
  PartEdit.OnExecute := PartController.PartEditExecute;
  PartDelete.OnExecute := PartController.PartDeleteExecute;
  PartSearch.OnExecute := PartController.PartSearchExecute;
  PartListUpdate.OnExecute := PartController.PartListUpdate;

  OrderAdd.OnExecute := OrderController.OrderAddExecute;
  OrderNewFromFile.OnExecute := OrderController.OrderAddExecute;
  OrderNewFrom1CAndMultiple.OnExecute := OrderController.OrderAddExecute;
  OrderConcate.OnExecute := OrderController.OrderConcateExecute;
  OrderRename.OnExecute := OrderController.OrderRenameExecute;
  OrderDelete.OnExecute := OrderController.OrderDeleteExecute;
  OrderAddPart.OnExecute := OrderController.OrderAddPartExecute;
  OrderDeletePart.OnExecute := OrderController.OrderDeletePartExecute;
  OrderCopyPart.OnExecute := OrderController.OrderCopyPartExecute;
  OrderSearchPart.OnExecute := OrderController.OrderSearchPartExecute;
  OrderEditPart.OnExecute := OrderController.OrderEditPartExecute;
  OrderAddPartFromOther.OnExecute := OrderController.OrderAddPartFromFileExecute;
  OrderSaveTo1C.OnExecute := OrderController.OrderSaveTo1C;

  BoxNew.OnExecute := BoxController.BoxNew;
  BoxNewAndLoad.OnExecute := BoxController.BoxNewAndLoadPart;
  BoxLoadPart.OnExecute := BoxController.BoxLoadPart;
  BoxLoadPartAuto.OnExecute := BoxController.BoxLoadPartAuto;
  BoxSaveInContainer.OnExecute := BoxController.BoxSaveInContainer;
  BoxUnloadPart.OnExecute := Boxcontroller.BoxUnloadPart;
  BoxDelete.OnExecute := BoxController.BoxDelete;

  ContainerAdd.OnExecute := ContainerController.ContainerAdd;
  ContainerEdit.OnExecute := ContainerController.ContainerEdit;
  ContainerDelete.OnExecute := ContainerController.ContainerDelete;
  ContainerSearchPart.OnExecute := ContainerController.SearchPart;
  ContainerAddBoxAndLoadPart.OnExecute := ContainerController.ContainerAddAiiInOne;
  ContaiinerLoadParAuto.OnExecute := ContainerController.ContainerAddSeparately;
  ContainerEditBox.OnExecute := ContainerController.ContainerEditBox;
  ContainerLoadPartToBox.OnExecute := ContainerController.ContainerLoadInBox;
  ContainerUnloadPart.OnExecute := ContainerController.ContainerUnloadFromBox;
  ContainerDeleteBox.OnExecute := ContainerController.ContainerDeleteBox;
  ContainerAddInBoxSelect.OnExecute := ContainerController.ContainerAddInOneSelect;
  ContainerAddInBoxMark.OnExecute := ContainerController.ContainerAddInOneMark;
  ContainerChangeGross.OnExecute := ContainerController.ContainerChangeGross;

  InvoiceSearchPart.OnExecute := InvoiceController.SearchPart;
  Self.InvoiceChageTotalCost.OnExecute := InvoiceController.ChangeTotalCost;
  InvoiceEditPart.OnExecute := InvoiceController.EditPart;

    // Подключение кнопок форм к TAction.
  frmPartProperty.tbEdit.Images := Self.imgMain;
  frmPartProperty.tbView.Images := Self.imgMain;
  frmPartProperty.btnPartAdd.Action := PartNew;
  frmPartProperty.btnPartCopy.Action := PartCopy;
  frmPartProperty.btnPartEdit.Action := PartEdit;
  frmPartProperty.btnPartDelete.Action := PartDelete;
  frmPartProperty.btnSearchPart.Action := PartSearch;
  frmPartProperty.btnPartListUpdate.Action := PartListUpdate;

  frmOrders.tbEdit.Images := Self.imgMain;
  frmOrders.btnOrderAdd.Action := OrderAdd;
  frmOrders.miNewEmpty.Action := OrderAdd;
  frmOrders.miNewFromFile.Action := OrderNewFromFile;
  frmOrders.miNew1CMult.Action := OrderNewFrom1CAndMultiple;
  frmOrders.btnOrderCancate.Action := OrderConcate;
  frmOrders.btnOrderEditTitle.Action := OrderRename;
  frmOrders.btnOrderDelete.Action := OrderDelete;
  frmOrders.btnPartAdd.Action := OrderAddPart;
  frmOrders.btnPartEdit.Action := OrderEditPart;
  frmOrders.btnPartDelete.Action := OrderDeletePart;
  frmOrders.miAddPart.Action := OrderAddPart;
  frmOrders.miAddFromOther.Action := OrderAddPartFromOther;
  frmOrders.miCopyPart.Action := OrderCopyPart;
  frmOrders.miNewPart.Action := PartNew;
  frmOrders.btnSearchPart.Action := OrderSearchPart;
  frmOrders.btnOrderSave.Action := OrderSaveTo1C;
  frmOrders.btnPartListUpdate.Action := PartListUpdate;

  frmBox.tbEditTools.Images := Self.imgMain;
  frmBox.btnNewBox.Action := BoxNew;
  frmBox.btnNewBoxAndLoad.Action := BoxNewAndLoad;
  frmBox.btnLoadPart.Action := BoxLoadPart;
  frmBox.btnSaveBox.Action := BoxSaveInContainer;
  frmBox.btnUnloadPart.Action := BoxUnloadPart;
  frmBox.btnDeleteBox.Action := BoxDelete;
  frmBox.btnAddPartAuto.Action := BoxLoadPartAuto;

  frmContainers.tbEdit.Images := imgMain;
  frmContainers.btnContainerAdd.Action := ContainerAdd;
  frmContainers.btnContainerEdit.Action := ContainerEdit;
  frmContainers.btnContainerDelete.Action := ContainerDelete;
  frmContainers.btnSearchPart.Action := ContainerSearchPart;
  frmContainers.btnAddBoxAndLoad.Action := ContainerAddBoxAndLoadPart;
  frmContainers.btnLoadPart.Action := ContainerLoadPartToBox;
  frmContainers.btnLoadPartAuto.Action := ContaiinerLoadParAuto;
  frmContainers.btnEditBox.Action := ContainerEditBox;
  frmContainers.btnUnloadPart.Action := ContainerUnloadPart;
  frmContainers.btnDeleteBox.Action := ContainerDeleteBox;
  frmContainers.miDelataItem.Action := ContainerUnloadPart;
  frmContainers.miDeleteBox.Action := ContainerDeleteBox;
  frmContainers.miEdit.Action := ContainerEditBox;
  frmContainers.miAddInBoxSelected.Action := ContainerAddInBoxSelect;
  frmContainers.miAddInBoxMark.Action := ContainerAddInBoxMark;
  frmContainers.btnChangeGross.Action := ContainerChangeGross;

  frmInvoice.btnSearchPart.Action := InvoiceSearchPart;
  frmInvoice.btnChageTotalCost.Action := InvoiceChageTotalCost;
  frmInvoice.btnEditPart.Action := InvoiceEditPart;
  frmInvoice.btnPartListUpdate.OnClick := PartListUpdate.OnExecute;

  frmPrintMode.OrderAll.OnExecute := PrintOrderController.PrintAll;
  frmPrintMode.OrderCurrent.OnExecute := PrintOrderController.PrintCurrent;
  frmPrintMode.OrderSelect.OnExecute := PrintOrderController.PrintSelect;
  frmPrintMode.ContainerAll.OnExecute := PrintContainerController.PrintAllContainer;
  frmPrintMode.ContainerCurrent.OnExecute := PrintContainerController.PrintCurrentContainer;
  frmPrintMode.ContainerSelect.OnExecute := PrintContainerController.PrintSelectContainer;
  frmPrintMode.LabelAll.OnExecute := PrintContainerController.PrintAllBox;
  frmPrintMode.LabelCurrentContainer.OnExecute := PrintContainerController.PrintBoxFromCurrentContainer;
  frmPrintMode.LabelSelectContainer.OnExecute := PrintContainerController.PrintBoxFromSelectContainer;
  frmPrintMode.LabelSelect.OnExecute := PrintContainerController.PrintSelectBoxFromSelectContainer;
  frmPrintMode.ExportFor1C.OnExecute := ExportController.ExportFor1C;
  frmPrintMode.ExportForInvoice.OnExecute := ExportController.ExportForInvoice;
  frmPrintMode.ExportForCustomCode.OnExecute := ExportController.ExportForCustomCode;
  frmPrintMode.PrintInvoiceAll.OnExecute := PrintInvoiceController.PrintInvoiceAll;

  // Подключение событий контролллетов и форм.
  GlobalSettings.GetInstance.OnLanguageChange := Self.OnChangeLanguage;
  ViewController.OnChange := Self.UpdateInterface;
  FileController.OnNewDocument := OnNewDocument;
  PartController.OnChangeModel := Self.OnChangeDataModel;
  OrderController.OnChangeModel := Self.OnChangeDataModel;
  BoxController.OnChangeModel := Self.OnChangeDataModel;
  ContainerController.OnChangeModel := Self.OnChangeDataModel;
  InvoiceController.OnChangeModel := Self.OnChangeDataModel;

  frmPartProperty.OnDoubleClick := PartEdit.OnExecute;

  frmOrders.OnDoubleClick := OrderEditPart.OnExecute;
  frmOrders.OnSelectItem := OnSelectOrderItem;
  frmOrders.grOrder.OnEndEdit := OrderController.OnEndEditGrid;

  frmBox.OnSelectItem := Self.UpdateInterface;
  frmBox.OnModifiedBoxForm := Self.UpdateInterface;
  frmBox.OnDragDrop := BoxController.OnDragDrop;
  frmBox.grBox.OnEndEdit := BoxController.OnEndEditGrid;

  frmContainers.OnSelectBox := OnSelectBox;
  frmContainers.OnDoubleClick := ContainerController.ContainerDblClick;
  frmContainers.OnDragDrop := ContainerController.OnDragDrop;
  frmContainers.grContainer.OnEndEdit := ContainerController.OnEndEditGrid;

  frmInvoice.OnSelectPart := OnSelectInvoicePart;
  frmInvoice.OnDoubleClick := InvoiceEditPart.OnExecute;
  frmInvoice.grInvoice.OnEndEdit := InvoiceController.OnEndEditGrid;

  // Создание нового документа.
  AccesManager.GetInstance.SetAccessLevel(GlobalSettings.GetInstance.AccessPassword);
  Self.UpdateAccesMode(Self);
  FileController.LoadDefaultDocument;
  OnChangeLanguage(Self);
  ViewController.CurrentView := GlobalSettings.GetInstance.DefaultView;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FileController.CanDocumentFree then Action := caNone;
end;

//

procedure TfrmMain.SearchClearExecute(Sender: TObject);
begin
  edSearch.Text := '';
end;

procedure TfrmMain.SearchStartExecute(Sender: TObject);
begin
  if Length(edSearch.Text) > 0 then frmSearch.SearchTitle(edSearch.Text);
end;

procedure TfrmMain.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  Pt: TPoint;
  Cntr, ParentCntr: TWinControl;
begin
  if Msg.message <> WM_MOUSEMOVE then Exit;
  Pt := Point(Msg.pt.X, Msg.pt.Y);
  Cntr := FindControl(WindowFromPoint(Pt));
  if (Cntr <> nil) then begin
    ParentCntr := Cntr.Parent;
    while (ParentCntr is TWinControl) and (ParentCntr.Parent <> nil) do
      ParentCntr := ParentCntr.Parent;
    if ParentCntr = frmContainers then
      frmContainers.CursorInClient(Pt.X, Pt.Y, Cntr);
    if ParentCntr = frmGrossWeightSettings then
      frmGrossWeightSettings.CursorInClien(Pt.X, Pt.Y, Cntr);
    if ParentCntr = frmPriceChangeSetiings then
      frmPriceChangeSetiings.CursorInClien(Pt.X, Pt.Y, Cntr);
  end;
end;

procedure TfrmMain.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then Self.SearchStartExecute(Self);
end;

procedure TfrmMain.FileExitExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmMain.FileExportExecute(Sender: TObject);
begin
  if FDocument.Orders.Count > 0 then PrintModeForm.frmPrintMode.ShowExportMaster;
end;

procedure TfrmMain.FileMergeExecute(Sender: TObject);
var
  MergeDocManager: TMergeDocManager;
begin
  if not dlgFileOpen.Execute then Exit;
  MergeDocManager := TMergeDocManager.Create(FDocument);
  if MergeDocManager.Merge(dlgFileOpen.FileName, frmContainers.CurrentContainer) then begin
    if FDocument.Parts.Count > 0 then
      frmPartProperty.Part := FDocument.Parts.Items[0];
    frmOrders.RefreshTabs(Self);
    if FDocument.Orders.Count > 0 then frmOrders.ShowOrder(FDocument.Orders.Last);
    frmContainers.RefreshTabs(Self);
    frmContainers.ShowContainer(FDocument.Containers.Last);
    frmInvoice.RefreshGrid(Self);
    Self.OnChangeDataModel(Self, True);
  end;
  MergeDocManager.Free;
end;

procedure TfrmMain.FilePrintExecute(Sender: TObject);
begin
  if FDocument.Orders.Count > 0 then PrintModeForm.frmPrintMode.ShowPrintMaster
end;

procedure TfrmMain.HelpAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.HelpSettingsExecute(Sender: TObject);
var
  Part: TPart;
begin
  Part := frmPartProperty.Part;
  if frmSettings.ShowModal = mrOk then begin
    Self.UpdateAccesMode(Self);
    Self.UpdateInterface(Self);
    frmPartProperty.RefreshGrid(Self);
    frmOrders.RefreshGrid(Self);
    frmContainers.RefreshGrid(Self);
    frmBox.RefreshData(Self);
    frmInvoice.RefreshGrid(Self);
    frmPartProperty.Part := Part;
  end;
end;

//

procedure TfrmMain.OnNewDocument(Sender: TObject);
var
  FileName: string;
begin
  if (FDocument.Orders.Count > 0) then frmWaiting.WaitTableUpdate;
  if Length(FDocument.FileName) = 0 then FileName := 'No name'
    else FileName :=  ExtractFileName(FDocument.FileName);
  Self.Caption := VERSION + ' - ' + FileName;
  FDocument.IsModified := False;
  frmOrders.Document := FDocument;
  frmContainers.Document := FDocument;
  frmSearch.Document := FDocument;
  frmBoxAutoCreate.Document := FDocument;
  frmInvoice.Document := FDocument;
  frmBox.Document := FDocument;
  frmBox.Box := nil;
  if FDocument.Parts.Count > 0 then frmPartProperty.Part := FDocument.Parts.Items[0]
    else frmPartProperty.Part := nil;
  UpdateInterface(Self);
  frmWaiting.Hide;
end;

procedure TfrmMain.OnSaveDocument(Sender: TObject);
begin
  Self.Caption := VERSION + ' - ' +FDocument.FileName;
  FDocument.IsModified := False;
  UpdateInterface(Self);
end;

procedure TfrmMain.OnChangeDataModel(Sender: TObject; UpdateInterface: boolean);
begin
  FDocument.IsModified := True;
  FileSave.Enabled := FDocument.IsModified;
  if UpdateInterface then Self.UpdateInterface(Sender);
end;

procedure TfrmMain.OnSelectOrderItem(OrderItem: TOrderItem);
begin
  if OrderItem <> nil then frmPartProperty.Part := OrderItem.Part;
  Self.UpdateInterface(Self);
end;

procedure TfrmMain.OnSelectBox(Box: TBox);
begin
  if {ViewController.CurrentView = vwBoxCreator} frmBox.Visible then frmBox.Box := Box;
  Self.UpdateInterface(Self);
end;

procedure TfrmMain.OnSelectInvoicePart(Part: TPart);
begin
  Self.UpdateInterface(Self);
end;

procedure TfrmMain.OnChangeLanguage(Sender: TObject);
var
  FormTranslator: TFormTranslator;
  I: integer;
begin
  FormTranslator := TFormTranslator.Create(GlobalSettings.GetInstance.Language);
  for i := 0 to Application.ComponentCount - 1 do
    if (Application.Components[i] is TForm) then
      FormTranslator.Translate((Application.Components[i] as TForm));
  ViewController.UpdatrViewList(Self.cbView);
  FormTranslator.Free;
end;

//

procedure TfrmMain.UpdateAccesMode(Sender: TObject);
begin
  frmPartProperty.EditMode := AccesManager.GetInstance.CanEditParts;
  frmOrders.EditMode := AccesManager.GetInstance.CanEditOrders;
  frmOrders.BoxCreatorMode := (AccesManager.GetInstance.CanEditBoxes);
   // and (ViewController.CurrentView = vwBoxCreator);
  frmContainers.EditContainer := AccesManager.GetInstance.CanEditContainers;
  frmContainers.EditBoxes := (AccesManager.GetInstance.CanEditBoxes)
    and (ViewController.CurrentView <> vwInvoice);
  frmBox.EditMode := AccesManager.GetInstance.CanEditBoxes;
  frmInvoice.EditMode := AccesManager.GetInstance.CanEditInvoice;
  Self.UpdateInterface(Self);
end;

procedure TfrmMain.UpdateInterface(Sender: TObject);
begin
  miPart.Visible := (frmPartProperty.Visible and AccesManager.GetInstance.CanEditParts);
  miOrders.Visible := (frmOrders.Visible and AccesManager.GetInstance.CanEditOrders) ;
  miOrderAddPart.Enabled := (AccesManager.GetInstance.CanEditOrders) and (frmOrders.CurrentOrder <> nil);
  miContainers.Visible := (frmContainers.Visible and AccesManager.GetInstance.CanEditContainers);
  miBox.Visible := (frmBox.Visible and AccesManager.GetInstance.CanEditBoxes);
  miInvoice.Visible := (frmInvoice.Visible and AccesManager.GetInstance.CanEditInvoice);
  miSeAmount.Enabled := (frmInvoice.Invoice <> nil);

  FileSave.Enabled := FDocument.IsModified;
  FileSaveAs.Enabled := (FDocument.Parts.Count > 0);
  FilePrint.Enabled := (FDocument.Orders.Count > 0);
  FileExport.Enabled := (FDocument.Orders.Count > 0);
  SearchStart.Enabled := FDocument.Parts.Count > 0;
  SearchClear.Enabled := SearchStart.Enabled;
  edSearch.Enabled := SearchStart.Enabled;
  lbSearch.Enabled := SearchStart.Enabled;

  ViewView.Checked := (ViewController.CurrentView = vwView);
  ViewBoxCreator.Checked := (ViewController.CurrentView = vwBoxCreator);
  ViewInvoice.Checked := (ViewController.CurrentView = vwInvoice);
  if cbView.ItemIndex <> ViewController.CurrentView then cbView.ItemIndex := ViewController.CurrentView;

  ViewPartForm.Visible := (ViewController.CurrentView = vwView);
  ViewOrdersForm.Visible := ((ViewController.CurrentView = vwView)
    or (ViewController.CurrentView = vwBoxCreator));
  ViewBoxForm.Visible := (ViewController.CurrentView = vwBoxCreator);
  ViewContainersForm.Visible := ((ViewController.CurrentView = vwView)
    or (ViewController.CurrentView = vwBoxCreator) or (ViewController.CurrentView = vwInvoice));
  ViewInvoiceForm.Visible := (ViewController.CurrentView = vwInvoice);
  ViewPartForm.Checked := frmPartProperty.Visible;
  ViewOrdersForm.Checked := frmOrders.Visible;
  ViewBoxForm.Checked := frmBox.Visible;
  ViewContainersForm.Checked := frmContainers.Visible;
  ViewInvoiceForm.Checked := frmInvoice.Visible;

  PartNew.Enabled := (AccesManager.GetInstance.CanEditParts);
  PartEdit.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmPartProperty.Part <> nil);
  PartCopy.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmPartProperty.Part <> nil);
  PartDelete.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmPartProperty.Part <> nil);
  PartSearch.Enabled := (frmPartProperty.Part <> nil);
  PartListUpdate.Enabled := (FDocument.Parts.Count > 0);

  OrderDelete.Enabled := (frmOrders.CurrentOrder <> nil);
  OrderConcate.Enabled := (FDocument.Orders.Count > 1);
  OrderRename.Enabled := (frmOrders.CurrentOrder <> nil);
  OrderAddPart.Enabled := (frmOrders.CurrentOrder <> nil);
  OrderEditPart.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmOrders.SelectItem <> nil);
  OrderDeletePart.Enabled := (frmOrders.SelectItem <> nil);
  OrderCopyPart.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmOrders.SelectItem <> nil);
  OrderSearchPart.Enabled := (frmOrders.SelectItem <> nil);
  OrderSaveTo1C.Enabled:= (frmOrders.CurrentOrder <> nil);

  BoxNew.Enabled := (FDocument.Orders.Count > 1);
  BoxLoadPart.Enabled := (frmOrders.SelectItem <> nil);
  BoxNewAndLoad.Enabled := (frmOrders.SelectItem <> nil);
  BoxLoadPartAuto.Enabled := (frmOrders.SelectItem <> nil) and (frmContainers.CurrentContainer <> nil);
  BoxSaveInContainer.Enabled := (frmBox.Modified) and (frmContainers.CurrentContainer <> nil);
  BoxUnloadPart.Enabled := (frmBox.SelectItem <> nil);
  BoxDelete.Enabled := (FDocument.Orders.Count > 1) and (frmBox.Box <> nil);

  ContainerAdd.Enabled := (FDocument <> nil);
  ContainerEdit.Enabled := (frmContainers.CurrentContainer <> nil);
  ContainerDelete.Enabled := (frmContainers.CurrentContainer <> nil);
  ContainerSearchPart.Enabled := (frmContainers.SelectBoxItem <> nil);
  ContainerAddBoxAndLoadPart.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.CurrentContainer <> nil) and (frmOrders.SelectItem <> nil)
    and (frmContainers.EditBoxes);
  ContainerLoadPartToBox.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBox <> nil) and (frmOrders.SelectItem <> nil)
    and (frmContainers.EditBoxes);
  Self.ContaiinerLoadParAuto.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.CurrentContainer <> nil) and (frmOrders.SelectItem <> nil)
    and (frmContainers.EditBoxes);
  ContainerEditBox.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBoxItem <> nil) and (frmContainers.EditBoxes);
  ContainerUnloadPart.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBoxItem <> nil) and (frmContainers.EditBoxes);
  ContainerDeleteBox.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBox <> nil) and (frmContainers.EditBoxes);
  ContainerAddInBoxSelect.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBox <> nil) and (frmOrders.SelectItem <> nil)
    and (frmContainers.EditBoxes);
  ContainerAddInBoxMark.Enabled := (AccesManager.GetInstance.CanEditBoxes)
    and (frmContainers.SelectBox <> nil) and (frmOrders.SelectItem <> nil)
    and (frmContainers.EditBoxes);
  ContainerChangeGross.Enabled :=(frmContainers.CurrentContainer <> nil);

  InvoiceSearchPart.Enabled := (frmInvoice.SelectedPart <> nil);
  InvoiceChageTotalCost.Enabled := (frmInvoice.Invoice <> nil) and (frmInvoice.Invoice.Count > 0);
  InvoiceEditPart.Enabled := (AccesManager.GetInstance.CanEditParts) and (frmInvoice.SelectedPart <> nil);
end;

end.
