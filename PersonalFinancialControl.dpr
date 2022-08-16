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
  fLogin in 'forms\fLogin.pas' {frmLogin},
  uLayoutConfiguration in 'class\uLayoutConfiguration.pas',
  uSystemManager in 'class\uSystemManager.pas',
  Vcl.Graphics,
  fCategory in 'forms\fCategory.pas' {frmCategory},
  uDataBaseConnection in 'class\uDataBaseConnection.pas',
  uAppConstants in 'class\uAppConstants.pas',
  uFunctions in 'class\uFunctions.pas',
  uCrudInterface in 'interfaces\uCrudInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  TSystemManager.GetInstance.LayoutConfiguration.TitleColor := clblack;
  TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor := clWhite;

  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCategory, frmCategory);
  Application.Run;
end.
