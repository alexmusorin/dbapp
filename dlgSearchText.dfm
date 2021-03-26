object TextSearchDialog: TTextSearchDialog
  Left = 132
  Top = 168
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1090#1077#1082#1089#1090#1072
  ClientHeight = 180
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 78
    Height = 13
    Caption = #1057#1090#1088#1086#1082#1072' '#1087#1086#1080#1089#1082#1072':'
  end
  object cbSearchText: TComboBox
    Left = 96
    Top = 8
    Width = 228
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object gbSearchOptions: TGroupBox
    Left = 8
    Top = 40
    Width = 154
    Height = 127
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
    TabOrder = 1
    object cbSearchCaseSensitive: TCheckBox
      Left = 8
      Top = 17
      Width = 140
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1103' '#1088#1077#1075#1080#1089#1090#1088
      TabOrder = 0
    end
    object cbSearchWholeWords: TCheckBox
      Left = 8
      Top = 39
      Width = 140
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1094#1077#1083#1099#1077' '#1089#1083#1086#1074#1072
      TabOrder = 1
    end
    object cbSearchFromCursor: TCheckBox
      Left = 8
      Top = 61
      Width = 140
      Height = 17
      Caption = #1053#1072#1095#1080#1085#1072#1103' '#1089' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1086#1079'.'
      TabOrder = 2
    end
    object cbSearchSelectedOnly: TCheckBox
      Left = 8
      Top = 83
      Width = 140
      Height = 17
      Caption = #1042#1085#1091#1090#1088#1080' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086
      TabOrder = 3
    end
    object cbRegularExpression: TCheckBox
      Left = 8
      Top = 104
      Width = 140
      Height = 17
      Caption = #1056#1077#1075#1091#1083#1103#1088#1085#1099#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1103
      TabOrder = 4
    end
  end
  object rgSearchDirection: TRadioGroup
    Left = 170
    Top = 40
    Width = 154
    Height = 65
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
    ItemIndex = 0
    Items.Strings = (
      '&'#1042#1087#1077#1088#1077#1076
      '&'#1053#1072#1079#1072#1076)
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 170
    Top = 149
    Width = 75
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 249
    Top = 149
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
