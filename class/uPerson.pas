unit uPerson;

interface

type TTypePerson = (tpProvider, tpCustomer);

type TPerson = class
  private
    FId: string;
    FTypePerson: TTypePerson;
    FName: string;
    FPhone: string;
    FEmail: string;
    FAdress: string;
    FNumber: string;
    FDistrict: string;
    FIdCity: string;

  public
    property Id: string read FId write FId;
    property TypePerson: TTypePerson read FTypePerson write FTypePerson;
    property Name: string read FName write FName;
    property Phone: string read FPhone write FPhone;
    property Email: string read FEmail write FEmail;
    property Adress: string read FAdress write FAdress;
    property Number: string read FNumber write FNumber;
    property District: string read FDistrict write FDistrict;
    property IdCity: string read FIdCity write FIdCity;
end;

implementation

end.
