object StringsDialog: TStringsDialog
  Left = 654
  Top = 336
  Width = 433
  Height = 324
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 417
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      417
      41)
    object BitBtn1: TBitBtn
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 240
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 417
    Height = 245
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
