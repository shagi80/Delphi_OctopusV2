unit PrintInvoiceControllerCls;

interface

uses
   InvoiceCls, DocumentCls, OrderListCls, frxClass, EntitiesBaseCls, Controls;

type
  TPrintInvoiceController = class(TObject)
  private
    FDocument: TDocument;
    FInvoice: TInvoice;
    FSupplier: TEntitiesRec;
    FBuyer: TEntitiesRec;
    FPort: string;
    FContNum: string;
    FInvNum: string;
    FInvDate: TDate;
    FPriceDate: TDate;
    FPriceValidDate: TDate;
    FSpecNum: string;
    procedure CannotPrintMessage;
    procedure ResizePrintModeForm;
    procedure Print(FileName: string);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure PrintInvoiceAll(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, OrderItemCls,
 SysUtils, OrdersForm, Forms, GlobalSettingsCls, PrintDataModule,
 WaitingForm;

const
  pfInvoiceAll = 'invoice_document.fr3';

constructor TPrintInvoiceController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FInvoice := nil;
end;

destructor TPrintInvoiceController.Destroy;
begin
  FDocument := nil;
  inherited Destroy;
end;

procedure TPrintInvoiceController.CannotPrintMessage;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    44, 'Нет данных для печати' + ' !');
  MessageDlg(Text, mtWarning, [mbOk], 0);
end;

procedure TPrintInvoiceController.ResizePrintModeForm;
begin
  frmPrintMode.pnBottom.Visible := False;
  frmPrintMode.Width := frmPrintMode.imgPrint.Width + 10;
  frmPrintMode.Height := frmPrintMode.imgPrint.Height + 30;
  frmPrintMode.Left := trunc((Screen.Width - frmPrintMode.Width) / 2);
  frmPrintMode.Top := trunc((Screen.Height - frmPrintMode.Height) / 2);
end;

// Подготоака данных

procedure TPrintInvoiceController.Print(FileName: string);
begin
  FileName := ExtractFilePath(Application.ExeName) + 'PrintForm/' + FileName;
  if FileExists(FileName) then begin
    Self.ResizePrintModeForm;
    FInvoice := TInvoice.Create;
    FInvoice.Prepare(FDocument);
    with dmPrint do begin
      frmWaiting.WaitPrint;

      frxDataSetMaster.RangeEndCount := FInvoice.Count;
      frxDataSetMaster.First;
      frxDataSetMaster.OnNext := nil;
      frxDataSetMaster.OnGetValue := nil;

      frxDataSetDetail.OnNext := nil;
      frxDataSetDetail.OnGetValue := nil;;

      frxDataSetSubDetail.OnNext := nil;
      frxDataSetSubDetail.OnGetValue := nil;

      frxReport.OnGetValue := Self.frxReportGetValue;
      frxDataSetMaster.OnGetValue := Self.frxDataSetMasterGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      frxReport.ShowPreparedReport;
    end;
    FInvoice.Free;
  end else Self.CannotPrintMessage;
  frmPrintMode.Close;
end;

