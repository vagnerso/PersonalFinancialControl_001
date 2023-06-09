unit fUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uUser;

type
  TfrmUser = class(TfrmMasterRegister)
    lb3: TLabel;
    edtName: TEdit;
    Label1: TLabel;
    edtLogin: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FRegisterObject: TUser;
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

    property RegisterObject: TUser read FRegisterObject write FRegisterObject;
  end;

var
  frmUser: TfrmUser;

implementation

uses
  uEnumTypes, uFunctions;

{$R *.dfm}

{ TfrmUser }

procedure TfrmUser.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmUser.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmUser.CloseForm;
begin
  inherited;
  Close;
end;

procedure TfrmUser.DeleteRegister;
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

procedure TfrmUser.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmUser.EditRegister;
begin
  inherited;
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;
  edtLogin.Text := dtsSearch.DataSet.FieldByName('Login').AsString;
  edtPassword.Text := dtsSearch.DataSet.FieldByName('Senha').AsString;
  edtName.SetFocus;
end;

procedure TfrmUser.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmUser.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TUser.Create;
end;

procedure TfrmUser.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmUser.FormShow(Sender: TObject);
begin
  FTitleForm := 'Usuários';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  searchExecute;
end;

procedure TfrmUser.InsertRegister;
begin
  inherited;
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtName.SetFocus;
end;

procedure TfrmUser.PrintRegister;
begin
  inherited;

end;

procedure TfrmUser.SaveRegister;
begin
  inherited;
  FRegisterObject.Name := edtName.Text;
  FRegisterObject.Login := edtLogin.Text;
  FRegisterObject.Password := edtPassword.Text;

  case FOperationType of
    otInsert:
    begin
      FRegisterObject.InsertRegister;
    end;
    otUpdate:
    begin
      FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
      FRegisterObject.Name := edtName.Text;
      FRegisterObject.Login := edtLogin.Text;
      FRegisterObject.Password := edtPassword.Text;
      FRegisterObject.UpdateRegister;
    end;
  end;
  DisabledRegister;
  SearchExecute;
end;

procedure TfrmUser.SearchExecute;
begin
  inherited;
  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 400;
  grdSearch.Columns[3].Width := 400;
  grdSearch.Columns[4].Visible := False;
end;

end.
