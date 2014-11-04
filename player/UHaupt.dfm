object Fplayer: TFplayer
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsSingle
  Caption = 'Fplayer'
  ClientHeight = 176
  ClientWidth = 249
  Color = clBtnFace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Lzeit: TLabel
    Left = 8
    Top = 39
    Width = 59
    Height = 13
    Caption = '00:00 00:00'
  end
  object bplaypause: TButton
    Left = 8
    Top = 8
    Width = 25
    Height = 25
    Caption = '>'
    TabOrder = 0
    OnClick = bplaypauseClick
  end
  object bnext: TButton
    Left = 132
    Top = 8
    Width = 25
    Height = 25
    Caption = '|>'
    TabOrder = 1
    OnClick = bnextClick
  end
  object bprev: TButton
    Left = 101
    Top = 8
    Width = 25
    Height = 25
    Caption = '<|'
    TabOrder = 2
    OnClick = bprevClick
  end
  object bopen: TButton
    Left = 70
    Top = 8
    Width = 25
    Height = 25
    Caption = '^'
    TabOrder = 3
    OnClick = bopenClick
  end
  object bstop: TButton
    Left = 39
    Top = 8
    Width = 25
    Height = 25
    Caption = '[]'
    TabOrder = 4
    OnClick = bstopClick
  end
  object posi: TScrollBar
    Left = 8
    Top = 58
    Width = 233
    Height = 16
    PageSize = 0
    TabOrder = 5
    OnScroll = posiScroll
  end
  object ls: TScrollBar
    Left = 177
    Top = 36
    Width = 64
    Height = 16
    Max = 255
    PageSize = 0
    TabOrder = 6
    OnChange = lsChange
  end
  object Bplayliste: TButton
    Left = 217
    Top = 8
    Width = 24
    Height = 25
    Caption = 'PL'
    TabOrder = 7
    OnClick = BplaylisteClick
  end
  object Pspectrum: TPanel
    Left = 8
    Top = 93
    Width = 233
    Height = 69
    BevelOuter = bvNone
    Caption = 'Pspectrum'
    TabOrder = 8
  end
  object Zeit: TTimer
    Enabled = False
    OnTimer = ZeitTimer
    Left = 8
    Top = 128
  end
  object TiSpectrum: TTimer
    Enabled = False
    Interval = 50
    OnTimer = TiSpectrumTimer
    Left = 32
    Top = 128
  end
  object PopupMenu1: TPopupMenu
    Left = 160
    Top = 8
    object ransparenz1: TMenuItem
      Caption = 'Transparenz'
      OnClick = ransparenz1Click
    end
    object Playlist1: TMenuItem
      Caption = 'Playlist'
      OnClick = BplaylisteClick
    end
    object Info1: TMenuItem
      Caption = 'Info'
      OnClick = Info1Click
    end
    object Beenden1: TMenuItem
      Caption = 'Beenden'
    end
  end
end
