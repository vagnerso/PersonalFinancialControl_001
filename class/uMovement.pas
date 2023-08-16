unit uMovement;

interface

uses
  uSearchFilters, uDataBaseConnection, uSubCategory, uFormPayment,
  System.SysUtils, Vcl.Dialogs, uAppConstants, System.Classes, uProvider,
  uFunctions, uEnumTypes, Data.DB, System.DateUtils, fMessage, uCustomer;

type TSearchFiltersCustomized = class(TSearchFilters)
  private
    FSituation: Integer;
    FMonth: Integer;
    FYear: Integer;
    FInitialDate: TDate;
    FEndDate: TDate;

  public
    property Situation: Integer read FSituation write FSituation;
    property Month: Integer read FMonth write FMonth;
    property Year: Integer read FYear write FYear;
    property InitialDate: TDate read FInitialDate write FInitialDate;
    property EndDate: TDate read FEndDate write FEndDate;
end;

type TMovement = class
  private
    FDataSet : TMyQuery;
    FSearchFiltersCustomized: TSearchFiltersCustomized;
    FId: Integer;
    FSubCategory: TSubCategory;
    FDescription: string;
    FUniqueId: string;
    FFormPayment: TFormPayment;
    FIssueDate: TDateTime;
    FInstallmentValue: Currency;
    FNumberParcel: Integer;
    FTypeMovement: TTypeMovement;
    FProvider: TProvider;
    FCustomer: TCustomer;
    FSituation: Byte;
    FQueryFormPaymentsRevenues: TMyQuery;
    FQueryFormPaymentsExpenses: TMyQuery;
    FQuerySubCategorysExpenses: TMyQuery;
    FQuerySubCategorysRevenues: TMyQuery;
    FQueryCategorysExpenses: TMyQuery;
    FQueryCategorysRevenues: TMyQuery;

  public
    constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure GetById;
    procedure Search(ADataSet: TMyQuery);
    procedure GetQueryFormPaymentsExpenses;
    procedure GetQueryFormPaymentsRevenues;
    procedure GetQuerySubCategoryExpenses;
    procedure GetQuerySubCategoryRevenues;
    procedure GetQueryCategoryExpenses;
    procedure GetQueryCategoryRevenues;
    procedure MakePayment;
    destructor Destroy; override;

    property DataSet: TMyQuery read FDataSet write FDataSet;
    property SearchFiltersCustomized: TSearchFiltersCustomized read FSearchFiltersCustomized write FSearchFiltersCustomized;
    property Id: Integer read FId write FId;
    property UniqueId: string read FUniqueId write FUniqueId;
    property Description: string read FDescription write FDescription;
    property SubCategory: TSubCategory read FSubCategory write FSubCategory;
    property FormPayment: TFormPayment read FFormPayment write FFormPayment;
    property IssueDate: TDateTime read FIssueDate write FIssueDate;
    property InstallmentValue: Currency read FInstallmentValue write FInstallmentValue;
    property NumberParcel: Integer read FNumberParcel write FNumberParcel;
    property TypeMovement: TTypeMovement read FTypeMovement write FTypeMovement;
    property Provider: TProvider read FProvider write FProvider;
    property Customer: TCustomer read FCustomer write FCustomer;
    property Situation: Byte read FSituation write FSituation;
    property QueryFormPaymentsRevenues: TMyQuery read FQueryFormPaymentsRevenues write FQueryFormPaymentsRevenues;
    property QueryFormPaymentsExpenses: TMyQuery read FQueryFormPaymentsExpenses write FQueryFormPaymentsExpenses;
    property QuerySubCategorysRevenues: TMyQuery read FQuerySubCategorysRevenues write FQuerySubCategorysRevenues;
    property QuerySubCategorysExpenses: TMyQuery read FQuerySubCategorysExpenses write FQuerySubCategorysExpenses;
    property QueryCategorysRevenues: TMyQuery read FQueryCategorysRevenues write FQueryCategorysRevenues;
    property QueryCategorysExpenses: TMyQuery read FQueryCategorysExpenses write FQueryCategorysExpenses;


    {

CREATE TABLE MOVEMENT (
	ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	UNIQUE_ID TEXT(200) NOT NULL,
	DESCRIPTION TEXT(300) NOT NULL,
	ID_SUB_CATEGORY INTEGER,
	ID_FORM_PAYMENT INTEGER,
	ISSUE_DATE DATETIME
,   INSTALLMENT_VALUE DOUBLE DEFAULT 0, NUMBER_PARCEL INTEGER DEFAULT 0, TYPE_MOVEMENT INTEGER DEFAULT 0, ID_PROVIDER INTEGER);
  }

