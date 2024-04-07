program PersonalFinancialControl;

uses
  Vcl.Forms,
  MidasLib,
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
  fMessage in 'forms\fMessage.pas' {frmMessage},
  uDataBaseScripts in 'class\uDataBaseScripts.pas',
  fUtilities in 'forms\fUtilities.pas' {frmUtilities},
  uCustomer in 'class\uCustomer.pas',
  fCustomer in 'forms\fCustomer.pas' {frmCustomer},
  uCity in 'class\uCity.pas',
  fCity in 'forms\fCity.pas' {frmCity},
  dMovements in 'dataModules\dMovements.pas' {dtmMovements: TDataModule},
  dConnection in 'dataModules\dConnection.pas' {dtmConnection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := False;
  Application.Title := 'Personal Financial Control';

  if not (TDataBaseScripts.ExecuteScripts) then
  begin
    TFrmMessage.ShowMessageBox(mtError, '', 'Atenção, ocorreu um erro ao tentarmos atualizar a estrutura do banco de dados. Tente novamente mais tarde.');
    Application.Terminate;
  end
  else
  begin

    TSystemManager.GetInstance.LayoutConfiguration.TitleColor := $007DA640;
    TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor := clWhite;
    TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor := $00635A4B;
    TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor := clWhite;
    TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor := clWhite;
    TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor := clBlack;
    TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor := $00242424 ;
    TSystemManager.GetInstance.LayoutConfiguration.SearchPanelColor := $00242424;
    TSystemManager.GetInstance.LayoutConfiguration.MainPanelColor := $00242424;
    TSystemManager.GetInstance.LayoutConfiguration.MainPanelRegisterColor := $00242424;
    TSystemManager.GetInstance.LayoutConfiguration.RegisterPanelColor := $00242424;
    TSystemManager.GetInstance.LayoutConfiguration.PanelBottomColor := $00242424;
    TSystemManager.GetInstance.LayoutConfiguration.PopUpBackgroundColor := $004A4B49;

    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdtmMovements, dtmMovements);
  Application.CreateForm(TdtmConnection, dtmConnection);
  Application.Run;

  end;

end.
