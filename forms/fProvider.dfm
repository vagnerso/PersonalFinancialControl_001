inherited frmProvider: TfrmProvider
  Caption = 'Cadastro de Fornecedor'
  OnDestroy = FormDestroy
  ExplicitWidth = 1053
  ExplicitHeight = 657
  TextHeight = 24
  inherited pnlTitle: TPanel
    Caption = 'Cadastro de Fornecedor'
    ExplicitWidth = 1037
  end
  inherited pnlBottom: TPanel
    ExplicitTop = 588
    ExplicitWidth = 1037
  end
  inherited pnlMain: TPanel
    ExplicitHeight = 416
  end
  inherited pnlGeneral: TPanel
    ExplicitWidth = 887
    ExplicitHeight = 416
    inherited pgcGeneral: TPageControl
      Width = 891
      Height = 417
      ExplicitWidth = 887
      ExplicitHeight = 416
      inherited tabGrid: TTabSheet
        ExplicitWidth = 883
        ExplicitHeight = 388
        inherited grdSearch: TDBGrid
          Width = 883
          Height = 388
        end
      end
      inherited tabRegister: TTabSheet
        ExplicitWidth = 883
        ExplicitHeight = 388
        inherited pnlMainRegister: TPanel
          Top = 347
          Width = 883
          inherited pnlButtonSave: TPanel
            Left = 736
          end
          inherited pnlButtonCancel: TPanel
            Left = 589
          end
        end
        inherited pgcRegister: TPageControl
          Width = 883
          Height = 347
          inherited tabRegisterBasic: TTabSheet
            ExplicitWidth = 875
            ExplicitHeight = 318
            inherited pnlRegisterBasic: TPanel
              Width = 875
              Height = 318
              object lb3: TLabel
                Left = 8
                Top = 11
                Width = 50
                Height = 24
                Caption = 'Nome'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label1: TLabel
                Left = 440
                Top = 11
                Width = 71
                Height = 24
                Caption = 'Telefone'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 8
                Top = 75
                Width = 53
                Height = 24
                Caption = 'E-Mail'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 8
                Top = 139
                Width = 78
                Height = 24
                Caption = 'Endere'#231'o'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label4: TLabel
                Left = 359
                Top = 139
                Width = 68
                Height = 24
                Caption = 'N'#250'mero'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel
                Left = 535
                Top = 139
                Width = 51
                Height = 24
                Caption = 'Bairro'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 8
                Top = 203
                Width = 58
                Height = 24
                Caption = 'Cidade'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object imButtonClearEdtCity: TImage
                Left = 423
                Top = 228
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
                OnClick = imButtonClearEdtCityClick
              end
              object imButtonSearchCity: TImage
                Left = 459
                Top = 228
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
                OnClick = imButtonSearchCityClick
              end
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 409
                Height = 32
                TabOrder = 0
              end
              object edtPhone: TEdit
                Left = 439
                Top = 36
                Width = 418
                Height = 32
                TabOrder = 1
              end
              object edtEmail: TEdit
                Left = 8
                Top = 100
                Width = 849
                Height = 32
                CharCase = ecLowerCase
                TabOrder = 2
              end
              object edtAdress: TEdit
                Left = 8
                Top = 164
                Width = 337
                Height = 32
                CharCase = ecLowerCase
                TabOrder = 3
              end
              object edtNumber: TEdit
                Left = 359
                Top = 164
                Width = 162
                Height = 32
                CharCase = ecLowerCase
                TabOrder = 4
              end
              object edtDistrict: TEdit
                Left = 535
                Top = 164
                Width = 322
                Height = 32
                CharCase = ecLowerCase
                TabOrder = 5
              end
              object edtCity: TEdit
                Left = 8
                Top = 228
                Width = 409
                Height = 32
                CharCase = ecLowerCase
                TabOrder = 6
              end
            end
          end
        end
      end
    end
  end
  inherited pgcSearch: TPageControl
    ExplicitWidth = 1037
    inherited tabSearch: TTabSheet
      ExplicitWidth = 1033
      inherited pnlSearch: TPanel
        Width = 1033
        ExplicitWidth = 1029
      end
    end
  end
  inherited pmActionMenu: TPopupMenu
    Left = 808
    Top = 40
  end
end
