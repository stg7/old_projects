object FOptionenGrafik: TFOptionenGrafik
  Left = 0
  Top = 0
  Caption = 'Grafik Einstellungen'
  ClientHeight = 163
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CBVollbild: TCheckBox
    Left = 32
    Top = 24
    Width = 121
    Height = 25
    Caption = 'Vollbildmodus (an/aus)'
    TabOrder = 0
  end
  object CBCrazymodus: TCheckBox
    Left = 32
    Top = 64
    Width = 121
    Height = 25
    Caption = 'Crazymodus (an/aus)'
    TabOrder = 1
  end
  object BUebernehmen: TButton
    Left = 10
    Top = 122
    Width = 81
    Height = 25
    Caption = #220'bernehmen'
    TabOrder = 2
    OnClick = BUebernehmenClick
  end
  object BAbbrechen: TButton
    Left = 168
    Top = 122
    Width = 77
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 3
    OnClick = BAbbrechenClick
  end
  object BReset: TButton
    Left = 97
    Top = 122
    Width = 65
    Height = 25
    Caption = 'Reset'
    TabOrder = 4
    OnClick = BResetClick
  end
end
