unit DragObjectCls;

interface

uses
  Controls, OrderCls, OrderItemCls;

type
  TOrderDragObject = class(TDragObjectEx)
  private
    FOrder: TOrder;
    FItem: TOrderItem;
  public
    constructor Create(Order: TOrder; Item: TOrderItem);
    destructor Destroy; override;
    property Order: TOrder read FOrder;
    property Item: TOrderItem read FItem;
  end;

implementation

uses
  Dialogs, SysUtils;

constructor TOrderDragObject.Create(Order: TOrder; Item: TOrderItem);
begin
  inherited Create;
  FOrder := Order;
  FItem := Item;
end;

destructor TOrderDragObject.Destroy;
begin
  inherited Destroy;
end;

end.
