object ModuleDialog: TModuleDialog
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1091#1083#1103
  ClientHeight = 157
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 19
    Width = 88
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1086#1076#1091#1083#1103
  end
  object Label2: TLabel
    Left = 32
    Top = 51
    Width = 58
    Height = 13
    Caption = #1058#1080#1087' '#1084#1086#1076#1091#1083#1103
  end
  object Label3: TLabel
    Left = 32
    Top = 80
    Width = 369
    Height = 30
    AutoSize = False
    BiDiMode = bdLeftToRight
    Caption = 
      #1057#1090#1072#1085#1076#1072#1088#1090#1085#1099#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1081' '#1074#1099#1087#1086#1083#1085#1103#1077#1084#1099#1093' '#1087#1088#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1080' '#1089#1086#1089#1090 +
      #1086#1103#1085#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' "App_onActivate", "App_onClose"'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    WordWrap = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 116
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 232
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 320
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Edit1: TEdit
    Left = 128
    Top = 16
    Width = 273
    Height = 21
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 128
    Top = 48
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'include'
      'application'
      'report'
      'toolbar')
  end
end
