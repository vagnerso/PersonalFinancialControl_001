object dtmMovements: TdtmMovements
  Height = 480
  Width = 640
  object qryMovementsReport: TFDQuery
    Connection = dtmConnection.conConnection
    SQL.Strings = (
      'SELECT                               '
      '    M.ID                             '
      '  , M.UNIQUE_ID                      '
      '  , M.DESCRIPTION       "Descri'#231#227'o"  '
      '  , M.ID_SUB_CATEGORY                '
      '  , M.ID_FORM_PAYMENT                '
      '  , M.ISSUE_DATE        "Vencimento" '
      '  , M.INSTALLMENT_VALUE "R$ Valor"   '
      '  , M.NUMBER_PARCEL     "N'#250'mero"     '
      '  , CASE M.TYPE_MOVEMENT             '
      '      WHEN 0 THEN "Entrada"          '
      '      ELSE "Sa'#237'da"                   '
      '    END "Tipo"                       '
      '  , M.ID_PERSON                      '
      '  , SC.NAME "Sub Categoria"          '
      '  , FP.NAME "Forma de Pagamento"    '
      '  , P.NAME "Fornecedor"              '
      '  , CASE M.SITUATION                 '
      '      WHEN 0 THEN "N'#227'o Pago"         '
      '      ELSE "Pago"                    '
      '    END "Situa'#231#227'o"                   '
      'FROM MOVEMENT M                     '
      '  LEFT JOIN SUB_CATEGORY SC          '
      '  ON (SC.ID = M.ID_SUB_CATEGORY)    '
      '  LEFT JOIN FORM_PAYMENT FP          '
      '  ON (FP.ID = M.ID_FORM_PAYMENT)     '
      '  LEFT JOIN PERSON P                 '
      '  ON (P.ID  = M.ID_PERSON)           '
      ' WHERE 1>0                           '
      '')
    Left = 115
    Top = 301
  end
  object frxReportMovements: TfrxReport
    Version = '2022.2.10'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45388.942498298610000000
    ReportOptions.LastChange = 45388.942498298610000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 224
    Top = 122
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        RowCount = 0
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
    end
  end
  object frxDBDatasetMovements: TfrxDBDataset
    UserName = 'frxDBDatasetMovements'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'UNIQUE_ID=UNIQUE_ID'
      'Descri'#231#227'o=Descri'#231#227'o'
      'ID_SUB_CATEGORY=ID_SUB_CATEGORY'
      'ID_FORM_PAYMENT=ID_FORM_PAYMENT'
      'Vencimento=Vencimento'
      'R$ Valor=R$ Valor'
      'N'#250'mero=N'#250'mero'
      'Tipo=Tipo'
      'ID_PERSON=ID_PERSON'
      'Sub Categoria=Sub Categoria'
      'Forma de Pagamento=Forma de Pagamento'
      'Fornecedor=Fornecedor'
      'Situa'#231#227'o=Situa'#231#227'o')
    DataSet = qryMovementsReport
    BCDToCurrency = False
    DataSetOptions = []
    Left = 333
    Top = 218
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 269
    Top = 301
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Outline = False
    Left = 474
    Top = 390
  end
end
