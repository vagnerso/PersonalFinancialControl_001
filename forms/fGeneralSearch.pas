unit fGeneralSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, uEnumTypes, uCategory, uSubCategory, uProvider,
  uTypePayment, uFormPayment, uSystemManager, uFunctions, uCustomer, uCity;

type
  TfrmGeneralSearch = class(TfrmBase)
    pnlTitle: TPanel;
    pnlBottom: TPanel;
    pgcSearch: TPageControl;
    tabSearch: TTabSheet;
    pnlSearch: TPanel;
    lb1: TLabel;
    imButtonSearchExecute: TImage;
    imButtonClearEdtSearch: TImage;
    edtSearch: TEdit;
    pnlGeneral: TPanel;
    pgcGeneral: TPageControl;
    tabGrid: TTabSheet;
    grdSearch: TDBGrid;
    dtsSearch: TDataSource;
    pnlButtonSelect: TPanel;
    pnlButtomCancel: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure imButtonSearchExecuteClick(Sender: TObject);
    procedure imButtonClearEdtSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdSearchDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlButtonSelectClick(Sender: TObject);
    procedure pnlButtonSelectEnter(Sender: TObject);
    procedure pnlButtonSelectExit(Sender: TObject);
    procedure pnlButtonSelectMouseEnter(Sender: TObject);
    procedure pnlButtonSelectMouseLeave(Sender: TObject);
    procedure pnlButtomCancelClick(Sender: TObject);
    procedure pnlButtomCancelEnter(Sender: TObject);
    procedure pnlButtomCancelExit(Sender: TObject);
    procedure pnlButtomCancelMouseEnter(Sender: TObject);
    procedure pnlButtomCancelMouseLeave(Sender: TObject);
    procedure grdSearchDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FSearchEntityType: TSearchEntityType;
    FCategory: TCategory;
    FSubCategory: TSubCategory;
    FProvider: TProvider;
    FTypePayment: TTypePayment;
    FFormPayment: TFormPayment;
    FCustomer: TCustomer;
    FBackgroundColor : TColor;
    FTitleColor : TColor;
    FTitleFontColor : TColor;
    FActionButtonColor : TColor;
    FHoverActionButtonColor: TColor;
    FActionButtonFontColor : TColor;
    FHoverActionButtonFontColor: TColor;
    FSearchPanelColor : TColor;
    FMainPanelColor : TColor;
    FRegisterPanelColor: TColor;
    FMainPanelRegisterColor: TColor;
    FPanelBottomColor : TColor;
    FTitleForm : string;
    FCity: TCity;

    procedure SetColors;
    procedure SelectRegister;
    procedure CategorySearchExecute;
    procedure SubCategorySearchExecute;
    procedure CustomerSearchExecute;
    procedure ProviderSearchExecute;
    procedure TypePaymentSearchExecute;
    procedure FormPaymentSearchExecute;
    procedure CitySearchExecute;
    procedure GridIdColumnsHide;
  public
    { Public declarations }
    procedure searchExecute;

    property SearchEntityType: TSearchEntityType read FSearchEntityType write FSearchEntityType;
    property Category: TCategory read FCategory  write FCategory;
    property SubCategory: TSubCategory read FSubCategory  write FSubCategory;
    property Provider: TProvider read FProvider  write FProvider;
    property TypePayment: TTypePayment read FTypePayment  write FTypePayment;
    property FormPayment: TFormPayment read FFormPayment  write FFormPayment;
    property Customer: TCustomer read FCustomer write FCustomer;
    property City: TCity read FCity write FCity;
  end;

var
  frmGeneralSearch: TfrmGeneralSearch;

implementation

{$R *.dfm}

{ TfrmGeneralSearch }

procedure TfrmGeneralSearch.FormCreate(Sender: TObject);
begin
  inherited;
  FCategory    := TCategory.Create;
  FSubCategory := TSubCategory.Create;
  FProvider    := TProvider.Create;
  FTypePayment := TTypePayment.Create;
  FFormPayment := TFormPayment.Create;
  FCustomer    := TCustomer.Create;
  FCity        := TCity.Create;
