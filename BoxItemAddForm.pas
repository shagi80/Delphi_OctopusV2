unit BoxItemAddForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmBoxItemAdd = class(TForm)
    pnMain: TPanel;
    Image1: TImage;
    pnOnlySelect: TPanel;
    Image2: TImage;
    lbOnlySelect: TLabel;
    pnSelectAndMark: TPanel;
    Image3: TImage;
    lbSelectAndMark: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnSelectAndMarkMouseEnter(Sender: TObject);
    procedure pnSelectAndMarkMouseLeave(Sender: TObject);
    procedure pnOnlySelectMouseLeave(Sender: TObject);
    procedure pnOnlySelectMouseEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBoxItemAdd: TfrmBoxItemAdd;

implementation

{$R *.dfm}

var
  SelectColor: TColor;

procedure TfrmBoxItemAdd.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered := True;
end;

procedure TfrmBoxItemAdd.FormShow(Sender: TObject);
begin
  SelectColor := rgb(255, 200, 200);
end;

procedure TfrmBoxItemAdd.pnOnlySelectMouseEnter(Sender: TObject);
begin
  Self.lbOnlySelect.Font.Color := clRed;
  Self.lbOnlySelect.Font.Style := [fsBold];
  Screen.Cursor := crHandPoint;
end;

procedure TfrmBoxItemAdd.pnOnlySelectMouseLeave(Sender: TObject);
begin
  Self.lbOnlySelect.Font.Color := clBlack;
  Self.lbOnlySelect.Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TfrmBoxItemAdd.pnSelectAndMarkMouseEnter(Sender: TObject);
begin
  Self.lbSelectAndMark.Font.Color := clRed;
  Self.lbSelectAndMark.Font.Style := [fsBold];
  Screen.Cursor := crHandPoint;
end;

procedure TfrmBoxItemAdd.pnSelectAndMarkMouseLeave(Sender: TObject);
begin
  Self.lbSelectAndMark.Font.Color := clBlack;
  Self.lbSelectAndMark.Font.Style := [];
  Screen.Cursor := crDefault;
end;

end.
