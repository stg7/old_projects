object FMenu: TFMenu
  Left = 0
  Top = 0
  Caption = 'Men'#252
  ClientHeight = 178
  ClientWidth = 153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GBEinstellungen: TGroupBox
    Left = 16
    Top = 8
    Width = 121
    Height = 97
    Caption = 'Einstellungen'
    TabOrder = 0
    object BSound: TButton
      Left = 15
      Top = 24
      Width = 89
      Height = 25
      Caption = 'Sound'
      TabOrder = 0
      OnClick = BSoundClick
    end
    object BGrafik: TButton
      Left = 15
      Top = 55
      Width = 89
      Height = 25
      Caption = 'Grafik'
      TabOrder = 1
      OnClick = BGrafikClick
    end
  end
  object BBeenden: TButton
    Left = 31
    Top = 143
    Width = 89
    Height = 25
    Caption = 'Beenden'
    TabOrder = 1
    OnClick = BBeendenClick
  end
  object Bweiter: TButton
    Left = 32
    Top = 112
    Width = 89
    Height = 25
    Caption = 'weiter'
    TabOrder = 2
    OnClick = BweiterClick
  end
end
