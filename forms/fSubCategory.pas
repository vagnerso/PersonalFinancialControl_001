unit fSubCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uSubCategory, uEnumTypes,
  uFunctions, uCategory, fGeneralSearch;

type
  TfrmSubCategory = class(TfrmMasterRegister)
    edtName: TEdit;
    lb3: TLabel;
    Label1: TLabel;
    edtCategory: TEdit;
    dtsSearchCategory: TDataSource;
    imButtonClearEdtCategory: TImage;
    imButtonSearchCategory: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imButtonSearchCategoryClick(Sender: TObject);
    procedure imButtonClearEdtCategoryClick(Sender: TObject);
  private
    FRegisterObject: TSubCategory;
    procedure EnabledRegister;
    procedure DisabledRegister;
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
    procedure ClearFields;

    property RegisterObject: TSubCategory read FRegisterObject write FRegisterObject;
  end;

var
  frmSubCategory: TfrmSubCategory;

implementation

{$R *.dfm}

{ TfrmSubCategory }

procedure TfrmSubCategory.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmSubCategory.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmSubCategory.CloseForm;
begin
  inherited;
  // save log
  Close;
end;

procedure TfrmSubCategory.DeleteRegister;
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

procedure TfrmSubCategory.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmSubCategory.EditRegister;
begin
  inherited;
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;
  FRegisterObject.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
  FRegisterObject.GetById;
  edtCategory.Text := FRegisterObject.Category.Name;
  edtName.SetFocus;
end;

procedure TfrmSubCategory.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmSubCategory.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TSubCategory.Create;
end;

procedure TfrmSubCategory.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmSubCategory.FormShow(Sender: TObject);
begin
  FTitleForm := 'Sub-Categorias';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  searchExecute;
end;

procedure TfrmSubCategory.imButtonClearEdtCategoryClick(Sender: TObject);
begin
  inherited;
  edtCategory.Text := EmptyStr;
end;

procedure TfrmSubCategory.imButtonSearchCategoryClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;

  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setCategory;

    if frmGeneralSearch.ShowModal = mrOk then
    begin
      edtCategory.Text := frmGeneralSearch.Category.Name;
      FRegisterObject.Category.Id := frmGeneralSearch.Category.Id;
    end;

  finally
    frmGeneralSearch.Free;
  end;

end;

procedure TfrmSubCategory.InsertRegister;
begin
  inherited;
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtName.SetFocus;
end;

procedure TfrmSubCategory.PrintRegister;
begin
  inherited;

end;

procedure TfrmSubCategory.SaveRegister;
begin
  inherited;
  FRegisterObject.Name := edtName.Text;

  case FOperationType of
    otInsert:
    begin
      FRegisterObject.InsertRegister;
    end;
    otUpdate:
    begin
      FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
      FRegisterObject.Name := edtName.Text;
      FRegisterObject.UpdateRegister;
    end;
  end;
  DisabledRegister;
  SearchExecute;

end;

procedure TfrmSubCategory.SearchExecute;
begin
  inherited;

  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 300;
  grdSearch.Columns[3].Visible := False;
  grdSearch.Columns[4].Width := 300;
end;

end.
