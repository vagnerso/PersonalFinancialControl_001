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

  public
    property TitleColor: TColor read FtitleColor write FtitleColor;
    property FormColor: TColor read FFormColor write FFormColor;
    property TitleFontColor: TColor read FTitleFontColor write FTitleFontColor;
    property TextFontColor: TColor read FTextFontColor write FTextFontColor;
    property DetailColor: TColor read FDetailColor write FDetailColor;
end;

implementation

end.