end;

implementation

uses
  uSystemManager;

{ TSearchFiltersCustomized }

procedure TMovement.Clear;
begin
  FId := 0;
  FSubCategory.Clear;
  FDescription := emptystr;
  FUniqueId := emptystr;
  FFormPayment.Clear;
  FIssueDate := 0;
  FInstallmentValue := 0;
  FNumberParcel := 0;
  FTypeMovement := tmRevenues;
  FProvider.Clear;
  FCustomer.Clear;
  FSituation := 0;
end;

constructor TMovement.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
  FFormPayment := TFormPayment.Create;
  FSubCategory := TSubCategory.Create;
  FProvider := TProvider.Create;
  FCustomer := TCustomer.Create;
  FQueryFormPaymentsRevenues := TMyQuery.Create(nil);
  FQueryFormPaymentsExpenses := TMyQuery.Create(nil);
  FQuerySubCategorysRevenues := TMyQuery.Create(nil);
  FQuerySubCategorysExpenses := TMyQuery.Create(nil);
  FQueryCategorysRevenues := TMyQuery.Create(nil);
  FQueryCategorysExpenses := TMyQuery.Create(nil);
end;

procedure TMovement.DeleteRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM MOVEMENT         ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID = :UNIQUE_ID ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_DELETE);
    end;
  end;
end;

destructor TMovement.Destroy;
begin
  FQueryCategorysExpenses.Free;
  FQueryCategorysRevenues.Free;
  FQuerySubCategorysExpenses.Free;
  FQuerySubCategorysRevenues.Free;
  FQueryFormPaymentsExpenses.Free;
  FQueryFormPaymentsRevenues.Free;
  FCustomer.Free;
  FProvider.Free;
  FSubCategory.Free;
  FFormPayment.Free;
  FSearchFiltersCustomized.Free;
  FDataSet.Free;
  inherited;
end;

procedure TMovement.GetById;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('SELECT                ');
    FDataSet.SQL.Add('    ID                ');
    FDataSet.SQL.Add('  , UNIQUE_ID         ');
    FDataSet.SQL.Add('  , DESCRIPTION       ');
    FDataSet.SQL.Add('  , ID_SUB_CATEGORY   ');
    FDataSet.SQL.Add('  , ID_FORM_PAYMENT   ');
    FDataSet.SQL.Add('  , ISSUE_DATE        ');
    FDataSet.SQL.Add('  , INSTALLMENT_VALUE ');
    FDataSet.SQL.Add('  , NUMBER_PARCEL     ');
    FDataSet.SQL.Add('  , TYPE_MOVEMENT     ');
    FDataSet.SQL.Add('  , ID_PROVIDER       ');
    FDataSet.SQL.Add('  , SITUATION         ');
    FDataSet.SQL.Add('FROM MOVEMENT         ');
    FDataSet.SQL.Add('  WHERE ID = :ID      ');
    FDataSet.ParamByName('ID').AsInteger := FId;
    FDataSet.Open;

    if not (FDataSet.IsEmpty) then
    begin
      FId := FDataSet.FieldByName('ID').AsInteger;
      FSubCategory.Id := FDataSet.FieldByName('ID_SUB_CATEGORY').AsInteger;
      FSubCategory.GetById;
      FDescription := FDataSet.FieldByName('DESCRIPTION').AsString;
      FUniqueId := FDataSet.FieldByName('UNIQUE_ID').AsString;
      FFormPayment.Id := FDataSet.FieldByName('ID_FORM_PAYMENT').AsInteger;
      FFormPayment.GetById;
      FIssueDate := FDataSet.FieldByName('ISSUE_DATE').AsDateTime;
      FInstallmentValue := FDataSet.FieldByName('INSTALLMENT_VALUE').AsCurrency;
      FNumberParcel := FDataSet.FieldByName('NUMBER_PARCEL').AsInteger;
      FTypeMovement := TTypeMovement(FDataSet.FieldByName('TYPE_MOVEMENT').AsInteger);
      FProvider.Id := FDataSet.FieldByName('ID_PROVIDER').AsInteger;
      FProvider.GetById;
      FSituation := FDataSet.FieldByName('SITUATION').AsInteger;
    end;

  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_MOVEMENT_PAYMENT);
    end;
  end;
