unit SearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OrderCls, PartCls, FindInShipmentCls, Grids, TntGrids, BoxItemCls,
  OctopusGridCls, ExtCtrls, StdCtrls, Buttons, DocumentCls, TntStdCtrls;

type
  TfrmSearch = class(TForm)
    pnButtons: TPanel;
    pnMain: TPanel;
    pnOrders: TPanel;
    Label1: TLabel;
    grOrders: TOctopusStringGrid;
    pnContainers: TPanel;
    Label2: TLabel;
    grContainers: TOctopusStringGrid;
    Label3: TLabel;
    Splitter1: TSplitter;
    pnTop: TPanel;
    lbCaption2: TLabel;
    pnFilter: TPanel;
    edSearch: TTntEdit;
    btnSearch: TSpeedButton;
    btnClearSearch: TSpeedButton;
    cbLanguage: TComboBox;
    procedure edSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
    procedure OrdersDblClick(Sender: TObject);
    procedure grContainersDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    FDocument: TDocument;
    procedure RefreshContainerGrid(SearchResult: TSearchResult);
    procedure RefreshOrderGrid(SearchResult: TSearchResult);
    procedure ResultEmpty;
    procedure SetDesableSearch(Text: string);
    procedure SetEnabledSearch(Text: string);
  public
    { Public declarations }
    property Document: TDocument read FDocument write FDocument;
    procedure SearchOrderItem(Order: TOrder; Part: TPart);
    procedure SearchBoxItem(Item: TBoxItem);
    procedure SearchPart(Part: TPart);
    procedure SearchTitle(Title: widestring; PrepareForm: boolean = True);
  end;

var
  frmSearch: TfrmSearch;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, ContainerForm, BoxCls, OrderItemCls,
  OrdersForm;

procedure TfrmSearch.btnClearSearchClick(Sender: TObject);
begin
  edSearch.Text := '';
end;

procedure TfrmSearch.btnSearchClick(Sender: TObject);
begin
  if Length(edSearch.Text) > 0 then begin
    Self.SearchTitle(edSearch.Text, False);
    Self.FocusControl(Self.edSearch);
  end;
end;

procedure TfrmSearch.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then Self.btnSearchClick(Self);
end;


procedure TfrmSearch.FormCreate(Sender: TObject);
begin
  grContainers.ColAlign[4] := DT_RIGHT;
  grOrders.ColAlign[3] := DT_RIGHT;
  grContainers.Colored := True;
  grOrders.Colored := True;
  FDocument := nil;
end;

procedure TfrmSearch.FormResize(Sender: TObject);
begin
  if pnContainers.Visible then begin
    grContainers.ColWidths[1] := 100;
    grContainers.ColWidths[2] := 70;
    grContainers.ColWidths[4] := 70;
    grContainers.ColWidths[3] := grContainers.ClientWidth
      - grContainers.ColWidths[0] - grContainers.ColWidths[2]
      - grContainers.ColWidths[1] - grContainers.ColWidths[4] - 5;
  end;
  if pnOrders.Visible then begin
    grOrders.ColWidths[1] := 100;
    grOrders.ColWidths[3] := 70;
    grOrders.ColWidths[2] := grOrders.ClientWidth
      - grOrders.ColWidths[0] - grOrders.ColWidths[3]
      - grOrders.ColWidths[1] - 3;
  end;
end;

procedure TfrmSearch.grContainersDblClick(Sender: TObject);
var
  Box : TBox;
begin
  Box := nil;
  if (grContainers.Row > 0) then
    Box := TBox(grContainers.Objects[1, grContainers.Row]);
  if Box = nil then Exit;
  frmContainers.ShowBox(Box);
end;

procedure TfrmSearch.OrdersDblClick(Sender: TObject);
var
  OrderItem: TOrderItem;
begin
  OrderItem := nil;
  if (grOrders.Row > 0) then
    OrderItem := TOrderItem(grOrders.Objects[1, grOrders.Row]);
  if OrderItem = nil then Exit;
  frmOrders.ShowOrderItem(OrderItem);
end;

procedure TfrmSearch.SetDesableSearch(Text: string);
begin
  edSearch.Text := Text;
  edSearch.ReadOnly := True;
  edSearch.Color := clBtnFace;
  cbLanguage.Visible := False;
  Self.btnSearch.Enabled := False;
  Self.btnClearSearch.Enabled := False;
