unit uDataBaseScripts;

interface

uses
  uDataBaseConnection;

type
  TDataBaseScripts = class
  private
    FScripts: TMyScript;
    FQuery: TMyQuery;

    function ColumnExists(ATable, AColumn: string): Boolean;
    function TableExists(ATable: string): Boolean;
  public

    procedure EmptyAllTables;
    procedure InsertAdminUser;
    procedure InsertDefaultTypePayments;
    procedure InsertDefaultCategories;
    procedure CreateCityTable;

    constructor Create;
    destructor Destroy; override;

    class function ExecuteScripts: Boolean;
  end;

implementation

uses
  uUser, uTypePayment, uFormPayment, uCategory, System.SysUtils;

{ TDataBaseScripts }

function TDataBaseScripts.ColumnExists(ATable, AColumn: string): Boolean;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT COUNT(*) AS CNTREC FROM pragma_table_info(:TABLE_NAME) WHERE name=:COLUMN)');
  FQuery.ParamByName('TABLE_NAME').AsString := ATable;
  FQuery.ParamByName('COLUMN').AsString := AColumn;
  FQuery.Open;

  Result := not FQuery.IsEmpty;
end;

constructor TDataBaseScripts.Create;
begin
  FScripts := TMyScript.Create(nil);
  FQuery := TMyQuery.Create(nil);
end;

procedure TDataBaseScripts.CreateCityTable;
var
  lSQL: string;
begin

  FScripts.SQLScripts.Clear;
  FScripts.SQLScripts.Add;

  lSQL := 'CREATE TABLE CITY(                             '+
	        'ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, '+
	        'UNIQUE_ID VARCHAR(200) NOT NULL,               '+
	        'NAME VARCHAR(300) NOT NULL,                    '+
          'SEFAZ_CODE INTEGER,                            '+
          'UF VARCHAR(2),                                 '+
          'ID_USER INTEGER);                              ';  
  FScripts.SQLScripts[0].SQL.Add(lSQL);

  lSQL := 'CREATE UNIQUE INDEX CITY_ID_IDX ON CITY (ID);  ';
  FScripts.SQLScripts[0].SQL.Add(lSQL);

  FScripts.ExecuteAll;
  FScripts.Connection.Commit;
end;

destructor TDataBaseScripts.Destroy;
begin
  FQuery.Free;
  FScripts.Free;
  inherited;
end;

procedure TDataBaseScripts.EmptyAllTables;
begin
  FScripts.SQLScripts.Clear;
  FScripts.SQLScripts.Add;

  FScripts.SQLScripts[0].SQL.Add('DELETE FROM MOVEMENT;');

  FScripts.SQLScripts[0].SQL.Add('DELETE FROM FORM_PAYMENT;');
  FScripts.SQLScripts[0].SQL.Add('DELETE FROM PERSON;');
  FScripts.SQLScripts[0].SQL.Add('DELETE FROM SUB_CATEGORY;');

  FScripts.SQLScripts[0].SQL.Add('DELETE FROM USER;');
  FScripts.SQLScripts[0].SQL.Add('DELETE FROM TYPE_PAYMENT;');
  FScripts.SQLScripts[0].SQL.Add('DELETE FROM CATEGORY;');


  FScripts.ExecuteAll;
end;

class function TDataBaseScripts.ExecuteScripts: Boolean;
var
  lDataBaseScripts: TDataBaseScripts;
begin
  Result := False;

  lDataBaseScripts := TDataBaseScripts.Create;
  try

    try

      TDataBaseConnection.GetInstance.NewConnection;

      if not (lDataBaseScripts.TableExists('CITY')) then
      begin
        lDataBaseScripts.CreateCityTable;
      end;

      Result := True;
      
    except on E: Exception do
    begin
      Result := False;
    end;
    end;     

  finally
    lDataBaseScripts.Free;
  end;

end;

procedure TDataBaseScripts.InsertAdminUser;
var
  lUser: TUser;
begin
  lUser := TUser.Create;
  try
    lUser.Clear;
    lUser.Name := 'Administrador';
    lUser.Login := 'admin';
    lUser.Password := 'admin';
    lUser.InsertRegister;
  finally
    lUser.Free;
  end;
end;

procedure TDataBaseScripts.InsertDefaultCategories;
var
  lCategory: TCategory;
begin
  lCategory := TCategory.Create;
  try
    lCategory.Clear;
    lCategory.Name := 'Salário';
    lCategory.InsertRegister;

    lCategory.Clear;
    lCategory.Name := 'Diversos';
    lCategory.InsertRegister;

  finally
    lCategory.Free;
  end;
end;

procedure TDataBaseScripts.InsertDefaultTypePayments;
var
  lTypePayment: TTypePayment;
begin
  lTypePayment := TTypePayment.Create;
  try
    lTypePayment.Clear;
    lTypePayment.Name := 'Dinheiro';
    lTypePayment.AllowsInstallment := False;
    lTypePayment.InsertRegister;

    lTypePayment.Clear;
    lTypePayment.Name := 'Cartão de Crédito';
    lTypePayment.AllowsInstallment := True;
    lTypePayment.InsertRegister;

    lTypePayment.Clear;
    lTypePayment.Name := 'Cartão de Débito';
    lTypePayment.AllowsInstallment := False;
    lTypePayment.InsertRegister;

    lTypePayment.Clear;
    lTypePayment.Name := 'Pix';
    lTypePayment.AllowsInstallment := False;
    lTypePayment.InsertRegister;

    lTypePayment.Clear;
    lTypePayment.Name := 'Vale';
    lTypePayment.AllowsInstallment := False;
    lTypePayment.InsertRegister;

  finally
    lTypePayment.Free;
  end;
end;

function TDataBaseScripts.TableExists(ATable: string): Boolean;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add('SELECT name FROM sqlite_master WHERE type=''table'' AND name=:TABLE_NAME;');
  FQuery.ParamByName('TABLE_NAME').AsString := ATable;
  FQuery.Open;

  Result := not FQuery.IsEmpty;
end;

end.
