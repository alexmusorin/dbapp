object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 315
  Width = 399
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object ADOTable1: TADOTable
    Connection = ADOConnection1
    Left = 112
    Top = 96
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 40
    Top = 96
  end
  object OpenDialog1: TOpenDialog
    Left = 208
    Top = 136
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 280
    Top = 80
  end
end
