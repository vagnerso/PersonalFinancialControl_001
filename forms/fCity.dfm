inherited frmCity: TfrmCity
  Caption = 'Cidades'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Caption = 'Cidades'
  end
  inherited pnlMain: TPanel
    ExplicitTop = 172
    ExplicitHeight = 418
  end
  inherited pnlGeneral: TPanel
    ExplicitTop = 172
    ExplicitHeight = 418
    inherited pgcGeneral: TPageControl
      ActivePage = tabGrid
      ExplicitHeight = 418
      inherited tabGrid: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 887
        ExplicitHeight = 389
      end
      inherited tabRegister: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 887
        ExplicitHeight = 389
        inherited pnlMainRegister: TPanel
          ExplicitTop = 348
        end
        inherited pgcRegister: TPageControl
          ExplicitHeight = 348
          inherited tabRegisterBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 25
            ExplicitWidth = 879
            ExplicitHeight = 319
            inherited pnlRegisterBasic: TPanel
              ExplicitHeight = 319
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
                Top = 75
                Width = 87
                Height = 19
                Caption = 'C'#243'digo SEFAZ'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object lb2: TLabel
                Left = 264
                Top = 75
                Width = 17
                Height = 19
                Caption = 'UF'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -16
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 497
                Height = 27
                TabOrder = 0
              end
              object edtSefazCode: TEdit
                Left = 8
                Top = 100
                Width = 233
                Height = 27
                NumbersOnly = True
                TabOrder = 1
              end
              object cbxUF: TComboBox
                Left = 264
                Top = 100
                Width = 241
                Height = 27
                Style = csDropDownList
                ItemIndex = 20
                TabOrder = 2
                Text = 'RS'
                Items.Strings = (
                  'AC'
                  'AL'
                  'AP'
                  'AM'
                  'BA'
                  'CE'
                  'DF'
                  'ES'
                  'GO'
                  'MA'
                  'MT'
                  'MS'
                  'MG'
                  'PA'
                  'PB'
                  'PR'
                  'PE'
                  'PI'
                  'RJ'
                  'RN'
                  'RS'
                  'RO'
                  'RR'
                  'SC'
                  'SP'
                  'SE'
                  'TO')
              end
            end
          end
        end
      end
    end
  end
  inherited pgcSearch: TPageControl
    ExplicitTop = 60
    inherited tabSearch: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 25
      ExplicitWidth = 1037
      ExplicitHeight = 83
    end
  end
  inherited pmActionMenu: TPopupMenu
    Left = 536
    Top = 432
  end
end
