inherited frmMasterRegister: TfrmMasterRegister
  Caption = 'frmMasterRegister'
  ClientHeight = 620
  ClientWidth = 1045
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Calibri'
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitTop = -113
  ExplicitWidth = 1061
  ExplicitHeight = 659
  PixelsPerInch = 96
  TextHeight = 19
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 1045
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'TITLE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 590
    Width = 1045
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
  end
  object pnlMain: TPanel
    Left = 0
    Top = 153
    Width = 150
    Height = 437
    Align = alLeft
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 2
    object pnlButtonInsert: TPanel
      Left = 0
      Top = 0
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Incluir'
      ParentBackground = False
      TabOrder = 0
      OnClick = pnlButtonInsertClick
      OnMouseEnter = pnlButtonInsertMouseEnter
      OnMouseLeave = pnlButtonInsertMouseLeave
    end
    object pnlButtonEdit: TPanel
      Left = 0
      Top = 41
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Alterar'
      ParentBackground = False
      TabOrder = 1
      OnClick = pnlButtonEditClick
      OnMouseEnter = pnlButtonEditMouseEnter
      OnMouseLeave = pnlButtonEditMouseLeave
    end
    object pnlButtonDelete: TPanel
      Left = 0
      Top = 82
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Excluir'
      ParentBackground = False
      TabOrder = 2
      OnClick = pnlButtonDeleteClick
      OnMouseEnter = pnlButtonDeleteMouseEnter
      OnMouseLeave = pnlButtonDeleteMouseLeave
    end
    object pnlButtonPrint: TPanel
      Left = 0
      Top = 123
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Imprimir'
      ParentBackground = False
      TabOrder = 3
      OnClick = pnlButtonPrintClick
      OnMouseEnter = pnlButtonPrintMouseEnter
      OnMouseLeave = pnlButtonPrintMouseLeave
    end
    object pnlButtonClose: TPanel
      Left = 0
      Top = 164
      Width = 150
      Height = 41
      Cursor = crHandPoint
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'Fechar'
      ParentBackground = False
      TabOrder = 4
      OnClick = pnlButtonCloseClick
      OnMouseEnter = pnlButtonCloseMouseEnter
      OnMouseLeave = pnlButtonCloseMouseLeave
    end
  end
  object pnlGeneral: TPanel
    Left = 150
    Top = 153
    Width = 895
    Height = 437
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object pgcGeneral: TPageControl
      Left = 0
      Top = 0
      Width = 895
      Height = 437
      ActivePage = tabGrid
      Align = alClient
      TabOrder = 0
      object tabGrid: TTabSheet
        Caption = 'Consulta'
        object grdSearch: TDBGrid
          Left = 0
          Top = 0
          Width = 887
          Height = 403
          Align = alClient
          BorderStyle = bsNone
          DataSource = dtsSearch
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = pmActionMenu
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -16
          TitleFont.Name = 'Calibri'
          TitleFont.Style = []
          OnDrawColumnCell = grdSearchDrawColumnCell
          OnDblClick = grdSearchDblClick
        end
      end
      object tabRegister: TTabSheet
        Caption = 'Cadastro'
        ImageIndex = 1
        object pnlMainRegister: TPanel
          Left = 0
          Top = 362
          Width = 887
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object pnlButtonSave: TPanel
            Left = 593
            Top = 0
            Width = 147
            Height = 41
            Cursor = crHandPoint
            Align = alRight
            BevelKind = bkTile
            BevelOuter = bvNone
            Caption = 'Salvar'
            ParentBackground = False
            TabOrder = 0
            OnClick = pnlButtonSaveClick
            OnMouseEnter = pnlButtonSaveMouseEnter
            OnMouseLeave = pnlButtonSaveMouseLeave
          end
          object pnlButtonCancel: TPanel
            Left = 740
            Top = 0
            Width = 147
            Height = 41
            Cursor = crHandPoint
            Align = alRight
            BevelKind = bkTile
            BevelOuter = bvNone
            Caption = 'Cancelar'
            ParentBackground = False
            TabOrder = 1
            OnClick = pnlButtonCancelClick
            OnMouseEnter = pnlButtonCancelMouseEnter
            OnMouseLeave = pnlButtonCancelMouseLeave
          end
        end
        object pgcRegister: TPageControl
          Left = 0
          Top = 0
          Width = 887
          Height = 362
          ActivePage = tabRegisterBasic
          Align = alClient
          TabOrder = 1
          object tabRegisterBasic: TTabSheet
            Caption = 'B'#225'sico'
            object pnlRegisterBasic: TPanel
              Left = 0
              Top = 0
              Width = 879
              Height = 328
              Align = alClient
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object pgcSearch: TPageControl
    Left = 0
    Top = 41
    Width = 1045
    Height = 112
    ActivePage = tabSearch
    Align = alTop
    TabOrder = 4
    object tabSearch: TTabSheet
      Caption = 'Op'#231#245'es de pesquisa'
      object pnlSearch: TPanel
        Left = 0
        Top = 0
        Width = 1037
        Height = 78
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object lb1: TLabel
          Left = 16
          Top = 6
          Width = 63
          Height = 19
          Caption = 'Pesquisar'
        end
        object imButtonSearchExecute: TImage
          Left = 308
          Top = 30
          Width = 30
          Height = 30
          Cursor = crHandPoint
          Hint = 'Clique aqui para executar a pesquisa'
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000000467414D410000B18F0BFC61050000000662
            4B4744000000000000F943BB7F0000000970485973000000600000006000F06B
            42CF000001334944415478DADDD53F4A034114C7F159580CA416044DC2A287B0
            50037A87A8E805C414B6365A68632BA29EC07FE40E11510BEF20BAA8B1B11715
            0BBF0FDF1282C9EC8CBB5BE8830F53ECBCF991CDCC6C600AAEE05F07CCA0A9E3
            305E70897D5C650908B187154BDF01D6F0F99B80435DFC153B38C2132A58C63A
            CA1AD2F40DA8E342179FC34D9F9E49B435641AD73E01A758C026B62D7D1BD8C2
            09967C023A18C504EE2C7DF2FC56E7577C02DE3184123E2C7DF2FC4DE7948AFC
            05CF18F3099077BA68DCFF83339DEF1C20BB420E93EB2EAAEB7CE7002939A9AB
            A67B0E8EF188AAF9DE31C9396861DEA4D4A093BCAB21834A166F20C6AC8ECE01
            494D99EE5D34627AEF2219EF11A58564B94D6B38C7381E34E4C7CECB7A5DA786
            E4F13DB086E4F5C14942C2A202A4221DE3BC5F91B5FE7EC0171B6C4819A051CA
            340000002574455874646174653A63726561746500323032322D30382D303654
            31323A34373A34372B30303A30309647D7A10000002574455874646174653A6D
            6F6469667900323032322D30382D30365431323A34373A34372B30303A3030E7
            1A6F1D0000000049454E44AE426082}
          ShowHint = True
          OnClick = imButtonSearchExecuteClick
        end
        object imButtonClearEdtSearch: TImage
          Left = 272
          Top = 30
          Width = 30
          Height = 30
          Cursor = crHandPoint
          Hint = 'Clique aqui para limpar o campo de pesquisa'
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
            00180806000000E0773DF80000000467414D410000B18F0BFC61050000000662
            4B4744000000000000F943BB7F0000000970485973000000600000006000F06B
            42CF0000009C4944415478DA6364A031601CB560D05AA001C4D3813812885F10
            3043148857007101105F26D682BD40EC04C457A0F46B3C86EF03621D28ED4CAC
            05A2504B7481F806103B62F109316AF0C6013E0388329C9005B80CFA4BACE1C4
            58801ECE57A0623036BEF821DA02749F3010E3F24165014D8388A6914CD3644A
            F38C46F3A202A4612210473010884406446197CF80480444C50155C0A805036F
            01006B284419F40874B80000002574455874646174653A637265617465003230
            32322D30382D32305430323A33313A31342B30303A3030D1C8BEC90000002574
            455874646174653A6D6F6469667900323032322D30382D32305430323A33313A
            31342B30303A3030A09506750000000049454E44AE426082}
          ShowHint = True
          OnClick = imButtonClearEdtSearchClick
        end
        object edtSearch: TEdit
          Left = 16
          Top = 31
          Width = 250
          Height = 27
          TabOrder = 0
          TextHint = 'Digite aqui o que deseja pesquisar'
          OnKeyPress = edtSearchKeyPress
        end
      end
    end
  end
  object dtsSearch: TDataSource
    Left = 392
    Top = 392
  end
  object pmActionMenu: TPopupMenu
    Left = 520
    Top = 312
    object Incluir1: TMenuItem
      Caption = 'Incluir'
      OnClick = Incluir1Click
    end
    object Alterar1: TMenuItem
      Caption = 'Alterar'
      OnClick = Alterar1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
    object Imprimir1: TMenuItem
      Caption = 'Imprimir'
      OnClick = Imprimir1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
