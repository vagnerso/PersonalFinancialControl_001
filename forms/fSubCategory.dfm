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
