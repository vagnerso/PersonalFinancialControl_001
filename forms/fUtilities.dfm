inherited frmUtilities: TfrmUtilities
  Caption = 'frmUtilities'
  Position = poScreenCenter
  TextHeight = 19
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Utilit'#225'rios'
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 821
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 369
    Width = 652
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 336
    ExplicitTop = 272
    ExplicitWidth = 185
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 41
    Width = 652
    Height = 328
    ActivePage = tbsScriptsSql
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 821
    ExplicitHeight = 453
    object tbsScriptsSql: TTabSheet
      Caption = 'Scripts'
      object pnlScriptsSql: TPanel
        Left = 0
        Top = 0
        Width = 644
        Height = 294
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 312
        ExplicitTop = 192
        ExplicitWidth = 185
        ExplicitHeight = 41
        object btnDeleteAll: TButton
          Left = 16
          Top = 16
          Width = 217
          Height = 57
          Caption = 'Apagar todos os dados'
          TabOrder = 0
          OnClick = btnDeleteAllClick
        end
      end
    end
    object tbsThemes: TTabSheet
      Caption = 'Temas'
      ImageIndex = 1
      object pnlThemes: TPanel
        Left = 0
        Top = 0
        Width = 644
        Height = 294
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 312
        ExplicitTop = 192
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
    end
  end
end
