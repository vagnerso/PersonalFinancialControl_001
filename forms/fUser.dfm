inherited frmUser: TfrmUser
  Caption = 'frmUser'
  ClientWidth = 1041
  OnDestroy = FormDestroy
  ExplicitWidth = 1053
  TextHeight = 24
  inherited pnlTitle: TPanel
    Width = 1041
    ExplicitWidth = 1037
  end
  inherited pnlBottom: TPanel
    Width = 1041
    ExplicitTop = 588
    ExplicitWidth = 1037
  end
  inherited pnlMain: TPanel
    ExplicitHeight = 416
  end
  inherited pnlGeneral: TPanel
    Width = 891
    ExplicitWidth = 887
    ExplicitHeight = 416
    inherited pgcGeneral: TPageControl
      Width = 891
      ActivePage = tabRegister
      ExplicitWidth = 887
      ExplicitHeight = 416
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
          ExplicitTop = 346
          ExplicitWidth = 879
          inherited pnlButtonSave: TPanel
            Left = 736
            ExplicitLeft = 732
          end
          inherited pnlButtonCancel: TPanel
            Left = 589
            ExplicitLeft = 585
          end
        end
        inherited pgcRegister: TPageControl
          Width = 883
          ExplicitWidth = 879
          ExplicitHeight = 346
          inherited tabRegisterBasic: TTabSheet
            ExplicitWidth = 875
            inherited pnlRegisterBasic: TPanel
              Width = 875
              ExplicitWidth = 871
              ExplicitHeight = 317
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
                Width = 44
                Height = 24
                Caption = 'Login'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -20
                Font.Name = 'Calibri'
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 8
                Top = 139
                Width = 51
                Height = 24
                Caption = 'Senha'
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
              object edtLogin: TEdit
                Left = 8
                Top = 100
                Width = 497
                Height = 32
                TabOrder = 1
              end
              object edtPassword: TEdit
                Left = 8
                Top = 164
                Width = 497
                Height = 32
                PasswordChar = '*'
                TabOrder = 2
              end
            end
          end
        end
      end
    end
  end
  inherited pgcSearch: TPageControl
    Width = 1041
    ExplicitWidth = 1037
    inherited tabSearch: TTabSheet
      ExplicitWidth = 1033
      inherited pnlSearch: TPanel
        Width = 1033
        ExplicitWidth = 1029
      end
    end
  end
end
