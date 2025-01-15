unit FileControllerCls;

interface

uses
  DocumentCls, Dialogs;

type
  TNewDocumentEvent = procedure(Sender: TObject) of object;
  TSaveDocumentEvent = procedure(Sender: TObject) of object;

  TFileController = class(TObject)
  private
    FDocument: TDocument;
    FNewDocumentEvent: TNewDocumentEvent;
    FSaveDocumentEvent: TSaveDocumentEvent;
    FSaveDlg: TSaveDialog;
    FOpenDlg: TOpenDialog;
    function SaveAs: boolean;
    procedure ClearDocument;
    procedure NewDocumentEvent;
    procedure SaveDocumentEvent;
  public
    constructor Create(Document: TDocument; SaveDlg: TSaveDialog;
      OpenDlg: TOpenDialog);
    property OnNewDocument: TNewDocumentEvent read FNewDocumentEvent
      write FNewDocumentEvent;
    property OnSaveDocument: TSaveDocumentEvent read FSaveDocumentEvent
      write FSaveDocumentEvent;
    procedure LoadDefaultDocument;
  published
    function CanDocumentFree: boolean;
    procedure NewDocument(Sender: TObject);
    procedure LoadDocument(Sender: TObject);
    procedure SaveDocument(Sender: TObject);
    procedure SaveAsDocument(Sender: TObject);
  end;

implementation

uses
  Controls, TranslatorCls, GlobalSettingsCls, ContainerCls, Forms,
  SysUtils;

constructor TFileController.Create(Document: TDocument; SaveDlg: TSaveDialog;
  OpenDlg: TOpenDialog);
begin
  inherited Create;
  FDocument := Document;
  FsaveDlg := SaveDlg;
  FOpenDlg := OpenDlg;
end;

function TFileController.CanDocumentFree: boolean;
var
  Way: Integer;
  Question: string;
begin
  Result := True;
  Question := Translator.GetInstance.TranslateMessage(
    1, 'Сохранить изменения в докуементе ?');
  if (FDocument <> nil) and (FDocument.IsModified) then begin
    Way := MessageDlg(Question, mtWarning, [mbYes, mbNo, mbCancel], 0);
    case Way of
      mrYes: Self.SaveDocument(Self);
      mrNo: ;
      mrCancel: Result := False;
    end;
  end;
end;

procedure TFileController.ClearDocument;
begin
  FDocument.Containers.Clear;
  FDocument.Orders.Clear;
  FDocument.Parts.Clear;
  FDocument.FileName := '';
  Self.NewDocumentEvent;
end;

function TFileController.SaveAs: boolean;
begin
  Result := False;
  if FSaveDlg.Execute then begin
    FDocument.FileName := FSaveDlg.FileName;
    Result := FDocument.Save;
    Self.SaveDocumentEvent;
  end;
end;

procedure TFileController.NewDocumentEvent;
begin
  if Assigned(Self.FNewDocumentEvent) then Self.FNewDocumentEvent(Self);
end;

procedure TFileController.SaveDocumentEvent;
begin
  if Assigned(Self.FSaveDocumentEvent) then Self.FSaveDocumentEvent(Self);
end;


procedure TFileController.NewDocument(Sender: TObject);
var
  Container: TContainer;
begin
  if Self.CanDocumentFree then begin
    Self.ClearDocument;
    Container := TContainer.Create;
    Container.Title := 'New cont';
    FDocument.Containers.Add(Container);
    Self.NewDocumentEvent;
  end;
end;

procedure TFileController.LoadDocument(Sender: TObject);
begin
  if Self.CanDocumentFree and Self.FOpenDlg.Execute then begin
    Self.ClearDocument;
    if FDocument.LoadFromFile(Self.FOpenDlg.FileName)then Self.NewDocumentEvent;
  end;
end;

procedure TFileController.SaveDocument(Sender: TObject);
begin
  if Length(FDocument.FileName) = 0 then Self.SaveAs
    else begin
      FDocument.Save;
      Self.SaveDocumentEvent;
    end;
end;

procedure TFileController.SaveAsDocument(Sender: TObject);
begin
  Self.SaveAs;
end;

procedure TFileController.LoadDefaultDocument;
var
  FileName: string;
begin
  FileName := ExtractFilePath(Application.ExeName) + GlobalSettings.GetInstance.DefFileNmae;
  Self.ClearDocument;
  if not (FileExists(FileName) and FDocument.LoadFromFile(FileName)) then
    Self.NewDocument(Self);
  Self.NewDocumentEvent;
end;

end.
