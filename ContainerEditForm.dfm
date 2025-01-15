object frmContainerEdit: TfrmContainerEdit
  Tag = 94
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1085#1090#1077#1081#1085#1077#1088#1072
  ClientHeight = 209
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnButtons: TPanel
    Left = 0
    Top = 153
    Width = 314
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOk: TBitBtn
      Left = 71
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Tag = 93
      Left = 152
      Top = 16
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 314
    Height = 153
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Tag = 95
      Left = 24
      Top = 22
      Width = 112
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1082#1086#1085#1090#1077#1081#1085#1077#1088#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Tag = 96
      Left = 24
      Top = 71
      Width = 75
      Height = 13
      Caption = #1052#1082#1082#1089' '#1074#1077#1089', '#1082#1075':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Tag = 97
      Left = 24
      Top = 98
      Width = 95
      Height = 13
      Caption = #1052#1072#1082#1089' '#1086#1073#1098#1105#1084', '#1084'3:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edVolume: TEdit
      Left = 192
      Top = 95
      Width = 97
      Height = 21
      TabOrder = 0
      Text = 'edVolume'
      OnKeyPress = edGrossKeyPress
    end
    object edGross: TEdit
      Left = 192
      Top = 68
      Width = 97
      Height = 21
      TabOrder = 1
      Text = 'edGross'
      OnKeyPress = edGrossKeyPress
    end
    object edTitle: TEdit
      Left = 24
      Top = 41
      Width = 265
      Height = 21
      TabOrder = 2
      Text = 'edTitle'
    end
  end
end
