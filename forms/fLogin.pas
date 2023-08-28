unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  uSystemManager, uUser, fMessage, uEnumTypes, uFunctions;

type
  TfrmLogin = class(TfrmBase)
    pnlCenter: TPanel;
    pnlDetail: TPanel;
    imIconApp: TImage;
    lblTitle: TLabel;
    lblDeveloper: TLabel;
    pnlLogin: TPanel;
    lb1: TLabel;
    lblUser: TLabel;
    lblPassword: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    pnlButtonConfirm: TPanel;
    pnlButtonCancel: TPanel;
    pnButtonUserRegister: TPanel;
    procedure pnlButtonCancelClick(Sender: TObject);
    procedure pnlButtonConfirmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnButtonUserRegisterClick(Sender: TObject);
    procedure pnlButtonConfirmMouseEnter(Sender: TObject);
    procedure pnlButtonConfirmMouseLeave(Sender: TObject);
    procedure pnlButtonConfirmEnter(Sender: TObject);
    procedure pnlButtonCancelEnter(Sender: TObject);
    procedure pnlButtonCancelMouseEnter(Sender: TObject);
    procedure pnButtonUserRegisterMouseEnter(Sender: TObject);
    procedure pnButtonUserRegisterEnter(Sender: TObject);
    procedure pnlButtonConfirmExit(Sender: TObject);
    procedure pnlButtonCancelExit(Sender: TObject);
    procedure pnlButtonCancelMouseLeave(Sender: TObject);
    procedure pnButtonUserRegisterExit(Sender: TObject);
    procedure pnButtonUserRegisterMouseLeave(Sender: TObject);
  private
    { Private declarations }
    FLoginColor: TColor;
    FActionButtonColor: TColor;
    FActionButtonFontColor: TColor;
    FHoverActionButtonColor: TColor;
    FHoverActionButtonFontColor: TColor;
    FBackgroundColor: TColor;
    procedure SetColors;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  fUser, fMain;

{$R *.dfm}

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := TWindowState.wsMaximized;
  SetColors;
  TFunctions.CenterPanel(self, pnlCenter);
end;

procedure TfrmLogin.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

procedure TfrmLogin.pnlButtonCancelEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonCancelExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonCancelMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonCancelMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonConfirmClick(Sender: TObject);
var
  User: TUser;
begin
  inherited;

  User := TUser.Create;
  try

    if User.ValidateLogin(edtUser.Text, edtPassword.Text) then
    begin
      frmMain.GetUserInfos;
      ModalResult := mrOk;
    end
    else
    begin
      TFrmMessage.ShowMessageBox(mtWarning, '', 'Atenção! Usuário e/ou senha inválidos. Por gentileza verifique e tente novamente.');
    end;

  finally
    User.Free;
  end;
end;

procedure TfrmLogin.pnlButtonConfirmEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonConfirmExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonConfirmMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnlButtonConfirmMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmLogin.SetColors;
begin
  FBackgroundColor := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  FLoginColor := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  FActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  FActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  FHoverActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor;
  FHoverActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor;
  lblTitle.Font.Color := FLoginColor;
  pnlLogin.Color := FBackgroundColor;
  edtUser.Font.Color := FLoginColor;
  edtPassword.Font.Color := FLoginColor;
  lblDeveloper.Font.Color := FLoginColor;
  pnlButtonConfirm.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  pnlButtonCancel.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  pnButtonUserRegister.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  pnlButtonConfirm.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  pnlButtonCancel.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  pnButtonUserRegister.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  color := TSystemManager.GetInstance.LayoutConfiguration.PopUpBackgroundColor;
end;

procedure TfrmLogin.pnButtonUserRegisterClick(Sender: TObject);
var
  lForm: TFrmUser;
begin
  lForm := TFrmUser.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;
end;

procedure TfrmLogin.pnButtonUserRegisterEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnButtonUserRegisterExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmLogin.pnButtonUserRegisterMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmLogin.pnButtonUserRegisterMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

end.
