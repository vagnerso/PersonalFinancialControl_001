unit uUser;

interface

uses
  uCrudInterface,
  uDataBaseConnection,
  System.SysUtils,
  Vcl.Dialogs,
  uAppConstants,
  uFunctions,
  uSearchFilters,
  System.Classes;

type TSearchFiltersCustomized = class(TSearchFilters)
  private

  public
end;

type TUser = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: String;
    FName: string;
    FLogin: string;
    FPassword: string;
    FDataSet: TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;

  public

    constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure GetById;
    procedure Search(ADataSet: TMyQuery);
    destructor Destroy; override;

    property DataSet: TMyQuery read FDataSet write FDataSet;
    property SearchFiltersCustomized: TSearchFiltersCustomized read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: Integer read FId write FId;
    property UniqueId: String read FUniqueId write FUniqueId;
    property Name: string read FName write FName;
    property Login: string read FLogin write FLogin;
    property Password: string read FPassword write FPassword;
end;

implementation

{ TUser }

procedure TUser.Clear;
begin
  FId       := 0;
  FUniqueId := EmptyStr;
  FName     := EmptyStr;
  FLogin    := EmptyStr;
  FPassword := EmptyStr;
end;

constructor TUser.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
end;

procedure TUser.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM USER             ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_USER_DELETE);
    end;
  end;
end;

destructor TUser.Destroy;
begin
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TUser.GetById;
var
  lQuery: TMyQuery;
begin

  lQuery  := TMyQuery.Create(nil);
  try

    try
      TDataBaseConnection.GetInstance.NewConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('SELECT          ');
      lQuery.SQL.Add('   ID           ');
      lQuery.SQL.Add(' , UNIQUE_ID    ');
      lQuery.SQL.Add(' , NAME         ');
      lQuery.SQL.Add(' , LOGIN        ');
      lQuery.SQL.Add(' , PASSWORD     ');
      lQuery.SQL.Add(' FROM USER      ');
      lQuery.SQL.Add('WHERE ID = :ID  ');
      lQuery.ParamByName('ID').AsInteger := FId;
      lQuery.Open;

      if not (lQuery.IsEmpty) then
      begin
        FId := lQuery.FieldByName('ID').AsInteger;
        FUniqueId := lQuery.FieldByName('UNIQUE_ID').AsString;
        FName := lQuery.FieldByName('NAME').AsString;
        FLogin := lQuery.FieldByName('LOGIN').AsString;
        FPassword := lQuery.FieldByName('PASSWORD').AsString;
      end;

    except on E: Exception do
      begin
        lQuery.Connection.Rollback;
        Showmessage(MSG_ERROR_USER_INSERT);
      end;
    end;

  finally
    lQuery.Free;
  end;
end;

procedure TUser.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO USER (      ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' , LOGIN                ');
    FDataSet.SQL.Add(' , PASSWORD             ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' , :LOGIN               ');
    FDataSet.SQL.Add(' , :PASSWORD            ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('LOGIN').AsString := FLogin;
    FDataSet.ParamByName('PASSWORD').AsString := FPassword;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_USER_INSERT);
    end;
  end;
end;

procedure TUser.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT                ');
    lSQL.Add('    ID                ');
    lSQL.Add('  , UNIQUE_ID         ');
    lSQL.Add('  , NAME      "Nome"  ');
    lSQL.Add('  , LOGIN     "Login" ');
    lSQL.Add('  , PASSWORD  "Senha" ');
    lSQL.Add('FROM USER             ');

    if (Length(Trim(FSearchFiltersCustomized.ValueSearch)) > 0) then
    begin
      lSQL.Add('WHERE NAME LIKE ' + QuotedStr('%' + FSearchFiltersCustomized.ValueSearch + '%'));
    end;

    lSQL.Add('ORDER BY NAME DESC   ');

    ADataSet.Close;
    ADataSet.SQL.Clear;
    ADataSet.SQL.Add(lSQL.Text);
    ADataSet.Open;

  finally
    lSQL.Free;
  end;

end;

procedure TUser.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE USER SET              ');
    FDataSet.SQL.Add('   NAME      = :NAME         ');
    FDataSet.SQL.Add(' , LOGIN     = :LOGIN        ');
    FDataSet.SQL.Add(' , PASSWORD  = :PASSWORD     ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('LOGIN').AsString := FLogin;
    FDataSet.ParamByName('PASSWORD').AsString := FPassword;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_USER_INSERT);
    end;
  end;
end;

end.
