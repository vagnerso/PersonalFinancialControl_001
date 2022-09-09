unit uCategory;

interface

uses
  uCrudInterface,
  uDataBaseConnection,
  System.SysUtils,
  Vcl.Dialogs,
  uAppConstants,
  uFunctions,
  uSearchFilters, System.Classes;

type TSearchFiltersCustomized = class(TSearchFilters)
  private

  public
end;

type TCategory = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
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
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;

end;

implementation

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
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM CATEGORY         ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_CATEGORY_DELETE);
    end;
  end;
end;

destructor TCategory.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TCategory.GetById;
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
      lQuery.SQL.Add(' FROM CATEGORY  ');
      lQuery.SQL.Add('WHERE ID = :ID  ');
      lQuery.ParamByName('ID').AsInteger := FId;
      lQuery.Open;

      if not (lQuery.IsEmpty) then
      begin
        FId := lQuery.FieldByName('ID').AsInteger;
        FUniqueId := lQuery.FieldByName('UNIQUE_ID').AsString;
        FName := lQuery.FieldByName('NAME').AsString;
      end;

    except on E: Exception do
      begin
        lQuery.Connection.Rollback;
        Showmessage(MSG_ERROR_CATEGORY_INSERT);
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
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_CATEGORY_INSERT);
    end;
  end;
end;

procedure TCategory.Search(ADataSet: TMyQuery);
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
    lSQL.Add('FROM CATEGORY    ');

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
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_CATEGORY_INSERT);
    end;
  end;
end;

end.
