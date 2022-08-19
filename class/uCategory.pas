unit uCategory;

interface

uses
  uCrudInterface, uDataBaseConnection, System.SysUtils, Vcl.Dialogs,
  uAppConstants, uFunctions;

type TCategory = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
    function GetUniqueId: string;
    procedure SetUniqueId(const Value: string);
  public
   constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure Search(ADataSet: TMyQuery);
    destructor Destroy; override;

    property Id: Integer read FId write FId;
    property UniqueId: string read GetUniqueId write SetUniqueId;
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

function TCategory.GetUniqueId: string;
begin
  Result := FUniqueId;
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

procedure TCategory.Search(ADataSet: TMyQuery);
begin
  ADataSet.Close;
  ADataSet.SQL.Clear;
  ADataSet.SQL.Add('select UNIQUE_ID Unique_Id, NAME Name from category order by id desc');
  ADataSet.Open;
end;

procedure TCategory.SetUniqueId(const Value: string);
begin
  FUniqueId := TFunctions.GenerateUUID;
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
