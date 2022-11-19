unit uMovement;

interface

uses
  uSearchFilters, uDataBaseConnection, uSubCategory, uFormPayment,
  System.SysUtils, Vcl.Dialogs, uAppConstants, System.Classes;

type TSearchFiltersCustomized = class(TSearchFilters)
  private

  public
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
    FTypeMovement: string;
  public
    constructor Create;

    procedure InsertRegister;
    procedure UpdateRegister;
    procedure DeleteRegister;
    procedure Clear;
    procedure GetById;
    procedure Search(ADataSet: TMyQuery);
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
    property TypeMovement: string read FTypeMovement write FTypeMovement;

    {

CREATE TABLE MOVEMENT (
	ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	UNIQUE_ID TEXT(200) NOT NULL,
	DESCRIPTION TEXT(300) NOT NULL,
	ID_SUB_CATEGORY INTEGER,
	ID_FORM_PAYMENT INTEGER,
	ISSUE_DATE DATETIME
,   INSTALLMENT_VALUE NUMERIC DEFAULT 0, NUMBER_PARCEL INTEGER DEFAULT 0, TYPE_MOVEMENT TEXT(1));

  }

end;

implementation

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
  FTypeMovement := emptystr;
end;

constructor TMovement.Create;
begin
  FDataSet := TMyQuery.Create(nil);
  FSearchFiltersCustomized := TSearchFiltersCustomized.Create;
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
      Showmessage(MSG_ERROR_DELETE);
    end;
  end;
end;

destructor TMovement.Destroy;
begin
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
      FTypeMovement := FDataSet.FieldByName('TYPE_MOVEMENT').AsString;
    end;

  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_SUB_CATEGORY_INSERT);
    end;
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
    FDataSet.SQL.Add(') VALUES (             ');
    FDataSet.SQL.Add('  :UNIQUE_ID           ');
    FDataSet.SQL.Add(', :DESCRIPTION         ');
    FDataSet.SQL.Add(', :ID_SUB_CATEGORY     ');
    FDataSet.SQL.Add(', :ID_FORM_PAYMENT     ');
    FDataSet.SQL.Add(', :ISSUE_DATE          ');
    FDataSet.SQL.Add(', :INSTALLMENT_VALUE   ');
    FDataSet.SQL.Add(', :NUMBER_PARCEL       ');
    FDataSet.SQL.Add(', :TYPE_MOVEMENT       ');
    FDataSet.SQL.Add(');                     ');
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ParamByName('DESCRIPTION').AsString := FDescription;
    FDataSet.ParamByName('ID_SUB_CATEGORY').AsInteger := FSubCategory.Id;
    FDataSet.ParamByName('ID_FORM_PAYMENT').AsInteger := FFormPayment.Id;
    FDataSet.ParamByName('ISSUE_DATE').AsDate := FIssueDate;
    FDataSet.ParamByName('INSTALLMENT_VALUE').AsCurrency := FInstallmentValue;
    FDataSet.ParamByName('NUMBER_PARCEL').AsInteger := FNumberParcel;
    FDataSet.ParamByName('TYPE_MOVEMENT').AsString := FTypeMovement;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_INSERT);
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
    lSQL.Add('SELECT                           ');
    lSQL.Add('    ID                           ');
    lSQL.Add('  , M.UNIQUE_ID                  ');
    lSQL.Add('  , M.DESCRIPTION                ');
    lSQL.Add('  , M.ID_SUB_CATEGORY            ');
    lSQL.Add('  , M.ID_FORM_PAYMENT            ');
    lSQL.Add('  , M.ISSUE_DATE                 ');
    lSQL.Add('  , M.INSTALLMENT_VALUE          ');
    lSQL.Add('  , M.NUMBER_PARCEL              ');
    lSQL.Add('  , M.TYPE_MOVEMENT              ');
    lSQL.Add('FROM MOVEMENT M                  ');
    lSQL.Add('  LEFT JOIN SUB_CATEGORY SC      ');
    lSQL.Add('  ON (SC.ID = M.ID_SUB_CATEGORY) ');
    lSQL.Add('  LEFT JOIN FORM_PAYMENT FP      ');
    lSQL.Add('  ON (FP.ID = M.ID_FORM_PAYMENT) ');

    if (Length(Trim(FSearchFiltersCustomized.ValueSearch)) > 0) then
    begin
      lSQL.Add('WHERE M.DESCRIPTION LIKE ' + QuotedStr('%' + FSearchFiltersCustomized.ValueSearch + '%'));
    end;

    lSQL.Add('ORDER BY M.DESCRIPTION DESC   ');

    ADataSet.Close;
    ADataSet.SQL.Clear;
    ADataSet.SQL.Add(lSQL.Text);
    ADataSet.Open;

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
    FDataSet.SQL.Add('WHERE UNIQUE_ID      = :UNIQUE_ID;        ');
    FDataSet.ParamByName('DESCRIPTION').AsString := FDescription;
    FDataSet.ParamByName('ID_SUB_CATEGORY').AsInteger := FSubCategory.Id;
    FDataSet.ParamByName('ID_FORM_PAYMENT').AsInteger := FFormPayment.Id;
    FDataSet.ParamByName('ISSUE_DATE').AsDate := FIssueDate;
    FDataSet.ParamByName('INSTALLMENT_VALUE').AsCurrency := FInstallmentValue;
    FDataSet.ParamByName('NUMBER_PARCEL').AsInteger := FNumberParcel;
    FDataSet.ParamByName('TYPE_MOVEMENT').AsString := FTypeMovement;
    FDataSet.ParamByName('UNIQUE_ID').AsString := FUniqueId;
    FDataSet.ExecSQL;
    FDataSet.Connection.Commit;
  except on E: Exception do
    begin
      FDataSet.Connection.Rollback;
      Showmessage(MSG_ERROR_INSERT);
    end;
  end;
end;

end.
