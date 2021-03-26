object AddTableDialog: TAddTableDialog
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094
  ClientHeight = 214
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 173
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 216
      Top = 8
      Width = 75
      Height = 25
      Caption = '>>'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 135
      Top = 8
      Width = 75
      Height = 25
      Caption = '<<'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object Panel2: TPanel
    Left = 24
    Top = 16
    Width = 281
    Height = 145
    TabOrder = 1
    DesignSize = (
      281
      145)
    object Label1: TLabel
      Left = 71
      Top = 27
      Width = 42
      Height = 13
      Caption = #1058#1072#1073#1083#1080#1094#1072
    end
    object Label2: TLabel
      Left = 16
      Top = 54
      Width = 95
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099
    end
    object Label3: TLabel
      Left = 94
      Top = 77
      Width = 19
      Height = 13
      Caption = 'SQL'
    end
    object ComboBox1: TComboBox
      Left = 119
      Top = 24
      Width = 145
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnChange = ComboBox1Change
    end
    object Edit1: TEdit
      Left = 119
      Top = 51
      Width = 146
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object Memo1: TMemo
      Left = 120
      Top = 78
      Width = 145
      Height = 57
      Anchors = [akLeft, akTop, akRight]
      Lines.Strings = (
        '')
      TabOrder = 2
    end
  end
  object Panel3: TPanel
    Left = 143
    Top = 32
    Width = 242
    Height = 135
    Caption = 'Panel3'
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 35
      Width = 240
      Height = 99
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
    end
    object Button4: TButton
      Left = 16
      Top = 4
      Width = 89
      Height = 25
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      TabOrder = 1
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 121
      Top = 4
      Width = 88
      Height = 25
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1074#1089#1077
      TabOrder = 2
      OnClick = Button5Click
    end
  end
end
