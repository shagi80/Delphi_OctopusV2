unit PrintInvoiceController;

interface

uses
   InvoiceCls, DocumentCls, OrderListCls, frxClass;

type
  TPrintInvoiceController = class(TObject)
  private
    FDocument: TDocument;
    FInvoice: TInvoice;
    procedure CannotPrintMessage;
    procedure ResizePrintModeForm;
    procedure Print(FileName: string);
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
      frxReport.OnGetValue := Self.frxDataSetMasterGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      frxReport.ShowPreparedReport;
    end;
    FInvoice.Free;
  end else Self.CannotPrintMessage;
  frmPrintMode.Close;
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
  if VarName = 'Count' then Value := Row.CFRPrice;
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
  ContNum, InvNum: string;
  I: integer;
begin
  if (FDocument.Parts.Count = 0) or (FDocument.Containers.Count = 0) then begin
    Self.CannotPrintMessage;
    Exit;
  end;
  SupplierId := 0;
  BuyerId := 0;
  PortId := 0;
  ContNum := '';
  for I := 0 to FDocument.Containers.Count - 1 do
    ContNum := ContNum + FDocument.Containers.Items[I].Title + '/';
  Delete(ContNum, Length(ContNum), 1);
  InvNum := FDocument.FileName;
  if not frmPrintMode.GetInvoiceSettings(SupplierId, BuyerId, PortId,
    ContNum, InvNum) then begin
      frmPrintMode.ShowMainPage;
      Exit;
  end;
  Self.Print(pfInvoiceAll);
  OrderList.Free;
end;


end.
