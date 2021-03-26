object TreeItemsDialog: TTreeItemsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'TreeView Items Editor'
  ClientHeight = 208
  ClientWidth = 415
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 217
    Height = 161
    Caption = '&Items'
    TabOrder = 0
    object TreeView1: TTreeView
      Left = 8
      Top = 16
      Width = 121
      Height = 137
      Indent = 19
      TabOrder = 0
      OnChange = TreeView1Change
    end
    object Button1: TButton
      Left = 135
      Top = 24
      Width = 75
      Height = 25
      Caption = '&New Item'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 135
      Top = 55
      Width = 75
      Height = 25
      Caption = 'N&ew Subitem'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 135
      Top = 86
      Width = 75
      Height = 25
      Caption = '&Delete'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 231
    Top = 8
    Width = 178
    Height = 161
    Caption = 'Item Propertys'
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 29
      Width = 26
      Height = 13
      Caption = '&Text:'
    end
    object Label2: TLabel
      Left = 6
      Top = 56
      Width = 65
      Height = 13
      Caption = 'I&mage Index:'
    end
    object z: TLabel
      Left = 6
      Top = 83
      Width = 76
      Height = 13
      Caption = '&Selected Index:'
    end
    object Label4: TLabel
      Left = 6
      Top = 110
      Width = 61
      Height = 13
      Caption = 'State Inde&x:'
    end
    object Edit1: TEdit
      Left = 82
      Top = 26
      Width = 89
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 82
      Top = 53
      Width = 49
      Height = 21
      TabOrder = 1
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      Left = 82
      Top = 80
      Width = 49
      Height = 21
      TabOrder = 2
      OnChange = Edit3Change
    end
    object Edit4: TEdit
      Left = 82
      Top = 107
      Width = 49
      Height = 21
      TabOrder = 3
      OnChange = Edit4Change
    end
  end
  object Button4: TButton
    Left = 251
    Top = 175
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 332
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button5Click
  end
end
