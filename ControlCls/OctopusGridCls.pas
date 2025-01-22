unit OctopusGridCls;

interface

uses
  SysUtils, Contnrs, Messages, Classes, Controls, Grids, TntGrids, Types, TntStdCtrls;

type
  TEndEditEvent = procedure (Sender: TObject; ACol, ARow: integer; Value: widestring) of object;

  TColAlignArray = array of Cardinal;

  TEditableCellSet = set of 0..255;

  TRowState = class(TObject)
  private
    FRowSelected: boolean;
    FColor: integer;
    FMarkedCols: TEditableCellSet;
  public
    constructor Create;
    property RowSelected: boolean read FRowSelected write FRowSelected;
    property Color: integer read FColor write FColor;
    property MarkedCols: TEditableCellSet read FMarkedCols write FMarkedCols;
  end;

  TMyInpEdit = class(TTntInplaceEdit)
  private
    FRow: integer;
    FCol: integer;
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure BoundsChanged; override;
  end;

  TOctopusStringGrid = class(TTntStringGrid)
  private
    FColAlign: TColAlignArray;
    FEditableCellSet: TEditableCellSet;
    FCheckListStyle: boolean;
    FWordWrap: boolean;
    FColored: boolean;
    FOnEndEdit: TEndEditEvent;
    FColoredSelection: boolean;
    function GetColAlign(Ind: integer): Cardinal;
    procedure SetColAlign(Ind: integer; AlignFlag: Cardinal);
    procedure SetCheckListStyle(Style: boolean);
    procedure DrawText(Rct: TRect; ACol, ARow: integer);
    procedure DrawCheckBox(Rct: TRect; ARow: integer);
  protected
    function CreateEditor:TInplaceEdit; override;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    property WordWrap: boolean read FWordWrap write FWordWrap;
    property Colored: boolean read FColored write FColored;
    property OnEndEdit: TEndEditEvent read FOnEndEdit write FOnEndEdit;
    property ColAlign[Ind: integer]: Cardinal read GetColAlign write SetColAlign;
    property EditableCells: TEditableCellSet read FEditableCellSet
      write FEditableCellSet;
    property CheckListStyle: boolean read FCheckListStyle write SetCheckListStyle;
    property ColoredSelection: boolean read FColoredSelection write FColoredSelection;
    procedure Sort(Column: integer);
    procedure Clear;
    procedure UnselectAll;
    procedure SelectAll;
    procedure ChangeSelection;
    procedure DoExit; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure Repaint; override;
    procedure KeyPress(var Key: Char); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure Click; override;
    procedure SetRowColor(ARow: integer; Color: integer);
    procedure SetCellMark(ARow: integer; Cells: TEditableCellSet);
    procedure ScrollToObject(ACol: integer; GridObject: TObject);
    procedure GetSelectedObjects(ACol: integer; Target: TObjectList);
    function CheckRowSelection(ARow: integer): boolean;
  end;

procedure Register;

implementation

uses
  Graphics, Windows, Dialogs, TntClasses, Forms;

// TMyInpEdit

procedure TMyInpEdit.WndProc(var Message: TMessage);
var
  OwnerGrid: TOctopusStringGrid;
begin
  inherited WndProc(Message);
  OwnerGrid := TOctopusStringGrid(Self.Owner);
  if (OwnerGrid.Selection.Left < 0) or (OwnerGrid.Selection.Top < 0) then begin
    Self.Hide;
    Exit;
  end;
  if Message.Msg = WM_KILLFOCUS then begin
    if (FCol < 0) or (FRow < 0) then Exit;
    if Assigned(OwnerGrid.FOnEndEdit) then OwnerGrid.FOnEndEdit(
      OwnerGrid, Self.FCol, Self.FRow, Self.Text);
  end;
end;

procedure TMyInpEdit.BoundsChanged;
var
  OwnerGrid: TOctopusStringGrid;
begin
  inherited BoundsChanged;
  OwnerGrid := TOctopusStringGrid(Self.Owner);
  Self.FCol := OwnerGrid.Col;
  Self.FRow := OwnerGrid.Row;
end;

// TRowState

constructor TRowState.Create;
begin
  inherited Create;
  Self.FRowSelected := False;
  Self.FColor := clWhite;
end;

// TOctopusStringGrid

constructor TOctopusStringGrid.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FWordWrap := False;
  FColored := False;
  SetLength(Self.FColAlign, 0);
  Options := Options - [goRangeSelect];
  DoubleBuffered := True;
  FColoredSelection := True;
end;

destructor TOctopusStringGrid.Destroy;
begin
  Self.Clear;
  SetLength(Self.FColAlign, 0);
  inherited Destroy;
end;

function TOctopusStringGrid.CreateEditor: TInplaceEdit;
var
  Editor: TMyInpEdit;
begin
  Editor := TMyInpEdit.Create(Self);
  Result := Editor;
end;

procedure TOctopusStringGrid.Repaint;
var
  I: integer;
begin
  for I := 0 to RowCount - 1 do
    if RowHeights[i] <> DefaultRowHeight then
      RowHeights[i] := DefaultRowHeight;
  inherited Repaint;
