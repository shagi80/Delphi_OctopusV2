unit PartEditorForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ExtCtrls, Buttons, PartCls, DocumentCls,
  TntGrids, OctopusGridCls, OrderItemCls, TntStdCtrls;

type
  TfrmPartEditor = class(TForm)
    pnMain: TPanel;
    pnButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    pnProperty: TPanel;
    Label1: TLabel;
    lbCode: TLabel;
    lbFullName: TLabel;
    lbEngName: TLabel;
    lbSuppName: TLabel;
    lbVolume: TLabel;
    lbNet: TLabel;
    lbUnit: TLabel;
    edCode: TEdit;
    edVolume: TEdit;
    cbUnit: TComboBox;
    edBOM: TEdit;
    edNet: TEdit;
    edFOBPrice: TEdit;
    edPrice: TEdit;
    edTNVED: TEdit;
    lbCFRPrice: TLabel;
    lbFOBPrice: TLabel;
    lbBOM: TLabel;
    lbPrice: TLabel;
    lbTNVED: TLabel;
    lbName: TLabel;
    edName: TEdit;
    edFullName: TTntMemo;
    edEngName: TTntMemo;
    edSuppName: TTntMemo;
    edCFRPrice: TEdit;
    edPack: TComboBox;
    lbPack: TLabel;
    edPackCount: TEdit;
    lbPackCount: TLabel;
    Label2: TLabel;
    grOrders: TOctopusStringGrid;
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FPart: TPart;
    FDocument: TDocument;
    FMode: integer;
    procedure SetPartProperty;
    procedure PrepareForm(Part: TPart; Document: TDocument);
    procedure RefreshPropertyGrid(Sender: TObject);
    procedure RefreshOrderGrid(Sender: TObject);
    procedure ResizeGrid(Grid: TOctopusStringGrid);
    procedure GetPartProperty;
    procedure SetEmptyProperty;
    function GetOrderCount: TOrderItem;
  public
    function AddPart(Document: TDocument): TOrderItem;
    function CopyPart(Part: TPart; Document: TDocument): TOrderItem;
    function EditPart(Part: TPart; Document: TDocument): TOrderItem;
  end;

var
  frmPartEditor: TfrmPartEditor;

implementation

{$R *.dfm}

uses
  TranslatorCls, FindInShipmentCls, OrderCls, GlobalSettingsCls,
  AccesManagerCls;

const
  mdAdd = 0;
  mdEdit = 1;
  mdCopy = 2;

var
  NetStrings: array [0..5] of string = ('шт', 'м', 'л', 'г', 'кг', 'т');

procedure TfrmPartEditor.FormCreate(Sender: TObject);
begin
  FPart := nil;
  FDocument := nil;
  FMode := -1;
  grOrders.EditableCells := [1];
  grOrders.WordWrap := True;
  grOrders.ColWidths[0] := trunc(grOrders.ClientWidth * 0.5);
end;

procedure TfrmPartEditor.ResizeGrid(Grid: TOctopusStringGrid);
begin
  Grid.ColWidths[1] := Grid.ClientWidth - Grid.ColWidths[0] - 2;
end;

procedure TfrmPartEditor.FormResize(Sender: TObject);
begin
  btnOk.Left := trunc(Self.ClientWidth / 2) - btnOk.Width - 3;
  btnCancel.Left := trunc(Self.ClientWidth / 2) + 3;
  Self.ResizeGrid(grOrders);
end;

procedure TfrmPartEditor.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  Self.ResizeGrid(TOctopusStringGrid(Sender));
end;