end;

procedure TfrmSearch.SetEnabledSearch(Text: string);
begin
  edSearch.Text := Text;
  edSearch.ReadOnly := False;
  edSearch.Color := clWhite;
  cbLanguage.Visible := True;
  cbLanguage.Left := 0;
  cbLanguage.Items.Clear;
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Рус назв'));
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Англ назв'));
  cbLanguage.Items.Add(Translator.GetInstance.TranslateWord('Кит назв'));
  cbLanguage.ItemIndex := GlobalSettings.GetInstance.Language;
  Self.btnSearch.Enabled := True;
  Self.btnClearSearch.Enabled := True;
end;


procedure TfrmSearch.RefreshOrderGrid(SearchResult: TSearchResult);
var
  SearchResultItem: FindInShipmentCls.TSearchResultItem;
  I: integer;
begin
  grOrders.Clear;
  grOrders.Cells[0, 0] := '№';
  grOrders.Cells[1, 0] := Translator.GetInstance.TranslateWord('Заказ');
  grOrders.Cells[2, 0] := Translator.GetInstance.TranslateWord('Наименование');
  grOrders.Cells[3, 0] := Translator.GetInstance.TranslateWord('Кол-во');
  grOrders.Enabled := (SearchResult.Count > 0);
  grOrders.Selection := TGridRect(Rect(-1, -1, -1, -1));
  if SearchResult.Count = 0 then begin
    grOrders.RowCount := 2;
    Self.FormResize(Self);
    Exit;
  end;

  grOrders.RowCount := SearchResult.Count + 1;
  for I := 0 to SearchResult.Count - 1 do begin
    SearchResultItem := SearchResult.Items[I];
    grOrders.Cells[0, I + 1] := IntToStr(I + 1);
    grOrders.Cells[1, I + 1] := SearchResultItem.Order.Title;
    grOrders.Cells[2, I + 1] := SearchResultItem.OrderItem.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language);
    grOrders.Cells[3, I + 1] := FloatToStr(SearchResultItem.Count);
    grOrders.Objects[1, I + 1] := SearchResultItem.OrderItem;
    if I mod 2 = 0 then grOrders.SetRowColor(I + 1, rgb(240, 240, 230));
  end;
  Self.FormResize(Self);
end;

procedure TfrmSearch.RefreshContainerGrid(SearchResult: TSearchResult);
var
  SearchResultItem: FindInShipmentCls.TSearchResultItem;
  I: integer;
begin
  grContainers.Clear;
  grContainers.Cells[0, 0] := '№';
  grContainers.Cells[1, 0] := Translator.GetInstance.TranslateWord('Контейнер');
  grContainers.Cells[2, 0] := Translator.GetInstance.TranslateWord('Гр.№');
  grContainers.Cells[3, 0] := Translator.GetInstance.TranslateWord('Наименование');
  grContainers.Cells[4, 0] := Translator.GetInstance.TranslateWord('Кол-во');
  grContainers.Enabled := (SearchResult.Count > 0);
  grContainers.Selection := TGridRect(Rect(-1, -1, -1, -1));
  if SearchResult.Count = 0 then begin
    grContainers.RowCount := 2;
    Self.FormResize(Self);
    Exit;
  end;

  grContainers.RowCount := SearchResult.Count + 1;
  for I := 0 to SearchResult.Count - 1 do begin
    SearchResultItem := SearchResult.Items[I];
    grContainers.Cells[0, I + 1] := IntToStr(I + 1);
    grContainers.Cells[1, I + 1] := SearchResultItem.Container.Title;
    grContainers.Cells[2, I + 1] := SearchResultItem.Box.BoxCode;
    grContainers.Cells[3, I +  1] := SearchResultItem.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language);
    grContainers.Cells[4, I + 1] := FloatToStr(SearchResultItem.Count);
    grContainers.Objects[1, I + 1] := SearchResultItem.Box;
    if I mod 2 = 0 then grContainers.SetRowColor(I + 1, rgb(240, 240, 230));
  end;
  Self.FormResize(Self);
end;

procedure TfrmSearch.ResultEmpty;
var
  Msg: string;
begin
  Msg := Translator.GetInstance.TranslateMessage(
    42, 'Поиск не дал результаов') + ' !';
  MessageDlg(Msg, mtWarning, [mbOk], 0);
end;


