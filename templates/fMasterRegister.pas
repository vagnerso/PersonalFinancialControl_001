unit fMasterRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, uSystemManager, uDataBaseConnection, uEnumTypes,
  uFunctions;

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
  private
    { Private declarations }
    FActionButtonColor : TColor;
    FHoverActionButtonColor: TColor;

    procedure SetButtonColors;

  protected
    FQuerySearch: TMyQuery;
    FOperationType : TOperationType;
    FTitleForm: string;

    procedure insertRegister; virtual; abstract;
    procedure editRegister; virtual; abstract;
    procedure deleteRegister; virtual; abstract;
    procedure printRegister; virtual; abstract;
    procedure closeForm; virtual; abstract;
    procedure searchExecute; virtual; abstract;
    procedure saveRegister; virtual; abstract;

  public
    property QuerySearch: TMyQuery read FQuerySearch write FQuerySearch;
    { Public declarations }
  end;

var
  frmMasterRegister: TfrmMasterRegister;

implementation

{$R *.dfm}

procedure TfrmMasterRegister.FormCreate(Sender: TObject);
begin
  inherited;
  FQuerySearch := TMyQuery.Create(Self);
  dtsSearch.DataSet := FQuerySearch;
end;

procedure TfrmMasterRegister.FormShow(Sender: TObject);
begin
  inherited;

  FormCloseWithEsc := True;
  SetButtonColors;
  pnlTitle.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  pnlTitle.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  pnlTitle.Caption := FTitleForm;
  Caption := TFunctions.AppName + ' - Vers�o: ' + TFunctions.AppVersion + ' - ' + FTitleForm;
end;

procedure TfrmMasterRegister.imButtonSearchExecuteClick(Sender: TObject);
begin
  inherited;
  searchExecute;
end;

procedure TfrmMasterRegister.pnlButtonCancelMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonCancelMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonCloseClick(Sender: TObject);
begin
  inherited;
  closeForm;
end;

procedure TfrmMasterRegister.pnlButtonCloseMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonCloseMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonDeleteClick(Sender: TObject);
begin
  inherited;
  deleteRegister;
end;

procedure TfrmMasterRegister.pnlButtonDeleteMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonDeleteMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonEditClick(Sender: TObject);
begin
  inherited;
  editRegister;
end;

procedure TfrmMasterRegister.pnlButtonEditMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonEditMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonInsertClick(Sender: TObject);
begin
  inherited;
  insertRegister;
end;

procedure TfrmMasterRegister.pnlButtonInsertMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonInsertMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonPrintClick(Sender: TObject);
begin
  inherited;
  printRegister;
end;

procedure TfrmMasterRegister.pnlButtonPrintMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonPrintMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonSaveClick(Sender: TObject);
begin
  inherited;
  saveRegister;
end;

procedure TfrmMasterRegister.pnlButtonSaveMouseEnter(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FHoverActionButtonColor;
end;

procedure TfrmMasterRegister.pnlButtonSaveMouseLeave(Sender: TObject);
begin
  inherited;
  TPanel(Sender).Color := FActionButtonColor;
end;

procedure TfrmMasterRegister.SetButtonColors;
begin
  FActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  FHoverActionButtonColor:= TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor;

  pnlButtonInsert.Color := FActionButtonColor;
  pnlButtonEdit.Color := FActionButtonColor;
  pnlButtonDelete.Color := FActionButtonColor;
  pnlButtonPrint.Color := FActionButtonColor;
  pnlButtonClose.Color := FActionButtonColor;
  pnlButtonSave.Color := FActionButtonColor;
  pnlButtonCancel.Color := FActionButtonColor;
end;

end.
