object Grid_Frame: TGrid_Frame
  Left = 0
  Top = 0
  Width = 389
  Height = 204
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object FilterPanel: TPanel
    Left = 0
    Top = 0
    Width = 389
    Height = 204
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object TabSet1: TTabSet
      Left = 0
      Top = 183
      Width = 389
      Height = 21
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      OnChange = TabSet1Change
    end
  end
  object DataSource: TDataSource
    DataSet = ADOQuery
    OnDataChange = DataSourceDataChange
    Left = 32
    Top = 24
  end
  object ADOQuery: TADOQuery
    AfterScroll = ADOQueryAfterScroll
    Parameters = <>
    Left = 72
    Top = 24
  end
  object ImageList1: TImageList
    Height = 12
    Width = 12
    Left = 112
    Top = 24
    Bitmap = {
      494C01010300040004000C000C00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000300000000C00000001002000000000000009
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000045302E00C8C5
      C100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D0BFBC007E4F41007C4E3D007C4D
      3F00B6AAAA000000000075737300424143000506040000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8695400B7685500B7685300BA69
      5400B5675600000000007372740051514B000B0A0C0000000000000000000000
      000000000000000000000000000000000000000000000000000045302E000000
      000000000000000000000000000000000000000000000000000000000000B869
      5400B7685500B7685300B7685300B7685300BA695400B5675600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000757373006C6E6F003F3F3F0000000000000000000000
      0000000000000000000000000000000000000000000045302E0045302E004530
      2E00000000000000000000000000000000000000000000000000000000000000
      00007E4F41007C4E3D007C4E3D007C4E3D007C4D3F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E2E2E20073737300959595004949490000000000000000000000
      0000000000000000000000000000000000007E4F41007C4E3D007C4E3D007C4E
      3D007C4D3F000000000000000000000000000000000000000000000000000000
      00000000000045302E0045302E0045302E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60091919100C7C7C70056565600A7A9A900000000000000
      0000000000000000000000000000B8695400B7685500B7685300B7685300B768
      5300BA695400B567560000000000000000000000000000000000000000000000
      0000000000000000000045302E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CCCCCC0086868600F3F3F300D7D7D7009595950046464600C2C4C4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D4D2
      D20073737300E8E8E800FCFAFA00E9E7E700D1CFCF007472720046464600C6C8
      C800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A1A1
      A100A9A9A9009C9C9C0092929200918F8F008482820068686800555555004848
      4800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000300000000C0000000100010000000000600000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFF0000000FFFFFFFFF0000000
      CFFFFFFFF0000000047FFFFFF0000000047FDFE030000000FC7F8FF070000000
      F87F07F8F0000000F83E03FDF0000000F01FFFFFF0000000E00FFFFFF0000000
      E00FFFFFF0000000FFFFFFFFF000000000000000000000000000000000000000
      000000000000}
  end
end