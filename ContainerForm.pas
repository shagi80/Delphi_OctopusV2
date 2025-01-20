unit ContainerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Grids, TntGrids, OctopusGridCls, Tabs, StdCtrls,
  TntStdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, PartCls, DocumentCls,
  BoxCls, BoxItemCls, ContainerCls, Menus, DragObjectCls, AppEvnts;

type
  TOnSelectBox = procedure (Box: TBox) of object;
  TOnSelectItem = procedure (Part: TPart) of object;
  TOnDoubleClick  = procedure (Column: integer) of object;
  TOnDragDrop = procedure (Sender: TObject; DragObject: TOrderDragObject;
      RecepientBox: TBox; Separate: boolean = False) of object;

  TfrmContainers = class(TForm)
    pnBotttom: TPanel;
    tsContainerList: TTabSet;
    ImageList1: TImageList;
    pnTop: TPanel;
    pnViewTools: TPanel;
    pnToolBar: TPanel;
    ToolBar1: TToolBar;
    btnWrap: TToolButton;
    btnColored: TToolButton;
    btnOnlyMark: TToolButton;
    btnSearchPart: TToolButton;
    ToolButton1: TToolButton;
    btnCheckListMode: TToolButton;
    ToolButton3: TToolButton;
    btnCheckAll: TToolButton;
    btnUncheckAll: TToolButton;
    btnInvertCheck: TToolButton;
    pnSearch: TPanel;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    edSearch: TTntEdit;
    pnEditTools: TPanel;
    tbEdit: TToolBar;
    Label3: TLabel;
    ToolButton4: TToolButton;
    btnContainerAdd: TToolButton;
    btnContainerEdit: TToolButton;
    btnContainerDelete: TToolButton;
    pmAddItem: TPopupMenu;
    miOnlySet: TMenuItem;
    miSelAndMark: TMenuItem;
    pnTotal: TPanel;
    lbTotalLabel1: TLabel;
    lbTotalLabel3: TLabel;
    lbTotalData3: TLabel;
    lbTotalData1: TLabel;
    lbTotalLabel2: TLabel;
    lbTotalLabel4: TLabel;
    lbTotalData4: TLabel;
    lbTotalData2: TLabel;
    pnWarning: TPanel;
    btnRetryWarning: TSpeedButton;
    Label2: TLabel;
    ToolButton2: TToolButton;
    btnAddBoxAndLoad: TToolButton;
    btnLoadPart: TToolButton;
    btnLoadPartAuto: TToolButton;
    btnUnloadPart: TToolButton;
    btnDeleteBox: TToolButton;
    btnEditBox: TToolButton;
    pnGrid: TPanel;
    grContainer: TOctopusStringGrid;
    pnGridAddPanel: TPanel;
    ToolButton5: TToolButton;
    lbAddHint: TLabel;
    pnEachSeparately: TPanel;
    pnAllInOne: TPanel;
    imgAllInOne: TImage;
    imgEachSeparately: TImage;
    pmMain: TPopupMenu;
    miAddInBoxSelected: TMenuItem;
    miAddInBoxMark: TMenuItem;
    mi1: TMenuItem;
    miDelataItem: TMenuItem;
    miDeleteBox: TMenuItem;
    miEdit: TMenuItem;
    ToolButton6: TToolButton;
    btnChangeGross: TToolButton;
    procedure pnWarningClick(Sender: TObject);
    procedure grContainerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnEachSeparatelyClick(Sender: TObject);
    procedure pnAllInOneClick(Sender: TObject);
    procedure grContainerDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure grContainerDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure grContainerDblClick(Sender: TObject);
    procedure btnInvertCheckClick(Sender: TObject);
    procedure btnUncheckAllClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnCheckListModeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grContainerSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnClearSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tsContainerListChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
  private
    FCurContainer: TContainer;
    FEditContainer: boolean;
    FEditBoxes: boolean;
    FDocument: TDocument;
    FOnSelectBox: TOnSelectBox;
    FOnSelectItem: TOnSelectItem;
    FOnDoubleClick: TOnDoubleClick;
    //FCanDropPart: boolean;
    FOnDragDrop: TOnDragDrop;
    procedure SetEditContainer(EditMode: boolean);
    procedure SetEditBoxes(EditMode: boolean);
    procedure SetDocument(Document: TDocument);
    procedure RefreshGridHeader(Language: integer);
    procedure SetCheckButtonsEnabled(Value: Boolean);
    function GetRowMark(Box: TBox): TEditableCellSet;
    function GetSelectObject(ACol: integer): TObject;
    function GetSelectBox: TBox;
    function GetSelectBoxItem: TBoxItem;
    procedure ClearAddHint;
  public
    { Public declarations }
    property Document: TDocument read FDocument write SetDocument;
    property EditContainer: boolean read FEditContainer write SetEditContainer;
    property EditBoxes: boolean read FEditBoxes write SetEditBoxes;
    //property CanDropPart: boolean read FCanDropPart write FCanDropPart;
    property CurrentContainer: TContainer read FCurContainer;
    property SelectBox: TBox read GetSelectBox;
    property SelectBoxItem: TBoxItem read GetSelectBoxItem;
    property OnSelectBox: TOnSelectBox read FOnSelectBox write FOnSelectBox;
    property OnSelectItem: TOnSelectItem read FOnSelectItem write FOnSelectItem;
    property OnDoubleClick: TOnDoubleClick read FOnDoubleClick write FOnDoubleClick;
    property OnDragDrop: TOnDragDrop read FOnDragDrop write FOnDragDrop;
    procedure SetRowMark(Box: TBox; ARow: integer);
    function ShowContainer(Container: TContainer): boolean;
    function ShowBox(Box: TBox): boolean;
    function CursorInClient(X, Y: integer; Control: TControl): boolean;
  published
    procedure CheckContainer(Sender: TObject);
    procedure RefreshTabs(Sender: TObject);
    procedure RefreshGrid(Sender: TObject);
    procedure RefreshSumPanel(Sender: TObject);
    procedure ViewButtonsClick(Sender: TObject);
  end;

