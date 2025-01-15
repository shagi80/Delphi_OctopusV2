object frmPartProperty: TfrmPartProperty
  Tag = 60
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = #1044#1077#1090#1072#1083#1100
  ClientHeight = 382
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grPart: TOctopusStringGrid
    Left = 0
    Top = 48
    Width = 321
    Height = 334
    Align = alClient
    ColCount = 2
    FixedCols = 0
    RowCount = 16
    TabOrder = 0
    OnDblClick = grPartDblClick
  end
  object pnTop: TPanel
    AlignWithMargins = True
    Left = 2
    Top = 0
    Width = 316
    Height = 48
    Margins.Left = 2
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 1
    object pnEditTools: TPanel
      Left = 0
      Top = 0
      Width = 316
      Height = 24
      Align = alTop
      Caption = 'pnEditTools'
      TabOrder = 0
      object tbEdit: TToolBar
        Left = 1
        Top = 1
        Width = 236
        Height = 22
        Align = alLeft
        AutoSize = True
        Caption = 'tbEdit'
        TabOrder = 0
        object Label3: TLabel
          Tag = 59
          Left = 0
          Top = 0
          Width = 105
          Height = 22
          Align = alLeft
          AutoSize = False
          Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077':'
          Layout = tlCenter
        end
        object ToolButton1: TToolButton
          Left = 105
          Top = 0
          Width = 8
          Caption = 'ToolButton1'
          ImageIndex = 6
          Style = tbsSeparator
        end
        object btnPartAdd: TToolButton
          Left = 113
          Top = 0
          Caption = 'btnPartAdd'
          ImageIndex = 3
        end
        object btnPartCopy: TToolButton
          Left = 136
          Top = 0
          Caption = 'btnPartCopy'
          ImageIndex = 4
        end
        object btnPartEdit: TToolButton
          Left = 159
          Top = 0
          Caption = 'btnPartEdit'
          ImageIndex = 7
        end
        object btnPartDelete: TToolButton
          Left = 182
          Top = 0
          Caption = 'btnPartDelete'
          ImageIndex = 5
        end
        object ToolButton2: TToolButton
          Left = 205
          Top = 0
          Width = 8
          Caption = 'ToolButton2'
          ImageIndex = 6
          Style = tbsSeparator
        end
        object btnPartListUpdate: TToolButton
          Left = 213
          Top = 0
          Caption = 'btnPartListUpdate'
          ImageIndex = 6
        end
      end
    end
    object pnViewTools: TPanel
      Left = 0
      Top = 24
      Width = 316
      Height = 24
      Align = alTop
      Caption = 'pnViewTools'
      TabOrder = 1
      object tbView: TToolBar
        Left = 1
        Top = 1
        Width = 314
        Height = 29
        Caption = 'tbView'
        TabOrder = 0
        object btnSearchPart: TToolButton
          Left = 0
          Top = 0
          Caption = 'btnSearchPart'
          ImageIndex = 0
        end
      end
    end
  end
end
