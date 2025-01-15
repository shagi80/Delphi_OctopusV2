unit PrintContainerControllerCls;

interface

uses
   Contnrs, ContainerCls, DocumentCls, ContainerListCls, frxClass;


type
  TPrintContainerController = class(TObject)
  private
    FDocument: TDocument;
    FContainerList: TContainerList;
    FMode: integer;
    procedure CannotPrint;
    procedure PrintContainers(ContainerList: TContainerList);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetDetailGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetSubdetailGetValue(const VarName: string; var Value: Variant);
    procedure frxDataSetMasterNext(Sender: TObject);
    procedure frxDataSetDetailNext(Sender: TObject);
    procedure PrintAll(Sender: TObject);
    procedure PrintCurrent(Sender: TObject);
    procedure PrintSelect(Sender: TObject);
    procedure PrintSelectBox(Sender: TObject);
    procedure CreateBoxData(Source, Target: TContainer; SortInd: integer);
    procedure MultiplyBoxes(Containers: TContainerList);
    procedure ResizePrintModeForm;
  public
    constructor Create(Document: TDocument);
    destructor Destroy; override;
    procedure PrintAllContainer(Sender: TObject);
    procedure PrintCurrentContainer(Sender: TObject);
    procedure PrintSelectContainer(Sender: TObject);
    procedure PrintAllBox(Sender: TObject);
    procedure PrintBoxFromCurrentContainer(Sender: TObject);
    procedure PrintBoxFromSelectContainer(Sender: TObject);
    procedure PrintSelectBoxFromSelectContainer(Sender: TObject);
  end;

implementation

uses
 PrintModeForm, TranslatorCls, Dialogs, FindInShipmentCls, BoxCls, BoxItemCls,
 SysUtils, ContainerForm, Forms, GlobalSettingsCls, PrintDataModule, WaitingForm;

const
  SortNone =  -1;
  SortBoxCode =  0;
  mdList = 0;
  mdLabels = 1;
  pfList = 'PrintForm/ContainerList.fr3';
  pfLabel = 'PrintForm/BoxLabel.fr3';


constructor TPrintContainerController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
  FContainerList := nil;
  FMode := 0;
end;

destructor TPrintContainerController.Destroy;
begin
  FDocument := nil;
  inherited Destroy;
end;

procedure TPrintContainerController.CannotPrint;
var
  Text: string;
begin
  Text := Translator.GetInstance.TranslateMessage(
    44, 'Нет данных для печати' + ' !');
  MessageDlg(Text, mtWarning, [mbOk], 0);
end;

procedure TPrintContainerController.ResizePrintModeForm;
begin
  frmPrintMode.pnBottom.Visible := False;
  frmPrintMode.Width := frmPrintMode.imgPrint.Width + 10;
  frmPrintMode.Height := frmPrintMode.imgPrint.Height + 30;
  frmPrintMode.Left := trunc((Screen.Width - frmPrintMode.Width) / 2);
  frmPrintMode.Top := trunc((Screen.Height - frmPrintMode.Height) / 2);
end;

// Подготовка данных.

procedure TPrintContainerController.CreateBoxData(Source, Target: TContainer; SortInd: integer);
var
  I, J: integer;
  NewBox, Box: TBox;
  CodeCurrent, CodeNew: widestring;
begin
  for I := 0 to Source.Count - 1 do begin
    Box := TBox(Source.Items[I]);
    NewBox := TBox.Create;
    NewBox.Copy(Box);
    if (Target.Count = 0) or (SortInd = SortNone) then Target.Add(NewBox)
      else begin
        J := 0;
        CodeNew := NewBox.BoxCode;
        repeat
          CodeCurrent := Box.BoxCode;
          inc(j);
        until (J = Target.Count) or (CodeNew < CodeCurrent);
        if J = Target.Count then Target.Add(NewBox)
          else Target.Insert(J - 1, NewBox);
      end;
  end;
end;

procedure TPrintContainerController.MultiplyBoxes(Containers: TContainerList);
var
  ContInd, BoxInd, I: integer;
  Container: TContainer;
  Box, NewBox: TBox;
  BoxCode: string;
begin
  for ContInd := 0 to Containers.Count - 1 do begin
    Container := Containers.Items[ContInd];
    BoxInd := 0;
    while BoxInd < Container.Count do begin
      Box := Container.Items[BoxInd];
      BoxCode := Box.BoxCode;
      Box.BoxCode := Box.BoxCode + '-1/' + IntToStr(Box.BoxCount);
      Inc(BoxInd);
      if (Box.BoxCount = 1) then Continue;
      //
      for I := 2 to Box.BoxCount do begin
        NewBox := TBox.Create;
        NewBox.Copy(Box);
        NewBox.BoxCode := BoxCode + '-'
          + IntToStr(I) + '/' + IntToStr(NewBox.BoxCount);
        if BoxInd < Container.Count then Container.Insert(BoxInd, NewBox)
          else Container.Add(NewBox);
        Inc(BoxInd);
      end;
    end;
  end;
