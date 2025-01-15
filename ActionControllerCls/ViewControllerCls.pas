unit ViewControllerCls;

interface

uses
  Forms, StdCtrls;

const
  vwView = 0;
  vwBoxCreator = 1;
  vwInvoice = 2;

type
  TOnChange = procedure (Sender: TObject) of object;

  TViewController = class(TObject)
  private
    FMainForm: TForm;
    FView: integer;
    FOnChange: TOnChange;
    procedure ModeView;
    procedure ModeBoxCreator;
    procedure ModeInvoice;
    procedure SetView(View: integer);
  public
    constructor Create(MainForm: TForm);
    property CurrentView: integer read FView write SetView;
    property OnChange: TOnChange read FOnChange write FOnChange;
    procedure MoveMainForm;
    procedure UpdatrViewList(ComboBox: TComboBox);
    procedure ShowFormExecute(Sender: TObject);
    procedure ViewChangeExecute(Sender: TObject);
  end;

implementation

uses
  InvoiceForm, PartPropertyForm, ContainerForm, OrdersForm, BoxForm, MainForm,
  Controls, TranslatorCls, AccesManagerCls;

const
  FORM_BEVEL = 5;

constructor TViewController.Create(MainForm: TForm);
begin
  inherited Create;
  FMainForm := MainForm;
  FView := -1;
end;

procedure TViewController.UpdatrViewList(ComboBox: TComboBox);
begin
  ComboBox.Items.Clear;
  ComboBox.Items.Add(Translator.GetInstance.TranslateWord('Просмотр'));
  ComboBox.Items.Add(Translator.GetInstance.TranslateWord('Конструктор коробок'));
  ComboBox.Items.Add(Translator.GetInstance.TranslateWord('Редактор инвойса'));
  if Self.FView > 0 then ComboBox.ItemIndex := Self.FView
    else ComboBox.ItemIndex := 0;
end;

procedure TViewController.MoveMainForm;
begin
  FMainForm.Left := 0;
  FMainForm.Width := Screen.WorkAreaWidth;
  FMainForm.Top := FORM_BEVEL;
end;

procedure TViewController.SetView(View: Integer);
begin
  FView := View;
  //Self.HideAll;
  Self.MoveMainForm;
  case FView of
    vwView: Self.ModeView;
    vwBoxCreator: Self.ModeBoxCreator;
    vwInvoice: Self.ModeInvoice;
  end;
end;

procedure TViewController.ModeView;
begin
  frmContainers.Visible := False;
  frmBox.Visible := False;
  frmInvoice.Visible := False;

  frmPartProperty.Left := FMainForm.Left;
  frmPartProperty.Top := FMainForm.Top + FMainForm.Height + FORM_BEVEL;
  frmPartProperty.Width := trunc(FMainForm.Width * 0.2);
  frmPartProperty.Height := trunc(Screen.WorkAreaHeight * 0.7);
  frmPartProperty.Visible := True;

  frmOrders.Left := frmPartProperty.Left + frmPartProperty.Width + FORM_BEVEL;
  frmOrders.Top := frmPartProperty.Top;
  frmOrders.Width := trunc(FMainForm.Width * 0.3);
  frmOrders.Height := Screen.WorkAreaHeight - frmOrders.Top - FORM_BEVEL;
  //frmOrders.BoxCreatorMode := False;
  frmOrders.Visible := True;

  frmContainers.Top := frmOrders.Top;
  frmContainers.Left := frmOrders.Left + frmOrders.Width + FORM_BEVEL;
  frmContainers.Height := frmOrders.Height;
  frmContainers.Width := FMainForm.Width - frmContainers.Left - FORM_BEVEL;
  frmContainers.Visible := True;
  frmContainers.EditBoxes := AccesManager.GetInstance.CanEditBoxes;
end;

procedure TViewController.ModeBoxCreator;
begin
  frmPartProperty.Visible := False;
  frmInvoice.Visible := False;

  frmOrders.Left := FMainForm.Left;;
  frmOrders.Top := FMainForm.Top + FMainForm.Height + FORM_BEVEL;
  frmOrders.Width := trunc(FMainForm.Width * 0.25);
  frmOrders.Height := Screen.WorkAreaHeight - frmOrders.Top - FORM_BEVEL;
  //frmOrders.BoxCreatorMode := AccesManager.GetInstance.CanEditBoxes;;
  frmOrders.Visible := True;

  frmBox.Box := nil;
  frmBox.Top := frmOrders.Top;
  frmBox.Left := frmOrders.Left + frmOrders.Width + FORM_BEVEL;
  frmBox.Height := trunc(Screen.WorkAreaHeight * 0.6);
  frmBox.Width := trunc(FMainForm.Width * 0.15);
  frmBox.Visible := True;
  frmBox.Box := nil;

  frmContainers.Top := frmBox.Top;
  frmContainers.Left := frmBox.Left + frmBox.Width + FORM_BEVEL;
  frmContainers.Height := frmOrders.Height;
  frmContainers.Width := FMainForm.Width - frmContainers.Left - FORM_BEVEL;
  frmContainers.Visible := True;
  frmContainers.EditBoxes := False;
end;

procedure TViewController.ModeInvoice;
begin
  frmPartProperty.Visible := False;
  frmOrders.Visible := False;
  frmBox.Visible := False;

  frmContainers.Top := FMainForm.Top + FMainForm.Height + FORM_BEVEL;
  frmContainers.Left := FMainForm.Left;
  frmContainers.Height := Screen.WorkAreaHeight - frmContainers.Top - FORM_BEVEL;
  frmContainers.Width := trunc(FMainForm.Width * 0.3);
  frmContainers.Visible := True;
  frmContainers.EditBoxes := False;

  frmInvoice.Top := frmContainers.Top;
  frmInvoice.Left := frmContainers.Left + frmContainers.Width + FORM_BEVEL;
  //frmInvoice.Left :=  FMainForm.Left;
  frmInvoice.Height := frmContainers.Height;
  //frmInvoice.Height := Screen.WorkAreaHeight - frmContainers.Top - FORM_BEVEL;
  frmInvoice.Width := FMainForm.Width - frmInvoice.Left - FORM_BEVEL;
  frmInvoice.Visible := True;
end;

procedure TViewController.ShowFormExecute(Sender: TObject);
var
  SenderName: string;
  Form: TForm;
begin
  Form := nil;
  SenderName := TControl(Sender).Name;
  if SenderName = 'ViewPartForm' then Form := frmPartProperty;
  if SenderName = 'ViewOrdersForm' then Form := frmOrders;
  if SenderName = 'ViewBoxForm' then Form := frmBox;
  if SenderName = 'ViewContainersForm' then Form := frmContainers;
  if SenderName = 'ViewInvoiceForm' then Form := frmInvoice;
  if Form = nil then Exit;  
  Form.Visible := not Form.Visible;
  if Form.Visible then Form.BringToFront;
  if Assigned(FOnChange) then Self.FOnChange(Self);
end;

procedure TViewController.ViewChangeExecute(Sender: TObject);
var
  SenderName: string;
begin
  SenderName := TControl(Sender).Name;
  if SenderName = 'cbView' then SetView(TComboBox(Sender).ItemIndex);
  if SenderName = 'ViewView' then SetView(vwView);
  if SenderName = 'ViewBoxCreator' then SetView(vwBoxCreator);
  if SenderName = 'ViewInvoice' then SetView(vwInvoice);
  if Assigned(FOnChange) then Self.FOnChange(Self);
end;

end.
