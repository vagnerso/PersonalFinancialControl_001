unit fManageMovements;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uMovement, uEnumTypes,
  uFunctions, fGeneralSearch, frxClass;

type
  TfrmManageMovements = class(TfrmMasterRegister)
    Label2: TLabel;
    edtDescription: TEdit;
    Label5: TLabel;
    edtProvider: TEdit;
    imButtonClearEdtProvider: TImage;
    imButtonSearchProvider: TImage;
    edtSubCategory: TEdit;
    Label6: TLabel;
    imButtonClearEdtSubCategory: TImage;
    imButtonSearchSubCategory: TImage;
    Label1: TLabel;
    edtFormPayment: TEdit;
    imButtonClearEdtFormPayment: TImage;
    imButtonSearchFormPayment: TImage;
    lbInstallmentsValue: TLabel;
    edtInstallmentesValue: TEdit;
    edtIssueDate: TDateTimePicker;
    lbFirstIssueDate: TLabel;
    N2: TMenuItem;
    Efetuarpagamento1: TMenuItem;
    cbxFilterSituation: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cbxFilterMonth: TComboBox;
    pnlSum: TPanel;
    lblSumRevenues: TLabel;
    lblSumExpenses: TLabel;
    lblBalance: TLabel;
    pnlButtonPdfExport: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure imButtonSearchProviderClick(Sender: TObject);
    procedure imButtonSearchSubCategoryClick(Sender: TObject);
    procedure imButtonSearchFormPaymentClick(Sender: TObject);
    procedure Efetuarpagamento1Click(Sender: TObject);
    procedure pnlButtonPrintClick(Sender: TObject);
    procedure pnlButtonPdfExportClick(Sender: TObject);
  private
    FRegisterObject: TMovement;
    procedure EnabledRegister;
    procedure DisabledRegister;
    procedure SumMovements;
    { Private declarations }
  public
    { Public declarations }
    procedure InsertRegister; override;
    procedure EditRegister; override;
    procedure DeleteRegister; override;
    procedure PrintRegister; override;
    procedure CloseForm; override;
    procedure SearchExecute; override;
    procedure SaveRegister; override;
    procedure CancelRegister; override;
    procedure MakePayment;
    procedure ClearFields;

    property RegisterObject: TMovement read FRegisterObject write FRegisterObject;
  end;

var
  frmManageMovements: TfrmManageMovements;

implementation

uses
  System.DateUtils, dMovements, FireDAC.Comp.Client, uDataBaseConnection;

{$R *.dfm}

{ TfrmManageMovements }

procedure TfrmManageMovements.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmManageMovements.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmManageMovements.CloseForm;
begin
  inherited;
  Close;
end;

procedure TfrmManageMovements.DeleteRegister;
begin
  inherited;
  if Application.MessageBox(PChar('Deseja realmente excluir o registro?'),
     PChar(Application.Title), MB_USEGLYPHCHARS + MB_DEFBUTTON2) = ID_NO then
  begin
    Abort;
  end;

  FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
  FRegisterObject.DeleteRegister;
  SearchExecute;
end;

procedure TfrmManageMovements.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmManageMovements.EditRegister;
begin
  inherited;
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  FRegisterObject.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
  FRegisterObject.GetById;
  edtDescription.Text := FRegisterObject.Description;
  edtProvider.Text := FRegisterObject.Provider.Name;
  edtSubCategory.Text := FRegisterObject.SubCategory.Name;
  edtFormPayment.Text := FRegisterObject.FormPayment.Name;
  edtInstallmentesValue.Text := CurrToStr(FRegisterObject.InstallmentValue);
  edtIssueDate.Date := FRegisterObject.IssueDate;

  edtDescription.SetFocus;
end;

procedure TfrmManageMovements.Efetuarpagamento1Click(Sender: TObject);
begin
  inherited;
  MakePayment;
  SearchExecute;
end;

procedure TfrmManageMovements.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmManageMovements.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TMovement.Create;
end;

procedure TfrmManageMovements.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmManageMovements.FormShow(Sender: TObject);
var
  lMonth: SmallInt;
begin
  FTitleForm := 'Gerenciar Movimentações';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  lMonth := MonthOf(now);
  cbxFilterMonth.ItemIndex := lMonth;
  searchExecute;
  WindowState := wsMaximized;
end;

procedure TfrmManageMovements.imButtonSearchFormPaymentClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setFormPayment;
    frmGeneralSearch.ShowModal;
    edtFormPayment.Text := frmGeneralSearch.FormPayment.Name;
    FRegisterObject.FormPayment.Id := frmGeneralSearch.FormPayment.Id;

  finally
    frmGeneralSearch.Free;
  end;

end;

procedure TfrmManageMovements.imButtonSearchProviderClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setProvider;
    frmGeneralSearch.ShowModal;
    edtProvider.Text := frmGeneralSearch.Provider.Name;
    FRegisterObject.Provider.Id := frmGeneralSearch.Provider.Id;
  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmManageMovements.imButtonSearchSubCategoryClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setSubCategory;
    frmGeneralSearch.ShowModal;
    edtSubCategory.Text := frmGeneralSearch.SubCategory.Name;
    FRegisterObject.SubCategory.Id := frmGeneralSearch.SubCategory.Id;
  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmManageMovements.InsertRegister;
