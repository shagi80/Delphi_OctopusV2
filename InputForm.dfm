object frmInput: TfrmInput
  Tag = 98
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
  ClientHeight = 206
  ClientWidth = 295
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
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 295
    Height = 150
    Align = alTop
    BorderWidth = 20
    TabOrder = 0
    object lbText: TLabel
      Left = 21
      Top = 21
      Width = 253
      Height = 13
      Align = alTop
      Caption = 'lbText'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 36
    end
    object lbHint: TLabel
      Left = 21
      Top = 116
      Width = 253
      Height = 13
      Align = alBottom
      Caption = 'lbHint'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 27
    end
    object pnString: TPanel
      AlignWithMargins = True
      Left = 24
      Top = 44
      Width = 247
      Height = 21
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnString'
      TabOrder = 0
      object btnClearString: TSpeedButton
        Left = 224
        Top = 0
        Width = 23
        Height = 21
        Align = alRight
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          EFEFEF4B4B4BAAAAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAAAAA4B4B
          4BEFEFEFFFFFFFFFFFFFFFFFFFFFFFFF4B4B4B000000040404A9A9A9FFFFFFFF
          FFFFFFFFFFFFFFFFA9A9A90404040000004C4C4CFFFFFFFFFFFFFFFFFFFFFFFF
          AAAAAA040404000000040404A9A9A9FFFFFFFFFFFFA9A9A90404040000000404
          04AAAAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABABAB040404000000030303A5
          A5A5ABABAB050505000000030303A4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFA9A9A9040404000000040404040404000000040404A9A9A9FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFABABAB04040400
          0000000000030303A4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFABABAB050505000000000000030303A5A5A5FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9A904040400000004
          0404040404000000040404A9A9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFABABAB050505000000030303A4A4A4ABABAB040404000000030303A5A5
          A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAAAAA040404000000040404A9A9A9FF
          FFFFFFFFFFA9A9A9040404000000040404AAAAAAFFFFFFFFFFFFFFFFFFFFFFFF
          4B4B4B000000040404A9A9A9FFFFFFFFFFFFFFFFFFFFFFFFA9A9A90404040000
          004C4C4CFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF4B4B4BAAAAAAFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFAAAAAA4B4B4BEFEFEFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = btnClearStringClick
        ExplicitLeft = 136
        ExplicitTop = 8
        ExplicitHeight = 22
      end
      object edString: TEdit
        Left = 0
        Top = 0
        Width = 224
        Height = 21
        Align = alClient
        TabOrder = 0
        Text = 'edString'
        OnKeyPress = edStringKeyPress
      end
    end
    object pnInteger: TPanel
      AlignWithMargins = True
      Left = 24
      Top = 80
      Width = 247
      Height = 21
      Margins.Top = 5
      Margins.Bottom = 10
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object edInteger: TEdit
        AlignWithMargins = True
        Left = 70
        Top = 0
        Width = 70
        Height = 21
        Margins.Left = 70
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        TabOrder = 0
        Text = '0'
      end
      object UpDown1: TUpDown
        Left = 140
        Top = 0
        Width = 17
        Height = 21
        Associate = edInteger
        Max = 10000
        Increment = 100
        TabOrder = 1
        Thousands = False
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 150
    Width = 295
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 71
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      TabOrder = 0
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
end