end;

procedure TOctopusStringGrid.DoExit;
begin
  inherited DoExit;
end;

procedure TOctopusStringGrid.DrawText(Rct: TRect; ACol, ARow: integer);
var
  Text: widestring;
  Flag: cardinal;
  TextHeight: integer;
begin
  Text := Self.Cells[ACol, ARow];
  Flag := Self.GetColAlign(ACol);
  if ACol in Self.FEditableCellSet then Self.Canvas.Font.Color := clNavy
    else Self.Canvas.Font.Color := clBlack;
  if FWordWrap then  Flag := Flag or DT_WORDBREAK;
  inc(Rct.Top, 2);
  inc(Rct.Left, 2);
  TextHeight := DrawTextW(Canvas.Handle, PWideChar(Text),
    Length(Text), Rct, Flag);
  TextHeight := TextHeight + 4;
  if (FWordWrap) and (TextHeight > RowHeights[ARow]) then
    RowHeights[ARow] := TextHeight;
end;

procedure TOctopusStringGrid.DrawCheckBox(Rct: TRect; ARow: integer);
var
  Size: integer;
  BufferColor: TColor;
begin
  if Length(Self.Cells[0, ARow]) = 0 then Exit;
  inc(Rct.Top, 5);
  inc(Rct.Left, 5);
  Size := trunc(Self.DefaultRowHeight * 0.5);
  Rct.Bottom := Rct.Top + Size;
  Rct.Right := Rct.Left + Size;
  Self.Canvas.Pen.Color := clBlack;
  if CheckRowSelection(ARow) then begin
    BufferColor := Self.Canvas.Brush.Color;
    Self.Canvas.Brush.Color := clBlack;
    Self.Canvas.FillRect(Rct);
    Self.Canvas.Brush.Color := BufferColor;
  end else Self.Canvas.Rectangle(Rct);
end;

procedure TOctopusStringGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState);
var
  Rct: TRect;
  RowState: TRowState;
  BrushColor: TColor;
begin
  if (ARow < FixedRows) then begin
    inherited DrawCell(ACol, ARow, ARect, AState);
    Exit;
  end;
  if (ARow >= FixedRows) and (ACol >= FixedCols) then begin
    Rct := ARect;
    if (FColoredSelection) and (gdSelected in AState) then
      Self.Canvas.Brush.Color := rgb(220, 250, 250)
    else
      if (Self.FColored) and (Self.Objects[0, ARow] <> nil) then begin
        RowState := TRowState(Self.Objects[0, ARow]);
        Self.Canvas.Brush.Color := RowState.Color;
      end else Self.Canvas.Brush.Color := clWhite;
    Self.Canvas.Font.Color := clBlack;
    Self.Canvas.FillRect(Rct);
    if (Self.Objects[0, ARow] <> nil) then begin
      RowState := TRowState(Self.Objects[0, ARow]);
      if ACol in RowState.MarkedCols then begin
        Self.Canvas.Pen.Color := clRed;
        BrushColor := Self.Canvas.Brush.Color;
        Self.Canvas.Brush.Color := clRed;
        Self.Canvas.Ellipse(Rct.Left + 2, Rct.Top + 2,
          Rct.Left + 10, Rct.Top + 10);
        Self.Canvas.Brush.Color := BrushColor;
      end;
    end;
    if (FCheckListStyle) and (ACol = 0) then Self.DrawCheckBox(Rct, ARow)
      else Self.DrawText(Rct, ACol, ARow);
  end;
  if not EditorMode then EditorMode := (goEditing in Options);
end;

procedure TOctopusStringGrid.Sort(Column: Integer);
var
  I, I2: integer;
  BufSL: TTntStringList;
begin
  Column := 1;
  try
    BufSL := TTntStringList.Create;
    try
      for I := Self.FixedRows to RowCount - 1 do begin
        for I2 := I + 1 to RowCount - 1 do begin
          // Cортируем по возрастанию
          if WideCompareStr(Cells[Column, I], Cells[Column, I2]) > 0 then begin
            BufSL.Assign(Rows[I]);
            Rows[I] := Rows[I2];
            Rows[I2] := BufSL;
          end;
        end;
      end;
    except
    end;
  finally
    FreeAndNil(BufSL);
  end;
end;

procedure TOctopusStringGrid.KeyPress(var Key: Char);
const
  Toolskey = [13, 8, 46, 38..40, 48..57];
var
  NextRow: boolean;
