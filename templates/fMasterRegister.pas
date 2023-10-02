unit fMasterRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, uSystemManager, uDataBaseConnection, uEnumTypes,
  uFunctions, Vcl.Menus, uClassHelperTEdit;

type
  TfrmMasterRegister = class(TfrmBase)
    pnlTitle: TPanel;
    pnlBottom: TPanel;
    pnlMain: TPanel;
    pnlGeneral: TPanel;
    pgcSearch: TPageControl;
    tabSearch: TTabSheet;
    pnlSearch: TPanel;
    lb1: TLabel;
    edtSearch: TEdit;
    pgcGeneral: TPageControl;
    tabGrid: TTabSheet;
    tabRegister: TTabSheet;
    pnlButtonInsert: TPanel;
    pnlButtonEdit: TPanel;
    pnlButtonDelete: TPanel;
    pnlButtonPrint: TPanel;
    pnlButtonClose: TPanel;
    grdSearch: TDBGrid;
    dtsSearch: TDataSource;
    pnlMainRegister: TPanel;
    pgcRegister: TPageControl;
    tabRegisterBasic: TTabSheet;
    pnlRegisterBasic: TPanel;
    pnlButtonSave: TPanel;
    pnlButtonCancel: TPanel;
    imButtonSearchExecute: TImage;
    pmActionMenu: TPopupMenu;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    Excluir1: TMenuItem;
    Imprimir1: TMenuItem;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    imButtonClearEdtSearch: TImage;
    lblFontTest: TLabel;
    procedure imButtonSearchExecuteClick(Sender: TObject);
    procedure pnlButtonInsertClick(Sender: TObject);
    procedure pnlButtonEditClick(Sender: TObject);
    procedure pnlButtonDeleteClick(Sender: TObject);
    procedure pnlButtonPrintClick(Sender: TObject);
    procedure pnlButtonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlButtonSaveClick(Sender: TObject);
    procedure pnlButtonInsertMouseEnter(Sender: TObject);
    procedure pnlButtonInsertMouseLeave(Sender: TObject);
    procedure pnlButtonEditMouseEnter(Sender: TObject);
    procedure pnlButtonDeleteMouseEnter(Sender: TObject);
    procedure pnlButtonPrintMouseEnter(Sender: TObject);
    procedure pnlButtonCloseMouseEnter(Sender: TObject);
    procedure pnlButtonSaveMouseEnter(Sender: TObject);
    procedure pnlButtonCancelMouseEnter(Sender: TObject);
    procedure pnlButtonEditMouseLeave(Sender: TObject);
    procedure pnlButtonDeleteMouseLeave(Sender: TObject);
    procedure pnlButtonPrintMouseLeave(Sender: TObject);
    procedure pnlButtonCloseMouseLeave(Sender: TObject);
    procedure pnlButtonSaveMouseLeave(Sender: TObject);
    procedure pnlButtonCancelMouseLeave(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure pnlButtonCancelClick(Sender: TObject);
    procedure imButtonClearEdtSearchClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure grdSearchDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdSearchDblClick(Sender: TObject);
    procedure pnlButtonInsertEnter(Sender: TObject);
    procedure pnlButtonEditEnter(Sender: TObject);
    procedure pnlButtonDeleteEnter(Sender: TObject);
    procedure pnlButtonPrintEnter(Sender: TObject);
    procedure pnlButtonCloseEnter(Sender: TObject);
    procedure pnlButtonCancelEnter(Sender: TObject);
    procedure pnlButtonSaveEnter(Sender: TObject);
    procedure pnlButtonInsertExit(Sender: TObject);
    procedure pnlButtonEditExit(Sender: TObject);
    procedure pnlButtonDeleteExit(Sender: TObject);
    procedure pnlButtonPrintExit(Sender: TObject);
    procedure pnlButtonCloseExit(Sender: TObject);
    procedure pnlButtonCancelExit(Sender: TObject);
    procedure pnlButtonSaveExit(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
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

    procedure SetColors;

  protected
    FQuerySearch: TMyQuery;
    FOperationType : TOperationType;
    FTitleForm: string;

    procedure InsertRegister; virtual; abstract;
    procedure EditRegister; virtual; abstract;
    procedure DeleteRegister; virtual; abstract;
    procedure PrintRegister; virtual; abstract;
    procedure CloseForm; virtual; abstract;
    procedure SearchExecute; virtual; abstract;
    procedure SaveRegister; virtual; abstract;
    procedure CancelRegister; virtual; abstract;

  public
    property QuerySearch: TMyQuery read FQuerySearch write FQuerySearch;
    { Public declarations }
  end;

var
  frmMasterRegister: TfrmMasterRegister;

implementation

{$R *.dfm}

procedure TfrmMasterRegister.Alterar1Click(Sender: TObject);
begin
  inherited;
  editRegister;
end;

procedure TfrmMasterRegister.edtSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmMasterRegister.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
  begin
    searchExecute;
  end;
end;

procedure TfrmMasterRegister.Excluir1Click(Sender: TObject);
begin
  inherited;
  deleteRegister;
end;

procedure TfrmMasterRegister.Fechar1Click(Sender: TObject);
begin
  inherited;
  closeForm;
end;

procedure TfrmMasterRegister.FormCreate(Sender: TObject);
begin
  inherited;
  FQuerySearch := TMyQuery.Create(Self);
  dtsSearch.DataSet := FQuerySearch;
end;

procedure TfrmMasterRegister.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  FormCloseWithEsc := True;
  SetColors;

  pnlTitle.Caption := FTitleForm;
  Caption := TFunctions.AppName + ' - Versão: ' + TFunctions.AppVersion + ' - ' + FTitleForm;

  edtSearch.Text := EmptyStr;
  edtSearch.SetFocus;
end;

procedure TfrmMasterRegister.grdSearchDblClick(Sender: TObject);
begin
  inherited;
  editRegister;
end;

procedure TfrmMasterRegister.grdSearchDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
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

procedure TfrmMasterRegister.imButtonClearEdtSearchClick(Sender: TObject);
begin
  inherited;
  edtSearch.Text := EmptyStr;
end;

procedure TfrmMasterRegister.imButtonSearchExecuteClick(Sender: TObject);
begin
  inherited;
  searchExecute;
end;

procedure TfrmMasterRegister.Imprimir1Click(Sender: TObject);
begin
  inherited;
  printRegister;
end;

procedure TfrmMasterRegister.Incluir1Click(Sender: TObject);
begin
  inherited;
  insertRegister;
end;

procedure TfrmMasterRegister.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  cancelRegister;
end;

procedure TfrmMasterRegister.pnlButtonCancelEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCancelExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCancelMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCancelMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCloseClick(Sender: TObject);
begin
  inherited;
  closeForm;
end;

procedure TfrmMasterRegister.pnlButtonCloseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCloseExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCloseMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonCloseMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonDeleteClick(Sender: TObject);
begin
  inherited;
  deleteRegister;
end;

procedure TfrmMasterRegister.pnlButtonDeleteEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonDeleteExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonDeleteMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonDeleteMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonEditClick(Sender: TObject);
begin
  inherited;
  editRegister;
end;

procedure TfrmMasterRegister.pnlButtonEditEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonEditExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonEditMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonEditMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonInsertClick(Sender: TObject);
begin
  inherited;
  insertRegister;
end;

procedure TfrmMasterRegister.pnlButtonInsertEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonInsertExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonInsertMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonInsertMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonPrintClick(Sender: TObject);
begin
  inherited;
  printRegister;
end;

procedure TfrmMasterRegister.pnlButtonPrintEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonPrintExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonPrintMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonPrintMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonSaveClick(Sender: TObject);
begin
  inherited;
  saveRegister;
end;

procedure TfrmMasterRegister.pnlButtonSaveEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonSaveExit(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonSaveMouseEnter(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMasterRegister.pnlButtonSaveMouseLeave(Sender: TObject);
begin
  inherited;
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMasterRegister.SetColors;
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
  pnlButtonInsert.Color := FActionButtonColor;
  pnlButtonEdit.Color := FActionButtonColor;
  pnlButtonDelete.Color := FActionButtonColor;
  pnlButtonPrint.Color := FActionButtonColor;
  pnlButtonClose.Color := FActionButtonColor;
  pnlButtonSave.Color := FActionButtonColor;
  pnlButtonCancel.Color := FActionButtonColor;
  pnlButtonInsert.Font.Color := FActionButtonFontColor;
  pnlButtonEdit.Font.Color := FActionButtonFontColor;
  pnlButtonDelete.Font.Color := FActionButtonFontColor;
  pnlButtonPrint.Font.Color := FActionButtonFontColor;
  pnlButtonClose.Font.Color := FActionButtonFontColor;
  pnlButtonSave.Font.Color := FActionButtonFontColor;
  pnlButtonCancel.Font.Color := FActionButtonFontColor;
  pnlSearch.Color := FSearchPanelColor;
  pnlMain.Color := FMainPanelColor;
  pnlRegisterBasic.Color := FRegisterPanelColor;
  pnlMainRegister.Color := FMainPanelRegisterColor;
  pnlBottom.Color := FPanelBottomColor;
end;

end.
