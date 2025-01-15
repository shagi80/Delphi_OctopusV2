unit InvoiceControllerCls;

interface

uses
  DocumentCls, OrderCls, PartListCls, OrderItemCls, PartCls, BoxItemCls, Classes;

type
  TOnChangeModel = procedure (Sender: TObject; UpdateInterface: boolean) of object;

  TInvoiceController = class(TObject)
  private
    FDocument: TDocument;
    FOnChangeModel: TOnChangeModel;
    procedure ChangeModelEvent(UpdateInterface: boolean);
    procedure SetTotalAmount(Codes: TStringList; Value: real);
    function SetTotalAmountForInvoice(TargetSum: real): integer;
    function SetTotalAmountForCodeList(TargetSum: real; CodeList: TStringList): integer;
  public
    constructor Create(Document: TDocument);
    property OnChangeModel: TOnChangeModel read FOnChangeModel write FOnChangeModel;
    procedure SearchPart(Sender: TObject);
    procedure OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
    procedure ChangeTotalCost(Sender: TObject);
    procedure EditPart(Sender: TObject);
  end;

implementation

uses
  Grids, Dialogs, OrdersForm, InputForm, TranslatorCls, Math,
  GlobalSettingsCls, DocLoaderCls, SysUtils, Controls, Forms,
  BoxForm, ContainerForm, PartEditorForm, PartPropertyForm, InvoiceForm,
  PartListForm, Contnrs,  SearchForm, InvoiceCls, PriceChangeSetiingsForm;

constructor TInvoiceController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
end;

procedure TInvoiceController.ChangeModelEvent(UpdateInterface: Boolean);
begin
  if Assigned(Self.FOnChangeModel) then
    Self.FOnChangeModel(Self, UpdateInterface);
end;

function TInvoiceController.SetTotalAmountForInvoice(TargetSum: real): integer;
var
  PerUnitOfPrice, Term: real;
  I: integer;
  Invoice: TInvoice;
begin
  Result := 0;
  Invoice := frmInvoice.Invoice;
  if Invoice.TotalPrice = 0 then Exit;
  PerUnitOfPrice := (TargetSum - Invoice.TotalPrice) / Invoice.TotalPrice;
  for I := 0 to Invoice.Count - 1 do begin
    Term := (PerUnitOfPrice * Invoice.Row[I].CFRTotal) / Invoice.Row[I].Count;
    Term := SimpleRoundTo(Term, - GlobalSettings.GetInstance.MoneyAccuracy);
    Invoice.Row[I].Part.CFRPrice := Invoice.Row[I].Part.CFRPrice + Term;
    if Invoice.Row[I].Part.CFRPrice <=0 then Result := -1;
  end;
  if Result = 0 then Result := 1;
end;

function TInvoiceController.SetTotalAmountForCodeList(TargetSum: real; CodeList: TStringList): integer;
var
  TotalSum, PerUnitOfPrice, Term: real;
  I: integer;
  Coef: real;
  Invoice: TInvoice;
  Code: string;
begin
  Result := 0;
  Invoice := frmInvoice.Invoice;
  TotalSum := 0;
  for I := 0 to Invoice.Count - 1 do begin
    Code := Invoice.Row[I].Code;
    Coef := StrToFloatDef(CodeList.Values[Code], 0);
    if Coef > 0 then begin
      TotalSum := TotalSum + Invoice.Row[I].CFRTotal * Coef;
    end;
  end;
  if TotalSum = 0 then Exit;
  PerUnitOfPrice := (TargetSum - Invoice.TotalPrice) / TotalSum;
  for I := 0 to Invoice.Count - 1 do begin
    Code := Invoice.Row[I].Code;
    Coef := StrToFloatDef(CodeList.Values[Code], 0);
    if Coef > 0 then begin
      Term := (PerUnitOfPrice * Invoice.Row[I].CFRTotal)
        / (Invoice.Row[I].Count * Coef);
      Term := SimpleRoundTo(Term, - GlobalSettings.GetInstance.MoneyAccuracy);
      Invoice.Row[I].Part.CFRPrice := Invoice.Row[I].Part.CFRPrice + Term;
      if Invoice.Row[I].Part.CFRPrice <=0 then Result := -1;
    end;
  end;
  if Result = 0 then Result := 1;
end;

procedure TInvoiceController.SetTotalAmount(Codes: TStringList; Value: real);
var
  Result: integer;
  Text: string;
