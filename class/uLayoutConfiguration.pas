unit uLayoutConfiguration;

interface

uses
  System.UITypes;

type TLayoutConfiguration = class
  private
    FTitleColor: TColor;
    FFormColor: TColor;
    FTitleFontColor: TColor;
    FTextFontColor: TColor;
    FDetailColor: TColor;
    FHoverActionButtonColor: TColor;
    FActionButtonColor: TColor;
    FActionButtonFontColor: TColor;
    FActionButtonHoverFontColor: TColor;
    FBackgroundColor: TColor;
    FSearchPanelColor: TColor;
    FMainPanelColor: TColor;
    FRegisterPanelColor: TColor;
    FMainPanelRegisterColor: TColor;
    FPanelBottomColor: TColor;

  public
    property TitleColor: TColor read FtitleColor write FtitleColor;
    property FormColor: TColor read FFormColor write FFormColor;
    property TitleFontColor: TColor read FTitleFontColor write FTitleFontColor;
    property TextFontColor: TColor read FTextFontColor write FTextFontColor;
    property DetailColor: TColor read FDetailColor write FDetailColor;
    property HoverActionButtonColor: TColor read FHoverActionButtonColor write FHoverActionButtonColor;
    property ActionButtonColor: TColor read FActionButtonColor write FActionButtonColor;
    property ActionButtonFontColor: TColor read FActionButtonFontColor write FActionButtonFontColor;
    property ActionButtonHoverFontColor: TColor read FActionButtonHoverFontColor write FActionButtonHoverFontColor;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property SearchPanelColor: TColor read FSearchPanelColor write FSearchPanelColor;
    property MainPanelColor: TColor read FMainPanelColor write FMainPanelColor;
    property RegisterPanelColor: TColor read FRegisterPanelColor write FRegisterPanelColor;
    property MainPanelRegisterColor: TColor read FMainPanelRegisterColor write FMainPanelRegisterColor;
    property PanelBottomColor: TColor read FPanelBottomColor write FPanelBottomColor;
end;

implementation

end.
