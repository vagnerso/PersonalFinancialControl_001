inherited frmMovement: TfrmMovement
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'frmMovement'
  ClientHeight = 571
  ClientWidth = 1018
  Font.Height = -21
  KeyPreview = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 26
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 1018
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Cadastro de Despesas'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -33
    Font.Name = 'Calibri'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 525
    Width = 1018
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlButtonSave: TPanel
      Left = 871
      Top = 0
      Width = 147
      Height = 46
      Cursor = crHandPoint
      Align = alRight
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Salvar'
      ParentBackground = False
      TabOrder = 0
      OnClick = pnlButtonSaveClick
      OnMouseEnter = pnlButtonSaveMouseEnter
      OnMouseLeave = pnlButtonSaveMouseLeave
    end
    object pnlButtonCancel: TPanel
      Left = 724
      Top = 0
      Width = 147
      Height = 46
      Cursor = crHandPoint
      Align = alRight
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Cancelar'
      ParentBackground = False
      TabOrder = 1
      OnClick = pnlButtonCancelClick
      OnMouseEnter = pnlButtonCancelMouseEnter
      OnMouseLeave = pnlButtonCancelMouseLeave
    end
  end
  object pgcNavigator: TPageControl
    Left = 0
    Top = 60
    Width = 1018
    Height = 465
    ActivePage = tabDescription
    Align = alClient
    TabOrder = 2
    object tabDescription: TTabSheet
      Caption = 'Informa'#231#245'es da conta'
      object pnlDescription: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 424
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 179
          Width = 183
          Height = 26
          Caption = 'Forma de pagamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object imButtonClearEdtFormPayment: TImage
          Left = 423
          Top = 212
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
        end
        object imButtonSearchFormPayment: TImage
          Left = 459
          Top = 212
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
          OnClick = imButtonSearchFormPaymentClick
        end
        object Label2: TLabel
          Left = 16
          Top = 19
          Width = 161
          Height = 26
          Caption = 'Descri'#231#227'o da conta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 512
          Top = 179
          Width = 201
          Height = 26
          Caption = 'Quantidade de parcelas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object lbInstallmentsValue: TLabel
          Left = 16
          Top = 259
          Width = 153
          Height = 26
          Caption = 'Valor das parcelas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object lblPerson: TLabel
          Left = 16
          Top = 99
          Width = 58
          Height = 26
          Caption = 'Pessoa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object imButtonClearEdtPerson: TImage
          Left = 423
          Top = 132
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
        end
        object imButtonSearchPerson: TImage
          Left = 459
          Top = 132
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
          OnClick = imButtonSearchPersonClick
        end
        object Label6: TLabel
          Left = 512
          Top = 99
          Width = 119
          Height = 26
          Caption = 'Sub-Categoria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object imButtonClearEdtSubCategory: TImage
          Left = 918
          Top = 132
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
        end
        object imButtonSearchSubCategory: TImage
          Left = 954
          Top = 132
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
          OnClick = imButtonSearchSubCategoryClick
        end
        object lbFirstIssueDate: TLabel
          Left = 512
          Top = 259
          Width = 250
          Height = 26
          Caption = 'Data do primeiro vencimento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -21
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object edtDescription: TEdit
          Left = 16
          Top = 51
          Width = 969
          Height = 34
          TabOrder = 0
        end
        object edtFormPayment: TEdit
          Left = 16
          Top = 211
          Width = 400
          Height = 34
          Hint = 'Pressiona a tecla F12 ou clique na lupinha ao lado para escolher'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          TextHint = 'Clique na lupinha ao lado para escolher'
          OnKeyDown = edtFormPaymentKeyDown
        end
        object edtNumberInstallments: TEdit
          Left = 512
          Top = 211
          Width = 472
          Height = 34
          TabOrder = 4
          OnExit = edtNumberInstallmentsExit
        end
        object pnlButtonInstallmentsGenerate: TPanel
          Left = 296
          Top = 350
          Width = 401
          Height = 51
          Cursor = crHandPoint
          BevelKind = bkTile
          BevelOuter = bvNone
          Caption = 'Gerar Parcelas'
          ParentBackground = False
          TabOrder = 6
          OnClick = pnlButtonInstallmentsGenerateClick
          OnEnter = pnlButtonInstallmentsGenerateEnter
          OnExit = pnlButtonInstallmentsGenerateExit
          OnMouseEnter = pnlButtonInstallmentsGenerateMouseEnter
          OnMouseLeave = pnlButtonInstallmentsGenerateMouseLeave
        end
        object edtInstallmentesValue: TEdit
          Left = 16
          Top = 291
          Width = 473
          Height = 34
          TabOrder = 5
          OnExit = edtInstallmentesValueExit
          OnKeyPress = edtInstallmentesValueKeyPress
        end
        object edtPerson: TEdit
          Left = 16
          Top = 131
          Width = 400
          Height = 34
          Hint = 'Pressiona a tecla F12 ou clique na lupinha ao lado para escolher'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          TextHint = 'Clique na lupinha ao lado para escolher'
          OnKeyDown = edtPersonKeyDown
        end
        object edtSubCategory: TEdit
          Left = 512
          Top = 131
          Width = 400
          Height = 34
          Hint = 'Pressiona a tecla F12 ou clique na lupinha ao lado para escolher'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TextHint = 'Clique na lupinha ao lado para escolher'
          OnKeyDown = edtSubCategoryKeyDown
        end
        object edtFirstIssueDate: TDateTimePicker
          Left = 512
          Top = 291
          Width = 472
          Height = 34
          Date = 44888.714996817130000000
          Time = 44888.714996817130000000
          TabOrder = 7
        end
      end
    end
    object tabInstallments: TTabSheet
      Caption = 'Parcelas'
      ImageIndex = 1
      object pnlInstallments: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 424
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object grInstallments: TDBGrid
          Left = 0
          Top = 0
          Width = 1010
          Height = 424
          Align = alClient
          DataSource = dtsInstallments
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -21
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
        end
      end
    end
  end
  object dtsInstallments: TDataSource
    Left = 88
    Top = 432
  end
end
