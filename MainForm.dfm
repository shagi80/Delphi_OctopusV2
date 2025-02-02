object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Developer: Shaginyan SV'
  ClientHeight = 31
  ClientWidth = 928
  Color = clBtnFace
  Constraints.MaxHeight = 90
  Constraints.MinHeight = 90
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 928
    Height = 30
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 436
      Top = 2
      Width = 289
      Height = 22
      Caption = 'ToolBar1'
      Images = imgMain
      TabOrder = 0
      object lbSearch: TLabel
        Tag = 18
        Left = 0
        Top = 0
        Width = 105
        Height = 22
        AutoSize = False
        Caption = #1055#1086#1080#1089#1082' '#1076#1077#1090#1072#1083#1080
        Layout = tlCenter
      end
      object edSearch: TEdit
        Left = 105
        Top = 0
        Width = 121
        Height = 22
        TabOrder = 0
        OnKeyUp = edSearchKeyUp
      end
      object ToolButton1: TToolButton
        Left = 226
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        Style = tbsSeparator
      end
      object btnSearch: TToolButton
        Tag = 18
        Left = 234
        Top = 0
        Action = SearchStart
      end
      object btnSearchClear: TToolButton
        Left = 257
        Top = 0
        Action = SearchClear
      end
    end
    object ToolBar2: TToolBar
      Left = 238
      Top = 2
      Width = 185
      Height = 22
      ButtonHeight = 21
      Caption = 'ToolBar1'
      TabOrder = 1
      object Label2: TLabel
        Tag = 57
        Left = 0
        Top = 0
        Width = 33
        Height = 21
        AutoSize = False
        Caption = #1042#1080#1076
        Layout = tlCenter
      end
      object cbView: TComboBox
        Left = 33
        Top = 0
        Width = 145
        Height = 21
        ItemHeight = 0
        ItemIndex = 0
        TabOrder = 0
        Text = #1055#1088#1086#1089#1084#1086#1090#1088
        Items.Strings = (
          #1055#1088#1086#1089#1084#1086#1090#1088
          #1050#1088#1085#1089#1090#1088#1091#1082#1090#1086#1088' '#1082#1086#1088#1086#1073#1086#1082
          #1055#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1080#1085#1074#1086#1081#1089#1072)
      end
    end
    object ToolBar3: TToolBar
      Left = 11
      Top = 2
      Width = 214
      Height = 22
      Caption = 'ToolBar3'
      Images = imgMain
      TabOrder = 2
      object ToolButton4: TToolButton
        Left = 0
        Top = 0
        Action = FileNew
      end
      object ToolButton5: TToolButton
        Left = 23
        Top = 0
        Action = FileOpen
      end
      object ToolButton6: TToolButton
        Left = 46
        Top = 0
        Action = FileSave
      end
      object ToolButton7: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Left = 77
        Top = 0
        Action = EditCopy1
      end
      object ToolButton9: TToolButton
        Left = 100
        Top = 0
        Action = EditCut1
      end
      object ToolButton10: TToolButton
        Left = 123
        Top = 0
        Action = EditPaste1
      end
      object ToolButton11: TToolButton
        Left = 146
        Top = 0
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object ToolButton12: TToolButton
        Left = 154
        Top = 0
        Action = FilePrint
      end
      object ToolButton13: TToolButton
        Left = 177
        Top = 0
        Action = FileExport
      end
    end
  end
  object mmMain: TMainMenu
    Left = 816
    object FileItem: TMenuItem
      Tag = 1
      Caption = #1060#1074#1081#1083
      GroupIndex = 1
      Hint = #1040#1088#1086#1086#1075#1085#1088#1088' '#1077#1077#1077
      object FileNewItem: TMenuItem
        Tag = 2
        Action = FileNew
      end
      object FileOpenItem: TMenuItem
        Tag = 3
        Action = FileOpen
        Caption = #1054#1090#1082#1088#1099#1090#1100
      end
      object FileSaveItem: TMenuItem
        Tag = 4
        Action = FileSave
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      end
      object FileSaveAsItem: TMenuItem
        Tag = 5
        Action = FileSaveAs
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object FileMerge1: TMenuItem
        Action = FileMerge
      end
      object N36: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Tag = 6
        Action = FilePrint
      end
      object Export1: TMenuItem
        Tag = 7
        Action = FileExport
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object FileExitItem: TMenuItem
        Tag = 8
        Action = FileExit
        Caption = #1042#1099#1093#1088#1076
      end
    end
    object MenuItem1: TMenuItem
      Tag = 9
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      GroupIndex = 2
      Hint = 'Edit commands'
      object CutItem: TMenuItem
        Tag = 10
        Action = EditCut1
        Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      end
      object CopyItem: TMenuItem
        Tag = 11
        Action = EditCopy1
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      end
      object PasteItem: TMenuItem
        Tag = 12
        Action = EditPaste1
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      end
    end
    object miPart: TMenuItem
      Tag = 13
      Caption = #1044#1077#1090#1072#1083#1100
      GroupIndex = 101
      object N12: TMenuItem
        Tag = 14
        Action = PartNew
      end
      object N28: TMenuItem
        Tag = 15
        Action = PartCopy
      end
      object N29: TMenuItem
        Tag = 16
        Action = PartEdit
      end
      object N30: TMenuItem
        Tag = 17
        Action = PartDelete
      end
      object N31: TMenuItem
        Caption = '-'
      end
      object N32: TMenuItem
        Tag = 18
        Action = PartSearch
      end
    end
    object miOrders: TMenuItem
      Tag = 19
      Caption = #1047#1072#1082#1072#1079#1099
      GroupIndex = 101
      object N8: TMenuItem
        Tag = 20
        Caption = #1053#1086#1074#1099#1081' '#1079#1072#1082#1072#1079
        ImageIndex = 30
        object N17: TMenuItem
          Action = OrderAdd
        end
        object N110: TMenuItem
          Action = OrderNewFromFile
        end
        object Octopus1: TMenuItem
          Action = OrderNewFrom1CAndMultiple
        end
      end
      object N49: TMenuItem
        Action = OrderRename
      end
      object N33: TMenuItem
        Tag = 21
        Action = OrderSaveTo1C
      end
      object N9: TMenuItem
        Tag = 22
        Action = OrderConcate
      end
      object N10: TMenuItem
        Tag = 23
        Action = OrderDelete
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miOrderAddPart: TMenuItem
        Tag = 30
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
        ImageIndex = 19
        object N23: TMenuItem
          Action = OrderAddPart
        end
        object N24: TMenuItem
          Action = OrderAddPartFromOther
        end
        object N25: TMenuItem
          Caption = '-'
        end
        object N26: TMenuItem
          Action = PartNew
        end
        object N27: TMenuItem
          Action = OrderCopyPart
        end
      end
      object N13: TMenuItem
        Action = OrderEditPart
      end
      object N14: TMenuItem
        Action = OrderDeletePart
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object N16: TMenuItem
        Action = OrderSearchPart
      end
    end
    object miBox: TMenuItem
      Tag = 31
      Caption = #1050#1086#1088#1086#1073#1082#1080
      GroupIndex = 101
      object N18: TMenuItem
        Action = BoxNew
      end
      object N44: TMenuItem
        Action = BoxNewAndLoad
      end
      object N20: TMenuItem
        Action = BoxLoadPart
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object N21: TMenuItem
        Action = BoxSaveInContainer
      end
      object N52: TMenuItem
        Caption = '-'
      end
      object N45: TMenuItem
        Action = BoxDelete
      end
    end
    object miContainers: TMenuItem
      Tag = 32
      Caption = #1050#1086#1085#1090#1077#1081#1085#1077#1088#1072
      GroupIndex = 101
      object N41: TMenuItem
        Action = ContainerAdd
      end
      object N42: TMenuItem
        Action = ContainerEdit
      end
      object N43: TMenuItem
        Action = ContainerDelete
      end
      object N46: TMenuItem
        Caption = '-'
      end
      object ContainerAddBoxAndLoadPart1: TMenuItem
        Action = ContainerAddBoxAndLoadPart
      end
      object ContaiinerLoadParAuto1: TMenuItem
        Action = ContaiinerLoadParAuto
      end
      object N53: TMenuItem
        Caption = '-'
      end
      object ContainerLoadPartToBox1: TMenuItem
        Action = ContainerLoadPartToBox
      end
      object ContainerEditBox1: TMenuItem
        Action = ContainerEditBox
      end
      object ContainerUnloadPart2: TMenuItem
        Action = ContainerUnloadPart
      end
      object ContainerUnloadPart1: TMenuItem
        Action = ContainerDeleteBox
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object ContainerChangeGross1: TMenuItem
        Action = ContainerChangeGross
      end
      object N54: TMenuItem
        Caption = '-'
      end
      object N35: TMenuItem
        Action = ContainerSearchPart
      end
    end
    object miInvoice: TMenuItem
      Tag = 55
      Caption = #1048#1085#1074#1086#1081#1089
      GroupIndex = 101
      object miSeAmount: TMenuItem
        Tag = 56
        Action = InvoiceChageTotalCost
      end
      object N38: TMenuItem
        Caption = '-'
      end
      object N51: TMenuItem
        Action = InvoiceEditPart
      end
      object N50: TMenuItem
        Caption = '-'
      end
      object N37: TMenuItem
        Action = InvoiceSearchPart
      end
    end
    object miView: TMenuItem
      Tag = 57
      Caption = '&'#1042#1080#1076
      GroupIndex = 101
      Hint = 'Window related commands'
      object WindowCascadeItem: TMenuItem
        Action = ViewView
      end
      object WindowTileItem: TMenuItem
        Action = ViewBoxCreator
      end
      object WindowTileItem2: TMenuItem
        Action = ViewInvoice
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miViewPanels: TMenuItem
        Tag = 58
        Caption = #1055#1072#1085#1077#1083#1080
        object N3: TMenuItem
          Action = ViewPartForm
        end
        object N4: TMenuItem
          Action = ViewOrdersForm
        end
        object N5: TMenuItem
          Action = ViewBoxForm
        end
        object N6: TMenuItem
          Action = ViewContainersForm
        end
        object N7: TMenuItem
          Action = ViewInvoiceForm
        end
      end
    end
    object Help1: TMenuItem
      Tag = 53
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      GroupIndex = 101
      Hint = 'Help topics'
      object N47: TMenuItem
        Action = HelpSettings
      end
      object N48: TMenuItem
        Caption = '-'
      end
      object HelpAboutItem: TMenuItem
        Action = HelpAbout
      end
    end
  end
  object dlgFileOpen: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Text files (*.txt)|*.txt'
    Title = #1054#1090#1082#1088#1099#1090#1080#1077' '#1092#1072#1081#1083#1072
    Left = 752
  end
  object actMain: TActionList
    Images = imgMain
    Left = 848
    object FileNew: TAction
      Tag = 2
      Category = 'File'
      Caption = #1053#1086#1074#1099#1081
      Hint = #1053#1086#1074#1099#1081'|'#1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1092#1072#1081#1083#1072
      ImageIndex = 6
      ShortCut = 16462
    end
    object FileOpen: TAction
      Tag = 3
      Category = 'File'
      Caption = '&Open'
      Hint = 'Open|Open a file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object FileSave: TAction
      Tag = 4
      Category = 'File'
      Caption = '&Save'
      Hint = 'Save|Save current file'
      ImageIndex = 8
      ShortCut = 16467
    end
    object FileSaveAs: TAction
      Tag = 5
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Save current file with different name'
    end
    object FileExit: TAction
      Tag = 8
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Exit application'
      OnExecute = FileExitExecute
    end
    object EditCut1: TEditCut
      Tag = 10
      Category = 'Edit'
      Caption = 'Cu&t'
      Enabled = False
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Tag = 11
      Category = 'Edit'
      Caption = '&Copy'
      Enabled = False
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Tag = 12
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object HelpAbout: TAction
      Tag = 54
      Category = 'Help'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      Hint = 
        'About|Displays program information, version number, and copyrigh' +
        't'
      OnExecute = HelpAboutExecute
    end
    object FilePrint: TAction
      Tag = 6
      Category = 'File'
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 14
      OnExecute = FilePrintExecute
    end
    object FileExport: TAction
      Tag = 7
      Category = 'File'
      Caption = #1069#1082#1089#1087#1086#1088#1090
      ImageIndex = 18
      OnExecute = FileExportExecute
    end
    object SearchStart: TAction
      Category = 'Search'
      Caption = #1055#1086#1080#1089#1082' '#1076#1077#1090#1072#1083#1080
      ImageIndex = 12
      OnExecute = SearchStartExecute
    end
    object SearchClear: TAction
      Category = 'Search'
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1087#1086#1080#1089#1082
      ImageIndex = 5
      OnExecute = SearchClearExecute
    end
    object ViewChange: TAction
      Category = 'View'
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1074#1080#1076
    end
    object ViewView: TAction
      Tag = 45
      Category = 'View'
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088
    end
    object ViewBoxCreator: TAction
      Tag = 46
      Category = 'View'
      Caption = #1050#1086#1085#1089#1090#1088#1091#1082#1090#1086#1088' '#1082#1086#1088#1086#1073#1086#1082
    end
    object ViewInvoice: TAction
      Tag = 47
      Category = 'View'
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1080#1085#1074#1086#1081#1089#1072
    end
    object ViewPartForm: TAction
      Tag = 48
      Category = 'View'
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1076#1077#1090#1072#1083#1080
    end
    object ViewOrdersForm: TAction
      Tag = 49
      Category = 'View'
      Caption = #1047#1072#1082#1072#1079#1099
    end
    object ViewBoxForm: TAction
      Tag = 51
      Category = 'View'
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1088#1086#1073#1082#1080
    end
    object ViewContainersForm: TAction
      Tag = 50
      Category = 'View'
      Caption = #1050#1086#1085#1090#1077#1081#1085#1077#1088#1072
    end
    object ViewInvoiceForm: TAction
      Tag = 52
      Category = 'View'
      Caption = #1048#1085#1074#1086#1081#1089
    end
    object OrderAdd: TAction
      Tag = 20
      Category = 'Order'
      Caption = #1055#1091#1089#1090#1086#1081' '#1079#1072#1082#1072#1079
      ImageIndex = 30
    end
    object OrderDelete: TAction
      Tag = 23
      Category = 'Order'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 32
    end
    object OrderConcate: TAction
      Tag = 22
      Category = 'Order'
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1079#1072#1082#1072#1079#1099
      ImageIndex = 31
    end
    object OrderAddPart: TAction
      Tag = 24
      Category = 'Order'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1100' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 19
    end
    object OrderDeletePart: TAction
      Tag = 17
      Category = 'Order'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 20
    end
    object OrderCopyPart: TAction
      Tag = 15
      Category = 'Order'
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 21
    end
    object OrderSearchPart: TAction
      Tag = 18
      Category = 'Order'
      Caption = #1053#1072#1081#1090#1080' '#1076#1077#1090#1072#1083#1100' '#1074' '#1082#1086#1085#1090#1077#1081#1085#1077#1088#1072#1093
      ImageIndex = 1
    end
    object BoxNew: TAction
      Tag = 33
      Category = 'Box'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1082#1086#1088#1086#1073#1086#1082' '#1074' '#1088#1091#1095#1085#1091#1102
      ImageIndex = 40
    end
    object BoxLoadPart: TAction
      Tag = 34
      Category = 'Box'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1077#1090#1072#1083#1100' '#1074' '#1082#1086#1088#1086#1073#1082#1080
      ImageIndex = 36
    end
    object BoxLoadPartAuto: TAction
      Tag = 35
      Category = 'Box'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1075#1088#1091#1087#1087#1099' '#1082#1086#1088#1086#1073#1086#1082' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
      ImageIndex = 39
    end
    object BoxSaveInContainer: TAction
      Tag = 36
      Category = 'Box'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1082#1086#1088#1086#1073#1082#1091' '#1074' '#1082#1086#1085#1090#1077#1081#1085#1077#1088
      ImageIndex = 26
    end
    object BoxUnloadPart: TAction
      Tag = 37
      Category = 'Box'
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1076#1077#1090#1072#1083#1100' '#1080#1079' '#1082#1086#1088#1086#1073#1086#1082
      ImageIndex = 37
    end
    object BoxDelete: TAction
      Tag = 38
      Category = 'Box'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091' '#1082#1086#1088#1086#1073#1086#1082
      ImageIndex = 38
    end
    object OrderRename: TAction
      Tag = 25
      Category = 'Order'
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 33
    end
    object OrderEditPart: TAction
      Tag = 16
      Category = 'Order'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 29
    end
    object OrderNewFromFile: TAction
      Tag = 26
      Category = 'Order'
      Caption = #1048#1079' '#1092#1072#1081#1083#1072
    end
    object PartNew: TAction
      Tag = 14
      Category = 'Part'
      Caption = #1053#1086#1074#1072#1103' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 34
    end
    object PartEdit: TAction
      Tag = 16
      Category = 'Part'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 29
    end
    object PartCopy: TAction
      Tag = 15
      Category = 'Part'
      Caption = #1053#1086#1074#1074#1072#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077#1084
      ImageIndex = 21
    end
    object PartDelete: TAction
      Tag = 17
      Category = 'Part'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 20
    end
    object PartSearch: TAction
      Tag = 18
      Category = 'Part'
      Caption = #1053#1072#1081#1090#1080' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 12
    end
    object OrderAddPartFromOther: TAction
      Tag = 28
      Category = 'Order'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1100' '#1080#1079' '#1092#1072#1081#1083#1072' 1'#1057
    end
    object OrderNewFrom1CAndMultiple: TAction
      Tag = 29
      Category = 'Order'
      Caption = #1048#1079' '#1092#1072#1081#1083#1072' 1'#1057' '#1089' '#1091#1084#1085#1086#1078#1077#1085#1080#1077#1084
    end
    object OrderSaveTo1C: TAction
      Tag = 21
      Category = 'Order'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082' '#1096#1072#1073#1083#1086#1085
      ImageIndex = 35
    end
    object ContainerSearchPart: TAction
      Tag = 18
      Category = 'Container'
      Caption = #1053#1072#1081#1090#1080' '#1076#1077#1090#1072#1083#1100' '#1074' '#1079#1072#1082#1072#1079#1072#1093
      ImageIndex = 7
    end
    object InvoiceSearchPart: TAction
      Tag = 18
      Category = 'Invoice'
      Caption = #1053#1072#1081#1090#1080' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 1
    end
    object ContainerAdd: TAction
      Tag = 39
      Category = 'Container'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 30
    end
    object ContainerEdit: TAction
      Tag = 40
      Category = 'Container'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1074#1086#1081#1089#1090#1074#1072
      ImageIndex = 33
    end
    object ContainerDelete: TAction
      Tag = 41
      Category = 'Container'
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1085#1090#1077#1081#1085#1077#1088
      ImageIndex = 32
    end
    object InvoiceEditPart: TAction
      Tag = 16
      Category = 'Invoice'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 15
    end
    object HelpSettings: TAction
      Tag = 53
      Category = 'Help'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnExecute = HelpSettingsExecute
    end
    object BoxNewAndLoad: TAction
      Tag = 152
      Category = 'Box'
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091' '#1082#1086#1088#1086#1073#1086#1082' '#1080' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1076#1077#1090#1072#1083#1100
      ImageIndex = 41
    end
    object ContainerAddBoxAndLoadPart: TAction
      Tag = 152
      Category = 'Container'
      Caption = 'ContainerAddBoxAndLoadPart'
      ImageIndex = 41
    end
    object ContainerLoadPartToBox: TAction
      Tag = 34
      Category = 'Container'
      Caption = 'ContainerLoadPartToBox'
      ImageIndex = 36
    end
    object ContaiinerLoadParAuto: TAction
      Tag = 35
      Category = 'Container'
      Caption = 'ContainerLoadParAuto'
      ImageIndex = 39
    end
    object ContainerUnloadPart: TAction
      Tag = 37
      Category = 'Container'
      Caption = 'ContainerUnloadPart'
      ImageIndex = 37
    end
    object ContainerDeleteBox: TAction
      Tag = 38
      Category = 'Container'
      Caption = 'ContainerDeleteBox'
      ImageIndex = 38
    end
    object ContainerEditBox: TAction
      Tag = 155
      Category = 'Container'
      Caption = 'ContainerEditBox'
      ImageIndex = 42
    end
    object ContainerAddInBoxSelect: TAction
      Tag = 156
      Category = 'Container'
      Caption = 'ContainerAddInBoxSelect'
    end
    object ContainerAddInBoxMark: TAction
      Tag = 157
      Category = 'Container'
      Caption = 'ContainerAddInBoxMark'
    end
    object PartListUpdate: TAction
      Tag = 164
      Category = 'Part'
      Caption = 'PartListUpdate'
      ImageIndex = 43
    end
    object ContainerChangeGross: TAction
      Tag = 167
      Category = 'Container'
      Caption = 'ContainerChangeGross'
      ImageIndex = 44
    end
    object InvoiceChageTotalCost: TAction
      Tag = 42
      Category = 'Invoice'
      Caption = 'InvoiceChageTotalCost'
      ImageIndex = 11
    end
    object FileMerge: TAction
      Tag = 182
      Category = 'File'
      Caption = 'FileMerge'
      OnExecute = FileMergeExecute
    end
  end
  object imgMain: TImageList
    Left = 880
    Bitmap = {
      494C01012E003100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D0000000010020000000000000D0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECF3E500ACCA91008DB567008CB56700A9C78E00E2ECD8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE0090BB6A004F9012004C8E0F004A8C0E00488A0D0046880B0045860C0088B0
      6300F5F8F1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F00000000000000000000000000000000007F7F7F000000
      0000000000000000000000000000000000000000000000000000FEFFFE0074AB
      4100519513004F9312004E9111006EA041006C9E4000488A0D0046880B004585
      0A0065993500F5F8F10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000B3D29600559A
      16005398150057971D008DB56900CADBBA00C9DAB90072A1480048890D004688
      0B0045850A0088B0630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000939393001A1A
      1A001A1A1A0093939300000000007F7F7F007F7F7F0000000000939393001A1A
      1A001A1A1A0093939300000000000000000000000000FEFEFD005EA02000579C
      1700559A160087B36000ECF2E600C2D6B000CADBBA00FEFEFD006A9C3C00488A
      0D0046880B0045860C00E2ECD900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3C3C30019191900DBDB
      DB00DADADA0019191900C4C4C4007F7F7F007F7F7F00C3C3C30019191900DBDB
      DB00DADADA0019191900C4C4C4000000000000000000EEF5E7005BA21C00589E
      1800579C1700589A1D00539618005194130056931F00FBFCF90091B66F004A8C
      0E00488A0D0046880B00A7C68C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008F8F8F00000000000000
      00000000000000000000909090007F7F7F007F7F7F008F8F8F00000000000000
      00000000000000000000909090000000000000000000E5F1DB005DA31C005AA1
      1A00589E1800579C1700609C2700A4C48800ECF2E600F3F7EF00629A30004C8E
      0F004A8C0E00488A0D008EB66A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDED0016161600D3D3
      D300D6D6D60015151500EBEBEB007F7F7F007F7F7F00EDEDED0016161600D3D3
      D300D6D6D60015151500EBEBEB000000000000000000EEF5E6005FA51D005CA3
      1B005AA11A0066A23000EEF4E900F4F8F100AFCB9500609A2B004F9312004E91
      11004C8E0F004A8C0E008EB76A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E8E004444
      4400484848008F8F8F00000000007F7F7F007F7F7F00000000008E8E8E004444
      4400484848008F8F8F00000000000000000000000000FBFDF90065AA25005EA5
      1C005CA31B0098BF7300FAFCF900639F2C005599160053971500519513004F93
      12004E9111004C8E0F00B1CD9700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FAFAFA002727
      270027272700FAFAFA00FEFEFE006060600060606000FEFEFE00FAFAFA002727
      270027272700FAFAFA00000000000000000000000000000000008BBF5A0060A7
      1E005EA51C007DB14C00FEFFFE00B2CE9900A7C78A00CDDEBE00519515005195
      13004F9312004F901200EFF5EA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      420042424200777777005B5B5B002D2D2D002D2D2D005B5B5B00777777004242
      4200424242000000000000000000000000000000000000000000F8FBF50062AA
      200060A71E005EA41C008BB86100D6E5C900D9E7CD00A9C88D00549816005398
      15005195130092BC6D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008888
      88008888880088888800686868002D2D2D002D2D2D0069696900888888008888
      880088888800000000000000000000000000000000000000000000000000EFF6
      E90062AA200060A71E005EA51C007AB0490079AE4800589E1800579C1700559A
      160076AC4400FDFEFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ABABAB00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9FCF70097C66B0062A821005EA51C005CA31B005AA11A005D9F1E00B9D6
      9F00FEFEFE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFDF900E2EFD600D6E8C500E7F1DE00FDFEFD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECEEEE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF00000000000000000000000000000000004F484100798E9700DDE8
      EE00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009F9F9F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000D0D7DA0083C8ED0078B7
      D90074B0C900F9FBFC0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00000000000000000000000000000000000000
      00006666660066666600666666008A8A8A0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF000000000000000000000000000000000000000000000000000000
      00006666660066666600666666008A8A8A0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000007AB8DA006DBB
      DA0095E2F40076B8CF00FCFDFE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A1A1A100A1A1A1000000
      00000000000000000000F8F8F8004E4E4E004C4C4C00FBFBFB00000000000000
      000000000000A1A1A100A1A1A1000000000000000000E0E0E000C6C6C600DBDB
      DB0000000000EEEEEE00000000005A5A5A0057AFFF0057AFFF00000000000000
      00000000000000000000000000000000000000000000E0E0E000C6C6C600DBDB
      DB0000000000EEEEEE00000000005A5A5A0057AFFF0057AFFF00000000000000
      0000000000000000000000000000000000000000000000000000E8F2F60096E1
      F500A3EEFF009BE7F90095CCDF00FCFDFE000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F8F8
      F80091919100EAEAEA00B0B0B0001B1B1B00000000009A9A9A00F0F0F0009393
      9300F8F8F80000000000000000000000000000000000C8C8C800E0E0E000AAAA
      AA00E0E0E00000000000000000005C5C5C0057AFFF000A1A1F0050D5FF0050D5
      FF0050D5FF0050D5FF00000000000000000000000000C8C8C800E0E0E000AAAA
      AA00E0E0E00000000000000000005C5C5C0057AFFF000A1A1F0050D5FF0050D5
      FF0050D5FF0050D5FF000000000000000000000000000000000000000000F1F8
      FA009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006464
      64000000000002020200000000000000000000000000000000002C2C2C000202
      02006060600000000000000000000000000029292900DDDDDD00A3A3A3000000
      00000000000000000000000000005C5C5C005151510000000000000000000000
      00000000000000000000000000000000000029292900DDDDDD00A3A3A3000000
      00000000000000000000000000005C5C5C005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFEFE009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE00000000000000
      000000000000000000000000000000000000000000000000000000000000B8B8
      B8001010100000000000000000001A1A1A001A1A1A0000000000000000000000
      00009898980000000000000000000000000066666600F5F5F500DCDCDC000000
      000000000000FCFCFC00000000005C5C5C000000000000000000000000000000
      00000000000000000000000000000000000066666600F5F5F500DCDCDC000000
      000000000000FCFCFC00000000005C5C5C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAFCFD009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE000000
      0000000000000000000000000000000000000000000000000000000000008F8F
      8F00000000000000000008080800C9C9C900C9C9C90008080800000000000000
      00009090900000000000000000000000000066666600F5F5F500000000000000
      0000FCFCFC0000000000000000005C5C5C000000000000000000000000000000
      00000000000000000000000000000000000066666600F5F5F500000000000000
      0000FCFCFC0000000000000000005C5C5C0000000000000000006FCC00006FCC
      0000000000000000000000000000000000000000000000000000151515000000
      00000000000000000000F7FBFC009DE6F900A3EEFF009CE7F90095CCDF00FCFD
      FE000000000000000000000000000000000000000000000000003B3B3B000202
      02000000000000000000A2A2A2000000000000000000A2A2A200000000000000
      0000333333003C3C3C00000000000000000066666600F5F5F500000000000000
      00009D9D9D004B4B4B003F3F3F00545454000000000000000000000000000000
      00000000000000000000000000000000000066666600F5F5F500000000000000
      00009D9D9D004B4B4B003F3F3F0054545400000000006FCC00006FCC00006FCC
      00006FCC000000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF00FAFCFD009DE6F900A3EEFF009CE7F90096CC
      DF00FCFDFE000000000000000000000000000000000000000000010101000A0A
      0A00000000000B0B0B0044444400C7C7C700C7C7C700444444000B0B0B000000
      00000000000000000000000000000000000066666600F5F5F500000000000000
      00008E8E8E00ACACAC0050505000ECECEC000000000000000000000000000000
      00000000000000000000000000000000000066666600F5F5F500000000000000
      00008E8E8E00ACACAC0050505000000000006FCC00006FCC00006FCC00006FCC
      00006FCC00006FCC0000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF00FDFEFE009DE6F900A3EEFF009CE7
      F90096C9DA00FAFBFC0000000000000000000000000000000000BABABA006262
      6200000000000000000000000000A0A0A000A0A0A00000000000000000000000
      00003C3C3C00BBBBBB0000000000000000006666660000000000000000000000
      0000000000003B3B3B00EEEEEE00000000000000000000000000000000000000
      0000000000000000000000000000000000006666660000000000000000000000
      0000000000003B3B3B000000000000000000000000006FCB00006FCC00006FCC
      000066BB000000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF00FAFDFE009DE6F900A2E8
      F700B0B4AC00C3BCB300FAFAFC0000000000000000000000000000000000B0B0
      B0000000000000000000000000008A8A8A008A8A8A0000000000000000000202
      0200CACACA00000000000000000000000000CCCCCC00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00EEEEEE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCCCCC00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00EEEEEE00000000000000000000000000222222006FCC00006FCC
      0000000000000000000000000000000000001313130000000000000000000000
      0000000000000000000057AFFF0057AFFF0057AFFF0057AFFF00F0F7F900AFB3
      AB00F3E5D700EBDDCF00A297AF00FEFEFF000000000000000000000000005B5B
      5B00010101000000000000000000000000000000000000000000000000000D0D
      0D00656565000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000191919006FCC00006FCC
      000000000000000000000000000000000000000000000000000050D5FF0050D5
      FF0050D5FF0050D5FF001F53630057AFFF0057AFFF000A1A1F0050D5FF00F8F7
      F600ECDED000B7AAB2008A88E800BEBEED00000000000000000000000000BABA
      BA00141414009B9B9B00313131000000000005050500383838006C6C6C001515
      1500BBBBBB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000010101006FCC00006FCC
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005151510000000000000000000000
      0000F0EEF2008B8AE8008080E900D3D3F3000000000000000000000000000000
      00000000000000000000E4E4E4000202020018181800F0F0F00000000000FCFC
      FC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8F8FD00D2D2F300000000000000000000000000000000000000
      0000000000000000000000000000C2C2C200C8C8C80000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000151515000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF0000000000000000000000000000000000000000000000000057AF
      FF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF000000000000000000000000000000000000000000EFEFEF004B4B
      4B00AAAAAA0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF0057AFFF00AAAA
      AA004B4B4B00EFEFEF0000000000000000000000000000000000000000000000
      00006666660066666600666666008A8A8A0057AFFF0057AFFF0057AFFF0057AF
      FF0057AFFF000000000000000000000000001313130000000000000000000000
      0000000000000000000057AFFF0057AFFF0057AFFF0057AFFF00000000000000
      0000000000000000000000000000000000001313130000000000000000000000
      0000000000000000000057AFFF0057AFFF0057AFFF0057AFFF00000000000000
      00000000000000000000000000000000000013131300000000004B4B4B000000
      000004040400A9A9A90057AFFF0057AFFF0057AFFF0057AFFF00A9A9A9000404
      0400000000004C4C4C00000000000000000000000000E0E0E000C6C6C600DBDB
      DB0000000000EEEEEE00000000005A5A5A0057AFFF0057AFFF00000000000000
      000000000000000000000000000000000000000000000000000050D5FF0050D5
      FF0050D5FF0050D5FF001F53630057AFFF0057AFFF000A1A1F0050D5FF0050D5
      FF0050D5FF0050D5FF000000000000000000000000000000000050D5FF0050D5
      FF0050D5FF0050D5FF001F53630057AFFF0057AFFF000A1A1F0050D5FF0050D5
      FF0050D5FF0050D5FF0000000000000000000000000000000000AAAAAA000404
      04000000000004040400A9A9A90057AFFF0057AFFF00A9A9A900040404000000
      000004040400AAAAAA00000000000000000000000000C8C8C800E0E0E000AAAA
      AA00E0E0E00000000000000000005C5C5C0057AFFF000A1A1F0050D5FF0050D5
      FF0050D5FF0050D5FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005151510000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB00040404000000000003030300A5A5A500ABABAB0005050500000000000303
      0300A4A4A40000000000000000000000000029292900DDDDDD00A3A3A3000000
      00000000000000000000000000005C5C5C005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A9A9A900040404000000000004040400040404000000000004040400A9A9
      A90000000000000000000000000000000000666666005C5C5C00DCDCDC000000
      00000000000000000000000000005C5C5C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006FCC00006FCC000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000001010100241CED00241CED0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB0004040400000000000000000003030300A4A4A4000000
      000000000000000000000000000000000000666666005C5C5C00000000000000
      00006FCC00006FCC0000000000005C5C5C0000000000000000006FCC00006FCC
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006FCC00006FCC00006FCC00006FCC0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000019191900241CED00241CED0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ABABAB0005050500000000000000000003030300A5A5A5000000
      0000000000000000000000000000000000003F3F3F0054545400000000006FCC
      00006FCC00006FCC00006FCC000000000000000000006FCC00006FCC00006FCC
      00006FCC00000000000000000000000000000000000000000000000000000000
      0000000000006FCC00006FCC00006FCC00006FCC00006FCC00006FCC00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000022222200241CED00241CED0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A9A9A900040404000000000004040400040404000000000004040400A9A9
      A9000000000000000000000000000000000050505000000000006FCC00006FCC
      00006FCC00006FCC00006FCC00006FCC0000000000006FCC00006FCC00006FCC
      00006FCC00006FCC000000000000000000000000000000000000000000000000
      000000000000000000006FCB00006FCC00006FCC000066BB0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000241CED00241CED00241CED00241CED00000000000000
      000000000000000000000000000000000000000000000000000000000000ABAB
      AB00050505000000000003030300A4A4A400ABABAB0004040400000000000303
      0300A5A5A5000000000000000000000000000000000000000000000000006FCB
      00006FCC00006FCC000066BB00000000000000000000000000006FCC00006FCC
      000066BB00000000000000000000000000000000000000000000000000000000
      00000000000000000000222222006FCC00006FCC000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000241CED00241CED00241CED00241CED00241CED00241CED000000
      0000000000000000000000000000000000000000000000000000AAAAAA000404
      04000000000004040400A9A9A9000000000000000000A9A9A900040404000000
      000004040400AAAAAA000000000000000000CCCCCC00AAAAAA00AAAAAA002222
      22006FCC00006FCC0000000000000000000000000000222222006FCC00006FCC
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000191919006FCC00006FCC000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000241CED00241CED00241CED00241CED00000000000000
      00000000000000000000000000000000000000000000000000004B4B4B000000
      000004040400A9A9A90000000000000000000000000000000000A9A9A9000404
      0400000000004C4C4C0000000000000000000000000000000000000000001919
      19006FCC00006FCC0000000000000000000000000000191919006FCC00006FCC
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000010101006FCC00006FCC000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000241CED00241CED0000000000000000000000
      0000000000000000000000000000000000000000000000000000EFEFEF004B4B
      4B00AAAAAA00000000000000000000000000000000000000000000000000AAAA
      AA004B4B4B00EFEFEF0000000000000000000000000000000000000000000101
      01006FCC00006FCC0000000000000000000000000000010101006FCC00006FCC
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E2E0FC00D1CFFB00E7E6FD00FDFD
      FF00F2F2FD00D4D2FB00D5D4FB00F6F5FE000000000000000000000000007B7D
      85006065710098969B00D0CFD200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006666660066666600666666007A7899000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F9E9E8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009C98F6003A33EF007C78F400ECEC
      FE00ACAAF8003B34EF005953F100DFDEFC000000000000000000000000006166
      7100245D7E003269850034354100C3C1C5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E0E0E000C6C6C600DBDB
      DB00EEEEEE00EEEEEE00EEEEEE00494686000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8E4E2000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DDDBFC006660F200443DF000A8A6
      F8005C56F2003D36F0009F9BF600F6F6FE000000000000000000000000009897
      9C003168850024A9E7001EA7E600218BBE002F32410000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8C8C800E0E0E000AAAA
      AA00E0E0E00000000000000000005C5B5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFAFF00AEABF800413AEF003F38
      EF002E27EE006963F300DBDAFD0000000000000000000000000000000000CFCE
      D100353640001EA7E6001EA7E6001EA7E600218BBE00C3C1C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FAEDEC000000000029292900DDDDDD00A3A3A3000000
      00000000000000000000000000005C5C5C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D4D3FB005A54F200241C
      ED003029EE009592F600F5F4FE00000000000000000000000000000000000000
      0000C3C2C500208ABE001EA7E6001EA7E6001EA7E60030344200BEBDC0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7B4AD000000000066666600F5F5F500DCDCDC000000
      000000000000FCFCFC00000000005C5C5C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F8F8FE00A5A2F8003A33EE004740
      F000352EEF006C67F300DFDEFD00000000000000000000000000000000000000
      0000000000002F334200208ABE001EA7E6001EA7E600208DC20030344200BEBD
      C000000000000000000000000000000000000000000000000000000000000000
      0000CECECE0078787800D1AC9B000000000066666600F5F5F500000000000000
      0000FCFCFC0000000000000000005C5C5C000000000000000000000000000000
      0000000000000000000000000000000000008A8A8A00E6E6E600898989000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006666660066666600666666007A789900615BF200362FEE00ABA8
      F8007974F300433CF000A29FF800F8F8FF000000000000000000000000000000
      00000000000055545700282C3B00208ABE001EA7E6001EA7E600208DC2003034
      4200BEBDC00000000000000000000000000000000000F5F5F500A4A4A400FEFE
      FE003D3D3D0000000000A5A09900D1AC9B0066666600F5F5F500000000000000
      00009D9D9D004B4B4B003F3F3F00545454000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E0E0E000C6C6
      C600DBDBDB00EEEEEE00EEEEEE00EEEEEE00494686005D57F2007D79F400E9E8
      FE00D2D1FB006963F200817CF500E8E8FD000000000000000000E0E0E000C6C6
      C600DBDBDB00EEEEEE00EEEEEE00B7B6B900282C3B001EA7E6001EA7E6001EA7
      E600208DC20030344200000000000000000000000000A2A2A200000000001F1F
      1F0000000000000000000E0E0E001313130066666600F5F5F500000000000000
      00008E8E8E00ACACAC0050505000ECECEC000000000000000000E0E0E000C6C6
      C600DBDBDB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C8C8C800E0E0
      E000AAAAAA00E0E0E00000000000000000005C5B5F00F8F8FF00FAFAFE00FEFE
      FF00FEFEFF00F9F9FF00F9F9FE00FEFEFF000000000000000000C8C8C800E0E0
      E000AAAAAA00E0E0E00000000000000000004D4C4F00208ABE001EA7E6001EA7
      E6001EA7E600208DC200BEBDC0000000000000000000C3C3C300020202000000
      0000010101001212120003030300000000006666660000000000000000000000
      0000000000003B3B3B00EEEEEE00000000000000000000000000C8C8C800E0E0
      E000AAAAAA000000000000000000000000005D5C5C0000000000000000000000
      0000000000000000000000000000000000000000000029292900DDDDDD00A3A3
      A300000000000000000000000000000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000029292900DDDDDD00A3A3
      A300000000000000000000000000000000005C5C5C002F334200208ABE001EA7
      E6001EA7E60067BBEE002A2C4100BEBDC000C1C1C10065656500000000000707
      0700B1B1B10000000000D9D9D90002020200CCCCCC00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00EEEEEE0000000000000000000000000029292900DDDDDD00A3A3
      A300000000000000000000000000000000005D5C5C0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F500DCDC
      DC000000000000000000FCFCFC00000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F500DCDC
      DC000000000000000000FCFCFC00000000005C5C5C00C3C1C5002F324100218B
      BE0067BBEE006988F000252D5B006F717E000000000000000000000000005050
      50000000000085858500000000000505050000000000000000007E6F6E00F6DE
      DC00F9E8E700FEFBFB0000000000000000000000000066666600F5F5F500DCDC
      DC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      000000000000FCFCFC0000000000000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      000000000000FCFCFC0000000000000000005C5C5C000000000000000000C3C1
      C5002A2B4000252D5B00FCFCFD0000000000CDCDCD0073737300000000002525
      2500F7F7F700A8A8A8005C5C5C00000000000000000045454500E2E2E2000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      000000000000FCFCFC0000000000000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000009D9D9D004B4B4B003F3F3F005454540000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000009D9D9D004B4B4B003F3F3F005454540000000000000000000000
      0000C3C1C50070727E00000000000000000000000000EDEDED00000000000000
      0000252525004E4E4E00060606000000000021212100FEFEFE00000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000009D9D9D004B4B4B003F3F3F005454540000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000008E8E8E00ACACAC0050505000ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000008E8E8E00ACACAC0050505000ECECEC0000000000000000000000
      00000000000000000000000000000000000000000000C4C4C400010101000101
      01000303030000000000000000000303030000000000A2A2A200000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000008E8E8E00ACACAC0050505000ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      000000000000000000003B3B3B00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      000000000000000000003B3B3B00EEEEEE000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00CDCDCD00EAEA
      EA008B8B8B00000000006C6C6C00C3C3C300AFAFAF00F7F7F700000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      000000000000000000003B3B3B00EEEEEE000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00EEEEEE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00EEEEEE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F1F10003030300CDCDCD00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00EEEEEE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECEEEE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7D
      85006065710098969B00D0CFD200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFE00DF8D8700CE4F4700DB7E
      7800F9E9E8000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004F484100798E9700DDE8
      EE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006166
      7100245D7E003269850034354100C3C1C5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFE00DC807B00CD4C4400D972
      6C00F8E4E2000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      660066666600666666008A8A8A000000000000000000D0D7DA0083C8ED0078B7
      D90074B0C900F9FBFC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009897
      9C003168850024A9E7001EA7E600218BBE002F32410000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFEFE00DC807B00CD4C4400D972
      6C00F8E4E2000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0E0E000C6C6C600DBDBDB00EEEE
      EE00EEEEEE00EEEEEE005A5A5A000000000000000000000000007AB8DA006DBB
      DA0095E2F40076B8CF00FCFDFE00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CFCE
      D100353640001EA7E6001EA7E6001EA7E600218BBE00C3C1C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBF1F000F5DDDB00F4D9D700F4D8D600D9756F00CD4B4300D569
      6200EFC4C100F4D9D700F4D9D800FBF0EF000000000000000000000000000000
      000000000000000000000000000000000000C8C8C800E0E0E000AAAAAA00E0E0
      E00000000000000000005C5C5C00000000000000000000000000E8F2F60096E1
      F500A3EEFF009BE7F90095CCDF00FCFDFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C3C2C500208ABE001EA7E6001EA7E6001EA7E60030344200BEBDC0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBB7B300D0574F00CC483F00CC483F00CC483F00CC483F00CC48
      3F00CC483F00CC483F00CD4A4100EAB3B0000000000000000000000000000000
      000000000000000000000000000029292900DDDDDD00A3A3A300000000000000
      000000000000000000005C5C5C0000000000000000000000000000000000F1F8
      FA009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE00292D3C00208ABE001EA7E6001EA7E600208DC20030344200BEBD
      C000000000000000000000000000000000000000000000000000000000000000
      000000000000ECBBB700D4665E00D0584F00D0584F00CE4D4400CC494000CD4C
      4300D0564D00D0584F00D1595100EBB9B6000000000000000000000000000000
      000000000000000000000000000066666600F5F5F500DCDCDC00000000000000
      0000FCFCFC00000000005C5C5C00000000000000000000000000000000000000
      0000FDFEFE009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE00000000000000
      00000000000000000000000000000000000000000000F5F5F500A4A4A400FEFE
      FE003D3D3D000B0A0D002B2F3E00208ABE001EA7E6001EA7E600208DC2003034
      4200BEBDC0000000000000000000000000000000000000000000000000000000
      00000000000071626100825E5C00845D5A009D767400D7706900CC4B4200D465
      5E00ECB7B300F0C9C600F1CBC800F8E9E7000000000000000000000000000000
      000000000000666666006666660066666600F5F5F5000000000000000000FCFC
      FC0000000000000000005C5C5C00000000000000000000000000000000000000
      000000000000FAFCFD009DE6F900A3EEFF009CE7F90095CCDF00FCFDFE000000
      00000000000000000000000000000000000000000000A2A2A200000000001F1F
      1F0000000000000000000E0E0E0019181B002F3342001EA7E6001EA7E6001EA7
      E600208DC2003034420000000000000000000000000000000000E0E0E000C6C6
      C600DBDBDB00EEEEEE00EEEEEE00EEEEEE005B5A5A00DC807B00CD4C4400D972
      6C00F8E4E2000000000000000000000000000000000000000000E0E0E000C6C6
      C600DBDBDB00EEEEEE000000000066666600F5F5F50000000000000000009D9D
      9D004B4B4B003F3F3F0054545400000000000000000000000000000000000000
      00000000000000000000F7FBFC009DE6F900A3EEFF009CE7F90095CCDF00FCFD
      FE000000000000000000000000000000000000000000C3C3C300020202000000
      00000101010012121200030303000000000019181B00208ABE001EA7E6001EA7
      E6001EA7E600208DC200BEBDC000000000000000000000000000C8C8C800E0E0
      E000AAAAAA00E0E0E00000000000000000005D5C5C00DC817B00CE4D4400D872
      6B00F8E5E3000000000000000000000000000000000000000000C8C8C800E0E0
      E000AAAAAA00E0E0E0000000000066666600F5F5F50000000000000000008E8E
      8E00ACACAC0050505000ECECEC00000000000000000000000000000000000000
      0000000000000000000000000000FAFCFD009DE6F900A3EEFF009CE7F90096CC
      DF00FCFDFE00000000000000000000000000C1C1C10065656500000000000707
      0700B1B1B10000000000D9D9D900020202000F0F0F002B2F3E00208ABE001EA7
      E6001EA7E60067BBEE002A2C4100BEBDC0000000000029292900DDDDDD00A3A3
      A300000000000000000000000000000000005D5C5C00E2959000D3605800DE87
      8100F9E9E8000000000000000000000000000000000029292900DDDDDD00A3A3
      A300000000000000000000000000666666000000000000000000000000000000
      00003B3B3B00EEEEEE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFEFE009DE6F900A3EEFF009CE7
      F90096C9DA00FAFBFC0000000000000000000000000000000000000000005050
      500000000000000000000000000005050500000000000C0A0E00292C3B00218B
      BE0067BBEE006988F000252D5B006F717E000000000066666600F5F5F500DCDC
      DC000000000000000000FCFCFC00000000005C5C5C00F7E2E100F2D1CF00F6DF
      DD00FEFAFA000000000000000000000000000000000066666600F5F5F500DCDC
      DC00000000000000000000000000CCCCCC00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00EEEEEE000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FAFDFE009DE6F900A2E8
      F700B0B4AC00C3BCB300FAFAFC0000000000CDCDCD0073737300000000002525
      2500F7F7F70000000000B0B0B000000000000000000045454500E2E2E200C3C1
      C5002A2B4000252D5B00FCFCFD00000000000000000066666600F5F5F5000000
      000000000000FCFCFC0000000000000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      000000000000FCFCFC0000000000000000005C5C5C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0F7F900AFB3
      AB00F3E5D700EBDDCF00A297AF00FEFEFF0000000000EDEDED00000000000000
      0000252525004E4E4E00060606000000000021212100FEFEFE00000000000000
      0000C3C1C50070727E0000000000000000000000000066666600F5F5F5000000
      0000000000009D9D9D004B4B4B003F3F3F005454540000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000009D9D9D004B4B4B003F3F3F005454540000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F8F7
      F600ECDED000B7AAB2008A88E800BEBEED0000000000C4C4C400010101000101
      01000303030000000000000000000303030000000000A2A2A200000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000008E8E8E00ACACAC0050505000ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000066666600F5F5F5000000
      0000000000008E8E8E00ACACAC0050505000ECECEC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0EEF2008B8AE8008080E900D3D3F30000000000FBFBFB00CDCDCD00EAEA
      EA008B8B8B00000000006C6C6C00C3C3C300AFAFAF00F7F7F700000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      000000000000000000003B3B3B00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      000000000000000000003B3B3B00EEEEEE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F8F8FD00D2D2F300000000000000000000000000000000000000
      0000F1F1F10003030300CDCDCD00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00EEEEEE00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00EEEEEE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008D8D8D005555
      5500555555005555550055555500555555005555550055555500555555005555
      5500555555008F8F8F00000000000000000000000000000000008D8D8D005555
      5500555555005555550055555500555555005555550055555500555555005555
      5500555555008F8F8F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008D8D8D005555
      5500555555005555550055555500555555005555550055555500555555005555
      5500555555008F8F8F00000000000000000000000000000000001A1A1A003939
      3900393939003939390039393900393939003939390039393900393939003939
      3900393939001A1A1A00000000000000000000000000000000001A1A1A003939
      3900393939003939390039393900393939003939390039393900393939003939
      3900393939001A1A1A0000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001A1A1A003939
      3900393939003939390039393900393939003939390039393900393939003939
      3900393939001A1A1A000000000000000000000000000000000039393900EBEB
      EB00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00EBEBEB00393939000000000000000000000000000000000039393900EBEB
      EB00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00EBEBEB003939390000000000000000000000000000000000000000000000
      0000008000000080000080000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000039393900EBEB
      EB00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00EBEBEB00393939000000000000000000000000000000000039393900AAAA
      AA004C4C4C00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA004C4C
      4C00AAAAAA00393939000000000000000000000000000000000039393900AAAA
      AA004C4C4C00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA004C4C
      4C00AAAAAA003939390000000000000000000000000000000000800000000080
      0000008000000080000000800000008000008000000000000000000000000000
      000000000000000000000000000000000000000000000000000039393900AAAA
      AA004C4C4C00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA004C4C
      4C00AAAAAA00393939000000000000000000000000000000000039393900AAAA
      AA00717171000000000000000000B5B5B500B5B5B50000000000000000007171
      7100AAAAAA00393939000000000000000000000000000000000039393900AAAA
      AA00717171000000000000000000B5B5B500B5B5B50000000000000000007171
      7100AAAAAA003939390000000000000000000000000080000000008000000080
      000000FF00000080000000800000008000000080000080000000000000000000
      000000000000000000000000000000000000000000000000000039393900AAAA
      AA007171710000000000B5B5B500B5B5B500B5B5B500B5B5B500000000007171
      7100AAAAAA00393939000000000000000000000000000000000039393900AAAA
      AA007171710000000000CACACA001A1A1A0019191900C5C5C500000000007171
      7100AAAAAA0039393900000000000000000000000000E4E3FD0036355300A4A4
      AD007171710000000000C5C5CB001B1A37001B1A3E00C0C0C600000000007171
      7100AAAAAA003939390000000000000000000000000000800000008000000080
      00000000000000FF000000800000008000000080000080000000000000000000
      000000000000000000000000000000000000000000000000000039393900AAAA
      AA0033333300B5B5B50000000000000000000000000000000000B5B5B5003333
      3300AAAAAA00393939000000000000000000A4A4A4000000000039393900AAAA
      AA0071717100DCDCDC001A1A1A00848484008C8C8C001A1A1A00D8D8D8007171
      7100AAAAAA003939390000000000A5A5A500A4A4A400171298002923C5008A88
      BA0071717100DCDCDC001B1A40003B35D5002F27E4001C1B3B00D8D8D8007171
      7100AAAAAA003939390000000000A5A5A5000000000000FF00000080000000FF
      0000000000000000000000FF0000008000000080000000800000800000000000
      000000000000000000000000000000000000A4A4A4000000000039393900AAAA
      AA0033333300B5B5B5008989890072727200727272008A8A8A00B5B5B5003333
      3300AAAAAA003939390000000000A5A5A5007171710072727200CECECE00AAAA
      AA00717171002121210069696900000000000000000069696900222222007171
      7100AAAAAA00CECECE00727272007171710071717100504DA6003E38E8007874
      C3006C6C790021212E00514E98003F39F0006963F30062617700222222007171
      7100AAAAAA00CECECE007272720071717100000000000000000000FF00000000
      000000000000000000000000000000FF00000080000000800000008000008000
      0000000000000000000000000000000000007171710072727200CECECE00AAAA
      AA00B5B5B500B5B5B50071717100AAAAAA00AAAAAA0071717100B5B5B500B5B5
      B500AAAAAA00CECECE007272720071717100A4A4A400333333004B4B4B003333
      3300A4A4A4004B4B4B0024242400B3B3B300B2B2B200242424004B4B4B00A4A4
      A400333333004B4B4B0033333300A4A4A400A4A4A400302E5C002C25CF002721
      C100544FD100332EB000241DBE002B24EA007C79C90024242C004B4B4B00A4A4
      A400333333004B4B4B0033333300A4A4A4000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000000080
      000000000000000000000000000000000000A4A4A400333333004B4B4B003333
      3300333333003333330071717100AAAAAA00AAAAAA0033333300333333003333
      3300333333004B4B4B0033333300A4A4A4000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      00000000000000000000000000000000000000000000E9E8FD00706BF3002B24
      ED00453EF000463FF000271FE9003B34E2009290B60071717200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      00000000000000000000000000000000000000000000F8F8FF009C98F7003D36
      F000C4C2FA00C8C6FA00302ADA005954D3009E9EB00071717100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000080
      0000008000008000000000000000000000000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      0000000000000000000000000000000000000000000000000000C9C7FA004D47
      F1008682F500908CF6002E28DE007875C300A8A8AA0071717100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080000000000000000000000000000000000000000000
      0000A4A4A4004B4B4B0024242400B3B3B300B2B2B200242424004B4B4B00A4A4
      A400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100AAAAAA00AAAAAA0071717100000000000000
      0000000000000000000000000000000000000000000000000000EAEAFD00706B
      F400514BF1005953F1003630CF008D8BB800AAAAAA0071717100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000080000000800000000000000000000000000000000000000000
      0000000000002121210069696900000000000000000069696900222222000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008989890072727200727272008A8A8A00000000000000
      0000000000000000000000000000000000000000000000000000FDFDFF00A09C
      F7003831EF002E27ED004C47C6006A6A7D00727272008A8A8A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000000000000000000000000000000000000000000000
      000000000000DCDCDC001A1A1A00848484008C8C8C001A1A1A00D8D8D8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBEB00AAAAAA00AAAAAA00EBEBEB00000000000000
      000000000000000000000000000000000000000000000000000000000000D7D6
      FC00726DF4006761F300ACAAEC00A8A8AC00AAAAAA00EBEBEB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CACACA001A1A1A0019191900C5C5C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B5B2F9007873F3007670F400D4D3FB00FAFA
      FF00C4C2FA007A75F400716BF300B3B0F9000000000000000000000000000000
      00000000000000000000000000000000000000000000C2C2C20022222200B9B9
      B900666666003B3B3B00F6F6F600000000000000000000000000BEBEBE00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C7C5FB005049F0002820ED007974F500CDCB
      FA00706BF3002B23ED003F38EE00C6C5FA000000000000000000000000000000
      000000000000000000000000000000000000F3F3F300B1B1B100000000000000
      00000000000009090900F6F6F600EFEFEF00000000000000000053535300BBBB
      BB00BBBBBB00BBBBBB00BBBBBB00BBBBBB00B4B4B40066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5F4FE009B98F7003830EE002B23ED007570
      F3003730EF003029EE00A09CF600F4F3FE000000000000000000000000000000
      0000000000000000000000000000E9E9E9000707070008080800000000001010
      10000A0A0A0000000000040404003B3B3B0000000000000000005C5C5C000000
      000000000000000000000000000000000000F5F5F50066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E0DFFC006A65F2002820EE002B23
      ED002720ED006B65F300E6E5FD00000000000000000000000000000000000000
      0000000000000000000000000000E9E9E900363636000000000038383800FAFA
      FA00E1E1E1000A0A0A00000000007777770000000000000000005C5C5C000000
      000000000000000000000000000000000000F5F5F50066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFEFFE007E7AF4002921EE002820
      EE002B23EE008C88F500F3F3FE00000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB0071717100000000005B5B5B000000
      0000F9F9F9001515150000000000ADADAD0000000000000000005C5C5C000000
      000000000000FCFCFC000000000000000000F5F5F50066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CECECE0078787800E8E8E800F3F3F600C6C4FB00524BF100251DED004C45
      F100312AEE00514BF000D0CEFB00FCFCFE000000000000000000000000000000
      0000A7A7A70077777700E6E6E600D7D7D7000000000000000000020202005A5A
      5A003A3A3A0000000000000000001F1F1F0000000000000000005C5C5C000000
      0000FCFCFC0053535300E0E0E000DCDCDC00F5F5F50066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5F5F500A4A4A400FEFE
      FE003D3D3D0000000000A6A6A600D3D2E7007772F4002B23EE003A32EF00ADAA
      F800645EF3002921ED00726DF300E2E1FC0000000000E3E3E300A1A1A100FEFE
      FE003434340000000000A6A6A600E6E6E6004848480086868600000000000000
      00000000000004040400B8B8B800C7C7C70000000000000000005C5C5C000000
      000000000000E0E0E0000F0F0F00A3A3A300DFDFDF0029292900666666006666
      6600666666008A8A8A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A2A2A200000000001F1F
      1F0000000000000000000E0E0E0018155400534DF1003A33EF008B87F500E7E6
      FD00AAA7F8004B45F000433CEF00B1AEF800000000002E2E2E00000000001F1F
      1F0000000000000000000E0E0E0013131300000000004E4E4E00000000006767
      67004040400006060600EAEAEA000000000000000000000000005C5C5C000000
      000000000000E0E0E000AAAAAA00E0E0E000C6C6C600DBDBDB00EEEEEE00EEEE
      EE00EEEEEE005A5A5A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3C3C300020202000000
      00000101010012121200030303000504200017154A00B4B1EA00DAD9F000FCFC
      FF00EFEEFE00CDCBFB00C5C2FA00DEDDFD000000000089898900000000000000
      00000000000000000000000000000000000013131300E7E7E700D5D5D500FAFA
      FA00EAEAEA00E8E8E800000000000000000000000000000000005A5A5A00EEEE
      EE00EEEEEE00EEEEEE00DEDEDE00C8C8C800E0E0E000AAAAAA00E0E0E0000000
      0000000000005C5C5C0000000000000000000000000000000000000000000000
      0000000000000000000055555500555555005555550055555500000000000000
      000000000000000000000000000000000000C1C1C10065656500000000000707
      0700B1B1B10000000000D9D9D900020202000F0F0F00A6A6A600E6E6E6000000
      000000000000000000000000000000000000BFBFBF0063636300000000000707
      0700ADADAD00DEDEDE0055555500000000000F0F0F00A6A6A600E4E4E4000000
      00000000000000000000000000000000000000000000000000008A8A8A006666
      6600666666006666660029292900DDDDDD00A3A3A3000F0F0F00E0E0E0000000
      0000000000005C5C5C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005050
      5000000000000000000000000000050505000000000000000000747474000000
      0000000000000000000000000000000000000000000000000000000000005050
      50000000000000000000DDDDDD00000000000000000000000000717171000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600F5F5F500DCDCDC00E0E0E00053535300FCFC
      FC00000000005C5C5C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDCDCD0073737300000000002525
      2500F7F7F70000000000B0B0B000000000000000000045454500E2E2E2000000
      0000000000000000000000000000000000005454540018181800000000002525
      2500F7F7F70000000000AAAAAA00000000000000000035353500A8A8A8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600F5F5F5000000000000000000FCFCFC000000
      0000000000005C5C5C0000000000000000000000000000000000121212003E3E
      3E00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA003E3E3E0012121200000000000000000000000000EDEDED00000000000000
      0000252525004E4E4E00060606000000000021212100FEFEFE00000000000000
      00000000000000000000000000000000000000000000ACACAC00000000000000
      0000252525004E4E4E00060606000000000021212100FEFEFE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600F5F5F50000000000000000009D9D9D004B4B
      4B003F3F3F005454540000000000000000000000000000000000939393000707
      0700A0A0A000AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00A0A0
      A0000707070093939300000000000000000000000000C4C4C400010101000101
      01000303030000000000000000000303030000000000A2A2A200000000000000
      0000000000000000000000000000000000000000000030303000000000000000
      00000000000000000000000000000000000000000000A0A0A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600F5F5F50000000000000000008E8E8E00ACAC
      AC0050505000ECECEC0000000000000000000000000000000000FCFCFC002D2D
      2D00000000000000000000000000000000000000000000000000000000000000
      00002A2A2A00FAFAFA00000000000000000000000000FBFBFB00CDCDCD00EAEA
      EA008B8B8B00000000006C6C6C00C3C3C300AFAFAF00F7F7F700000000000000
      000000000000000000000000000000000000000000009696960032323200ADAD
      AD001717170000000000666666008A8A8A002F2F2F00E3E3E300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600B4B4B400BBBBBB00BBBBBB00686868003B3B
      3B00EEEEEE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F1F10003030300CDCDCD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005050500000000000C4C4C400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CCCCCC00AAAAAA00AAAAAA00AAAAAA00AAAAAA00EEEE
      EE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009936
      2F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFDFD00DE898300CE4E
      4600DB7C7600F9E8E70000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099362F00241C
      ED0099362F000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFDFD00DC807A00CD4C
      4400D8736C00F8E5E30000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000008080000080
      8000000000000000000000000000000000000000000099362F00241CED00241C
      ED00241CED0099362F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFDFD00DC807A00CD4C
      4400D8736C00F8E5E30000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000008080000080
      80000000000000000000000000000000000099362F00241CED00241CED00241C
      ED00241CED00241CED0099362F00000000000000000000000000000000000000
      00000000000000000000FAEDEC00F3D5D300F2D1CF00F2D0CE00D8726C00CD4C
      4300D5686100EDBEBB00F2D1CF00F3D2D0000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000008080000080
      800000000000000000000000000099362F00241CED00241CED00241CED00241C
      ED00241CED00241CED00241CED0099362F000000000000000000000000000000
      00000000000000000000E7B4AD00D0574F00CC483F00CC483F00CC483F00CC48
      3F00CC483F00CC483F00CC483F00CD4A41000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF0080000000800000008000000080000000800000008000
      00008000000080000000FFFFFF00800000000000000000000000008080000080
      8000000000000000000099362F0099362F0099362F0099362F00241CED00241C
      ED00241CED0099362F0099362F0099362F000000000000000000000000000000
      0000CECECE0078787800D1AC9B00D66C6500D35F5700D35F5700CE4F4700CC49
      4000CD4D4400D15B5300D35F5700D36058000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF0080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000008080000080
      8000008080000080800000808000008080000080800099362F00241CED00241C
      ED00241CED0099362F00000000000000000000000000F5F5F500A4A4A400FEFE
      FE003D3D3D0000000000A5A09900F6DFDE00F5DDDB00F5DBD900D8756F00CD4B
      4300D66B6400F0C7C400F5DDDB00F6DDDC000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000008000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000099362F00241CED00241C
      ED00241CED0099362F00000000000000000000000000A2A2A200000000001F1F
      1F0000000000000000000E0E0E001313130000000000FEFDFD00DC807A00CD4C
      4400D8736C00F8E5E30000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00099362F00241CED00241C
      ED00241CED0099362F00000000000000000000000000C3C3C300020202000000
      00000101010012121200030303000000000013131300E6E5E500DC807B00CD4C
      4300D9746E00F8E5E40000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000080000000FFFFFF008000
      000080000000800000008000000080000000800000008000000080000000FFFF
      FF00800000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00099362F00241CED00241C
      ED00241CED0099362F000000000000000000C1C1C10065656500000000000707
      0700B1B1B10000000000D9D9D900020202000F0F0F00A7A6A600CA887600D465
      5D00DF8D8700FAECEB0000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000080000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00099362F00241CED00241C
      ED00241CED0099362F0000000000000000000000000000000000000000005050
      50000000000000000000000000000505050000000000000000007E6F6E00F6DE
      DC00F9E8E700FEFBFB0000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00800000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00099362F00241CED00241C
      ED00241CED0099362F000000000000000000CDCDCD0073737300000000002525
      2500F7F7F70000000000B0B0B000000000000000000045454500E2E2E2000000
      0000000000000000000000000000000000000000000080000000800000008000
      00008000000080000000FFFFFF00800000008000000080000000800000008000
      0000FFFFFF008000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00099362F0099362F009936
      2F0099362F0099362F00000000000000000000000000EDEDED00000000000000
      0000252525004E4E4E00060606000000000021212100FEFEFE00000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000080000000800000008000
      00008000000080000000800000008000000080000000FFFFFF00800000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000000000000000000000000000C4C4C400010101000101
      01000303030000000000000000000303030000000000A2A2A200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00CDCDCD00EAEA
      EA008B8B8B00000000006C6C6C00C3C3C300AFAFAF00F7F7F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F1F10003030300CDCDCD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000C0C0C0008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080000000C0C0
      C000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C0000000000000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000C0C0C0008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080000000C0C0C000800000008000
      000080000000000000000000000000000000000000000000000080808000C0C0
      C000FFFFFF008080800000000000800000000000000000000000000000000000
      00000000800000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C00000FFFF0000FFFF0000FFFF00C0C0C000C0C0
      C000000000000000000000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000FFFFFF008080800080000000800000008000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C000C0C0C000FFFFFF0080808000000000000000000000000000000000000000
      80000000800000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000808080008080800080808000C0C0C000C0C0
      C00000000000C0C0C00000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000000000000000000000000000000000000080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF0080808000000000000000
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFFFFF00000000000000000000000000000080000000
      8000000080000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000C0C0C000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF008000000000000000000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFFFF00000000000000
      00000000000000000000000000000000000000000000C0C0C000FFFFFF00FFFF
      0000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      80000000800000000000000000000000800000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000C0C0C00000000000C0C0C000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      00008000000080000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00C0C0C000C0C0C00080808000000000000000000000000000000000000000
      0000000080000000000000000000000080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C00000000000C0C0C00000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C000C0C0C0008080800000000000000000000000000000000000000000000000
      000000000000000000000000000000008000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C0C0C00000000000C0C0C000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080000000000000000000000000000000C0C0C000FFFFFF00FFFF
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000080000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080000000000000000000000000000000C0C0C000FFFFFF00FFFF
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFF0000FFFF0000C0C0C000C0C0C000C0C0C000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000000000000
      0000000080000000800000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF00800000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0C00080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      8000000080000000800000008000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      80000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C000FFFF00008080
      80008080800000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      80000080800000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000C0C0C00000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      00000080800000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000C0C0C000FFFF0000C0C0C000C0C0C0008080
      8000C0C0C00000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000080808000FFFF0000FFFF0000C0C0C0008080
      80008080800000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF0000000000C0C0C00000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000C0C0C000C0C0C0008080
      80000000000000000000000000000000000000000000FFFFFF0000000000C0C0
      C00000000000FFFFFF0000000000C0C0C00000000000C0C0C000000000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000000000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0
      C000C0C0C0000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000008000000080000000800000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000808000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080000000800000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000008000000080000000800000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080000000800000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000000000000000
      0000000000008000000080000000800000000000000000000000008080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C00000000000C0C0C000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008080000080800000808000008080000080800000808000008080000080
      8000008080000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000000000000080000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000000000000000000000000000000000000000000000000000800000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000000000000000000000000000000000008000000080000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000800000000000000000000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000800000000000000080000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000080808000008080008080
      8000008080008080800080000000FFFFFF000000000000000000000000000000
      00000000000000000000FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000800000000000000080000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00800000000000000000808000808080000080
      8000808080000080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000000080000000800000000000000080000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000080808000008080008080
      8000008080008080800080000000FFFFFF00000000000000000000000000FFFF
      FF00800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000080000000800000008000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF0000000000000000000000
      00000000000000000000FFFFFF00800000000000000000808000808080000080
      8000808080000080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080000000FFFFFF0080000000000000000000000000000000800000008000
      0000800000008000000080000000000000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800000000000000080000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00800000000000000080808000008080008080
      8000008080008080800080000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000008000000000000000000000000000000000000000800000008000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF000000000000000000FFFF
      FF00800000008000000080000000800000000000000000808000808080000080
      8000808080000080800080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080000000FFFFFF0080000000000000000000000080808000008080008080
      8000008080008080800000808000808080000080800080808000008080008080
      8000008080000000000000000000000000000000000000000000800000008000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00800000008000000000000000000000000000000000808000808080000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000000000000000000000000000800000000000
      0000000000000000000080000000800000000000000000000000000000000000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000080808000808080000000
      0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000008080
      8000008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000000080000000800000008000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000808000808080000080
      80000000000000FFFF00000000000000000000FFFF0000000000808080000080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF00000000FFFFF81F00000000
      FFFFE00700000000F81FC00300000000FE7FC00300000000C243800100000000
      800180010000000080018001000000008001800100000000C243800100000000
      C003C00100000000E007C00300000000E007E00300000000FE7FF00700000000
      FFFFFC1F00000000FFFFFFFF00000000C003C003BFFFFFFFC003C0038FFF8001
      C003C00383FF9FF900030003C1FF9C390A000A00C0FFE00706010601E07FE007
      1E031E03F03FE0071AFF1ACFF81FE00736FF3687C003C18330FF3003C003C003
      30FF3001C003C00301FF0000C001E00703FF03870000E007FFFFFF878000E007
      FFFFFF87C000FC2FFFFFFF87FFF9FE7FC003C003C003C003C003C003C003C003
      C003C003C003C003C003C003C00300030000000000000A008001800180010601
      C003C003C0031E03FE7FFC3FF00F12CFFC3FFC3FF81F2087F81FFC3FF81F0003
      F00FFC3FF00F0001E007E007E0070000FC3FF00FC1830187FC3FF81FC3C3E187
      FC3FFC3FC7E3E187FC3FFE7FFFFFE187FF00E1FFFF00FFF7FF00E0FFFF00FFF7
      FF00E07FFF06F803FF01E03FFD1EF8E3FF81F01FFD1AF8E3FF01F80FF136F803
      8000800780308003800080038030800383008301800183638F7F8F0004038B63
      8D7F8D00080388079B7F9B61001F9B7F987F9873803F987F987F987F803F987F
      80FF80FF803F80FF81FF81FFF1FF81FFBFFFE1FFFF07FFFF8FFFE0FFFF07FE01
      83FFE07FFF07FE01C1FFE03FF800FE0DC0FFF01FF800FE3DE07FF00FF800FE35
      F03F80078000806DF81F800380078261FC0F800183078261FE0704008F078E03
      FF030E008D078E07FF8104019B7F9B7FFFC08033987F987FFFE0803F987F987F
      FFF0803F80FF80FFFFF9F1FF81FF81FFFFFFFFFFFFFFFFFFC003C003FFFFC003
      C003C003F3FFC003C003C003F1FFC003C003C003C07FC003C663C663803FC423
      C4238423883FC3C3000000008C1F000001800000DE0F000000000000FF0F0000
      FC3F803FFF87FC3FFC3F803FFFC3FC3FFC3FC03FFFF1F00FFC3FC03FFFF1F99F
      FC3FC03FFFFBF81FFC3FE03FFFFFFC3FFE00FF81C03FFFFFFE00FF00C03FFFFF
      FE00FE00DF3FC003FF01FE00DF3FC003FF01FE10DB3FC003F000F000D03FC003
      80008000D803C00380008001D803C00380008003C01BC003041F001FC01BC3C3
      0E1F0C1FFC0BC003041F041FFCDBC003803F803FFCC3C003803F803FFCC3C003
      803F803FFC07FFFFF1FFF1FFFC0FFFFFFFFFFC00FFEFFF838003FC00C001FF83
      8003FC008001FF838003FC008001FC008003E0008000FC008003E0008000F000
      8003E000800180008003E0078001808380038007800180038003800780010403
      8003800780010E038003801F8001041F8003801F8001803F8003801F8001803F
      FFFF801F8001803FFFFFFFFFFFFFF1FFFFF3FFFFFFFFFFFFFFE1FF3FC0078003
      FFC1FE3F80038003FF83C07F00018003F00780F700018003C00F00E700018003
      801F00C100008003801F00E600008003000F00F680008003000F81FEC0008003
      000FC3BFE0018003000FFFB7E0078003801FFFB3F0078003801FFFC1F0038003
      C03FFFF3F803FFFFF0FFFFF7FFFFFFFFFFFFFFFFFFFFFFFFC001000C000FF9FF
      80010008000FF9FF80010001000FF3C780010003000F73C780010003000F27FF
      80010003000F07C780010003000F00C780010003000F01E380010007000403F1
      8001000F000006388001000F00000E388001000FF8001E388001001FFC003F01
      8001003FFE047F83FFFF007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFEFFDC007001FFFFFC7FFC007000FFFFFC3FBC0070007EFFFE3F7C0070003
      EF83F1E7C0070001DFC3F8CFC0070000DFE3FC1FC007001FDFD3FE3FC007001F
      EF3BFC1FC007001FF0FFF8CFC0078FF1FFFFE1E7C00FFFF9FFFFC3F3C01FFF75
      FFFFC7FDC03FFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFC00FFFF
      F6CFFE008000FFFFF6B7FE000000FFFFF6B7FE000000FFFFF8B780000000FFF7
      FE8F80000001C1F7FE3F80000003C3FBFF7F80000003C7FBFE3F80010003CBFB
      FEBF80030003DCF7FC9F80070003FF0FFDDF807F0003FFFFFDDF80FF8007FFFF
      FDDF81FFF87FFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object dlgFileSave: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Text files (*.txt)|*.txt'
    Title = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1092#1072#1081#1083#1072
    Left = 784
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 496
  end
end
