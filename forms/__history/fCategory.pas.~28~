unit fCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  uCategory, uDataBaseConnection, uEnumTypes, Vcl.Menus, uFunctions;

type
  TfrmCategory = class(TfrmMasterRegister)
    edtName: TEdit;
    lb3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FRegisterObject: TCategory;
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

    property RegisterObject: TCategory read FRegisterObject write FRegisterObject;
  end;

var
  frmCategory: TfrmCategory;

implementation

{$R *.dfm}

procedure TfrmCategory.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmCategory.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmCategory.closeForm;
begin
  // save log
  Close;
end;

procedure TfrmCategory.DeleteRegister;
begin
  if Application.MessageBox(PChar('Deseja realmente excluir o registro?'),
     PChar(Application.Title), MB_USEGLYPHCHARS + MB_DEFBUTTON2) = ID_NO then
  begin
    Abort;
  end;

  FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
  FRegisterObject.DeleteRegister;
  SearchExecute;
end;

procedure TfrmCategory.EditRegister;
begin
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;
  edtName.SetFocus;
end;

procedure TfrmCategory.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TCategory.Create;
end;

procedure TfrmCategory.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmCategory.FormShow(Sender: TObject);
begin
  FTitleForm := 'Categorias';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  searchExecute;
end;

procedure TfrmCategory.InsertRegister;
begin
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtName.SetFocus;
end;

procedure TfrmCategory.PrintRegister;
begin

end;

procedure TfrmCategory.SaveRegister;
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

procedure TfrmCategory.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmCategory.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmCategory.SearchExecute;
begin

  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Width := 0;
  grdSearch.Columns[1].Width := 0;
  grdSearch.Columns[2].Width := 400;
end;

end.
