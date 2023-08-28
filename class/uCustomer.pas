unit uCustomer;

interface

uses
  uPerson,
  uEnumTypes;

type TCustomer = class(TPerson)
  private

  public
    procedure Clear; override;
    constructor Create;
end;

implementation

{ TProvider }

procedure TCustomer.Clear;
begin
  inherited;
  FTypePerson:= tpCustomer;
end;

constructor TCustomer.Create;
begin
  inherited;
  TypePerson := tpCustomer;

end;

end.
