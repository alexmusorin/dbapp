object ErrorForm: TErrorForm
  Left = 336
  Top = 198
  BorderStyle = bsDialog
  Caption = 'ErrorForm'
  ClientHeight = 275
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DescriptionLabel: TLabel
    Left = 56
    Top = 16
    Width = 305
    Height = 138
    AutoSize = False
    Caption = 'DescriptionLabel'
    WordWrap = True
  end
  object Image1: TImage
    Left = 8
    Top = 16
    Width = 32
    Height = 32
  end
  object OkButton: TButton
    Left = 294
    Top = 249
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object DetailStatic: TStaticText
    Left = 8
    Top = 172
    Width = 365
    Height = 71
    AutoSize = False
    BorderStyle = sbsSunken
    Caption = 'DetailStatic'
    TabOrder = 1
  end
end
