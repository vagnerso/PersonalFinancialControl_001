unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TfrmLogin = class(TfrmBase)
    pnlDetail: TPanel;
    pnlLogin: TPanel;
    lb1: TLabel;
    lblUser: TLabel;
    lblPassword: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    imIconApp: TImage;
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
