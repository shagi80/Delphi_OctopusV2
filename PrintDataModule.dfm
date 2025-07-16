object dmPrint: TdmPrint
  OldCreateOrder = False
  Height = 123
  Width = 515
  object frxReport: TfrxReport
    Version = '4.15'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Maximized = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40621.537163900500000000
    ReportOptions.LastChange = 45854.712244606480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 16
    Top = 24
    Datasets = <
      item
        DataSet = frxDataSetDetail
        DataSetName = 'frxDataSetDetail'
      end
      item
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
      end
      item
        DataSet = frxDataSetSubDetail
        DataSetName = 'frxDataSetSubdetail'
      end>
    Variables = <
      item
        Name = ' catBarCode'
        Value = Null
      end
      item
        Name = 'valBarCode'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 190.000000000000000000
      ColumnPositions.Strings = (
        '0')
      object ReportTitle1: TfrxReportTitle
        Height = 56.692950000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo14: TfrxMemoView
          Align = baBottom
          Top = 37.795300000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[FileName]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 71.811070000000000000
        Top = 136.063080000000000000
        Width = 718.110700000000000000
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
        RowCount = 0
        Stretched = True
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 11.338590000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetMaster
          DataSetName = 'frxDataSetMaster'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[frxDataSetMaster."ContainerTitle"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Align = baWidth
          Top = 56.692950000000000000
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
      object DetailData1: TfrxDetailData
        Height = 60.472480000000000000
        Top = 230.551330000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        DataSet = frxDataSetDetail
        DataSetName = 'frxDataSetDetail'
        KeepChild = True
        RowCount = 0
        Stretched = True
        object mBoxCode: TfrxMemoView
          Left = 298.582870000000000000
          Width = 283.464383860000000000
          Height = 37.795300000000000000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          GapX = 5.000000000000000000
          HAlign = haCenter
          HideZeros = True
          Memo.UTF8 = (
            '[frxDataSetDetail."LabelBoxCode"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          Left = 650.079160000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetDetail."OneBoxGross"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 582.047620000000000000
          Top = 18.897650000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetDetail."OneBoxNet"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 650.079160000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'Gross, kg')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 582.047620000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'Net, kg')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 582.047620000000000000
          Top = 37.795300000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'ver 2.0')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 298.582870000000000000
          Top = 37.795300000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."ContainerTitle"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Width = 264.567100000000000000
          Height = 56.692950000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 264.567100000000000000
          Top = 37.795300000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'PI')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 264.567100000000000000
          Width = 34.015770000000000000
          Height = 37.795300000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'CRT')
          ParentFont = False
        end
        object BarCode1: TfrxBarCodeView
          Left = 10.842610000000000000
          Top = 7.559060000000000000
          Width = 129.000000000000000000
          Height = 37.795275590000000000
          ShowHint = False
          BarType = bcCode39
          DataField = 'valBarCode'
          DataSet = frxDataSetDetail
          DataSetName = 'frxDataSetDetail'
          Expression = '[frxDataSetDetail."valBarCode"]'
          Rotation = 0
          ShowText = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
      end
      object Memo12: TfrxMemoView
        Align = baWidth
        Top = 15.118120000000000000
        Width = 718.110700000000000000
        Height = 18.897650000000000000
        ShowHint = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HAlign = haCenter
        Memo.UTF8 = (
          '[ReportTitle]')
        ParentFont = False
      end
      object SubdetailData1: TfrxSubdetailData
        Height = 64.252010000000000000
        Top = 313.700990000000000000
        Width = 718.110700000000000000
        AllowSplit = True
        DataSet = frxDataSetSubDetail
        DataSetName = 'frxDataSetSubdetail'
        RowCount = 0
        Stretched = True
        object Memo2: TfrxMemoView
          Left = 109.606370000000000000
          Width = 438.425480000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDataSetSubDetail."RusTitle"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 548.031850000000000000
          Top = 45.354360000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetSubDetail."Unit"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 548.031850000000000000
          Top = 18.897650000000000000
          Width = 86.929190000000000000
          Height = 26.456710000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetSubDetail."LoadCount"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo22: TfrxMemoView
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Memo.UTF8 = (
            '[frxDataSetSubDetail."Code"]')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Top = 18.897650000000000000
          Width = 109.606370000000000000
          Height = 45.354360000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetSubDetail."BOM"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 548.031850000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'QTY')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 634.961040000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            'NET')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 634.961040000000000000
          Top = 18.897650000000000000
          Width = 83.149660000000000000
          Height = 26.456710000000000000
          ShowHint = False
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetSubDetail."Net"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo11: TfrxMemoView
          Left = 634.961040000000000000
          Top = 45.354360000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'kg')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 109.606370000000000000
          Top = 18.897650000000000000
          Width = 438.425480000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[frxDataSetSubDetail."EngTitle"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 109.606370000000000000
          Top = 37.795300000000000000
          Width = 438.425480000000000000
          Height = 26.456710000000000000
          ShowHint = False
          StretchMode = smActualHeight
          DataSet = frxDataSetSubDetail
          DataSetName = 'frxDataSetSubdetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetSubDetail."ChineTitle"]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        Height = 26.456710000000000000
        Top = 400.630180000000000000
        Width = 718.110700000000000000
        object Line1: TfrxLineView
          Align = baWidth
          Top = 11.338590000000000000
          Width = 718.110700000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDataSetMaster: TfrxUserDataSet
    RangeEnd = reCount
    UserName = 'frxDataSetMaster'
    Left = 56
    Top = 24
  end
  object frxDataSetDetail: TfrxUserDataSet
    RangeEnd = reCount
    UserName = 'frxDataSetDetail'
    Left = 88
    Top = 24
  end
  object frxDataSetSubDetail: TfrxUserDataSet
    RangeEnd = reCount
    UserName = 'frxDataSetSubdetail'
    Left = 120
    Top = 24
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    ExportStyles = False
    OpenExcelAfterExport = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = False
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 232
    Top = 24
  end
  object frxODSExport1: TfrxODSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    ExportStyles = False
    OpenAfterExport = True
    Background = True
    Creator = 'FastReport'
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 296
    Top = 24
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = True
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 328
    Top = 24
  end
  object frxTXTExport1: TfrxTXTExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ScaleWidth = 1.000000000000000000
    ScaleHeight = 1.000000000000000000
    Borders = False
    Pseudogrpahic = False
    PageBreaks = True
    OEMCodepage = False
    EmptyLines = False
    LeadSpaces = False
    PrintAfter = False
    PrinterDialog = True
    UseSavedProps = True
    Left = 360
    Top = 24
  end
  object frxODTExport1: TfrxODTExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    OpenAfterExport = True
    Background = True
    Creator = 'FastReport'
    Language = 'en'
    SuppressPageHeadersFooters = False
    Left = 264
    Top = 24
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 160
    Top = 24
  end
end
