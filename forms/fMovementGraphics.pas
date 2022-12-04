unit fMovementGraphics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, uMovement, VclTee.TeeGDIPlus, Data.DB, VCLTee.TeEngine, VCLTee.Series,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids;

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
    chtFormPaymentsRevenues: TDBChart;
    Series1: TPieSeries;
    chtFormPaymentsExpenses: TDBChart;
    PieSeries1: TPieSeries;
    dtsFormPaymentsRevenues: TDataSource;
    pnlFilters: TPanel;
    chtSubCategoryExpenses: TDBChart;
    PieSeries2: TPieSeries;
    chtSubCategoryRevenues: TDBChart;
    PieSeries3: TPieSeries;
    dtsSubCategorysExpenses: TDataSource;
    dtsSubCategorysRevenues: TDataSource;
    chtCategoryExpenses: TDBChart;
    PieSeries4: TPieSeries;
    chtCategoryRevenues: TDBChart;
    PieSeries5: TPieSeries;
    dtsCategorysExpenses: TDataSource;
    dtsCategorysRevenues: TDataSource;
    scrLists: TScrollBox;
    scrTotals: TScrollBox;
    pn1: TPanel;
    gr1: TDBGrid;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    Panel3: TPanel;
    DBGrid3: TDBGrid;
    Panel4: TPanel;
    DBGrid4: TDBGrid;
    Panel5: TPanel;
    DBGrid5: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMovement: TMovement;
    { Private declarations }
  public
    { Public declarations }
    property Movement: TMovement read FMovement write FMovement;
  end;

var
  frmMovementGraphics: TfrmMovementGraphics;

implementation

{$R *.dfm}

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

procedure TfrmMovementGraphics.FormShow(Sender: TObject);
var
  I:Integer;
  lDescription: string;
begin
  inherited;

  I:=0;
  lDescription := EmptyStr;
  chtFormPaymentsExpenses.Series[0].Clear;
  dtsFormPaymentsExpenses.DataSet := FMovement.QueryFormPaymentsExpenses;
  FMovement.GetQueryFormPaymentsExpenses;

  if not (FMovement.QueryFormPaymentsExpenses.IsEmpty) then
  begin
    FMovement.QueryFormPaymentsExpenses.First;
    while not FMovement.QueryFormPaymentsExpenses.Eof do
    begin
      lDescription := FMovement.QueryFormPaymentsExpenses.FieldByName('name').AsAnsiString;
      chtFormPaymentsExpenses.Series[0].Add(
        FMovement.QueryFormPaymentsExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryFormPaymentsExpenses.Next;
    end;
  end;
  chtFormPaymentsExpenses.Series[0].Marks.Visible := false;

  chtFormPaymentsRevenues.Series[0].Clear;
  dtsFormPaymentsRevenues.DataSet := FMovement.QueryFormPaymentsRevenues;
  FMovement.GetQueryFormPaymentsRevenues;

  if not (FMovement.QueryFormPaymentsRevenues.IsEmpty) then
  begin
    FMovement.QueryFormPaymentsRevenues.First;
    while not FMovement.QueryFormPaymentsRevenues.Eof do
    begin
      lDescription := FMovement.QueryFormPaymentsRevenues.FieldByName('name').AsAnsiString;
      chtFormPaymentsRevenues.Series[0].Add(
        FMovement.QueryFormPaymentsRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryFormPaymentsRevenues.Next;
    end;
  end;
  chtFormPaymentsRevenues.Series[0].Marks.Visible := false;

  chtSubCategoryExpenses.Series[0].Clear;
  dtsSubCategorysExpenses.DataSet := FMovement.QuerySubCategorysExpenses;
  FMovement.GetQuerySubCategoryExpenses;

  if not (FMovement.QuerySubCategorysExpenses.IsEmpty) then
  begin
    FMovement.QuerySubCategorysExpenses.First;
    while not FMovement.QuerySubCategorysExpenses.Eof do
    begin
      lDescription := FMovement.QuerySubCategorysExpenses.FieldByName('name').AsAnsiString;
      chtSubCategoryExpenses.Series[0].Add(
        FMovement.QuerySubCategorysExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QuerySubCategorysExpenses.Next;
    end;
  end;
  chtSubCategoryExpenses.Series[0].Marks.Visible := false;

  chtSubCategoryRevenues.Series[0].Clear;
  dtsSubCategorysRevenues.DataSet := FMovement.QuerySubCategorysRevenues;
  FMovement.GetQuerySubCategoryRevenues;

  if not (FMovement.QuerySubCategorysRevenues.IsEmpty) then
  begin
    FMovement.QuerySubCategorysRevenues.First;
    while not FMovement.QuerySubCategorysRevenues.Eof do
    begin
      lDescription := FMovement.QuerySubCategorysRevenues.FieldByName('name').AsAnsiString;
      chtSubCategoryRevenues.Series[0].Add(
        FMovement.QuerySubCategorysRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QuerySubCategorysRevenues.Next;
    end;
  end;
  chtSubCategoryRevenues.Series[0].Marks.Visible := false;

  chtCategoryExpenses.Series[0].Clear;
  dtsCategorysExpenses.DataSet := FMovement.QueryCategorysExpenses;
  FMovement.GetQueryCategoryExpenses;

  if not (FMovement.QueryCategorysExpenses.IsEmpty) then
  begin
    FMovement.QueryCategorysExpenses.First;
    while not FMovement.QueryCategorysExpenses.Eof do
    begin
      lDescription := FMovement.QueryCategorysExpenses.FieldByName('name').AsAnsiString;
      chtCategoryExpenses.Series[0].Add(
        FMovement.QueryCategorysExpenses.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryCategorysExpenses.Next;
    end;
  end;
  chtCategoryExpenses.Series[0].Marks.Visible := false;

  chtCategoryRevenues.Series[0].Clear;
  dtsCategorysRevenues.DataSet := FMovement.QueryCategorysRevenues;
  FMovement.GetQueryCategoryRevenues;

  if not (FMovement.QueryCategorysRevenues.IsEmpty) then
  begin
    FMovement.QueryCategorysRevenues.First;
    while not FMovement.QueryCategorysRevenues.Eof do
    begin
      lDescription := FMovement.QueryCategorysRevenues.FieldByName('name').AsAnsiString;
      chtCategoryRevenues.Series[0].Add(
        FMovement.QueryCategorysRevenues.FieldByName('total').AsCurrency,
        ' ' + lDescription,
        RGB(Random(255), Random(255), Random(255)));
      FMovement.QueryCategorysRevenues.Next;
    end;
  end;
  chtCategoryRevenues.Series[0].Marks.Visible := false;

end;

end.
