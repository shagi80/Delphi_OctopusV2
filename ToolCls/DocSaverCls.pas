unit DocSaverCls;

interface
uses
  PartCls, OrderCls, DocumentCls, ContainerCls, InvoiceCls;

type
  TDocSaver = class(TObject)
  private
    FFile: TextFile;
    const SEPARATOR = '","';
    procedure SaveOrder(Order: TOrder);
    procedure SaveContainer(Container: TContainer);
  public
    constructor Create(filename: string);
    destructor Destroy; override;
    function SaveDocument(Document: TDocument): boolean;
    function SaveOrderTo1C(Order: TOrder): boolean;
    function SaveExportTo1C(Title: string; Invoice: TInvoice): boolean;
  end;


implementation

uses
  SysUtils, Dialogs, StrUtils, OrderItemCls, BoxCls, GlobalSettingsCls,
  BoxItemCls, TranslatorCls;

constructor TDocSaver.Create(filename: string);
begin
  inherited Create;
  AssignFile(FFile, filename);
  Rewrite(FFile);
end;

destructor TDocSaver.Destroy;
begin
  CloseFile(FFile);
  inherited Destroy;
end;

procedure TDocSaver.SaveOrder(Order: TOrder);
var
  I: integer;
  str: string;
  Part: TPart;
begin
  WriteLn(Self.FFile, Order.Title);
  WriteLn(Self.FFile, Order.Count);
  for I := 0 to Order.Count - 1 do begin
    str := '"';
    Part := Order.Items[I].Part;
    str := str + IntToStr(I + 1) + SEPARATOR;
    str := str + Part.Code + SEPARATOR;
    str := str + Part.BOM + SEPARATOR;
    str := str + Part.ShortTitle + SEPARATOR;
    str := str + Part.RusName + SEPARATOR;
    str := str + Part.EngName + SEPARATOR;
    str := str + '0' + SEPARATOR; // Количество в комплектовочной ведомости
    str := str + Part.PartUnit + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
      Part.Weight) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.VolumeAccuracyMask,
      Part.Volume) + SEPARATOR;
   // str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
    //  Part.CountInBox) + SEPARATOR;
    str := str + FloatToStr(Part.CountInBox) + SEPARATOR;
    str := str + '' + SEPARATOR; // Штрих-код детали
    str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
      Order.Items[I].OrderCount) + SEPARATOR;
    str := str + '0' + SEPARATOR; // Вес брутто детали
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.SupplierPrice) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.FOBPrice) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.CFRPrice) + SEPARATOR;
    str := str + 'false' + SEPARATOR; // Признак выделения детали
    if Part.NetUnit then str := str + 'true' + SEPARATOR
      else str := str + 'false' + SEPARATOR;
    str := str + '0' + SEPARATOR; // Изначальное значение кол-ва в коробке
    str := str + UTF8Encode(Part.ChinName) + SEPARATOR;
    str := str + Part.CustomCode + SEPARATOR;
    str := str + Part.BoxType;
    str := str + '"';
    //ShowMessage(str);
    WriteLn(Self.FFile, str);
  end;
end;

procedure TDocSaver.SaveContainer(Container: TContainer);
var
  I, J: integer;
  str: string;
  Box: TBox;
  Item: TBoxItem;