var
  frmContainers: TfrmContainers;

implementation

{$R *.dfm}
uses
  Math, TranslatorCls, GlobalSettingsCls, BoxForm, WaitingForm, LoggerCls;

// Сеттеры.

procedure TfrmContainers.SetEditContainer(EditMode: boolean);
begin
  FEditContainer := EditMode;
  Self.pnEditTools.Visible := FEditContainer;
  Self.pnEditTools.Top := 0;
end;

procedure TfrmContainers.SetEditBoxes(EditMode: boolean);
begin
  FEditBoxes := EditMode;
  if FEditBoxes then grContainer.EditableCells := [5, 6, 8, 9]
    else grContainer.EditableCells := [];
  pnGridAddPanel.Visible := (FEditBoxes) and (Self.FCurContainer <> nil);
  RefreshGrid(Self);
end;

procedure TfrmContainers.SetDocument(Document: TDocument);
begin
  FDocument := Document;
  pnBotttom.Visible := (FDocument.Containers.Count > 0);
  if FDocument.Containers.Count = 0 then begin
    edSearch.Text := '';
    FCurContainer := nil;
    RefreshGrid(Self);
    tsContainerList.Tabs.Clear;
    Exit;
  end;
  RefreshTabs(Self);
end;

function TfrmContainers.GetSelectObject(ACol: integer): TObject;
var
  ARow: integer;
begin
  Result := nil;
  if Self.FCurContainer = nil then Exit;
  ARow := Self.grContainer.Selection.Top;
  if not ((ARow > 0) and (ARow < grContainer.RowCount)) then Exit;
  Result := grContainer.Objects[ACol, ARow];
end;

function TfrmContainers.GetSelectBox: TBox;
begin
  Result := TBox(Self.GetSelectObject(1));
end;

function TfrmContainers.GetSelectBoxItem: TBoxItem;
begin
  Result := TBoxItem(Self.GetSelectObject(2));
end;

// События Tabs.

procedure TfrmContainers.tsContainerListChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if NewTab >= 0 then begin
    FCurContainer := TContainer(Self.tsContainerList.Tabs.Objects[NewTab]);
    RefreshGrid(Self);
  end;
end;

// События формы.

procedure TfrmContainers.FormCreate(Sender: TObject);
var
  I: integer;
begin
  FDocument := nil;
  FCurContainer := nil;
  Self.EditContainer := False;
  Self.pnEditTools.Visible := False;
  Self.FEditBoxes := False;
  grContainer.EditableCells := [];
  Self.grContainer.Colored := True;
  Self.btnWrap.Down := Self.grContainer.WordWrap;
  Self.btnColored.Down := Self.grContainer.Colored;
  Self.btnCheckListMode.Down := Self.grContainer.CheckListStyle;
  SetCheckButtonsEnabled(grContainer.CheckListStyle);
  grContainer.ColWidths[0] := 30;
  grContainer.ColAlign[4] := DT_CENTER;
  grContainer.ColWidths[4] := 30;
  for I := 5 to grContainer.ColCount - 1 do grContainer.ColAlign[I] := DT_RIGHT;
  pnWarning.Visible := False;
  pnGridAddPanel.Visible := False;
