unit uCategory;

interface

uses
  uCrudInterface, uDataBaseConnection, System.SysUtils, Vcl.Dialogs;

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
    destructor Destroy; override;

    property Id: Integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property Name: string read FName write FName;

end;

implementation

{ TCategory }

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
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO CATEGORY (  ');
    FDataSet.SQL.Add('   UNIQUE_ID            ');
    FDataSet.SQL.Add(' , NAME                 ');
    FDataSet.SQL.Add(' ) VALUES (             ');
    FDataSet.SQL.Add('   :UNIQUE_ID           ');
    FDataSet.SQL.Add(' , :NAME                ');
    FDataSet.SQL.Add(' )                      ');
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage('Erro ao incluir categoria');
    end;
  end;
end;

procedure TCategory.UpdateRegister;
begin

end;

end.
