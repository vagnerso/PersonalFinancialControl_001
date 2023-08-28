inherited frmSubCategory: TfrmSubCategory
  Caption = 'frmSubCategory'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Caption = 'Sub-Categorias'
  end
  inherited pnlGeneral: TPanel
    inherited pgcGeneral: TPageControl
      inherited tabRegister: TTabSheet
        inherited pgcRegister: TPageControl
          inherited tabRegisterBasic: TTabSheet
            inherited pnlRegisterBasic: TPanel
              object lb3: TLabel
                Left = 8
                Top = 11
                Width = 38
                Height = 19
                Caption = 'Name'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label1: TLabel
                Left = 8
                Top = 67
                Width = 58
                Height = 19
                Caption = 'Category'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object imButtonClearEdtCategory: TImage
                Left = 439
                Top = 92
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
                OnClick = imButtonClearEdtCategoryClick
              end
              object imButtonSearchCategory: TImage
                Left = 475
                Top = 92
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
                OnClick = imButtonSearchCategoryClick
              end
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 497
                Height = 27
                TabOrder = 0
              end
              object edtCategory: TEdit
                Left = 8
                Top = 92
                Width = 425
                Height = 27
                TabOrder = 1
              end
            end
          end
        end
      end
    end
  end
  inherited dtsSearch: TDataSource
    Top = 400
  end
  inherited pmActionMenu: TPopupMenu
    Left = 512
    Top = 400
  end
  object dtsSearchCategory: TDataSource
    Left = 704
    Top = 328
  end
end
