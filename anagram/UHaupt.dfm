object FAnagramme: TFAnagramme
  Left = 0
  Top = 0
  Caption = 'Anagramme erstellen-Steve'#39's Verfahren '
  ClientHeight = 369
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LEingabe: TLabel
    Left = 8
    Top = 8
    Width = 68
    Height = 23
    Caption = 'Eingabe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 240
    Top = 8
    Width = 72
    Height = 23
    Caption = 'Ausgabe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MIN: TMemo
    Left = 8
    Top = 32
    Width = 209
    Height = 209
    TabOrder = 0
    OnChange = MINChange
  end
  object MOUT: TMemo
    Left = 240
    Top = 32
    Width = 209
    Height = 209
    ReadOnly = True
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 464
    Top = 416
    Width = 185
    Height = 105
    Caption = 'RadioGroup1'
    TabOrder = 2
  end
  object RGArt: TRadioGroup
    Left = 24
    Top = 264
    Width = 137
    Height = 57
    Caption = 'Ver oder Entschl'#252'sseln'
    ItemIndex = 0
    Items.Strings = (
      'verschl'#252'sseln'
      'entschl'#252'sseln')
    TabOrder = 3
    OnClick = RGArtClick
  end
  object Binfo: TButton
    Left = 240
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Info'
    TabOrder = 4
    OnClick = BinfoClick
  end
end
