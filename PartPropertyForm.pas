unit PartPropertyForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, TntGrids, OctopusGridCls, PartCls, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls;

type
  TOnChangeData = procedure of object;
  TOnDoubleClick  = procedure (Sender: TObject) of object;

  TfrmPartProperty = class(TForm)
    grPart: TOctopusStringGrid;
    pnTop: TPanel;
    pnEditTools: TPanel;
    pnViewTools: TPanel;
    tbEdit: TToolBar;
    Label3: TLabel;
    btnPartAdd: TToolButton;
    btnPartCopy: TToolButton;
    btnPartEdit: TToolButton;
    btnPartDelete: TToolButton;
    tbView: TToolBar;
    btnSearchPart: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnPartListUpdate: TToolButton;
    procedure grPartDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPart: TPart;
    FEditMode: boolean;
    FOnChangeData: TOnChangeData;
    FOnDoubleClick: TOnDoubleClick;
    procedure RefreshHeader(Sende: TObject);
    procedure SetEditMode(EditMode: boolean);
    procedure OnEdit(Sende: TObject; ACol, ARow: integer; Value: widestring);
    procedure SetPart(Part: TPart);
  public
    { Public declarations }
    property Part: TPart read FPart write SetPart;
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnChangeData: TOnChangeData read FOnChangeData write FOnChangeData;
    property OnDoubleClick: TOnDoubleClick read FOnDoubleClick write FOnDoubleClick;
  published
    procedure RefreshGrid(Sende: TObject);
  end;

var
  frmPartProperty: TfrmPartProperty;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls, FindInShipmentCls, OrderItemCls;

procedure TfrmPartProperty.FormCreate(Sender: TObject);
begin
  FPart := nil;
  grPart.WordWrap := True;
  grPart.OnEndEdit := Self.OnEdit;
  grPart.ColoredSelection := False;
  FEditMode := False;
end;

procedure TfrmPartProperty.FormResize(Sender: TObject);
begin
  grPart.ColWidths[0] := trunc(grPart.ClientWidth * 0.3);
  grPart.ColWidths[1] := grPart.ClientWidth - grPart.ColWidths[0] - 3;
  grPart.Repaint;
end;

procedure TfrmPartProperty.FormShow(Sender: TObject);
begin
  Self.RefreshGrid(Self);
end;


procedure TfrmPartProperty.SetPart(Part: TPart);
begin
  FPart := Part;
  RefreshGrid(Self);
end;

procedure TfrmPartProperty.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  grPart.EditableCells := [];
  Self.pnEditTools.Visible := FEditMode;
  Self.pnEditTools.Top := 0;
  RefreshGrid(Self);
end;


procedure TfrmPartProperty.OnEdit(Sende: TObject; ACol, ARow: integer; Value: widestring);
begin
  case ARow of
    1: FPart.Code := grPart.Cells[1, 1];
    2: FPart.ShortTitle := grPart.Cells[1, 2];
    3: begin
        FPart.RusName := grPart.Cells[1, 3];
        //ShowMessage(FPart.RusName);
       end;
    4: FPart.EngName := grPart.Cells[1, 4];
    5: FPart.ChinName := UTF8Encode(grPart.Cells[1, 5]);
    6: FPart.PartUnit := grPart.Cells[1, 6];
    7: FPart.Weight := StrToFloatDef(grPart.Cells[1, 7], 0);
    8: FPart.Volume := StrToFloatDef(grPart.Cells[1, 8], 0);
    9: FPart.BOM := grPart.Cells[1, 9];
    10: FPart.CustomCode := grPart.Cells[1, 10];
    11: FPart.SupplierPrice := StrToFloatDef(grPart.Cells[1, 11], 0);
    12: FPart.FOBPrice := StrToFloatDef(grPart.Cells[1, 12], 0);
    13: FPart.CFRPrice := StrToFloatDef(grPart.Cells[1, 13], 0);
    14: FPart.BoxType := grPart.Cells[1, 14];
    15: FPart.CountInBox := StrToFloatDef(grPart.Cells[1, 15], 0);
  end;
  if Assigned(Self.FOnChangeData) then Self.FOnChangeData;
