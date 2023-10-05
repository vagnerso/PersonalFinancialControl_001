unit fMovement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, fGeneralSearch, uEnumTypes,
  FireDAC.Comp.Client, uFunctions, uMovement, uSystemManager, fMessage;

type
  TfrmMovement = class(TfrmBase)
    pnlTitle: TPanel;
    pnlBottom: TPanel;
    pgcNavigator: TPageControl;
    tabDescription: TTabSheet;
    pnlDescription: TPanel;
    edtDescription: TEdit;
    Label1: TLabel;
    edtFormPayment: TEdit;
    imButtonClearEdtFormPayment: TImage;
    imButtonSearchFormPayment: TImage;
    tabInstallments: TTabSheet;
    pnlInstallments: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNumberInstallments: TEdit;
    pnlButtonInstallmentsGenerate: TPanel;
    pnlButtonSave: TPanel;
    pnlButtonCancel: TPanel;
    grInstallments: TDBGrid;
    dtsInstallments: TDataSource;
    lbInstallmentsValue: TLabel;
    edtInstallmentesValue: TEdit;
    lblPerson: TLabel;
    imButtonClearEdtPerson: TImage;
    imButtonSearchPerson: TImage;
    edtPerson: TEdit;
    Label6: TLabel;
    edtSubCategory: TEdit;
    imButtonClearEdtSubCategory: TImage;
    imButtonSearchSubCategory: TImage;
    lbFirstIssueDate: TLabel;
    edtFirstIssueDate: TDateTimePicker;
    procedure imButtonSearchFormPaymentClick(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonCancelClick(Sender: TObject);
    procedure pnlButtonSaveClick(Sender: TObject);
    procedure imButtonSearchPersonClick(Sender: TObject);
    procedure imButtonSearchSubCategoryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pnlButtonCancelMouseEnter(Sender: TObject);
    procedure pnlButtonSaveMouseEnter(Sender: TObject);
    procedure pnlButtonCancelMouseLeave(Sender: TObject);
    procedure pnlButtonSaveMouseLeave(Sender: TObject);
    procedure edtInstallmentesValueKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumberInstallmentsExit(Sender: TObject);
    procedure edtInstallmentesValueExit(Sender: TObject);
    procedure edtPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSubCategoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFormPaymentKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlButtonInstallmentsGenerateEnter(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateExit(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateMouseEnter(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateMouseLeave(Sender: TObject);
  private
    FMemInstallmentsList: TFDMemTable;
    FTypeMovement: TTypeMovement;
    FRegisterObject: TMovement;
    FBackgroundColor :TColor;
    FTitleColor :TColor;
    FTitleFontColor :TColor;
    FActionButtonColor :TColor;
    FHoverActionButtonColor :TColor;
    FActionButtonFontColor :TColor;
    FActionButtonHoverColor :TColor;
    FSearchPanelColor :TColor;
    FMainPanelColor :TColor;
    FRegisterPanelColor :TColor;
    FMainPanelRegisterColor :TColor;
    FPanelBottomColor :TColor;
    FHoverActionButtonFontColor: TColor;

    procedure InstallmentsGenerate;
    procedure SetColors;
    procedure SearchPerson;
    procedure SearchSubCategory;
    procedure SearchFormPayment;
    procedure SetLayoutGridInstallments;

    { Private declarations }
  public
    { Public declarations }
    property TypeMovement: TTypeMovement read FTypeMovement write FTypeMovement;
    property RegisterObject: TMovement read FRegisterObject write FRegisterObject;
  end;

var
  frmMovement: TfrmMovement;

implementation

uses
  uAppConstants;

{$R *.dfm}

procedure TfrmMovement.edtFormPaymentKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F12) then
  begin
    SearchFormPayment;
  end;
end;

procedure TfrmMovement.edtInstallmentesValueExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := FormatCurr('#,##0.00', StrToCurrDef(TEdit(Sender).Text, 0));
end;

procedure TfrmMovement.edtInstallmentesValueKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(key in ['0'..'9','.',',',#8,#13]) then
    key := #0;
  if key in [',','.'] then
    key := FormatSettings.DecimalSeparator;
  if key = FormatSettings.DecimalSeparator then
  if pos(key,TEdit(Sender).Text) <> 0 then
    key := #0;
end;

procedure TfrmMovement.edtNumberInstallmentsExit(Sender: TObject);
var
  numberInstallments: Integer;
begin
  inherited;
  numberInstallments := StrToIntDef(edtNumberInstallments.Text, 1);

  if numberInstallments > 1 then
  begin
    pnlButtonInstallmentsGenerate.Visible := True;
    tabInstallments.TabVisible := True;
    lbFirstIssueDate.Caption := 'Data do primeiro vencimento';
    lbInstallmentsValue.Caption := 'Valor das parcelas';
  end
  else
  begin
    pnlButtonInstallmentsGenerate.Visible := False;
    tabInstallments.TabVisible := False;
    lbFirstIssueDate.Caption := 'Data de vencimento';
    lbInstallmentsValue.Caption := 'Valor';
  end;
end;

procedure TfrmMovement.edtPersonKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F12) then
  begin
    SearchPerson;
  end;
end;

procedure TfrmMovement.edtSubCategoryKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_F12) then
  begin
    SearchSubCategory;
  end;
end;

procedure TfrmMovement.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TMovement.Create;
  FRegisterObject.Clear;
  FMemInstallmentsList := TFDMemTable.Create(Self);
  FMemInstallmentsList.FieldDefs.Add('NUMBER_PARCEL', ftInteger);
  FMemInstallmentsList.FieldDefs.Add('DESCRIPTION', ftString, 300);
  FMemInstallmentsList.FieldDefs.Add('INSTALLMENT_VALUE', ftCurrency);
  FMemInstallmentsList.FieldDefs.Add('ISSUE_DATE', ftDate);
  FMemInstallmentsList.CreateDataSet;
end;

procedure TfrmMovement.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmMovement.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmMovement.FormShow(Sender: TObject);
begin
  inherited;
  pgcNavigator.ActivePage := tabDescription;
  SetColors;

  case FTypeMovement of
    tmRevenues:
    begin
      Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + 'Receitas';
      pnlTitle.Caption := 'Cadastro de Receitas';
      lblPerson.Caption := 'Clientes';
    end;
    tmExpenses:
    begin
      Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + 'Receitas';
      pnlTitle.Caption := 'Cadastro de Despesas';
      lblPerson.Caption := 'Fornecedores';
    end;
  end;

  edtFirstIssueDate.Date := now;
  edtNumberInstallments.Text := '1';
  edtNumberInstallmentsExit(Self);
end;


procedure TfrmMovement.SetColors;
begin
  FBackgroundColor := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  FTitleColor := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  FTitleFontColor := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  FActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  FHoverActionButtonColor:= TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor;
  FActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  FActionButtonHoverColor:= TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor;
  FSearchPanelColor := TSystemManager.GetInstance.LayoutConfiguration.SearchPanelColor;
  FMainPanelColor := TSystemManager.GetInstance.LayoutConfiguration.MainPanelColor;
  FRegisterPanelColor := TSystemManager.GetInstance.LayoutConfiguration.RegisterPanelColor;
  FMainPanelRegisterColor := TSystemManager.GetInstance.LayoutConfiguration.MainPanelRegisterColor;
  FPanelBottomColor := TSystemManager.GetInstance.LayoutConfiguration.PanelBottomColor;
  FHoverActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor;

  Color := FBackgroundColor;
  //pnlTitle.Color := FTitleColor;
  pnlTitle.Font.Color := FTitleFontColor;

  pnlButtonSave.Color := FActionButtonColor;
  pnlButtonCancel.Color := FActionButtonColor;

  pnlButtonSave.Font.Color := FActionButtonFontColor;
  pnlButtonCancel.Font.Color := FActionButtonFontColor;

  pnlButtonInstallmentsGenerate.Color := FActionButtonColor;
  pnlButtonInstallmentsGenerate.Font.Color := FActionButtonFontColor;

  pnlDescription.Color := FRegisterPanelColor;

  pnlBottom.Color := FPanelBottomColor;
end;

procedure TfrmMovement.SearchPerson;
var
  frmGeneralSearch : TfrmGeneralSearch;
begin

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try

    case FTypeMovement of
      tmRevenues:
      begin
        frmGeneralSearch.SearchEntityType := setCustomer;
      end;
      tmExpenses:
      begin
        frmGeneralSearch.SearchEntityType := setProvider;
      end;
    end;

    if frmGeneralSearch.ShowModal = mrOk then
    begin

      case FTypeMovement of
        tmRevenues:
        begin
          edtPerson.Text := frmGeneralSearch.Customer.Name;
          FRegisterObject.Provider.Id := frmGeneralSearch.Customer.Id;
        end;
        tmExpenses:
        begin
          edtPerson.Text := frmGeneralSearch.Provider.Name;
          FRegisterObject.Provider.Id := frmGeneralSearch.Provider.Id;
        end;
      end;

    end;

  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmMovement.imButtonSearchPersonClick(Sender: TObject);
begin
  inherited;
  SearchPerson;
end;

procedure TfrmMovement.SearchSubCategory;
var
  frmGeneralSearch : TfrmGeneralSearch;
begin

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setSubCategory;

    if frmGeneralSearch.ShowModal = mrOk then
    begin
      edtSubCategory.Text := frmGeneralSearch.SubCategory.Name;
      FRegisterObject.SubCategory.Id := frmGeneralSearch.SubCategory.Id;
    end;

  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmMovement.imButtonSearchSubCategoryClick(Sender: TObject);
begin
  inherited;
  SearchSubCategory;
end;

procedure TfrmMovement.SearchFormPayment;
var
  frmGeneralSearch : TfrmGeneralSearch;
begin

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setFormPayment;

    if frmGeneralSearch.ShowModal = mrOk then
    begin
      edtFormPayment.Text := frmGeneralSearch.FormPayment.Name;
      FRegisterObject.FormPayment.Id := frmGeneralSearch.FormPayment.Id;
    end;

  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmMovement.SetLayoutGridInstallments;
begin
  grInstallments.Columns[0].Width := 80;
  grInstallments.Columns[1].Width := 300;
  grInstallments.Columns[2].Width := 140;
  grInstallments.Columns[3].Width := 140;
  grInstallments.Columns[0].Title.Caption := 'Parcela';
  grInstallments.Columns[1].Title.Caption := 'Descrição';
  grInstallments.Columns[2].Title.Caption := 'R$ Valor';
  grInstallments.Columns[3].Title.Caption := 'Vencimento';
end;

procedure TfrmMovement.imButtonSearchFormPaymentClick(Sender: TObject);
begin
  inherited;
  SearchFormPayment;
end;

procedure TfrmMovement.InstallmentsGenerate;
var
  lNumberInstallments: Integer;
  I: Integer;
  lIssueDate: TDate;
begin

  lNumberInstallments := StrToIntDef(edtNumberInstallments.Text, 1);
  lIssueDate := edtFirstIssueDate.Date;

  dtsInstallments.DataSet := FMemInstallmentsList;
  FMemInstallmentsList.EmptyDataSet;

  for I := 0 to lNumberInstallments - 1 do
  begin
    FMemInstallmentsList.Append;
    FMemInstallmentsList.FieldByName('NUMBER_PARCEL').AsInteger := i + 1;
    FMemInstallmentsList.FieldByName('DESCRIPTION').AsString := edtDescription.Text;
    FMemInstallmentsList.FieldByName('INSTALLMENT_VALUE').AsCurrency := StrToCurrDef(edtInstallmentesValue.Text, 0);
    FMemInstallmentsList.FieldByName('ISSUE_DATE').AsDateTime := lIssueDate;
    FMemInstallmentsList.Post;
    lIssueDate := IncMonth(lIssueDate);
  end;

  SetLayoutGridInstallments;

  pgcNavigator.ActivePage := tabInstallments;

end;

procedure TfrmMovement.pnlButtonSaveClick(Sender: TObject);
begin
  inherited;

  try

    if (StrToIntDef(edtNumberInstallments.Text, 1) = 1)  then
    begin
      InstallmentsGenerate;
    end;

    FMemInstallmentsList.First;
    while not FMemInstallmentsList.Eof do
    begin

      FRegisterObject.Description      := FMemInstallmentsList.FieldByName('DESCRIPTION').AsString;
      FRegisterObject.InstallmentValue := FMemInstallmentsList.FieldByName('INSTALLMENT_VALUE').AsCurrency;
      FRegisterObject.IssueDate        := FMemInstallmentsList.FieldByName('ISSUE_DATE').AsDateTime;
      FRegisterObject.NumberParcel     := FMemInstallmentsList.FieldByName('NUMBER_PARCEL').AsInteger;
      FRegisterObject.TypeMovement     := FTypeMovement;
      FRegisterObject.Situation        := 0;
      FRegisterObject.InsertRegister;

      FMemInstallmentsList.Next;
    end;

    TFrmMessage.ShowMessageBox(mtSuccess, '', MGS_SUCCESS_PARCEL_GENERATE);

    ModalResult := mrOk;

  except on E: Exception do
    begin
      TFrmMessage.ShowMessageBox(mtError, MGS_ERROR_PARCEL_GENERATE, e.Message);
    end;
  end;
end;

procedure TfrmMovement.pnlButtonSaveMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
  TPanel(Sender).Font.Color := FActionButtonHoverColor;
end;

procedure TfrmMovement.pnlButtonSaveMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
  TPanel(Sender).Font.Color := FActionButtonFontColor;
end;

procedure TfrmMovement.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMovement.pnlButtonCancelMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
  TPanel(Sender).Font.Color := FActionButtonHoverColor;
end;

procedure TfrmMovement.pnlButtonCancelMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
  TPanel(Sender).Font.Color := FActionButtonFontColor;
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateClick(Sender: TObject);
begin
  inherited;
  InstallmentsGenerate;
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateExit(Sender: TObject);
begin
  inherited;
   TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

end.
