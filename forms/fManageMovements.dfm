inherited frmManageMovements: TfrmManageMovements
  Caption = 'frmManageMovements'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Caption = 'Gerenciar movimenta'#231#245'es'
  end
  inherited pnlGeneral: TPanel
    inherited pgcGeneral: TPageControl
      inherited tabGrid: TTabSheet
        inherited grdSearch: TDBGrid
          Height = 367
        end
        object pnlSum: TPanel
          Left = 0
          Top = 367
          Width = 887
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object lblSumRevenues: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 3
            Width = 118
            Height = 35
            Margins.Left = 10
            Margins.Right = 0
            Align = alLeft
            Caption = 'lblSumRevenues'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 7909724
            Font.Height = -17
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitHeight = 21
          end
          object lblSumExpenses: TLabel
            AlignWithMargins = True
            Left = 138
            Top = 3
            Width = 114
            Height = 35
            Margins.Left = 10
            Margins.Right = 0
            Align = alLeft
            Caption = 'lblSumExpenses'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 3684595
            Font.Height = -17
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitHeight = 21
          end
          object lblBalance: TLabel
            AlignWithMargins = True
            Left = 262
            Top = 3
            Width = 72
            Height = 35
            Margins.Left = 10
            Margins.Right = 0
            Align = alLeft
            Caption = 'lblBalance'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -17
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitHeight = 21
          end
        end
      end
      inherited tabRegister: TTabSheet
        inherited pgcRegister: TPageControl
          inherited tabRegisterBasic: TTabSheet
            inherited pnlRegisterBasic: TPanel
              object Label2: TLabel
                Left = 8
                Top = 11
                Width = 124
                Height = 19
                Caption = 'Descri'#231#227'o da conta'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel
                Left = 8
                Top = 75
                Width = 72
                Height = 19
                Caption = 'Fornecedor'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object imButtonClearEdtProvider: TImage
                Left = 343
                Top = 100
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
              object imButtonSearchProvider: TImage
                Left = 379
                Top = 100
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
                OnClick = imButtonSearchProviderClick
              end
              object Label6: TLabel
                Left = 424
                Top = 75
                Width = 91
                Height = 19
                Caption = 'Sub-Categoria'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object imButtonClearEdtSubCategory: TImage
                Left = 791
                Top = 100
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
                Left = 827
                Top = 100
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
              object Label1: TLabel
                Left = 8
                Top = 139
                Width = 137
                Height = 19
                Caption = 'Forma de pagamento'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object imButtonClearEdtFormPayment: TImage
                Left = 343
                Top = 164
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
                Left = 379
                Top = 164
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
              object lbInstallmentsValue: TLabel
                Left = 8
                Top = 203
                Width = 54
                Height = 19
                Caption = 'R$ Valor'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object lbFirstIssueDate: TLabel
                Left = 424
                Top = 203
                Width = 130
                Height = 19
                Caption = 'Data de vencimento'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object edtDescription: TEdit
                Left = 8
                Top = 35
                Width = 849
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object edtProvider: TEdit
                Left = 8
                Top = 99
                Width = 329
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object edtSubCategory: TEdit
                Left = 424
                Top = 99
                Width = 361
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object edtFormPayment: TEdit
                Left = 8
                Top = 163
                Width = 329
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object edtInstallmentesValue: TEdit
                Left = 8
                Top = 227
                Width = 401
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object edtIssueDate: TDateTimePicker
                Left = 424
                Top = 227
                Width = 433
                Height = 27
                Date = 44888.714996817130000000
                Time = 44888.714996817130000000
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
                TabOrder = 5
              end
            end
          end
        end
      end
    end
  end
  inherited pgcSearch: TPageControl
    inherited tabSearch: TTabSheet
      inherited pnlSearch: TPanel
        object Label3: TLabel [3]
          Left = 352
          Top = 6
          Width = 55
          Height = 19
          Caption = 'Situa'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel [4]
          Left = 512
          Top = 7
          Width = 28
          Height = 19
          Caption = 'M'#234's'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
        end
        object cbxFilterSituation: TComboBox
          Left = 352
          Top = 32
          Width = 145
          Height = 27
          ItemIndex = 0
          TabOrder = 1
          Text = 'Todas'
          Items.Strings = (
            'Todas'
            'N'#227'o Pagas'
            'Pagas')
        end
        object cbxFilterMonth: TComboBox
          Left = 512
          Top = 32
          Width = 145
          Height = 27
          ItemIndex = 0
          TabOrder = 2
          Text = 'Todos'
          Items.Strings = (
            'Todos'
            'Janeiro'
            'Fevereiro'
            'Mar'#231'o'
            'Abril'
            'Maio'
            'Junho'
            'Julho'
            'Agosto'
            'Setembro'
            'Outubro'
            'Novembro'
            'Dezembro')
        end
      end
    end
  end
  inherited pmActionMenu: TPopupMenu
    object Efetuarpagamento1: TMenuItem [5]
      Caption = 'Realizar Pagamento'
      OnClick = Efetuarpagamento1Click
    end
    object N2: TMenuItem [6]
      Caption = '-'
    end
  end
end
