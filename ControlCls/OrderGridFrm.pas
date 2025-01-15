unit OrderGridFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, TntGrids, OctopusGridCls, Tabs, ExtCtrls, OrderListCls,
  OrderCls, OrderItemCls, ImgList, ComCtrls, ToolWin, StdCtrls, Buttons,
  TntStdCtrls, DocumentCls, PartCls;

type
  TOnSelectItem = procedure (Part: TPart) of object;
  
  TfrmOrders = class(TFrame)
    pnTop: TPanel;
    tsOrderList: TTabSet;
    pnBotttom: TPanel;
    pnToolBar: TPanel;
    pnSearch: TPanel;
    ToolBar1: TToolBar;
    btnWrap: TToolButton;
    ImageList1: TImageList;
    btnColored: TToolButton;
    btnSort: TToolButton;
    ToolButton1: TToolButton;
    grOrder: TOctopusStringGrid;
    btnClearSearch: TSpeedButton;
    btnSearch: TSpeedButton;
    edSearch: TTntEdit;
    btnNotLoad: TToolButton;
    btnOverload: TToolButton;
    btnUnderload: TToolButton;
    btnShowAll: TToolButton;
    lbTotalLabel1: TLabel;
    lbTotalLabel2: TLabel;
    lbTotalData1: TLabel;
    lbTotalData2: TLabel;
    procedure grOrderSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FrameResize(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnColoredClick(Sender: TObject);
    procedure btnWrapClick(Sender: TObject);
    procedure tsOrderListChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
  published
    procedure RefreshGrid(Sende: TObject);
  private
    { Private declarations }
    FCurOrder: TOrder;
    FEditMode: boolean;
    FSorted: boolean;
    FDocument: TDocument;
    FOnSelectItem: TOnSelectItem;
    procedure RefreshHeader(Language: integer);
    procedure SetEditMode(EditMode: boolean);
    procedure UpdateGrid(Order: TOrder);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateData(Document: TDocument);
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnSelectItem: TOnSelectItem read FOnSelectItem write FOnSelectItem;
  end;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls;


constructor TfrmOrders.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCurOrder := nil;
  FSorted := False;
  SetEditMode(False);
  Self.btnWrap.Down := Self.grOrder.WordWrap;
  Self.btnColored.Down := Self.grOrder.Colored;
  Self.btnSort.Down := FSorted;
  grOrder.ColWidths[0] := 30;
  grOrder.ColAlign[2] := DT_RIGHT;
  grOrder.ColAlign[3] := DT_RIGHT;
end;

procedure TfrmOrders.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then Self.RefreshGrid(Self)
    else if (Key in [8, 46]) and (Length(edSearch.Text) = 0) then Self.RefreshGrid(Self);
end;

procedure TfrmOrders.FrameResize(Sender: TObject);
var
  I, ColWidth: integer;
begin
  // Поизционирование строки поиска.
  Self.pnSearch.Width := Self.pnTop.ClientWidth - Self.pnToolBar.Width;
  if Self.pnSearch.Width > 200 then Self.pnSearch.Width := 200;
  // Подбор ширины столбца Наименование.
  ColWidth := 0;
  for I := 0 to grOrder.ColCount - 1 do
    if I <> 1 then
      ColWidth := ColWidth + grOrder.ColWidths[I] + 1;
  grOrder.ColWidths[1] := grOrder.ClientWidth - ColWidth - 2;
  if grOrder.ColWidths[1] < 70 then grOrder.ColWidths[1] := 70;
  grOrder.Repaint;
end;

procedure TfrmOrders.grOrderSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if Assigned(Self.FOnSelectItem) and (grOrder.Objects[1, ARow] <> nil) then
    Self.FOnSelectItem(TOrderItem(grOrder.Objects[1, ARow]).Part);
end;

procedure TfrmOrders.btnClearSearchClick(Sender: TObject);
begin
  edSearch.Text := '';
  Self.RefreshGrid(Self);
end;

procedure TfrmOrders.btnColoredClick(Sender: TObject);
begin
  grOrder.Colored := Self.btnColored.Down;
  grOrder.Repaint;
end;

procedure TfrmOrders.btnSortClick(Sender: TObject);
begin
  Self.FSorted := Self.btnSort.Down;
  Self.RefreshGrid(Self);
end;

procedure TfrmOrders.btnWrapClick(Sender: TObject);
begin
  grOrder.WordWrap := Self.btnWrap.Down;
  grOrder.Repaint;
end;

procedure TfrmOrders.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  if FEditMode then begin
    grOrder.ColCount := 5;
    grOrder.ColAlign[4] := DT_RIGHT;
  end else grOrder.ColCount := 4;
  Self.RefreshGrid(Self);
end;

procedure TfrmOrders.UpdateData(Document: TDocument);
var
  I: integer;
begin
  FDocument := Document;
  Self.tsOrderList.Tabs.Clear;
  Self.Visible := (FDocument.Orders.Count > 0);
  if FDocument.Orders.Count = 0 then begin
    Self.grOrder.Clear;
    Exit;
  end;
  for I := 0 to FDocument.Orders.Count - 1 do
    Self.tsOrderList.Tabs.AddObject(FDocument.Orders.Items[I].Title,
      FDocument.Orders.Items[I]);
  Self.tsOrderList.TabIndex := 0;
end;

procedure TfrmOrders.tsOrderListChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if NewTab >= 0 then begin
    FCurOrder := TOrder(Self.tsOrderList.Tabs.Objects[NewTab]);
    Self.UpdateGrid(FCurOrder);
  end;
end;

procedure TfrmOrders.UpdateGrid(Order: TOrder);
begin
  Self.FCurOrder := Order;
  Self.RefreshGrid(Self);
end;

procedure TfrmOrders.RefreshHeader(Language: integer);
begin
  if not FEditMode then begin
    grOrder.Cells[0, 0] := '№';
  end else begin
    grOrder.Cells[0, 0] := '';
    grOrder.Cells[4, 0] := Translator.GetInstance.TranslateWord(
      'В коробке', Language);
  end;
  grOrder.Cells[1, 0] := Translator.GetInstance.TranslateWord(
    'Наименование', Language);
  grOrder.Cells[2, 0] := Translator.GetInstance.TranslateWord(
    'Заквз', Language);
  grOrder.Cells[3, 0] := Translator.GetInstance.TranslateWord(
    'Загруж', Language);
end;

procedure TfrmOrders.RefreshGrid(Sende: TObject);
var
  Language: integer;
  I, ARow: integer;
  Item: TOrderItem;
  AddRow: boolean;
  Finder: TFindInShipment;
  LoadCount: real;
begin
  Self.grOrder.Clear;
  Language := GlobalSettings.GetInstance.Language;
  Self.RefreshHeader(Language);
  grOrder.Enabled := (FCurOrder <> nil) and (grOrder.RowCount > 0);
  if ((FCurOrder = nil) or (FCurOrder.Count = 0)) then begin
    grOrder.RowCount := 2;
    Exit;
  end;
  Finder := TFindInShipment.Create(FDocument.Containers);
  grOrder.RowCount := FCurOrder.Count + 1;
  ARow := 1;
  for I := 0 to FCurOrder.Count - 1 do begin
    Item := TOrderItem(FCurOrder.Items[I]);
    LOadCount := Finder.CountForOrder(FcurOrder, Item.Part);
    AddRow := True;
    // Отбор по полю поиска.
    if Length(edSearch.Text) > 0 then
      AddRow := (pos(WideUpperCase(edSearch.Text),
        WideUpperCase(Item.Part.GetTranslatedTitle(Language))) > 0);
    // Отбор по загруженному количеству.
    if not Self.btnShowAll.Down then begin
      AddRow := False;
      if (Self.btnNotLoad.Down) and (LoadCount = 0) then
        AddRow := True
      else if (Self.btnOverload.Down) and (LoadCount > Item.OrderCount) then
        AddRow := True
      else if (Self.btnUnderload.Down) and (LoadCount < Item.OrderCount) then
        AddRow := True;
    end;
    // Вывод строки.
    if AddRow then begin
      grOrder.Cells[1, ARow] := Item.Part.GetTranslatedTitle(Language);
      grOrder.Cells[2, ARow] := FloatToStr(Item.OrderCount);
      grOrder.Cells[3, ARow] := FloatToStr(LoadCount);
      if Self.FEditMode then
        grOrder.Cells[4, ARow] := FloatToStr(Item.Part.CountInBox);
      if LoadCount = 0 then
        grOrder.SetRowColor(ARow, rgb(240, 128, 128))
      else if LoadCount < Item.OrderCount then
        grOrder.SetRowColor(ARow, rgb(240, 230, 140))
      else if LoadCount > Item.OrderCount then
        grOrder.SetRowColor(ARow, rgb(144, 238, 144))
      else
        grOrder.SetRowColor(ARow, clWhite);
      Self.grOrder.Objects[1, ARow] := Item;
      inc(ARow);
    end;
  end;
  grOrder.Enabled := (ARow > 1);
  Self.lbTotalData1.Caption := IntToStr(FCurOrder.Count);
  if ARow > 1 then begin
    grOrder.RowCount := ARow;
    Self.lbTotalData2.Caption := IntToStr(ARow - 1);
  end else begin
    grOrder.RowCount := 2;
    Self.lbTotalData2.Caption := '0';
  end;
  if Self.FSorted then grOrder.Sort(1);
  if ARow > 1 then begin
    for I := 1 to grOrder.RowCount - 1 do
      grOrder.Cells[0, I] := IntToStr(I);
    //grOrder.TopRow := TopRow;
    // if Assigned(Self.FOnSelectItem) then
     // FonSelectItem(TOrderItem(grOrder.Objects[1, 1]).Part);
  end;
  Finder.Free;
  grOrder.Repaint;
  grOrder.Selection := TGridRect(Rect(-1, -1, -1, -1));
end;

end.
