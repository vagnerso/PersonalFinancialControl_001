object dtmConnection: TdtmConnection
  Height = 480
  Width = 640
  object conConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Arquivos_de_Trabalho\Projetos_Delphi\PersonalFinanci' +
        'alControl_001\database\PersonalFinancialControl'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 104
    Top = 112
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 120
    Top = 216
  end
end
