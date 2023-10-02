unit fBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmBase = class(TForm)
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    FormCloseWithEsc: Boolean;
    ChangeEnterToTab: Boolean;
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  ChangeEnterToTab := False;
  FormCloseWithEsc := False;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FormCloseWithEsc) and (key = VK_ESCAPE) then
  begin
    Close;
  end;
end;

procedure TfrmBase.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if (ChangeEnterToTab) and (Key = #13) and not
     (UpperCase(Screen.ActiveControl.Name) = 'EDTSEARCH') then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;

  end;

end.
