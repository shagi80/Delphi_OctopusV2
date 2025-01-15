unit ExportControllerCls;

interface

uses
   OrderCls, DocumentCls, frxClass, InvoiceCls;

type
  TExportController = class(TObject)
  private
    FDocument: TDocument;
    FInvoice: TInvoice;
    FMode: integer;
    procedure CannotExportMessage;
    procedure ExportDoneMessage;
    function GetFileName(Ext: string): string;
    procedure ExportWithFastReports(ExportFormat: integer);
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
    procedure ResizePrintModeForm;
    //procedure frxDataSetMasterNext(Sender: TObject);
    function GetSystemDecSeparator: char;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure ExportFor1C(Sender: TObject);
    procedure ExportForInvoice(Sender: TObject);
    procedure ExportForCustomCode(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, OrderItemCls,
 SysUtils, OrdersForm, Forms, GlobalSettingsCls, PrintDataModule,
 WaitingForm, PartCls, DocSaverCls, Windows;

const
  SortNone =  -1;
  SortRussian =  0;
  SortEnglish = 1;
  mdFor1C = 0;
  mdForInvoice = 1;
  mdForCustom = 2;
  pfForInvoice = 'invoice.fr3';
  pfForCustomInvoice = 'CustomInvoice.fr3';


constructor TExportController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FInvoice := nil;
end;

destructor TExportController.Destroy;
begin
  FDocument := nil;
  FInvoice := nil;
  inherited Destroy;
end;

procedure TExportController.CannotExportMessage;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    67, 'Нет данных для экспорта' + ' !');
  MessageDlg(Text, mtWarning, [mbOk], 0);
end;

procedure TExportController.ExportDoneMessage;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    68, 'Экспорт выполнен успешно' + ' !');
  MessageDlg(Text, mtInformation, [mbOk], 0);
end;

function TExportController.GetFileName(Ext: string): string;
var
  SaveDlg: TSaveDialog;
begin
  Result := '';
  SaveDlg := TSaveDialog.Create(nil);
  SaveDlg.Title := Translator.GetInstance.TranslateMessage(
    59, 'Выберите файл для сохранения');
  SaveDlg.DefaultExt := '*.' + Ext;
  if Ext = 'txt' then SaveDlg.Filter := 'Text files (*.txt)|*.txt';
  if Ext = 'csv' then SaveDlg.Filter := 'CSV files (*.csv)|*.csv';
  if not SaveDlg.Execute then Exit;
  Result := SaveDlg.FileName;
end;

procedure TExportController.ExportWithFastReports(ExportFormat: integer);
var
  FileName: string;
begin
  if (FDocument.Parts.Count = 0) or (FDocument.Containers.Count = 0) then begin
    Self.CannotExportMessage;
    frmPrintMode.Close;
    Exit;
  end;
  case FMode of
    mdForInvoice: FileName := pfForInvoice;
    mdForCustom: FileName := pfForCustomInvoice;
  end;
  FileName := ExtractFilePath(Application.ExeName) + 'PrintForm/' + FileName;
  if FileExists(FileName) then begin
    Self.ResizePrintModeForm;
    FInvoice := TInvoice.Create;
    FInvoice.Prepare(FDocument);
    with dmPrint do begin
      frmWaiting.WaitPrint;
      case FMode of
        mdForInvoice: frxDataSetMaster.RangeEndCount := FInvoice.Count;
        mdForCustom: frxDataSetMaster.RangeEndCount := FInvoice.CustomRowCount;
      end;
      frxDataSetMaster.First;
      frxReport.OnGetValue := Self.frxDataSetMasterGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      //frxReport.ShowPreparedReport;
      case ExportFormat of
        0: frxReport.Export(frxXLSExport1);
        1: frxReport.Export(frxODTExport1);
        2: frxReport.Export(frxODSExport1);
        3: frxReport.Export(frxPDFExport1);
        4: frxReport.Export(frxTXTExport1);
      end;
    end;
    FInvoice.Free;
  end else Self.CannotExportMessage;
  frmPrintMode.Close;
end;

procedure TExportController.frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
var
  I: integer;
  Row: TInvoiceRow;
begin
  I := dmPrint.frxDataSetMaster.RecNo;
  Value := 0;
  case FMode of
    mdForInvoice: begin
        if I >= FInvoice.Count then Exit;
        Row := FInvoice.Row[I];
      end;
    mdForCustom: begin
        if I >= FInvoice.CustomRowCount then Exit;
        Row := FInvoice.CustomRow[I];
      end;
  end;
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

procedure TExportController.ResizePrintModeForm;
begin
  frmPrintMode.pnBottom.Visible := False;
  frmPrintMode.Width := frmPrintMode.imgExport.Width + 10;
  frmPrintMode.Height := frmPrintMode.imgExport.Height + 30;
  frmPrintMode.Left := trunc((Screen.Width - frmPrintMode.Width) / 2);
  frmPrintMode.Top := trunc((Screen.Height - frmPrintMode.Height) / 2);
end;

function TExportController.GetSystemDecSeparator: char;
var
  pcLCA: Array[0..20] of Char;
begin
  if (GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, pcLCA, 19) <= 0) then
    pcLCA[0] := #0;
  Result := pcLCA[0];
end;

// Экспорт для 1С в TXT формат

procedure TExportController.ExportFor1C(Sender: TObject);
var
  FileName, Title: string;
  Saver: TDocSaver;
  Invoice: TInvoice;
  I: integer;
begin
  if (FDocument.Parts.Count = 0) or (FDocument.Containers.Count = 0) then begin
    Self.CannotExportMessage;
    Exit;
  end;
  FileName := Self.GetFileName('txt');
  if Length(FileName) = 0 then Exit;
  Invoice := TInvoice.Create;
  Invoice.Prepare(FDocument);
  // Сохраням в файл
  Saver := TDocSaver.Create(FileName);
  Title := 'Containers: ';
  for I := 0 to FDocument.Containers.Count - 1 do begin
    Title := Title + FDocument.Containers.Items[I].Title;
    if I < FDocument.Containers.Count - 1 then Title := Title + ', ';
  end;
  Title := Title + '. Orders: ';
  for I := 0 to FDocument.Orders.Count - 1 do begin
    Title := Title + FDocument.Orders.Items[I].Title;
    if I < FDocument.Orders.Count - 1 then Title := Title + ', ';
  end;
  Title := Title + '. ' + ExtractFileName(FDocument.FileName);
  Saver.SaveExportTo1C(Title, Invoice);
  Saver.Destroy;
  frmPrintMode.Close;
  Invoice.Free;
  Self.ExportDoneMessage;
end;

// Экспорт для инвойса

procedure TExportController.ExportForInvoice(Sender: TObject);
var
  ExportFormat: integer;
begin
  FMode := mdForInvoice;
  ExportFormat := -1;
  if frmPrintMode.GetExportMode(ExportFormat) then
    Self.ExportWithFastReports(ExportFormat)
      else frmPrintMode.ShowMainPage;
end;

procedure TExportController.ExportForCustomCode(Sender: TObject);
var
  ExportFormat: integer;
begin
  FMode := mdForCustom;
  ExportFormat := -1;
  if frmPrintMode.GetExportMode(ExportFormat) then
    Self.ExportWithFastReports(ExportFormat)
      else frmPrintMode.ShowMainPage;
end;

end.
