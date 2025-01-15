unit PartControllerCls;

interface

uses
  DocumentCls, OrderCls;

type
  TOnChangeModel = procedure (Sender: TObject; UpdateInterface: boolean) of object;

  TPartController = class(TObject)
  private
    FDocument: TDocument;
    FOnChangeModel: TOnChangeModel;
    procedure ChangeModelEvent(UpdateInterface: boolean);
    procedure RefreshAllGrids;
  public
    constructor Create(Document: TDocument);
    procedure PartNewExecute(Sender: TObject);
    procedure PartEditExecute(Sender: TObject);
    procedure PartCopyExecute(Sender: TObject);
    procedure PartDeleteExecute(Sender: TObject);
    procedure PartSearchExecute(Sender: TObject);
    procedure PartListUpdate(Sender: TObject);
    property OnChangeModel: TOnChangeModel read FOnChangeModel
      write FOnChangeModel;
  end;

implementation

uses
  Dialogs, OrdersForm, InputForm, TranslatorCls, PartListUpdateForm,
  GlobalSettingsCls, DocLoaderCls, SysUtils, SelectOrdersForm, Controls,
  BoxForm, ContainerForm, PartEditorForm, PartPropertyForm, InvoiceForm,
  OrderItemCls, SearchForm, PartListCls;

constructor TPartController.Create(Document: TDocument);
begin
  inherited Create;
  FDocument := Document;
end;

procedure TPartController.RefreshAllGrids;
begin
  frmOrders.RefreshGrid(Self);
  frmPartProperty.RefreshGrid(Self);
  frmBox.RefreshData(Self);
  frmContainers.RefreshGrid(Self);
  frmInvoice.RefreshGrid(Self);
end;

procedure TPartController.ChangeModelEvent(UpdateInterface: boolean);
begin
  if Assigned(Self.FOnChangeModel) then
    Self.FOnChangeModel(Self, UpdateInterface);
end;

// Actions

procedure TPartController.PartNewExecute(Sender: TObject);
var
  LastOrderItem: TOrderItem;
  Msg: string;
begin
  LastOrderItem := frmPartEditor.AddPart(Self.FDocument);
  if LastOrderItem <> nil then begin
    RefreshAllGrids;
    Msg := Translator.GetInstance.TranslateMessage(
      28, 'Показать деталь в последнем заказе') + ' ?';
    if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      frmOrders.ShowOrderItem(LastOrderItem);
    Self.ChangeModelEvent(True);
  end;
end;

procedure TPartController.PartEditExecute(Sender: TObject);
begin
  if frmPartProperty.Part = nil then Exit;
  if frmPartEditor.EditPart(frmPartProperty.Part, Self.FDocument) <> nil then begin
    Self.RefreshAllGrids;
    Self.ChangeModelEvent(False);
  end;
end;

procedure TPartController.PartCopyExecute(Sender: TObject);
var
  LastOrderItem: TOrderItem;
  Msg: string;
begin
  LastOrderItem := frmPartEditor.CopyPart(frmPartProperty.Part, FDocument);
  if LastOrderItem <> nil then begin
    RefreshAllGrids;
    Msg := Translator.GetInstance.TranslateMessage(
      28, 'Показать деталь в последнем заказе') + ' ?';
    if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      frmOrders.ShowOrderItem(LastOrderItem);
    Self.ChangeModelEvent(True);
  end;
end;

procedure TPartController.PartDeleteExecute(Sender: TObject);
var
  Text: string;
  OrderInd, OrderItenInd: integer;
  Order: TOrder;
  OrderItem: TOrderItem;
begin
  if frmPartProperty.Part = nil then Exit;
  Text := Translator.GetInstance.TranslateMessage(
    29, 'Вы действительно хотите удалить деталь')
    + ' "' + frmPartProperty.Part.GetTranslatedTitle(
      GlobalSettings.GetInstance.Language) + '" ?'
    + chr(13) + Translator.GetInstance.TranslateMessage(
    30, 'Эта деталь будет удалена из всех заказов и выгружена из всех коробок !');
  if MessageDlg(Text, mtConfirmation, [mbYes, mbCancel], 0) = mrYes then begin
    for OrderInd := 0 to FDocument.Orders.Count - 1 do begin
      Order := FDocument.Orders.Items[OrderInd];
      OrderItenInd := 0;
      while (OrderItenInd < Order.Count) do begin
        OrderItem := Order.Items[OrderItenInd];
        if OrderItem.Part = frmPartProperty.Part then begin
          FDocument.Containers.ExtractOrderItem(Order, OrderItem);
          frmBox.ExtractOrderItem(Order, OrderItem);
          Order.Extract(OrderItem);
          OrderItem.Free;
        end else inc(OrderItenInd);
      end;
    end;
    FDocument.Parts.Extract(frmPartProperty.Part);
    frmPartProperty.Part.Free;
    if FDocument.Parts.Count > 0 then
        frmPartProperty.Part := FDocument.Parts.Items[0]
      else frmPartProperty.Part := nil;
    Self.RefreshAllGrids;
    Self.ChangeModelEvent(True);
  end;
end;

procedure TPartController.PartSearchExecute(Sender: TObject);
begin
  if frmPartProperty.Part = nil then Exit;
  frmSearch.SearchPart(frmPartProperty.Part);
end;

procedure TPartController.PartListUpdate(Sender: TObject);
var
  NewPart: TPartList;
  Loader: TDocLoader;
  OpenDlg: TOpenDialog;
begin
  if FDocument.Parts.Count = 0 then Exit;
  OpenDlg := TOpenDialog.Create(nil);
  OpenDlg.Title := Translator.GetInstance.TranslateMessage(
    17, 'Выбор файла 1C');
  OpenDlg.Filter := 'Text files|*.txt';
  if not OpenDlg.Execute then Exit;
  NewPart := TPartList.Create;
  Loader := TDocLoader.Create(OpenDlg.FileName);
  Loader.GetPartListFrom1CFile(NewPart);
  if frmPartListUpdate.UpdatePaerts(ExtractFileName(OpenDlg.FileName),
      FDocument.Parts, NewPart) then begin
    Self.RefreshAllGrids;
    Self.ChangeModelEvent(False);
  end;
  OpenDlg.Free;
  NewPart.Free;
  Loader.Free;
end;

end.
