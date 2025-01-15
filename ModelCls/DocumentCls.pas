unit DocumentCls;

interface

uses
  PartListCls, ContainerListCls, OrderListCls;

type
  TDocument = class(TObject)
  private
    FParts: TPartList;
    FOrders: TOrderList;
    FContainers: TContainerList;
    FFileName: string;
    FIsModified: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Parts: TPartList read FParts;
    property Orders: TOrderList read FOrders;
    property Containers: TContainerList read FContainers;
    property IsModified: boolean read FIsModified write FIsModified;
    property FileName: string read FFileName write FFileName;
    function LoadFromFile(filename: string=''): boolean;
    function Save: boolean;
    function GetNewBoxNumber(Pref: string = ''): string;
    function GetNewPartCode(Pref: string = ''): string;
    function GetNewContainerTitle: string;
    function GetNewOrderTitle: string;
  end;

implementation

uses
  SysUtils, DocLoaderCls, Dialogs, DocSaverCls, OrderCls;

constructor TDocument.Create;
begin
  inherited Create;
  FParts := TPartList.Create;
  FOrders := TOrderList.Create;
  FContainers := TContainerList.Create;
  FIsModified := False;
end;

destructor TDocument.Destroy;
begin
  FParts.Free;
  FOrders.Free;
  FContainers.Free;
  inherited Destroy;
end;

function Tdocument.LoadFromFile(filename: string = ''): boolean;
var
  loader: TDocLoader;
  Order: TOrder;
begin
  Result := false;
  if (length(filename) = 0) and (length(FFileName) = 0) then Exit;
  if (length(filename) > 0) then self.FFileName := filename;
  if FileExists(FFileName) then begin
    loader := TDocLoader.Create(FFileName);
    if Loader.FileIs1C then begin
      Order := TOrder.Create;
      Result := Loader.LoadOrderFrom1C(Order, Self);
      if Result then Self.Orders.Add(Order) else Order.Free;
    end else
      Result := loader.Load(self);
    loader.Destroy;
  end;
end;

function TDocument.Save: boolean;
var
  Saver: TDocSaver;
begin
  Saver := TDocSaver.Create(Self.FFileName);
  Result := Saver.SaveDocument(Self);
  Saver.Destroy;
end;

function TDocument.GetNewBoxNumber(Pref: string = ''): string;
var
  ContInd: integer;
  Number: integer;
  NewCode: string;
  UniqueCode: boolean;
begin
  Result := Pref + '000001';
  if (Self = nil) or (Containers = nil) then Exit;
  Number := 1;
  UniqueCode := True;
  repeat
    NewCode := Pref + IntToStr(Number);
    while Length(NewCode) < 5 do insert('0', NewCode, Length(Pref) + 1);
    for ContInd := 0 to Self.Containers.Count - 1 do begin
      UniqueCode := (Self.Containers.Items[ContInd].IndByCode(NewCode) = -1);
      if not UniqueCode then Break;
    end;
    if not UniqueCode then inc(Number);
  until UniqueCode = True;
  Result := NewCode;
end;

function TDocument.GetNewPartCode(Pref: string = ''): string;
var
  Number: integer;
  NewCode: string;
  UniqueCode: boolean;
begin
  Result := Pref + '000001';
  if (Self = nil) or (FParts = nil) then Exit;
  Number := 1;
  repeat
    NewCode := Pref + IntToStr(Number);
    while Length(NewCode) < 5 do insert('0', NewCode, Length(Pref) + 1);
    UniqueCode := (Self.FParts.Items[NewCode] = nil);
    if not UniqueCode then inc(Number);
  until UniqueCode = True;
  Result := NewCode;
end;

function TDocument.GetNewContainerTitle: string;
var
  Number: integer;
  Text, NewTitle: string;
  UniqueCode: boolean;
begin
  Text := 'NEW CONT ';
  Result := Text + ' 1';
  if (Self = nil) or (SElf.FContainers = nil) then Exit;
  Number := 1;
  repeat
    NewTitle := Text + FormatFloat('###', Number);
    UniqueCode := (Self.FContainers.ContainerByTitle[NewTitle] = nil);
    if not UniqueCode then inc(Number);
  until UniqueCode = True;
  Result := NewTitle;
end;

function TDocument.GetNewOrderTitle: string;
var
  Number: integer;
  Text, NewTitle: string;
  UniqueCode: boolean;
begin
  Text := 'NEW ORDER ';
  Result := Text + ' 1';
  if (Self = nil) or (Self.FOrders = nil) then Exit;
  Number := 1;
  repeat
    NewTitle := Text + FormatFloat('###', Number);
    UniqueCode := (Self.FOrders.IndByTitle(NewTitle) < 0);
    if not UniqueCode then inc(Number);
  until UniqueCode = True;
  Result := NewTitle;
end;

end.
