unit fMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uEnumTypes, Vcl.Imaging.pngimage;

type
  TfrmMessage = class(TForm)
    pnlCenter: TPanel;
    pnlGeneral: TPanel;
    lblMessageType: TLabel;
    lblMessage: TLabel;
    imgIcon: TImage;
    pnlMenu: TPanel;
    pnlButtonOk: TPanel;
    pnlTitle: TPanel;
    procedure pnlButtonOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure pnlButtonOkMouseEnter(Sender: TObject);
    procedure pnlButtonOkEnter(Sender: TObject);
    procedure pnlButtonOkMouseLeave(Sender: TObject);
    procedure pnlButtonOkExit(Sender: TObject);
  private
    FTitle: string;
    FMessageText: string;
    FMessageType: TMessageType;
    FBackgroundColor : TColor;
    FTitleColor : TColor;
    FTitleFontColor : TColor;
    FActionButtonColor : TColor;
    FHoverActionButtonColor: TColor;
    FActionButtonFontColor : TColor;
    FHoverActionButtonFontColor: TColor;

    procedure SetColors;
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

uses
  uFunctions, uSystemManager;

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

procedure TfrmMessage.SetColors;
begin
  FBackgroundColor := TSystemManager.GetInstance.LayoutConfiguration.BackgroundColor;
  FTitleColor := TSystemManager.GetInstance.LayoutConfiguration.TitleColor;
  FTitleFontColor := TSystemManager.GetInstance.LayoutConfiguration.TitleFontColor;
  FActionButtonColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonColor;
  FHoverActionButtonColor:= TSystemManager.GetInstance.LayoutConfiguration.HoverActionButtonColor;
  FActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonFontColor;
  FHoverActionButtonFontColor := TSystemManager.GetInstance.LayoutConfiguration.ActionButtonHoverFontColor;

  Color := TSystemManager.GetInstance.LayoutConfiguration.PopUpBackgroundColor;
  pnlTitle.Color := FTitleColor;
  pnlTitle.Font.Color := FTitleFontColor;
  pnlMenu.Color := FTitleColor;
  pnlGeneral.Color := FBackgroundColor;

end;

procedure TfrmMessage.FormShow(Sender: TObject);
begin
  WindowState := TWindowState.wsMaximized;
  SetColors;
  Caption := TFunctions.AppName + ' - Vers�o: ' + TFunctions.AppVersion;
  TFunctions.CenterPanel(self, pnlCenter);
  pnlButtonOk.SetFocus;
end;

procedure TfrmMessage.pnlButtonOkClick(Sender: TObject);
begin
  Confirm;
end;

procedure TfrmMessage.pnlButtonOkEnter(Sender: TObject);
begin
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMessage.pnlButtonOkExit(Sender: TObject);
begin
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMessage.pnlButtonOkMouseEnter(Sender: TObject);
begin
  TFunctions.SetButtonColors(Sender, FHoverActionButtonColor, FHoverActionButtonFontColor);
end;

procedure TfrmMessage.pnlButtonOkMouseLeave(Sender: TObject);
begin
  TFunctions.SetButtonColors(Sender, FActionButtonColor, FActionButtonFontColor);
end;

procedure TfrmMessage.PrepareMessageBox;
var
  lPathIconSuccessWhite, lPathIconErrorWhite, lPathIconWarningWhite, lPathIconInformationWhite: string;
begin

  lPathIconSuccessWhite     := TFunctions.ApplicationPath+'/images/outline_check_circle_white_48dp.png';
  lPathIconErrorWhite       := TFunctions.ApplicationPath+'/images/outline_error_white_48dp.png';
  lPathIconWarningWhite     := TFunctions.ApplicationPath+'/images/outline_warning_white_48dp.png';
  lPathIconInformationWhite := TFunctions.ApplicationPath+'/images/outline_priority_high_white_48dp.png';

  case MessageType of
    mtSuccess:
    begin
      lblMessageType.Caption := 'Sucesso';
      if FileExists(lPathIconSuccessWhite) then
      begin
        imgIcon.Picture.LoadFromFile(lPathIconSuccessWhite);
      end;
    end;
    mtWarning:
    begin
      lblMessageType.Caption := 'Aten��o';
      if FileExists(lPathIconWarningWhite) then
      begin
        imgIcon.Picture.LoadFromFile(lPathIconWarningWhite);
      end;
    end;
    mtError:
    begin
      lblMessageType.Caption := 'Erro';
      if FileExists(lPathIconErrorWhite) then
      begin
        imgIcon.Picture.LoadFromFile(lPathIconErrorWhite);
      end;
    end;
    mtInformation:
    begin
      lblMessageType.Caption := 'Informa��o';
      if FileExists(lPathIconInformationWhite) then
      begin
        imgIcon.Picture.LoadFromFile(lPathIconInformationWhite);
      end;
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
