unit PartGridFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, PartCls, Grids, TntGrids, OctopusGridCls;

type
  TOnChangeData = procedure of object;

  TfrmPart = class(TFrame)
    grPart: TOctopusStringGrid;
    procedure FrameResize(Sender: TObject);
  published
    procedure RefreshGrid(Sende: TObject);
  private
    { Private declarations }
    FPart: TPart;
    FEditMode: boolean;
    FOnChangeData: TOnChangeData;
    procedure RefreshHeader(Language: integer);
    procedure SetEditMode(EditMode: boolean);
    procedure OnEdit(Sende: TObject; ACol, ARow: integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateData(Part: TPart);
    property EditMode: boolean read FEditMode write SetEditMode;
    property OnChangeData: TOnChangeData read FOnChangeData write FOnChangeData;
  end;

implementation

{$R *.dfm}

uses
  TranslatorCls, GlobalSettingsCls;

constructor TfrmPart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPart := nil;
  grPart.WordWrap := True;
  grPart.OnEndEdit := Self.OnEdit;
  grPart.ColoredSelection := False;
  FEditMode := False;
end;

procedure TfrmPart.UpdateData(Part: TPart);
begin
  FPart := Part;
  Self.Visible := (FPart <> nil);
  Self.RefreshGrid(Self);
end;

procedure TfrmPart.FrameResize(Sender: TObject);
begin
  grPart.ColWidths[0] := trunc(grPart.ClientWidth * 0.3);
  grPart.ColWidths[1] := grPart.ClientWidth - grPart.ColWidths[0] - 3;
  grPart.Repaint;
end;

procedure TfrmPart.RefreshGrid(Sende: TObject);
var
  Language: integer;
  LocalTranslator: TTranslatorSingleton;
begin
  grPart.Clear;
  Language := GlobalSettings.GetInstance.Language;
  LocalTranslator := Translator.GetInstance;
  Self.RefreshHeader(Language);
  grPart.Enabled := (FPart <> nil);
  if (FPart = nil) then Exit;
  Self.grPart.Cells[0, 1] := LocalTranslator.TranslateWord('Код 1С', Language);
  Self.grPart.Cells[1, 1] := FPart.Code;
  Self.grPart.Cells[0, 2] := LocalTranslator.TranslateWord('Наименование', Language);
  Self.grPart.Cells[1, 2] := FPart.ShortTitle;
  Self.grPart.Cells[0, 3] := LocalTranslator.TranslateWord('Полн наимнование', Language);
  Self.grPart.Cells[1, 3] := FPart.RusName;
  Self.grPart.Cells[0, 4] := LocalTranslator.TranslateWord('Англ наименование', Language);
  Self.grPart.Cells[1, 4] := FPart.EngName;
  Self.grPart.Cells[0, 5] := LocalTranslator.TranslateWord('Кит наименование', Language);
  Self.grPart.Cells[1, 5] := FPart.ChinName;
  Self.grPart.Cells[0, 6] := LocalTranslator.TranslateWord('Ед изм', Language);
  Self.grPart.Cells[1, 6] := FPart.PartUnit;
  Self.grPart.Cells[0, 7] := LocalTranslator.TranslateWord('Вес, кг', Language);
  Self.grPart.Cells[1, 7] := FloatToStr(FPart.Weight);
  Self.grPart.Cells[0, 8] := LocalTranslator.TranslateWord('Обьем, м3', Language);
  Self.grPart.Cells[1, 8] := FloatToStr(FPart.Volume);
  Self.grPart.Cells[0, 9] := LocalTranslator.TranslateWord('BOM', Language);
  Self.grPart.Cells[1, 9] := FPart.BOM;
  Self.grPart.Cells[0, 10] := LocalTranslator.TranslateWord('Код ТНВЭД', Language);
  Self.grPart.Cells[1, 10] := FPart.CustomCode;
  Self.grPart.Cells[0, 11] := LocalTranslator.TranslateWord('Цена постаыщика', Language);
  Self.grPart.Cells[1, 11] := FloatToStr(FPart.SupplierPrice);
  Self.grPart.Cells[0, 12] := LocalTranslator.TranslateWord('FOB цена', Language);
  Self.grPart.Cells[1, 12] := FloatToStr(FPart.FOBPrice);
  Self.grPart.Cells[0, 13] := LocalTranslator.TranslateWord('CFR цена', Language);
  Self.grPart.Cells[1, 13] := FloatToStr(FPart.CFRPrice);
  Self.grPart.Cells[0, 14] := LocalTranslator.TranslateWord('Вид тары', Language);
  Self.grPart.Cells[1, 14] := FPart.BoxType;
  Self.grPart.Cells[0, 15] := LocalTranslator.TranslateWord('Кол-во в коробке', Language);
  Self.grPart.Cells[1, 15] := FloatToStr(FPart.CountInBox);
  Self.grPart.Repaint;
end;

procedure TfrmPart.RefreshHeader(Language: Integer);
begin
  Self.grPart.Cells[0, 0] := Translator.GetInstance.TranslateWord('Свойство', Language);
  Self.grPart.Cells[1, 0] := Translator.GetInstance.TranslateWord('Значение', Language);
end;

procedure TfrmPart.SetEditMode(EditMode: boolean);
begin
  FEditMode := EditMode;
  if FEditMode then grPart.EditableCells := [1]
    else grPart.EditableCells := [];
  grPart.Repaint;  
end;

procedure TfrmPart.OnEdit(Sende: TObject; ACol, ARow: integer);
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

end.