end;

procedure TfrmPartProperty.grPartDblClick(Sender: TObject);
begin
  if Assigned(FOnDoubleClick) then FOnDoubleClick(Self);
end;


procedure TfrmPartProperty.RefreshHeader(Sende: TObject);
begin
  Self.grPart.Cells[0, 0] := Translator.GetInstance.TranslateWord('Свойство');
  Self.grPart.Cells[1, 0] := Translator.GetInstance.TranslateWord('Значение');
end;

procedure TfrmPartProperty.RefreshGrid(Sende: TObject);
var
  LocalTranslator: TTranslatorSingleton;
begin
  if not Self.Visible then Exit;
  grPart.Clear;
  LocalTranslator := Translator.GetInstance;
  Self.RefreshHeader(Self);
  grPart.Enabled := (FPart <> nil);
  grPart.SelectCell(MaxInt, MaxInt);
  if (FPart = nil) then Exit;

  Perform(WM_SETREDRAW, 0, 0);

  Self.grPart.Cells[0, 1] := LocalTranslator.TranslateWord('Код 1С');
  Self.grPart.Cells[1, 1] := FPart.Code;
  Self.grPart.Cells[0, 2] := LocalTranslator.TranslateWord('Наименование');
  Self.grPart.Cells[1, 2] := FPart.ShortTitle;
  Self.grPart.Cells[0, 3] := LocalTranslator.TranslateWord('Полн наимнование');
  Self.grPart.Cells[1, 3] := FPart.RusName;
  Self.grPart.Cells[0, 4] := LocalTranslator.TranslateWord('Англ наименование');
  Self.grPart.Cells[1, 4] := FPart.EngName;
  Self.grPart.Cells[0, 5] := LocalTranslator.TranslateWord('Наимее поставщика');
  Self.grPart.Cells[1, 5] := FPart.ChinName;
  Self.grPart.Cells[0, 6] := LocalTranslator.TranslateWord('Ед изм');
  Self.grPart.Cells[1, 6] := FPart.PartUnit;
  Self.grPart.Cells[0, 7] := LocalTranslator.TranslateWord('Вес, кг');
  Self.grPart.Cells[1, 7] := FormatFloat('#0.0##########', FPart.Weight);
  Self.grPart.Cells[0, 8] := LocalTranslator.TranslateWord('Объем,м3');
  Self.grPart.Cells[1, 8] := FormatFloat('#0.0##########', FPart.Volume);
  Self.grPart.Cells[0, 9] := LocalTranslator.TranslateWord('BOM');
  Self.grPart.Cells[1, 9] := FPart.BOM;
  Self.grPart.Cells[0, 10] := LocalTranslator.TranslateWord('Код ТНВЭД');
  Self.grPart.Cells[1, 10] := FPart.CustomCode;
  Self.grPart.Cells[0, 11] := LocalTranslator.TranslateWord('Цена постаыщика');
  Self.grPart.Cells[1, 11] := FloatToStr(FPart.SupplierPrice);
  Self.grPart.Cells[0, 12] := LocalTranslator.TranslateMessage(87, 'FOB цена');
  Self.grPart.Cells[1, 12] := FloatToStr(FPart.FOBPrice);
  Self.grPart.Cells[0, 13] := LocalTranslator.TranslateMessage(88, 'CFR цена');
  Self.grPart.Cells[1, 13] := FloatToStr(FPart.CFRPrice);
  Self.grPart.Cells[0, 14] := LocalTranslator.TranslateWord('Вид тары');
  Self.grPart.Cells[1, 14] := FPart.BoxType;
  Self.grPart.Cells[0, 15] := LocalTranslator.TranslateWord('В коробке');
  Self.grPart.Cells[1, 15] := FloatToStr(FPart.CountInBox);
  Self.FormResize(Self);

  Perform(WM_SETREDRAW, 1, 0);
  RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_ALLCHILDREN or RDW_INVALIDATE);
end;

end.