begin
  inherited;
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtDescription.SetFocus;
end;

procedure TfrmManageMovements.MakePayment;
begin

  if Application.MessageBox(PChar('Deseja realmente efetuar o pagamento?'),
     PChar(Application.Title), MB_USEGLYPHCHARS + MB_DEFBUTTON2) = ID_NO then
  begin
    Abort;
  end;

  FRegisterObject.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
  FRegisterObject.GetById;
  FRegisterObject.MakePayment;
end;

procedure TfrmManageMovements.pnlButtonPdfExportClick(Sender: TObject);
begin
  inherited;
  dtmMovements.frxReportMovements.PrintOptions.ShowDialog := True;
  dtmMovements.frxReportMovements.FileName := 'C:\temp\relatorio_movimento.PDF';
  dtmMovements.frxReportMovements.PrepareReport();
  dtmMovements.frxReportMovements.Export(dtmMovements.frxPDFExport1);
end;

procedure TfrmManageMovements.pnlButtonPrintClick(Sender: TObject);
begin
  inherited;
  TDatabaseConnection.GetInstance.NewConnection;
  dtmMovements.qryMovementsReport.Connection := TDataBaseConnection.GetInstance.Connection;
  dtmMovements.qryMovementsReport.Close;
  dtmMovements.qryMovementsReport.SQL.Clear;
  dtmMovements.qryMovementsReport.SQL.Add(TFDQuery(dtsSearch.DataSet).SQL.Text);
  dtmMovements.qryMovementsReport.Open;
  dtmMovements.frxReportMovements.ShowReport;
end;

procedure TfrmManageMovements.PrintRegister;
begin
  inherited;

end;

procedure TfrmManageMovements.SaveRegister;
begin
  inherited;
  //FRegisterObject.Name := edtName.Text;

  case FOperationType of
    otInsert:
    begin
      FRegisterObject.InsertRegister;
    end;
    otUpdate:
    begin
      FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
      FRegisterObject.Description := edtDescription.Text;
      FRegisterObject.Provider.Name := edtProvider.Text;
      FRegisterObject.SubCategory.Name := edtSubCategory.Text;
      FRegisterObject.FormPayment.Name := edtFormPayment.Text;
      FRegisterObject.InstallmentValue := StrToCurrDef(edtInstallmentesValue.Text,0);
      FRegisterObject.IssueDate := edtIssueDate.Date;
      FRegisterObject.UpdateRegister;
    end;
  end;
  DisabledRegister;
  SearchExecute;
end;

procedure TfrmManageMovements.SearchExecute;
begin
  inherited;
  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.SearchFiltersCustomized.Situation := cbxFilterSituation.ItemIndex -1;
  FRegisterObject.SearchFiltersCustomized.Month := cbxFilterMonth.ItemIndex;
  FRegisterObject.Search(FQuerySearch);
  SumMovements;

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 300;
  grdSearch.Columns[3].Visible := False;
  grdSearch.Columns[4].Visible := False;
  grdSearch.Columns[5].Width := 150;
  grdSearch.Columns[6].Width := 150;
  grdSearch.Columns[7].Width := 100;
  grdSearch.Columns[8].Width := 150;
  grdSearch.Columns[9].Visible := False;
  grdSearch.Columns[10].Width := 250;
  grdSearch.Columns[11].Width := 250;
  grdSearch.Columns[12].Width := 250;
end;

procedure TfrmManageMovements.SumMovements;
var
  lSumRevenues, lSumExpenses: Currency;
begin
  inherited;

  lSumRevenues := 0;
  lSumExpenses := 0;

  dtsSearch.DataSet.DisableControls;
  dtsSearch.DataSet.First;

  while not dtsSearch.DataSet.Eof do
  begin

    if dtsSearch.DataSet.FieldByName('tipo').AsString = 'Entrada' then
    begin
      lSumRevenues := lSumRevenues + dtsSearch.DataSet.FieldByName('R$ Valor').AsFloat;
    end;

    if dtsSearch.DataSet.FieldByName('tipo').AsString = 'Saída' then
    begin
      lSumExpenses := lSumExpenses + dtsSearch.DataSet.FieldByName('R$ Valor').AsFloat;
    end;

    dtsSearch.DataSet.Next;
  end;

  lblSumRevenues.Caption := 'Total de Receitas: R$ ' + FormatCurr('#,##0.00', lSumRevenues);
  lblSumExpenses.Caption := 'Total de Despesas: R$ ' + FormatCurr('#,##0.00', lSumExpenses);
  lblBalance.Caption := 'Saldo: R$ ' + FormatCurr('#,##0.00', lSumRevenues - lSumExpenses);

  dtsSearch.DataSet.First;
  dtsSearch.DataSet.EnableControls;
end;

end.
