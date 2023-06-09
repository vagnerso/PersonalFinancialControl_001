unit fMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uEnumTypes;

type
  TfrmMessage = class(TForm)
    pnlTitle: TPanel;
    pnlGeneral: TPanel;
    pnlMenu: TPanel;
    lblMessageType: TLabel;
    lblMessage: TLabel;
    pnlButtonOk: TPanel;
    imgIcon: TImage;
    procedure pnlButtonOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FTitle: string;
    FMessageText: string;
    FMessageType: TMessageType;
    { Private declarations }
  public
    { Public declarations }
    property Title: string read FTitle write FTitle;
    property MessageText: string read FMessageText write FMessageText;
    property MessageType: TMessageType read FMessageType write FMessageType;

    procedure PrepareMessageBox;
    procedure Confirm;
    class procedure ShowMessageBox(AMessageType: TMessageType; ATitle, AMessage: string);

  end;

var
  frmMessage: TfrmMessage;

implementation

{$R *.dfm}

{ TfrmMessage }

procedure TfrmMessage.Confirm;
begin
  ModalResult := mrOk;
end;

procedure TfrmMessage.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Confirm;
  end;
end;

procedure TfrmMessage.pnlButtonOkClick(Sender: TObject);
begin
  Confirm;
end;

procedure TfrmMessage.PrepareMessageBox;
begin
  case MessageType of
    mtSuccess:
    begin
      lblMessageType.Caption := 'Sucesso';
    end;
    mtWarning:
    begin
      lblMessageType.Caption := 'Aten��o';
    end;
    mtError:
    begin
      lblMessageType.Caption := 'Erro';
    end;
    mtInformation:
    begin
      lblMessageType.Caption := 'Informa��o';
    end;
  end;

  if not (Trim(Title) = EmptyStr)  then
  begin
    lblMessageType.Caption := Title;
  end;

  lblMessage.Caption := MessageText;

end;

class procedure TfrmMessage.ShowMessageBox(AMessageType: TMessageType; ATitle, AMessage: string);
var
  lFrmMessage: TfrmMessage;
begin
  lFrmMessage := TfrmMessage.Create(nil);

  try

    lFrmMessage.Title := ATitle;
    lFrmMessage.MessageText := AMessage;
    lFrmMessage.MessageType := AMessageType;
    lFrmMessage.PrepareMessageBox;
    lFrmMessage.ShowModal;

  finally
    lFrmMessage.Free;
  end;
end;

end.
