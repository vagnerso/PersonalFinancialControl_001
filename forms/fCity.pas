unit fCity;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uCity;

type
  TfrmCity = class(TfrmMasterRegister)
    edtName: TEdit;
    lb3: TLabel;
    edtSefazCode: TEdit;
    Label1: TLabel;
    lb2: TLabel;
    cbxUF: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
 private
    FRegisterObject: TCity;
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

    property RegisterObject: TCity read FRegisterObject write FRegisterObject;
  end;

var
  frmCity: TfrmCity;

implementation

uses
  uEnumTypes, uFunctions;

{$R *.dfm}

{ TfrmCity }

procedure TfrmCity.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmCity.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmCity.CloseForm;
begin
  inherited;
  Close;
end;

procedure TfrmCity.DeleteRegister;
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

procedure TfrmCity.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmCity.EditRegister;
begin
  inherited;
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;
  edtSefazCode.Text := dtsSearch.DataSet.FieldByName('Cod. Cidade').AsString;
  cbxUF.ItemIndex := cbxUF.Items.IndexOf(dtsSearch.DataSet.FieldByName('UF').AsString);
  edtName.SetFocus;
end;

procedure TfrmCity.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmCity.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TCity.Create;
end;

procedure TfrmCity.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmCity.FormShow(Sender: TObject);
begin
  FTitleForm := 'Cidades';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  searchExecute;
end;

procedure TfrmCity.InsertRegister;
begin
  inherited;
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtName.SetFocus;
end;

procedure TfrmCity.PrintRegister;
begin
  inherited;

end;

procedure TfrmCity.SaveRegister;
begin
  inherited;
  FRegisterObject.Name := edtName.Text;
  FRegisterObject.SefazCode := StrToIntDef(edtSefazCode.Text, 0);
  FRegisterObject.UF := cbxUF.Text;

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

procedure TfrmCity.SearchExecute;
begin
  inherited;
  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 400;
end;

end.
