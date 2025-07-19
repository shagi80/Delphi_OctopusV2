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
    FTotalCost: real;
  public
    constructor Create(order: TOrder; part: TPart);
    destructor Destroy; override;
    property Order: TOrder read FOrder write FOrder;
    property TotalCost: real read FTotalCost write FTotalCost;
  end;

implementation

constructor TBoxItem.Create(order: TOrder; part: TPart);
begin
  inherited Create(part);
  FOrder := order;
  FTotalCost := 0;
end;

destructor TboxItem.Destroy;
begin
  inherited Destroy;
end;

end.
