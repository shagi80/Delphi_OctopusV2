unit ExportControllerCls;

interface

uses
   OrderCls, DocumentCls, frxClass, InvoiceCls, ContainerCls;

type
  TExportController = class(TObject)
  private
    FDocument: TDocument;
    FInvoice: TInvoice;
    FMode: integer;
    procedure CannotExportMessage;
    procedure ExportDoneMessage;
    function GetFileName(Ext: string): string;
    procedure ExportWithFastReports(ExportFormat: integer;
      ExportFileName: string = '');
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
    procedure ResizePrintModeForm;
    function SaveExportTo1C(Title: string; Invoice: TInvoice): boolean;
    function SaveExportToTCD(BoxList: TContainer): boolean;
    //procedure frxDataSetMasterNext(Sender: TObject);
    //function GetSystemDecSeparator: char;
    procedure CannotExport;
    function GetOrderTitle: string;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure ExportFor1C(Sender: TObject);
    procedure ExportForInvoice(Sender: TObject);
    procedure ExportForCustomCode(Sender: TObject);
    procedure ExportForTCD(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, OrderItemCls,
 SysUtils, OrdersForm, Forms, GlobalSettingsCls, PrintDataModule,
 WaitingForm, PartCls, DocSaverCls, Windows, ContainerListCls, Contnrs,
 ContainerForm, PrintContainerControllerCls, Classes, BoxCls, FileCtrl;

const
  SortNone =  -1;
  SortRussian =  0;
  SortEnglish = 1;
  mdFor1C = 0;
  mdForInvoice = 1;
  mdForCustom = 2;
  pfForInvoice = 'invoice.fr3';
  pfForCustomInvoice = 'CustomInvoice.fr3';
  SEPARATOR_1C = '","';


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

procedure TExportController.CannotExport;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    115, 'Нет данных для экспорта') + ' !';
  MessageDlg(Text, mtWarning, [mbOk], 0);
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

procedure TExportController.ExportWithFastReports(ExportFormat: integer;
  ExportFileName: string = '');
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
      frxDataSetMaster.OnNext := nil;
      frxDataSetMaster.OnGetValue := nil;

      frxDataSetDetail.OnNext := nil;
      frxDataSetDetail.OnGetValue := nil;;

      frxDataSetSubDetail.OnNext := nil;
      frxDataSetSubDetail.OnGetValue := nil;

      frxReport.OnGetValue := Self.frxDataSetMasterGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Close;
      //frxReport.ShowPreparedReport;
      case ExportFormat of
        0: begin
          frxXLSExport1.FileName := ExportFileName;
          frxXLSExport1.OpenExcelAfterExport := False;
          frxXLSExport1.PageBreaks := False;
          frxReport.Export(frxXLSExport1);
        end;
        1: begin
          frxODTExport1.FileName := ExportFileName;
          frxODTExport1.OpenAfterExport := False;
          frxReport.Export(frxODTExport1);
        end;
        2: begin
          frxODSExport1.FileName := ExportFileName;
          frxODSExport1.OpenAfterExport := False;
          frxODSExport1.SingleSheet := True;
          frxReport.Export(frxODSExport1);
        end;
        3: begin
          frxPDFExport1.FileName := ExportFileName;
          frxPDFExport1.OpenAfterExport := False;
          frxReport.Export(frxPDFExport1);
        end;
        4: begin
          frxTXTExport1.FileName := ExportFileName;
          frxReport.Export(frxTXTExport1);
        end;
      end;
    end;
    FInvoice.Free;
  end else Self.CannotExportMessage;
  frmPrintMode.ShowMainPage;
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

{function TExportController.GetSystemDecSeparator: char;
var
  pcLCA: Array[0..20] of Char;
begin
  if (GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, LOCALE_SDECIMAL, pcLCA, 19) <= 0) then
    pcLCA[0] := #0;
  Result := pcLCA[0];
end;    }

function TExportController.GetOrderTitle: string;
begin
  Result := ExtractFileName(Self.FDocument.FileName);
  Result := copy(Result, 1, 7);
end;

// Экспорт для 1С в TXT формат

function TExportController.GetFileName(Ext: string): string;
var
  SaveDlg: TSaveDialog;
begin
  Result := '';
  SaveDlg := TSaveDialog.Create(nil);
  SaveDlg.Title := Translator.GetInstance.TranslateMessage(
    59, 'Выберите файл для сохранения');
  SaveDlg.FileName := FDocument.InvoiceNumber + '-for_1C';
  SaveDlg.DefaultExt := '*.' + Ext;
  if Ext = 'txt' then SaveDlg.Filter := 'Text files (*.txt)|*.txt';
  if Ext = 'csv' then SaveDlg.Filter := 'CSV files (*.csv)|*.csv';
  if not SaveDlg.Execute then Exit;
  Result := SaveDlg.FileName;
end;

procedure TExportController.ExportFor1C(Sender: TObject);
var
  Title: string;
  Invoice: TInvoice;
  I: integer;
begin
  if (FDocument.Parts.Count = 0) or (FDocument.Containers.Count = 0) then begin
    Self.CannotExportMessage;
    Exit;
  end;
  Invoice := TInvoice.Create;
  Invoice.Prepare(FDocument);
  // Сохраням в файл
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
  SaveExportTo1C(Title, Invoice);
  Invoice.Free;
  Self.ExportDoneMessage;
  frmPrintMode.ShowMainPage;
end;

function TExportController.SaveExportTo1C(Title: string; Invoice: TInvoice): boolean;
var
  I: integer;
  Row: TInvoiceRow;
  FileName, str: string;
  FFile: TextFile;
