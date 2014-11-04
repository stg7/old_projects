object FOptionenSound: TFOptionenSound
  Left = 0
  Top = 0
  Caption = 'Sound Einstellungen'
  ClientHeight = 158
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LGesamt: TLabel
    Left = 10
    Top = 69
    Width = 90
    Height = 13
    Caption = 'Lautst'#228'rke Gesamt'
  end
  object LHintergrund: TLabel
    Left = 10
    Top = 5
    Width = 156
    Height = 13
    Caption = 'Lautst'#228'rke der Hintergrundmusik'
  end
  object LHWert: TLabel
    Left = 26
    Top = 24
    Width = 18
    Height = 19
    Caption = '50'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LGWert: TLabel
    Left = 26
    Top = 88
    Width = 18
    Height = 19
    Caption = '50'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object TBHintergrund: TTrackBar
    Left = 74
    Top = 24
    Width = 169
    Height = 33
    LineSize = 5
    Max = 100
    PageSize = 5
    Frequency = 5
    Position = 50
    TabOrder = 0
    OnChange = TBHintergrundChange
  end
  object TBGesamt: TTrackBar
    Left = 76
    Top = 88
    Width = 169
    Height = 25
    LineSize = 5
    Max = 100
    PageSize = 5
    Frequency = 5
    Position = 50
    TabOrder = 1
    OnChange = TBGesamtChange
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
