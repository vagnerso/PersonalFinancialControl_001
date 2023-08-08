unit fMovementGraphics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, uMovement, VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, VCLTee.Series,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  uSystemManager;

type
  TfrmMovementGraphics = class(TfrmBase)
    dtsFormPaymentsExpenses: TDataSource;
    pnlTitle: TPanel;
    pnlBottom: TPanel;
    pgcGeneral: TPageControl;
    tabGraphics: TTabSheet;
    tabLists: TTabSheet;
    tabTotals: TTabSheet;
    scrGraphics: TScrollBox;
    dtsFormPaymentsRevenues: TDataSource;
    pnlFilters: TPanel;
    dtsSubCategorysExpenses: TDataSource;
    dtsSubCategorysRevenues: TDataSource;
    dtsCategorysExpenses: TDataSource;
    dtsCategorysRevenues: TDataSource;
    scrLists: TScrollBox;
    scrTotals: TScrollBox;
    pn1: TPanel;
    grdFormPaymentsExpenses: TDBGrid;
    Panel1: TPanel;
    grdFormPaymentsRevenues: TDBGrid;
    Panel2: TPanel;
    grdSubCategorysExpenses: TDBGrid;
    Panel3: TPanel;
    grdSubCategorysRevenues: TDBGrid;
    Panel4: TPanel;
    grdCategorysExpenses: TDBGrid;
    Panel5: TPanel;
    grdCategorysRevenues: TDBGrid;
    chtFormPaymentsExpenses: TChart;
    Series2: TPieSeries;
    chtCategoryExpenses: TChart;
    PieSeries1: TPieSeries;
    chtSubCategoryExpenses: TChart;
    PieSeries4: TPieSeries;
    chtFormPaymentsRevenues: TChart;
    PieSeries2: TPieSeries;
    chtCategoryRevenues: TChart;
    PieSeries6: TPieSeries;
    chtSubCategoryRevenues: TChart;
    PieSeries5: TPieSeries;
    lb1: TLabel;
    lb2: TLabel;
    Label1: TLabel;
    lb3: TLabel;
    lb4: TLabel;
    lb5: TLabel;
    cbxFilterSituation: TComboBox;
    lb6: TLabel;
    lblMonthYear: TLabel;
    cbxFilterMonthOrYear: TComboBox;
    edtFilterInitialDate: TDateTimePicker;
    edtFilterEndDate: TDateTimePicker;
    lblFilterInitialDate: TLabel;
    lblFilterEndDate: TLabel;
    Label3: TLabel;
    cbxFilterDateBy: TComboBox;
    btnSearchExecute: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSearchExecuteClick(Sender: TObject);
    procedure cbxFilterDateByChange(Sender: TObject);
  private
    FMovement: TMovement;
    FBackgroundColor: TColor;
    FTitleColor: TColor;
    FTitleFontColor: TColor;
    FPanelBottomColor: TColor;
    procedure SetColors;
    procedure Search;
    procedure SetInitialStateFilters;
    procedure SetFilterMonthOrYear;
    { Private declarations }
  public
    { Public declarations }
    property Movement: TMovement read FMovement write FMovement;
  end;

var
  frmMovementGraphics: TfrmMovementGraphics;

implementation

{$R *.dfm}

procedure TfrmMovementGraphics.btnSearchExecuteClick(Sender: TObject);
begin
  inherited;
  Search;
end;

procedure TfrmMovementGraphics.cbxFilterDateByChange(Sender: TObject);
begin
  inherited;
  SetFilterMonthOrYear;
end;

procedure TfrmMovementGraphics.FormCreate(Sender: TObject);
begin
  inherited;
  FMovement := TMovement.Create;
end;

procedure TfrmMovementGraphics.FormDestroy(Sender: TObject);
begin
  inherited;
  FMovement.Free;
end;


procedure TfrmMovementGraphics.Search;
var
  lDescription: string;
  lMonth: Integer;
