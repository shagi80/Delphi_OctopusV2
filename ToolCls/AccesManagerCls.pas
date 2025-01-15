unit AccesManagerCls;

interface

uses
  SysUtils, SQLite3, SQLite3Wrap, Classes;

type
  TAccesManagerSingleton = class(TObject)
  private
    FDB : TSQLite3Database;
    FKeys: array [1..6] of boolean;
    const DB_FILENAME: string = 'access.db';
    class var FInstance: TAccesManagerSingleton;
    function CheckAcces(index: integer): boolean;
    procedure SetAccess(Index: integer; Value: boolean);
  public
    property CanEditParts: boolean index 1 read CheckAcces write SetAccess;
    property CanEditOrders: boolean index 2 read CheckAcces write SetAccess;
    property CanEditContainers: boolean index 3 read CheckAcces write SetAccess;
    property CanEditBoxes: boolean index 4 read CheckAcces write SetAccess;
    property CanEditInvoice: boolean index 5 read CheckAcces write SetAccess;
    property CanEditSettings: boolean index 6 read CheckAcces write SetAccess;
    procedure GetStrings(Strs: TStringList);
    procedure SetAccessLevel(Password: string);
    class function GetInstance(): TAccesManagerSingleton;
    class procedure DestroyInstance;
  end;

  TAccesManager = class of TAccesManagerSingleton;

var
  AccesManager: TAccesManager;

implementation

uses
  TranslatorCls, GlobalSettingsCls, Dialogs;

class procedure TAccesManagerSingleton.DestroyInstance;
begin
  if Assigned(FInstance) then begin
    if Assigned(FInstance.FDB) then FInstance.FDB.Free;
    FInstance.Free;
  end;
end;

class function TAccesManagerSingleton.GetInstance(): TAccesManagerSingleton;
var
  I: integer;
begin
  if not Assigned(FInstance) then begin
    FInstance := TAccesManagerSingleton.Create();
    for I := 1 to 6 do Finstance.FKeys[I] := False;
    FInstance.FDB := nil;
    if FileExists(DB_FILENAME) then begin
      FInstance.FDB := TSQLite3Database.Create;
      try
        FInstance.FDB.Open(DB_FILENAME);
      except
        FInstance.FDB.Free;
        FInstance.FDB := nil;
      end;
    end;
  end;
  Result := FInstance;
end;

function TAccesManagerSingleton.CheckAcces(index: integer): boolean;
begin
  Result := Self.FKeys[Index];
end;

procedure TAccesManagerSingleton.SetAccess(Index: integer; Value: boolean);
begin
  Self.FKeys[Index] := Value;
end;

procedure TAccesManagerSingleton.SetAccessLevel(Password: string);
var
  Sql: string;
  Stmt: TSQLite3Statement;
  I: integer;
begin
  for I := 1 to 6 do Finstance.FKeys[I] := False;
  if Self.FDB = nil then Exit;
  if Length(Password) = 0 then Exit;
  //
  Sql := 'SELECT * FROM password WHERE password="' + Password + '"';
  Stmt := FDB.Prepare(sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      for I := 1 to 6 do Self.FKeys[i] := (Stmt.ColumnInt(I + 2) = 1);
    end;
  finally
    Stmt.Free;
  end;
end;

procedure TAccesManagerSingleton.GetStrings(Strs: TStringList);
begin
  Strs.Clear;
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование деталей')
    + '=' + IntToStr(Integer(Self.CheckAcces(1))));
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование заказов')
    + '=' + IntToStr(Integer(Self.CheckAcces(2))));
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование контейнеров')
    + '=' + IntToStr(Integer(Self.CheckAcces(3))));
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование коробок')
    + '=' + IntToStr(Integer(Self.CheckAcces(4))));
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование инвойса')
    + '=' + IntToStr(Integer(Self.CheckAcces(5))));
  Strs.Add(Translator.GetInstance.TranslateWord('редактирование настроек')
    + '=' + IntToStr(Integer(Self.CheckAcces(6))));
end;

end.
