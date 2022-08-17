unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fLogin, Vcl.ExtCtrls, fCategory, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Comp.UI,
  FireDAC.Phys.SQLite;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    procedure loginCall;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uDataBaseConnection;

{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  loginCall;
end;

procedure TfrmMain.loginCall;
var
  lform: TFrmLogin;
begin
  lform := TfrmLogin.Create(nil);
  try
    lform.ShowModal;
  finally
    lform.Free;
  end;
end;

procedure TfrmMain.Panel1Click(Sender: TObject);
var lForm: TFrmCategory;
begin
  lForm := TfrmCategory.Create(Self);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;
end;

end.
