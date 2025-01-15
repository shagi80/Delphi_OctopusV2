unit MainFormPanelControllerCls;

interface

uses
  SDIMAIN;

type
  TMainFormPanelController = class(TObject)
  private
    FForm: SDIMAIN.TMainForm;
    procedure CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure HideAndShow;
    procedure SetActionEnabled;
    procedure SetAlign;
    procedure SetCantainerPanelVisible(Sender: TObject);
    procedure SetOrderPanelVisible(Sender: TObject);
    procedure SetParttPanelVisible(Sender: TObject);
  public
    constructor Create(Form: TMainForm);
    procedure SetInitialSize;
  end;

implementation

uses
  Controls;

constructor TMainFormPanelController.Create(Form: TMainForm);
begin
  inherited Create;
  FForm := Form;
  FForm.OrderPanelVisibleChange.Checked := FForm.pnOrder.Visible;
  FForm.ContainerPanelVisibleChange.Checked := FForm.pnContainer.Visible;
  FForm.PartPanelVisibleChange.Checked := FForm.pnPart.Visible;
  FForm.OnCanResize := Self.CanResize;
  FForm.OrderPanelVisibleChange.OnExecute := Self.SetOrderPanelVisible;
  FForm.ContainerPanelVisibleChange.OnExecute := Self.SetCantainerPanelVisible;
  FForm.PartPanelVisibleChange.OnExecute := SetParttPanelVisible;
end;

procedure TMainFormPanelController.SetInitialSize;
begin
  with FForm do begin
    pnPart.Width := trunc(ClientWidth  * 0.2);
    pnOrder.Width := trunc(ClientWidth * 0.3);
    pnContainer.Width := trunc(ClientWidth * 0.5);
  end;
end;

procedure TMainFormPanelController.CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var
  Scale: real;
begin
  with FForm do begin
    Scale := NewWidth / Width;
    pnPart.Width := trunc(pnPart.Width * Scale);
    pnOrder.Width := trunc(pnOrder.Width * Scale);
    pnContainer.Width := trunc(pnContainer.Width * Scale);
  end;
end;

procedure TMainFormPanelController.SetAlign;
begin
  with FForm do begin
    if not ContainerPanelVisibleChange.Checked then pnOrder.Align := alClient
      else pnOrder.Align := alLeft;
    if (not ContainerPanelVisibleChange.Checked) and (not OrderPanelVisibleChange.Checked) then
      pnPart.Align := alClient else pnPart.Align := alLeft;
    if ContainerPanelVisibleChange.Checked then pnContainer.Align := alClient;
  end;
end;

procedure TMainFormPanelController.SetActionEnabled;
begin
  with FForm do begin
  PartPanelVisibleChange.Enabled := (pnOrder.Visible or pnContainer.Visible);
  OrderPanelVisibleChange.Enabled := (pnPart.Visible or pnContainer.Visible);
  ContainerPanelVisibleChange.Enabled := (pnPart.Visible or pnOrder.Visible);
  btnParttPanelHide.Visible := (pnOrder.Visible or pnContainer.Visible);
  btnOrderPanelHide.Visible := (pnPart.Visible or pnContainer.Visible);
  btnCantainerPanelHide.Visible := (pnPart.Visible or pnOrder.Visible);
  end;
end;

procedure TMainFormPanelController.HideAndShow;
begin
  with FForm do begin
    pnPart.Align := alNone;
    pnOrder.Align := alNone;
    pnContainer.Align := alNone;
    Self.SetInitialSize;
    Self.SetAlign;
    pnContainer.Visible := ContainerPanelVisibleChange.Checked;
    pnContainer.Left := 0;
    spOrder.Visible := (OrderPanelVisibleChange.Checked and ContainerPanelVisibleChange.Checked);
    spOrder.Left := 0;
    pnOrder.Visible := OrderPanelVisibleChange.Checked;
    pnOrder.Left := 0;
    spPart.Visible := PartPanelVisibleChange.Checked;
    spPart.Left := 0;
    pnPart.Visible := PartPanelVisibleChange.Checked;
    pnPart.Left := 0;
    Self.SetActionEnabled;
  end;
end;

procedure TMainFormPanelController.SetCantainerPanelVisible(Sender: TObject);
begin
  FForm.ContainerPanelVisibleChange.Checked := not FForm.ContainerPanelVisibleChange.Checked;
  if FForm.ContainerPanelVisibleChange.Checked then HideAndShow
    else begin
      FForm.pnContainer.Visible := False;
      FForm.spOrder.Visible := False;
      Self.SetAlign;
    end;
  SetActionEnabled;
end;

procedure TMainFormPanelController.SetOrderPanelVisible(Sender: TObject);
begin
  FForm.OrderPanelVisibleChange.Checked := not FForm.OrderPanelVisibleChange.Checked;
  if FForm.OrderPanelVisibleChange.Checked then HideAndShow
    else begin
      FForm.pnOrder.Visible := False;
      FForm.spOrder.Visible := False;
      Self.SetAlign;
    end;
  SetActionEnabled;
end;

procedure TMainFormPanelController.SetParttPanelVisible(Sender: TObject);
begin
  FForm.PartPanelVisibleChange.Checked := not FForm.PartPanelVisibleChange.Checked;
  if FForm.PartPanelVisibleChange.Checked then HideAndShow
    else begin
      FForm.pnPart.Visible := False;
      FForm.spPart.Visible := False;
      Self.SetAlign;
    end;
  SetActionEnabled;
end;

end.
