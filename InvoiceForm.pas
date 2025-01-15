unit InvoiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, TntGrids, OctopusGridCls, ImgList, ComCtrls,
  ToolWin, TntStdCtrls, Buttons, ExtCtrls, DocumentCls, PartCls, InvoiceCls,
  Menus;

type
  TOnSelectPart = procedure (Part: TPart) of object;
  TOnDoubleClick  = procedure (Sender: TObject) of object;

  TfrmInvoice = class(TForm)
    pnTop: TPanel;
    pnViewTools: TPanel;
    pnSearch: TPanel;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    edSearch: TTntEdit;
    pnToolBar: TPanel;
    tbView: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    ToolButton3: TToolButton;
    btnSearchPart: TToolButton;
    pnEditTools: TPanel;
    tbEdit: TToolBar;
    btnChageTotalCost: TToolButton;
    ImageList1: TImageList;
    grInvoice: TOctopusStringGrid;
    pnBottom: TPanel;
    pnTotal: TPanel;
    lbTotalLabel1: TLabel;
    lbTotalLabel2: TLabel;
    lbTotalPrice: TLabel;
    lbTotalNet: TLabel;
    lbTotalGross: TLabel;
    Label1: TLabel;
    pnWarning: TPanel;
    btnRetryWarning: TSpeedButton;
    Label2: TLabel;
    btnOnlyMark: TToolButton;
    Label3: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnCheckListMode: TToolButton;
    btnCheckAll: TToolButton;
    btnUncheckAll: TToolButton;
    btnInvertCheck: TToolButton;
    ToolButton4: TToolButton;
    btnEditPart: TToolButton;
    btnPartListUpdate: TToolButton;
    procedure grInvoiceKeyPress(Sender: TObject; var Key: Char);
    procedure grInvoiceDblClick(Sender: TObject);
    procedure btnInvertCheckClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnCheckListModeClick(Sender: TObject);
    procedure grInvoiceSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnClearSearchClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDocument: TDocument;
    FInvoice: TInvoice;
    FOnSelectPart: TOnSelectPart;
    FEditMode: boolean;
    FOnDoubleClick: TOnDoubleClick;
    procedure SetDocument(Document: TDocument);
    function GetRowMark(InvoiceRow: TInvoiceRow): TEditableCellSet;
    procedure RefreshGridHeader(Sender: TObject);
    function GetSelectPart: TPart;
    procedure SetEditMode(EditMode: boolean);
    procedure SetCheckButtonsEnabled(Value: Boolean);
  public
    { Public declarations }
    property Document: TDocument read FDocument write SetDocument;
    property OnSelectPart: TOnSelectPart read FOnSelectPart write FOnSelectPart;
    property Invoice: TInvoice read FInvoice;
    property SelectedPart: TPart read GetSelectPart;
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnDoubleClick: TOnDoubleClick read FOnDoubleClick write FOnDoubleClick;
    procedure RefreshSumPanel;
    procedure SetGridRowMark(InvoiceRow: TInvoiceRow; ARow: integer);
  published
    procedure CheckInvoice(Sender: TObject);
    procedure RefreshGrid(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
  end;

var
  frmInvoice: TfrmInvoice;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls;

procedure TfrmInvoice.SetDocument(Document: TDocument);
begin
  Self.FDocument := Document;
  Self.RefreshGrid(Self);
end;

function TfrmInvoice.GetSelectPart: TPart;
var
  ARow, Ind: integer;
begin
  Result := nil;
  if (FInvoice = nil) or (FInvoice.Count = 0) then Exit;
  ARow := grInvoice.Selection.Top;
  if ARow <= 0 then Exit;
  Ind := integer(grInvoice.Objects[1, ARow]);
  Result := FInvoice.Row[Ind].Part;
end;

procedure TfrmInvoice.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  if FEditMode then grInvoice.EditableCells := [6]
    else grInvoice.EditableCells := [];
  Self.pnEditTools.Visible := FEditMode;
  Self.pnEditTools.Top := 0;
  RefreshGrid(Self);
end;

//

procedure TfrmInvoice.FormCreate(Sender: TObject);
begin
  grInvoice.ColAlign[4] := DT_CENTER;
  grInvoice.ColAlign[5] := DT_RIGHT;
  grInvoice.ColAlign[6] := DT_RIGHT;
  grInvoice.ColAlign[7] := DT_RIGHT;
  grInvoice.ColAlign[8] := DT_RIGHT;
  grInvoice.ColAlign[9] := DT_RIGHT;
  grInvoice.ColAlign[10] := DT_RIGHT;
  grInvoice.ColAlign[12] := DT_RIGHT;
  grInvoice.Colored := True;
  grInvoice.CheckListStyle := False;
  Self.SetCheckButtonsEnabled(grInvoice.CheckListStyle);
  Self.btnColored.Down := grInvoice.Colored;
  FInvoice := TInvoice.Create;
  FEditMode := False;
  grInvoice.EditableCells := [];
  pnEditTools.Visible := False;
end;

procedure TfrmInvoice.FormResize(Sender: TObject);
var
  I, W: integer;
begin
  grInvoice.ColWidths[0] := 30;
  grInvoice.ColWidths[1] := 80;
  grInvoice.ColWidths[2] := 150;
  grInvoice.ColWidths[4] := 30;
  grInvoice.ColWidths[5] := 70;
  grInvoice.ColWidths[6] := 70;
  grInvoice.ColWidths[7] := 70;
  grInvoice.ColWidths[8] := 70;
  grInvoice.ColWidths[9] := 70;
  grInvoice.ColWidths[10] := 70;
  grInvoice.ColWidths[11] := 70;
  W := 0;
  for I := 0 to grInvoice.ColCount - 1 do
    if I <> 3 then W := W + grInvoice.ColWidths[I];
  grInvoice.ColWidths[3] := grInvoice.ClientWidth - W - grInvoice.ColCount;

end;

procedure TfrmInvoice.FormShow(Sender: TObject);
begin
  Self.RefreshGrid(Self);
end;

//

procedure TfrmInvoice.btnCheckAllClick(Sender: TObject);
begin
  grInvoice.SelectAll;
  grInvoice.Repaint;
end;

procedure TfrmInvoice.btnCheckListModeClick(Sender: TObject);
begin
  grInvoice.CheckListStyle := btnCheckListMode.Down;
  if Self.btnCheckListMode.Down then grInvoice.UnselectAll;
  Self.SetCheckButtonsEnabled(grInvoice.CheckListStyle);
  grInvoice.Repaint;
end;

procedure TfrmInvoice.btnClearSearchClick(Sender: TObject);
begin
  if Length(edSearch.Text) >0 then begin
    edSearch.Text := '';
    RefreshGrid(Self);
  end;
end;

procedure TfrmInvoice.btnInvertCheckClick(Sender: TObject);
begin
  grInvoice.ChangeSelection;
  grInvoice.Repaint;
end;

procedure TfrmInvoice.btnUncheckAllClick(Sender: TObject);
begin
  grInvoice.UnselectAll;
  grInvoice.Repaint;
end;

procedure TfrmInvoice.ViewButtonsClick(Sender: TObject);
begin
  grInvoice.Colored := Self.btnColored.Down;
  grInvoice.WordWrap := btnWrap.Down;
  grInvoice.Repaint;
end;

procedure TfrmInvoice.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then RefreshGrid(Self)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then RefreshGrid(Self);
end;

procedure TfrmInvoice.grInvoiceDblClick(Sender: TObject);
begin
  if Assigned(Self.FOnDoubleClick) then Self.FOnDoubleClick(Self);
end;

procedure TfrmInvoice.grInvoiceKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

procedure TfrmInvoice.grInvoiceSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  Part: TPart;
begin
  grInvoice.Selection := TGridRect(Rect(ACol, ARow, ACol, ARow));
  Part := Self.GetSelectPart;
  if Assigned(Self.FOnSelectPart) then Self.FOnSelectPart(Part);
end;

procedure TfrmInvoice.SetCheckButtonsEnabled(Value: Boolean);
begin
  btnCheckAll.Enabled := Value;
  btnUncheckAll.Enabled := Value;
  btnInvertCheck.Enabled := Value;
end;

//

function TfrmInvoice.GetRowMark(InvoiceRow: TInvoiceRow): TEditableCellSet;
var
  Marks: TEditableCellSet;
begin
  Marks := [];
  if Length(InvoiceRow.EngTitle) = 0 then Marks := Marks + [2];
  if Length(InvoiceRow.RusTitle) = 0 then Marks := Marks + [3];
  if Length(InvoiceRow.PartUnit) = 0 then Marks := Marks + [4];
  if InvoiceRow.CFRPrice <= 0 then Marks := Marks + [6];
  if InvoiceRow.CFRTotal <= 0 then Marks := Marks + [7];
  if InvoiceRow.NetTotal <= 0 then Marks := Marks + [8];
  if InvoiceRow.GrossTotal <= 0 then Marks := Marks + [9];
  if (InvoiceRow.BoxFullCount <= 0) and (InvoiceRow.BoxPartCount <= 0) then
    Marks := Marks + [10];
  if Length(InvoiceRow.CustomCode) = 0 then Marks := Marks + [11];
  if InvoiceRow.PriceRisk = 0 then Marks := Marks + [12];
  if (InvoiceRow.GrossTotal < InvoiceRow.NetTotal)
    and (not(9 in Marks)) then Marks := Marks + [9];
  Result := Marks;
end;

procedure TfrmInvoice.SetGridRowMark(InvoiceRow: TInvoiceRow; ARow: Integer);
begin
  grInvoice.SetCellMark(ARow, Self.GetRowMark(InvoiceRow));
  Self.CheckInvoice(Self);
end;

procedure TfrmInvoice.RefreshGridHeader(Sender: TObject);
begin
  grInvoice.Cells[0,0] := '№';
  grInvoice.Cells[1,0] := 'BOM';
  grInvoice.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Англ наименование');
  grInvoice.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Рус наименование');
  grInvoice.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Ед.');
  grInvoice.Cells[5,0] :=
    Translator.GetInstance.TranslateWord('Кол-во');
  grInvoice.Cells[6,0] :=
    Translator.GetInstance.TranslateWord('Цена');
  grInvoice.Cells[7,0] :=
    Translator.GetInstance.TranslateWord('Сумма');
  grInvoice.Cells[8,0] :=
    Translator.GetInstance.TranslateWord('Нетто,кг');
  grInvoice.Cells[9,0] :=
    Translator.GetInstance.TranslateWord('Брутто,кг');
  grInvoice.Cells[10,0] :=
    Translator.GetInstance.TranslateWord('Кол.мест');
  grInvoice.Cells[11,0] :=
    Translator.GetInstance.TranslateWord('Код ТНВЭД');
  grInvoice.Cells[12,0] :=
    Translator.GetInstance.TranslateWord('Риск стоим');
end;

procedure TfrmInvoice.RefreshSumPanel;
begin
  if FInvoice.Count = 0 then Exit;
  lbTotalPrice.Caption := FloatToStrF(FInvoice.TotalPrice, ffNumber, 10,
    GlobalSettings.GetInstance.MoneyAccuracy);
  lbTotalNet.Caption := FloatToStrF(FInvoice.TotalGross, ffNumber, 10,
    GlobalSettings.GetInstance.WeightAccuracy);
  lbTotalGross.Caption := FloatToStrF(FInvoice.TotalNet, ffNumber, 10,
    GlobalSettings.GetInstance.WeightAccuracy);
end;

procedure TfrmInvoice.CheckInvoice(Sender: TObject);
var
  ARow: integer;
begin
  pnWarning.Visible := False;
  if FInvoice.Count = 0 then FInvoice.Prepare(FDocument);
  if FInvoice.Count = 0 then Exit;
  for ARow := 0 to FInvoice.Count - 1 do
    if (GetRowMark(FInvoice.Row[ARow]) <> []) then begin
      pnWarning.Visible := True;
      Exit;
    end;
end;

procedure TfrmInvoice.RefreshGrid(Sender: TObject);
var
  I, ARow: integer;
  InvoiceRow: TInvoiceRow;
  AddRow: boolean;
  Marks: TEditableCellSet;
begin
  grInvoice.Options := grInvoice.Options - [goEditing];
  grInvoice.DoExit;
  if not Self.Visible then Exit;
  pnWarning.Visible := False;
  grInvoice.Clear;
  grInvoice.RowCount := 2;
  grInvoice.SelectCell(MaxInt, MaxInt);
  //if Assigned(Self.FOnSelectItem) then FOnSelectItem(nil);
  RefreshGridHeader(Self);
  FInvoice.Prepare(FDocument);
  if FInvoice.Count = 0 then begin
    grInvoice.Enabled := False;
    FormResize(Self);
    pnBottom.Visible := False;
    Exit;
  end;
  ARow := 0;

  Perform(WM_SETREDRAW, 0, 0);
  for I := 0 to FInvoice.Count - 1 do begin
    InvoiceRow := FInvoice.Row[I];
    AddRow := True;
    // Отбор по полю поиска.
    if Length(edSearch.Text) > 0 then
      AddRow := (pos(WideUpperCase(edSearch.Text),
          WideUpperCase(InvoiceRow.RusTitle)) > 0)
        or (pos(WideUpperCase(edSearch.Text),
          WideUpperCase(InvoiceRow.EngTitle)) > 0);
    if not AddRow then Continue;
    // Только маркированные.
    Marks := GetRowMark(InvoiceRow);
    if btnOnlyMark.Down then AddRow := (Marks <> []);
    if not AddRow then Continue;
    // вывод строк.
    ARow := ARow + 1;
    grInvoice.Cells[1, ARow] := InvoiceRow.BOM;
    grInvoice.Cells[2, ARow] := InvoiceRow.EngTitle;
    grInvoice.Cells[3, ARow] := InvoiceRow.RusTitle;
    grInvoice.Cells[4, ARow] := InvoiceRow.PartUnit;
    grInvoice.Cells[5, ARow] := FloatToStr(InvoiceRow.Count);
    grInvoice.Cells[6, ARow] := FormatFloat(
      GlobalSettings.GetInstance.MoneyAccuracyMask, InvoiceRow.CFRPrice);
    grInvoice.Cells[7, ARow] := FormatFloat(
      GlobalSettings.GetInstance.MoneyAccuracyMask, InvoiceRow.CFRTotal);
    grInvoice.Cells[8, ARow] := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask, InvoiceRow.NetTotal);
    grInvoice.Cells[9, ARow] := FormatFloat(
      GlobalSettings.GetInstance.WeightAccuracyMask, InvoiceRow.GrossTotal);
    grInvoice.Cells[10, ARow] := IntToStr(InvoiceRow.BoxFullCount) + '/' +
      IntToStr(InvoiceRow.BoxPartCount);
    grInvoice.Cells[11, ARow] := InvoiceRow.CustomCode;
    grInvoice.Cells[12, ARow] := FloatToStr(InvoiceRow.PriceRisk);
    if ARow mod 2 = 0 then grInvoice.SetRowColor(ARow, rgb(240, 240, 230));
    grInvoice.Objects[1, ARow] := TObject(I);
    if Marks <> [] then begin
      pnWarning.Visible := True;
      grInvoice.SetCellMark(ARow, Marks);
    end;
    grInvoice.RowCount := ARow + 1;
  end;
  grInvoice.Enabled := (ARow > 0);
  pnBottom.Visible := grInvoice.Enabled;
  if grInvoice.Enabled then begin
    for ARow := 1 to grInvoice.RowCount - 1 do
      grInvoice.Cells[0, ARow] := IntToStr(ARow);
    Self.RefreshSumPanel;
  end;
  Self.FormResize(Self);
  Perform(WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
  if not pnWarning.Visible then CheckInvoice(Self);
end;

end.
