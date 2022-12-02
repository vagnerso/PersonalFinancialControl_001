inherited frmTypePayment: TfrmTypePayment
  Caption = 'frmTypePayment'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Caption = 'TIPOS DE PAGAMENTO'
  end
  inherited pnlGeneral: TPanel
    inherited pgcGeneral: TPageControl
      ActivePage = tabRegister
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
              object lb2: TLabel
                Left = 8
                Top = 71
                Width = 143
                Height = 19
                Caption = 'Permite Parcelamento'
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
              object cbxAllowsInstallment: TComboBox
                Left = 8
                Top = 96
                Width = 89
                Height = 27
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
