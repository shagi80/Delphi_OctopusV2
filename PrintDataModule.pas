unit PrintDataModule;

interface

uses
  SysUtils, Classes, frxClass, frxExportODF, frxExportTXT, frxExportPDF,
  frxExportXLS;

type
  TdmPrint = class(TDataModule)
    frxReport: TfrxReport;
    frxDataSetMaster: TfrxUserDataSet;
    frxDataSetDetail: TfrxUserDataSet;
    frxDataSetSubDetail: TfrxUserDataSet;
    frxXLSExport1: TfrxXLSExport;
    frxODSExport1: TfrxODSExport;
    frxPDFExport1: TfrxPDFExport;
    frxTXTExport1: TfrxTXTExport;
    frxODTExport1: TfrxODTExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrint: TdmPrint;

implementation

{$R *.dfm}

end.
