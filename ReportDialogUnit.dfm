object ReportDialog: TReportDialog
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1077#1090#1099' Free Report'
  ClientHeight = 366
  ClientWidth = 541
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 325
    Width = 541
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 375
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 456
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
    object BitBtn3: TBitBtn
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = #1044#1080#1079#1072#1081#1085#1077#1088
      TabOrder = 2
      OnClick = BitBtn3Click
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA1917AA1917AA1917AA1917AA1917AA1
        917AA1917AA1917AA1917AA1917AA1917A978B78FFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BFFFCF6FFF9F1FFFAF3FFFAF3FFFAF3FFFAF3FFF9F0FFF9F0FFF9F0FFFC
        F9978B78FFFFFFFFFFFFFFFFFFFFFFFFC5B39BF4ECE3D7C8B3CEBFA9CEBFA9CE
        BFA9CEBFA9CEBFA9CEBFA9D7C8B4F9F4EF978B78FFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BF7F0E6F1E4D3F1E4D3F1E4D3F1E4D3F1E4D3F1E4D3F1E4D3F1E4D3FBF7
        F1978B78FFFFFFFFFFFFFFFFFFFFFFFFC5B39BFBF5EC8A85BB6E6E9493939393
        9393939393939393939393B1AEAAFDF9F4978B78FFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BFBF5EF6E6E94F7EEE3162DDC505FE1C9D4BF16843A4DA566F7EEE3FDF9
        F6978B78FFFFFFFFFFFFFFFFFFFFFFFFC5B39BFEFBF5939393FEF7EE233AEB65
        73ECFEF7EE1998435EB577FEF7EEFEFDF9978B78FFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BFEFCFA939393FDFAF6233AEB6574EEFDFAF61998435EB679FDFAF6FEFD
        FC978B78FFFFFFFFFFFFFFFFFFFFFFFFC5B39BFEFEFE939393FDFDFD233AEB65
        75F0FDFDFD5EB67B8ECCA3FDFDFDFEFEFE978B78FFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BFFFFFF939393FFFFFF6575F1949FF5FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFA49681FFFFFFFFFFFFFFFFFFFFFFFFC5B39BFFFFFF939393FCFBFAFCFBFAFC
        FBFAFCFBFAFCFBFADED1B4D6C8ADCCBDA4C5B39BFFFFFFFFFFFFFFFFFFFFFFFF
        C5B39BFFFFFFB3B2B2FCFBFAFCFBFAFCFBFAFCFBFAFCFBFAD6C8ADDFD7CAD8CF
        C2E6E1DBFFFFFFFFFFFFFFFFFFFFFFFFC5B39BFFFFFFFDFDFCFDFDFCFDFDFCFD
        FDFCFDFDFCFDFCFCCCBDA4D8CFC2E6E1DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        D6CAB9C5B39BC5B39BC5B39BC5B39BC5B39BC5B39BD3C1A5C5B39BE6E1DBFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    end
    object BitBtn4: TBitBtn
      Left = 105
      Top = 8
      Width = 75
      Height = 25
      Caption = #1047#1072#1087#1088#1086#1089
      TabOrder = 3
      OnClick = BitBtn4Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00797979007979790079797900797979007979790079797900797979007979
        79007979790079797900797979007979790079797900FF00FF00FF00FF00FF00
        FF0086868600F0F0F100F1F1F300F1F2F200F2F2F400F3F3F400F3F4F500F4F4
        F500F5F5F600F6F6F600F7F7F800F7F8F90086868600FF00FF00FF00FF00FF00
        FF0090909000E0D6C800E0D6C800E0D6C800E0D6C800E0D6C800E0D6C800E0D6
        C800E0D6C800E0D6C800E0D6C800E0D6C80090909000FF00FF00FF00FF00FF00
        FF009D9D9D00F2F2F300F2F2F400F3F3F400F4F4F500F4F4F500F5F5F600F6F6
        F600F7F7F800F8F8F900F8F8F900F9FAFA009D9D9D00FF00FF00FF00FF00FF00
        FF00ACACAC00E0D6C800E0D6C800E0D6C800E0D6C800E0D6C800E0D6C800E0D6
        C800E0D6C800E0D6C800E0D6C800E0D6C800ACACAC00FF00FF00FF00FF00FF00
        FF00ADADAD00F3F3F400F4F4F500F4F4F500F5F6F700F6F7F800F7F7F800F8F8
        F900D7D7D800F9FAFA00FAFAFB00FBFBFC00ADADAD00FF00FF00E9E9E9004646
        4600000000000E0E0D00928C8200E0D6C8009E978D001E1D1B00000000002D2B
        28001E1D1B00CFC6B90000000000000000000000000046464600878787008787
        8700B3B3B300E2E2E30031323200E3E4E50032323200D6D6D700A3A3A3004545
        450077777800FBFCFC0000000000FF00FF00B3B3B300FF00FF00FF00FF00FF00
        FF0093939300857F77004C494400ABA3980078726B00E0D6C800B6AEA300E0D6
        C8003E3B3700E0D6C80000000000E0D6C800B5B5B500FF00FF00DADADA004646
        460062626200BCBCBD00F7F8F900BDBDBD0085858600FAFAFB00FAFBFC00FBFC
        FC0046464600FF00FF0000000000FDFEFE00B8B8B800FF00FF00C0C0C0007878
        7800BABABA00B6AEA3004C494400CFC6B9002D2B2800C2B9AD00E0D6C800857F
        77003E3B3700E0D6C80000000000E0D6C800B8B8B800FF00FF00E9E9E9004646
        46000000000022222200CBCBCB00FAFAFB00B1B2B20022222200000000004646
        4600CECFCF00FDFEFE0000000000DFDFE000BABABA00FF00FF00FF00FF00FF00
        FF00BDBDBD00F9FAFA00FAFAFB00FBFBFC00FBFCFC00FF00FF00FF00FF00FDFE
        FE00FDFEFE00BABABA00B8B8B800B8B8B800BABABA00FF00FF00FF00FF00FF00
        FF00BFBFBF00FAFAFB00E3E1E000E8E5E500FF00FF00E3E1E000E8E5E500FDFE
        FE00E3E1E000C5C5C500F6F6F600BBBBBB00F0F0F100FF00FF00FF00FF00FF00
        FF00C0C0C000FBFBFC00BDBDBD00DAD8D800FF00FF00BDBDBD00DAD8D800FBFC
        FC00BDBDBD00CACACA00BABABA00F1F2F200FF00FF00FF00FF00FF00FF00FF00
        FF00C0C0C000C0C0C000F6F3F300C0C0C000C0C0C000F6F3F300C0C0C000C0C0
        C000F6F3F300C0C0C000F8F8F900FF00FF00FF00FF00FF00FF00}
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 541
    Height = 33
    Align = alTop
    TabOrder = 1
    DesignSize = (
      541
      33)
    object Label1: TLabel
      Left = 16
      Top = 10
      Width = 68
      Height = 13
      Caption = #1048#1084#1103' '#1086#1090#1095#1077#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 105
      Top = 7
      Width = 426
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end