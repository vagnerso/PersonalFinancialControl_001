inherited frmFormPayment: TfrmFormPayment
  Caption = 'frmFormPayment'
  OnDestroy = FormDestroy
  TextHeight = 24
  inherited pnlTitle: TPanel
    Caption = 'FORMAS DE PAGAMENTO'
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
              object lb2: TLabel
                Left = 8
                Top = 71
                Width = 162
                Height = 24
                Caption = 'Tipo de Pagamento'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object lblNumberInstallmentes: TLabel
                Left = 8
                Top = 131
                Width = 197
                Height = 24
                Caption = 'Quantidade de Parcelas'
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
              object cbxTypePayment: TComboBox
                Left = 8
                Top = 96
                Width = 497
                Height = 32
                Style = csDropDownList
                TabOrder = 1
                OnChange = cbxTypePaymentChange
              end
              object edtNumberInstallments: TEdit
                Left = 8
                Top = 156
                Width = 125
                Height = 32
                NumbersOnly = True
                TabOrder = 2
              end
            end
          end
        end
      end
    end
  end
end
