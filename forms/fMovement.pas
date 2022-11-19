unit fMovement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, fGeneralSearch, uEnumTypes,
  FireDAC.Comp.Client;

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
    imButtonClearEdtCategory: TImage;
    imButtonSearchCategory: TImage;
    tabInstallments: TTabSheet;
    pnlInstallments: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNumberInstallments: TEdit;
    pnlButtonInstallmentsGenerate: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    grInstallments: TDBGrid;
    dtsInstallments: TDataSource;
    Label4: TLabel;
    edtInstallmentesValue: TEdit;
    Label5: TLabel;
    Image1: TImage;
    Image2: TImage;
    Edit1: TEdit;
    procedure imButtonSearchCategoryClick(Sender: TObject);
    procedure edtNumberInstallmentsClick(Sender: TObject);
    procedure pnlButtonInstallmentsGenerateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FMemInstallmentsList: TFDMemTable;

    procedure InstallmentsGenerate;

    { Private declarations }
  public
    { Public declarations }
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
  end
  else
  begin
    pnlButtonInstallmentsGenerate.Visible := False;
  end;

end;

procedure TfrmMovement.FormCreate(Sender: TObject);
begin
  inherited;
  FMemInstallmentsList := TFDMemTable.Create(Self);
end;

procedure TfrmMovement.FormShow(Sender: TObject);
begin
  inherited;
  pgcNavigator.ActivePage := tabDescription;
end;

procedure TfrmMovement.imButtonSearchCategoryClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setFormPayment;
    frmGeneralSearch.ShowModal;
    edtFormPayment.Text := frmGeneralSearch.FormPayment.Name;

  finally
    frmGeneralSearch.Free;
  end;

end;

procedure TfrmMovement.InstallmentsGenerate;
var
  numberInstallments: Integer;
  I: Integer;

begin

  numberInstallments := StrToIntDef(edtNumberInstallments.Text, 1);

  dtsInstallments.DataSet := FMemInstallmentsList;

  FMemInstallmentsList.FieldDefs.Add('id', ftInteger);
  FMemInstallmentsList.FieldDefs.Add('name', ftString, 300);
  FMemInstallmentsList.FieldDefs.Add('valor', ftFloat);
  FMemInstallmentsList.CreateDataSet;

  for I := 0 to numberInstallments - 1 do
  begin
    FMemInstallmentsList.Append;
    FMemInstallmentsList.FieldByName('id').AsInteger := i;
    FMemInstallmentsList.FieldByName('name').AsString := edtDescription.Text;
    FMemInstallmentsList.FieldByName('valor').AsFloat := StrToFloat(edtInstallmentesValue.Text);
    FMemInstallmentsList.Post;
  end;

  grInstallments.Columns[0].Width := 80;
  grInstallments.Columns[1].Width := 300;
  grInstallments.Columns[2].Width := 140;

  pgcNavigator.ActivePage := tabInstallments;

end;

procedure TfrmMovement.pnlButtonInstallmentsGenerateClick(Sender: TObject);
begin
  inherited;
  InstallmentsGenerate;
end;

end.