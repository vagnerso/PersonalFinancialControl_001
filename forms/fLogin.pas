unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls;

type
  TfrmLogin = class(TfrmBase)
    pnlDetail: TPanel;
    pnlLogin: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

end.
