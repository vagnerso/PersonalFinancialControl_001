program PersonalFinancialControl;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  uUser in 'class\uUser.pas',
  fBase in 'templates\fBase.pas' {frmBase},
  fMasterRegister in 'templates\fMasterRegister.pas' {frmMasterRegister},
  uCategory in 'class\uCategory.pas',
  uSubCategory in 'class\uSubCategory.pas',
  uPerson in 'class\uPerson.pas',
  uProvider in 'class\uProvider.pas',
  fLogin in 'forms\fLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmBase, frmBase);
  Application.CreateForm(TfrmMasterRegister, frmMasterRegister);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
