unit uPerson;

interface

uses
  uCrudInterface,
  uSearchFilters,
  uDataBaseConnection,
  System.SysUtils,
  uAppConstants,
  uFunctions,
  Vcl.Dialogs,
  System.Classes,
  uEnumTypes,
  fMessage, uCity;

type TSearchFiltersCustomized = class(TSearchFilters)
  private
    FTypePerson: TTypePerson;
  public
    property TypePerson: TTypePerson read FTypePerson write FTypePerson;
end;

type TPerson = class(TInterfacedObject, ICrudInterface)
  private

  protected
    FId: integer;
    FTypePerson: TTypePerson;
    FName: string;
    FPhone: string;
    FEmail: string;
    FAdress: string;
    FNumber: string;
    FDistrict: string;
    FCity: TCity;
    FDataSet : TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;
    FUniqueId: string;

  public
    constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear; virtual;
    procedure GetById;
    procedure Search(ADataSet: TMyQuery);
    destructor Destroy; override;

    property DataSet: TMyQuery read FDataSet write FDataSet;
    property SearchFiltersCustomized: TSearchFiltersCustomized read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property TypePerson: TTypePerson read FTypePerson write FTypePerson;
    property Name: string read FName write FName;
    property Phone: string read FPhone write FPhone;
    property Email: string read FEmail write FEmail;
    property Adress: string read FAdress write FAdress;
    property Number: string read FNumber write FNumber;
    property District: string read FDistrict write FDistrict;
    property City: TCity read FCity write FCity;

end;

implementation

uses
  uSystemManager;

{ TPerson }

procedure TPerson.Clear;
begin
  FId         := 0;
  FName       := EmptyStr;
  FPhone      := EmptyStr;
  FEmail      := EmptyStr;
  FAdress     := EmptyStr;
  FNumber     := EmptyStr;
  FDistrict   := EmptyStr;
  FCity.Clear;
  FUniqueId   := EmptyStr;
end;

constructor TPerson.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
  FCity := TCity.Create;
end;

procedure TPerson.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM PERSON         ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      //Showmessage(MSG_ERROR__DELETE);
    end;
  end;

end;

destructor TPerson.Destroy;
begin
  FCity.Free;
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TPerson.GetById;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('SELECT          ');
    FDataSet.SQL.Add('   ID           ');
    FDataSet.SQL.Add(' , UNIQUE_ID    ');
    FDataSet.SQL.Add(' , NAME         ');
    FDataSet.SQL.Add(' , TYPE_PERSON  ');
    FDataSet.SQL.Add(' , PHONE        ');
    FDataSet.SQL.Add(' , EMAIL        ');
    FDataSet.SQL.Add(' , ADRESS       ');
    FDataSet.SQL.Add(' , NUMBER       ');
    FDataSet.SQL.Add(' , DISTRICT     ');
    FDataSet.SQL.Add(' , ID_CITY      ');
    FDataSet.SQL.Add(' FROM PERSON    ');
    FDataSet.SQL.Add('WHERE ID = :ID  ');
    FDataSet.ParamByName('ID').AsInteger := FId;
    FDataSet.Open;

    if not (FDataSet.IsEmpty) then
    begin
      FId := FDataSet.FieldByName('ID').AsInteger;
      FUniqueId := FDataSet.FieldByName('UNIQUE_ID').AsString;
      FName := FDataSet.FieldByName('NAME').AsString;
      FTypePerson := TTypePerson(FDataSet.FieldByName('TYPE_PERSON').AsInteger);
      FPhone := FDataSet.FieldByName('PHONE').AsString;
      FEmail := FDataSet.FieldByName('EMAIL').AsString;
      FAdress := FDataSet.FieldByName('ADRESS').AsString;
      FNumber := FDataSet.FieldByName('NUMBER').AsString;
      FDistrict := FDataSet.FieldByName('DISTRICT').AsString;
      FCity.Id := FDataSet.FieldByName('ID_CITY').AsInteger;
      FCity.GetById;
    end;

  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_PROVIDER_SEARCH);
    end;
  end;

end;

