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
    ExplicitWidth = 818
  end
  inherited pnlBottom: TPanel
    Top = 466
    Width = 818
    ExplicitTop = 466
    ExplicitWidth = 818
  end
  inherited pnlMain: TPanel
    Height = 313
    ExplicitHeight = 313
  end
  inherited pnlGeneral: TPanel
    Width = 668
    Height = 313
    ExplicitWidth = 668
    ExplicitHeight = 313
    inherited pgcGeneral: TPageControl
      Width = 668
      Height = 313
      ExplicitWidth = 668
      ExplicitHeight = 313
      inherited tabGrid: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 660
        ExplicitHeight = 284
        inherited grdSearch: TDBGrid
          Width = 660
          Height = 284
        end
      end
      inherited tabRegister: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 660
        ExplicitHeight = 284
        inherited pnlMainRegister: TPanel
          Top = 243
          Width = 660
          ExplicitTop = 243
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
          Height = 243
          ExplicitWidth = 660
          ExplicitHeight = 243
          inherited tabRegisterBasic: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 25
            ExplicitWidth = 652
            ExplicitHeight = 214
            inherited pnlRegisterBasic: TPanel
              Width = 652
              Height = 214
              ExplicitWidth = 652
              ExplicitHeight = 214
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
    ExplicitWidth = 818
    inherited tabSearch: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 25
      ExplicitWidth = 810
      ExplicitHeight = 83
      inherited pnlSearch: TPanel
        Width = 810
        ExplicitWidth = 810
      end
    end
  end
end