procedure TfrmSearch.SearchPart(Part: TPart);
var
  SearchResultInOrders, SearchResultInContainers: TSearchResult;
  Finder: TFindInShipment;
begin
  lbCaption2.Caption := Translator.GetInstance.TranslateMessage(
    43, 'Поиск по всех заказах и всех контейнерах');
  Self.SetDesableSearch(Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language));
  pnOrders.Visible := True;
  pnContainers.Visible := True;
  Splitter1.Visible := True;
  pnOrders.Align := alTop;
  pnContainers.Align := alClient;
  pnOrders.Top := 0;
  pnOrders.Height := trunc(pnMain.ClientHeight * 0.48);

  SearchResultInOrders := TSearchResult.Create;
  SearchResultInContainers := TSearchResult.Create;
  Finder := TFindInShipment.Create(FDocument);
  Finder.SearchPartInContainers(Part, SearchResultInContainers);
  Finder.SearchPartInOrders(Part, SearchResultInOrders);
  if (SearchResultInOrders.Count = 0) and (SearchResultInContainers.Count = 0) then
      Self.ResultEmpty;
  Self.RefreshContainerGrid(SearchResultInContainers);
  Self.RefreshOrderGrid(SearchResultInOrders);
  Self.Show;

  SearchResultInContainers.Free;
  SearchResultInOrders.Free;
  Finder.Free;
end;

procedure TfrmSearch.SearchOrderItem(Order: TOrder; Part: TPart);
var
  SearchResult: TSearchResult;
  Finder: TFindInShipment;
begin
  Self.SetDesableSearch(Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language));
  lbCaption2.Caption := Translator.GetInstance.TranslateWord(
    'Заказ') + ':' + Order.Title;
  pnOrders.Visible := False;
  Splitter1.Visible := False;
  pnContainers.Visible := True;

  SearchResult := TSearchResult.Create;
  Finder := TFindInShipment.Create(FDocument);
  if Finder.SearchForOrder(Order, Part, SearchResult) then begin
    Self.RefreshContainerGrid(SearchResult);
    Self.Show;
  end else
    Self.ResultEmpty;
  SearchResult.Free;
  Finder.Free;
end;

procedure TfrmSearch.SearchBoxItem(Item: TBoxItem);
var
  SearchResult: TSearchResult;
  Finder: TFindInShipment;
begin
  Self.SetDesableSearch(Item.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language));
  lbCaption2.Caption := Translator.GetInstance.TranslateMessage(
    60, 'Поиск во всех заказах');
  pnOrders.Visible := True;
  pnOrders.Align := alClient;
  Splitter1.Visible := False;
  pnContainers.Visible := False;

  SearchResult := TSearchResult.Create;
  Finder := TFindInShipment.Create(FDocument);
  if Finder.SearchPartInOrders(Item.Part, SearchResult) then begin
    Self.RefreshOrderGrid(SearchResult);
    Self.Show;
  end else
    Self.ResultEmpty;
  SearchResult.Free;
  Finder.Free;
end;

procedure TfrmSearch.SearchTitle(Title: widestring; PrepareForm: boolean = True);
var
  SearchResultInOrders, SearchResultInContainers: TSearchResult;
  Finder: TFindInShipment;
begin
  if PrepareForm then begin
    lbCaption2.Caption := Translator.GetInstance.TranslateMessage(
      43, 'Поиск по всех заказах и всех контейнерах');
    Self.SetEnabledSearch(Title);
    pnOrders.Visible := True;
    pnContainers.Visible := True;
    Splitter1.Visible := True;
    pnOrders.Align := alTop;
    pnContainers.Align := alClient;
    pnOrders.Top := 0;
    pnOrders.Height := trunc(pnMain.ClientHeight * 0.48);
  end;

  SearchResultInOrders := TSearchResult.Create;
  SearchResultInContainers := TSearchResult.Create;
  Finder := TFindInShipment.Create(FDocument);
  Finder.SearchTitleInContainers(Title, SearchResultInContainers,
    cbLanguage.ItemIndex);
  Finder.SearchTitleInOrders(Title, SearchResultInOrders,
    cbLanguage.ItemIndex);
  Self.RefreshContainerGrid(SearchResultInContainers);
  Self.RefreshOrderGrid(SearchResultInOrders);
  Self.Show;

  SearchResultInContainers.Free;
  SearchResultInOrders.Free;
  Finder.Free;
end;

end.
