unit OrderItemCls;

interface

uses
  PartCls;

type

  //����� ��������� ������ � ������.
  //����� ������������ �������� ������ �� ��������� TPart (������)
  //� ���������� ��������
  
  TOrderItem = class(TObject)
  private
    FPart: TPart;
    FOrderCount: real;
  public
    constructor Create(part: TPart);
    destructor Destroy; override;
    property Part: TPart read FPart write FPart;
    property OrderCount: real read FOrderCount write FOrderCount;
  end;

implementation

constructor TOrderItem.Create(part: TPart);
begin
  inherited Create;
  FPart := part;
end;

destructor TOrderItem.Destroy;
begin
  inherited Destroy;
end;

end.
