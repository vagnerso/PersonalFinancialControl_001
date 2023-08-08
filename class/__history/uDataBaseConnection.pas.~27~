unit uDataBaseConnection;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.dapt,
  FireDAC.Stan.Param,
  System.SysUtils,
  uFunctions,
  uAppConstants,
  Vcl.Dialogs,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Comp.UI,
  System.Classes, fMessage, uEnumTypes;

type TDataBaseConnection = class
  private
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FConnection: TFDConnection;

    class var FInstance: TDataBaseConnection;

    constructor CreatePrivate;
    constructor Create;
  public

    destructor Destroy;
    function NewConnection: Boolean;
    property Connection: TFDConnection read FConnection write FConnection;
    class function GetInstance: TDataBaseConnection ;
end;

type TMyQuery = class(TFDQuery)
  private

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

end;

implementation

{ TDataBaseConnection }

function TDataBaseConnection.NewConnection: Boolean;
begin

  Result := False;

  FConnection.DriverName := 'SQLite';
  FConnection.Params.Database := TFunctions.DataBasePath + DATABASE_NAME;

  try

    Result := FConnection.Connected;

  except on e: Exception do
    begin
      TFrmMessage.ShowMessageBox(mtError, '', 'Erro ao tentar conectar no banco de dados.');
    end;
  end;

end;

constructor TDataBaseConnection.Create;
begin
  raise Exception.Create('Para obter uma instância de TDataBaseConnection utilize TDataBaseConnection.GetInstance !');
end;

constructor TDataBaseConnection.CreatePrivate;
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';
  FDPhysSQLiteDriverLink := TFDPhysSQLiteDriverLink.Create(FConnection);
  FDPhysSQLiteDriverLink.DriverID := 'SQLite';
end;

destructor TDataBaseConnection.Destroy;
begin
  inherited;
  FDPhysSQLiteDriverLink.free;
  FConnection.Free;
end;

class function TDataBaseConnection.GetInstance: TDataBaseConnection;
begin
  if not Assigned(FInstance) then
      FInstance := TDataBaseConnection.CreatePrivate;
   Result := FInstance;
end;

constructor TMyQuery.Create(AOwner: TComponent);
begin
  inherited;
  Connection := TDataBaseConnection.GetInstance.Connection;
end;

destructor TMyQuery.Destroy;
begin

  inherited;
end;

end.