end;

procedure TPrintContainerController.PrintAll(Sender: TObject);
var
  ContainerList: TContainerList;
  Container: TContainer;
  SortMode, I: Integer;
begin
  if FDocument.Containers.Count = 0 then begin
    Self.CannotPrint;
    Exit;
  end;
  SortMode := SortNone;
  if not frmPrintMode.GetBoxSortMode(SortMode) then begin
    frmPrintMode.ShowMainPage;
    Exit;
  end;
  ContainerList := TContainerList.Create;
  for I := 0 to FDocument.Containers.Count - 1 do begin
    Container := TContainer.Create;
    Container.Title := FDocument.Containers.Items[I].Title;
    Self.CreateBoxData(FDocument.Containers.Items[I], Container, SortMode);
    ContainerList.Add(Container);
  end;
  if Self.FMode = mdLabels then Self.MultiplyBoxes(ContainerList);
  Self.PrintContainers(ContainerList);
  ContainerList.Free;
end;

procedure TPrintContainerController.PrintCurrent(Sender: TObject);
var
  ContainerList: TContainerList;
  Container: TContainer;
  SortMode: Integer;
begin
  if frmContainers.CurrentContainer = nil then begin
    Self.CannotPrint;
    Exit;
  end;
  SortMode := SortNone;
  if not frmPrintMode.GetBoxSortMode(SortMode) then begin
    frmPrintMode.ShowMainPage;
    Exit;
  end;
  ContainerList := TContainerList.Create;
  Container := TContainer.Create;
  Container.Title := frmContainers.CurrentContainer.Title;
  Self.CreateBoxData(frmContainers.CurrentContainer, Container, SortMode);
  ContainerList.Add(Container);
  if Self.FMode = mdLabels then Self.MultiplyBoxes(ContainerList);
  Self.PrintContainers(ContainerList);
  ContainerList.Free;
end;

procedure TPrintContainerController.PrintSelect(Sender: TObject);
var
  ContainerList: TContainerList;
  I, SortMode: integer;
  Container: TContainer;
begin
  if FDocument.Containers.Count = 0 then begin
    Self.CannotPrint;
    Exit;
  end;
  SortMode := SortNone;
  repeat
    if not frmPrintMode.GetBoxSortMode(SortMode, False) then begin
      frmPrintMode.ShowMainPage;
      Exit;
    end;
  until frmPrintMode.SetCheckList(FDocument.Containers);
  ContainerList := TContainerList.Create;
  for I := 0 to frmPrintMode.cbCheck.Items.Count - 1 do
    if frmPrintMode.cbCheck.Checked[I] then begin
      Container := TContainer.Create;
      Container.Title := TContainer(frmPrintMode.cbCheck.Items.Objects[I]).Title;
      Self.CreateBoxData(TContainer(frmPrintMode.cbCheck.Items.Objects[I]),
        Container, SortMode);
      ContainerList.Add(Container);
    end;
  if ContainerList.Count > 0 then begin
    if Self.FMode = mdLabels then Self.MultiplyBoxes(ContainerList);
    Self.PrintContainers(ContainerList);
  end;
  ContainerList.Free;
end;

procedure TPrintContainerController.PrintSelectBox(Sender: TObject);
var
  ContainerList: TContainerList;
  Container: TContainer;
  BoxList: TObjectList;
  SortMode: Integer;
begin
  if frmContainers.CurrentContainer = nil then begin
    Self.CannotPrint;
    Exit;
  end;
  BoxList := TObjectList.Create(False);
  frmContainers.grContainer.GetSelectedObjects(1, BoxList);
  if BoxList.Count = 0 then begin
    BoxList.Free;
    Self.CannotPrint;
    Exit;
  end;
  SortMode := SortNone;
  if not frmPrintMode.GetBoxSortMode(SortMode) then begin
    frmPrintMode.ShowMainPage;
    Exit;
  end;
  ContainerList := TContainerList.Create;
  Container := TContainer.Create;
  Container.Title := frmContainers.CurrentContainer.Title;
  Self.CreateBoxData(TContainer(BoxList), Container, SortMode);
  ContainerList.Add(Container);
  if Self.FMode = mdLabels then Self.MultiplyBoxes(ContainerList);
  Self.PrintContainers(ContainerList);
  BoxList.Free;
  ContainerList.Free;
