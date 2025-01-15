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
    ReportOptions.LastChange = 45664.775142881950000000
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
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
      end
      item
        DataSet = frxDataSetDetail
        DataSetName = 'frxDataSetDetail'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'OrderTitle'
        Value = Null
      end
      item
        Name = 'PartName'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 18.897650000000000000
        Top = 661.417750000000000000
        Width = 1046.929810000000000000
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
        RowCount = 0
        Stretched = True
        object Memo2: TfrxMemoView
          Left = 298.582870000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetDetail
          DataSetName = 'frxDataSetDetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."RusTitle"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetMaster
          DataSetName = 'frxDataSetMaster'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."BOM"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 113.385900000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."EngTitle"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 548.031850000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetMaster."Unit"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 589.606680000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Count"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 665.197280000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Price"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 740.787880000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."TotalPrice"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 816.378480000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Net"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 891.969080000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Gross"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 967.559680000000000000
          Width = 41.574805590000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."FullBox"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 1009.134510000000000000
          Width = 37.795275590000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."PartBox"]')
          ParentFont = False
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 582.047620000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo1: TfrxMemoView
          Top = 480.000310000000000000
          Width = 113.385900000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'BOM#/ '#1056#1106#1057#1026#1057#8218#1056#1105#1056#1108#1057#1107#1056#187)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo17: TfrxMemoView
          Left = 113.385900000000000000
          Top = 480.000310000000000000
          Width = 434.645950000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            ' NAME / '#1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo16: TfrxMemoView
          Left = 589.606680000000000000
          Top = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#8226#176#1081#8225#1039'/ QUANTITY/ '#1056#1113#1056#1109#1056#187#1056#1105#1057#8225#1056#181#1057#1027#1057#8218#1056#1030#1056#1109)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo18: TfrxMemoView
          Left = 548.031850000000000000
          Top = 480.000310000000000000
          Width = 41.574830000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'MEAS/ '#1056#8226#1056#1169' '#1056#1105#1056#183#1056#1112#1056#181#1057#1026)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo19: TfrxMemoView
          Left = 665.197280000000000000
          Top = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1077#1036#8226#1076#187#183' '#1077#8230#1107' /UNIT'#1074#1026#152'S PRICE,CNY/ '#1056#166#1056#181#1056#1029#1056#176' '#1056#183#1056#176' '#1056#181#1056#1169#1056#1105#1056#1029#1056#1105#1057#8224#1057#1107', CN' +
              'Y')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo20: TfrxMemoView
          Left = 740.787880000000000000
          Top = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#1026#187#1076#187#183' '#1077#8230#1107'/ TOTAL, CNY/ '#1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034', CNY')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo21: TfrxMemoView
          Left = 816.378480000000000000
          Top = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1077#8225#1026#1081#8225#1036' '#1077#8230#172#1078#8211#164'/ NET WEIGHT KG/ '#1056#8217#1056#181#1057#1027' '#1056#1029#1056#181#1057#8218#1057#8218#1056#1109', '#1056#1108#1056#1110)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo22: TfrxMemoView
          Left = 891.969080000000000000
          Top = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 102.047310000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#1031#8250#1081#8225#1036' '#1077#8230#172#1078#8211#164'/ GROSS WEIGHT KG/ '#1056#8217#1056#181#1057#1027' '#1056#177#1057#1026#1057#1107#1057#8218#1057#8218#1056#1109', '#1056#1108#1056#1110)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo23: TfrxMemoView
          Left = 967.559680000000000000
          Top = 555.590910000000000000
          Width = 41.574830000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#166#1056#181#1056#187#1056#176#1057#1039' '#1056#1108#1056#1109#1057#1026#1056#1109#1056#177#1056#1108#1056#176)
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 1009.134510000000000000
          Top = 555.590910000000000000
          Width = 37.795300000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1056#167#1056#176#1057#1027#1057#8218#1057#1034' '#1056#1108#1056#1109#1057#1026#1056#1109#1056#177#1056#1108#1056#1105)
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Top = 102.047310000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[SupplierRusName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Top = 234.330860000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[BuyerEngName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngName]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Top = 22.677180000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngAddr]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierPhone]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Top = 83.149660000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            'EXPORTER)ISSUED BY/'#1056#1115#1056#1118#1056#1119#1056#160#1056#1106#1056#8217#1056#152#1056#1118#1056#8226#1056#8250#1056#172':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Top = 120.944960000000000000
          Width = 529.134200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[SupplierRusAddr]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Top = 151.181200000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            'T/T ROUTE AS FOLLOWS/'#1056#160#1056#8226#1056#1113#1056#8217#1056#152#1056#8212#1056#152#1056#1118#1056#171' '#1056#8221#1056#8250#1056#1031' '#1056#1119#1056#8250#1056#1106#1056#1118#1056#8226#1056#8211#1056#1106':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          Top = 170.078850000000000000
          Width = 529.134200000000000000
          Height = 45.354360000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[SupplierBankDetails], [SupplierBankName]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Top = 215.433210000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            'TO/'#1056#1119#1056#1109#1056#187#1057#1107#1057#8225#1056#176#1057#8218#1056#181#1056#187#1057#1034)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          Top = 253.228510000000000000
          Width = 529.134200000000000000
          Height = 94.488250000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[BuyerEndAddr], [BuyerBankName]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Top = 347.716760000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8 = (
            '[BuyerRusName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          Top = 366.614410000000000000
          Width = 529.134200000000000000
          Height = 75.590600000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8 = (
            '[BuyerRusAddr], [BuyerBankDetails]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 529.134200000000000000
          Top = 83.149660000000000000
          Width = 517.795610000000000000
          Height = 132.283550000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1077#1039#8216'  '#1079#1168#1025' / COMMERCIAL INVOICE'
            #1056#1113#1056#1115#1056#1114#1056#1114#1056#8226#1056#160#1056#167#1056#8226#1056#1038#1056#1113#1056#152#1056#8482' '#1056#152#1056#1116#1056#8217#1056#1115#1056#8482#1056#1038)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Left = 529.134200000000000000
          Top = 215.433210000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1077#1039#8216#1079#1168#1025#1077#1039#183' / Invoice number / '#1056#152#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo43: TfrxMemoView
          Left = 680.315400000000000000
          Top = 215.433210000000000000
          Width = 132.283550000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[InvoiceNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo44: TfrxMemoView
          Left = 812.598950000000000000
          Top = 215.433210000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1077#1039#8216#1079#1168#1025#1077#1039#183' / Invoice number / '#1056#152#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo45: TfrxMemoView
          Left = 963.780150000000000000
          Top = 215.433210000000000000
          Width = 83.149660000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[InvoiceDate]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo41: TfrxMemoView
          Left = 529.134200000000000000
          Top = 245.669450000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1077#1106#8364#1077#1106#1034#1077#1039#183'/ Contract No / '#1056#1113#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo42: TfrxMemoView
          Left = 680.315400000000000000
          Top = 245.669450000000000000
          Width = 132.283550000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[BuyerContrNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo46: TfrxMemoView
          Left = 812.598950000000000000
          Top = 245.669450000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Contract dated / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1108#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218#1056#176':  ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo47: TfrxMemoView
          Left = 963.780150000000000000
          Top = 245.669450000000000000
          Width = 83.149660000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          HAlign = haCenter
          Memo.UTF8 = (
            '[BuyerContrDate]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo48: TfrxMemoView
          Left = 529.134200000000000000
          Top = 275.905690000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Preliminary Invoice / '#1056#1119#1057#1026#1056#181#1056#1169#1056#1030#1056#176#1057#1026#1056#1105#1057#8218' '#1056#1105#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027' '#1074#8222#8211': ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo49: TfrxMemoView
          Left = 680.315400000000000000
          Top = 275.905690000000000000
          Width = 132.283550000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo50: TfrxMemoView
          Left = 812.598950000000000000
          Top = 275.905690000000000000
          Width = 151.181200000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Invoice date / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1105#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027#1056#176':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo51: TfrxMemoView
          Left = 963.780150000000000000
          Top = 275.905690000000000000
          Width = 83.149660000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight]
          HAlign = haCenter
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 529.134200000000000000
          Top = 317.480520000000000000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          Memo.UTF8 = (
            
              #1076#1108#167#1077#1114#176'/Country of origin/ '#1056#1038#1057#8218#1057#1026#1056#176#1056#1029#1056#176' '#1056#1111#1057#1026#1056#1109#1056#1105#1057#1027#1057#8230#1056#1109#1056#182#1056#1169#1056#181#1056#1029#1056#1105#1057 +
              #1039':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 812.598950000000000000
          Top = 317.480520000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierCountry]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo52: TfrxMemoView
          Left = 668.976810000000000000
          Top = 336.378170000000000000
          Width = 377.953000000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              'T/T, Payment by any portions  by Contract (not later 180 days fr' +
              'om arrival)/'#1056#1115#1056#1111#1056#187#1056#176#1057#8218#1056#176' '#1056#187#1057#1035#1056#177#1057#8249#1056#1112#1056#1105' '#1057#8225#1056#176#1057#1027#1057#8218#1057#1039#1056#1112#1056#1105' '#1057#1027#1056#1109#1056#1110#1056#187#1056#176#1057 +
              #1027#1056#1029#1056#1109' '#1056#1108#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218#1056#176', '#1056#173#1056#187#1056#181#1056#1108#1057#8218#1057#1026#1056#1109#1056#1029#1056#1029#1057#8249#1056#8470' '#1056#1111#1056#181#1057#1026#1056#181#1056#1030#1056#1109#1056#1169' ' +
              '('#1056#1029#1056#181' '#1056#1111#1056#1109#1056#183#1056#1169#1056#1029#1056#181#1056#181' 180 '#1056#1169#1056#1029#1056#181#1056#8470' '#1056#1111#1056#1109#1057#1027#1056#187#1056#181' '#1056#1111#1057#1026#1056#1105#1056#177#1057#8249#1057#8218#1056#1105#1057#1039')')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo53: TfrxMemoView
          Left = 529.134200000000000000
          Top = 396.850650000000000000
          Width = 139.842610000000000000
          Height = 45.354360000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'Shipment terms / '#1056#1032#1057#1027#1056#187#1056#1109#1056#1030#1056#1105#1057#1039' '#1056#1111#1056#1109#1057#1027#1057#8218#1056#176#1056#1030#1056#1108#1056#1105':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo54: TfrxMemoView
          Left = 668.976810000000000000
          Top = 396.850650000000000000
          Width = 377.953000000000000000
          Height = 45.354360000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[PortAndBasis]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo13: TfrxMemoView
          Left = 529.134200000000000000
          Top = 306.141930000000000000
          Width = 517.795610000000000000
          Height = 11.338590000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo55: TfrxMemoView
          Left = 529.134200000000000000
          Top = 336.378170000000000000
          Width = 139.842610000000000000
          Height = 60.472480000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8 = (
            'Payment terms:/'
            #1056#1032#1057#1027#1056#187#1056#1109#1056#1030#1056#1105#1057#1039' '#1056#1109#1056#1111#1056#187#1056#176#1057#8218#1057#8249': ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo56: TfrxMemoView
          Top = 442.205010000000000000
          Width = 151.181200000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'Shipping route / '#1056#1114#1056#176#1057#1026#1057#8364#1057#1026#1057#1107#1057#8218' '#1056#1169#1056#1030#1056#1105#1056#182#1056#1105#1056#181#1056#1029#1056#1105#1057#1039' '#1056#1110#1057#1026#1057#1107#1056#183#1056#176':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo57: TfrxMemoView
          Left = 151.181200000000000000
          Top = 442.205010000000000000
          Width = 377.953000000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              'from [SupplierPortEng] to [BuyerPortEng] / '#1056#1105#1056#183' [SupplierPortRus' +
              '] '#1056#1030' [BuyerPortRus]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo58: TfrxMemoView
          Left = 529.134200000000000000
          Top = 442.205010000000000000
          Width = 204.094620000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            'CONTAINER'#39'S / '#1056#1113#1056#1115#1056#1116#1056#1118#1056#8226#1056#8482#1056#1116#1056#8226#1056#160' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo59: TfrxMemoView
          Left = 733.228820000000000000
          Top = 442.205010000000000000
          Width = 313.700990000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[ContainerNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo60: TfrxMemoView
          Left = 967.559680000000000000
          Top = 480.000310000000000000
          Width = 79.370130000000000000
          Height = 75.590600000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1077#1034#8230#1080#1032#8230#1076#187#182#1078#8226#176'/ NUMBER OF CARTOONS / '#1056#1108#1056#1109#1056#187#1056#1105#1057#8225#1056#181#1057#1027#1057#8218#1056#1030#1056#1109'  '#1056#1112#1056#181#1057#1027#1057 +
              #8218)
          ParentFont = False
          VAlign = vaBottom
        end
        object Line1: TfrxLineView
          Top = 480.000310000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
      end
    end
    object Page2: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle2: TfrxReportTitle
        Height = 260.787570000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo15: TfrxMemoView
          Top = 207.874150000000000000
          Width = 132.283550000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'BOM#/ '#1056#1106#1057#1026#1057#8218#1056#1105#1056#1108#1057#1107#1056#187)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo61: TfrxMemoView
          Left = 132.283550000000000000
          Top = 207.874150000000000000
          Width = 714.331170000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            ' NAME / '#1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo63: TfrxMemoView
          Left = 846.614720000000000000
          Top = 207.874150000000000000
          Width = 75.590600000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'MEAS/ '#1056#8226#1056#1169' '#1056#1105#1056#183#1056#1112#1056#181#1057#1026)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo64: TfrxMemoView
          Left = 922.205320000000000000
          Top = 207.874150000000000000
          Width = 124.724490000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1077#1036#8226#1076#187#183' '#1077#8230#1107' /UNIT'#1074#1026#152'S PRICE,CNY/ '#1056#166#1056#181#1056#1029#1056#176' '#1056#183#1056#176' '#1056#181#1056#1169#1056#1105#1056#1029#1056#1105#1057#8224#1057#1107', CN' +
              'Y')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo72: TfrxMemoView
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngName]')
          ParentFont = False
        end
        object Memo73: TfrxMemoView
          Top = 22.677180000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngAddr]')
          ParentFont = False
        end
        object Memo74: TfrxMemoView
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierPhone]')
          ParentFont = False
        end
        object Memo103: TfrxMemoView
          Top = 83.149660000000000000
          Width = 1046.929810000000000000
          Height = 49.133890000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'PRICE SHEET / '#1056#1119#1056#160#1056#1106#1056#8482#1056#1038' '#1056#8250#1056#152#1056#1038#1056#1118)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo104: TfrxMemoView
          Top = 170.078850000000000000
          Width = 188.976500000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Price date / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1111#1057#1026#1056#1109#1056#176#1056#8470#1057#1027#1056#176':')
          ParentFont = False
        end
        object Memo106: TfrxMemoView
          Top = 132.283550000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'terms / '#1057#1107#1057#1027#1056#187#1056#1109#1056#1030#1056#1105#1057#1039' '#1056#1111#1056#1109#1057#1027#1057#8218#1056#176#1056#1030#1056#1108#1056#1105': [PortAndBasis]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Top = 260.787570000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo70: TfrxMemoView
          Left = 188.976500000000000000
          Top = 170.078850000000000000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[PriceDate]')
          ParentFont = False
        end
        object Memo71: TfrxMemoView
          Left = 718.110700000000000000
          Top = 170.078850000000000000
          Width = 204.094620000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'VALID UNTILL/'#1056#8221#1056#181#1056#8470#1057#1027#1057#8218#1056#1030#1056#1105#1057#8218#1056#181#1056#187#1056#181#1056#1029' '#1056#1169#1056#1109': ')
          ParentFont = False
        end
        object Memo75: TfrxMemoView
          Left = 922.205320000000000000
          Top = 170.078850000000000000
          Width = 124.724490000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[PriceValidDate]')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        Height = 18.897650000000000000
        Top = 340.157700000000000000
        Width = 1046.929810000000000000
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
        RowCount = 0
        Stretched = True
        object Memo62: TfrxMemoView
          Left = 411.968770000000000000
          Width = 434.645950000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetDetail
          DataSetName = 'frxDataSetDetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."RusTitle"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetMaster
          DataSetName = 'frxDataSetMaster'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."BOM"]')
          ParentFont = False
        end
        object Memo66: TfrxMemoView
          Left = 132.283550000000000000
          Width = 279.685220000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."EngTitle"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 846.614720000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."Unit"]')
          ParentFont = False
        end
        object Memo69: TfrxMemoView
          Left = 922.205320000000000000
          Width = 124.724441180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Price"]')
          ParentFont = False
        end
      end
    end
    object Page3: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle3: TfrxReportTitle
        Height = 332.598640000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo68: TfrxMemoView
          Top = 279.685220000000000000
          Width = 132.283550000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'BOM#/ '#1056#1106#1057#1026#1057#8218#1056#1105#1056#1108#1057#1107#1056#187)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo76: TfrxMemoView
          Left = 132.283550000000000000
          Top = 279.685220000000000000
          Width = 710.551640000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            ' NAME / '#1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo77: TfrxMemoView
          Left = 933.543910000000000000
          Top = 279.685220000000000000
          Width = 113.385900000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#8226#176#1081#8225#1039'/ QUANTITY/ '#1056#1113#1056#1109#1056#187#1056#1105#1057#8225#1056#181#1057#1027#1057#8218#1056#1030#1056#1109)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo78: TfrxMemoView
          Left = 842.835190000000000000
          Top = 279.685220000000000000
          Width = 90.708720000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'MEAS/ '#1056#8226#1056#1169' '#1056#1105#1056#183#1056#1112#1056#181#1057#1026)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo85: TfrxMemoView
          Top = 22.677180000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SupplierRusName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo86: TfrxMemoView
          Top = 102.047310000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[BuyerEngName] / [BuyerRusName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo94: TfrxMemoView
          Top = 83.149660000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'FROM:')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo105: TfrxMemoView
          Top = 234.330860000000000000
          Width = 226.771800000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            #1077#1106#8364#1077#1106#1034#1077#1039#183'/ Contract No / '#1056#1113#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo107: TfrxMemoView
          Left = 226.771800000000000000
          Top = 234.330860000000000000
          Width = 132.283550000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[BuyerContrNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo108: TfrxMemoView
          Left = 744.567410000000000000
          Top = 234.330860000000000000
          Width = 200.315090000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Contract dated / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1108#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218#1056#176':  ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo109: TfrxMemoView
          Left = 944.882500000000000000
          Top = 234.330860000000000000
          Width = 102.047310000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[BuyerContrDate]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line3: TfrxLineView
          Top = 332.598640000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo87: TfrxMemoView
          Top = 41.574830000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SupplierDirectorPosition]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo88: TfrxMemoView
          Top = 60.472480000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SupplierDirectorName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo89: TfrxMemoView
          Top = 120.944960000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[BuyerDirectorPosition]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo91: TfrxMemoView
          Top = 139.842610000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[BuyerDirectorName]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo92: TfrxMemoView
          Top = 158.740260000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'ORDER / '#1056#8212#1056#1106#1056#1113#1056#1106#1056#8212)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo93: TfrxMemoView
          Top = 196.535560000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'Order Date / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#183#1056#176#1056#1108#1056#176#1056#183#1056#176': [PriceDate]')
          ParentFont = False
        end
        object Memo90: TfrxMemoView
          Top = 3.779530000000000000
          Width = 529.134200000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'TO:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData3: TfrxMasterData
        Height = 18.897650000000000000
        Top = 411.968770000000000000
        Width = 1046.929810000000000000
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
        RowCount = 0
        Stretched = True
        object Memo79: TfrxMemoView
          Left = 385.512060000000000000
          Width = 457.323130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetDetail
          DataSetName = 'frxDataSetDetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."RusTitle"]')
          ParentFont = False
        end
        object Memo80: TfrxMemoView
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetMaster
          DataSetName = 'frxDataSetMaster'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."BOM"]')
          ParentFont = False
        end
        object Memo81: TfrxMemoView
          Left = 132.283550000000000000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."EngTitle"]')
          ParentFont = False
        end
        object Memo82: TfrxMemoView
          Left = 842.835190000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetMaster."Unit"]')
          ParentFont = False
        end
        object Memo83: TfrxMemoView
          Left = 933.543910000000000000
          Width = 113.385851180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Count"]')
          ParentFont = False
        end
      end
    end
    object Page4: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle4: TfrxReportTitle
        Height = 291.023810000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        Stretched = True
        object Memo84: TfrxMemoView
          Top = 238.110390000000000000
          Width = 128.504020000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'BOM#/ '#1056#1106#1057#1026#1057#8218#1056#1105#1056#1108#1057#1107#1056#187)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo95: TfrxMemoView
          Left = 128.504020000000000000
          Top = 238.110390000000000000
          Width = 532.913730000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            ' NAME / '#1056#1116#1056#176#1056#1105#1056#1112#1056#181#1056#1029#1056#1109#1056#1030#1056#176#1056#1029#1056#1105#1056#181)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo96: TfrxMemoView
          Left = 733.228820000000000000
          Top = 238.110390000000000000
          Width = 86.929190000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#8226#176#1081#8225#1039'/ QUANTITY/ '#1056#1113#1056#1109#1056#187#1056#1105#1057#8225#1056#181#1057#1027#1057#8218#1056#1030#1056#1109)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo97: TfrxMemoView
          Left = 661.417750000000000000
          Top = 238.110390000000000000
          Width = 71.811070000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            'MEAS/ '#1056#8226#1056#1169' '#1056#1105#1056#183#1056#1112#1056#181#1057#1026)
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo98: TfrxMemoView
          Left = 820.158010000000000000
          Top = 238.110390000000000000
          Width = 109.606370000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            
              #1077#1036#8226#1076#187#183' '#1077#8230#1107' /UNIT'#1074#1026#152'S PRICE,CNY/ '#1056#166#1056#181#1056#1029#1056#176' '#1056#183#1056#176' '#1056#181#1056#1169#1056#1105#1056#1029#1056#1105#1057#8224#1057#1107', CN' +
              'Y')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo99: TfrxMemoView
          Left = 929.764380000000000000
          Top = 238.110390000000000000
          Width = 117.165430000000000000
          Height = 52.913420000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            #1078#1026#187#1076#187#183' '#1077#8230#1107'/ TOTAL, CNY/ '#1056#1038#1057#8218#1056#1109#1056#1105#1056#1112#1056#1109#1057#1027#1057#8218#1057#1034', CNY')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo113: TfrxMemoView
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngName]')
          ParentFont = False
        end
        object Memo114: TfrxMemoView
          Top = 22.677180000000000000
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierEngAddr]')
          ParentFont = False
        end
        object Memo115: TfrxMemoView
          Top = 60.472480000000000000
          Width = 1046.929810000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[SupplierPhone]')
          ParentFont = False
        end
        object Memo116: TfrxMemoView
          Top = 94.488250000000000000
          Width = 1046.929810000000000000
          Height = 26.456710000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            'SPECIFICATION / '#1056#1038#1056#1119#1056#8226#1056#166#1056#152#1056#164#1056#152#1056#1113#1056#1106#1056#166#1056#152#1056#1031)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo126: TfrxMemoView
          Left = 241.889920000000000000
          Top = 181.417440000000000000
          Width = 132.283550000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[InvoiceNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo127: TfrxMemoView
          Top = 181.417440000000000000
          Width = 241.889920000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Invoice number / '#1056#152#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo128: TfrxMemoView
          Left = 941.102970000000000000
          Top = 181.417440000000000000
          Width = 105.826840000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[InvoiceDate]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo129: TfrxMemoView
          Top = 162.519790000000000000
          Width = 241.889920000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Contract No / '#1056#1113#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218' '#1074#8222#8211':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo130: TfrxMemoView
          Left = 241.889920000000000000
          Top = 162.519790000000000000
          Width = 211.653680000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[BuyerContrNum]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo131: TfrxMemoView
          Left = 721.890230000000000000
          Top = 162.519790000000000000
          Width = 219.212740000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Contract dated / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1108#1056#1109#1056#1029#1057#8218#1057#1026#1056#176#1056#1108#1057#8218#1056#176':  ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo132: TfrxMemoView
          Left = 941.102970000000000000
          Top = 162.519790000000000000
          Width = 105.826840000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[BuyerContrDate]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo135: TfrxMemoView
          Left = 721.890230000000000000
          Top = 181.417440000000000000
          Width = 219.212740000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Invoice date / '#1056#8221#1056#176#1057#8218#1056#176' '#1056#1105#1056#1029#1056#1030#1056#1109#1056#8470#1057#1027#1056#176':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line4: TfrxLineView
          Top = 291.023810000000000000
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo111: TfrxMemoView
          Top = 120.944960000000000000
          Width = 1046.929810000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            #1074#8222#8211' [SpecNum]       date / '#1056#1169#1056#176#1057#8218#1056#176'  [PriceDate]')
          ParentFont = False
        end
        object Memo112: TfrxMemoView
          Top = 200.315090000000000000
          Width = 241.889920000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Shipment terms / '#1056#1032#1057#1027#1056#187#1056#1109#1056#1030#1056#1105#1057#1039' '#1056#1111#1056#1109#1057#1027#1057#8218#1056#176#1056#1030#1056#1108#1056#1105':')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo117: TfrxMemoView
          Left = 241.889920000000000000
          Top = 200.315090000000000000
          Width = 377.953000000000000000
          Height = 18.897637800000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '[PortAndBasis]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object MasterData4: TfrxMasterData
        Height = 18.897650000000000000
        Top = 370.393940000000000000
        Width = 1046.929810000000000000
        DataSet = frxDataSetMaster
        DataSetName = 'frxDataSetMaster'
        RowCount = 0
        Stretched = True
        object Memo100: TfrxMemoView
          Left = 325.039580000000000000
          Width = 336.378170000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetDetail
          DataSetName = 'frxDataSetDetail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."RusTitle"]')
          ParentFont = False
        end
        object Memo101: TfrxMemoView
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxDataSetMaster
          DataSetName = 'frxDataSetMaster'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."BOM"]')
          ParentFont = False
        end
        object Memo102: TfrxMemoView
          Left = 128.504020000000000000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8 = (
            '[frxDataSetMaster."EngTitle"]')
          ParentFont = False
        end
        object Memo110: TfrxMemoView
          Left = 661.417750000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[frxDataSetMaster."Unit"]')
          ParentFont = False
        end
        object Memo118: TfrxMemoView
          Left = 733.228820000000000000
          Width = 86.929141180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Count"]')
          ParentFont = False
        end
        object Memo119: TfrxMemoView
          Left = 820.158010000000000000
          Width = 109.606321180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."Price"]')
          ParentFont = False
        end
        object Memo120: TfrxMemoView
          Left = 929.764380000000000000
          Width = 117.165381180000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8 = (
            '[frxDataSetMaster."TotalPrice"]')
          ParentFont = False
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
end
