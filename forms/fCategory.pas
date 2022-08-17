unit fCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  uCategory, uDataBaseConnection, uEnumTypes;

type
  TfrmCategory = class(TfrmMasterRegister)
    edtUniqueId: TEdit;
    edtName: TEdit;
    lb2: TLabel;
    lb3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonCancelClick(Sender: TObject);
  private
    FRegisterObject: TCategory;
    { Private declarations }
  public
    { Public declarations }
    procedure insertRegister; override;
    procedure editRegister; override;
    procedure deleteRegister; override;
    procedure printRegister; override;
    procedure closeForm; override;
    procedure searchExecute; override;
    procedure saveRegister; override;

    property RegisterObject: TCategory read FRegisterObject write FRegisterObject;
  end;

var
  frmCategory: TfrmCategory;

implementation

{$R *.dfm}

procedure TfrmCategory.closeForm;
begin
  // save log
  Close;
end;

procedure TfrmCategory.deleteRegister;
begin

end;

procedure TfrmCategory.editRegister;
begin

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
  inherited;
  tabSearch.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmCategory.insertRegister;
begin
  tabSearch.TabVisible := False;
  tabRegister.TabVisible := True;
  tabRegisterBasic.TabVisible := True;
  tabRegisterBasic.Show;
  FRegisterObject.Clear;

end;

procedure TfrmCategory.pnlButtonCancelClick(Sender: TObject);
begin
  inherited;
  tabSearch.TabVisible := True;
  tabRegister.TabVisible := False;
  tabRegisterBasic.TabVisible := False;
end;

procedure TfrmCategory.printRegister;
begin

end;

procedure TfrmCategory.saveRegister;
begin
  inherited;

  FRegisterObject.UniqueId := edtUniqueId.Text;
  FRegisterObject.Name := edtName.Text;

  case FOperationType of
    otInsert:
    begin
      FRegisterObject.InsertRegister;
    end;
    otUpdate:
    begin
      FRegisterObject.UpdateRegister;
    end;
  end;

end;

procedure TfrmCategory.searchExecute;
begin
  TDatabaseConnection.GetInstance.NewConnection;
  FRegisterObject.Search(FQuerySearch);
end;

end.
