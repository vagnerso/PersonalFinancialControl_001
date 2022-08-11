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
    lblTitle: TLabel;
    lblDeveloper: TLabel;
    pnlButtonConfirm: TPanel;
    pnlButtonCancel: TPanel;
    procedure pnlButtonCancelClick(Sender: TObject);
    procedure pnlButtonConfirmClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

procedure TfrmLogin.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmLogin.pnlButtonConfirmClick(Sender: TObject);
begin
  inherited;

  if (edtUser.Text = 'admin') and (edtPassword.Text = 'admin') then
  begin
    ModalResult := mrOk;
  end
  else
  begin
    ShowMessage('Aten��o! Usu�rio e/ou senha inv�lidos. Por gentileza verifique e tente novamente.');
  end;
end;

end.
