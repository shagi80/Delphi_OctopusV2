unit InvoiceCls;

interface

uses
  DocumentCls, OrderCls, PartCls, OrderItemCls;

type
  TInvoiceRow = record
    BOM: string;
    Code: string;
    ShortTitle: widestring;
    EngTitle: widestring;
    RusTitle: widestring;
    PartUnit: string;
    Count: real;
    CFRPrice: real;
    CFRTotal: real;
    NetTotal: real;
    GrossTotal: real;
    BoxFullCount: integer;
    BoxPartCount: integer;
    CustomCode: string;
    PriceRisk: real;
    Part: TPart;
  end;

  TInvoice = class(TObject)
  private
    FDocument: TDocument;
    FSortTitleInd: integer;
    FRows: array of TInvoiceRow;
    FCustomCodeRows: array of TInvoiceRow;
    FTotalPrice: real;
    FTotalNet: real;
    FTotalGross: real;
    procedure CreateItems(Items: TOrder; SortTitleInd: integer);
    procedure CalculateRow(var Row:TInvoiceRow; Item: TOrderItem);
    procedure AddCustomRow(Row:TInvoiceRow);
    procedure CreateRows(Items: TOrder);
    function GetRow(Ind: integer): TInvoiceRow;
    function GetCustomRow(Ind: integer): TInvoiceRow;
    function GetCount: integer;
    function GetCustomCount: integer;
    function MakeCFRFromFOB(Part: TPart): real;
    procedure GetGrossWeightAndBoxCount(Part: TPart; var Gross: real;
      var BoxFull: integer; var BoxPart: integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Prepare(Document: TDocument): boolean;
    property Row[Ind: integer]: TInvoiceRow read GetRow;
    property CustomRow[Ind: integer]: TInvoiceRow read GetCustomRow;
    property Count: integer read GetCount;
    property CustomRowCount: integer read GetCustomCount;
    property TotalPrice: real read FTotalPrice;
    property TotalNet: real read FTotalNet;
    property TotalGross: real read FTotalGross;
  end;

implementation

uses
  GlobalSettingsCls, TranslatorCls, Math, FindInShipmentCls,
  BoxCls;

constructor TInvoice.Create;
begin
  inherited Create;
  FDocument := nil;
end;

destructor TInvoice.Destroy;
begin
  FDocument := nil;
  SetLength(FRows, 0);
  inherited Destroy;
end;

function TInvoice.GetCount: integer;
begin
  Result := High(Self.FRows) + 1;
end;

function TInvoice.GetCustomCount: integer;
begin
  Result := High(Self.FCustomCodeRows) + 1;
end;

function TInvoice.GetRow(Ind: integer): TInvoiceRow;
begin
  Result := FRows[Ind];
end;

function TInvoice.GetCustomRow(Ind: integer): TInvoiceRow;
begin
  Result := FCustomCodeRows[Ind];
end;

//

function TInvoice.Prepare(Document: TDocument): boolean;
var
  Items: TOrder;
begin
  FDocument := Document;
  Items := TOrder.Create;
  Self.CreateItems(Items, 0);
  SetLength(FRows, 0);
  SetLength(FCustomCodeRows, 0);
  FTotalPrice := 0;
  FTotalNet := 0;
  FTotalGross := 0;
  Self.CreateRows(Items);
  Items.Free;
  Result := (High(FRows) >= 0);
end;

procedure TInvoice.CreateItems(Items: TOrder; SortTitleInd: integer);
var
  I, J: integer;
  Finder: TFindInShipment;
  NewItem: TOrderItem;
  Part: TPart;
  LoadCount: real;
  TitleCurrent, TitleNew: widestring;
begin
  Finder := TFindInShipment.Create(FDocument);
  for I := 0 to FDocument.Parts.Count - 1 do begin
    Part := FDocument.Parts.Items[I];
    LoadCount := Finder.CountForOrder(nil, Part);
    // Создание элеиентов
    if LoadCount > 0 then begin
      NewItem := TOrderItem.Create(Part);
      NewItem.OrderCount := LoadCount;
      if (Items.Count = 0) or (SortTitleInd = -1) then Items.Add(NewItem)
        else begin
          J := 0;
          TitleNew := NewItem.Part.GetTranslatedTitle(FSortTitleInd);
          repeat
            TitleCurrent := Items.Items[J].Part.GetTranslatedTitle(SortTitleInd);
            inc(j);
          until (J = Items.Count) or (TitleNew < TitleCurrent);
          if J = Items.Count then Items.Add(NewItem)
            else Items.Insert(J - 1, NewItem);
        end;
    end;
  end;
  Finder.Free;
end;

procedure TInvoice.GetGrossWeightAndBoxCount(Part: TPart; var Gross: real;
      var BoxFull: integer; var BoxPart: integer);
var
  SearchResult: TSearchResult;
  Finder: TFindInShipment;
  I: integer;
  ItemNet, NetProcent: real;
  Box: TBox;
begin
  Gross := 0;
  BoxFull := 0;
  BoxPart := 0;
  Finder := TFindInShipment.Create(FDocument);
  SearchResult := TSearchResult.Create;
  if not Finder.SearchPartInContainers(Part, SearchResult) then begin
    Finder.Free;
    SearchResult.Free;
    Exit;
  end;
  Finder.Free;
  //
  for I := 0 to SearchResult.Count - 1 do begin
    Box := SearchResult.Items[I].Box;
    if not Box.IsMultipart then begin
      Gross := Gross + Box.GroupGrossWeight;
      BoxFull := BoxFull + Box.BoxCount;
      Continue;
    end;
    BoxPart := BoxPart + Box.BoxCount;
    if Box.GroupNetWeight = 0 then Continue;
    ItemNet := SearchResult.Items[I].Count * Part.Weight;
    NetProcent := ItemNet / Box.GroupNetWeight;
    Gross := Gross + SimpleRoundTo(Box.GroupGrossWeight * NetProcent,
      - GlobalSettings.GetInstance.WeightAccuracy);
  end;
  SearchResult.Free;
end;

function TInvoice.MakeCFRFromFOB(Part: TPart): real;
var
  FOBPrice, CFRPrice: real;
begin
  FOBPrice := Part.FOBPrice;
  if FOBPrice = 0 then FOBPrice := GlobalSettings.GetInstance.DefFOBPrice;
  CFRPrice := FOBPrice;
  if GlobalSettings.GetInstance.CFRPriceFactor <> 0 then
    CFRPrice := CFRPrice * GlobalSettings.GetInstance.CFRPriceFactor;
  CFRPrice := SimpleRoundTo(CFRPrice, -GlobalSettings.GetInstance.MoneyAccuracy);
  Part.CFRPrice := CFRPrice;
  Result := Part.CFRPrice;
end;

procedure TInvoice.CalculateRow(var Row:TInvoiceRow; Item: TOrderItem);
var
  Part: TPart;
begin
  Part := Item.Part;
  Row.BOM := Part.BOM;
  Row.Code := Part.Code;
  Row.ShortTitle := Part.ShortTitle;
  Row.EngTitle := Part.EngName;
  Row.RusTitle := Part.RusName;
  Row.PartUnit := Translator.GetInstance.TranslateWord(Part.PartUnit);
  Row.Count := Item.OrderCount;
  if (Part.CFRPrice = 0) and (GlobalSettings.GetInstance.UseFOBForCFR) then
    Self.MakeCFRFromFOB(Part);
  Row.CFRPrice := Part.CFRPrice;
  Row.CFRTotal := SimpleRoundTo(Part.CFRPrice * Item.OrderCount,
    -GlobalSettings.GetInstance.MoneyAccuracy);
  if Part.NetUnit = True then
    Row.NetTotal := Item.OrderCount * Part.NetCoefficient
  else Row.NetTotal := SimpleRoundTo(Part.Weight * Item.OrderCount,
    -GlobalSettings.GetInstance.WeightAccuracy);

  Self.GetGrossWeightAndBoxCount(Part, Row.GrossTotal, Row.BoxFullCount,
    Row.BoxPartCount);

  Row.CustomCode := Part.CustomCode;
  if Row.GrossTotal = 0 then Row.PriceRisk := 0
    else Row.PriceRisk := SimpleRoundTo(Row.CFRTotal / Row.GrossTotal, -2);
  Row.Part := Part;
end;

procedure TInvoice.AddCustomRow(Row:TInvoiceRow);
var
  I: integer;
begin
  for I := 0 to High(FCustomCodeRows) do
    if FCustomCodeRows[I].CustomCode = Row.CustomCode then begin
      FCustomCodeRows[I].CFRTotal := FCustomCodeRows[I].CFRTotal + Row.CFRTotal;
      FCustomCodeRows[I].NetTotal := FCustomCodeRows[I].NetTotal + Row.NetTotal;
      FCustomCodeRows[I].GrossTotal := FCustomCodeRows[I].GrossTotal + Row.GrossTotal;
      FCustomCodeRows[I].BoxFullCount := FCustomCodeRows[I].BoxFullCount + Row.BoxFullCount;
      FCustomCodeRows[I].BoxPartCount := FCustomCodeRows[I].BoxPartCount + Row.BoxPartCount;
      Exit;
    end;
  SetLength(FCustomCodeRows, High(FCustomCodeRows) + 2);
  I := High(FCustomCodeRows);
  FCustomCodeRows[I] := Row;
end;

procedure TInvoice.CreateRows(Items: TOrder);
var
  I: integer;
begin
  SetLength(FRows, Items.Count);
  FTotalPrice := 0;
  FTotalNet := 0;
  FTotalGross := 0;
  for I := 0 to Items.Count - 1 do begin
    Self.CalculateRow(FRows[I], Items.Items[I]);
    FTotalPrice := FTotalPrice + FRows[I].CFRTotal;
    FTotalNet :=  FTotalNet + FRows[I].NetTotal;
    FTotalGross :=  FTotalGross + FRows[I].GrossTotal;
    Self.AddCustomRow(FRows[I]);
  end;
end;

end.