end;

procedure TfrmGeneralSearch.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FCategory) then
  begin
    FCategory.Free;
  end;

  if Assigned(FSubCategory) then
  begin
    FSubCategory.Free;
  end;

  if Assigned(FProvider) then
  begin
    FProvider.Free;
  end;

  if Assigned(FTypePayment) then
  begin
    FTypePayment.Free;
  end;

  if Assigned(FFormPayment) then
  begin
    FFormPayment.Free;
  end;

  if Assigned(FCustomer) then
  begin
    FCustomer.Free;
  end;

  if Assigned(FCity) then
  begin
    FCity.Free;
  end;

end;

procedure TfrmGeneralSearch.FormShow(Sender: TObject);
begin
  inherited;
  SetColors;

  case FSearchEntityType of
    setCategory: FTitleForm := 'Categorias';
    setSubCategory: FTitleForm := 'Sub-Categorias';
    setCustomer: FTitleForm := 'Clientes';
    setProvider: FTitleForm := 'Fornecedores';
    setTypePayment: FTitleForm := 'Tipos de Pagamento';
    setFormPayment: FTitleForm := 'Formas de pagamento';
    setCity       : FTitleForm := 'Cidades';
  end;

  FTitleForm := 'Pesquisar ' + FTitleForm;

  pnlTitle.Caption := FTitleForm;
  Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + FTitleForm;
  edtSearch.Text := EmptyStr;
  searchExecute;
  edtSearch.SetFocus;
end;

procedure TfrmGeneralSearch.grdSearchDblClick(Sender: TObject);
begin
  inherited;
  SelectRegister;
end;

procedure TfrmGeneralSearch.grdSearchDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if gdSelected in State then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
    TDBGrid(Sender).Canvas.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  end;

  TDBGrid(Sender).Canvas.FillRect(Rect);
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmGeneralSearch.imButtonClearEdtSearchClick(Sender: TObject);
begin
  inherited;
  edtSearch.Clear;
  edtSearch.SetFocus;
end;

procedure TfrmGeneralSearch.imButtonSearchExecuteClick(Sender: TObject);
begin
  inherited;
  searchExecute;
end;

procedure TfrmGeneralSearch.pnlButtomCancelClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmGeneralSearch.pnlButtomCancelEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtomCancelExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtomCancelMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtomCancelMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtonSelectClick(Sender: TObject);
begin
  inherited;
  SelectRegister;
end;

procedure TfrmGeneralSearch.pnlButtonSelectEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtonSelectExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtonSelectMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmGeneralSearch.pnlButtonSelectMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmGeneralSearch.searchExecute;
begin

  case FSearchEntityType of
    setCategory:
    begin
      CategorySearchExecute;
    end;
    setSubCategory:
    begin
      SubCategorySearchExecute;
    end;
    setCustomer:
    begin
      CustomerSearchExecute;
    end;
    setProvider:
    begin
      ProviderSearchExecute;
    end;
    setTypePayment:
    begin
      TypePaymentSearchExecute;
    end;
    setFormPayment:
    begin
      FormPaymentSearchExecute;
    end;
    setCity:
    begin
      CitySearchExecute;
    end;
  end;

  GridIdColumnsHide;

end;

procedure TfrmGeneralSearch.GridIdColumnsHide;
begin
  grdSearch.Columns[0].Visible := False;
  grdSearch.Columns[1].Visible := False;
end;

