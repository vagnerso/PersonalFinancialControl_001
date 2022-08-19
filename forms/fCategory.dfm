inherited frmCategory: TfrmCategory
  Caption = 'frmCategory'
  ClientHeight = 496
  ClientWidth = 818
  OnDestroy = FormDestroy
  ExplicitWidth = 834
  ExplicitHeight = 535
  PixelsPerInch = 96
  TextHeight = 19
  inherited pnlTitle: TPanel
    Width = 818
    Caption = 'CATEGORIAS'
  end
  inherited pnlBottom: TPanel
    Top = 466
    Width = 818
  end
  inherited pnlMain: TPanel
    Height = 313
  end
  inherited pnlGeneral: TPanel
    Width = 668
    Height = 313
    inherited pgcGeneral: TPageControl
      Width = 668
      Height = 313
      inherited tabGrid: TTabSheet
        inherited grdSearch: TDBGrid
          Width = 660
          Height = 279
        end
      end
      inherited tabRegister: TTabSheet
        inherited pnlMainRegister: TPanel
          Top = 238
          Width = 660
          inherited pnlButtonSave: TPanel
            Left = 366
          end
          inherited pnlButtonCancel: TPanel
            Left = 513
            OnClick = pnlButtonCancelClick
          end
        end
        inherited pgcRegister: TPageControl
          Width = 660
          Height = 238
          inherited tabRegisterBasic: TTabSheet
            inherited pnlRegisterBasic: TPanel
              Width = 652
              Height = 204
              object lb3: TLabel
                Left = 8
                Top = 11
                Width = 38
                Height = 19
                Caption = 'Name'
              end
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 497
                Height = 27
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
  inherited pgcSearch: TPageControl
    Width = 818
    inherited tabSearch: TTabSheet
      inherited pnlSearch: TPanel
        Width = 810
      end
    end
  end
end
