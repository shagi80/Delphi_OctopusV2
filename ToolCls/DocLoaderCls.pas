unit DocLoaderCls;

interface

uses
  PartCls, OrderCls, DocumentCls, PartListCls;

type
  TSubStrings = array of string;

  TDocLoader = class(TObject)
  private
    FFile: TextFile;
    function LoadPartsAndOrders(doc: TDocument): boolean;
    function LoadContainers(doc: TDocument): boolean;
    function ParseString(valString: string): TSubStrings;
    procedure AddSubstringToArray(substr: string; var Substrings: TSubStrings);
    function PartBuilder(Substrings: TSubStrings): TPart;
    function PartBuilder1C(Substrings: TSubStrings): TPart;
    function CheckICFeature(valString: string): boolean;
    const SEPARATOR = '","';
    function CalculateCFRPrice(CFRPrice, FOBPrice: real): real;
    function UniverseStrToFloat(val: string; Def: real): real;
  public
    constructor Create(filename: string);
    destructor Destroy; override;
    function Load(doc: TDocument): boolean;
    function LoadOrderFrom1C(var Order: TOrder; Doc: TDocument): boolean;
    function GetPartListFrom1CFile(Parts: TPartList): boolean;
    function FileIs1C: boolean;
  end;


implementation

uses
  SysUtils, Dialogs, StrUtils, OrderItemCls, ContainerCls, BoxCls,
  BoxItemCls, TranslatorCls, GlobalSettingsCLS;

constructor TDocLoader.Create(filename: string);
begin
  inherited Create;
  AssignFile(FFile, filename);
  Reset(FFile);
end;

destructor TDocLoader.Destroy;
begin
  CloseFile(FFile);
  inherited Destroy;
end;

function TDocLoader.CalculateCFRPrice(CFRPrice, FOBPrice: real): real;
begin
  if (CFRPrice = 0) and (GlobalSettings.GetInstance.UseFOBForCFR) then
    CFRPrice := FOBPrice * GlobalSettings.GetInstance.CFRPriceFactor;
  Result := CFRPrice;
end;

procedure TDocLoader.AddSubstringToArray(substr: string;
  var Substrings: TSubStrings);
begin
  if length(substr) > 0  then begin
    while (length(substr) > 0) and (substr[1] in ['"', ',']) do
      delete(substr, 1, 1);
    while (length(substr) > 0) and (substr[length(substr)] in ['"', ',']) do
      delete(substr, length(substr), 1);
    SetLength(Substrings, high(Substrings) + 2);
    Substrings[high(Substrings)] := substr;
  end;
end;

function TDocLoader.ParseString(valString: string): TSubStrings;
var
  firstInd, Ind: integer;
  substr: string;
  Substrings: TSubStrings;
begin
  SetLength(Substrings, 0);
  firstInd := 1;
  while True do begin
    Ind := PosEx(SEPARATOR, valString, firstInd);
    if Ind = 0 then begin
      substr := copy(valString, firstInd, MaxInt);
      AddSubstringToArray(substr, Substrings);
      Break;
    end;
    substr := copy(valString, firstInd, Ind - firstInd + 1);
    AddSubstringToArray(substr, Substrings);
    firstInd := ind + 1;
  end;
  Result := Substrings;
end;

function TDocLoader.UniverseStrToFloat(val: string; Def: real): real;
const
  Dot = '.';
  Comma = ',';
begin
  if DecimalSeparator = Dot then
    val := StringReplace(val, Comma , Dot, [rfReplaceAll])
  else
    val := StringReplace(val, Dot , Comma, [rfReplaceAll]);
  Result := StrToFloatDef(val, Def);
end;

function TDocLoader.PartBuilder(Substrings: TSubStrings): TPart;
var
  Part: TPart;