procedure TfrmGeneralSearch.CitySearchExecute;
begin
  dtsSearch.DataSet := FCity.DataSet;
  FCity.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FCity.Search(FCity.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.FormPaymentSearchExecute;
begin
  dtsSearch.DataSet := FFormPayment.DataSet;
  FFormPayment.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FFormPayment.Search(FFormPayment.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.TypePaymentSearchExecute;
begin
  dtsSearch.DataSet := FTypePayment.DataSet;
  FTypePayment.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FTypePayment.Search(FTypePayment.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.ProviderSearchExecute;
begin
  dtsSearch.DataSet := FProvider.DataSet;
  FProvider.SearchFiltersCustomized.TypePerson := tpProvider;
  FProvider.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FProvider.Search(FProvider.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.CustomerSearchExecute;
begin
  dtsSearch.DataSet := FCustomer.DataSet;
  FCustomer.SearchFiltersCustomized.TypePerson := tpCustomer;
  FCustomer.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FCustomer.Search(FCustomer.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_UP) then
  begin
    dtsSearch.DataSet.Prior;
  end;

  if (Key = VK_DOWN) then
  begin
    dtsSearch.DataSet.Next;
  end;
end;

procedure TfrmGeneralSearch.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    searchExecute;
  end;
end;

procedure TfrmGeneralSearch.SubCategorySearchExecute;
begin
  dtsSearch.DataSet := FSubCategory.DataSet;
  FSubCategory.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FSubCategory.Search(FSubCategory.DataSet);
  grdSearch.Columns[2].Width := 400;
  grdSearch.Columns[3].Visible := False;
  grdSearch.Columns[4].Width := 400;
end;

procedure TfrmGeneralSearch.CategorySearchExecute;
begin
  dtsSearch.DataSet := FCategory.DataSet;
  FCategory.SearchFiltersCustomized.ValueSearch := edtSearch.Text;
  FCategory.Search(FCategory.DataSet);
  grdSearch.Columns[2].Width := 600;
end;

procedure TfrmGeneralSearch.SelectRegister;
var
  lSelected: Boolean;
begin
  lSelected := False;

  if (Assigned(dtsSearch.DataSet)) and not (dtsSearch.DataSet.IsEmpty) then
  begin
    case FSearchEntityType of
      setCategory:
        begin
          FCategory.Clear;
          FCategory.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FCategory.GetById;
          lSelected := True;
        end;
      setSubCategory:
        begin
          FSubCategory.Clear;
          FSubCategory.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FSubCategory.GetById;
          lSelected := True;
        end;
      setCustomer:
        begin
          FCustomer.Clear;
          FCustomer.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FCustomer.GetById;
          lSelected := True;
        end;
      setProvider:
        begin
          FProvider.Clear;
          FProvider.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FProvider.GetById;
          lSelected := True;
        end;
      setTypePayment:
        begin
          FTypePayment.Clear;
          FTypePayment.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FTypePayment.GetById;
          lSelected := True;
        end;
      setFormPayment:
        begin
          FFormPayment.Clear;
          FFormPayment.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FFormPayment.GetById;
          lSelected := True;
        end;
      setCity:
        begin
          FCity.Clear;
          FCity.Id := dtsSearch.DataSet.FieldByName('ID').AsInteger;
          FCity.GetById;
          lSelected := True;
        end;
    end;
  end;

  if lSelected then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmGeneralSearch.SetColors;
begin
  FBackgroundColor := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  FTitleColor := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  FTitleFontColor := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  FActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  FHoverActionButtonColor:= TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor;
  FActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  FHoverActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor;
  FSearchPanelColor := TSystemManager.GetInstance.LayoutConfiguration.SearchPanelColor;
  FMainPanelColor := TSystemManager.GetInstance.LayoutConfiguration.MainPanelColor;
  FRegisterPanelColor := TSystemManager.GetInstance.LayoutConfiguration.RegisterPanelColor;
  FMainPanelRegisterColor := TSystemManager.GetInstance.LayoutConfiguration.MainPanelRegisterColor;
  FPanelBottomColor := TSystemManager.GetInstance.LayoutConfiguration.PanelBottomColor;

  Color := FBackgroundColor;
  pnlTitle.Color := FTitleColor;
  pnlTitle.Font.Color := FTitleFontColor;
  pnlSearch.Color := FSearchPanelColor;
  pnlBottom.Color := FPanelBottomColor;
  pnlButtonSelect.Color := FActionButtonColor;
  pnlButtonSelect.Font.Color := FActionButtonFontColor;
  pnlButtomCancel.Color := FActionButtonColor;
  pnlButtomCancel.Font.Color := FActionButtonFontColor;
end;

end.
