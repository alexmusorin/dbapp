object ConfigDialog: TConfigDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
  ClientHeight = 129
  ClientWidth = 428
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
    Left = 8
    Top = 27
    Width = 43
    Height = 13
    Caption = #1060#1072#1081#1083' '#1041#1044
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 65
    Height = 13
    Caption = #1048#1084#1103' '#1082#1086#1085#1092#1080#1075#1072
  end
  object Panel1: TPanel
    Left = 0
    Top = 88
    Width = 428
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 152
    ExplicitTop = 192
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 232
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Edit1: TEdit
    Left = 80
    Top = 24
    Width = 323
    Height = 21
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 80
    Top = 51
    Width = 323
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 382
    Top = 26
    Width = 19
    Height = 17
    Caption = '...'
    TabOrder = 3
    OnClick = Button1Click
  end
end
