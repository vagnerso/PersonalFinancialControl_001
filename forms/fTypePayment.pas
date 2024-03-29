unit fTypePayment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uTypePayment, uEnumTypes,
  uFunctions;

type
  TfrmTypePayment = class(TfrmMasterRegister)
    lb3: TLabel;
    edtName: TEdit;
    cbxAllowsInstallment: TComboBox;
    lb2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FRegisterObject: TTypePayment;
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

    property RegisterObject: TTypePayment read FRegisterObject write FRegisterObject;
  end;

var
  frmTypePayment: TfrmTypePayment;

implementation

{$R *.dfm}

{ TfrmTypePayment }

procedure TfrmTypePayment.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmTypePayment.ClearFields;
begin
  TFunctions.clearFormFields(Self);
  cbxAllowsInstallment.ItemIndex := 0;
end;

procedure TfrmTypePayment.CloseForm;
begin
  inherited;
  // save log
  Close;
end;

procedure TfrmTypePayment.DeleteRegister;
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

procedure TfrmTypePayment.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmTypePayment.EditRegister;
begin
  inherited;

  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;

  if dtsSearch.DataSet.FieldByName('Permite Parcelamento').AsString = 'N�o' then
  begin
    cbxAllowsInstallment.ItemIndex := 0;
  end
  else
  begin
    cbxAllowsInstallment.ItemIndex := 1;
  end;


  edtName.SetFocus;
end;

procedure TfrmTypePayment.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmTypePayment.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TTypePayment.Create;
end;

procedure TfrmTypePayment.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmTypePayment.FormShow(Sender: TObject);
begin
  FTitleForm := 'Tipos de Pagamento';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  SearchExecute;

end;

procedure TfrmTypePayment.InsertRegister;
begin
  inherited;

  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  edtName.SetFocus;

end;

procedure TfrmTypePayment.PrintRegister;
begin
  inherited;

  
end;

procedure TfrmTypePayment.SaveRegister;
begin
  inherited;
  FRegisterObject.Name := edtName.Text;
  FRegisterObject.AllowsInstallment := cbxAllowsInstallment.ItemIndex = 1;

  case FOperationType of
    otInsert:
    begin
      FRegisterObject.InsertRegister;
    end;
    otUpdate:
    begin
      FRegisterObject.UniqueId := dtsSearch.DataSet.FieldByName('UNIQUE_ID').AsString;
      FRegisterObject.UpdateRegister;
    end;
  end;
  DisabledRegister;
  SearchExecute;
end;

procedure TfrmTypePayment.SearchExecute;
begin
  inherited;
  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 400;

end;

end.