begin
  if not((Key in [',', '.']) or (ord(Key) in ToolsKey)) then Key := chr(0);
  NextRow := (Key = #13);
  inherited KeyPress(Key);
  if NextRow then
    if (Row < RowCount - 1) then Row := Row + 1 else
      Self.Options := Self.Options - [goEditing];
end;

function TOctopusStringGrid.GetColAlign(Ind: integer): Cardinal;
begin
  if Ind <= High(Self.FColAlign) then Result := FColAlign[Ind]
    else Result := DT_LEFT;
end;

procedure TOctopusStringGrid.SetColAlign(Ind: integer; AlignFlag: Cardinal);
begin
  if High(Self.FColAlign) <> (Self.ColCount - 1) then
    SetLength(Self.FColAlign, Self.ColCount);
  Self.FColAlign[Ind] := AlignFlag;
end;

procedure TOctopusStringGrid.Clear;
var
  ACol, ARow: integer;
begin
  for ARow := 0 to RowCount - 1 do
    if Assigned(Objects[0, ARow]) then Objects[0, ARow].Free;
  for ARow := 0 to Self.RowCount - 1 do begin
    for ACol := 0 to Self.ColCount - 1 do begin
      Cells[ACol, ARow] := '';
      if Objects[ACol, ARow] <> nil then Objects[ACol, ARow] := nil;
    end;
  end;
end;

function TOctopusStringGrid.SelectCell(ACol, ARow: Longint): Boolean;
begin
  inherited SelectCell(ACol, ARow);
  if (ACol in Self.FEditableCellSet)
    and ((Objects[1, ARow] <> nil) or (integer(Objects[1, ARow]) = 0)) then
      Options := Options + [goEditing]
    else Options := Options - [goEditing];
  Result := True;
end;

procedure TOctopusStringGrid.SetCheckListStyle(Style: Boolean);
begin
  Self.UnselectAll;
  Self.FCheckListStyle := Style;
end;

procedure TOctopusStringGrid.UnselectAll;
var
  I: integer;
begin
  for I := 0 to RowCount - 1 do
    if Objects[0, I] <> nil then
      TRowState(Self.Objects[0, I]).FRowSelected := False;
end;

procedure TOctopusStringGrid.SelectAll;
var
  I: integer;
  RowState: TRowState;
begin
  for I := 0 to RowCount - 1 do
    if (Length(Self.Cells[0, I]) > 0) then begin
      if (Objects[0, I] = nil) then Objects[0, I] := TRowState.Create;
      RowState := TRowState(Self.Objects[0, I]);
      RowState.FRowSelected := True;
    end;
end;

procedure TOctopusStringGrid.ChangeSelection;
var
  I: integer;
  RowState: TRowState;
begin
  for I := 0 to RowCount - 1 do
    if (Length(Self.Cells[0, I]) > 0) then begin
      if (Objects[0, I] = nil) then Objects[0, I] := TRowState.Create;
      RowState := TRowState(Self.Objects[0, I]);
      RowState.FRowSelected := not RowState.FRowSelected;
    end;
end;

procedure TOctopusStringGrid.Click;
var
  RowState: TRowState;
begin
  if (CheckListStyle) and (Col = 0) and (Row >= FixedRows) then begin
    if Self.Objects[0, Row] = nil then begin
        RowState := TRowState.Create;
        Self.Objects[0, Row] := RowState;
      end else RowState := TRowState(Self.Objects[0, Row]);
    if not CheckRowSelection(Self.Row) then RowState.RowSelected := True
      else RowState.RowSelected := False;
    Refresh;
  end;
end;

function  TOctopusStringGrid.CheckRowSelection(ARow: Integer): boolean;
begin
  Result := (not (Self.Objects[0, ARow] = nil)
    and (TRowState(Self.Objects[0, ARow]).RowSelected));
end;

procedure TOctopusStringGrid.SetRowColor(ARow: integer; Color: integer);
var
  RowState: TRowState;
begin
  if Self.Objects[0, ARow] = nil then begin
    RowState := TRowState.Create;
    Self.Objects[0, ARow] := RowState;
  end
    else RowState := TRowState(Self.Objects[0, ARow]);
  RowState.Color := Color;
end;

procedure TOctopusStringGrid.SetCellMark(ARow: Integer; Cells: TEditableCellSet);
var
  RowState: TRowState;
begin
  if Self.Objects[0, ARow] = nil then begin
    RowState := TRowState.Create;
    Self.Objects[0, ARow] := RowState;
  end
    else RowState := TRowState(Self.Objects[0, ARow]);
  RowState.MarkedCols := Cells;
end;

procedure TOctopusStringGrid.ScrollToObject(ACol: integer; GridObject: TObject);
var
  ARow, NewTopRow: integer;
begin
  if GridObject = nil then Exit;
  for ARow := 1 to Self.RowCount - 1 do
    if Self.Objects[ACol, ARow] = GridObject then begin
      if ((ARow - Self.TopRow) > Self.VisibleRowCount) or (ARow < Self.TopRow) then begin
        NewTopRow := ARow - 1;
        if NewTopRow < 1 then NewTopRow := 1;
        Self.TopRow := NewTopRow;
      end;
      Self.SelectCell(ACol, ARow);
      Exit;
    end;
end;

procedure TOctopusStringGrid.GetSelectedObjects(ACol: integer; Target: TObjectList);
var
  ARow: integer;
  ColObject: TObject;
begin
  Target.Clear;
  for ARow := 1 to Self.RowCount - 1 do
    if Self.CheckRowSelection(ARow) then begin
      ColObject := Self.Objects[ACol, ARow];
      if (ColObject <> nil) or (integer(ColObject) = 0) then Target.Add(ColObject);
    end;
end;

// Register

procedure Register;
begin
  RegisterComponents('Samples', [TOctopusStringGrid]);
end;

end.
