inherited fFormTransport: TfFormTransport
  Left = 605
  Top = 319
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 410
  ClientWidth = 400
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 400
    Height = 410
    Align = alClient
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    LookAndFeel = FDM.dxLayoutWeb1
    object EditName: TcxTextEdit
      Left = 81
      Top = 61
      Hint = 'T.T_Name'
      ParentFont = False
      Properties.MaxLength = 80
      TabOrder = 1
      OnKeyDown = FormKeyDown
      Width = 138
    end
    object EditMemo: TcxMemo
      Left = 81
      Top = 111
      Hint = 'T.T_Memo'
      ParentFont = False
      Properties.MaxLength = 50
      Properties.ScrollBars = ssVertical
      Style.Edges = [bBottom]
      TabOrder = 4
      Height = 50
      Width = 368
    end
    object InfoList1: TcxMCListBox
      Left = 23
      Top = 248
      Width = 397
      Height = 104
      HeaderSections = <
        item
          Text = #20449#24687#39033
          Width = 105
        end
        item
          AutoSize = True
          Text = #20869#23481
          Width = 288
        end>
      ParentFont = False
      Style.BorderStyle = cbsOffice11
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      TabOrder = 9
    end
    object InfoItems: TcxComboBox
      Left = 81
      Top = 198
      ParentFont = False
      Properties.ImmediateDropDown = False
      Properties.IncrementalSearch = False
      Properties.MaxLength = 30
      TabOrder = 5
      Width = 75
    end
    object EditInfo: TcxTextEdit
      Left = 81
      Top = 223
      ParentFont = False
      Properties.MaxLength = 50
      TabOrder = 7
      Width = 90
    end
    object BtnAdd: TButton
      Left = 332
      Top = 198
      Width = 45
      Height = 17
      Caption = #28155#21152
      TabOrder = 6
      OnClick = BtnAddClick
    end
    object BtnDel: TButton
      Left = 332
      Top = 223
      Width = 45
      Height = 18
      Caption = #21024#38500
      TabOrder = 8
      OnClick = BtnDelClick
    end
    object BtnOK: TButton
      Left = 245
      Top = 376
      Width = 69
      Height = 23
      Caption = #20445#23384
      TabOrder = 10
      OnClick = BtnOKClick
    end
    object BtnExit: TButton
      Left = 319
      Top = 376
      Width = 70
      Height = 23
      Caption = #21462#28040
      TabOrder = 11
      OnClick = BtnExitClick
    end
    object cxTextEdit3: TcxTextEdit
      Left = 254
      Top = 86
      Hint = 'T.T_Phone'
      ParentFont = False
      Properties.MaxLength = 20
      TabOrder = 3
      OnKeyDown = FormKeyDown
      Width = 145
    end
    object cxTextEdit1: TcxTextEdit
      Left = 81
      Top = 86
      Hint = 'T.T_Man'
      ParentFont = False
      Properties.MaxLength = 32
      TabOrder = 2
      Width = 110
    end
    object EditID: TcxTextEdit
      Left = 81
      Top = 36
      Hint = 'T.T_ID'
      ParentFont = False
      Properties.MaxLength = 80
      TabOrder = 0
      OnKeyDown = FormKeyDown
      Width = 278
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dxLayoutControl1Group1: TdxLayoutGroup
        Caption = #22522#26412#20449#24687
        object dxLayoutControl1Group9: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayoutControl1Item3: TdxLayoutItem
            Caption = #36816#36755#32534#21495':'
            Control = EditID
            ControlOptions.ShowBorder = False
          end
          object dxLayoutControl1Item2: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #36816#36755#21333#20301':'
            Control = EditName
            ControlOptions.ShowBorder = False
          end
          object dxLayoutControl1Group6: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayoutControl1Item1: TdxLayoutItem
              Caption = #32852#31995#20154#21592':'
              Control = cxTextEdit1
              ControlOptions.ShowBorder = False
            end
            object dxLayoutControl1Item14: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #32852#31995#26041#24335':'
              Control = cxTextEdit3
              ControlOptions.ShowBorder = False
            end
          end
        end
        object dxLayoutControl1Item4: TdxLayoutItem
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
      object dxLayoutControl1Group2: TdxLayoutGroup
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #38468#21152#20449#24687
        object dxLayoutControl1Group4: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayoutControl1Group3: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayoutControl1Item6: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #20449' '#24687' '#39033':'
              Control = InfoItems
              ControlOptions.ShowBorder = False
            end
            object dxLayoutControl1Item8: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahRight
              Caption = 'Button1'
              ShowCaption = False
              Control = BtnAdd
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayoutControl1Group7: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayoutControl1Item7: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #20449#24687#20869#23481':'
              Control = EditInfo
              ControlOptions.ShowBorder = False
            end
            object dxLayoutControl1Item9: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahRight
              Caption = 'Button2'
              ShowCaption = False
              Control = BtnDel
              ControlOptions.ShowBorder = False
            end
          end
        end
        object dxLayoutControl1Item5: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Control = InfoList1
          ControlOptions.ShowBorder = False
        end
      end
      object dxLayoutControl1Group5: TdxLayoutGroup
        AutoAligns = [aaHorizontal]
        AlignVert = avBottom
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dxLayoutControl1Item10: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'Button3'
          ShowCaption = False
          Control = BtnOK
          ControlOptions.ShowBorder = False
        end
        object dxLayoutControl1Item11: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'Button4'
          ShowCaption = False
          Control = BtnExit
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
