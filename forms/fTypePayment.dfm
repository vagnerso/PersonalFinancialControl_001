inherited frmTypePayment: TfrmTypePayment
  Caption = 'frmTypePayment'
  OnDestroy = FormDestroy
  TextHeight = 24
  inherited pnlTitle: TPanel
    Caption = 'TIPOS DE PAGAMENTO'
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
              object lb2: TLabel
                Left = 8
                Top = 71
                Width = 185
                Height = 24
                Caption = 'Permite Parcelamento'
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
              object cbxAllowsInstallment: TComboBox
                Left = 8
                Top = 96
                Width = 89
                Height = 32
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 1
                Text = 'N'#227'o'
                Items.Strings = (
                  'N'#227'o'
                  'Sim')
              end
            end
          end
        end
      end
    end
  end
end