begin
  lDescription := EmptyStr;

  FMovement.SearchFiltersCustomized.Situation := -1;
  if cbxFilterSituation.ItemIndex > 0 then
  begin
    FMovement.SearchFiltersCustomized.Situation := cbxFilterSituation.ItemIndex - 1;
  end;

  case cbxFilterDateBy.ItemIndex of
    0: // Month
      begin
        lMonth := Integer(cbxFilterMonthOrYear.Items.Objects[cbxFilterMonthOrYear.ItemIndex]);
        FMovement.SearchFiltersCustomized.Month := lMonth;
      end;
    1: // Year
      begin
        FMovement.SearchFiltersCustomized.Year := StrToIntDef(cbxFilterMonthOrYear.Text, 2020);
      end;
    2: // period
      begin
        FMovement.SearchFiltersCustomized.InitialDate := edtFilterInitialDate.Date;
        FMovement.SearchFiltersCustomized.EndDate := edtFilterEndDate.Date;
      end;
  end;

  // saídas por forma de pagamento
  chtFormPaymentsExpenses.Series[0].Clear;
  dtsFormPaymentsExpenses.DataSet := FMovement.QueryFormPaymentsExpenses;
  FMovement.GetQueryFormPaymentsExpenses;

  if not (FMovement.QueryFormPaymentsExpenses.IsEmpty) then
  begin
    FMovement.QueryFormPaymentsExpenses.First;
    while not FMovement.QueryFormPaymentsExpenses.Eof do
    begin
      lDescription := FMovement.QueryFormPaymentsExpenses.FieldByName('name').AsString;
      chtFormPaymentsExpenses.Series[0].Add(
        FMovement.QueryFormPaymentsExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryFormPaymentsExpenses.Next;
    end;
  end;
  chtFormPaymentsExpenses.Series[0].Marks.Visible := false;

  // entradas por forma de pagamento
  chtFormPaymentsRevenues.Series[0].Clear;
  dtsFormPaymentsRevenues.DataSet := FMovement.QueryFormPaymentsRevenues;
  FMovement.GetQueryFormPaymentsRevenues;

  if not (FMovement.QueryFormPaymentsRevenues.IsEmpty) then
  begin
    FMovement.QueryFormPaymentsRevenues.First;
    while not FMovement.QueryFormPaymentsRevenues.Eof do
    begin
      lDescription := FMovement.QueryFormPaymentsRevenues.FieldByName('name').AsString;
      chtFormPaymentsRevenues.Series[0].Add(
        FMovement.QueryFormPaymentsRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryFormPaymentsRevenues.Next;
    end;
  end;
  chtFormPaymentsRevenues.Series[0].Marks.Visible := false;

  // saídas por categoria
  chtSubCategoryExpenses.Series[0].Clear;
  dtsSubCategorysExpenses.DataSet := FMovement.QuerySubCategorysExpenses;
  FMovement.GetQuerySubCategoryExpenses;

  if not (FMovement.QuerySubCategorysExpenses.IsEmpty) then
  begin
    FMovement.QuerySubCategorysExpenses.First;
    while not FMovement.QuerySubCategorysExpenses.Eof do
    begin
      lDescription := FMovement.QuerySubCategorysExpenses.FieldByName('name').AsString;
      chtSubCategoryExpenses.Series[0].Add(
        FMovement.QuerySubCategorysExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QuerySubCategorysExpenses.Next;
    end;
  end;
  chtSubCategoryExpenses.Series[0].Marks.Visible := false;

  // entradas por categoria
  chtSubCategoryRevenues.Series[0].Clear;
  dtsSubCategorysRevenues.DataSet := FMovement.QuerySubCategorysRevenues;
  FMovement.GetQuerySubCategoryRevenues;

  if not (FMovement.QuerySubCategorysRevenues.IsEmpty) then
  begin
    FMovement.QuerySubCategorysRevenues.First;
    while not FMovement.QuerySubCategorysRevenues.Eof do
    begin
      lDescription := FMovement.QuerySubCategorysRevenues.FieldByName('name').AsString;
      chtSubCategoryRevenues.Series[0].Add(
        FMovement.QuerySubCategorysRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QuerySubCategorysRevenues.Next;
    end;
  end;
  chtSubCategoryRevenues.Series[0].Marks.Visible := false;

  // saídas por sub-categoria
  chtCategoryExpenses.Series[0].Clear;
  dtsCategorysExpenses.DataSet := FMovement.QueryCategorysExpenses;
  FMovement.GetQueryCategoryExpenses;

  if not (FMovement.QueryCategorysExpenses.IsEmpty) then
  begin
    FMovement.QueryCategorysExpenses.First;
    while not FMovement.QueryCategorysExpenses.Eof do
    begin
      lDescription := FMovement.QueryCategorysExpenses.FieldByName('name').AsString;
      chtCategoryExpenses.Series[0].Add(
        FMovement.QueryCategorysExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryCategorysExpenses.Next;
    end;
  end;
  chtCategoryExpenses.Series[0].Marks.Visible := false;

  // entradas por sub-categoria
  chtCategoryRevenues.Series[0].Clear;
  dtsCategorysRevenues.DataSet := FMovement.QueryCategorysRevenues;
  FMovement.GetQueryCategoryRevenues;

  if not (FMovement.QueryCategorysRevenues.IsEmpty) then
  begin
    FMovement.QueryCategorysRevenues.First;
    while not FMovement.QueryCategorysRevenues.Eof do
    begin
      lDescription := FMovement.QueryCategorysRevenues.FieldByName('name').AsString;
      chtCategoryRevenues.Series[0].Add(
        FMovement.QueryCategorysRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryCategorysRevenues.Next;
    end;
  end;
  chtCategoryRevenues.Series[0].Marks.Visible := false;

  grdFormPaymentsExpenses.Columns[0].Width := 200;
  grdFormPaymentsExpenses.Columns[1].Width := 100;
  grdSubCategorysExpenses.Columns[0].Width := 200;
  grdSubCategorysExpenses.Columns[1].Width := 100;
  grdCategorysExpenses.Columns[0].Width := 200;
  grdCategorysExpenses.Columns[1].Width := 100;
  grdFormPaymentsRevenues.Columns[0].Width := 200;
  grdFormPaymentsRevenues.Columns[1].Width := 100;
  grdSubCategorysRevenues.Columns[0].Width := 200;
  grdSubCategorysRevenues.Columns[1].Width := 100;
  grdCategorysRevenues.Columns[0].Width := 200;
  grdCategorysRevenues.Columns[1].Width := 100;

end;

procedure TfrmMovementGraphics.FormShow(Sender: TObject);
begin
  inherited;
  SetColors;
  SetInitialStateFilters;
  Search;
end;

procedure TfrmMovementGraphics.SetColors;
begin
  FBackgroundColor := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  FTitleColor := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  FTitleFontColor := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  FPanelBottomColor := TSystemManager.GetInstance.LayoutConfiguration.PanelBottomColor;

  Color := FBackgroundColor;
  pnlTitle.Color := FTitleColor;
  pnlTitle.Font.Color := FTitleFontColor;
  pnlBottom.Color := FPanelBottomColor;
end;

procedure TfrmMovementGraphics.SetInitialStateFilters;
begin
  cbxFilterSituation.ItemIndex := 0;
  cbxFilterDateBy.ItemIndex := 0;
  edtFilterInitialDate.Date := Now - 30;
  edtFilterEndDate.Date := Now;
  SetFilterMonthOrYear;
  cbxFilterMonthOrYear.ItemIndex := 0;
end;

procedure TfrmMovementGraphics.SetFilterMonthOrYear;
begin
  case cbxFilterDateBy.ItemIndex of
    0:
      // Month
      begin
        lblFilterInitialDate.Visible := False;
        lblFilterEndDate.Visible := False;
        edtFilterInitialDate.Visible := False;
        edtFilterEndDate.Visible := False;
        lblMonthYear.Visible := True;
        cbxFilterMonthOrYear.Visible := True;
        cbxFilterMonthOrYear.Items.Clear;
        cbxFilterMonthOrYear.Items.AddObject('Janeiro', TObject(1));
        cbxFilterMonthOrYear.Items.AddObject('Fevereiro', TObject(2));
        cbxFilterMonthOrYear.Items.AddObject('Março', TObject(3));
        cbxFilterMonthOrYear.Items.AddObject('Abril', TObject(4));
        cbxFilterMonthOrYear.Items.AddObject('Maio', TObject(5));
        cbxFilterMonthOrYear.Items.AddObject('Junho', TObject(6));
        cbxFilterMonthOrYear.Items.AddObject('Julho', TObject(7));
        cbxFilterMonthOrYear.Items.AddObject('Agosto', TObject(8));
        cbxFilterMonthOrYear.Items.AddObject('Setembro', TObject(9));
        cbxFilterMonthOrYear.Items.AddObject('Outubro', TObject(10));
        cbxFilterMonthOrYear.Items.AddObject('Novembro', TObject(11));
        cbxFilterMonthOrYear.Items.AddObject('Dezembro', TObject(12));
      end;
    1:
      // Year
      begin
        lblFilterInitialDate.Visible := False;
        lblFilterEndDate.Visible := False;
        edtFilterInitialDate.Visible := False;
        edtFilterEndDate.Visible := False;
        lblMonthYear.Visible := True;
        cbxFilterMonthOrYear.Visible := True;
        cbxFilterMonthOrYear.Items.Clear;
        cbxFilterMonthOrYear.Items.Add('2020');
        cbxFilterMonthOrYear.Items.Add('2021');
        cbxFilterMonthOrYear.Items.Add('2022');
        cbxFilterMonthOrYear.Items.Add('2023');
        cbxFilterMonthOrYear.Items.Add('2024');
        cbxFilterMonthOrYear.Items.Add('2025');
        cbxFilterMonthOrYear.Items.Add('2026');
        cbxFilterMonthOrYear.Items.Add('2027');
        cbxFilterMonthOrYear.Items.Add('2028');
        cbxFilterMonthOrYear.Items.Add('2029');
        cbxFilterMonthOrYear.Items.Add('2030');
      end;
    2:
      // time course
      begin
        lblFilterInitialDate.Visible := True;
        lblFilterEndDate.Visible := True;
        edtFilterInitialDate.Visible := True;
        edtFilterEndDate.Visible := True;
        lblMonthYear.Visible := False;
        cbxFilterMonthOrYear.Visible := False;
        cbxFilterMonthOrYear.Items.Clear;
      end;
  end;
end;

end.