end;

procedure TfrmContainers.FormResize(Sender: TObject);
var
  I, ColWidth: integer;
begin
  // Поизционирование строки поиска.
  Self.pnSearch.Width := Self.pnViewTools.ClientWidth - Self.pnToolBar.Width;
  if Self.pnSearch.Width > 200 then Self.pnSearch.Width := 200;
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grContainer.ColCount - 1 do
    if I <> 3 then
      ColWidth := ColWidth + grContainer.ColWidths[I] + 1;
  grContainer.ColWidths[3] := grContainer.ClientWidth - ColWidth - 2;
  if grContainer.ColWidths[3] < 70 then grContainer.ColWidths[3] := 70;
  grContainer.Repaint;
  // Выравнивание полей для добавлкения перетаскиванием
  pnAllInOne.Width := trunc(pnGridAddPanel.ClientWidth / 2);
  imgAllInOne.Left := trunc((pnAllInOne.ClientWidth - imgEachSeparately.Width) / 2);
  imgEachSeparately.Left := trunc((self.pnEachSeparately.ClientWidth - imgEachSeparately.Width ) / 2);
end;

procedure TfrmContainers.FormShow(Sender: TObject);
begin
  RefreshTabs(Self);
  RefreshGrid(Self);
end;

// События таблицы и настройки вида таблицы.

procedure TfrmContainers.grContainerDblClick(Sender: TObject);
begin
  if Assigned(FOnDoubleClick) and (grContainer.Selection.Left > 0)
    then FOnDoubleClick(grContainer.Selection.Left);
end;

procedure TfrmContainers.grContainerDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  DragObject: TOrderDragObject;
  Col, Row: integer;
  Box: TBox;
  Separate: boolean;
begin
  if (FEditBoxes) and (Source is TOrderDragObject) then begin
    DragObject := TOrderDragObject(Source);
    Box := nil;
    Separate := (Sender = Self.pnEachSeparately);
    if not (Sender is TPanel) then begin
      grContainer.MouseToCell(X, Y, Col, Row);
      if Row > 0 then Box := TBox(grContainer.Objects[1, Row]) else Exit;
    end;
    if Assigned(FOnDragDrop) then FOnDragDrop(Self, DragObject, Box, Separate);
  end;
end;

procedure TfrmContainers.grContainerDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  ACol, ARow: integer;
begin
  Accept := (FEditBoxes) and (FEditBoxes) and (Source is TOrderDragObject);
  if Accept then begin
    grContainer.MouseToCell(X, Y, ACol, ARow);
    if (ARow > 0) then grContainer.Selection := TGridRect(Rect(1, ARow, 1, ARow));
  end;
end;

procedure TfrmContainers.grContainerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: integer;
begin
  Self.grContainer.MouseToCell(X, Y, ACol, ARow);
  if (ACol > 0) and (ARow > 0) then grContainer.SelectCell(ACol, ARow);
  Self.pmMain.AutoPopup := ((ACol > 0) and (ARow > 0));
end;

procedure TfrmContainers.grContainerSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  grContainer.Selection := TGridRect(Rect(ACol, ARow, ACol, ARow));
  if Assigned(Self.FOnSelectItem) and (grContainer.Objects[2, ARow] <> nil) then
    Self.FOnSelectItem(TBoxItem(grContainer.Objects[2, ARow]).Part);
  if Assigned(Self.FOnSelectBox) and (grContainer.Objects[1, ARow] <> nil) then
    Self.FOnSelectBox(TBox(grContainer.Objects[1, ARow]));
end;

procedure TfrmContainers.ViewButtonsClick(Sender: TObject);
begin
  grContainer.Colored := Self.btnColored.Down;
  grContainer.WordWrap := btnWrap.Down;
  grContainer.Repaint;
end;

procedure TfrmContainers.btnClearSearchClick(Sender: TObject);
begin
  if Length(edSearch.Text) >0 then begin
    edSearch.Text := '';
    RefreshGrid(Self);
  end;
end;