end;

// Настройка компонентов FastReports.

procedure TPrintContainerController.PrintContainers(ContainerList: TContainerList);
var
  FileName: string;
begin
  Self.ResizePrintModeForm;
  if (ContainerList = nil) or (ContainerList.Count = 0)
  or (ContainerList.Items[0].Count = 0) then begin
    frmPrintMode.Close;
    Self.CannotPrint;
    Exit;
  end;
  FileName := ExtractFilePath(Application.ExeName);
  case FMode of
    mdList: FileName := FileName + pfList;
    mdLabels: FileName := FileName + pfLabel;
  end;
  if FileExists(FileName) then begin
    FContainerList := ContainerList;
    with dmPrint do begin
      frmWaiting.WaitPrint;
      frxDataSetMaster.RangeEndCount := ContainerList.Count;
      frxDataSetMaster.First;
      frxDataSetMaster.OnNext := Self.frxDataSetMasterNext;
      frxDataSetMaster.OnGetValue := Self.frxDataSetMasterGetValue;

      frxDataSetDetail.RangeEndCount := ContainerList.Items[0].Count;
      frxDataSetDetail.First;
      frxDataSetDetail.OnNext := Self.frxDataSetDetailNext;
      frxDataSetDetail.OnGetValue := Self.frxDataSetDetailGetValue;

      frxDataSetSubDetail.RangeEndCount := ContainerList.Items[0].Items[0].Count;
      frxDataSetSubDetail.First;
      frxDataSetSubDetail.OnGetValue := Self.frxDataSetSubdetailGetValue;

      frxReport.OnGetValue := Self.frxReportGetValue;
      frxReport.LoadFromFile(FileName);
      frxReport.PrepareReport(True);
      frmWaiting.Hide;
      frxReport.ShowPreparedReport;
    end;

    FContainerList := nil;
  end else Self.CannotPrint;
  frmPrintMode.Close;
end;

// Подключаемые процедуры компонентов FastReports.

procedure TPrintContainerController.frxDataSetMasterNext(Sender: TObject);
var
  ContainerInd: integer;
begin
  ContainerInd := dmPrint.frxDataSetMaster.RecNo;
  if ContainerInd < FContainerList.Count then begin
    dmPrint.frxDataSetDetail.RangeEndCount := FContainerList.Items[ContainerInd].Count;
    dmPrint.frxDataSetDetail.First;
  end;
end;

procedure TPrintContainerController.frxDataSetDetailNext(Sender: TObject);
var
  ContainerInd, BoxInd: integer;
begin
  ContainerInd := dmPrint.frxDataSetMaster.RecNo;
  BoxInd := dmPrint.frxDataSetDetail.RecNo;
  if (ContainerInd < FContainerList.Count)
    and (BoxInd < FContainerList.Items[ContainerInd].Count) then begin
      dmPrint.frxDataSetSubdetail.RangeEndCount :=
        FContainerList.Items[ContainerInd].Items[BoxInd].Count;
      dmPrint.frxDataSetSubdetail.First;
  end;
end;

procedure TPrintContainerController.frxReportGetValue(const VarName: string; var Value: Variant);
var
  LocTranslator: TTranslatorSingleton;
begin
  Value := '??';
  LocTranslator := Translator.GetInstance;
  if VarName = 'ReportTitle' then
    case FMode of
      mdList: Value := LocTranslator.TranslateWord('Контейнера');
      mdLabels: Value := LocTranslator.TranslateWord('Ярлыки');
    end;
  if VarName = 'FileName' then Value := LocTranslator.TranslateWord('из файла')
    + ' ' + FDocument.FileName;
end;

procedure TPrintContainerController.frxDataSetMasterGetValue(const VarName: string; var Value: Variant);
var
  LocTranslator: TTranslatorSingleton;
begin
  LocTranslator := Translator.GetInstance;
  if VarName = 'ContainerTitle' then Value := LocTranslator.TranslateWord('Контейнер')
    + ': ' + FContainerList.Items[dmPrint.frxDataSetMaster.RecNo].Title;
  if VarName = 'hdrRow' then Value := '№';
  if VarName = 'hdrBoxCode' then Value := LocTranslator.TranslateWord('Гр.№');
  if VarName = 'hdrTitle' then Value := LocTranslator.TranslateWord('Наименование');
  if VarName = 'hdrUnit' then Value := LocTranslator.TranslateWord('Ед.');
  if VarName = 'hdrLoadCount' then Value := LocTranslator.TranslateWord('Загружено');
  if VarName = 'hdrBoxCount' then Value := LocTranslator.TranslateWord('Кол.мест');
  if VarName = 'hdrBoxNet' then Value := LocTranslator.TranslateWord('Нетто,кг');
  if VarName = 'hdrBoxGross' then Value := LocTranslator.TranslateWord('Брутто,кг');
  if VarName = 'hdrBoxPack' then Value := LocTranslator.TranslateWord('Уп-ка,кг');
  if VarName = 'hdrBoxVol' then Value := LocTranslator.TranslateWord('Объем,м3');
