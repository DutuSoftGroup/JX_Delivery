{*******************************************************************************
  ����: dmzn@163.com 2012-03-31
  ����: ���ز�ѯ
*******************************************************************************}
unit UFramePoundQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, Menus, dxLayoutControl,
  cxCheckBox, cxMaskEdit, cxButtonEdit, cxTextEdit, ADODB, cxLabel,
  UBitmapPanel, cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, ToolWin, UFormCtrl;

type
  TfFramePoundQuery = class(TfFrameNormal)
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item1: TdxLayoutItem;
    EditTruck: TcxButtonEdit;
    dxLayout1Item2: TdxLayoutItem;
    EditCus: TcxButtonEdit;
    dxLayout1Item3: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    cxTextEdit3: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxLayout1Item6: TdxLayoutItem;
    cxTextEdit4: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    PMenu1: TPopupMenu;
    N3: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Check1: TcxCheckBox;
    dxLayout1Item8: TdxLayoutItem;
    N4: TMenuItem;
    N5: TMenuItem;
    EditPID: TcxButtonEdit;
    dxLayout1Item9: TdxLayoutItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure EditTruckPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PMenu1Popup(Sender: TObject);
    procedure Check1Click(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
  private
    { Private declarations }
  protected
    FStart,FEnd: TDate;
    FTimeS,FTimeE: TDate;
    //ʱ������
    FJBWhere: string;
    //�����ѯ
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    procedure AfterInitFormData; override;
    function InitFormDataSQL(const nWhere: string): string; override;
    {*��ѯSQL*}
  public
    { Public declarations }
    class function FrameID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ShellAPI, ULibFun, UMgrControl, UDataModule, UFormDateFilter, UFormInputbox,
  UFormWait, USysConst, USysDB, UBusinessConst, UFormBase;

class function TfFramePoundQuery.FrameID: integer;
begin
  Result := cFI_FramePoundQuery;
end;

procedure TfFramePoundQuery.OnCreateFrame;
begin
  inherited;
  FTimeS := Str2DateTime(Date2Str(Now) + ' 00:00:00');
  FTimeE := Str2DateTime(Date2Str(Now) + ' 00:00:00');

  FJBWhere := '';
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFramePoundQuery.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFramePoundQuery.InitFormDataSQL(const nWhere: string): string;
begin
  EditDate.Text := Format('%s �� %s', [Date2Str(FStart), Date2Str(FEnd)]);

  Result := 'Select pl.*,(P_MValue-P_PValue-P_KZValue) As P_NetWeight,' +
            'ABS((P_MValue-P_PValue-P_KZValue)-P_LimValue) As P_Wucha From $PL pl';
  //xxxxx

  if FJBWhere = '' then
  begin
    Result := Result + ' Where ((P_PDate >=''$S'' and P_PDate<''$E'') or ' +
              '(P_MDate >=''$S'' and P_MDate<''$E'')) ';
  end else
  begin
    Result := Result + ' Where (' + FJBWhere + ')';
  end;

  if Check1.Checked then
       Result := MacroValue(Result, [MI('$PL', sTable_PoundBak)])
  else Result := MacroValue(Result, [MI('$PL', sTable_PoundLog)]);

  Result := MacroValue(Result, [MI('$S', Date2Str(FStart)),
            MI('$E', Date2Str(FEnd+1))]);
  //xxxxx

  if nWhere <> '' then
    Result := Result + ' And (' + nWhere + ')';
  //xxxxx
end;

procedure TfFramePoundQuery.AfterInitFormData;
begin
  FJBWhere := '';
end;

//Desc: ����ɸѡ
procedure TfFramePoundQuery.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then InitFormData(FWhere);
end;

//Desc: ִ�в�ѯ
procedure TfFramePoundQuery.EditTruckPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditPID then
  begin
    EditPID.Text := Trim(EditPID.Text);
    if EditPID.Text = '' then Exit;

    if Length(EditPID.Text) <= 3 then
    begin
      FWhere := 'P_ID like ''%%%s%%''';
      FWhere := Format(FWhere, [EditPID.Text]);
    end else
    begin
      FWhere := '';
      FJBWhere := 'P_ID like ''%%%s%%''';
      FJBWhere := Format(FJBWhere, [EditPID.Text]);
    end;
    InitFormData(FWhere);
  end else

  if Sender = EditTruck then
  begin
    EditTruck.Text := Trim(EditTruck.Text);
    if EditTruck.Text = '' then Exit;

    FWhere := 'P_Truck like ''%%%s%%''';
    FWhere := Format(FWhere, [EditTruck.Text]);
    InitFormData(FWhere);
  end else

  if Sender = EditCus then
  begin
    EditCus.Text := Trim(EditCus.Text);
    if EditCus.Text = '' then Exit;

    FWhere := 'P_CusName like ''%%%s%%''';
    FWhere := Format(FWhere, [EditCus.Text]);
    InitFormData(FWhere);
  end;
end;

procedure TfFramePoundQuery.Check1Click(Sender: TObject);
begin
  BtnRefresh.Click;
end;

//------------------------------------------------------------------------------
//Desc: Ȩ�޿���
procedure TfFramePoundQuery.PMenu1Popup(Sender: TObject);
begin
  N3.Enabled := BtnPrint.Enabled and (not Check1.Checked);
  N9.Visible := BtnEdit.Enabled;
  N10.Visible := BtnEdit.Enabled;
  N11.Visible := BtnEdit.Enabled;
  N12.Visible := BtnEdit.Enabled;
end;

//Desc: ��ӡ����
procedure TfFramePoundQuery.N3Click(Sender: TObject);
var nStr: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    if SQLQuery.FieldByName('P_PValue').AsFloat = 0 then
    begin
      ShowMsg('���ȳ���Ƥ��', sHint); Exit;
    end;

    nStr := SQLQuery.FieldByName('P_ID').AsString;

    if SQLQuery.FieldByName('P_Type').AsString=sFlag_Sale then
         PrintSalePoundReport(nStr, False)
    else PrintPoundReport(nStr, False);
  end
end;

//Desc: ʱ��β�ѯ
procedure TfFramePoundQuery.N2Click(Sender: TObject);
begin
  if ShowDateFilterForm(FTimeS, FTimeE, True) then
  try
    case TComponent(Sender).Tag of
     10: FJBWhere := 'P_PDate>=''$S'' And P_PDate<''$E''';
     20: FJBWhere := 'P_MDate>=''$S'' And P_MDate<''$E''';
     30: FJBWhere := '(P_PDate>=''$S'' And P_PDate<''$E'') Or ' +
                     '(P_MDate>=''$S'' And P_MDate<''$E'')';
     //xxxxx
    end;

    FJBWhere := MacroValue(FJBWhere, [MI('$S', DateTime2Str(FTimeS)),
                MI('$E', DateTime2Str(FTimeE))]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;

//Desc: ɾ����
procedure TfFramePoundQuery.BtnDelClick(Sender: TObject);
var nIdx: Integer;
    nStr,nID,nP: string;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('��ѡ��Ҫɾ���ļ�¼', sHint);
    Exit;
  end;

  nID := SQLQuery.FieldByName('P_ID').AsString;
  nStr := Format('ȷ��Ҫɾ�����Ϊ[ %s ]�Ĺ�������?', [nID]);
  if not QueryDlg(nStr, sAsk) then Exit;

  nStr := Format('Select * From %s Where 1<>1', [sTable_PoundLog]);
  //only for fields
  nP := '';

  with FDM.QueryTemp(nStr) do
  begin
    for nIdx:=0 to FieldCount - 1 do
    if (Fields[nIdx].DataType <> ftAutoInc) and
       (Pos('P_Del', Fields[nIdx].FieldName) < 1) then
      nP := nP + Fields[nIdx].FieldName + ',';
    //�����ֶ�,������ɾ��
    System.Delete(nP, Length(nP), 1);
  end;

  FDM.ADOConn.BeginTrans;
  try
    nStr := 'Insert Into $PB($FL,P_DelMan,P_DelDate) ' +
            'Select $FL,''$User'',$Now From $PL Where P_ID=''$ID''';
    nStr := MacroValue(nStr, [MI('$PB', sTable_PoundBak),
            MI('$FL', nP), MI('$User', gSysParam.FUserID),
            MI('$Now', sField_SQLServer_Now),
            MI('$PL', sTable_PoundLog), MI('$ID', nID)]);
    FDM.ExecuteSQL(nStr);
    
    nStr := 'Delete From %s Where P_ID=''%s''';
    nStr := Format(nStr, [sTable_PoundLog, nID]);
    FDM.ExecuteSQL(nStr);

    FDM.ADOConn.CommitTrans;
    InitFormData(FWhere);
    ShowMsg('ɾ�����', sHint);
  except
    FDM.ADOConn.RollbackTrans;
    ShowMsg('ɾ��ʧ��', sError);
  end;
end;

procedure TfFramePoundQuery.BtnEditClick(Sender: TObject);
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('��ѡ����Ҫ�޸ĵĳ��ؼ�¼', sHint);
    Exit;
  end;


end;

procedure TfFramePoundQuery.N10Click(Sender: TObject);
var nSQL,nStr,nBID,nPID,nPType,nTruck: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    if (SQLQuery.FieldByName('P_MValue').AsFloat>0) and
      (SQLQuery.FieldByName('P_PValue').AsFloat>0)
    then
    begin
      ShowDlg('��ֹ�޸�����ɶ���', sWarn);
      Exit;
    end;

    nStr := SQLQuery.FieldByName('P_Truck').AsString;
    nTruck := nStr;
    if not ShowInputBox('�������µĳ��ƺ���:', '�޸�', nTruck, 15) then Exit;

    if (nTruck = '') or (nStr = nTruck) then Exit;
    //��Ч��һ��

    nPID := SQLQuery.FieldByName('P_ID').AsString;
    nBID := SQLQuery.FieldByName('P_Bill').AsString;
    nPType:=SQLQuery.FieldByName('P_Type').AsString;

    FDM.ADOConn.BeginTrans;
    try
      nSQL := MakeSQLByStr([SF('P_Truck', nTruck)
                ], sTable_PoundLog, SF('P_ID', nPID), False);
      FDM.ExecuteSQL(nSQL);

      if nPType <> sFlag_Provide then
      begin
        nSQL := MakeSQLByStr([SF('L_Truck', nTruck)
                ], sTable_Bill, SF('L_ID', nBID), False);
        FDM.ExecuteSQL(nSQL);
      end;

      nStr := Format('�޸ĳ��س��ƺ�,������:%s ԭ����:%s �³���:%s', [
              nPID, nStr, nTruck]);
      FDM.WriteSysLog(sFlag_PoundLogItem, sFlag_PoundLogItem, nStr);

      FDM.ADOConn.CommitTrans;
      InitFormData(FWhere);
      ShowMsg('���ƺ��޸ĳɹ�', sHint);
    except
      FDM.ADOConn.RollbackTrans;
      ShowMsg('���ƺ��޸�ʧ��', sError);
    end;
  end;
end;

procedure TfFramePoundQuery.N11Click(Sender: TObject);
var nSQL,nStr,nBID,nPID,nPType,nStock: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nPID    := SQLQuery.FieldByName('P_ID').AsString;
    nBID    := SQLQuery.FieldByName('P_Bill').AsString;
    nPType  := SQLQuery.FieldByName('P_Type').AsString;
    nStock  := SQLQuery.FieldByName('P_MName').AsString;

    if (nPType = sFlag_NChange) or (nPType = sFlag_Other) then
    begin
      if not ShowInputBox('�������µ���������:', '�޸�', nStr, 15) then Exit;
    end else Exit;

    if (nStr='') or (nStr=nStock) then Exit;

    FDM.ADOConn.BeginTrans;
    try
      nSQL := MakeSQLByStr([SF('P_MName', nStr)
                ], sTable_PoundLog, SF('P_ID', nPID), False);
      FDM.ExecuteSQL(nSQL);

      nStr := Format('�޸ĳ�����������,������:%s ԭ������:%s ��������:%s', [
              nPID, nStock, nStr]);
      FDM.WriteSysLog(sFlag_PoundLogItem, sFlag_PoundLogItem, nStr);

      FDM.ADOConn.CommitTrans;
      InitFormData(FWhere);
      ShowMsg('���������޸ĳɹ�', sHint);
    except
      FDM.ADOConn.RollbackTrans;
      ShowMsg('���������޸�ʧ��', sError);
    end;
  end;
end;

procedure TfFramePoundQuery.N12Click(Sender: TObject);
var nStr, nSQL, nPID, nPType, nCusName: string;
begin
  inherited;
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nPID    := SQLQuery.FieldByName('P_ID').AsString;
    nPType  := SQLQuery.FieldByName('P_Type').AsString;
    nCusName  := SQLQuery.FieldByName('P_CusName').AsString;

    if (nPType = sFlag_NChange) or (nPType = sFlag_Other) then
    begin
      if not ShowInputBox('�������µĿͻ�����:', '�޸�', nStr, 15) then Exit;
    end else Exit;

    if (nStr='') or (nStr=nCusName) then Exit;

    FDM.ADOConn.BeginTrans;
    try
      nSQL := MakeSQLByStr([SF('P_CusName', nStr)
                ], sTable_PoundLog, SF('P_ID', nPID), False);
      FDM.ExecuteSQL(nSQL);

      nStr := Format('�޸ĳ�����������,������:%s ԭ�ͻ���:%s �¿ͻ���:%s', [
              nPID, nCusName, nStr]);
      FDM.WriteSysLog(sFlag_PoundLogItem, sFlag_PoundLogItem, nStr);

      FDM.ADOConn.CommitTrans;
      InitFormData(FWhere);
      ShowMsg('�ͻ������޸ĳɹ�', sHint);
    except
      FDM.ADOConn.RollbackTrans;
      ShowMsg('�ͻ������޸�ʧ��', sError);
    end;
  end;
end;

//����ͳ��
procedure TfFramePoundQuery.N16Click(Sender: TObject);
begin
  inherited;
  //
  if ShowDateFilterForm(FTimeS, FTimeE, True) then
  try
    FJBWhere := '(P_MDate>=''%s'' And P_MDate<''%s'' And P_Type=''%s'')';
    FJBWhere := Format(FJBWhere, [DateTime2Str(FTimeS), DateTime2Str(FTimeE),
                sFlag_Sale]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;

//�ջ�ͳ��
procedure TfFramePoundQuery.N17Click(Sender: TObject);
begin
  inherited;
  //
  if ShowDateFilterForm(FTimeS, FTimeE, True) then
  try
    FJBWhere := '(P_PDate>=''%s'' And P_PDate<''%s'' And P_Type=''%s'' And ' +
                'P_MDate Is Not Null)';
    FJBWhere := Format(FJBWhere, [DateTime2Str(FTimeS), DateTime2Str(FTimeE),
                sFlag_Provide]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;

//����ͳ��
procedure TfFramePoundQuery.N18Click(Sender: TObject);
begin
  inherited;
  //
  if ShowDateFilterForm(FTimeS, FTimeE, True) then
  try
    FJBWhere := '(P_PDate>=''%s'' And P_PDate<''%s'' And P_Type=''%s'' And ' +
                'P_MDate Is Not Null)';
    FJBWhere := Format(FJBWhere, [DateTime2Str(FTimeS), DateTime2Str(FTimeE),
                sFlag_NChange]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;

initialization
  gControlManager.RegCtrl(TfFramePoundQuery, TfFramePoundQuery.FrameID);
end.
