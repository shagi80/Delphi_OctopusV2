object frmSettings: TfrmSettings
  Tag = 53
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 437
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcSettings: TPageControl
    Tag = 82
    Left = 0
    Top = 0
    Width = 391
    Height = 381
    ActivePage = tsPrice
    Align = alClient
    TabOrder = 0
    object tsMain: TTabSheet
      Tag = 82
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077
      object Label1: TLabel
        Tag = 84
        Left = 24
        Top = 56
        Width = 19
        Height = 13
        Caption = #1042#1080#1076
      end
      object Label2: TLabel
        Tag = 83
        Left = 24
        Top = 24
        Width = 26
        Height = 13
        Caption = #1071#1079#1099#1082
      end
      object Label3: TLabel
        Tag = 85
        Left = 24
        Top = 88
        Width = 76
        Height = 13
        Caption = #1055#1088#1072#1074#1072' '#1076#1086#1089#1090#1091#1087#1072
      end
      object btnUpdateAccess: TSpeedButton
        Left = 322
        Top = 84
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
          33333333333F8888883F33330000324334222222443333388F3833333388F333
          000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
          F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
          223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
          3338888300003AAAAAAA33333333333888888833333333330000333333333333
          333333333333333333FFFFFF000033333333333344444433FFFF333333888888
          00003A444333333A22222438888F333338F3333800003A2243333333A2222438
          F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
          22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
          33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
          3333333333338888883333330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnUpdateAccessClick
      end
      object Label14: TLabel
        Tag = 151
        Left = 24
        Top = 226
        Width = 108
        Height = 13
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074' '#1079#1072#1082#1072#1079#1077
      end
      object Label15: TLabel
        Tag = 153
        Left = 24
        Top = 250
        Width = 209
        Height = 13
        Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1074#1077#1089' '#1082#1086#1088#1086#1073#1082#1080' '#1087#1088#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1080
      end
      object Label16: TLabel
        Tag = 160
        Left = 24
        Top = 274
        Width = 205
        Height = 13
        Caption = #1055#1086#1076#1089#1074#1077#1095#1080#1074#1072#1090#1100' '#1082#1086#1088#1086#1073#1082#1080' '#1089' '#1085#1091#1083#1077#1074#1099#1084' '#1074#1077#1089#1086#1084
      end
      object Label17: TLabel
        Tag = 176
        Left = 24
        Top = 299
        Width = 141
        Height = 13
        Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1074#1077#1089' '#1091#1087#1072#1082#1086#1074#1082#1080
      end
      object cbView: TComboBox
        Left = 136
        Top = 53
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'cbView'
      end
      object cbLanguage: TComboBox
        Left = 136
        Top = 21
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'cbLanguage'
      end
      object edAccesPassword: TEdit
        Left = 136
        Top = 85
        Width = 180
        Height = 21
        TabOrder = 2
        Text = 'edAccesPassword'
      end
      object cbAccesSettings: TCheckListBox
        Left = 24
        Top = 112
        Width = 321
        Height = 97
        ItemHeight = 13
        TabOrder = 3
      end
      object cbShowCountInOrder: TComboBox
        Left = 200
        Top = 223
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = 'cbShowCountInOrder'
      end
      object cbFixPackBoxWeight: TCheckBox
        Left = 306
        Top = 250
        Width = 39
        Height = 17
        Alignment = taLeftJustify
        TabOrder = 5
      end
      object cbMarkedZerousPack: TCheckBox
        Left = 320
        Top = 273
        Width = 25
        Height = 17
        Alignment = taLeftJustify
        TabOrder = 6
      end
      object edMinPackWeight: TEdit
        Left = 264
        Top = 296
        Width = 81
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 7
        Text = 'edMinPackWeight'
        OnKeyPress = edFloatKeyPress
      end
    end
    object tsRound: TTabSheet
      Tag = 86
      Caption = #1054#1082#1088#1091#1075#1083#1077#1085#1080#1077
      ImageIndex = 1
      object Label4: TLabel
        Tag = 90
        Left = 38
        Top = 112
        Width = 76
        Height = 13
        Caption = #1090#1086#1095#1085#1086#1089#1090#1100' '#1094#1077#1085#1099
      end
      object Label5: TLabel
        Tag = 89
        Left = 38
        Top = 80
        Width = 87
        Height = 13
        Caption = #1090#1086#1095#1085#1086#1089#1090#1100' '#1086#1073#1098#1077#1084#1072
      end
      object Label6: TLabel
        Tag = 88
        Left = 38
        Top = 48
        Width = 73
        Height = 13
        Caption = #1090#1086#1095#1085#1086#1089#1090#1100' '#1074#1077#1089#1072
      end
      object Label7: TLabel
        Tag = 87
        Left = 24
        Top = 18
        Width = 222
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1072#1085#1095#1072#1097#1080#1093' '#1094#1080#1092#1088' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1103#1090#1086#1081':'
      end
      object Label8: TLabel
        Tag = 91
        Left = 24
        Top = 144
        Width = 185
        Height = 13
        Caption = #1054#1082#1088#1091#1075#1083#1077#1085#1080#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1087#1088#1080' '#1079#1072#1082#1072#1079#1077':'
      end
      object lbWeightAccuracy: TLabel
        Left = 277
        Top = 48
        Width = 76
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lbWeightAccuracy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbVolumeAccuracy: TLabel
        Left = 277
        Top = 80
        Width = 76
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Label9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbPriceAccuracy: TLabel
        Left = 277
        Top = 112
        Width = 76
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Label9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnChangeAccuracyFile: TSpeedButton
        Left = 330
        Top = 162
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = btnChangeAccuracyFileClick
      end
      object lbCantChangeAccuracy: TLabel
        Tag = 92
        Left = 24
        Top = 328
        Width = 274
        Height = 13
        Caption = #1042#1099' '#1085#1077' '#1084#1086#1078#1077#1090#1077' '#1080#1079#1084#1077#1085#1103#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1085#1072' '#1101#1090#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1077' !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edPriceAccuracy: TEdit
        Left = 232
        Top = 109
        Width = 39
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        Text = '1'
        OnChange = UpdateAccuracyExample
        OnKeyPress = edIntegerKeyPress
      end
      object edVolumeAccuracy: TEdit
        Left = 232
        Top = 77
        Width = 39
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
        Text = '1'
        OnChange = UpdateAccuracyExample
        OnKeyPress = edIntegerKeyPress
      end
      object edWeightAccuracy: TEdit
        Left = 232
        Top = 45
        Width = 39
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 2
        Text = '1'
        OnChange = UpdateAccuracyExample
        OnKeyPress = edIntegerKeyPress
      end
      object edAccuracyFile: TEdit
        Left = 24
        Top = 163
        Width = 305
        Height = 21
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 3
        Text = 'edAccuracyFile'
      end
      object vleAccuracy: TValueListEditor
        Left = 24
        Top = 190
        Width = 329
        Height = 126
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
        TabOrder = 4
        TitleCaptions.Strings = (
          'Code'
          'Factor')
        ColWidths = (
          150
          173)
      end
    end
    object tsPrice: TTabSheet
      Tag = 134
      Caption = #1062#1077#1085#1099
      ImageIndex = 2
      object Label9: TLabel
        Tag = 135
        Left = 24
        Top = 18
        Width = 198
        Height = 13
        Caption = #1055#1088#1072#1074#1080#1083#1072' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1094#1077#1085' '#1074' '#1080#1085#1074#1086#1081#1089#1077':'
      end
      object Label10: TLabel
        Tag = 136
        Left = 38
        Top = 48
        Width = 122
        Height = 13
        Caption = #1094#1077#1085#1072' FOB '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      end
      object Label11: TLabel
        Tag = 137
        Left = 38
        Top = 80
        Width = 140
        Height = 13
        Caption = #1089#1095#1080#1090#1072#1090#1100' CFR '#1085#1072' '#1086#1089#1085#1086#1074#1077' FOB'
      end
      object Label12: TLabel
        Tag = 138
        Left = 38
        Top = 112
        Width = 125
        Height = 13
        Caption = #1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1087#1077#1088#1077#1089#1095#1077#1090#1072
      end
      object Label13: TLabel
        Tag = 139
        Left = 24
        Top = 144
        Width = 169
        Height = 13
        Caption = #1041#1072#1079#1080#1089' '#1076#1083#1103' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1089#1091#1084#1084#1099':'
      end
      object btnChangePriceFile: TSpeedButton
        Left = 330
        Top = 162
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = btnChangePriceFileClick
      end
      object lbCantChangePrice: TLabel
        Tag = 92
        Left = 24
        Top = 328
        Width = 274
        Height = 13
        Caption = #1042#1099' '#1085#1077' '#1084#1086#1078#1077#1090#1077' '#1080#1079#1084#1077#1085#1103#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1085#1072' '#1101#1090#1086#1081' '#1089#1090#1088#1072#1085#1080#1094#1077' !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edDefFOB: TEdit
        Left = 272
        Top = 45
        Width = 81
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        Text = 'edWeightAccuracy'
        OnChange = UpdateAccuracyExample
        OnKeyPress = edFloatKeyPress
      end
      object edCFRCoef: TEdit
        Left = 272
        Top = 109
        Width = 81
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
        Text = 'edPriceAccuracy'
        OnChange = UpdateAccuracyExample
        OnKeyPress = edFloatKeyPress
      end
      object edPriceFile: TEdit
        Left = 24
        Top = 163
        Width = 305
        Height = 21
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 2
        Text = 'edAccuracyFile'
      end
      object vlePriceSettings: TValueListEditor
        Left = 24
        Top = 190
        Width = 329
        Height = 126
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goAlwaysShowEditor, goThumbTracking]
        TabOrder = 3
        ColWidths = (
          150
          173)
      end
      object cbFOBForCFR: TCheckBox
        Left = 272
        Top = 80
        Width = 20
        Height = 17
        TabOrder = 4
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 381
    Width = 391
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 119
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
      Left = 200
      Top = 16
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
