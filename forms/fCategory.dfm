inherited frmCategory: TfrmCategory
  Caption = 'frmCategory'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Caption = 'CATEGORIAS'
  end
  inherited pnlGeneral: TPanel
    inherited pgcGeneral: TPageControl
      ActivePage = tabRegister
      inherited tabRegister: TTabSheet
        inherited pnlMainRegister: TPanel
          inherited pnlButtonCancel: TPanel
            OnClick = pnlButtonCancelClick
          end
        end
        inherited pgcRegister: TPageControl
          inherited tabRegisterBasic: TTabSheet
            inherited pnlRegisterBasic: TPanel
              object lb2: TLabel
                Left = 8
                Top = 31
                Width = 64
                Height = 19
                Caption = 'Unique ID'
              end
              object lb3: TLabel
                Left = 8
                Top = 103
                Width = 38
                Height = 19
                Caption = 'Name'
              end
              object edtUniqueId: TEdit
                Left = 8
                Top = 56
                Width = 217
                Height = 27
                TabOrder = 0
              end
              object edtName: TEdit
                Left = 8
                Top = 128
                Width = 217
                Height = 27
                TabOrder = 1
              end
            end
          end
        end
      end
    end
  end
end
