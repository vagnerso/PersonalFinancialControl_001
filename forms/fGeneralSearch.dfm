inherited frmGeneralSearch: TfrmGeneralSearch
  Caption = 'frmGeneralSearch'
  ClientHeight = 562
  ClientWidth = 1012
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1028
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 19
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Caption = 'GENERAL SEARCH'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -33
    Font.Name = 'Calibri'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 521
    Width = 1012
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlButtonSelect: TPanel
      Left = 862
      Top = 0
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alRight
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Selecionar'
      Color = 6009689
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Calibri'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = pnlButtonSelectClick
      OnEnter = pnlButtonSelectEnter
      OnExit = pnlButtonSelectExit
      OnMouseEnter = pnlButtonSelectMouseEnter
      OnMouseLeave = pnlButtonSelectMouseLeave
    end
    object pnlButtomCancel: TPanel
      Left = 712
      Top = 0
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alRight
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = 6009689
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Calibri'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = pnlButtomCancelClick
      OnEnter = pnlButtomCancelEnter
      OnExit = pnlButtomCancelExit
      OnMouseEnter = pnlButtomCancelMouseEnter
      OnMouseLeave = pnlButtomCancelMouseLeave
    end
  end
  object pgcSearch: TPageControl
    Left = 0
    Top = 60
    Width = 1012
    Height = 112
    ActivePage = tabSearch
    Align = alTop
    TabOrder = 2
    object tabSearch: TTabSheet
      Caption = 'Op'#231#245'es de pesquisa'
      object pnlSearch: TPanel
        Left = 0
        Top = 0
        Width = 1004
        Height = 78
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object lb1: TLabel
          Left = 16
          Top = 6
          Width = 80
          Height = 24
          Caption = 'Pesquisar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -20
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object imButtonSearchExecute: TImage
          Left = 396
          Top = 31
          Width = 30
          Height = 30
          Cursor = crHandPoint
          Hint = 'Clique aqui para executar a pesquisa'
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000000467414D410000B18F0BFC61050000000662
            4B4744000000000000F943BB7F0000000970485973000000600000006000F06B
            42CF0000014F4944415478DADD95CD4A02511886CF0169A0B520D824A217D1A2
            49B07BA8A46E2072D1B64D2D72E33642BD02B5F01E8A185B740F5152D9A67D94
            08D33379422BE7E78CCEC6030FAF30DFF91E87393F52C43CE4E20A1CC7D920CA
            E06612DEC0869A94B21B5940E304710EFB3EF3EA7088681845D050CDDFA10A4D
            780113F6E008965D0982B29680E605E24635DFA4C1DD943FB0465C298945CDAD
            8EE082D881132656BC2651774C9C429BBA5D1D419F48439E890F3E823C710F7D
            EA4C1DC127B1040613073E0283F8800175469C6FF04ADD8A8EA04D9434BEC125
            75251D8125469B29EC2A2A50638716A80635E2408CF7410B9E6115DC15F3B30F
            3A34DF1601C36B279F2989D7E8C016F4A088A8175A30215A17E3B328257E9F45
            36CF1FF99D0D92443E4D1164886BC8C19392FC5B79331DD7612433DF074192B9
            5C381392442C0225C97E37FCF3B117F84E9ED7F802083296196F48DCCB000000
            2574455874646174653A63726561746500323032322D30382D30365431323A34
            373A34362B30303A30303030DC150000002574455874646174653A6D6F646966
            7900323032322D30382D30365431323A34373A34362B30303A3030416D64A900
            00000049454E44AE426082}
          ShowHint = True
          OnClick = imButtonSearchExecuteClick
        end
        object imButtonClearEdtSearch: TImage
          Left = 360
          Top = 31
          Width = 30
          Height = 30
          Cursor = crHandPoint
          Hint = 'Clique aqui para limpar o campo de pesquisa'
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000000467414D410000B18F0BFC61050000000662
            4B4744000000000000F943BB7F0000000970485973000000600000006000F06B
            42CF000000A84944415478DA6364A031601CB560705AF0FFFF7F0D20351D8823
            1919195FE03300A8561448AD00E202A0DACBC45AB017483901F115100DD4F81A
            8FE1FB8058074403D539136B014823C8125D20BE01C48EE83E21460D4E0B0819
            40ACE1782DC0651010FF25D67082166009E72B5061181B67FC106D01169F3010
            E3F2C163014D8388A6914CD3644AF38C468FA202A461221047108A44A4C22E1F
            A8F60A511650138C5A30F0160000E46A861908EB94D100000025744558746461
            74653A63726561746500323032322D30382D32305430323A33313A35372B3030
            3A3030646AAAAE0000002574455874646174653A6D6F6469667900323032322D
            30382D32305430323A33313A35372B30303A3030153712120000000049454E44
            AE426082}
          ShowHint = True
          OnClick = imButtonClearEdtSearchClick
        end
        object edtSearch: TEdit
          Left = 16
          Top = 31
          Width = 338
          Height = 32
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'Digite aqui o que deseja pesquisar'
          OnKeyDown = edtSearchKeyDown
          OnKeyPress = edtSearchKeyPress
        end
      end
    end
  end
  object pnlGeneral: TPanel
    Left = 0
    Top = 172
    Width = 1012
    Height = 349
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pgcGeneral: TPageControl
      Left = 0
      Top = 0
      Width = 1012
      Height = 349
      ActivePage = tabGrid
      Align = alClient
      TabOrder = 0
      object tabGrid: TTabSheet
        Caption = 'Consulta'
        object grdSearch: TDBGrid
          Left = 0
          Top = 0
          Width = 1004
          Height = 315
          Align = alClient
          BorderStyle = bsNone
          DataSource = dtsSearch
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -23
          Font.Name = 'Calibri'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -23
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
          OnDrawColumnCell = grdSearchDrawColumnCell
          OnDblClick = grdSearchDblClick
        end
      end
    end
  end
  object dtsSearch: TDataSource
    Left = 120
    Top = 288
  end
end
