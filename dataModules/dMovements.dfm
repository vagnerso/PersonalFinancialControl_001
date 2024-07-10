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
end
