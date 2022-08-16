unit fMasterRegister;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, uSystemManager, uDataBaseConnection;

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
    pnButtonInsert: TPanel;
    pnButtonEdit: TPanel;
    pnButtonDelete: TPanel;
    pnButtonPrint: TPanel;
    pnButtonClose: TPanel;
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
    procedure pnButtonInsertClick(Sender: TObject);
    procedure pnButtonEditClick(Sender: TObject);
    procedure pnButtonDeleteClick(Sender: TObject);
    procedure pnButtonPrintClick(Sender: TObject);
    procedure pnButtonCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnlButtonSaveClick(Sender: TObject);
  private
    FQuerySearch: TMyQuery;
    { Private declarations }

  protected
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
  pnlTitle.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  pnlTitle.Font.Color := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
end;

procedure TfrmMasterRegister.imButtonSearchExecuteClick(Sender: TObject);
begin
  inherited;
  searchExecute;
end;

procedure TfrmMasterRegister.pnButtonCloseClick(Sender: TObject);
begin
  inherited;
  closeForm;
end;

procedure TfrmMasterRegister.pnButtonDeleteClick(Sender: TObject);
begin
  inherited;
  deleteRegister;
end;

procedure TfrmMasterRegister.pnButtonEditClick(Sender: TObject);
begin
  inherited;
  editRegister;
end;

procedure TfrmMasterRegister.pnButtonInsertClick(Sender: TObject);
begin
  inherited;
  insertRegister;
end;

procedure TfrmMasterRegister.pnButtonPrintClick(Sender: TObject);
begin
  inherited;
  printRegister;
end;

procedure TfrmMasterRegister.pnlButtonSaveClick(Sender: TObject);
begin
  inherited;
  saveRegister;
end;

end.
