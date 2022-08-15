unit uSystemManager;

interface

uses
  uLayoutConfiguration, System.SysUtils;

type TSystemManager=class
  private
    class var FInstance: TSystemManager;
    class var FLayoutConfiguration : TLayoutConfiguration;
    constructor CreatePrivate;
    constructor Create;
  public

   destructor Destroy; override;
   class function GetInstance: TSystemManager;


   class property LayoutConfiguration: TLayoutConfiguration read FLayoutConfiguration write FLayoutConfiguration;
end;

implementation

{ TSystemManager }

constructor TSystemManager.Create;
begin
   raise Exception.Create('Para obter uma instância de TUsuario utilize TSystemManager.GetInstance !');
end;

constructor TSystemManager.CreatePrivate;
begin
  inherited
  Create;
  FLayoutConfiguration := TLayoutConfiguration.Create;
end;

destructor TSystemManager.Destroy;
begin

  inherited;
end;

class function TSystemManager.GetInstance: TSystemManager;
begin

  if not Assigned(FInstance) then
      FInstance := TSystemManager.CreatePrivate;
   Result := FInstance;
end;

end.