procedure TPerson.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO PERSON (    ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' , TYPE_PERSON          ');
    FDataSet.SQL.Add(' , PHONE                ');
    FDataSet.SQL.Add(' , EMAIL                ');
    FDataSet.SQL.Add(' , ADRESS               ');
    FDataSet.SQL.Add(' , NUMBER               ');
    FDataSet.SQL.Add(' , DISTRICT             ');
    FDataSet.SQL.Add(' , ID_CITY              ');
    FDataSet.SQL.Add(' , ID_USER              ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' , :TYPE_PERSON         ');
    FDataSet.SQL.Add(' , :PHONE               ');
    FDataSet.SQL.Add(' , :EMAIL               ');
    FDataSet.SQL.Add(' , :ADRESS              ');
    FDataSet.SQL.Add(' , :NUMBER              ');
    FDataSet.SQL.Add(' , :DISTRICT            ');
    FDataSet.SQL.Add(' , :ID_CITY             ');
    FDataSet.SQL.Add(' , :ID_USER             ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('TYPE_PERSON').AsInteger := Integer(FTypePerson);
    FDataSet.ParamByName('PHONE').AsString := FPhone ;
    FDataSet.ParamByName('EMAIL').AsString := FEmail ;
    FDataSet.ParamByName('ADRESS').AsString := FAdress ;
    FDataSet.ParamByName('NUMBER').AsString := FNumber ;
    FDataSet.ParamByName('DISTRICT').AsString := FDistrict ;
    FDataSet.ParamByName('ID_CITY').AsInteger := FCity.Id;
    FDataSet.ParamByName('ID_USER').AsInteger := TSystemManager.GetInstance.LoggedUser.Id;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      //Showmessage(MSG_ERROR_PERSON_INSERT);
    end;
  end;

end;

procedure TPerson.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT                         ');
    lSQL.Add('   P.ID                        ');
    lSQL.Add(' , P.UNIQUE_ID                 ');
    lSQL.Add(' , P.NAME        "Nome"        ');
    lSQL.Add(' , P.TYPE_PERSON "Tipo"        ');
    lSQL.Add(' , P.PHONE       "Fone"        ');
    lSQL.Add(' , P.EMAIL       "E-Mail"      ');
    lSQL.Add(' , P.ADRESS      "Endereço"    ');
    lSQL.Add(' , P.NUMBER      "Número"      ');
    lSQL.Add(' , P.DISTRICT    "Bairro"      ');
    lSQL.Add(' , P.ID_CITY     "Cidade"      ');
    lSQL.Add(' , C.NAME        "Nome Cidade" ');
    lSQL.Add('FROM PERSON P                  ');
    lSQL.Add(' INNER JOIN CITY C             ');
    lSQL.Add(' ON C.ID = P.ID_CITY           ');
    lSQL.Add('WHERE 1>0                      ');

    lSQL.Add('AND P.TYPE_PERSON = ' + (Integer(FSearchFiltersCustomized.TypePerson)).ToString);

    if (Length(Trim(FSearchFiltersCustomized.ValueSearch)) > 0) then
    begin
      lSQL.Add('AND P.NAME LIKE ' + QuotedStr('%' + FSearchFiltersCustomized.ValueSearch + '%'));
    end;

    lSQL.Add('ORDER BY P.NAME DESC   ');

    ADataSet.Close;
    ADataSet.SQL.Clear;
    ADataSet.SQL.Add(lSQL.Text);
    ADataSet.Open;

  finally
    lSQL.Free;
  end;


end;

procedure TPerson.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE PERSON SET               ');
    FDataSet.SQL.Add('   NAME         = :NAME         ');
    FDataSet.SQL.Add(' , TYPE_PERSON  = :TYPE_PERSON  ');
    FDataSet.SQL.Add(' , PHONE        = :PHONE        ');
    FDataSet.SQL.Add(' , EMAIL        = :EMAIL        ');
    FDataSet.SQL.Add(' , ADRESS       = :ADRESS       ');
    FDataSet.SQL.Add(' , NUMBER       = :NUMBER       ');
    FDataSet.SQL.Add(' , DISTRICT     = :DISTRICT     ');
    FDataSet.SQL.Add(' , ID_CITY      = :ID_CITY      ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID    ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('TYPE_PERSON').AsInteger := Integer(FTypePerson);
    FDataSet.ParamByName('PHONE').AsString := FPhone;
    FDataSet.ParamByName('EMAIL').AsString := FEmail;
    FDataSet.ParamByName('ADRESS').AsString := FAdress;
    FDataSet.ParamByName('NUMBER').AsString := FNumber;
    FDataSet.ParamByName('DISTRICT').AsString := FDistrict;
    FDataSet.ParamByName('ID_CITY').AsInteger := FCity.Id;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      //Showmessage(MSG_ERROR_PERSON_INSERT);
    end;
  end;

end;

end.
