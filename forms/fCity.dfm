inherited frmCity: TfrmCity
  Caption = 'Cidades'
  ClientWidth = 1041
  OnDestroy = FormDestroy
  ExplicitWidth = 1057
  PixelsPerInch = 96
  TextHeight = 24
  inherited pnlTitle: TPanel
    Width = 1041
    Caption = 'Cidades'
    ExplicitWidth = 1041
  end
  inherited pnlBottom: TPanel
    Width = 1041
    ExplicitWidth = 1041
  end
  inherited pnlGeneral: TPanel
    Width = 891
    ExplicitWidth = 891
    inherited pgcGeneral: TPageControl
      Width = 891
      ExplicitWidth = 891
      inherited tabGrid: TTabSheet
        ExplicitWidth = 883
        inherited grdSearch: TDBGrid
          Width = 883
        end
      end
      inherited tabRegister: TTabSheet
        ExplicitWidth = 883
        inherited pnlMainRegister: TPanel
          Width = 883
          ExplicitTop = 347
          ExplicitWidth = 883
          inherited pnlButtonSave: TPanel
            Left = 736
            ExplicitLeft = 736
          end
          inherited pnlButtonCancel: TPanel
            Left = 589
            ExplicitLeft = 589
          end
        end
        inherited pgcRegister: TPageControl
          Width = 883
          ExplicitWidth = 883
          ExplicitHeight = 347
          inherited tabRegisterBasic: TTabSheet
            ExplicitWidth = 875
            inherited pnlRegisterBasic: TPanel
              Width = 875
              ExplicitWidth = 875
              ExplicitHeight = 318
              object lb3: TLabel
                Left = 8
                Top = 11
                Width = 49
                Height = 24
                Caption = 'Name'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label1: TLabel
                Left = 8
                Top = 75
                Width = 111
                Height = 24
                Caption = 'C'#243'digo SEFAZ'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object lb2: TLabel
                Left = 264
                Top = 75
                Width = 22
                Height = 24
                Caption = 'UF'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 497
                Height = 32
                TabOrder = 0
              end
              object edtSefazCode: TEdit
                Left = 8
                Top = 100
                Width = 233
                Height = 32
                NumbersOnly = True
                TabOrder = 1
              end
              object cbxUF: TComboBox
                Left = 264
                Top = 100
                Width = 241
                Height = 32
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
    Width = 1041
    ExplicitWidth = 1041
    inherited tabSearch: TTabSheet
      ExplicitWidth = 1033
      inherited pnlSearch: TPanel
        Width = 1033
        ExplicitWidth = 1033
      end
    end
  end
  inherited pmActionMenu: TPopupMenu
    Left = 536
    Top = 432
  end
end
