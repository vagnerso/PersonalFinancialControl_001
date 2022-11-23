unit fMovement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, fGeneralSearch, uEnumTypes,
  FireDAC.Comp.Client, uFunctions, uMovement;

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
    Label4: TLabel;
    edtInstallmentesValue: TEdit;
    Label5: TLabel;
    imButtonClearEdtProvider: TImage;
    imButtonSearchProvider: TImage;
    edtProvider: TEdit;
    Label6: TLabel;
    edtSubCategory: TEdit;
    imButtonClearEdtSubCategory: TImage;
    imButtonSearchSubCategory: TImage;
    lbFirstIssueDate: TLabel;
    edtFirstIssueDate: TDateTimePicker;
    procedure imButtonSearchFormPaymentClick(Sender: TObject);
    procedure edtNumberInstallmentsClick(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonCancelClick(Sender: TObject);
    procedure pnlButtonSaveClick(Sender: TObject);
    procedure imButtonSearchProviderClick(Sender: TObject);
    procedure imButtonSearchSubCategoryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMemInstallmentsList: TFDMemTable;
    FTypeMovement: TTypeMovement;
    FRegisterObject: TMovement;

    procedure InstallmentsGenerate;

    { Private declarations }
  public
    { Public declarations }
    property TypeMovement: TTypeMovement read FTypeMovement write FTypeMovement;
    property RegisterObject: TMovement read FRegisterObject write FRegisterObject;
  end;

var
  frmMovement: TfrmMovement;

implementation

{$R *.dfm}

procedure TfrmMovement.edtNumberInstallmentsClick(Sender: TObject);
var
  numberInstallments: Integer;
begin
  inherited;
  numberInstallments := StrToIntDef(edtNumberInstallments.Text, 1);

  if numberInstallments > 1 then
  begin
    pnlButtonInstallmentsGenerate.Visible := True;
    lbFirstIssueDate.Visible := True;
    edtFirstIssueDate.Visible := True;
  end
  else
  begin
    pnlButtonInstallmentsGenerate.Visible := False;
    lbFirstIssueDate.Visible := False;
    edtFirstIssueDate.Visible := False;
  end;

end;

procedure TfrmMovement.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TMovement.Create;
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

procedure TfrmMovement.FormShow(Sender: TObject);
begin
  inherited;
  pgcNavigator.ActivePage := tabDescription;

  case FTypeMovement of
    tmRevenues:
    begin
      Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + 'Receitas';
      pnlTitle.Caption := 'Cadastro de Receitas';
    end;
    tmExpenses:
    begin
      Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + 'Receitas';
      pnlTitle.Caption := 'Cadastro de Despesas';
    end;
  end;

  edtFirstIssueDate.Date := now;
  edtNumberInstallments.Text := '1';
end;

procedure TfrmMovement.imButtonSearchProviderClick(Sender: TObject);
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

procedure TfrmMovement.imButtonSearchSubCategoryClick(Sender: TObject);
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

procedure TfrmMovement.imButtonSearchFormPaymentClick(Sender: TObject);
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

procedure TfrmMovement.InstallmentsGenerate;
var
  numberInstallments: Integer;
  I: Integer;
  lIssueDate: TDate;
begin

  numberInstallments := StrToIntDef(edtNumberInstallments.Text, 1);
  lIssueDate := edtFirstIssueDate.Date;

  dtsInstallments.DataSet := FMemInstallmentsList;
  FMemInstallmentsList.EmptyDataSet;

  for I := 0 to numberInstallments - 1 do
  begin
    FMemInstallmentsList.Append;
    FMemInstallmentsList.FieldByName('NUMBER_PARCEL').AsInteger := i + 1;
    FMemInstallmentsList.FieldByName('DESCRIPTION').AsString := edtDescription.Text;
    FMemInstallmentsList.FieldByName('INSTALLMENT_VALUE').AsCurrency := StrToCurrDef(edtInstallmentesValue.Text, 0);
    FMemInstallmentsList.FieldByName('ISSUE_DATE').AsDateTime := lIssueDate;


    FMemInstallmentsList.Post;
    lIssueDate := IncMonth(lIssueDate);
  end;

  grInstallments.Columns[0].Width := 80;
  grInstallments.Columns[1].Width := 300;
  grInstallments.Columns[2].Width := 140;
  grInstallments.Columns[3].Width := 140;

  pgcNavigator.ActivePage := tabInstallments;

end;

procedure TfrmMovement.pnlButtonSaveClick(Sender: TObject);
begin
  inherited;

  if StrToIntDef(edtNumberInstallments.Text, 1) = 1  then
  begin
    InstallmentsGenerate;
  end;

  FMemInstallmentsList.First;
  while not FMemInstallmentsList.Eof do
  begin

    FRegisterObject.Clear;
    FRegisterObject.Description := FMemInstallmentsList.FieldByName('DESCRIPTION').AsString;
    FRegisterObject.InstallmentValue := FMemInstallmentsList.FieldByName('INSTALLMENT_VALUE').AsCurrency;
    FRegisterObject.IssueDate := FMemInstallmentsList.FieldByName('ISSUE_DATE').AsDateTime;
    FRegisterObject.NumberParcel := FMemInstallmentsList.FieldByName('NUMBER_PARCEL').AsInteger;
    FRegisterObject.InsertRegister;

    FMemInstallmentsList.Next;
  end;

  ModalResult := mrOk;
end;

procedure TfrmMovement.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateClick(Sender: TObject);
begin
  inherited;
  InstallmentsGenerate;
end;

end.
