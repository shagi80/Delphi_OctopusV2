unit BoxItemCls;

interface

uses
  OrderItemCls, PartCls, OrderCls;

type

  {  ласс единичной записи в коробке.
     ласс обеспечивает хранение ссылки на экземпл€р TPart (деталь)
    TOrder (заказ) и количество деаталей в коробке. }

  TBoxItem = class(TOrderItem)
  private
    FOrder: TOrder;
  public
    constructor Create(order: TOrder; part: TPart);
    destructor Destroy; override;
    property Order: TOrder read FOrder write FOrder;
  end;

implementation

constructor TBoxItem.Create(order: TOrder; part: TPart);
begin
  inherited Create(part);
  FOrder := order;
end;

destructor TboxItem.Destroy;
begin
  inherited Destroy;
end;

end.
