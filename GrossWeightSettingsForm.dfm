object frmGrossWeightSettings: TfrmGrossWeightSettings
  Tag = 168
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmGrossWeightSettings'
  ClientHeight = 360
  ClientWidth = 515
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
    Width = 515
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Tag = 169
      Left = 16
      Top = 22
      Width = 137
      Height = 13
      Caption = #1059#1082#1072#1078#1080#1090#1077' '#1090#1088#1077#1073#1091#1077#1084#1091#1102' '#1089#1091#1084#1084#1091
      Layout = tlCenter
    end
    object edNewGross: TEdit
      Left = 376
      Top = 19
      Width = 113
      Height = 21
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 0
      Text = 'edNewGross'
      OnKeyPress = edNewGrossKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 65
    Width = 515
    Height = 295
    Align = alClient
    BorderWidth = 10
    TabOrder = 1
    object Label8: TLabel
      Tag = 170
      AlignWithMargins = True
      Left = 14
      Top = 261
      Width = 487
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
    object pnByPackWeight: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 14
      Width = 487
      Height = 106
      AutoSize = True
      BorderWidth = 5
      TabOrder = 0
      OnClick = pnByPackWeightClick
      object Label2: TLabel
        Tag = 172
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
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pnByPackWeightClick
        ExplicitWidth = 37
      end
      object Label3: TLabel
        Tag = 174
        Left = 6
        Top = 24
        Width = 475
        Height = 50
        Align = alTop
        AutoSize = False
        Caption = 'Label3'
        WordWrap = True
        OnClick = pnByPackWeightClick
      end
      object lbMinForByPackWeight: TLabel
        Tag = 171
        AlignWithMargins = True
        Left = 9
        Top = 77
        Width = 469
        Height = 13
        Margins.Bottom = 10
        Align = alTop
        Alignment = taCenter
        Caption = 'lbMinForByPackWeight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = pnByPackWeightClick
        ExplicitWidth = 108
      end
    end
    object pnByPackMinWeight: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 134
      Width = 487
      Height = 106
      AutoSize = True
      BorderWidth = 5
      TabOrder = 1
      OnClick = pnByPackMinWeightClick
      object lbCaptionByPackMinWeight: TLabel
        Tag = 173
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
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = pnByPackMinWeightClick
        ExplicitWidth = 37
      end
      object Label6: TLabel
        Tag = 175
        Left = 6
        Top = 24
        Width = 475
        Height = 50
        Align = alTop
        AutoSize = False
        Caption = 'Label3'
        WordWrap = True
        OnClick = pnByPackMinWeightClick
      end
      object lbMinForByPackMinWeight: TLabel
        Tag = 171
        AlignWithMargins = True
        Left = 9
        Top = 77
        Width = 469
        Height = 13
        Margins.Bottom = 10
        Align = alTop
        Alignment = taCenter
        Caption = 'Label4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = pnByPackMinWeightClick
        ExplicitWidth = 31
      end
    end
  end
end
