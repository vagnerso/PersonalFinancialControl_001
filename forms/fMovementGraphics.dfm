inherited frmMovementGraphics: TfrmMovementGraphics
  Caption = 'frmMovementGraphics'
  ClientHeight = 1023
  ClientWidth = 1444
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 1456
  ExplicitHeight = 1061
  TextHeight = 19
  object pnlTitle: TPanel
    Left = 0
    Top = 0
    Width = 1444
    Height = 60
    Align = alTop
    Caption = 'Gr'#225'ficos de movimenta'#231#227'o financeira'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 1438
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 1006
    Width = 1444
    Height = 17
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 997
    ExplicitWidth = 1438
  end
  object pgcGeneral: TPageControl
    Left = 0
    Top = 130
    Width = 1444
    Height = 876
    ActivePage = tabGraphics
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 1438
    ExplicitHeight = 867
    object tabGraphics: TTabSheet
      Caption = 'Visualizar em Gr'#225'ficos'
      object scrGraphics: TScrollBox
        Left = 0
        Top = 0
        Width = 1436
        Height = 842
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        object chtFormPaymentsExpenses: TChart
          Left = 4
          Top = 0
          Width = 469
          Height = 436
          Title.Font.Color = clRed
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Sa'#237'das por forma de pagamento')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 0
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object Series2: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
        object chtCategoryExpenses: TChart
          Left = 479
          Top = 0
          Width = 465
          Height = 436
          Title.Font.Color = clRed
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Sa'#237'das por categoria')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 1
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object PieSeries1: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
        object chtSubCategoryExpenses: TChart
          Left = 950
          Top = 0
          Width = 465
          Height = 436
          Title.Font.Color = clRed
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Sa'#237'das por sub-categoria')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 2
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object PieSeries4: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
        object chtFormPaymentsRevenues: TChart
          Left = 3
          Top = 444
          Width = 469
          Height = 436
          Title.Font.Color = clGreen
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Entradas por forma de pagamento')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 3
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object PieSeries2: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
        object chtCategoryRevenues: TChart
          Left = 478
          Top = 444
          Width = 466
          Height = 436
          Title.Font.Color = clGreen
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Entradas por categoria')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 4
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object PieSeries6: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
        object chtSubCategoryRevenues: TChart
          Left = 950
          Top = 444
          Width = 466
          Height = 436
          Title.Font.Color = clGreen
          Title.Font.Height = -19
          Title.Font.Name = 'Tahoma'
          Title.Text.Strings = (
            'Entradas por sub-categoria')
          View3DOptions.Elevation = 315
          View3DOptions.Orthogonal = False
          View3DOptions.Perspective = 0
          View3DOptions.Rotation = 360
          Color = clWhite
          TabOrder = 5
          DefaultCanvas = 'TGDIPlusCanvas'
          ColorPaletteIndex = 13
          object PieSeries5: TPieSeries
            HoverElement = []
            Marks.Tail.Margin = 2
            XValues.Order = loAscending
            YValues.Name = 'Pie'
            YValues.Order = loNone
            Frame.InnerBrush.BackColor = clRed
            Frame.InnerBrush.Gradient.EndColor = clGray
            Frame.InnerBrush.Gradient.MidColor = clWhite
            Frame.InnerBrush.Gradient.StartColor = 4210752
            Frame.InnerBrush.Gradient.Visible = True
            Frame.MiddleBrush.BackColor = clYellow
            Frame.MiddleBrush.Gradient.EndColor = 8553090
            Frame.MiddleBrush.Gradient.MidColor = clWhite
            Frame.MiddleBrush.Gradient.StartColor = clGray
            Frame.MiddleBrush.Gradient.Visible = True
            Frame.OuterBrush.BackColor = clGreen
            Frame.OuterBrush.Gradient.EndColor = 4210752
            Frame.OuterBrush.Gradient.MidColor = clWhite
            Frame.OuterBrush.Gradient.StartColor = clSilver
            Frame.OuterBrush.Gradient.Visible = True
            Frame.Width = 4
            OtherSlice.Legend.Visible = False
          end
        end
      end
    end
    object tabLists: TTabSheet
      Caption = 'Visualizar em listas'
      ImageIndex = 1
      object scrLists: TScrollBox
        Left = 0
        Top = 0
        Width = 1436
        Height = 842
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        object pn1: TPanel
          Left = 3
          Top = 3
          Width = 398
          Height = 326
          TabOrder = 0
          object lb1: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Sa'#237'das por forma de pagamento'
            Color = 3684595
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 249
          end
          object grdFormPaymentsExpenses: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsFormPaymentsExpenses
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
        object Panel1: TPanel
          Left = 3
          Top = 335
          Width = 398
          Height = 326
          TabOrder = 1
          object lb3: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Entradas por forma de pagamento'
            Color = 6009689
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 268
          end
          object grdFormPaymentsRevenues: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsFormPaymentsRevenues
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
        object Panel2: TPanel
          Left = 407
          Top = 3
          Width = 398
          Height = 326
          TabOrder = 2
          object lb2: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Sa'#237'das por categoria'
            Color = 3684595
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 159
          end
          object grdSubCategorysExpenses: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsSubCategorysExpenses
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
        object Panel3: TPanel
          Left = 407
          Top = 335
          Width = 398
          Height = 326
          TabOrder = 3
          object lb4: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Entradas por categoria'
            Color = 6009689
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 178
          end
          object grdSubCategorysRevenues: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsSubCategorysRevenues
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
        object Panel4: TPanel
          Left = 811
          Top = 3
          Width = 398
          Height = 326
          TabOrder = 4
          object Label1: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Sa'#237'das por sub-categoria'
            Color = 3684595
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 193
          end
          object grdCategorysExpenses: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsCategorysExpenses
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
        object Panel5: TPanel
          Left = 811
          Top = 335
          Width = 398
          Height = 326
          TabOrder = 5
          object lb5: TLabel
            Left = 1
            Top = 1
            Width = 396
            Height = 23
            Align = alTop
            Alignment = taCenter
            Caption = 'Entradas por sub-categoria'
            Color = 6009689
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Calibri'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 212
          end
          object grdCategorysRevenues: TDBGrid
            Left = 1
            Top = 24
            Width = 396
            Height = 301
            Align = alClient
            BorderStyle = bsNone
            DataSource = dtsCategorysRevenues
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Calibri'
            TitleFont.Style = []
          end
        end
      end
    end
    object tabTotals: TTabSheet
      Caption = 'Visualizar os totais'
      ImageIndex = 2
      object scrTotals: TScrollBox
        Left = 0
        Top = 0
        Width = 1436
        Height = 842
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  object pnlFilters: TPanel
    Left = 0
    Top = 60
    Width = 1444
    Height = 70
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 1438
    object lb6: TLabel
      Left = 8
      Top = 6
      Width = 55
      Height = 19
      Caption = 'Situa'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object lblMonthYear: TLabel
      Left = 296
      Top = 6
      Width = 58
      Height = 19
      Caption = 'M'#234's/Ano'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object lblFilterInitialDate: TLabel
      Left = 464
      Top = 6
      Width = 74
      Height = 19
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object lblFilterEndDate: TLabel
      Left = 616
      Top = 6
      Width = 66
      Height = 19
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 136
      Top = 6
      Width = 103
      Height = 19
      Caption = 'Filtrar datas por'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
    object cbxFilterSituation: TComboBox
      Left = 8
      Top = 31
      Width = 113
      Height = 27
      ItemIndex = 2
      TabOrder = 0
      Text = 'Pagos'
      Items.Strings = (
        'Todas'
        'N'#227'o Pagos'
        'Pagos')
    end
    object cbxFilterMonthOrYear: TComboBox
      Left = 296
      Top = 31
      Width = 141
      Height = 27
      TabOrder = 1
    end
    object edtFilterInitialDate: TDateTimePicker
      Left = 464
      Top = 32
      Width = 129
      Height = 27
      Date = 44903.000000000000000000
      Time = 0.348942754630115800
      TabOrder = 2
    end
    object edtFilterEndDate: TDateTimePicker
      Left = 616
      Top = 32
      Width = 129
      Height = 27
      Date = 44903.000000000000000000
      Time = 0.348942754630115800
      TabOrder = 3
    end
    object cbxFilterDateBy: TComboBox
      Left = 136
      Top = 31
      Width = 141
      Height = 27
      ItemIndex = 0
      TabOrder = 4
      Text = 'M'#234's'
      OnChange = cbxFilterDateByChange
      Items.Strings = (
        'M'#234's'
        'Ano'
        'Per'#237'odo')
    end
    object btnSearchExecute: TButton
      Left = 768
      Top = 16
      Width = 180
      Height = 40
      Caption = 'Atualizar pesquisa'
      TabOrder = 5
      OnClick = btnSearchExecuteClick
    end
  end
  object dtsFormPaymentsExpenses: TDataSource
    Left = 104
    Top = 168
  end
  object dtsFormPaymentsRevenues: TDataSource
    Left = 560
    Top = 160
  end
  object dtsSubCategorysExpenses: TDataSource
    Left = 120
    Top = 624
  end
  object dtsSubCategorysRevenues: TDataSource
    Left = 576
    Top = 616
  end
  object dtsCategorysExpenses: TDataSource
    Left = 112
    Top = 960
  end
  object dtsCategorysRevenues: TDataSource
    Left = 568
    Top = 952
  end
end
