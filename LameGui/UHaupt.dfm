object FLameGui: TFLameGui
  Left = 0
  Top = 0
  Caption = 'LameGui'
  ClientHeight = 280
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LBitrate: TLabel
    Left = 16
    Top = 51
    Width = 32
    Height = 13
    Caption = 'Bitrate'
  end
  object LAusgabe: TLabel
    Left = 16
    Top = 109
    Width = 42
    Height = 13
    Caption = 'Ausgabe'
  end
  object LKonvertierung: TLabel
    Left = 168
    Top = 51
    Width = 68
    Height = 13
    Caption = 'Konvertierung'
  end
  object BOeffnen: TButton
    Left = 167
    Top = 24
    Width = 113
    Height = 21
    Caption = 'Datei ausw'#228'hlen'
    TabOrder = 0
    OnClick = BOeffnenClick
  end
  object EPfad: TEdit
    Left = 16
    Top = 24
    Width = 145
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object CBBitrate: TComboBox
    Left = 16
    Top = 70
    Width = 73
    Height = 21
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 2
    Text = '128'
    Items.Strings = (
      '64'
      '128'
      '160'
      '192')
  end
  object BStart: TButton
    Left = 167
    Top = 70
    Width = 50
    Height = 25
    Caption = 'start'
    TabOrder = 3
    OnClick = BStartClick
  end
  object Memo1: TMemo
    Left = 16
    Top = 128
    Width = 377
    Height = 137
    TabOrder = 4
  end
  object Bstop: TButton
    Left = 232
    Top = 70
    Width = 48
    Height = 25
    Caption = 'stop'
    Enabled = False
    TabOrder = 5
    OnClick = BstopClick
  end
  object DOeffnen: TOpenDialog
    Filter = '*.mp2;*.mp3;*.wav|*.mp2;*.mp3;*.wav'
    Left = 368
    Top = 96
  end
  object MainMenu1: TMainMenu
    Left = 368
    Top = 56
    object datei1: TMenuItem
      Caption = 'Datei'
      object beenden1: TMenuItem
        Caption = 'ausw'#228'hlen'
        OnClick = beenden1Click
      end
      object beenden2: TMenuItem
        Caption = 'beenden'
        OnClick = beenden2Click
      end
    end
    object Mstart: TMenuItem
      Caption = 'start'
      OnClick = MstartClick
    end
    object Mstop: TMenuItem
      Caption = 'stop'
      OnClick = MstopClick
    end
    object info2: TMenuItem
      Caption = 'info'
      OnClick = info2Click
    end
  end
end
