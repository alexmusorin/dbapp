object ConstDialog: TConstDialog
  Left = 0
  Top = 0
  Caption = #1050#1086#1085#1089#1090#1072#1085#1090#1099
  ClientHeight = 573
  ClientWidth = 615
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
  object Panel1: TPanel
    Left = 0
    Top = 532
    Width = 615
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 528
      Top = 6
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkCancel
    end
    object BitBtn2: TBitBtn
      Left = 439
      Top = 6
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkOK
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 26
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 5
      Width = 96
      Height = 13
      Caption = #1048#1084#1103' '#1087#1077#1088#1077#1084#1077#1085#1085#1086#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 118
      Top = 2
      Width = 485
      Height = 21
      TabOrder = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 26
    Width = 615
    Height = 506
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #1058#1077#1082#1089#1090#1086#1074#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 607
        Height = 478
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1080#1089#1091#1085#1086#1082
      ImageIndex = 1
      object Image1: TImage
        Left = 129
        Top = 0
        Width = 478
        Height = 478
        Align = alClient
        Center = True
        ExplicitLeft = 216
        ExplicitTop = 96
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 129
        Height = 478
        Align = alLeft
        TabOrder = 0
        object Button1: TButton
          Left = 12
          Top = 16
          Width = 96
          Height = 25
          Caption = #1048#1079' '#1092#1072#1081#1083#1072
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 12
          Top = 47
          Width = 96
          Height = 25
          Caption = #1042' '#1092#1072#1081#1083
          TabOrder = 1
        end
      end
    end
  end
end
