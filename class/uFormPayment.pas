unit uFormPayment;

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

type TFormPayment = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
    FIdTypePayment: integer;
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

    property SearchFiltersCustomized: TSearchFiltersCustomized read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: Integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;
    property IdTypePayment: integer read FIdTypePayment write FIdTypePayment;

end;

implementation

{ TFormPayment }

procedure TFormPayment.Clear;
begin
  FUniqueId := EmptyStr;
  FName := EmptyStr;
end;

constructor TFormPayment.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
end;

procedure TFormPayment.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM FORM_PAYMENT     ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_FORM_PAYMENT_DELETE);
    end;
  end;
end;

destructor TFormPayment.Destroy;
begin
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TFormPayment.GetById;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('SELECT             ');
    FDataSet.SQL.Add('   ID              ');
    FDataSet.SQL.Add(' , UNIQUE_ID       ');
    FDataSet.SQL.Add(' , NAME            ');
    FDataSet.SQL.Add(' FROM FORM_PAYMENT ');
    FDataSet.SQL.Add('WHERE ID = :ID     ');
    FDataSet.ParamByName('ID').AsInteger := FId;
    FDataSet.Open;

    if not (FDataSet.IsEmpty) then
    begin
      FId := FDataSet.FieldByName('ID').AsInteger;
      FUniqueId := FDataSet.FieldByName('UNIQUE_ID').AsString;
      FName := FDataSet.FieldByName('NAME').AsString;
      FIdTypePayment := FDataSet.FieldByName('ID_TYPE_PAYMENT').AsInteger;
    end;

  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_FORM_PAYMENT_SEARCH);
    end;
  end;

end;

procedure TFormPayment.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO FORM_PAYMENT (  ');
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
      Showmessage(MSG_ERROR_FORM_PAYMENT_INSERT);
    end;
  end;
end;

procedure TFormPayment.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin
  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT                 ');
    lSQL.Add('   UNIQUE_ID           ');
    lSQL.Add(' , NAME Nome           ');
    lSQL.Add('FROM FORM_PAYMENT      ');

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

procedure TFormPayment.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE  SET                           ');
    FDataSet.SQL.Add('   NAME = :NAME                       ');
    FDataSet.SQL.Add(' , ID_TYPE_PAYMENT = :ID_TYPE_PAYMENT ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID          ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('ID_TYPE_PAYMENT').AsInteger := FIdTypePayment;
    FDataSet.ParamByName('NAME').AsString := FName;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_FORM_PAYMENT_INSERT);
    end;
  end;
end;

end.