begin
  Part := TPart.Create(Substrings[1]);
  with Part do begin
    BOM := Substrings[2];
    ShortTitle := Substrings[3];
    RusName := Substrings[4];
    EngName := Substrings[5];
    ChinName := (Substrings[20]);
    PartUnit := Substrings[7];
    Weight := UniverseStrToFloat(Substrings[8], 0);
    Volume := UniverseStrToFloat(Substrings[9], 0);
    CountInBox := UniverseStrToFloat(Substrings[10], 0);
    SupplierPrice := UniverseStrToFloat(Substrings[14], 0);
    FOBPrice := UniverseStrToFloat(Substrings[15], 0);
    CFRPrice := UniverseStrToFloat(Substrings[16], 0);
    CustomCode := Substrings[21];
    BoxType := Substrings[22];
  end;
  if Part.FOBPrice = 0 then Part.FOBPrice := GlobalSettings.GetInstance.DefFOBPrice;  
  Part.CFRPrice := Self.CalculateCFRPrice(Part.CFRPrice, Part.FOBPrice);
  Result := Part;
end;

function TDocLoader.PartBuilder1C(Substrings: TSubStrings): TPart;
var
  Part: TPart;
begin
  Part := TPart.Create(Substrings[1]);
  with Part do begin
    BOM := Substrings[2];
    CustomCode := Substrings[3];
    ShortTitle := Substrings[4];
    RusName := Substrings[5];
    EngName := Substrings[6];
    ChinName := (Substrings[7]);
    PartUnit := Substrings[9];
    Weight := UniverseStrToFloat(Substrings[10], 0);
    Volume := UniverseStrToFloat(Substrings[11], 0);
    CountInBox := UniverseStrToFloat(Substrings[12], 0);
    BoxType := Substrings[15];
    SupplierPrice := UniverseStrToFloat(Substrings[16], 0);
    FOBPrice := UniverseStrToFloat(Substrings[17], 0);
    CFRPrice := UniverseStrToFloat(Substrings[18], 0);
  end;
  if Part.FOBPrice = 0 then Part.FOBPrice := GlobalSettings.GetInstance.DefFOBPrice;
  Part.CFRPrice := Self.CalculateCFRPrice(Part.CFRPrice, Part.FOBPrice);
  Result := Part;
end;

function TDocLoader.LoadPartsAndOrders(doc: TDocument): boolean;
var
  valString: string;
  Substrings: TSubStrings;
  orderInd, itemInd, orderCount, itemCount: integer;
  part: TPart;
  orderItem: TOrderItem;
  order: TOrder;
begin
  Result := False;
  ReadLn(FFile, valString);
  orderCount := StrToIntDef(valString, 0);
  if orderCount = 0 then Exit;
  for orderInd := 0 to orderCount - 1 do begin
    ReadLn(FFile, valString);
    if length(valString) = 0 then valString := 'no nmae';
    // Создание экземпляра класса заказа.
    order := TOrder.Create;
    order.Title := valString;
    ReadLn(FFile, valString);
    itemCount := StrToIntDef(valString, 0);
    for itemInd := 0 to itemCount - 1 do begin
      ReadLn(FFile, valString);
      Substrings := ParseString(valString);
      // Создание экземпляра детали.
      part := doc.Parts.Items[Substrings[1]];
      if part = nil then begin
        part := PartBuilder(Substrings);
        doc.Parts.Add(part);
      end;
      // Создание экземпляра строки заказа.
      orderItem := TorderItem.Create(part);
      orderItem.OrderCount := StrToFloatDef(Substrings[12], 0);
      order.Add(orderItem);
    end;
    doc.Orders.Add(order);
  end;
  Result := True;
end;

function TDocLoader.LoadContainers(doc: TDocument): boolean;
var
  valString: string;
  Substrings: TSubStrings;
  ContCount, BoxCount, ItemCount: integer;
  ContInd, BoxInd, ItemInd: integer;
  Container: TContainer;
  Box: TBox;
  BoxItem: TBoxItem;
  Part: TPart;
  Order: TOrder;