procedure TfrmPartEditor.GridKeyPress(Sender: TObject; var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
end;

procedure TfrmPartEditor.btnOkClick(Sender: TObject);
var
  Errors: string;
  FindPart: TPart;
begin
  Self.ModalResult := mrOk;
  Errors := '';
  FindPart := Self.FDocument.Parts.Items[edCode.Text];
  if (FindPart <> nil) and (FindPart <> FPart) then
    Errors := Errors + chr(13)
      + Translator.GetInstance.TranslateMessage(
      27, 'Код 1С должен быть уникальным') + ' !';
  if Length(edCode.Text) = 0 then
    Errors := Errors + chr(13)
      + lbCode.Caption + ' - '
      + Translator.GetInstance.TranslateMessage(
        24, 'обязательное поле') + ' !';
  if Length(edName.Text) = 0 then
    Errors := Errors + chr(13)
      + lbName.Caption + ' - '
      + Translator.GetInstance.TranslateMessage(
        24, 'обязательное поле') + ' !';
  if Length(edFullName.Text) = 0 then
    Errors := Errors + chr(13)
      + lbFullName.Caption + ' - '
      + Translator.GetInstance.TranslateMessage(
        24, 'обязательное поле') + ' !';
  if Length(edEngName.Text) = 0 then
    Errors := Errors + chr(13)
      + lbEngName.Caption + ' - '
      + Translator.GetInstance.TranslateMessage(
        24, 'обязательное поле') + ' !';
  {IsOrdered := False;
  for I := 1 to grOrders.RowCount - 1 do begin
    IsOrdered := (StrToFloatDef(grOrders.Cells[1, I], 0) > 0);
    if IsOrdered then Break;
  end;
  if not IsOrdered then
      Errors := Errors + chr(13)
        + Translator.GetInstance.TranslateMessage(
          25, 'Детал должна быть заказанна') + ' !';  }
  if Length(Errors) > 0 then begin
    Errors := Translator.GetInstance.TranslateMessage(
      26, 'Обнаружены ошибки:') + Errors;
    MessageDlg(Errors, mtWarning, [mbOk], 0);
    Self.ModalResult := mrNone;
  end;
end;


procedure TfrmPartEditor.GetPartProperty;
begin
  FPart.Code := edCode.Text;
  FPart.ShortTitle := edName.Text;
  FPart.RusName := edFullName.Text;
  FPart.EngName := edEngName.Text;
  FPart.ChinName := UTF8Encode(edSuppName.Text);
  //FPart.PartUnit := grProperty.Cells[1, 6];
  FPart.Weight := StrToFloatDef(edNet.Text, 0);
  FPart.Volume := StrToFloatDef(edVolume.Text, 0);
  FPart.BOM := edBOM.Text;
  FPart.CustomCode := edTNVED.Text;
  FPart.SupplierPrice := StrToFloatDef(edPrice.Text, 0);
  FPart.FOBPrice := StrToFloatDef(edFOBPrice.Text, 0);
  FPart.CFRPrice := StrToFloatDef(edCFRPrice.Text, 0);
  FPart.BoxType := edPack.Text;
  FPart.CountInBox := StrToFloatDef(edPackCount.Text, 0);

  if (cbUnit.ItemIndex >= 0) and (cbUnit.ItemIndex <= High(NetStrings)) then
    FPart.PartUnit := NetStrings[cbUnit.ItemIndex];
end;

function TfrmPartEditor.GetOrderCount: TOrderItem;
var
  I: integer;
  OrderItem: TOrderItem;
  Count: real;
begin
  Result := nil;
  for I := 1 to grOrders.RowCount - 1 do begin
    Count := StrToFloatDef(grOrders.Cells[1, I], 0);
    if Assigned(grOrders.Objects[1, I]) then
      if grOrders.Objects[1, I] is TOrderItem then begin
        TOrderItem(grOrders.Objects[1, I]).OrderCount := Count;
        Result :=  TOrderItem(grOrders.Objects[1, I]); 
      end else
        if Count > 0 then begin
          OrderItem := TOrderItem.Create(FPart);
          OrderItem.OrderCount := Count;
          TOrder(grOrders.Objects[1, I]).Add(OrderItem);
          Result := OrderItem;
        end;
  end;
end;

function TfrmPartEditor.AddPart(Document: TDocument): TOrderItem;
begin
  Result := nil;
  FMode := mdAdd;
  Self.PrepareForm(nil, Document);
  if Self.ShowModal = mrOk then begin
    FPart := TPart.Create(edCode.Text);
    GetPartProperty;
    FDocument.Parts.Add(FPart);
    Result := GetOrderCount;
  end;
end;

function TfrmPartEditor.CopyPart(Part: TPart; Document: TDocument): TOrderItem;
begin
  Result := nil;
  FMode := mdCopy;
  Self.PrepareForm(Part, Document);
  FPart := nil;
  if Self.ShowModal = mrOk then begin
    FPart := TPart.Create(edCode.Text);
    GetPartProperty;
    FDocument.Parts.Add(FPart);
    Result := GetOrderCount;
  end;
end;

function TfrmPartEditor.EditPart(Part: TPart; Document: TDocument): TOrderItem;
begin
  Result := nil;
  FMode := mdEdit;
  Self.PrepareForm(Part, Document);
  if ShowModal = mrOk then begin
    GetPartProperty;
    Result := GetOrderCount;
  end;
end;

procedure TfrmPartEditor.PrepareForm(Part: TPart; Document: TDocument);
var
  LocalTranslator: TTranslatorSingleton;
  Enable: boolean;
begin
  FPart := Part;
  FDocument := Document;
  LocalTranslator := Translator.GetInstance;
  case Self.FMode of
    mdAdd: Self.Caption := LocalTranslator.TranslateWord('Добавление детали');
    mdEdit: Self.Caption := LocalTranslator.TranslateWord('Изменение детали');
    mdCopy: Self.Caption := LocalTranslator.TranslateWord('Копирование детали');
  end;
  Enable := AccesManager.GetInstance.CanEditParts;
  pnProperty.Enabled := Enable;
  Self.pnButtons.Visible := Enable;
  if not pnButtons.Visible then Self.Height := 485 else Self.Height := 540;
  if not Enable then
    Self.Caption := LocalTranslator.TranslateWord('Только просмотр');
  Self.RefreshPropertyGrid(Self);
  Self.RefreshOrderGrid(Self);
end;


procedure TfrmPartEditor.SetPartProperty;
var
  I, Ind: integer;
begin
  edCode.Text := FPart.Code;
  edName.Text := FPart.ShortTitle;
  edFullName.Text := FPart.RusName;
  edEngName.Text := FPart.EngName;
  edSuppName.Text := FPart.ChinName;
  edNet.Text := FloatToStr(FPart.Weight);
  edVolume.Text := FloatToStr(FPart.Volume);
  edBOM.Text := FPart.BOM;
  edTNVED.Text := FPart.CustomCode;
  edPrice.Text := FloatToStr(FPart.SupplierPrice);
  edFOBPrice.Text := FloatToStr(FPart.FOBPrice);
  edCFRPrice.Text := FloatToStr(FPart.CFRPrice);
  edPack.Text := FPart.BoxType;
  edPackCount.Text := FloatToStr(FPart.CountInBox);
  // Part unit
  cbUnit.Items.Clear;
  Ind := -1;
  for I := 0 to High(NetStrings) do begin
    cbUnit.Items.Add(Translator.GetInstance.TranslateWord(NetStrings[I]));
    if NetStrings[I] = FPart.PartUnit then Ind := I;
  end;
  if Ind = -1 then begin
    if GlobalSettings.GetInstance.Language = 0 then cbUnit.Items.Add(FPart.PartUnit)
      else cbUnit.Items.Add('other');
    Ind := cbUnit.Items.Count - 1;
  end;
  cbUnit.ItemIndex := Ind;
end;

procedure TfrmPartEditor.SetEmptyProperty;
var
  I: integer;
begin
  edCode.Text := '';
  edName.Text := '';
  edFullName.Text := '';
  edEngName.Text := '';
  edSuppName.Text := '';
  edNet.Text := '';
  edVolume.Text := '';
  edBOM.Text := '';
  edTNVED.Text := '';
  edPrice.Text := '';
  edFOBPrice.Text := '';
  edCFRPrice.Text := '';
  edPack.Text := '';
  edPackCount.Text := '';
  // Part unit
  cbUnit.Items.Clear;
  for I := 0 to High(NetStrings) do
    cbUnit.Items.Add(Translator.GetInstance.TranslateWord(NetStrings[I]));
  cbUnit.ItemIndex := 0;
end;

procedure TfrmPartEditor.RefreshPropertyGrid(Sender: TObject);
begin
  if FMode in [mdEdit, mdCopy] then Self.SetPartProperty;
  if FMode in [mdAdd] then SetEmptyProperty;
  if FMode in [mdAdd, mdCopy] then edCode.Text := FDocument.GetNewPartCode('W');
end;

procedure TfrmPartEditor.RefreshOrderGrid(Sender: TObject);
var
  Finder: TFindInShipment;
  I: integer;
  OrderItem: TOrderItem;
  Count: string;
begin
  grOrders.Clear;
  grOrders.Cells[0, 0] := Translator.GetInstance.TranslateWord('Заказ');
  grOrders.Cells[1, 0] := Translator.GetInstance.TranslateWord('Кол-во');
  grOrders.RowCount := FDocument.Orders.Count + 1;
  grOrders.Enabled := ((grOrders.RowCount > 1) and (Self.pnProperty.Enabled));
  if grOrders.RowCount = 1 then begin
    grOrders.RowCount := 2;
    Exit;
  end;
  Finder := TFindInShipment.Create(FDocument);
  for I := 0 to FDocument.Orders.Count - 1 do begin
    Count := '0';
    case FMode of
      mdAdd, mdCopy: grOrders.Objects[1, I + 1] := FDocument.Orders.Items[I];
      mdEdit: begin
          OrderItem := Finder.FindPartInOrder(FPart, FDocument.Orders.Items[I]);
          if OrderItem <> nil then begin
            Count := FloatToStr(OrderItem.OrderCount);
            grOrders.Objects[1, I + 1] := OrderItem;
          end else
            grOrders.Objects[1, I + 1] := FDocument.Orders.Items[I];
        end;
    end;
    grOrders.Cells[0, I + 1] := FDocument.Orders.Items[I].Title;
    grOrders.Cells[1, I + 1] := Count;
  end;
  Finder.Free;
  grOrders.Repaint;
end;

end.
