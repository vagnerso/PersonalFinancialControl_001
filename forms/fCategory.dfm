inherited frmCategory: TfrmCategory
  Caption = 'frmCategory'
  ClientHeight = 496
  ClientWidth = 818
  OnDestroy = FormDestroy
  ExplicitWidth = 830
  ExplicitHeight = 534
  TextHeight = 24
  inherited pnlTitle: TPanel
    Width = 818
    Caption = 'CATEGORIAS'
    ExplicitWidth = 814
  end
  inherited pnlBottom: TPanel
    Top = 466
    Width = 818
    ExplicitTop = 465
    ExplicitWidth = 814
  end
  inherited pnlMain: TPanel
    Height = 294
    ExplicitHeight = 293
  end
  inherited pnlGeneral: TPanel
    Width = 668
    Height = 294
    ExplicitWidth = 664
    ExplicitHeight = 293
    inherited pgcGeneral: TPageControl
      Width = 668
      Height = 294
      ActivePage = tabRegister
      ExplicitWidth = 664
      ExplicitHeight = 293
      inherited tabGrid: TTabSheet
        ExplicitWidth = 660
        ExplicitHeight = 265
        inherited grdSearch: TDBGrid
          Width = 660
          Height = 265
        end
      end
      inherited tabRegister: TTabSheet
        ExplicitWidth = 660
        ExplicitHeight = 265
        inherited pnlMainRegister: TPanel
          Top = 224
          Width = 660
          ExplicitTop = 224
          ExplicitWidth = 660
          inherited pnlButtonSave: TPanel
            Left = 366
            ExplicitLeft = 366
          end
          inherited pnlButtonCancel: TPanel
            Left = 513
            ExplicitLeft = 513
          end
        end
        inherited pgcRegister: TPageControl
          Width = 660
          Height = 224
          ExplicitWidth = 660
          ExplicitHeight = 224
          inherited tabRegisterBasic: TTabSheet
            ExplicitWidth = 652
            ExplicitHeight = 195
            inherited pnlRegisterBasic: TPanel
              Width = 652
              Height = 195
              ExplicitWidth = 652
              ExplicitHeight = 195
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
              object edtName: TEdit
                Left = 8
                Top = 36
                Width = 497
                Height = 32
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
    ExplicitWidth = 814
    inherited tabSearch: TTabSheet
      ExplicitWidth = 810
      inherited pnlSearch: TPanel
        Width = 810
        ExplicitWidth = 806
      end
    end
  end
end