procedure TPrintInvoiceController.frxReportGetValue(const VarName: string; var Value: Variant);
begin
  Value := 0;
  if VarName = 'SupplierRusName' then Value := Self.FSupplier.RusName;
  if VarName = 'SupplierEngName' then Value := Self.FSupplier.EngName;
  if VarName = 'SupplierRusAddr' then Value := Self.FSupplier.RusAddr;
  if VarName = 'SupplierEngAddr' then Value := Self.FSupplier.EngAddr;
  if VarName = 'SupplierContrNum' then Value := Self.FSupplier.ContractNumber;
  if VarName = 'SupplierContrDate' then Value := Self.FSupplier.ContractDate;
  if VarName = 'SupplierPhone' then Value := Self.FSupplier.phone;
  if VarName = 'SupplierBankName' then Value := Self.FSupplier.bank_name;
  if VarName = 'SupplierBankDetails' then Value := Self.FSupplier.bank_details;
  if VarName = 'SupplierCountry' then Value := Self.FSupplier.country;
  if VarName = 'SupplierPortRus' then Value := Self.FSupplier.main_port_rus;
  if VarName = 'SupplierPortEng' then Value := Self.FSupplier.main_port_eng;
  if VarName = 'SupplierDirectorPosition' then Value := Self.FSupplier.DirectorPosition;
  if VarName = 'SupplierDirectorName' then Value := Self.FSupplier.DirectorName;

  if VarName = 'BuyerRusName' then Value := Self.FBuyer.RusName;
  if VarName = 'BuyerEngName' then Value := Self.FBuyer.EngName;
  if VarName = 'BuyerRusAddr' then Value := Self.FBuyer.RusAddr;
  if VarName = 'BuyerEndAddr' then Value := Self.FBuyer.EngAddr;
  if VarName = 'BuyerContrNum' then Value := Self.FBuyer.ContractNumber;
  if VarName = 'BuyerContrDate' then Value := Self.FBuyer.ContractDate;
  if VarName = 'BuyerPhone' then Value := Self.FBuyer.phone;
  if VarName = 'BuyerBankName' then Value := Self.FBuyer.bank_name;
  if VarName = 'BuyerBankDetails' then Value := Self.FBuyer.bank_details;
  if VarName = 'BuyerCountry' then Value := Self.FBuyer.country;
  if VarName = 'BuyerPortRus' then Value := Self.FBuyer.main_port_rus;
  if VarName = 'BuyerPortEng' then Value := Self.FBuyer.main_port_eng;
  if VarName = 'BuyerDirectorPosition' then Value := Self.FBuyer.DirectorPosition;
  if VarName = 'BuyerDirectorName' then Value := Self.FBuyer.DirectorName;

  if VarName = 'PortAndBasis' then Value := Self.FPort;
  if VarName = 'ContainerNum' then Value := Self.FContNum;
  if VarName = 'InvoiceNum' then Value := Self.FInvNum;
  if VarName = 'InvoiceDate' then Value := DateToStr(Self.FInvDate);
  if VarName = 'PriceDate' then Value := DateToStr(Self.FPriceDate);
  if VarName = 'PriceValidDate' then Value := DateToStr(Self.FPriceValidDate);
  if VarName = 'SpecNum' then Value := Self.FSpecNum;
end;

procedure TPrintInvoiceController.frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
var
  I: integer;
  Row: TInvoiceRow;
begin
  I := dmPrint.frxDataSetMaster.RecNo;
  Value := 0;
  if I >= FInvoice.Count then Exit;
  Row := FInvoice.Row[I];
  if VarName = 'BOM' then Value := Row.BOM;
  if VarName = 'RusTitle' then Value := Row.RusTitle;
  if VarName = 'EngTitle' then Value := Row.EngTitle;
  if VarName = 'Unit' then Value := Row.PartUnit;
  if VarName = 'Count' then Value := Row.Count;
  if VarName = 'Price' then Value := Row.CFRPrice;
  if VarName = 'TotalPrice' then Value := Row.CFRTotal;
  if VarName = 'Net' then Value := Row.NetTotal;
  if VarName = 'Gross' then Value := Row.GrossTotal;
  if VarName = 'FullBox' then Value := Row.BoxFullCount;
  if VarName = 'PartBox' then Value := Row.BoxPartCount;
  if VarName = 'CustomCode' then Value := Row.CustomCode;
  if VarName = 'Risk' then Value := Row.PriceRisk;
end;

//

procedure TPrintInvoiceController.PrintInvoiceAll(Sender: TObject);
var
  SupplierId, BuyerId, PortId: integer;
  I: integer;
  EntitiesBase: TEntitiesBase;
  ContNum, InvNum, SpecNum: string;
  InvDate: TDate;
begin
  if (FDocument.Parts.Count = 0) or (FDocument.Containers.Count = 0) then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  SupplierId := 0;
  BuyerId := 0;
  PortId := 0;
  ContNum := '';
  SpecNum := '1';
  for I := 0 to FDocument.Containers.Count - 1 do
    ContNum := ContNum + FDocument.Containers.Items[I].Title + '/';
  Delete(ContNum, Length(ContNum), 1);
  InvNum := ExtractFileName(FDocument.FileName);
  InvDate := date;
  //
  if not frmPrintMode.GetInvoiceSettings(SupplierId, BuyerId, PortId,
    ContNum, InvNum, InvDate, SpecNum) then begin
      frmPrintMode.ShowMainPage;
      Exit;
  end;
  Self.FContNum := ContNum;
  Self.FInvNum := InvNum;
  Self.FInvDate := InvDate;
  Self.FPriceDate := InvDate - 45;
  Self.FPriceValidDate := InvDate + 7;
  Self.FSpecNum := SpecNum;
  EntitiesBase := TEntitiesBase.Create;
  EntitiesBase.GetOneEntitie(SupplierId, Self.FSupplier);
  EntitiesBase.GetOneEntitie(BuyerId, Self.FBuyer);
  EntitiesBase.GetOnePort(PortId, Self.FPort);
  EntitiesBase.Free;
  Self.Print(pfInvoiceAll);
end;

end.