begin
  if frmInvoice.Invoice = nil then Exit;
  Text := '';
  if Codes = nil then Result := SetTotalAmountForInvoice(Value)
    else Result := SetTotalAmountForCodeList(Value, Codes);
  if Result <= 0 then begin
    case Result of
       0: text := Translator.GetInstance.TranslateMessage(
            106, 'Ошибка перерасчета - нулевой коэффициент' );
      -1: Text := Translator.GetInstance.TranslateMessage(
            107, 'Внимание ! В результате пересчета некоторые цены стали отрицательными' );
    end;
    MessageDlg(Text + ' !', mtWarning, [mbOk], 0);
  end;
  if Result <> 0 then begin
    frmInvoice.RefreshGrid(self);
    Self.ChangeModelEvent(True);
  end;
end;

//

procedure TInvoiceController.OnEndEditGrid(Sende: TObject; ACol, ARow: integer; Value: widestring);
var
  Ind: integer;
  NewValue: real;
  Part: TPart;
begin
  if (frmInvoice.Invoice = nil) then Exit;
  Ind := integer(frmInvoice.grInvoice.Objects[1, ARow]);
  Part := frmInvoice.Invoice.Row[Ind].Part;
  NewValue := StrToFloatDef(Value, 0);
  if NewValue <= 0 then begin
    frmInvoice.grInvoice.Cells[6, ARow] := FormatFloat(
      GlobalSettings.GetInstance.MoneyAccuracyMask, Part.CFRPrice);
    Exit;
  end;
  if NewValue = Part.CFRPrice then Exit;
  Part.CFRPrice := NewValue;
  frmInvoice.Invoice.Prepare(FDocument);
  frmInvoice.grInvoice.Cells[7, ARow] := FormatFloat(
    GlobalSettings.GetInstance.MoneyAccuracyMask,
      frmInvoice.Invoice.Row[Ind].CFRTotal);
  frmInvoice.SetGridRowMark(frmInvoice.Invoice.Row[Ind], ARow);
  frmInvoice.RefreshSumPanel;
  Self.ChangeModelEvent(False);
end;

procedure TInvoiceController.SearchPart(Sender: TObject);
begin
  if (frmInvoice.SelectedPart = nil) then Exit;
  SearchForm.frmSearch.SearchPart(frmInvoice.SelectedPart);
end;

procedure TInvoiceController.EditPart(Sender: TObject);
begin
  if frmInvoice.SelectedPart = nil then Exit;
  if frmPartEditor.EditPart(frmInvoice.SelectedPart, Self.FDocument) <> nil then begin
    frmOrders.RefreshGrid(Self);
    frmPartProperty.RefreshGrid(Self);
    frmBox.RefreshData(Self);
    frmContainers.RefreshGrid(Self);
    frmInvoice.RefreshGrid(Self);
    Self.ChangeModelEvent(False);
  end;
end;

procedure TInvoiceController.ChangeTotalCost(Sender: TObject);
var
  NewCost: real;
  Objects: TObjectList;
  Code: TStringList;
  FileName: string;
  I, Ind, Mode: integer;
begin
  if (frmInvoice.Invoice = nil) or (frmInvoice.Invoice.Count = 0) then Exit;
  NewCost := frmInvoice.Invoice.TotalPrice;
  // Список выбранных в инвойсе деталей
  Objects := TObjectList.Create(False);
  frmInvoice.grInvoice.GetSelectedObjects(1, Objects);
  // Спиок из настроек
  Code := TStringList.Create;
  FileName := ExtractFilePath(Application.ExeName) +
    GlobalSettings.GetInstance.PricedDistributionFileName;
  try
    Code.LoadFromFile(FileName);
  finally
    //
  end;
  //
  Mode := frmPriceChangeSetiings.GetNewCost((Objects.Count > 0),
    (Code.Count > 0), NewCost);
  case Mode of
    1: SetTotalAmount(nil, NewCost);
    2: begin
      for I := 0 to OBjects.Count - 1 do begin
        Ind := integer(Objects.Items[I]);
        Code.Add(frmInvoice.Invoice.Row[Ind].Part.Code + '=1');
      end;
      SetTotalAmount(Code, NewCost);
    end;
    3: SetTotalAmount(Code, NewCost);
  end;
  Objects.Free;
  Code.Free;
end;

end.