procedure TfrmContainers.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then RefreshGrid(Self)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then RefreshGrid(Self);
end;

// Событич панели приема перетаскивания и создания коробок

procedure TfrmContainers.ClearAddHint;
begin
  Self.lbAddHint.Font.Color := clGray;
  Self.lbAddHint.Caption := Translator.GetInstance.TranslateMessage(
    96, 'Перетащите сюда выбранные элементы заказа');
end;

function TfrmContainers.CursorInClient(X, Y: integer; Control: TControl): boolean;
var
  HintCaption: string;
begin
  Result := ((Control = pnAllInOne) or (Control = pnEachSeparately));
  if not FEditBoxes then Exit;
  if Result then begin
    (Control as TPanel).Color := rgb(220, 250, 250);
    if Screen.Cursor = crDefault then Screen.Cursor := crHandPoint;
    if Control = Self.pnAllInOne then
      HintCaption := Translator.GetInstance.TranslateMessage(
        97, 'Все выбранные детали в одну группу коробок');
    if Control = Self.pnEachSeparately then
      HintCaption := Translator.GetInstance.TranslateMessage(
        98, 'Новая группа для каждой выбранной детали');
    Self.lbAddHint.Caption := HintCaption;
    Self.lbAddHint.Font.Color := clRed;
  end else begin
    Self.ClearAddHint;
    pnAllInOne.Color := clWhite;
    pnEachSeparately.Color := clWhite;
    if Screen.Cursor = crHandPoint then Screen.Cursor := crDefault;
  end;
end;

procedure TfrmContainers.pnAllInOneClick(Sender: TObject);
begin
  Self.btnAddBoxAndLoad.Action.OnExecute(Self);
end;

procedure TfrmContainers.pnEachSeparatelyClick(Sender: TObject);
begin
  Self.btnLoadPartAuto.Action.OnExecute(Self);
end;

procedure TfrmContainers.pnWarningClick(Sender: TObject);
begin

end;

// Процедуры работы с маркерами.

procedure TfrmContainers.btnCheckAllClick(Sender: TObject);
begin
  grContainer.SelectAll;
  grContainer.Repaint;
end;

procedure TfrmContainers.btnUncheckAllClick(Sender: TObject);
begin
   grContainer.UnselectAll;
   grContainer.Repaint;
end;

procedure TfrmContainers.btnInvertCheckClick(Sender: TObject);
begin
   grContainer.ChangeSelection;
   grContainer.Repaint;
end;

procedure TfrmContainers.btnCheckListModeClick(Sender: TObject);
begin
  grContainer.CheckListStyle := btnCheckListMode.Down;
  if Self.btnCheckListMode.Down then grContainer.UnselectAll;
  SetCheckButtonsEnabled(grContainer.CheckListStyle);
  grContainer.Repaint;
end;

procedure TfrmContainers.SetCheckButtonsEnabled(Value: Boolean);
begin
  btnCheckAll.Enabled := Value;
  btnUncheckAll.Enabled := Value;
  btnInvertCheck.Enabled := Value;
end;

// Процедуры обновления.

procedure TfrmContainers.CheckContainer(Sender: TObject);
var
  Ind: integer;
begin
  pnWarning.Visible := False;
  if ((FCurContainer = nil) or (FCurContainer.Count = 0)) then Exit;
  for Ind := 1 to FCurContainer.Count - 1 do
    if (GetRowMark(FCurContainer.Items[Ind]) <> []) then begin
      pnWarning.Visible := True;
      Exit;
    end;
end;

function TfrmContainers.GetRowMark(Box: TBox): TEditableCellSet;
begin
  Result := [];
  if Box.GroupGrossWeight < Box.GroupNetWeight then
    Result := Result + [9];
  if GlobalSettings.GetInstance.MarkedZerousPack then begin
    if Box.PackageWeight <= 0 then Result := Result + [10];
  end else begin
    if Box.PackageWeight < 0 then Result := Result + [10];
  end;
end;

procedure TfrmContainers.SetRowMark(Box: TBox; ARow: integer);
begin
  Self.grContainer.SetCellMark(ARow, Self.GetRowMark(Box));
end;

procedure TfrmContainers.RefreshTabs(Sender: TObject);
var
  I: integer;
