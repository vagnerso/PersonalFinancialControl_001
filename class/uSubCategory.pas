unit uSubCategory;

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

type TSubCategory = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;
    FIdCategory: integer;
  public
    constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure GetById;
    procedure Search(ADataSet: TMyQuery);
    destructor Destroy; override;

    property SearchFiltersCustomized: TSearchFiltersCustomized read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: Integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;
    property IdCategory: integer read FIdCategory write FIdCategory;

end;

implementation

{ TSubCategory }

procedure TSubCategory.Clear;
begin
  FUniqueId := EmptyStr;
  FName := EmptyStr;
  FIdCategory := 0;
end;

constructor TSubCategory.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
end;

procedure TSubCategory.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM SUB_CATEGORY     ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_SUB_CATEGORY_DELETE);
    end;
  end;
end;

destructor TSubCategory.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TSubCategory.GetById;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('SELECT              ');
    FDataSet.SQL.Add('   ID               ');
    FDataSet.SQL.Add(' , UNIQUE_ID        ');
    FDataSet.SQL.Add(' , NAME             ');
    FDataSet.SQL.Add(' , ID_CATEGORY      ');
    FDataSet.SQL.Add(' FROM SUB_CATEGORY  ');
    FDataSet.SQL.Add('WHERE ID = :ID      ');
    FDataSet.ParamByName('ID').AsInteger := FId;
    FDataSet.Open;

    if not (FDataSet.IsEmpty) then
    begin
      FId := FDataSet.FieldByName('ID').AsInteger;
      FUniqueId := FDataSet.FieldByName('UNIQUE_ID').AsString;
      FName := FDataSet.FieldByName('NAME').AsString;
      FIdCategory := FDataSet.FieldByName('ID_CATEGORY').AsInteger;
    end;

  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_SUB_CATEGORY_INSERT);
    end;
  end;
end;

procedure TSubCategory.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO SUB_CATEGORY (  ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' , ID_CATEGORY          ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' , :ID_CATEGORY         ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('ID_CATEGORY').AsInteger := FIdCategory;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_SUB_CATEGORY_INSERT);
    end;
  end;
end;

procedure TSubCategory.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT            ');
    lSQL.Add('    UNIQUE_ID     ');
    lSQL.Add('  , NAME "Nome"   ');
    lSQL.Add('  , ID_CATEGORY "Categoria"   ');
    lSQL.Add('FROM SUB_CATEGORY    ');

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

procedure TSubCategory.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE SUB_CATEGORY SET      ');
    FDataSet.SQL.Add(' NAME        = :NAME         ');
    FDataSet.SQL.Add(' ID_CATEGORY = :ID_CATEGORY  ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ParamByName('ID_CATEGORY').AsInteger := FIdCategory;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_SUB_CATEGORY_INSERT);
    end;
  end;
end;

end.
