unit uCategory;

interface

uses
  uCrudInterface,
  uDataBaseConnection,
  System.SysUtils,
  Vcl.Dialogs,
  uAppConstants,

  uSearchFilters,
  System.Classes, fMessage, uEnumTypes, uFunctions;

type
  TSearchFiltersCustomized = class(TSearchFilters)
  private

  public
  end;

type
  TCategory = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet: TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;
    Fnome: string;
    procedure Somar;
    procedure Setnome(const Value: string);
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
    property SearchFiltersCustomized: TSearchFiltersCustomized
      read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: Integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;
    property nome: string read Fnome write Setnome;

  end;

implementation

uses
  uSystemManager;

{ TCategory }

procedure TCategory.Clear;
begin
  FUniqueId := EmptyStr;
  FName := EmptyStr;
end;

constructor TCategory.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
end;

procedure TCategory.DeleteRegister;
var
  MyElem: TObject;
begin
  try
    tdatabaseconnection.getinstance.newconnection;
    fdataset.close;
    fdataset.sql.clear;
    fdataset.sql.add('delete from category         ');
    fdataset.sql.add('where unique_id = :unique_id ');
    fdataset.parambyname('unique_id').asstring := funiqueid;
    fdataset.execsql;
    fdataset.connection.commit;
  except
    on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CATEGORY_DELETE);
    end;
  end;

  try


  except on E: Exception do
  end;

  for MyElem in MyList do
  begin

  end;


end;

destructor TCategory.Destroy;
begin
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TCategory.GetById;
var
  lQuery: TMyQuery;
begin

  lQuery := TMyQuery.Create(nil);
  try

    try
      TDataBaseConnection.GetInstance.NewConnection;
      lQuery.Close;
      lQuery.SQL.Clear;
      lQuery.SQL.Add('SELECT          ');
      lQuery.SQL.Add('   ID           ');
      lQuery.SQL.Add(' , UNIQUE_ID    ');
      lQuery.SQL.Add(' , NAME         ');
      lQuery.SQL.Add(' FROM CATEGORY  ');
      lQuery.SQL.Add('WHERE ID = :ID  ');
      lQuery.ParamByName('ID').AsInteger := FId;
      lQuery.Open;

      if not(lQuery.IsEmpty) then
      begin
        FId := lQuery.FieldByName('ID').AsInteger;
        FUniqueId := lQuery.FieldByName('UNIQUE_ID').AsString;
        FName := lQuery.FieldByName('NAME').AsString;
      end;

    except
      on E: Exception do
      begin
        lQuery.Connection.Rollback;
        TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CATEGORY_SEARCH);
      end;
    end;

  finally
    lQuery.Free;
  end;
end;

procedure TCategory.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO CATEGORY (  ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' , ID_USER              ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' , :ID_USER             ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('ID_USER').AsInteger :=
      TSystemManager.GetInstance.LoggedUser.Id;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except
    on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CATEGORY_INSERT);
    end;
  end;
end;

procedure TCategory.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDataBaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT           ');
    lSQL.Add('    ID           ');
    lSQL.Add('  , UNIQUE_ID    ');
    lSQL.Add('  , NAME "Nome"  ');
    lSQL.Add('FROM CATEGORY    ');

    if (Length(Trim(FSearchFiltersCustomized.ValueSearch)) > 0) then
    begin
      lSQL.Add('WHERE NAME LIKE ' +
        QuotedStr('%' + FSearchFiltersCustomized.ValueSearch + '%'));
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

procedure TCategory.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TCategory.Somar;
begin

end;

procedure TCategory.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE CATEGORY SET          ');
    FDataSet.SQL.Add(' NAME = :NAME                ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except
    on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_CATEGORY_UPDATE);
    end;
  end;
end;

end.