begin
  Result := False;
  FileName := Self.GetFileName('txt');
  if Length(FileName) = 0 then Exit;
  AssignFile(FFile, filename);
  Rewrite(FFile);
  WriteLn(FFile, Title);
  for I := 0 to Invoice.Count - 1 do begin
    Row := Invoice.Row[I];
    str := '"' + Row.Code + SEPARATOR_1C;
    str := str + Row.ShortTitle + SEPARATOR_1C;
    str := str + FloatToStr(Row.Count) + SEPARATOR_1C;
    str := str +FloatToStr(Row.CFRPrice) + '"';
    WriteLn(FFile, str);
  end;
  CloseFile(FFile);
  Result := True;
end;

// Экспорт для инвойса

procedure TExportController.ExportForInvoice(Sender: TObject);
var
  ExportFormat: integer;
begin
  FMode := mdForInvoice;
  ExportFormat := -1;
  if frmPrintMode.GetExportMode(ExportFormat) then
    Self.ExportWithFastReports(ExportFormat,
      FDocument.InvoiceNumber + '_invoice')
      else frmPrintMode.ShowMainPage;
end;

procedure TExportController.ExportForCustomCode(Sender: TObject);
var
  ExportFormat: integer;
begin
  FMode := mdForCustom;
  ExportFormat := -1;
  if frmPrintMode.GetExportMode(ExportFormat) then
    Self.ExportWithFastReports(ExportFormat,
      FDocument.InvoiceNumber + '_cust_code')
      else frmPrintMode.ShowMainPage;
end;

// Экспорт для ТСД

function TExportController.SaveExportToTCD(BoxList: TContainer): boolean;
var
  I, J, Num: integer;
  Box: TBox;
  Path, OrderName, str, PartName: string;
  FFile: TextFile;
begin
  Result := False;
  SelectDirectory('Выбери папку:', '', Path);
  if Length(Path) = 0 then Exit;
  OrderName := Self.GetOrderTitle;

  // Сохранение в файл Номенклатуры
  AssignFile(FFile, Path + '\Номенклатура.csv');
  Rewrite(FFile);
  str := 'Код;Артикул;Наименование;Packing.Barcode;ПоСН;Product.BasePackingId;'
    + 'Packing.Id;Packing.Name;Packing.ИдХарактеристики';
  WriteLn(FFile, str);
  Num := 1;
  for I := 0 to BoxList.Count - 1 do begin
    Box := BoxList.Items[I];
    PartName := Copy(Box.Items[0].Part.RusName, 1, 100);
    for J := 0 to Box.BoxCount - 1 do begin
      str := OrderName + '-' + Box.BoxCode + '-' + IntToStr(J + 1) + '/'
        + IntToStr(Box.BoxCount);
      str := FormatFloat('T0000000', Num) + ';' + FormatFloat('T0000000', Num)
         + ';' + PartName + ';' + str + ';true;шт;шт;шт;';
      Inc(Num);
      WriteLn(FFile, str);
    end;
  end;
  CloseFile(FFile);

  // Сохранение в файл Документа прихода
  Num := 1;
  AssignFile(FFile, Path + '\Приход на склад ' + OrderName + '.csv');
  Rewrite(FFile);
  WriteLn(FFile, '#{Document}');
  WriteLn(FFile, 'Name;Barcode');
  WriteLn(FFile, '"Приход на склад ' + OrderName + '";123456789012398');
  WriteLn(FFile, '#{Document.DeclaredItems}');
  WriteLn(FFile, '{Item.ProductId};{Item.ProductBarcode};{Item.ProductName};'
    + '{Item.DeclaredQuantity};{Item.CurrentQuantity}');
  for I := 0 to BoxList.Count - 1 do begin
    Box := BoxList.Items[I];
    PartName := Copy(Box.Items[0].Part.RusName, 1, 100);
    for J := 0 to Box.BoxCount - 1 do begin
      str := OrderName + '-' + Box.BoxCode + '-' + IntToStr(J + 1) + '/'
        + IntToStr(Box.BoxCount);
      str := FormatFloat('T000000', Num) + ';' + str + ';' + PartName + ';1;0';
      Inc(Num);
      WriteLn(FFile, str);
    end;
  end;
  CloseFile(FFile);

  Result := True;
end;

procedure TExportController.ExportForTCD(Sender: TObject);
var
  ContainerList: TContainerList;
  Container: TContainer;
  BoxList: TObjectList;
  SortMode: Integer;
  PrintController: TPrintContainerController;
begin
  if frmContainers.CurrentContainer = nil then begin
    Self.CannotExport;
    Exit;
  end;
  BoxList := TObjectList.Create(False);
  frmContainers.grContainer.GetSelectedObjects(1, BoxList);
  if BoxList.Count = 0 then BoxList := frmContainers.CurrentContainer;
  if BoxList.Count = 0 then begin
    BoxList.Free;
    Self.CannotExport;
    Exit;
  end;
  SortMode := SortNone;
  if not frmPrintMode.GetBoxSortMode(SortMode) then begin
    frmPrintMode.ShowMainPage;
    Exit;
  end;
  ContainerList := TContainerList.Create;
  Container := TContainer.Create;
  Container.Title := frmContainers.CurrentContainer.Title;
  PrintController := TPrintContainerController.Create(Self.FDocument);
  PrintController.CreateBoxData(TContainer(BoxList), Container, SortMode);
  PrintController.Free;
  ContainerList.Add(Container);
  if SaveExportToTCD(Container) then Self.ExportDoneMessage;
  BoxList.Free;
  ContainerList.Free;
  frmPrintMode.ShowMainPage;
end;

end.
