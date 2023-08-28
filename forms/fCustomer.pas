unit fCustomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, uCustomer;

type
  TfrmCustomer = class(TfrmMasterRegister)
    lb3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    imButtonClearEdtCity: TImage;
    imButtonSearchCity: TImage;
    edtName: TEdit;
    edtPhone: TEdit;
    edtEmail: TEdit;
    edtAdress: TEdit;
    edtNumber: TEdit;
    edtDistrict: TEdit;
    edtCity: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imButtonSearchCityClick(Sender: TObject);
    procedure imButtonClearEdtCityClick(Sender: TObject);
  private
    FRegisterObject: TCustomer;
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
    procedure GetTypePaymentList;

    property RegisterObject: TCustomer read FRegisterObject write FRegisterObject;
  end;

var
  frmCustomer: TfrmCustomer;

implementation

uses
  uEnumTypes, uFunctions, uPerson, fGeneralSearch;

{$R *.dfm}

{ TfrmCustomer }

procedure TfrmCustomer.CancelRegister;
begin
  inherited;
  DisabledRegister;
end;

procedure TfrmCustomer.ClearFields;
begin
  TFunctions.clearFormFields(Self);
end;

procedure TfrmCustomer.CloseForm;
begin
  inherited;
  Close;
end;

procedure TfrmCustomer.DeleteRegister;
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

procedure TfrmCustomer.DisabledRegister;
begin
  pgcSearch.Visible := True;
  pnlMain.Visible := True;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmCustomer.EditRegister;
begin
  inherited;
  FOperationType := otUpdate;
  EnabledRegister;
  FRegisterObject.Clear;
  GetTypePaymentList;

  edtName.Text := dtsSearch.DataSet.FieldByName('Nome').AsString;
  edtPhone.Text := dtsSearch.DataSet.FieldByName('Fone').AsString;
  edtEmail.Text := dtsSearch.DataSet.FieldByName('E-Mail').AsString;
  edtAdress.Text := dtsSearch.DataSet.FieldByName('Endereço').AsString;
  edtNumber.Text := dtsSearch.DataSet.FieldByName('Número').AsString;
  edtDistrict.Text := dtsSearch.DataSet.FieldByName('Bairro').AsString;
  edtCity.Text := dtsSearch.DataSet.FieldByName('Cidade').AsString;

  edtName.SetFocus;
end;

procedure TfrmCustomer.EnabledRegister;
begin
  pgcSearch.Visible := False;
  pnlMain.Visible := False;
  tabGrid.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  inherited;
  FRegisterObject := TCustomer.Create;
end;

procedure TfrmCustomer.FormDestroy(Sender: TObject);
begin
  inherited;
  FRegisterObject.Free;
end;

procedure TfrmCustomer.FormShow(Sender: TObject);
begin
  FTitleForm := 'Clientes';
  inherited;
  tabGrid.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
  searchExecute;
end;

procedure TfrmCustomer.GetTypePaymentList;
begin

end;

procedure TfrmCustomer.imButtonClearEdtCityClick(Sender: TObject);
begin
  inherited;
  edtCity.Clear;
end;

procedure TfrmCustomer.imButtonSearchCityClick(Sender: TObject);
var
  frmGeneralSearch : TfrmGeneralSearch;
begin
  inherited;
  frmGeneralSearch := TfrmGeneralSearch.Create(nil);
  try
    frmGeneralSearch.SearchEntityType := setCity;

    if frmGeneralSearch.ShowModal = mrOk then
    begin
      edtCity.Text := frmGeneralSearch.City.Name;
      FRegisterObject.City.Id := frmGeneralSearch.City.Id;
    end;

  finally
    frmGeneralSearch.Free;
  end;
end;

procedure TfrmCustomer.InsertRegister;
begin
  inherited;
  FOperationType := otInsert;
  EnabledRegister;
  FRegisterObject.Clear;
  ClearFields;
  GetTypePaymentList;
  edtName.SetFocus;
end;

procedure TfrmCustomer.PrintRegister;
begin
  inherited;

end;

procedure TfrmCustomer.SaveRegister;
begin
  inherited;
  FRegisterObject.Name := edtName.Text;
  FRegisterObject.Phone := edtPhone.Text;
  FRegisterObject.Email := edtEmail.Text;
  FRegisterObject.Adress := edtAdress.Text;
  FRegisterObject.Number := edtNumber.Text;
  FRegisterObject.District := edtDistrict.Text;

//  FRegisterObject.TypePayment.Id := Integer(cbxTypePayment.Items.Objects[cbxTypePayment.ItemIndex]);

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

procedure TfrmCustomer.SearchExecute;
begin
  inherited;
  FRegisterObject.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FRegisterObject.SearchFiltersCustomized.TypePerson := tpCustomer;
  FRegisterObject.Search(FQuerySearch);

  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
  grdSearch.Columns[2].Width := 250;
  grdSearch.Columns[3].Width := 250;
  grdSearch.Columns[4].Width := 100;
  grdSearch.Columns[5].Width := 150;
  grdSearch.Columns[6].Width := 150;
  grdSearch.Columns[7].Width := 150;
  grdSearch.Columns[8].Width := 150;
end;

end.
