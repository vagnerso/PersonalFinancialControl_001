unit uCity;

interface

uses
  uCrudInterface,
  uDataBaseConnection,
  System.SysUtils,
  Vcl.Dialogs,
  uAppConstants,
  uFunctions,
  uSearchFilters,
  System.Classes,
  fMessage,
  uEnumTypes;

type TSearchFiltersCustomized = class(TSearchFilters)
  private

  public
end;

type TCity = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;
    FSefazCode: Integer;
    FUF: string;
    FIdUser: Integer;
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
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;
    property SefazCode: Integer read FSefazCode write FSefazCode;
    property UF: string read FUF write FUF;
    property IdUser: Integer read FIdUser write FIdUser;

end;


implementation

uses
  uSystemManager;

{ TCity }

procedure TCity.Clear;
begin
  FId        := 0;
  FUniqueId  := EmptyStr;
  FName      := EmptyStr;
  FSefazCode := 0;
  FUF        := EmptyStr;
  FIdUser    := 0;
end;

constructor TCity.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
end;

procedure TCity.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM CITY             ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CITY_DELETE);
    end;
  end;
end;

destructor TCity.Destroy;
begin
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TCity.GetById;
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
      lQuery.SQL.Add(' , SEFAZ_CODE   ');
      lQuery.SQL.Add(' , UF           ');
      lQuery.SQL.Add(' FROM CITY      ');
      lQuery.SQL.Add('WHERE ID = :ID  ');
      lQuery.ParamByName('ID').AsInteger := FId;
      lQuery.Open;

      if not (lQuery.IsEmpty) then
      begin
        FId := lQuery.FieldByName('ID').AsInteger;
        FUniqueId := lQuery.FieldByName('UNIQUE_ID').AsString;
        FName := lQuery.FieldByName('NAME').AsString;
        FSefazCode := lQuery.FieldByName('SEFAZ_CODE').AsInteger;
        FUF := lQuery.FieldByName('UF').AsString;
      end;

    except on E: Exception do
      begin
        lQuery.Connection.Rollback;
        TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CITY_SEARCH);
      end;
    end;

  finally
    lQuery.Free;
  end;
end;

procedure TCity.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO CITY (      ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' , SEFAZ_CODE           ');
    FDataSet.SQL.Add(' , UF                   ');
    FDataSet.SQL.Add(' , ID_USER              ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' , :SEFAZ_CODE          ');
    FDataSet.SQL.Add(' , :UF                  ');
    FDataSet.SQL.Add(' , :ID_USER             ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('SEFAZ_CODE').AsInteger := FSefazCode;
    FDataSet.ParamByName('UF').AsString := FUF;
    FDataSet.ParamByName('ID_USER').AsInteger := TSystemManager.GetInstance.LoggedUser.Id;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CITY_INSERT);
    end;
  end;
end;

procedure TCity.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT           ');
    lSQL.Add('    ID           ');
    lSQL.Add('  , UNIQUE_ID    ');
    lSQL.Add('  , NAME "Nome"  ');
    lSQL.Add('  , SEFAZ_CODE "Cod. Cidade"  ');
    lSQL.Add('  , UF           ');
    lSQL.Add('FROM CITY        ');

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

procedure TCity.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE CITY SET              ');
    FDataSet.SQL.Add('   NAME       = :NAME        ');
    FDataSet.SQL.Add(' , SEFAZ_CODE = :SEFAZ_CODE  ');
    FDataSet.SQL.Add(' , UF         = :UF          ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('SEFAZ_CODE').AsInteger := FSefazCode;
    FDataSet.ParamByName('UF').AsString := FUF;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CITY_UPDATE);
    end;
  end;
end;

end.
