object JoinDialog: TJoinDialog
  Left = 0
  Top = 0
  Caption = #1054#1073#1098#1077#1076#1080#1085#1077#1085#1080#1077
  ClientHeight = 282
  ClientWidth = 366
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
    Top = 241
    Width = 366
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 96
    ExplicitTop = 144
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 273
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object ValueListEditor1: TValueListEditor
    Left = 0
    Top = 0
    Width = 366
    Height = 241
    Align = alClient
    TabOrder = 1
    TitleCaptions.Strings = (
      #1055#1072#1088#1072#1084#1077#1090#1088
      #1047#1085#1072#1095#1077#1085#1080#1077)
    ExplicitLeft = 64
    ExplicitTop = 120
    ExplicitWidth = 306
    ExplicitHeight = 300
    ColWidths = (
      150
      210)
  end
end
