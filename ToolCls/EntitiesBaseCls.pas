unit EntitiesBaseCls;

interface

uses
  SysUtils, SQLite3, SQLite3Wrap, Classes;

type
  TEntitiesRec = record
    Id: integer;
    IsSupplier: boolean;
    RusName: widestring;
    EngName: widestring;
    RusAddr: widestring;
    EngAddr: widestring;
    ContractNumber: widestring;
    ContractDate: widestring;
    DirectorPosition: widestring;
    DirectorName: widestring;
    phone: widestring;
    bank_name: widestring;
    bank_details: widestring;
    country: widestring;
    main_port_rus: widestring;
    main_port_eng: widestring;
  end;

  TEntitiesArray = array of TEntitiesRec;

  TPortsArray = array of string;

  TEntitiesBase = class(TObject)
  private
    FDB : TSQLite3Database;
    const DB_FILENAME: string = 'entities.db';
    procedure ReadEntities(var Entitie: TEntitiesRec; Stmt: TSQLite3Statement);
  public
    constructor Create;
    destructor Destroy; override;
    function GetEntities(var EntitiesArray: TEntitiesArray): boolean;
    function GetPorts(var Ports: TPortsArray): boolean;
    function GetOneEntitie(id: integer; var Entitie: TEntitiesRec): boolean;
    function GetOnePort(id: integer; var Port: string): boolean;
  end;

implementation

uses
  Forms;

constructor TEntitiesBase.Create;
var
  FileName: string;
begin
  inherited Create;
  FDB := nil;
  FileName := ExtractFilePath(Application.ExeName) + DB_FILENAME;
  if FileExists(FileName) then begin
    FDB := TSQLite3Database.Create;
    try
      FDB.Open(FileName);
    except
      FDB.Free;
      FDB := nil;
    end;
  end;
end;

destructor TEntitiesBase.Destroy;
begin
  FDB.Free;
  inherited Destroy;
end;

procedure TEntitiesBase.ReadEntities(var Entitie: TEntitiesRec; Stmt: TSQLite3Statement);
begin
  Entitie.Id := Stmt.ColumnInt(0);
  Entitie.IsSupplier := (Stmt.ColumnInt(1) = 1);
  Entitie.RusName := Stmt.ColumnText(2);
  Entitie.EngName := Stmt.ColumnText(3);
  Entitie.RusAddr := Stmt.ColumnText(4);
  Entitie.EngAddr := Stmt.ColumnText(5);
  Entitie.ContractNumber := Stmt.ColumnText(6);
  Entitie.ContractDate := Stmt.ColumnText(7);
  Entitie.DirectorPosition := Stmt.ColumnText(8);
  Entitie.DirectorName := Stmt.ColumnText(9);
  Entitie.phone := Stmt.ColumnText(10);
  Entitie.bank_name := Stmt.ColumnText(11);
  Entitie.bank_details := Stmt.ColumnText(12);
  Entitie.country := Stmt.ColumnText(13);
  Entitie.main_port_rus := Stmt.ColumnText(14);
  Entitie.main_port_eng := Stmt.ColumnText(15);
end;

function TEntitiesBase.GetEntities(var EntitiesArray: TEntitiesArray): boolean;
var
  Sql: string;
  Stmt: TSQLite3Statement;
  Ind: integer;
begin
  Result := False;
  SetLength(EntitiesArray, 0);
  if Self.FDB = nil then Exit;
  Sql := 'SELECT * FROM entities';
  Stmt := FDB.Prepare(Sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      SetLength(EntitiesArray, High(EntitiesArray) + 2);
      Ind := High(EntitiesArray);
      Self.ReadEntities(EntitiesArray[Ind], Stmt);
      if not Result then Result := True;
    end;
  finally
    Stmt.Free;
  end;
end;

function TEntitiesBase.GetPorts(var Ports: TPortsArray): boolean;
var
  Sql: string;
  Stmt: TSQLite3Statement;
  Ind: integer;
begin
  Result := False;
  SetLength(Ports, 0);
  if Self.FDB = nil then Exit;
  Sql := 'SELECT * FROM ports';
  Stmt := FDB.Prepare(Sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      SetLength(Ports, High(Ports) + 2);
      Ind := High(Ports);
      Ports[Ind] := Stmt.ColumnText(1);
      if not Result then Result := True;
    end;
  finally
    Stmt.Free;
  end;
end;

function TEntitiesBase.GetOneEntitie(id: integer; var Entitie: TEntitiesRec): boolean;
var
  Sql: string;
  Stmt: TSQLite3Statement;
begin
  Result := False;
  if Self.FDB = nil then Exit;
  Sql := 'SELECT * FROM entities WHERE id=' + IntToStr(id);
  Stmt := FDB.Prepare(Sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      Self.ReadEntities(Entitie, Stmt);
      if not Result then Result := True;
    end;
  finally
    Stmt.Free;
  end;
end;

function TEntitiesBase.GetOnePort(id: Integer; var Port: string): boolean;
var
  Sql: string;
  Stmt: TSQLite3Statement;
begin
  Result := False;
  if Self.FDB = nil then Exit;
  Sql := 'SELECT * FROM ports WHERE id=' + IntToStr(id);
  Stmt := FDB.Prepare(Sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      Port := Stmt.ColumnText(1);
      if not Result then Result := True;
    end;
  finally
    Stmt.Free;
  end;
end;


end.
