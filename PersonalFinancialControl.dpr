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
  fFormPayment in 'forms\fFormPayment.pas' {frmFormPayment},
  fSubCategory in 'forms\fSubCategory.pas' {frmSubCategory},
  fGeneralSearch in 'forms\fGeneralSearch.pas' {frmGeneralSearch},
  fMovement in 'forms\fMovement.pas' {frmMovement},
  uMovement in 'class\uMovement.pas',
  fProvider in 'forms\fProvider.pas' {frmProvider},
  fImport in 'forms\fImport.pas' {frmImport},
  fManageMovements in 'forms\fManageMovements.pas' {frmManageMovements},
  fMovementGraphics in 'forms\fMovementGraphics.pas' {frmMovementGraphics},
  uClassHelperTEdit in 'class\uClassHelperTEdit.pas',
  fUser in 'forms\fUser.pas' {frmUser},
  fMessage in 'forms\fMessage.pas' {frmMessage};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := False;
  Application.Title := 'Personal Financial Control';

  TSystemManager.GetInstance.LayoutConfiguration.TitleColor := $0078B15C;
  TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor := clWhite;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor := $00635A4B;
  TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor := $0077DCEA;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor := clWhite;
  TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor := clBlack;
  TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor :=$00635A4B ;
  TSystemManager.GetInstance.LayoutConfiguration.SearchPanelColor :=$00635A4B;
  TSystemManager.GetInstance.LayoutConfiguration.MainPanelColor := $00635A4B;
  TSystemManager.GetInstance.LayoutConfiguration.MainPanelRegisterColor := $00635A4B;
  TSystemManager.GetInstance.LayoutConfiguration.RegisterPanelColor := $00635A4B;
  TSystemManager.GetInstance.LayoutConfiguration.PanelBottomColor := $00635A4B;

  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
