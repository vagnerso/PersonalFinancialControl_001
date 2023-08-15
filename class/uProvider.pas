unit uProvider;

interface

uses
  uPerson;

type TProvider = class(TPerson)
  private

  public
    procedure Clear; override;
    constructor Create;
end;

implementation

{ TProvider }

procedure TProvider.Clear;
begin
  inherited;
  FTypePerson:= tpProvider;
end;

constructor TProvider.Create;
begin
  inherited;
  TypePerson := tpProvider;

end;

end.
