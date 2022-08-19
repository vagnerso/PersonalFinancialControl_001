unit uCategory;

interface

uses
  uCrudInterface, uDataBaseConnection, System.SysUtils, Vcl.Dialogs,
  uAppConstants;

type TCategory = class(TInterfacedObject, ICrudInterface)
  private
    FId: Integer;
    FUniqueId: string;
    FName: string;
    FDataSet : TMyQuery;
  public
   constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure Search(ADataSet: TMyQuery);
    destructor Destroy; override;

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
end;

procedure TCategory.DeleteRegister;
begin

end;

destructor TCategory.Destroy;
begin
  FDataSet.Free;
  inherited;
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

procedure TCategory.UpdateRegister;
begin

end;

end.
