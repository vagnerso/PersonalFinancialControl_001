object frmImport: TfrmImport
  Left = 0
  Top = 0
  Caption = 'Importar Lista de IPs'
  ClientHeight = 507
  ClientWidth = 859
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 19
  object pcGeneral: TPageControl
    Left = 0
    Top = 0
    Width = 859
    Height = 466
    ActivePage = tabJSON
    Align = alClient
    TabOrder = 0
    object tabJSON: TTabSheet
      Caption = 'Visualizar JSON'
      ExplicitTop = 24
      ExplicitWidth = 281
      ExplicitHeight = 165
      object mmJson: TMemo
        Left = 0
        Top = 0
        Width = 851
        Height = 432
        Align = alClient
        Lines.Strings = (
          'mmJson')
        TabOrder = 0
        ExplicitLeft = 256
        ExplicitTop = 128
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
    object tabImport: TTabSheet
      Caption = 'Visualizar IPs em texto'
      ImageIndex = 1
      ExplicitTop = 24
      ExplicitWidth = 281
      ExplicitHeight = 165
      object mmText: TMemo
        Left = 0
        Top = 0
        Width = 851
        Height = 432
        Align = alClient
        Lines.Strings = (
          'mmText')
        TabOrder = 0
        ExplicitLeft = 256
        ExplicitTop = 128
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
    object tabGrid: TTabSheet
      Caption = 'Visualizar em grade'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitTop = 24
      ExplicitWidth = 691
      ExplicitHeight = 339
      object grData: TDBGrid
        Left = 0
        Top = 0
        Width = 851
        Height = 432
        Align = alClient
        DataSource = dsGrid
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Calibri'
        TitleFont.Style = []
      end
    end
  end
  object pnMenu: TPanel
    Left = 0
    Top = 466
    Width = 859
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 264
    ExplicitTop = 240
    ExplicitWidth = 185
    object btImport: TButton
      Left = 1
      Top = 1
      Width = 128
      Height = 39
      Align = alLeft
      Caption = 'Importar'
      TabOrder = 0
      OnClick = btImportClick
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://www.gstatic.com/ipranges'
    Params = <>
    HandleRedirects = True
    Left = 32
    Top = 8
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Resource = 'cloud.json'
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 120
    Top = 8
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 208
    Top = 8
  end
  object dsGrid: TDataSource
    Left = 344
    Top = 248
  end
end
