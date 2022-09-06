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
  uCrudInterface in 'interfaces\uCrudInterface.pas',
  uEnumTypes in 'class\uEnumTypes.pas',
  uFormPayment in 'class\uFormPayment.pas',
  uSearchFilters in 'class\uSearchFilters.pas',
  uTypePayment in 'class\uTypePayment.pas',
  fTypePayment in 'forms\fTypePayment.pas' {frmTypePayment},
  fFormPayment in 'forms\fFormPayment.pas' {frmFormPayment};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := False;
  Application.Title := 'Personal Financial Control';

  TSystemManager.GetInstance.LayoutConfiguration.TitleColor := $00354237;
  TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor := clWhite;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor := clWhite;
  TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor := $00354237;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor := clBlack;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor := clWhite;
  TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor := $00354237;

  Application.CreateForm(TfrmMain, frmMain);

  Application.Run;
end.
