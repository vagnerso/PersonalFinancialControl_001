unit fCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fMasterRegister, Data.DB, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  uCategory;

type
  TfrmCategory = class(TfrmMasterRegister)
    edtUniqueId: TEdit;
    edtName: TEdit;
    lb2: TLabel;
    lb3: TLabel;
    procedure pnButtonInsertClick(Sender: TObject);
  private
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
  end;

var
  frmCategory: TfrmCategory;

implementation

{$R *.dfm}

procedure TfrmCategory.closeForm;
begin

end;

procedure TfrmCategory.deleteRegister;
begin

end;

procedure TfrmCategory.editRegister;
begin

end;

procedure TfrmCategory.insertRegister;
begin

end;

procedure TfrmCategory.pnButtonInsertClick(Sender: TObject);

begin
  inherited;
  tabRegisterBasic.Show;
end;

procedure TfrmCategory.printRegister;
begin

end;

procedure TfrmCategory.saveRegister;
var
  lCategory: TCategory;
begin
  inherited;
  lCategory := TCategory.Create;
  try
    lCategory.UniqueId := edtUniqueId.Text;
    lCategory.Name := edtName.Text;
    lCategory.InsertRegister;
  finally
    lCategory.Free;
  end;
end;

procedure TfrmCategory.searchExecute;
begin
  QuerySearch.Close;
  QuerySearch.SQL.Clear;
  QuerySearch.SQL.Add('select * from category order by id desc');
  QuerySearch.Open;
end;

end.
