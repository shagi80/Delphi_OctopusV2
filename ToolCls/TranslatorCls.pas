unit TranslatorCls;

interface

{ Класс для обеспечения перевода слов.
  Singletone, обеспечивающий доступ к БД,
  func TranslateCaption, TranslateHint, TRanslateMessage - обеспечение
  выьборки из соответствующих таблиц по Id
  funct TranslateWord - выборка из таблицы word по русскому написанию
  слова. }

uses
  SysUtils, SQLite3, SQLite3Wrap, GlobalSettingsCls;

const
  LANG_RUSSIAN = 0;
  LANG_ENGLISH = 1;
  LANG_CHINESE = 2;

type
  TTranslatorSingleton = class(TObject)
  private
    FDB : TSQLite3Database;
    function TranslateById(tableName: string; id: Integer; default: string = ''): string;
    function GetFromBD(sql: string): string;
    const DB_FILENAME: string = 'language.db';
    const UNKNOW_VALUE: string = '????';
    const LANG_FIELDS: array [0..2] of string = ('russian', 'english', 'english');
    class var FInstance: TTranslatorSingleton;
  public
    function TranslateCaption(id: Integer; default: string = ''): string;
    function TranslateHint(id: Integer; default: string = ''): string;
    function TranslateMessage(id: Integer; default: string = ''): string;
    function TranslateWord(word: string): string;
    class function GetInstance(): TTranslatorSingleton;
    class procedure DestroyInstance;
  end;

  TTranslator = class of TTranslatorSingleton;

var
  Translator: TTranslator;

implementation

uses
  Dialogs;

class procedure TTranslatorSingleton.DestroyInstance;
begin
  if Assigned(FInstance) then begin
    if Assigned(FInstance.FDB) then FInstance.FDB.Free;
    FInstance.Free;
  end;
end;

class function TTranslatorSingleton.GetInstance(): TTranslatorSingleton;
begin
  if not Assigned(FInstance) then begin
    FInstance := TTranslatorSingleton.Create();
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

function TTranslatorSingleton.TranslateById(tableName: string; id: Integer;
  default: string = ''): string;
var
  sql, baseResult: string;
  language: integer;
begin
  language := GlobalSettings.GetInstance.Language;
  if Length(default) > 0 then Result := default
    else Result := UNKNOW_VALUE;
  sql := 'SELECT ' + LANG_FIELDS[language] +
    ' FROM ' + tableName + ' WHERE wordId=' + IntToStr(id);
  baseResult := self.GetFromBD(sql);
  if length(baseResult) <> 0 then Result := baseResult;
end;

function TTranslatorSingleton.GetFromBD(sql: string): string;
var
  Stmt: TSQLite3Statement;
begin
  result := '';
  Stmt := FDB.Prepare(sql);
  try
    while Stmt.Step = SQLITE_ROW do begin
      result := Stmt.ColumnText(0);
    end;
  finally
    Stmt.Free;
  end;
end;

function TTranslatorSingleton.TranslateCaption(id: Integer; default: string = ''): string;
begin
  Result := self.TranslateById('caption', id, default);
end;

function TTranslatorSingleton.TranslateHint(id: Integer; default: string = ''): string;
begin
  Result := self.TranslateById('hint', id, default);
end;

function TTranslatorSingleton.TranslateMessage(id: Integer; default: string = ''): string;
begin
  if GlobalSettings.GetInstance.Language = 0 then begin
    if Length(default) > 0 then Result := default else Result := UNKNOW_VALUE;
    Exit;
  end;
  Result := self.TranslateById('message', id, default);
end;

function TTranslatorSingleton.TranslateWord(word: string): string;
var
  sql: string;
  language: integer;
begin
  language := GlobalSettings.GetInstance.Language;
  if (language = LANG_RUSSIAN) or (not Assigned(FDB)) then begin
    Result := word;
  end else begin
    sql := 'SELECT ' + LANG_FIELDS[language] +
    ' FROM word WHERE russian="' + LowerCase(word) + '"';
    Result := self.GetFromBD(sql);
  end;
  if Length(Result) = 0 then Result := word;
end;

end.