end;

procedure TMovement.GetQueryCategoryExpenses;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                 ');
    lSql.Add('  c.name,                              ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL       ');
    lSql.Add('from MOVEMENT m                        ');
    lSql.Add('left join SUB_CATEGORY sc              ');
    lSql.Add('on (sc.id=m.ID_SUB_CATEGORY)           ');
    lSql.Add('left join CATEGORY c                   ');
    lSql.Add('on (c.id=sc.ID_CATEGORY)               ');
    lSql.Add('where m.TYPE_MOVEMENT = ''1''          ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and c.name not NULL                          ');
    lSql.Add('group by c.name                              ');
    lSql.Add('order by c.name                              ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQueryCategorysExpenses.Close;
    FQueryCategorysExpenses.SQL.Clear;
    FQueryCategorysExpenses.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQueryCategorysExpenses.Open;
    TFunctions.FormatDataSetDecimalFields(FQueryCategorysExpenses, '#,##0.00');

  finally
    lSql.Free;
  end;
end;

procedure TMovement.GetQueryCategoryRevenues;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                 ');
    lSql.Add('  c.name,                              ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL       ');
    lSql.Add('from MOVEMENT m                        ');
    lSql.Add('left join SUB_CATEGORY sc              ');
    lSql.Add('on (sc.id=m.ID_SUB_CATEGORY)           ');
    lSql.Add('left join CATEGORY c                   ');
    lSql.Add('on (c.id=sc.ID_CATEGORY)               ');
    lSql.Add('where m.TYPE_MOVEMENT = ''0''          ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and c.name not NULL                          ');
    lSql.Add('group by c.name                              ');
    lSql.Add('order by c.name                              ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQueryCategorysRevenues.Close;
    FQueryCategorysRevenues.SQL.Clear;
    FQueryCategorysRevenues.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQueryCategorysRevenues.Open;
    TFunctions.FormatDataSetDecimalFields(FQueryCategorysRevenues, '#,##0.00');

  finally
    lSql.Free;
  end;
end;

procedure TMovement.GetQueryFormPaymentsExpenses;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                       ');
    lSql.Add('  fp.name,                                   ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL             ');
    lSql.Add('from MOVEMENT m                              ');
    lSql.Add('left join FORM_PAYMENT fp                    ');
    lSql.Add('on (fp.id=m.ID_FORM_PAYMENT)                 ');
    lSql.Add('where m.TYPE_MOVEMENT = ''1''                ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and fp.name not NULL                         ');
    lSql.Add('group by fp.name                             ');
    lSql.Add('order by fp.name                             ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQueryFormPaymentsExpenses.Close;
    FQueryFormPaymentsExpenses.SQL.Clear;
    FQueryFormPaymentsExpenses.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQueryFormPaymentsExpenses.Open;
    TFunctions.FormatDataSetDecimalFields(FQueryFormPaymentsExpenses, '#,##0.00');

  finally
    lSql.Free;
  end;
end;

procedure TMovement.GetQueryFormPaymentsRevenues;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                       ');
    lSql.Add('  fp.name,                                   ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL             ');
    lSql.Add('from MOVEMENT m                              ');
    lSql.Add('left join FORM_PAYMENT fp                    ');
    lSql.Add('on (fp.id=m.ID_FORM_PAYMENT)                 ');
    lSql.Add('where m.TYPE_MOVEMENT = ''0''                ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and fp.name not NULL                         ');
    lSql.Add('group by fp.name                             ');
    lSql.Add('order by fp.name                             ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQueryFormPaymentsRevenues.Close;
    FQueryFormPaymentsRevenues.SQL.Clear;
    FQueryFormPaymentsRevenues.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQueryFormPaymentsRevenues.Open;
    TFunctions.FormatDataSetDecimalFields(FQueryFormPaymentsRevenues, '#,##0.00');

  finally
    lSql.Free;
  end;

end;

procedure TMovement.GetQuerySubCategoryExpenses;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                       ');
    lSql.Add('  sc.name,                                   ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL             ');
    lSql.Add('from MOVEMENT m                              ');
    lSql.Add('left join SUB_CATEGORY sc                    ');
    lSql.Add('on (sc.id=m.ID_SUB_CATEGORY)                 ');
    lSql.Add('where m.TYPE_MOVEMENT = ''1''                ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and sc.name not NULL                         ');
    lSql.Add('group by sc.name                             ');
    lSql.Add('order by sc.name                             ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQuerySubCategorysExpenses.Close;
    FQuerySubCategorysExpenses.SQL.Clear;
    FQuerySubCategorysExpenses.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQuerySubCategorysExpenses.Open;
    TFunctions.FormatDataSetDecimalFields(FQuerySubCategorysExpenses, '#,##0.00');

  finally
    lSql.Free;
  end;
end;

procedure TMovement.GetQuerySubCategoryRevenues;
var
  lSql: TStringList;
begin

  lSql := TStringList.Create;
  try
    lSql.Add('select                                       ');
    lSql.Add('  sc.name,                                   ');
    lSql.Add('  sum(m.INSTALLMENT_VALUE) TOTAL             ');
    lSql.Add('from MOVEMENT m                              ');
    lSql.Add('left join SUB_CATEGORY sc                    ');
    lSql.Add('on (sc.id=m.ID_SUB_CATEGORY)                 ');
    lSql.Add('where m.TYPE_MOVEMENT = ''0''                ');

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('and m.situation = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('and strftime(''%m'', m.issue_date) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    if FSearchFiltersCustomized.Year > 0 then
    begin
      lSql.Add('and strftime(''%Y'', m.issue_date) = ' + QuotedStr(FSearchFiltersCustomized.Year.ToString));
    end;

    lSql.Add('and sc.name not NULL                          ');
    lSql.Add('group by sc.name                              ');
    lSql.Add('order by sc.name                              ');

    TDataBaseConnection.GetInstance.NewConnection;
    FQuerySubCategorysRevenues.Close;
    FQuerySubCategorysRevenues.SQL.Clear;
    FQuerySubCategorysRevenues.SQL.Add(lSql.Text);
    //ShowMessage(lSql.Text);
    FQuerySubCategorysRevenues.Open;
    TFunctions.FormatDataSetDecimalFields(FQuerySubCategorysRevenues, '#,##0.00');

  finally
    lSql.Free;
  end;
end;

procedure TMovement.InsertRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('INSERT INTO MOVEMENT ( ');
    FDataSet.SQL.Add('  UNIQUE_ID            ');
    FDataSet.SQL.Add(', DESCRIPTION          ');
    FDataSet.SQL.Add(', ID_SUB_CATEGORY      ');
    FDataSet.SQL.Add(', ID_FORM_PAYMENT      ');
    FDataSet.SQL.Add(', ISSUE_DATE           ');
    FDataSet.SQL.Add(', INSTALLMENT_VALUE    ');
    FDataSet.SQL.Add(', NUMBER_PARCEL        ');
    FDataSet.SQL.Add(', TYPE_MOVEMENT        ');
    FDataSet.SQL.Add(', ID_PROVIDER          ');
    FDataSet.SQL.Add(', SITUATION            ');
    FDataSet.SQL.Add(', ID_USER              ');
    FDataSet.SQL.Add(') VALUES (             ');
    FDataSet.SQL.Add('  :UNIQUE_ID           ');
    FDataSet.SQL.Add(', :DESCRIPTION         ');
    FDataSet.SQL.Add(', :ID_SUB_CATEGORY     ');
    FDataSet.SQL.Add(', :ID_FORM_PAYMENT     ');
    FDataSet.SQL.Add(', :ISSUE_DATE          ');
    FDataSet.SQL.Add(', :INSTALLMENT_VALUE   ');
    FDataSet.SQL.Add(', :NUMBER_PARCEL       ');
    FDataSet.SQL.Add(', :TYPE_MOVEMENT       ');
    FDataSet.SQL.Add(', :ID_PROVIDER         ');
    FDataSet.SQL.Add(', :SITUATION           ');
    FDataSet.SQL.Add(', :ID_USER             ');
    FDataSet.SQL.Add(');                     ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := TFunctions.GenerateUUID;
    FDataSet.ParamByName('DESCRIPTION').AsString := FDescription;
    FDataSet.ParamByName('ID_SUB_CATEGORY').AsInteger := FSubCategory.Id;
    FDataSet.ParamByName('ID_FORM_PAYMENT').AsInteger := FFormPayment.Id;
    FDataSet.ParamByName('ISSUE_DATE').AsDate := FIssueDate;
    FDataSet.ParamByName('INSTALLMENT_VALUE').AsCurrency := FInstallmentValue;
    FDataSet.ParamByName('NUMBER_PARCEL').AsInteger := FNumberParcel;
    FDataSet.ParamByName('TYPE_MOVEMENT').AsInteger := Integer(FTypeMovement);
    FDataSet.ParamByName('ID_PERSON').AsInteger := FProvider.Id;
    FDataSet.ParamByName('SITUATION').AsInteger := FSituation;
    FDataSet.ParamByName('ID_USER').AsInteger := TSystemManager.GetInstance.LoggedUser.Id;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_MOVEMENT_PAYMENT);
    end;
  end;
end;

procedure TMovement.MakePayment;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE MOVEMENT SET                       ');
    FDataSet.SQL.Add('   SITUATION         = :SITUATION         ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID      = :UNIQUE_ID;        ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('SITUATION').AsInteger := 1;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_MOVEMENT_PAYMENT);
    end;
  end;
end;

procedure TMovement.Search(ADataSet: TMyQuery);
var
  lSQL: TStringList;
begin

  TDatabaseConnection.GetInstance.NewConnection;

  lSQL := TStringList.Create;
  try
    lSQL.Clear;
    lSQL.Add('SELECT                               ');
    lSQL.Add('    M.ID                             ');
    lSQL.Add('  , M.UNIQUE_ID                      ');
    lSQL.Add('  , M.DESCRIPTION       "Descri��o"  ');
    lSQL.Add('  , M.ID_SUB_CATEGORY                ');
    lSQL.Add('  , M.ID_FORM_PAYMENT                ');
    lSQL.Add('  , M.ISSUE_DATE        "Vencimento" ');
    lSQL.Add('  , M.INSTALLMENT_VALUE "R$ Valor"   ');
    lSQL.Add('  , M.NUMBER_PARCEL     "N�mero"     ');
    lSQL.Add('  , CASE M.TYPE_MOVEMENT             ');
    lSQL.Add('      WHEN 0 THEN "Entrada"          ');
    lSQL.Add('      ELSE "Sa�da"                   ');
    lSQL.Add('    END "Tipo"                       ');
    lSQL.Add('  , M.ID_PERSON                    ');
    lSQL.Add('  , SC.NAME "Sub Categoria"          ');
    lSQL.Add('  , FP.NAME "Forma de Pagamento"     ');
    lSQL.Add('  , P.NAME "Fornecedor"              ');
    lSQL.Add('  , CASE M.SITUATION                 ');
    lSQL.Add('      WHEN 0 THEN "N�o Pago"         ');
    lSQL.Add('      ELSE "Pago"                    ');
    lSQL.Add('    END "Situa��o"                   ');
    lSQL.Add('FROM MOVEMENT M                      ');
    lSQL.Add('  LEFT JOIN SUB_CATEGORY SC          ');
    lSQL.Add('  ON (SC.ID = M.ID_SUB_CATEGORY)     ');
    lSQL.Add('  LEFT JOIN FORM_PAYMENT FP          ');
    lSQL.Add('  ON (FP.ID = M.ID_FORM_PAYMENT)     ');
    lSQL.Add('  LEFT JOIN PERSON P                 ');
    lSQL.Add('  ON (P.ID  = M.ID_PERSON)         ');
    lSQL.Add(' WHERE 1>0                           ');

    if (Length(Trim(FSearchFiltersCustomized.ValueSearch)) > 0) then
    begin
      lSQL.Add('AND M.DESCRIPTION LIKE ' + QuotedStr('%' + FSearchFiltersCustomized.ValueSearch + '%'));
    end;

    if FSearchFiltersCustomized.Situation >= 0 then
    begin
      lSql.Add('AND M.SITUATION = ' + FSearchFiltersCustomized.Situation.ToString);
    end;

    if FSearchFiltersCustomized.Month > 0 then
    begin
      lSql.Add('AND STRFTIME(''%m'', M.ISSUE_DATE) = ' + QuotedStr(FormatFloat('00', FSearchFiltersCustomized.Month)));
      lSql.Add('AND STRFTIME(''%Y'', M.ISSUE_DATE) = ' + QuotedStr(YearOf(Now).tostring));
    end;

    lSQL.Add('ORDER BY M.DESCRIPTION DESC   ');

    lSQL.SaveToFile(TFunctions.ApplicationPath + 'TMovement.Search.txt');

    ADataSet.Close;
    ADataSet.SQL.Clear;
    ADataSet.SQL.Add(lSQL.Text);
    ADataSet.Open;
    TFunctions.FormatDataSetDecimalFields(ADataSet, '#,##0.00');

  finally
    lSQL.Free;
  end;

end;

procedure TMovement.UpdateRegister;
begin
  try
    TDataBaseConnection.GetInstance.NewConnection;
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('UPDATE MOVEMENT SET                       ');
    FDataSet.SQL.Add('   DESCRIPTION       = :DESCRIPTION       ');
    FDataSet.SQL.Add(' , ID_SUB_CATEGORY   = :ID_SUB_CATEGORY   ');
    FDataSet.SQL.Add(' , ID_FORM_PAYMENT   = :ID_FORM_PAYMENT   ');
    FDataSet.SQL.Add(' , ISSUE_DATE        = :ISSUE_DATE        ');
    FDataSet.SQL.Add(' , INSTALLMENT_VALUE = :INSTALLMENT_VALUE ');
    FDataSet.SQL.Add(' , NUMBER_PARCEL     = :NUMBER_PARCEL     ');
    FDataSet.SQL.Add(' , TYPE_MOVEMENT     = :TYPE_MOVEMENT     ');
    FDataSet.SQL.Add(' , ID_PERSON       = :ID_PERSON       ');
    FDataSet.SQL.Add(' , SITUATION         = :SITUATION         ');
    FDataSet.SQL.Add('WHERE UNIQUE_ID      = :UNIQUE_ID;        ');
    FDataSet.ParamByName('DESCRIPTION').AsString := FDescription;
    FDataSet.ParamByName('ID_SUB_CATEGORY').AsInteger := FSubCategory.Id;
    FDataSet.ParamByName('ID_FORM_PAYMENT').AsInteger := FFormPayment.Id;
    FDataSet.ParamByName('ISSUE_DATE').AsDate := FIssueDate;
    FDataSet.ParamByName('INSTALLMENT_VALUE').AsCurrency := FInstallmentValue;
    FDataSet.ParamByName('NUMBER_PARCEL').AsInteger := FNumberParcel;
    FDataSet.ParamByName('TYPE_MOVEMENT').AsInteger := Integer(FTypeMovement);
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('ID_PERSON').AsInteger := FProvider.Id;
    FDataSet.ParamByName('SITUATION').AsInteger := FSituation;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      TFrmMessage.ShowMessageBox(mtError, '', MSG_ERROR_MOVEMENT_PAYMENT);
    end;
  end;
end;

end.
