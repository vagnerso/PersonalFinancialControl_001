inherited frmManageMovements: TfrmManageMovements
  Caption = 'frmManageMovements'
  OnDestroy = FormDestroy
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
          ExplicitTop = 358
          ExplicitWidth = 881
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
                  42CF0000009C4944415478DA6364A031601CB560D05AA001C4D3813812885F10
                  3043148857007101105F26D682BD40EC04C457A0F46B3C86EF03621D28ED4CAC
                  05A2504B7481F806103B62F109316AF0C6013E0388329C9005B80CFA4BACE1C4
                  58801ECE57A0623036BEF821DA02749F3010E3F24165014D8388A6914CD3644A
                  F38C46F3A202A4612210473010884406446197CF80480444C50155C0A805036F
                  01006B284419F40874B80000002574455874646174653A637265617465003230
                  32322D30382D32305430323A33313A31342B30303A3030D1C8BEC90000002574
                  455874646174653A6D6F6469667900323032322D30382D32305430323A33313A
                  31342B30303A3030A09506750000000049454E44AE426082}
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
                  42CF000001334944415478DADDD53F4A034114C7F159580CA416044DC2A287B0
                  50037A87A8E805C414B6365A68632BA29EC07FE40E11510BEF20BAA8B1B11715
                  0BBF0FDF1282C9EC8CBB5BE8830F53ECBCF991CDCC6C600AAEE05F07CCA0A9E3
                  305E70897D5C650908B187154BDF01D6F0F99B80435DFC153B38C2132A58C63A
                  CA1AD2F40DA8E342179FC34D9F9E49B435641AD73E01A758C026B62D7D1BD8C2
                  09967C023A18C504EE2C7DF2FC56E7577C02DE3184123E2C7DF2FC4DE7948AFC
                  05CF18F3099077BA68DCFF83339DEF1C20BB420E93EB2EAAEB7CE7002939A9AB
                  A67B0E8EF188AAF9DE31C9396861DEA4D4A093BCAB21834A166F20C6AC8ECE01
                  494D99EE5D34627AEF2219EF11A58564B94D6B38C7381E34E4C7CECB7A5DA786
                  E4F13DB086E4F5C14942C2A202A4221DE3BC5F91B5FE7EC0171B6C4819A051CA
                  340000002574455874646174653A63726561746500323032322D30382D303654
                  31323A34373A34372B30303A30309647D7A10000002574455874646174653A6D
                  6F6469667900323032322D30382D30365431323A34373A34372B30303A3030E7
                  1A6F1D0000000049454E44AE426082}
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
                  42CF0000009C4944415478DA6364A031601CB560D05AA001C4D3813812885F10
                  3043148857007101105F26D682BD40EC04C457A0F46B3C86EF03621D28ED4CAC
                  05A2504B7481F806103B62F109316AF0C6013E0388329C9005B80CFA4BACE1C4
                  58801ECE57A0623036BEF821DA02749F3010E3F24165014D8388A6914CD3644A
                  F38C46F3A202A4612210473010884406446197CF80480444C50155C0A805036F
                  01006B284419F40874B80000002574455874646174653A637265617465003230
                  32322D30382D32305430323A33313A31342B30303A3030D1C8BEC90000002574
                  455874646174653A6D6F6469667900323032322D30382D32305430323A33313A
                  31342B30303A3030A09506750000000049454E44AE426082}
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
                  42CF000001334944415478DADDD53F4A034114C7F159580CA416044DC2A287B0
                  50037A87A8E805C414B6365A68632BA29EC07FE40E11510BEF20BAA8B1B11715
                  0BBF0FDF1282C9EC8CBB5BE8830F53ECBCF991CDCC6C600AAEE05F07CCA0A9E3
                  305E70897D5C650908B187154BDF01D6F0F99B80435DFC153B38C2132A58C63A
                  CA1AD2F40DA8E342179FC34D9F9E49B435641AD73E01A758C026B62D7D1BD8C2
                  09967C023A18C504EE2C7DF2FC56E7577C02DE3184123E2C7DF2FC4DE7948AFC
                  05CF18F3099077BA68DCFF83339DEF1C20BB420E93EB2EAAEB7CE7002939A9AB
                  A67B0E8EF188AAF9DE31C9396861DEA4D4A093BCAB21834A166F20C6AC8ECE01
                  494D99EE5D34627AEF2219EF11A58564B94D6B38C7381E34E4C7CECB7A5DA786
                  E4F13DB086E4F5C14942C2A202A4221DE3BC5F91B5FE7EC0171B6C4819A051CA
                  340000002574455874646174653A63726561746500323032322D30382D303654
                  31323A34373A34372B30303A30309647D7A10000002574455874646174653A6D
                  6F6469667900323032322D30382D30365431323A34373A34372B30303A3030E7
                  1A6F1D0000000049454E44AE426082}
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
                  42CF0000009C4944415478DA6364A031601CB560D05AA001C4D3813812885F10
                  3043148857007101105F26D682BD40EC04C457A0F46B3C86EF03621D28ED4CAC
                  05A2504B7481F806103B62F109316AF0C6013E0388329C9005B80CFA4BACE1C4
                  58801ECE57A0623036BEF821DA02749F3010E3F24165014D8388A6914CD3644A
                  F38C46F3A202A4612210473010884406446197CF80480444C50155C0A805036F
                  01006B284419F40874B80000002574455874646174653A637265617465003230
                  32322D30382D32305430323A33313A31342B30303A3030D1C8BEC90000002574
                  455874646174653A6D6F6469667900323032322D30382D32305430323A33313A
                  31342B30303A3030A09506750000000049454E44AE426082}
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
                  42CF000001334944415478DADDD53F4A034114C7F159580CA416044DC2A287B0
                  50037A87A8E805C414B6365A68632BA29EC07FE40E11510BEF20BAA8B1B11715
                  0BBF0FDF1282C9EC8CBB5BE8830F53ECBCF991CDCC6C600AAEE05F07CCA0A9E3
                  305E70897D5C650908B187154BDF01D6F0F99B80435DFC153B38C2132A58C63A
                  CA1AD2F40DA8E342179FC34D9F9E49B435641AD73E01A758C026B62D7D1BD8C2
                  09967C023A18C504EE2C7DF2FC56E7577C02DE3184123E2C7DF2FC4DE7948AFC
                  05CF18F3099077BA68DCFF83339DEF1C20BB420E93EB2EAAEB7CE7002939A9AB
                  A67B0E8EF188AAF9DE31C9396861DEA4D4A093BCAB21834A166F20C6AC8ECE01
                  494D99EE5D34627AEF2219EF11A58564B94D6B38C7381E34E4C7CECB7A5DA786
                  E4F13DB086E4F5C14942C2A202A4221DE3BC5F91B5FE7EC0171B6C4819A051CA
                  340000002574455874646174653A63726561746500323032322D30382D303654
                  31323A34373A34372B30303A30309647D7A10000002574455874646174653A6D
                  6F6469667900323032322D30382D30365431323A34373A34372B30303A3030E7
                  1A6F1D0000000049454E44AE426082}
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
                Date = 44888.000000000000000000
                Time = 0.714996817128849200
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
