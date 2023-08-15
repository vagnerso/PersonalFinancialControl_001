unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fLogin, Vcl.ExtCtrls, fCategory, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  fTypePayment, uSystemManager, fFormPayment, fSubCategory, fMovement,
  fProvider, fImport, uEnumTypes, fManageMovements, fMovementGraphics,
  fUtilities;

type
  TfrmMain = class(TForm)
    pnlDetail: TPanel;
    imIconApp: TImage;
    lblTitle: TLabel;
    lbUser: TLabel;
    imUser: TImage;
    lblDeveloper: TLabel;
    pnMenus: TPanel;
    pnlMenuCategory: TPanel;
    pnlMenuSubCategory: TPanel;
    pnlMenuRevenues: TPanel;
    pnlMenuFormPayment: TPanel;
    pnlMenuTypePayment: TPanel;
    pnlMenuExpenses: TPanel;
    pnlMenuProvider: TPanel;
    btImport: TButton;
    pnButtonManageMovements: TPanel;
    pnlButtonMovementReports: TPanel;
    pnButtonMovementGraphics: TPanel;
    pnlSettings: TPanel;
    imgButtonUtilities: TImage;
    procedure FormShow(Sender: TObject);
    procedure pnlMenuCategoryClick(Sender: TObject);
    procedure pnlMenuTypePaymentClick(Sender: TObject);
    procedure pnlMenuFormPaymentClick(Sender: TObject);
    procedure pnlMenuSubCategoryClick(Sender: TObject);
    procedure pnlMenuExpensesClick(Sender: TObject);
    procedure pnlMenuRevenuesClick(Sender: TObject);
    procedure pnlMenuProviderClick(Sender: TObject);
    procedure btImportClick(Sender: TObject);
    procedure pnButtonManageMovementsClick(Sender: TObject);
    procedure pnButtonMovementGraphicsClick(Sender: TObject);
    procedure imgButtonUtilitiesClick(Sender: TObject);
  private
    procedure loginCall;
    { Private declarations }
  public
    { Public declarations }
    procedure GetUserInfos;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  uDataBaseConnection;

{$R *.dfm}

procedure TfrmMain.btImportClick(Sender: TObject);
var
lform: TFrmImport;
begin
lform := TfrmImport.Create(nil);
try
  lform.ShowModal;
finally
  lform.Free;
end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Color := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  loginCall;
end;

procedure TfrmMain.GetUserInfos;
begin
  lbUser.Caption := TSystemManager.GetInstance.LoggedUser.Name;
end;

procedure TfrmMain.imgButtonUtilitiesClick(Sender: TObject);
var
  lForm: TFrmUtilities;
begin
   lForm := TfrmUtilities.Create(nil);
   try
     lform.ShowModal;
   finally
     lForm.Free;
   end;
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

procedure TfrmMain.pnButtonManageMovementsClick(Sender: TObject);
var
  lForm: TFrmManageMovements;
begin
  lForm := TFrmManageMovements.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;

end;

procedure TfrmMain.pnButtonMovementGraphicsClick(Sender: TObject);
var
  lForm: TFrmMovementGraphics;
begin
  lForm := TFrmMovementGraphics.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;

end;

procedure TfrmMain.pnlMenuCategoryClick(Sender: TObject);
var
  lForm: TFrmCategory;
begin
  lForm := TfrmCategory.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;
end;

procedure TfrmMain.pnlMenuExpensesClick(Sender: TObject);
var
  lForm: TfrmMovement;
begin
  lForm := TfrmMovement.Create(nil);
  try
    lForm.TypeMovement := tmExpenses;
    lForm.pnlTitle.Color := pnlMenuExpenses.Color;
    lForm.ShowModal;
  finally
    lForm.Free;
  end;
end;

procedure TfrmMain.pnlMenuFormPaymentClick(Sender: TObject);
var
  lForm: TFrmFormPayment;
begin
  lForm := TFrmFormPayment.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;

end;

procedure TfrmMain.pnlMenuProviderClick(Sender: TObject);
var
  lForm: TfrmProvider;
begin
  lForm := TfrmProvider.Create(nil);
  try
    lForm.ShowModal;
  finally
    lForm.Free;
  end;

end;

procedure TfrmMain.pnlMenuRevenuesClick(Sender: TObject);
var
  lForm: TfrmMovement;
begin
  lForm := TfrmMovement.Create(nil);
  try
    lForm.TypeMovement := tmRevenues;
    lForm.pnlTitle.Color := pnlMenuRevenues.Color;
    lForm.ShowModal;
  finally
    lForm.Free;
  end;

end;

procedure TfrmMain.pnlMenuSubCategoryClick(Sender: TObject);
var
  lForm: TFrmSubCategory;
begin
  lForm := TfrmSubCategory.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;
end;

procedure TfrmMain.pnlMenuTypePaymentClick(Sender: TObject);
var
  lForm: TFrmTypePayment;
begin
  lForm := TFrmTypePayment.Create(nil);
  try
    lForm.showmodal;
  finally
    lForm.Free;
  end;

end;

end.
