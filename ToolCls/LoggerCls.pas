unit LoggerCls;

interface

uses
  Classes;

type
  TLogger = class(TObject)
  private
    FFile: TextFile;
  public
    constructor Create(FileName: string);
    destructor Destroy; override;
    procedure Log(caption: string; value: variant);
  end;

var
  Logger: TLogger;

implementation

constructor TLogger.Create(FileName: string);
begin
  inherited Create;
  AssignFile(FFile, FileName);
  Rewrite(FFile);
end;

destructor TLogger.Destroy;
begin
  CloseFile(FFile);
  inherited Destroy;
end;

procedure TLogger.Log(caption: string; value: variant);
begin
  Write(FFile, caption + ':   ');
  WriteLn(FFile, Value);
end;


end.