begin
  if not Self.Visible then Exit;
  tsContainerList.Tabs.Clear;
  Self.FCurContainer := nil;
  if (FDocument = nil) or (FDocument.Containers.Count = 0) then begin
    Self.RefreshGrid(Self);
    Exit;
  end;
  for I := 0 to FDocument.Containers.Count - 1 do
    Self.tsContainerList.Tabs.AddObject(FDocument.Containers.Items[I].Title,
      FDocument.Containers.Items[I]);
  tsContainerList.TabIndex := 0;
end;

procedure TfrmContainers.RefreshGridHeader(Language: integer);
begin
  grContainer.Cells[0,0] := '№';
  grContainer.Cells[1,0] :=
    Translator.GetInstance.TranslateWord('Гр.№');
  grContainer.Cells[2,0] :=
    Translator.GetInstance.TranslateWord('Заказ');
  grContainer.Cells[3,0] :=
    Translator.GetInstance.TranslateWord('Наименование');
  grContainer.Cells[4,0] :=
    Translator.GetInstance.TranslateWord('Ед.');
  grContainer.Cells[5,0] :=
    Translator.GetInstance.TranslateWord('Кол-во');
  grContainer.Cells[6,0] :=
    Translator.GetInstance.TranslateWord('Кол.мест');
  grContainer.Cells[7,0] :=
    Translator.GetInstance.TranslateWord('Нетто,кг');
  grContainer.Cells[8,0] :=
    Translator.GetInstance.TranslateWord('Брутто,кг');
  grContainer.Cells[9,0] :=
    Translator.GetInstance.TranslateWord('Уп-ка,кг');
  grContainer.Cells[10,0] :=
    Translator.GetInstance.TranslateWord('Объем,м3');
end;

procedure TfrmContainers.RefreshGrid(Sender: TObject);
var
  Language: integer;
  I, J, ARowForBox, ARow, BoxNumber, TopRow: integer;
  Box: TBox;
  Item: TBoxItem;
  AddRow: boolean;
  IsFirstRow: boolean;
  Marks: TEditableCellSet;
