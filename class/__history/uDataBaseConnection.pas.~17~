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
  System.SysUtils,
  uFunctions,
  uAppConstants,
  Vcl.Dialogs,
  FireDAC.Phys.SQLite, System.Classes;

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
var
  FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
begin
    FDPhysSQLiteDriverLink := TFDPhysSQLiteDriverLink.Create(nil);
    FConnection.Params.DriverID := 'SQLITE';
    FConnection.DriverName := 'SQLITE';
    FConnection.Params.Database := TFunctions.DataBasePath + DATABASE_NAME;

    try

      FConnection.Connected := True;

    except on e: Exception do
      begin
        showmessage('Erro ao tentar conectar no banco de dados.');
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
  FDPhysSQLiteDriverLink := TFDPhysSQLiteDriverLink.Create(nil);
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