end;

procedure TPrintContainerController.frxDataSetDetailGetValue(const VarName: string; var Value: Variant);
var
  Box: TBox;
begin
  Value := '';
  frmWaiting.NextStep(Self);
  if dmPrint.frxDataSetDetail.RecNo >=
    FContainerList.Items[dmPrint.frxDataSetMaster.RecNo].Count then Exit;
  Box := FContainerList.Items[dmPrint.frxDataSetMaster.RecNo].Items[
    dmPrint.frxDataSetDetail.RecNo];
  if dmPrint.frxDataSetSubDetail.RecNo > 0 then Exit;
  if VarName = 'Row' then Value := dmPrint.frxDataSetDetail.RecNo + 1;
  if VarName = 'BoxCode' then Value := Box.BoxCode;
  if VarName = 'BoxCount' then Value := Box.BoxCount;
  if VarName = 'BoxNet' then Value := Box.GroupNetWeight;
  if VarName = 'BoxGross' then Value := Box.GroupGrossWeight;
  if VarName = 'BoxPack' then Value := Box.PackageWeight;
  if VarName = 'BoxVol' then Value := Box.Volume;
  if VarName = 'OneBoxGross' then Value := Box.OneBoxGrossWeight;
  if VarName = 'OneBoxNet' then Value := Box.OneBoxNetWeight;
end;

procedure TPrintContainerController.frxDataSetSubdetailGetValue(const VarName: string;
  var Value: Variant);
var
  Box: TBox;
  Item: TBoxItem;
  LocTranslator: TTranslatorSingleton;
begin
  Value := '??';
  LocTranslator := Translator.GetInstance;
  Box := FContainerList.Items[dmPrint.frxDataSetMaster.RecNo].Items[
    dmPrint.frxDataSetDetail.RecNo];
  Item := Box.Items[dmPrint.frxDataSetSubDetail.RecNo];
  if VarName = 'ItemTitle' then Value := Item.Part.GetTranslatedTitle(
    GlobalSettings.GetInstance.Language);
  if VarName = 'Unit' then Value := LocTranslator.TranslateWord(
    Item.Part.PartUnit);
  if VarName = 'LoadCount' then Value := Item.OrderCount;
  if VarName = 'Code' then Value := Item.Part.Code;
  if VarName = 'BOM' then Value := Item.Part.BOM;
  if VarName = 'RusTitle' then Value := Item.Part.RusName;
  if VarName = 'EngTitle' then Value := Item.Part.EngName;
  if VarName = 'ChineTitle' then Value := Item.Part.ChinName;
  if VarName = 'Net' then
    if Item.Part.NetUnit then Value := Item.OrderCount
      else Value := Item.Part.Weight * Item.OrderCount;
end;

// Подключение TAction/ Печать списка коробок.

procedure TPrintContainerController.PrintAllContainer(Sender: TObject);
begin
  Self.FMode := mdList;
  Self.PrintAll(Self);
end;

procedure TPrintContainerController.PrintCurrentContainer(Sender: TObject);
begin
  Self.FMode := mdList;
  Self.PrintCurrent(Self);
end;

procedure TPrintContainerController.PrintSelectContainer(Sender: TObject);
begin
  Self.FMode := mdList;
  Self.PrintSelect(Self);
end;

// Подключение TAction/ Печать ярлаков.

procedure TPrintContainerController.PrintAllBox(Sender: TObject);
begin
  Self.FMode := mdLabels;
  Self.PrintAll(Self);
end;

procedure TPrintContainerController.PrintBoxFromCurrentContainer(Sender: TObject);
begin
  Self.FMode := mdLabels;
  Self.PrintCurrent(Self);
end;

procedure TPrintContainerController.PrintBoxFromSelectContainer(Sender: TObject);
begin
  Self.FMode := mdLabels;
  Self.PrintSelect(Self);
end;

procedure TPrintContainerController.PrintSelectBoxFromSelectContainer(Sender: TObject);
begin
  Self.FMode := mdLabels;
  Self.PrintSelectBox(Self);
end;

end.
