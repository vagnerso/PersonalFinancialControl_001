inherited frmLogin: TfrmLogin
  Caption = 'Login'
  ClientHeight = 561
  ClientWidth = 684
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'Calibri'
  ExplicitWidth = 700
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 19
  object pnlDetail: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 561
    Align = alLeft
    TabOrder = 0
  end
  object pnlLogin: TPanel
    Left = 400
    Top = 0
    Width = 284
    Height = 561
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 456
    ExplicitWidth = 334
    object lb1: TLabel
      Left = 104
      Top = 88
      Width = 116
      Height = 19
      Caption = 'Seja bem vindo(a)'
    end
    object lblUser: TLabel
      Left = 16
      Top = 144
      Width = 50
      Height = 19
      Caption = 'Usu'#225'rio'
    end
    object lblPassword: TLabel
      Left = 16
      Top = 216
      Width = 39
      Height = 19
      Caption = 'Senha'
    end
    object edtUser: TEdit
      Left = 16
      Top = 169
      Width = 249
      Height = 27
      TabOrder = 0
      Text = 'edtUser'
    end
    object edtPassword: TEdit
      Left = 16
      Top = 241
      Width = 249
      Height = 27
      TabOrder = 1
      Text = 'edtPassword'
    end
  end
end
