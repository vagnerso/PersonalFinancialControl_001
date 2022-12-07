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
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMovement: TMovement;
    FBackgroundColor: TColor;
    FTitleColor: TColor;
    FTitleFontColor: TColor;
    FPanelBottomColor: TColor;
    procedure SetColors;
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
  SetColors;

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

end.
