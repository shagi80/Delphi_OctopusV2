object frmPriceChangeSetiings: TfrmPriceChangeSetiings
  Tag = 177
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Changing the total cost in an invoice'
  ClientHeight = 353
  ClientWidth = 518
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
  object pnValue: TPanel
    Left = 0
    Top = 0
    Width = 518
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Tag = 178
      Left = 16
      Top = 22
      Width = 137
      Height = 13
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1090#1088#1077#1073#1091#1077#1084#1091#1102' '#1089#1091#1084#1084#1091
      Layout = tlCenter
    end
    object edNewCost: TEdit
      Left = 376
      Top = 19
      Width = 113
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      Text = 'edNewCost'
      OnKeyPress = edNewCostKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 65
    Width = 518
    Height = 288
    Align = alClient
    BorderWidth = 10
    TabOrder = 1
    object Label8: TLabel
      Tag = 170
      AlignWithMargins = True
      Left = 14
      Top = 254
      Width = 490
      Height = 13
      Margins.Top = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = 'Label8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 31
    end
    object pnByAll: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 14
      Width = 487
      Height = 70
      AutoSize = True
      BorderWidth = 5
      TabOrder = 0
      OnClick = ModePanelClick
      object Label2: TLabel
        Tag = 42
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 475
        Height = 13
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 5
        Align = alTop
        Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1088#1072#1079#1085#1080#1094#1091' '#1087#1086' '#1074#1089#1077#1084' '#1076#1077#1090#1072#1083#1103#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = ModePanelClick
        ExplicitWidth = 238
      end
      object Label3: TLabel
        Tag = 179
        Left = 6
        Top = 24
        Width = 475
        Height = 40
        Align = alTop
        AutoSize = False
        Caption = 
          #1056#1072#1079#1085#1080#1094#1072' '#1084#1077#1078#1076#1091' '#1090#1077#1082#1091#1097#1077#1081' '#1080' '#1090#1088#1077#1073#1091#1077#1084#1086#1081' '#1089#1091#1084#1084#1086#1081' '#1073#1091#1076#1090' '#1088#1072#1089#1087#1088#1076#1083#1077#1077#1085#1072' '#1084#1077#1078#1076#1091' ' +
          #1074#1089#1077#1084#1080' '#1076#1077#1090#1072#1083#1103#1084#1080' '#1074' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080' '#1086#1090' '#1080#1079' '#1087#1077#1088#1074#1086#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1089#1090#1086#1080#1084#1086#1089#1090#1080
        WordWrap = True
        OnClick = ModePanelClick
      end
    end
    object pnBySelected: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 90
      Width = 487
      Height = 70
      AutoSize = True
      BorderWidth = 5
      TabOrder = 1
      OnClick = ModePanelClick
      object lbCaptionByPackMinWeight: TLabel
        Tag = 43
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 475
        Height = 13
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 5
        Align = alTop
        Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1088#1072#1079#1085#1080#1094#1091' '#1087#1086' '#1086#1090#1084#1077#1095#1077#1085#1085#1099#1084' '#1076#1077#1090#1072#1083#1103#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = ModePanelClick
        ExplicitWidth = 285
      end
      object Label6: TLabel
        Tag = 180
        Left = 6
        Top = 24
        Width = 475
        Height = 40
        Align = alTop
        AutoSize = False
        Caption = 
          #1056#1072#1079#1085#1080#1094#1072' '#1084#1077#1078#1076#1091' '#1090#1077#1082#1091#1097#1077#1081' '#1080' '#1090#1088#1077#1073#1091#1077#1084#1086#1081' '#1089#1091#1084#1084#1086#1081' '#1073#1091#1076#1077#1090' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1072' '#1084#1077#1078#1076 +
          #1091' '#1074#1099#1073#1088#1072#1085#1085#1099#1084#1080' '#1076#1077#1090#1072#1083#1103#1084#1080' '#1074' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1080' '#1086#1090' '#1080#1093' '#1087#1077#1088#1074#1086#1085#1072#1095#1072#1083#1100#1085#1086#1081' '#1089#1090#1086#1080#1084#1086#1089 +
          #1090#1080
        WordWrap = True
        OnClick = ModePanelClick
      end
    end
    object pnBySettings: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 166
      Width = 487
      Height = 70
      AutoSize = True
      BorderWidth = 5
      TabOrder = 2
      OnClick = ModePanelClick
      object Label4: TLabel
        Tag = 44
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 475
        Height = 13
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 5
        Align = alTop
        Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1088#1072#1079#1085#1080#1094#1091' '#1074' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1080' '#1089' '#1085#1072#1089#1090#1088#1086#1081#1082#1072#1084#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = ModePanelClick
        ExplicitWidth = 315
      end
      object Label5: TLabel
        Tag = 181
        Left = 6
        Top = 24
        Width = 475
        Height = 40
        Align = alTop
        AutoSize = False
        Caption = 
          #1056#1072#1079#1085#1080#1094#1072' '#1084#1077#1078#1076#1091' '#1090#1077#1082#1091#1097#1077#1081' '#1080' '#1090#1088#1077#1073#1091#1077#1084#1086#1081' '#1089#1091#1084#1084#1086#1081' '#1073#1091#1076#1077#1090' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1072' '#1084#1077#1078#1076 +
          #1091' '#1076#1077#1090#1072#1083#1103#1084#1080', '#1091#1082#1072#1079#1072#1085#1085#1099#1084#1080' '#1074' '#1085#1072#1089#1090#1088#1086#1081#1082#1072#1093' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
        WordWrap = True
        OnClick = ModePanelClick
      end
    end
  end
end