begin
  Readln(FFile, valString);
  ContCount := StrToIntDef(valString, 0);
  Readln(FFile, valString);
  for ContInd := 0 to ContCount - 1 do begin
    Container := TContainer.Create;
    Readln(FFile, valString);
    Substrings := ParseString(valString);
    Container.Title := Substrings[0];
    Container.MaxVolume := UniverseStrToFloat(Substrings[1], 0);
    Container.MaxWeight := UniverseStrToFloat(Substrings[2], 0);
    Readln(FFile, valString);
    BoxCount := StrToIntDef(valString, 0);
    for BoxInd := 0 to BoxCount - 1 do begin
      Readln(FFile, valString);
      Substrings := ParseString(valString);
      // Create box
      Box := TBox.Create;
      Box.BoxCount := StrToIntDef(Substrings[0], 0);
      Box.GroupGrossWeight := UniverseStrToFloat(Substrings[2], 0);
      Box.BoxCode := Substrings[3];
      Readln(FFile, valString);
      ItemCount := StrToIntDef(valString, 0);
      for ItemInd := 0 to ItemCount - 1 do begin
        Readln(FFile, valString);
        Substrings := ParseString(valString);
        // Create box item.
        Order := doc.Orders.OrderByTitle[Substrings[0]];
        Part := doc.Parts.Items[Substrings[1]];
        if (Order <> nil) and (Part <> nil) then begin
          BoxItem := TBoxItem.Create(Order, Part);
          BoxItem.OrderCount := UniverseStrToFloat(Substrings[3], 0);
          if BoxItem.OrderCount > 0 then Box.Add(BoxItem)
            else BoxItem.Free;
        end;
      end;
      if (Box.BoxCount > 0) and (Box.Count > 0) then Container.Add(Box)
        else Box.Free;
    end;
    doc.Containers.Add(Container);
  end;


  Result := True;
end;

function TDocLoader.CheckICFeature(valString: string): boolean;
var
  Msg: string;
begin
  Result := True;
  if StrToIntDef(valString, 0) > 0 then begin
    Msg := Translator.GetInstance.TranslateMessage(
      33, 'Ошибка загрузки') + ' !' + chr(13)
      + Translator.GetInstance.TranslateMessage(
      35, 'Проверьте формат файла. Это не файл 1C') + ' !';
    MessageDlg(Msg, mtWarning, [mbOk], 0);
    Result := False;
  end;
end;

//

function TDocLoader.Load(doc: TDocument): boolean;
var
  Text: string;
begin
  Reset(FFile);
  if not LoadPartsAndOrders(doc) then Result := False
    else Result := Self.LoadContainers(doc);
  if not Result then begin
    Text := Translator.GetInstance.TranslateMessage(
      33, 'Ошибка загрузки') + ' !' + chr(13)
      + Translator.GetInstance.TranslateMessage(
      34, 'Проверьте формат файла. Это не файл "Oктопус"') + ' !';
    MessageDlg(Text, mtWarning, [mbOk], 0);
  end;
end;

function TDocLoader.LoadOrderFrom1C(var Order: TOrder; Doc: TDocument): boolean;
var
  valString: string;
  Substrings: TSubStrings;
  Part: TPart;
  OrderItem: TOrderItem;
begin
  Result := False;
  Reset(FFile);
  ReadLn(FFile, valString);
  if not Self.CheckICFeature(valString) then Exit;
  Order.Title := copy(valString, 2, Length(valString) - 2);
  while not EoF(FFile) do begin
    ReadLn(FFile, valString);
    Substrings := ParseString(valString);
    // Создание экземпляра детали.
    part := doc.Parts.Items[Substrings[1]];
    if part = nil then begin
      part := PartBuilder1C(Substrings);
      doc.Parts.Add(part);
    end;
    // Создание экземпляра строки заказа.
    OrderItem := TorderItem.Create(part);
    OrderItem.OrderCount := UniverseStrToFloat(Substrings[19], 0);
    Order.Add(OrderItem);
  end;
  Result := True;
end;

function TDocLoader.GetPartListFrom1CFile(Parts: TPartList): boolean;
var
  valString: string;
  Substrings: TSubStrings;
  Part: TPart;
begin
  Result := False;
  Reset(FFile);
  ReadLn(FFile, valString);
  if not Self.CheckICFeature(valString) then Exit;
  while not EoF(FFile) do begin
    ReadLn(FFile, valString);
    Substrings := ParseString(valString);
    // Создание экземпляра детали.
    Part := PartBuilder1C(Substrings);
    Parts.Add(part);
  end;
  Result := True;
end;

function TDocLoader.FileIs1C: boolean;
var
  valString: string;
begin
  Reset(FFile);
  ReadLn(FFile, valString);
  Result := (StrToIntDef(valString, 0) = 0);
end;

end.
