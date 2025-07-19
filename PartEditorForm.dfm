object frmPartEditor: TfrmPartEditor
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'frmPartEditor'
  ClientHeight = 531
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnMain: TPanel
    Left = 0
    Top = 0
    Width = 812
    Height = 476
    Align = alClient
    TabOrder = 0
    object pnProperty: TPanel
      Left = 1
      Top = 1
      Width = 810
      Height = 474
      Align = alClient
      TabOrder = 0
      object Label1: TLabel
        Tag = 99
        AlignWithMargins = True
        Left = 24
        Top = 10
        Width = 54
        Height = 13
        Margins.Left = 10
        Caption = #1057#1074#1086#1081#1089#1090#1074#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbCode: TLabel
        Tag = 100
        Left = 24
        Top = 40
        Width = 57
        Height = 13
        Caption = #1050#1086#1076' '#1087#1086' 1'#1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbFullName: TLabel
        Tag = 102
        Left = 23
        Top = 94
        Width = 115
        Height = 13
        Caption = #1055#1086#1083#1085' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbEngName: TLabel
        Tag = 103
        Left = 24
        Top = 142
        Width = 114
        Height = 13
        Caption = #1040#1085#1075#1083' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbSuppName: TLabel
        Tag = 104
        Left = 24
        Top = 190
        Width = 102
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbVolume: TLabel
        Tag = 109
        Left = 23
        Top = 349
        Width = 52
        Height = 13
        Caption = #1054#1073#1098#1077#1084', '#1084'3'
      end
      object lbNet: TLabel
        Tag = 108
        Left = 24
        Top = 322
        Width = 68
        Height = 13
        Caption = #1042#1077#1089' '#1085#1077#1090#1090#1086', '#1082#1075
      end
      object lbUnit: TLabel
        Tag = 107
        Left = 23
        Top = 296
        Width = 69
        Height = 13
        Caption = #1045#1076' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      end
      object lbCFRPrice: TLabel
        Tag = 114
        Left = 491
        Top = 376
        Width = 47
        Height = 13
        Caption = 'CFR '#1094#1077#1085#1072
      end
      object lbFOBPrice: TLabel
        Tag = 113
        Left = 491
        Top = 349
        Width = 47
        Height = 13
        Caption = 'FOB '#1094#1077#1085#1072
      end
      object lbBOM: TLabel
        Tag = 105
        Left = 23
        Top = 241
        Width = 22
        Height = 13
        Caption = 'BOM'
      end
      object lbPrice: TLabel
        Tag = 112
        Left = 491
        Top = 322
        Width = 91
        Height = 13
        Caption = #1062#1077#1085#1072' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      end
      object lbTNVED: TLabel
        Tag = 106
        Left = 23
        Top = 268
        Width = 57
        Height = 13
        Caption = #1050#1086#1076' '#1058#1053#1042#1069#1044
      end
      object lbName: TLabel
        Tag = 101
        Left = 24
        Top = 67
        Width = 84
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbPack: TLabel
        Tag = 110
        Left = 23
        Top = 376
        Width = 70
        Height = 13
        Caption = #1042#1080#1076' '#1091#1087#1072#1082#1086#1074#1082#1080
      end
      object lbPackCount: TLabel
        Tag = 111
        Left = 24
        Top = 403
        Width = 95
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086' '#1074' '#1091#1087#1072#1082#1086#1074#1082#1077
      end
      object Label2: TLabel
        Tag = 19
        AlignWithMargins = True
        Left = 575
        Top = 10
        Width = 44
        Height = 13
        Caption = #1047#1072#1082#1072#1079#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Tag = 191
        Left = 491
        Top = 296
        Width = 57
        Height = 13
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      end
      object Label4: TLabel
        Tag = 192
        Left = 24
        Top = 430
        Width = 74
        Height = 13
        Caption = #1042#1077#1089' '#1073#1088#1091#1090#1090#1086', '#1082#1075
      end
      object Label5: TLabel
        Tag = 193
        Left = 491
        Top = 268
        Width = 135
        Height = 13
        Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100' '#1080' '#1094#1077#1085#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edCode: TEdit
        Left = 168
        Top = 37
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'edCode'
      end
      object edVolume: TEdit
        Left = 168
        Top = 346
        Width = 80
        Height = 21
        TabOrder = 1
        Text = 'edVolume'
        OnKeyPress = GridKeyPress
      end
      object cbUnit: TComboBox
        Left = 167
        Top = 292
        Width = 80
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
      object edBOM: TEdit
        Left = 167
        Top = 238
        Width = 255
        Height = 21
        TabOrder = 3
        Text = 'edBOM'
      end
      object edNet: TEdit
        Left = 168
        Top = 319
        Width = 80
        Height = 21
        TabOrder = 4
        Text = 'edNet'
        OnKeyPress = GridKeyPress
      end
      object edFOBPrice: TEdit
        Left = 635
        Top = 346
        Width = 80
        Height = 21
        TabOrder = 5
        Text = 'edFOBPrice'
        OnKeyPress = GridKeyPress
      end
      object edPrice: TEdit
        Left = 635
        Top = 319
        Width = 80
        Height = 21
        TabOrder = 6
        Text = 'edPrice'
        OnKeyPress = GridKeyPress
      end
      object edTNVED: TEdit
        Left = 167
        Top = 265
        Width = 255
        Height = 21
        TabOrder = 7
        Text = 'edTNVED'
      end
      object edName: TEdit
        Left = 168
        Top = 64
        Width = 387
        Height = 21
        TabOrder = 8
        Text = 'edName'
      end
      object edFullName: TTntMemo
        Left = 168
        Top = 91
        Width = 387
        Height = 42
        Lines.Strings = (
          'edFullName')
        TabOrder = 9
      end
      object edEngName: TTntMemo
        Left = 168
        Top = 139
        Width = 387
        Height = 42
        Lines.Strings = (
          'TntMemo1')
        TabOrder = 10
      end
      object edSuppName: TTntMemo
        Left = 168
        Top = 187
        Width = 387
        Height = 42
        Lines.Strings = (
          'TntMemo1')
        TabOrder = 11
      end
      object edCFRPrice: TEdit
        Left = 635
        Top = 373
        Width = 80
        Height = 21
        TabOrder = 12
        Text = 'Edit5'
        OnKeyPress = GridKeyPress
      end
      object edPack: TComboBox
        Left = 167
        Top = 373
        Width = 255
        Height = 21
        ItemHeight = 13
        TabOrder = 13
        Text = 'edPack'
      end
      object edPackCount: TEdit
        Left = 167
        Top = 400
        Width = 81
        Height = 21
        TabOrder = 14
        Text = 'edPackCount'
        OnKeyPress = GridKeyPress
      end
      object grOrders: TOctopusStringGrid
        Left = 575
        Top = 40
        Width = 209
        Height = 189
        ColCount = 2
        DefaultRowHeight = 20
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        TabOrder = 15
        OnDrawCell = GridDrawCell
        OnKeyPress = GridKeyPress
      end
      object edFactory: TEdit
        Left = 635
        Top = 292
        Width = 149
        Height = 21
        TabOrder = 16
        Text = 'edPrice'
        OnKeyPress = GridKeyPress
      end
      object edGross: TEdit
        Left = 167
        Top = 428
        Width = 81
        Height = 21
        TabOrder = 17
        Text = 'edPackCount'
        OnKeyPress = GridKeyPress
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 476
    Width = 812
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 247
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
    object btnCancel: TBitBtn
      Tag = 93
      Left = 328
      Top = 16
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
