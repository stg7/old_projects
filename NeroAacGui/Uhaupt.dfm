object FNeroAacGui: TFNeroAacGui
  Left = 0
  Top = 0
  Caption = 'FNeroAacGui'
  ClientHeight = 348
  ClientWidth = 432
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
  object LBFiles: TListBox
    Left = 8
    Top = 64
    Width = 193
    Height = 265
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnKeyDown = LBFilesKeyDown
  end
  object BAdd: TButton
    Left = 8
    Top = 33
    Width = 75
    Height = 25
    Caption = 'hinzuf'#252'gen'
    TabOrder = 1
    OnClick = BAddClick
  end
  object bstart: TButton
    Left = 216
    Top = 127
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 2
    OnClick = bstartClick
  end
  object Boptionen: TButton
    Left = 126
    Top = 33
    Width = 75
    Height = 25
    Caption = 'optionen'
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 216
    Top = 63
    Width = 193
    Height = 58
    Lines.Strings = (
      ''
      ''
      '')
    TabOrder = 4
  end
  object bstop: TButton
    Left = 334
    Top = 127
    Width = 75
    Height = 25
    Caption = 'stop'
    Enabled = False
    TabOrder = 5
    OnClick = bstopClick
  end
  object binfo: TButton
    Left = 334
    Top = 304
    Width = 75
    Height = 25
    Caption = 'info'
    TabOrder = 6
    OnClick = binfoClick
  end
  object oeffnen: TOpenDialog
    Filter = '*.wav|*.wav'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Dateien w'#228'hlen'
    Left = 216
    Top = 32
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 248
    Top = 32
  end
end
