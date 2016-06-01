inherited fFramePoundQuery: TfFramePoundQuery
  Width = 976
  Height = 582
  inherited ToolBar1: TToolBar
    Width = 976
    inherited BtnAdd: TToolButton
      Visible = False
    end
    inherited BtnEdit: TToolButton
      Visible = False
      OnClick = BtnEditClick
    end
    inherited BtnDel: TToolButton
      OnClick = BtnDelClick
    end
    inherited S1: TToolButton
      Visible = False
    end
  end
  inherited cxGrid1: TcxGrid
    Top = 205
    Width = 976
    Height = 377
    inherited cxView1: TcxGridDBTableView
      PopupMenu = PMenu1
    end
  end
  inherited dxLayout1: TdxLayoutControl
    Width = 976
    Height = 138
    object cxTextEdit1: TcxTextEdit [0]
      Left = 269
      Top = 94
      Hint = 'T.P_Truck'
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 6
      Width = 125
    end
    object EditTruck: TcxButtonEdit [1]
      Left = 269
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditTruckPropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      TabOrder = 1
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    object EditCus: TcxButtonEdit [2]
      Left = 457
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditTruckPropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      TabOrder = 2
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    object cxTextEdit2: TcxTextEdit [3]
      Left = 81
      Top = 94
      Hint = 'T.P_ID'
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 5
      Width = 125
    end
    object cxTextEdit3: TcxTextEdit [4]
      Left = 457
      Top = 94
      Hint = 'T.P_PDate'
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 7
      Width = 125
    end
    object EditDate: TcxButtonEdit [5]
      Left = 645
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = EditDatePropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      TabOrder = 3
      Width = 185
    end
    object cxTextEdit4: TcxTextEdit [6]
      Left = 645
      Top = 94
      Hint = 'T.P_MDate'
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 8
      Width = 125
    end
    object Check1: TcxCheckBox [7]
      Left = 835
      Top = 36
      Caption = #26597#35810#24050#21024#38500
      ParentFont = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      TabOrder = 4
      Transparent = True
      OnClick = Check1Click
      Width = 110
    end
    object EditPID: TcxButtonEdit [8]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditTruckPropertiesButtonClick
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebsSingle
      Style.ButtonStyle = btsHotFlat
      TabOrder = 0
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item9: TdxLayoutItem
          Caption = #30917#21333#32534#21495':'
          Control = EditPID
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item2: TdxLayoutItem
          Caption = #36710#29260#21495#30721':'
          Control = EditTruck
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #23458#25143#21517#31216':'
          Control = EditCus
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item6: TdxLayoutItem
          Caption = #26085#26399#31579#36873':'
          Control = EditDate
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = 'cxCheckBox1'
          ShowCaption = False
          Control = Check1
          ControlOptions.ShowBorder = False
        end
      end
      inherited GroupDetail1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem
          Caption = #30917#21333#32534#21495':'
          Control = cxTextEdit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item1: TdxLayoutItem
          Caption = #36710#29260#21495#30721':'
          Control = cxTextEdit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item5: TdxLayoutItem
          Caption = #30382#37325#26102#38388':'
          Control = cxTextEdit3
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item7: TdxLayoutItem
          Caption = #27611#37325#26102#38388':'
          Control = cxTextEdit4
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited cxSplitter1: TcxSplitter
    Top = 197
    Width = 976
  end
  inherited TitlePanel1: TZnBitmapPanel
    Width = 976
    inherited TitleBar: TcxLabel
      Caption = #30917#25151#31216#37327#26597#35810
      Style.IsFontAssigned = True
      Width = 976
      AnchorX = 488
      AnchorY = 11
    end
  end
  inherited SQLQuery: TADOQuery
    Left = 2
    Top = 234
  end
  inherited DataSource1: TDataSource
    Left = 30
    Top = 234
  end
  object PMenu1: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PMenu1Popup
    Left = 2
    Top = 262
    object N3: TMenuItem
      Caption = #25171#21360#36807#30917#21333
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #31216#37325#26102#25235#25293
      Visible = False
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Caption = #8251#31216#37325#26597#35810#8251
      Enabled = False
    end
    object N2: TMenuItem
      Tag = 30
      Caption = #26102#38388#27573#26597#35810
      OnClick = N2Click
    end
    object N1: TMenuItem
      Tag = 10
      Caption = #36807#31354#26102#38388
      OnClick = N2Click
    end
    object N7: TMenuItem
      Tag = 20
      Caption = #36807#37325#26102#38388
      OnClick = N2Click
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object N15: TMenuItem
      Caption = #8251#25253#34920#26597#35810#8251
      Enabled = False
    end
    object N16: TMenuItem
      Caption = #21457#36135#32479#35745
      OnClick = N16Click
    end
    object N17: TMenuItem
      Caption = #25910#36135#32479#35745
      OnClick = N17Click
    end
    object N18: TMenuItem
      Caption = #20498#26009#32479#35745
      OnClick = N18Click
    end
    object N6: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object N9: TMenuItem
      Caption = #8251#31216#37325#21208#35823#8251
      Enabled = False
    end
    object N10: TMenuItem
      Caption = #20462#25913#36710#29260#21495
      OnClick = N10Click
    end
    object N11: TMenuItem
      Caption = #20462#25913#29289#26009
      OnClick = N11Click
    end
    object N12: TMenuItem
      Caption = #20462#25913#23458#25143
      OnClick = N12Click
    end
  end
end
