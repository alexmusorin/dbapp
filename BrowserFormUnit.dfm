object BrowserForm: TBrowserForm
  Left = 0
  Top = 0
  Caption = 'Browser'
  ClientHeight = 404
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object WB: TWebBrowser
    Left = 0
    Top = 24
    Width = 611
    Height = 380
    Align = alClient
    TabOrder = 0
    OnCommandStateChange = WBCommandStateChange
    OnDocumentComplete = WBDocumentComplete
    ExplicitLeft = 128
    ExplicitTop = 208
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000263F0000462700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 611
    Height = 24
    Caption = 'ToolBar1'
    DrawingStyle = dsGradient
    GradientEndColor = 15717318
    Images = ImageList1
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = Action1
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Action = Action2
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 0
      Action = Action3
    end
    object Edit1: TEdit
      Left = 69
      Top = 0
      Width = 484
      Height = 22
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object ToolButton4: TToolButton
      Left = 553
      Top = 0
      Action = Action4
    end
  end
  object ImageList1: TImageList
    Left = 448
    Top = 88
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A0A0004040
      4000404040004040400040404000404040004040400040404000404040004040
      40004040400040404000A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E6E1E00DAAF4100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DAAF41008E6E1E000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004040400080E0
      E00080E0E00080E0E00080E0E00080E0E00080E0E00080E0E00080E0E00080E0
      E00080E0E00080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000815E0500CF9808008B6A1900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008B6A1900CF980800815E050000000000000000000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF00F0FBFF0080208000F0FBFF00F0FBFF00F0FBFF00F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000087651000CF980800F6CB970089681400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000089681400F6CB9700CF98080087651000000000000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF008020800080208000F0FBFF00F0FBFF00F0FBFF00F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000087651000CF980800F6CB9700F6CB9700825F0800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000825F0800F6CB9700F6CB9700CF980800876510000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF008060A00080208000802080008020800080208000C0A0C000F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000825F0700CF980800F6CB9700F6CB9700F6CB97007F5B000083610A009476
      2B0088671300D5A4270000000000000000000000000000000000D5A427008867
      130094762B0083610A007F5B0000F6CB9700F6CB9700F6CB9700CF980800825F
      070000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF008060A00080208000F0FBFF00F0FBFF0080208000F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000825F
      0700CF980800F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB9700876510000000000000000000000000000000000087651000F6CB
      9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700CF98
      0800825F0700000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF00F0FBFF008060A000F0FBFF00F0FBFF0080208000F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F702100CF98
      0800F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB97008B6A1900000000000000000000000000000000008B6A1900F6CB
      9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700CF9808008F7021000000000000000000000000000000000040404000F0FB
      FF00F0FBFF0080208000F0FBFF00F0FBFF00F0FBFF00F0FBFF0080208000F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6A82F00FFF3
      D500F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700F6CB9700907124000000000000000000000000000000000090712400F6CB
      9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB9700F6CB
      9700FFF3D500D6A82F000000000000000000000000000000000040404000F0FB
      FF00F0FBFF0080208000F0FBFF00F0FBFF0080208000F0FBFF00F0FBFF00F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D19C
      1200FFF3D500F6CB9700F6CB9700F6CB9700FFF3D500FFF3D500FFF3D500FFF3
      D500FFF3D50094762B000000000000000000000000000000000094762B00FFF3
      D500FFF3D500FFF3D500FFF3D500FFF3D500F6CB9700F6CB9700F6CB9700FFF3
      D500D19C1200000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF0080208000F0FBFF00F0FBFF008020800080208000F0FBFF00F0FB
      FF00F0FBFF0080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D2A11E00FFF3D500F6CB9700F6CB9700FFF3D5007F5B0000CF980800CF98
      0800CF980800DAB0450000000000000000000000000000000000DAB04500CF98
      0800CF980800CF9808007F5B0000FFF3D500F6CB9700F6CB9700FFF3D500D2A1
      1E0000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00C0A0C000802080008020800080208000802080008060A000F0FB
      FF0080E0E00080E0E00040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D19F1A00FFF3D500F6CB9700FFF3D5007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F5B0000FFF3D500F6CB9700FFF3D500D19F1A000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00802080008060A000F0FBFF004060
      6000406060004060600040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D19C1200FFF3D500FFF3D5007F5B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F5B0000FFF3D500FFF3D500D19C1200000000000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF00F0FBFF00F0FBFF008060A000F0FBFF00F0FBFF004060
      6000F0FBFF00F0FBFF0040404000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D29F1B00FFF3D500815E0500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000815E0500FFF3D500D29F1B0000000000000000000000
      000000000000000000000000000000000000000000000000000040404000F0FB
      FF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF004060
      6000F0FBFF004040400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3A01D008B6A1900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008B6A1900D3A01D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A4A0A0004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900F9F9
      F900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFC0010000FF3FFCFFC0010000
      FE3FFC7FC0010000FC3FFC3FC0010000F83FFC1FC0010000F003C00FC0010000
      E003C007C0010000C003C003C0010000C003C003C0010000E003C007C0010000
      F003C00FC0010000F83FFC1FC0010000FC3FFC3FC0010000FE3FFC7FC0030000
      FF3FFCFFC0070000FFFFFFFFCFFF000000000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 320
    Top = 120
    object Action1: TAction
      Caption = 'Action1'
      Enabled = False
      ImageIndex = 0
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Action2'
      Enabled = False
      ImageIndex = 1
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Caption = 'Action3'
      ImageIndex = 2
      OnExecute = Action3Execute
    end
    object Action4: TAction
      Caption = 'Action4'
      ImageIndex = 1
      OnExecute = Action4Execute
    end
  end
end