begin
  if not Self.Visible then Exit;
  Self.ClearAddHint;
  pnWarning.Visible := False;
  TopRow := grContainer.TopRow;
  Self.grContainer.Clear;
  Language := GlobalSettings.GetInstance.Language;
  Self.RefreshGridHeader(Language);
  pnGridAddPanel.Visible := (FCurContainer <> nil) and (Self.FEditBoxes);
  if ((FCurContainer = nil) or (FCurContainer.Count = 0)) then begin
    grContainer.Enabled := False;
    grContainer.RowCount := 2;
    Self.RefreshSumPanel(Self);
    Self.FormResize(Self);
    Exit;
  end;

  Perform(WM_SETREDRAW, 0, 0);

  ARow := 1;
  BoxNumber := 0;
  ARowForBox := 0;
  for I := 0 to FCurContainer.Count - 1 do begin
    Box := TBox(FCurContainer.Items[I]);
    IsFirstRow := True;
    frmWaiting.NextStep(Self);
    for J := 0 to Box.Count - 1 do begin
      Item := TBoxItem(Box.Items[J]);
      AddRow := True;
      // Отбор по полю поиска.
      if Length(edSearch.Text) > 0 then
        AddRow := (pos(WideUpperCase(edSearch.Text),
          WideUpperCase(Item.Part.GetTranslatedTitle(Language))) > 0);
      if not AddRow then Continue;
      // Отбор только маркированных.
      Marks := GetRowMark(Box);
      if btnOnlyMark.Down then AddRow := (Marks <> []);
      if not AddRow then Continue;
      // Вывод строки.
      if IsFirstRow then begin
          IsFirstRow := False;
          ARowForBox := ARow;
          Inc(BoxNumber);
          grContainer.Cells[0, ARow] := IntToStr(BoxNumber);
          grContainer.Cells[1, ARow] := Box.BoxCode;
          grContainer.Cells[6, ARow] := IntToStr(Box.BoxCount);
          grContainer.Cells[7, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            Box.GroupNetWeight);
          grContainer.Cells[8, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            Box.GroupGrossWeight);
          grContainer.Cells[9, ARow] := FormatFloat(
            GlobalSettings.GetInstance.WeightAccuracyMask,
            Box.PackageWeight);
          grContainer.Cells[10, ARow] := FormatFloat(
            GlobalSettings.GetInstance.VolumeAccuracyMask,
            Box.Volume);
          // Установка маркировки ошибок в параметрах коробки.
          if Marks <> [] then grContainer.SetCellMark(ARow, Marks);
      end;
      grContainer.Cells[2, ARow] := Item.Order.Title;
      grContainer.Cells[3, ARow] := Item.Part.GetTranslatedTitle(
        GlobalSettings.GetInstance.Language);
      grContainer.Cells[4, ARow] := Translator.GetInstance.TranslateWord(
        Item.Part.PartUnit);
      grContainer.Cells[5, ARow] := FloatToStr(Item.OrderCount);
      // Установка цыета строки
      if BoxNumber mod 2 = 0 then grContainer.SetRowColor(ARow, rgb(240, 240, 230));
      // Запись обьектов
      grContainer.Objects[1, ARow] := Box;
      grContainer.Objects[2, ARow] := Item;
      grContainer.Objects[3, ARow] := TObject(ARowForBox);
      // Увеличиваем счетчик строк.
      inc(ARow);
    end;
  end;
  grContainer.Enabled := (ARow > 1);
  if ARow > 1 then grContainer.RowCount := ARow;
  Self.RefreshSumPanel(Self);
  Self.FormResize(Self);
  grContainer.SelectCell(MaxInt, MaxInt);
  if (TopRow < (grContainer.RowCount - 1))
    and (grContainer.RowCount > grContainer.VisibleRowCount) then
      grContainer.TopRow := TopRow;
  if not pnWarning.Visible then CheckContainer(Self);
  Perform(WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
end;

procedure TfrmContainers.RefreshSumPanel(Sender: TObject);
begin
  Self.pnBotttom.Visible := (FCurContainer <> nil);
  if FCurContainer = nil then Exit;
  Self.lbTotalData1.Caption := IntToStr(FCurContainer.TotalBoxCount);
  Self.lbTotalData2.Caption := FloatToStrF(FCurContainer.RealNetWeight,
    ffNumber, 10, GlobalSettings.GetInstance.WeightAccuracy);
  Self.lbTotalData3.Caption := FloatToStrF(FCurContainer.RealGrossWeight,
    ffNumber, 10, GlobalSettings.GetInstance.WeightAccuracy);
  if FCurContainer.RealGrossWeight > FCurContainer.MaxWeight then
      Self.lbTotalData3.Font.Color := clRed
    else Self.lbTotalData3.Font.Color := clBlack;
  Self.lbTotalData4.Caption := FloatToStrF(FCurContainer.RealVolume,
    ffNumber, 10, GlobalSettings.GetInstance.VolumeAccuracy);
  if FCurContainer.RealVolume > FCurContainer.MaxVolume then
      Self.lbTotalData4.Font.Color := clRed
    else Self.lbTotalData4.Font.Color := clBlack;
end;

// Поиск и отображение

function TfrmContainers.ShowContainer(Container: TContainer): boolean;
var
  TabInd: integer;
begin
  Result := False;
  for TabInd := 0 to Self.tsContainerList.Tabs.Count - 1 do begin
    if TContainer(tsContainerList.Tabs.Objects[TabInd]) = Container then begin
      tsContainerList.TabIndex := TabInd;
      FCurContainer := Container;
      RefreshGrid(Self);
      Result:= True;
      Exit;
    end;
  end;
end;

function TfrmContainers.ShowBox(Box: TBox): boolean;
var
  Container: TContainer;
  ARow, TabInd, BoxInd: integer;
begin
  Result := False;
  Self.edSearch.Text := '';
  Self.btnOnlyMark.Down := False;
  grContainer.Options := grContainer.Options - [goEditing];
  for TabInd := 0 to Self.tsContainerList.Tabs.Count - 1 do begin
    Container := TContainer(tsContainerList.Tabs.Objects[TabInd]);
    for BoxInd := 0 to Container.Count - 1 do
      if Container.Items[BoxInd] = Box then begin
        if tsContainerList.TabIndex <> TabInd then tsContainerList.TabIndex := TabInd;
        grContainer.ScrollToObject(1, Box);
        ARow := grContainer.Row;
        if Arow > 0 then begin
          if Assigned(Self.FOnSelectItem) and (grContainer.Objects[2, ARow] <> nil) then
            Self.FOnSelectItem(TBoxItem(grContainer.Objects[2, ARow]).Part);
          if Assigned(Self.FOnSelectBox) and (grContainer.Objects[1, ARow] <> nil) then
            Self.FOnSelectBox(TBox(grContainer.Objects[1, ARow]));
        end;
        Result := True;
        Exit;
      end;
  end;
end;

end.