begin
  str := '"' + Container.Title + SEPARATOR;
  str := str + FloatToStr(Container.MaxVolume) + SEPARATOR;
  str := str + FloatToStr(Container.MaxWeight) + '"';
  WriteLn(Self.FFile, str);
  WriteLn(Self.FFile, Container.Count);
  for I := 0 to Container.Count - 1 do begin
    Box := Container.Items[I];
    str := '"' + IntToStr(Box.BoxCount) + SEPARATOR;
    if Box.BoxCount = 1 then str := str + 'false' + SEPARATOR // в группе больше одной коробки
      else str := str + 'true' + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
      Box.GroupGrossWeight) + SEPARATOR;
    str := str + Box.BoxCode + SEPARATOR;
    str := str + 'false' + '"'; // отметка, что коробка выбрана
    WriteLn(Self.FFile, str);
    WriteLn(Self.FFile, Box.Count);
    for J := 0 to Box.Count - 1 do begin
      Item := Box.Items[J];
      str := '"' + Item.Order.Title + SEPARATOR;
      str := str + Item.Part.Code + SEPARATOR;
      if Item.Part.NetUnit then str := str + 'true' + SEPARATOR
        else str := str + 'false' + SEPARATOR;
      str := str +FloatToStr(Item.OrderCount) + SEPARATOR;
      str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
        Item.Part.Weight) + SEPARATOR;
      str := str + FormatFloat(GlobalSettings.GetInstance.VolumeAccuracyMask,
        Item.Part.Volume) + SEPARATOR;
      str := str +IntTostr(J + 1) + '"';
      WriteLn(Self.FFile, str);
    end;
  end;
end;

function TDocSaver.SaveDocument(Document: TDocument): boolean;
var
  I: integer;
begin
  WriteLn(Self.FFile, Document.Orders.Count);  // Кол-во заказов
  for I := 0 to Document.Orders.Count - 1 do
    Self.SaveOrder(Document.Orders.Items[I]);
  WriteLn(Self.FFile, Document.Containers.Count);  // Кол-во контейнеров
  WriteLn(Self.FFile, StrToInt(Document.GetNewBoxNumber)); // Последний номер кjhj,rb
  for I := 0 to Document.Containers.Count - 1 do
    Self.SaveContainer(Document.Containers.Items[I]);
  Result := True;
end;

function TDocSaver.SaveOrderTo1C(Order: TOrder): boolean;
var
  I: integer;
  Part: TPart;
  str: string;
begin
  WriteLn(Self.FFile, '"' + Order.Title + '"');
  for I := 0 to Order.Count - 1 do begin
    Part := Order.Items[I].Part;
    str := '"' + IntToStr(I + 1) + SEPARATOR;
    str := str + Part.Code + SEPARATOR;
    str := str + Part.BOM + SEPARATOR;
    str := str + Part.CustomCode + SEPARATOR;
    str := str + Part.ShortTitle + SEPARATOR;
    str := str + Part.RusName + SEPARATOR;
    str := str + Part.EngName + SEPARATOR;
    str := str + UTF8Encode(Part.ChinName) + SEPARATOR;
    str := str + '0' + SEPARATOR; // Кол-во в одном комплекте
    str := str + Part.PartUnit + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.WeightAccuracyMask,
      Part.Weight) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.VolumeAccuracyMask,
      Part.Volume) + SEPARATOR;
    str := str + FloatToStr(Part.CountInBox) + SEPARATOR;
    str := str + '' + SEPARATOR; // Штрих-код детали
    str := str + '0' + SEPARATOR; // Вес брутто детали
    str := str + Part.BoxType + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.SupplierPrice) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.FOBPrice) + SEPARATOR;
    str := str + FormatFloat(GlobalSettings.GetInstance.MoneyAccuracyMask,
      Part.CFRPrice) + SEPARATOR;
    str := str +FloatToStr(Order.Items[I].OrderCount) + '"';
    WriteLn(Self.FFile, str);
  end;
  Result := True;
end;

function TDocSaver.SaveExportTo1C(Title: string; Invoice: TInvoice): boolean;
var
  I: integer;
  Row: TInvoiceRow;
  str: string;
begin
  WriteLn(Self.FFile, Title);
  for I := 0 to Invoice.Count - 1 do begin
    Row := Invoice.Row[I];
    str := '"' + Row.Code + SEPARATOR;
    str := str + Row.ShortTitle + SEPARATOR;
    str := str + FloatToStr(Row.Count) + SEPARATOR;
    str := str +FloatToStr(Row.CFRPrice) + '"';
    WriteLn(Self.FFile, str);
  end;
  Result := True;
end;

end.
