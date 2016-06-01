{*******************************************************************************
  ����: dmzn@163.com 2014-06-10
  ����: �ֶ�����ͨ����
*******************************************************************************}
unit UFramePoundManualItem;

{$I Link.Inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UMgrPoundTunnels, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, ExtCtrls, cxCheckBox,
  StdCtrls, cxButtons, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLabel,
  ULEDFont, cxRadioGroup, UFrameBase, cxSplitter, cxMemo,
  cxButtonEdit, UBusinessConst;

type
  TOrderItem = record
    FOrder: string;         //������
    FMaxValue: Double;      //������
    FKDValue: Double;       //������
  end;

  TOrderItems = array of TOrderItem;
  //�����б�

  TfFrameManualPoundItem = class(TBaseFrame)
    GroupBox1: TGroupBox;
    EditValue: TLEDFontNum;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    ImageBT: TImage;
    ImageOff: TImage;
    ImageOn: TImage;
    HintLabel: TcxLabel;
    EditTruck: TcxComboBox;
    EditMID: TcxComboBox;
    EditPID: TcxComboBox;
    EditMValue: TcxTextEdit;
    EditPValue: TcxTextEdit;
    EditJValue: TcxTextEdit;
    BtnReadNumber: TcxButton;
    BtnSave: TcxButton;
    BtnNext: TcxButton;
    Timer1: TTimer;
    PMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    EditBill: TcxComboBox;
    EditZValue: TcxTextEdit;
    GroupBox2: TGroupBox;
    RadioPD: TcxRadioButton;
    RadioCC: TcxRadioButton;
    EditMemo: TcxTextEdit;
    EditWValue: TcxTextEdit;
    RadioLS: TcxRadioButton;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    Timer2: TTimer;
    GroupBox4: TGroupBox;
    EditKZValue: TcxTextEdit;
    cxKZMemo: TcxMemo;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    EditBatchCode: TcxButtonEdit;
    cxLabel14: TcxLabel;
    BtnTruckP: TcxButton;
    EditTransport: TcxComboBox;
    cxLabel15: TcxLabel;
    Timer_SaveFail: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure EditBillKeyPress(Sender: TObject; var Key: Char);
    procedure EditBillPropertiesEditValueChanged(Sender: TObject);
    procedure BtnReadNumberClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure RadioPDClick(Sender: TObject);
    procedure EditTruckKeyPress(Sender: TObject; var Key: Char);
    procedure EditMValuePropertiesEditValueChanged(Sender: TObject);
    procedure EditMIDPropertiesChange(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure EditPIDKeyPress(Sender: TObject; var Key: Char);
    procedure EditBatchCodeEnter(Sender: TObject);
    procedure EditBatchCodeKeyPress(Sender: TObject; var Key: Char);
    procedure BtnTruckPClick(Sender: TObject);
    procedure Timer_SaveFailTimer(Sender: TObject);
  private
    { Private declarations }
    FPoundTunnel: PPTTunnelItem;
    //��վͨ��
    FLastBT: Int64;
    //�ϴλ
    FOrderItems: TOrderItems;
    //�����б�
    FBillItems: TLadingBillItems;
    FUIData,FInnerData: TLadingBillItem;
    //��������
    FListA, FListB, FListC: TStrings;
    //xxxx
    FKZPopItem,FHasGetP: Boolean;

    procedure InitUIData;
    procedure SetUIData(const nReset: Boolean; const nOnlyData: Boolean = False);
    //��������
    procedure SetImageStatus(const nImage: TImage; const nOff: Boolean);
    //����״̬
    procedure SetTunnel(const nTunnel: PPTTunnelItem);
    //����ͨ��
    procedure OnPoundData(const nValue: Double);
    //��ȡ����
    procedure LoadBillItems(const nCard: string);
    //��ȡ������
    procedure LoadTruckPoundItem(const nTruck: string);
    //��ȡ��������
    procedure LoadOrderPoundItem(const nOrderData: string);
    //��ȡ��������
    function SavePoundSale: Boolean;
    function SavePoundData: Boolean;
    //�������
    procedure AdjustSanValue(const nBillValue: Double);
    //ɢװУ������
    function MakeNewSanBill(nBillValue: Double): Boolean;
    //ɢװ���µ�
    procedure SelectNCBatchCode;
    //ѡ�����κ�
    procedure AdjustProvideValue(const nNewValue: Double);
    function AdjustNCMaxValue:Boolean;
  public
    { Public declarations }
    class function FrameID: integer; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    //����̳�
    property PoundTunnel: PPTTunnelItem read FPoundTunnel write SetTunnel;
    //�������
  end;

implementation

{$R *.dfm}

uses
  ULibFun, UAdjustForm, UFormBase, UDataModule, UBusinessPacker,
  UFormWait, USysConst, USysDB, USysLoger, USysPopedom;

const
  cFlag_ON    = 10;
  cFlag_OFF   = 20;

procedure WriteLog(nEvent: string);
begin
  gSysLoger.AddLog(TfFrameManualPoundItem, '�ֹ�����ҵ��', nEvent);
end;    

class function TfFrameManualPoundItem.FrameID: integer;
begin
  Result := cFI_FormPoundManual;
end;

procedure TfFrameManualPoundItem.OnCreateFrame;
begin
  inherited;
  FPoundTunnel := nil;
  FListA := TStringList.Create;
  FListB := TStringList.Create;
  FListC := TStringList.Create;
  InitUIData;
  FHasGetP:=False;
end;

procedure TfFrameManualPoundItem.OnDestroyFrame;
begin
  gPoundTunnelManager.ClosePort(FPoundTunnel.FID);
  //�رձ�ͷ�˿�
  
  AdjustStringsItem(EditMID.Properties.Items, True);
  AdjustStringsItem(EditPID.Properties.Items, True);
  FListA.Free;
  FListB.Free;
  FListC.Free; 
  inherited;
end;

//Desc: ��������״̬ͼ��
procedure TfFrameManualPoundItem.SetImageStatus(const nImage: TImage;
  const nOff: Boolean);
begin
  if nOff then
  begin
    if nImage.Tag <> cFlag_OFF then
    begin
      nImage.Tag := cFlag_OFF;
      nImage.Picture.Bitmap := ImageOff.Picture.Bitmap;
    end;
  end else
  begin
    if nImage.Tag <> cFlag_ON then
    begin
      nImage.Tag := cFlag_ON;
      nImage.Picture.Bitmap := ImageOn.Picture.Bitmap;
    end;
  end;
end;

//------------------------------------------------------------------------------
//Desc: ��ʼ������
procedure TfFrameManualPoundItem.InitUIData;
var nStr: string;
    nEx: TDynamicStrArray;
begin
  SetLength(nEx, 1);
  nStr := 'M_ID=Select M_ID,M_Name From %s Order By M_ID ASC';
  nStr := Format(nStr, [sTable_Materails]);

  nEx[0] := 'M_ID';
  FDM.FillStringsData(EditMID.Properties.Items, nStr, 0, '', nEx);
  AdjustCXComboBoxItem(EditMID, False);

  nStr := 'P_ID=Select P_ID,P_Name From %s Order By P_ID ASC';
  nStr := Format(nStr, [sTable_Provider]);

  nEx[0] := 'P_ID';
  FDM.FillStringsData(EditPID.Properties.Items, nStr, 0, '', nEx);
  AdjustCXComboBoxItem(EditPID, False);

  FKZPopItem := gPopedomManager.HasPopedom('MAIN_E01', sPopedom_KouZa);
  cxLabel11.Visible := FKZPopItem;
  cxLabel14.Visible := FKZPopItem;
  EditKZValue.Visible := FKZPopItem;
end;

//Desc: ���ý�������
procedure TfFrameManualPoundItem.SetUIData(const nReset,nOnlyData: Boolean);
var nStr: string;
    nInt: Integer;
    nVal: Double;
    nItem: TLadingBillItem;
begin
  if nReset then
  begin
    FillChar(nItem, SizeOf(nItem), #0);
    //init

    with nItem do
    begin
      FKZValue := 0;
      FKZComment := '';

      FPModel := sFlag_PoundPD;
      FFactory := gSysParam.FFactNum;
    end;

    FHasGetP:= False;
    FUIData := nItem;
    FInnerData := nItem;
    if nOnlyData then Exit;

    SetLength(FBillItems, 0);
    EditValue.Text := '0.00';
    EditBill.Properties.Items.Clear;

    EditKZValue.Text := '0.00';
    cxKZMemo.Lines.Clear;
    EditTransport.Text := '';

    gPoundTunnelManager.ClosePort(FPoundTunnel.FID);
    //�رձ�ͷ�˿�
  end;

  with FUIData do
  begin
    if FBillOrign = sFlag_BillZX then
         EditBill.Text := FID
    else EditBill.Text := FCard;
    EditTruck.Text := FTruck;
    EditMID.Text := FStockName;
    EditPID.Text := FCusName;
    EditBatchCode.Text := FBatchCode;

    EditMValue.Text := Format('%.2f', [FMData.FValue]);
    EditPValue.Text := Format('%.2f', [FPData.FValue]);
    EditZValue.Text := Format('%.2f', [FValue]);

    if (FValue > 0) and (FMData.FValue > 0) and (FPData.FValue > 0) then
    begin
      nVal := FMData.FValue - FPData.FValue;
      EditJValue.Text := Format('%.2f', [nVal]);
      EditWValue.Text := Format('%.2f', [FValue - nVal]);
    end else
    begin
      EditJValue.Text := '0.00';
      EditWValue.Text := '0.00';
    end;

    RadioPD.Checked := FPModel = sFlag_PoundPD;
    RadioCC.Checked := FPModel = sFlag_PoundCC;
    RadioLS.Checked := FPModel = sFlag_PoundLS;

    BtnSave.Enabled := FTruck <> '';
    BtnReadNumber.Enabled := FTruck <> '';
    BtnTruckP.Enabled := (FTruck <> '') and               //���ƺŴ���
      (FPType <> sFlag_Sale) and (not FHasGetP) and       //��Ӧ������δ��ȡ
      (FNextStatus = sFlag_TruckBFP) and
      (FMData.FValue <= 0);
    RadioLS.Enabled := (FPoundID = '') and (FID = '');
    //�ѳƹ�����������,������ʱģʽ
    RadioCC.Enabled := False;
    //ȡ������ģʽ

    EditBill.Properties.ReadOnly := (FID = '') and (FTruck <> '');
    EditTruck.Properties.ReadOnly := FTruck <> '';
    EditMID.Properties.ReadOnly := (FID <> '') or (FPoundID <> '');
    EditPID.Properties.ReadOnly := (FID <> '') or (FPoundID <> '');
    //�����������

    EditMemo.Properties.ReadOnly := True;
    EditMValue.Properties.ReadOnly := not FPoundTunnel.FUserInput;
    EditPValue.Properties.ReadOnly := not FPoundTunnel.FUserInput;
    EditJValue.Properties.ReadOnly := True;
    EditZValue.Properties.ReadOnly := True;
    EditWValue.Properties.ReadOnly := True;
    //������������

    cxKZMemo.Text := FKZComment;
    EditTransport.Text := FTransport;

    if FTruck = '' then
    begin
      EditMemo.Text := '';
      Exit;
    end;
  end;

  nInt := Length(FBillItems);
  if FUIData.FPType<>'' then
  begin
    nStr := '����';
    if FUIData.FPType = sFlag_Sale    then nStr := '����';
    if FUIData.FPType = sFlag_Provide then nStr := '��Ӧ';
    if FUIData.FPType = sFlag_Dispatch then nStr := '����';

    if nInt>1 then nStr := nStr + '����';

    if (FUIData.FNextStatus = sFlag_TruckBFP) and (not FHasGetP) then
    begin
      RadioCC.Enabled := False;
      EditMemo.Text := nStr + '��Ƥ��';
    end else
    begin
      RadioCC.Enabled := False;
      EditMemo.Text := nStr + '��ë��';
    end;
  end else
  begin
    if RadioLS.Checked then
      EditMemo.Text := '������ʱ����';
    //xxxxx

    if RadioPD.Checked then
      EditMemo.Text := '������Գ���';
    //xxxxx
  end;
end;

//Date: 2014-09-19
//Parm: �ſ��򽻻�����
//Desc: ��ȡnCard��Ӧ�Ľ�����
procedure TfFrameManualPoundItem.LoadBillItems(const nCard: string);
var nIdx,nInt: Integer;
begin
  if nCard = '' then
  begin
    EditBill.SetFocus;
    EditBill.SelectAll;
    ShowMsg('�����뵥�ݺ�', sHint); Exit;
  end;

  if not GetLadingBills(EditBill.Text, FBillItems) then
  begin
    SetUIData(True);
    Exit;
  end;
  //��ȡ������Ϣ

  nInt := 0;
  EditBill.Properties.Items.Clear;
  for nIdx:=Low(FBillItems) to High(FBillItems) do
  begin
    if nInt = 0 then
         FInnerData := FBillItems[nIdx]
    else FInnerData.FValue := FInnerData.FValue + FBillItems[nIdx].FValue;

    EditBill.Properties.Items.Add(FBillItems[nIdx].FCard);
    Inc(nInt);
  end;

  FInnerData.FPModel := sFlag_PoundPD;
  FUIData := FInnerData;
  SetUIData(False);

  if not FPoundTunnel.FUserInput then
    gPoundTunnelManager.ActivePort(FPoundTunnel.FID, OnPoundData, True);
  //xxxxx
end;

//Date: 2014-09-25
//Parm: ���ƺ�
//Desc: ��ȡnTruck�ĳ�����Ϣ
procedure TfFrameManualPoundItem.LoadTruckPoundItem(const nTruck: string);
var //nData: TLadingBillItems;
    nIdx, nInt: Integer;
    nStr :string;
begin
  if nTruck = '' then
  begin
    EditTruck.SetFocus;
    EditTruck.SelectAll;
    ShowMsg('�����복�ƺ�', sHint); Exit;
  end;

  if FUIData.FZhiKa <> '' then       //��ѡ��������
  begin
    if TruckInFact(EditTruck.Text) then
    begin
      EditTruck.Text := '';
      Exit;
    end;
    for nIdx:= Low(FBillItems) to High(FBillItems) do
      FBillItems[nIdx].FTruck := EditTruck.Text;

    FInnerData.FTruck := EditTruck.Text;
  end else
  begin
    if not GetTruckPoundItem(nTruck, FBillItems) then
    begin
      SetUIData(True);
      Exit;
    end;

    nInt := 0;
    EditBill.Properties.Items.Clear;
    for nIdx:=Low(FBillItems) to High(FBillItems) do
    begin
      if nInt = 0 then
           FInnerData := FBillItems[nIdx]
      else FInnerData.FValue := FInnerData.FValue + FBillItems[nIdx].FValue;

      EditBill.Properties.Items.Add(FBillItems[nIdx].FCard);
      Inc(nInt);
    end;
  end;

  if (Pos('����', FInnerData.FStockName)>0) and
    (EditTransport.Properties.Items.Count<=0) then
  begin
    nStr := 'Select T_Name From %s';
    nStr := Format(nStr, [sTable_Transport]);
    //xxxxx

    EditTransport.Properties.Items.Clear;
    with FDM.QuerySQL(nStr) do
    begin
      First;

      while not Eof do
      begin
        EditTransport.Properties.Items.Add(Fields[0].AsString);
        Next;
      end;    
    end;  
  end;  

  FUIData := FInnerData;
  SetUIData(False);

  if not FPoundTunnel.FUserInput then
    gPoundTunnelManager.ActivePort(FPoundTunnel.FID, OnPoundData, True);
  //xxxxx
end;

//------------------------------------------------------------------------------
//Desc: ��������״̬
procedure TfFrameManualPoundItem.Timer1Timer(Sender: TObject);
begin
  SetImageStatus(ImageBT, GetTickCount - FLastBT > 5 * 1000);
end;

//Desc: �رպ��̵�
procedure TfFrameManualPoundItem.Timer2Timer(Sender: TObject);
begin

end;

//Desc: ��ͷ����
procedure TfFrameManualPoundItem.OnPoundData(const nValue: Double);
begin
  FLastBT := GetTickCount;
  EditValue.Text := Format('%.2f', [nValue]);
end;

//Desc: ����ͨ��
procedure TfFrameManualPoundItem.SetTunnel(const nTunnel: PPTTunnelItem);
begin
  FPoundTunnel := nTunnel;
  SetUIData(True);
end;

//Desc: ���ƺ��̵�
procedure TfFrameManualPoundItem.N1Click(Sender: TObject);
begin
  N1.Checked := not N1.Checked;
end;

//Desc: �رճ���ҳ��
procedure TfFrameManualPoundItem.N3Click(Sender: TObject);
var nP: TWinControl;
begin
  nP := Parent;
  while Assigned(nP) do
  begin
    if (nP is TBaseFrame) and
       (TBaseFrame(nP).FrameID = cFI_FramePoundManual) then
    begin
      TBaseFrame(nP).Close();
      Exit;
    end;

    nP := nP.Parent;
  end;
end;

//Desc: ������ť
procedure TfFrameManualPoundItem.BtnNextClick(Sender: TObject);
begin
  SetUIData(True);
end;

procedure TfFrameManualPoundItem.EditBillKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if EditBill.Properties.ReadOnly then Exit;

    EditBill.Text := Trim(EditBill.Text);
    LoadBillItems(EditBill.Text);
  end;
end;

procedure TfFrameManualPoundItem.EditTruckKeyPress(Sender: TObject;
  var Key: Char);
var nP: TFormCommandParam;
begin
  if Key = Char(VK_RETURN) then
  begin
    Key := #0;
    if EditTruck.Properties.ReadOnly then Exit;

    EditTruck.Text := Trim(EditTruck.Text);
    LoadTruckPoundItem(EditTruck.Text);
  end;

  if Key = Char(VK_SPACE) then
  begin
    Key := #0;
    if EditTruck.Properties.ReadOnly then Exit;

    nP.FParamA := EditTruck.Text;
    CreateBaseFormItem(cFI_FormGetTruck, '', @nP);

    if (nP.FCommand = cCmd_ModalResult) and(nP.FParamA = mrOk) then
      EditTruck.Text := nP.FParamB;
    EditTruck.SelectAll;
  end;
end;

procedure TfFrameManualPoundItem.EditBillPropertiesEditValueChanged(
  Sender: TObject);
begin
  if EditBill.Properties.Items.Count > 0 then
  begin
    if EditBill.ItemIndex < 0 then
    begin
      EditBill.Text := FUIData.FCard;
      Exit;
    end;

    with FBillItems[EditBill.ItemIndex] do
    begin
      if FUIData.FCard = FCard then Exit;
      //ͬ����

      FUIData.FCard := FCard;
      FUIData.FCusName := FCusName;
      FUIData.FStockName := FStockName;
    end;

    SetUIData(False);
    //ui
  end;
end;

//Desc: ����
procedure TfFrameManualPoundItem.BtnReadNumberClick(Sender: TObject);
var nVal: Double;
begin
  if not IsNumber(EditValue.Text, True) then Exit;
  nVal := StrToFloat(EditValue.Text);
  AdjustProvideValue(nVal);
end;

//Desc: �ɶ�ͷָ��������
procedure TfFrameManualPoundItem.RadioPDClick(Sender: TObject);
begin
  if RadioPD.Checked then
    FUIData.FPModel := sFlag_PoundPD;
  if RadioCC.Checked then
    FUIData.FPModel := sFlag_PoundCC;
  if RadioLS.Checked then
    FUIData.FPModel := sFlag_PoundLS;
  //�л�ģʽ

  SetUIData(False);
end;

procedure TfFrameManualPoundItem.EditMValuePropertiesEditValueChanged(
  Sender: TObject);
var nVal: Double;
    nEdit: TcxTextEdit;
begin
  nEdit := Sender as TcxTextEdit;
  if not IsNumber(nEdit.Text, True) then Exit;
  nVal := StrToFloat(nEdit.Text);

  if Sender = EditPValue then
    FUIData.FPData.FValue := nVal;
  //xxxxx

  if Sender = EditMValue then
    FUIData.FMData.FValue := nVal;

  SetUIData(False);
end;

procedure TfFrameManualPoundItem.EditMIDPropertiesChange(Sender: TObject);
var nP: TFormCommandParam;
begin
  if Sender = EditMID then
  begin
    if not EditMID.Focused then Exit;
    //�ǲ�����Ա����
    EditMID.Text := Trim(EditMID.Text);

    if EditMID.ItemIndex < 0 then
    begin
      FUIData.FStockNo := '';
      FUIData.FStockName := EditMID.Text;
    end else
    begin
      FUIData.FStockNo := GetCtrlData(EditMID);
      FUIData.FStockName := EditMID.Text;
    end;
  end else

  if Sender = EditPID then
  begin
    if not EditPID.Focused then Exit;
    //�ǲ�����Ա����
    EditPID.Text := Trim(EditPID.Text);

    if EditPID.ItemIndex < 0 then
    begin
      FUIData.FCusID := '';
      FUIData.FCusName := EditPID.Text;
    end else
    begin
      FUIData.FCusID := GetCtrlData(EditPID);
      FUIData.FCusName := EditPID.Text;
    end;

    if FUIData.FCusID = '' then Exit;
    if BtnSave.Enabled then Exit;
    //ҵ���ѿ�ʼ

    if FUIData.FCusName <> EditPID.Properties.Items[EditPID.ItemIndex] then
      Exit;
    //�û��ֹ�����

    nP.FParamA := FUIData.FCusID;
    nP.FParamB := '';
    nP.FParamC := sFlag_Provide;

    CreateBaseFormItem(cFI_FormGetOrder, FPopedom, @nP);
    if (nP.FCommand <> cCmd_ModalResult) or (nP.FParamA <> mrOK) then Exit;
    LoadOrderPoundItem(nP.FParamB);
  end;
end;

procedure TfFrameManualPoundItem.LoadOrderPoundItem(const nOrderData: string);
var nOrder: TOrderItemInfo;
begin
  AnalyzeOrderInfo(nOrderData, nOrder);
  with FInnerData do
  begin
    FID         := nOrder.FOrders;
    FZhiKa      := nOrder.FOrders;
    FCard       := nOrder.FBillID;

    FCusID      := nOrder.FCusID;
    FCusName    := nOrder.FCusName;
    FAreaName   := nOrder.FAreaName;

    FStockNo    := nOrder.FStockID;
    FStockName  := nOrder.FStockName;
    FValue      := nOrder.FValue;
    FSelected   := True;

    FPType      := sFlag_Provide;
    FNextStatus := sFlag_TruckBFP;
  end;

  FUIData := FInnerData;
  SetUIData(False);
  EditTruck.SetFocus;

  if not FPoundTunnel.FUserInput then
    gPoundTunnelManager.ActivePort(FPoundTunnel.FID, OnPoundData, True);
  //xxxxx
end;

//------------------------------------------------------------------------------
//Desc: ԭ���ϻ���ʱ
function TfFrameManualPoundItem.SavePoundData: Boolean;
var nHint: string;
    nOldPValue: Boolean;
begin
  Result := False;
  //init

  if ((FUIData.FPData.FValue <= 0) and (FUIData.FMData.FValue <= 0)) //Ƥ��ë��û��
  or ((FUIData.FPData.FValue <= 0) and (FUIData.FMData.FValue > 0)) then //��ë��Ƥ
  begin
    ShowMsg('���ȳ���', sHint);
    Exit;
  end;

  if (FUIData.FPData.FValue > 0) and (FUIData.FMData.FValue > 0) then
  begin
    if FUIData.FPData.FValue > FUIData.FMData.FValue then
    begin
      ShowMsg('Ƥ��ӦС��ë��', sHint);
      Exit;
    end;
  end;

  if (Pos('����', FUIData.FStockName)>0) and (Trim(EditTransport.Text)='') then
  if not QueryDlg('���䵥λΪ��,�Ƿ񱣴�', sAsk) then Exit;

  SetLength(FBillItems, 1);
  FBillItems[0] := FUIData;
  //�����û���������

  with FBillItems[0] do
  begin
    FTransport := Trim(EditTransport.Text);
    
    if FNextStatus = sFlag_TruckBFP then
    begin
      FPData.FStation := FPoundTunnel.FID;
      FPData.FOperator:= gSysParam.FUserName;
    end else
    begin
      FMData.FStation := FPoundTunnel.FID;
      FMData.FOperator:= gSysParam.FUserName;
    end;

    if FKZPopItem then
      FKZValue := Float2Float(StrToFloat(EditKZValue.Text), cPrecision, False)
    else FKZValue := 0;

    FKZComment := cxKZMemo.Text;

    nOldPValue := (FPData.FValue>0) and (FMData.FValue-FPData.FValue-FKZValue>0);
  end;

  Result := SaveTruckPoundItem(CombineBillItmes(FBillItems), nHint);
  //�������

  if not Result then
  begin
    ShowMsg(nHint, sHint);
    Exit;
  end;

  if nOldPValue or (FUIData.FPoundID<>'') then PrintPoundReport(nHint, True);

  if FKZPopItem then
    EditKZValue.Text := '0.00';
  cxKZMemo.Clear;
  //���������Ϣ
end;

procedure TfFrameManualPoundItem.AdjustProvideValue(const nNewValue: Double);
begin
  if (FInnerData.FPType=sFlag_Sale) or (FInnerData.FPType=sFlag_Dispatch) then
  begin
    if FBillItems[0].FNextStatus = sFlag_TruckBFP then
         FUIData.FPData.FValue := nNewValue
    else FUIData.FMData.FValue := nNewValue;
  end else
  begin
    if FInnerData.FPData.FValue > 0 then
    begin
      if nNewValue <= FInnerData.FPData.FValue then
      begin
        FUIData.FPData := FInnerData.FMData;
        FUIData.FMData := FInnerData.FPData;

        FUIData.FPData.FValue := nNewValue;
        FUIData.FNextStatus := sFlag_TruckBFP;
        //�л�Ϊ��Ƥ��
      end else
      begin
        FUIData.FPData := FInnerData.FPData;
        FUIData.FMData := FInnerData.FMData;

        FUIData.FMData.FValue := nNewValue;
        FUIData.FNextStatus := sFlag_TruckBFM;
        //�л�Ϊ��ë��
      end;
    end else
    begin
      FUIData.FPData.FValue := nNewValue;
    end;
  end;

  SetUIData(False);
end;

procedure TfFrameManualPoundItem.AdjustSanValue(const nBillValue: Double);
var nStr: string;
    nIdx: Integer;
    nDec,nVal,nLVal: Double;
begin
  FDM.ADOConn.BeginTrans;
  try
    nVal := nBillValue;
    //to dec

    for nIdx:=Low(FBillItems) to High(FBillItems) do
    with FBillItems[nIdx] do
    begin
      if FValue > nVal then
           nDec := nVal
      else nDec := FValue;

      if nDec <= 0 then Continue;
      //�Ѵ�����
      nVal := nVal - nDec;

      nStr := 'Select L_Value From %s Where L_ID=''%s''';
      nStr := Format(nStr, [sTable_Bill, FID]);
      with FDM.QuerySQL(nStr) do
      begin
        if RecordCount<1 then Continue; //������ʧ

        nLVal := Fields[0].AsFloat;
        nDec  := nDec-(FValue-nLVal);
      end;

      if nDec>0 then
           nStr := 'Update %s Set L_Value=L_Value-%.2f Where L_ID=''%s'''
      else nStr := 'Update %s Set L_Value=L_Value+%.2f Where L_ID=''%s''';
      nStr := Format(nStr, [sTable_Bill, Abs(nDec), FID]);

      FDM.ExecuteSQL(nStr);

      if FBillOrign = sFlag_BillZX then
      begin
        if nDec>0 then
             nStr := 'Update %s Set B_Freeze=B_Freeze-%.2f Where B_ID=''%s'''
        else nStr := 'Update %s Set B_Freeze=B_Freeze+%.2f Where B_ID=''%s''';
        nStr := Format(nStr, [sTable_Order, Abs(nDec), FZhiKa]);

        FDM.ExecuteSQL(nStr);
      end;   
    end;

    FDM.ADOConn.CommitTrans;
    //��������� 
  except
    on E: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(E.Message, sHint);
      Exit;
    end;
  end;
end;

function TfFrameManualPoundItem.AdjustNCMaxValue:Boolean;
var nIdx, nJdx: Integer;
    nHint, nStr: string;
begin 
  {$IFDEF NCChanged}
  Result := False;
  FListA.Clear;
  for nIdx:=Low(FBillItems) to High(FBillItems) do
  if FBillItems[nIdx].FSelected then
    FListA.Add(FBillItems[nIdx].FZhiKa);
  nStr := AdjustListStrFormat2(FListA, '''', True, ',', False, False);

  FListB.Clear;
  FListB.Values['MeamKeys'] := nStr;

  if (not GetSQLQueryOrder(nStr, '103', FListB.Text)) or (nStr='') then
  begin
    nHint := '��ȡ������ѯ���ʧ��';
    nHint := '�ó�����ǰ���ܹ���,��������: ' + #13#10#13#10 + nHint;
    ShowDlg(nHint, sHint);
    Exit;
  end;

  with FDM.QueryTemp(nStr, True) do
  begin
    if RecordCount < 1 then
    begin
      nStr := StringReplace(FListA.Text, #13#10, ',', [rfReplaceAll]);
      nStr := Format('����[ %s ]��Ϣ�Ѷ�ʧ.', [nStr]);

      ShowDlg(nStr, sHint);
      Exit;
    end;

    SetLength(FOrderItems, RecordCount);
    nJdx := 0;
    First;

    while not Eof do
    begin
      with FOrderItems[nJdx] do
      begin
        FOrder := FieldByName('pk_meambill').AsString;
        FMaxValue := FieldByName('NPLANNUM').AsFloat;
        FKDValue := 0;
      end;
      
      Inc(nJdx);
      Next;
    end;
  end;

  if not GetOrderFHValue(FListA, False) then Exit;
  //��ȡ�ѷ�����

  for nJdx:=Low(FOrderItems) to High(FOrderItems) do
  with FOrderItems[nJdx] do
  begin
    nStr := FListA.Values[FOrder];
    if not IsNumber(nStr, True) then Continue;

    FMaxValue := FMaxValue - Float2Float(StrToFloat(nStr), cPrecision, False);
    //������ = �ƻ��� - �ѷ���
  end;

  FInnerData.FValue := 0;
  for nIdx:=Low(FBillItems) to High(FBillItems) do
  with FBillItems[nIdx] do
  begin
    if FSelected then
    begin
      FNCChanged   := False;
      FChangeValue := 0;
      //Ĭ���ޱ仯

      for nJdx:=Low(FOrderItems) to High(FOrderItems) do
      with FOrderItems[nJdx] do
      begin
        if FOrder = FZhiKa then
        begin
          if FValue>FMaxValue then
          begin
            FNCChanged   := True;
            FChangeValue := FValue-FMaxValue;

            FValue := FMaxValue;
          end;

          Break;
        end;
      end;
      //�����������С������¿�Ʊ��

      FInnerData.FValue := FInnerData.FValue + FValue;
      //�ۼ���
    end;
  end;
  //�����������С������¿�Ʊ��
  {$ENDIF}

  Result := True;
end;  

//Desc: ��������
function TfFrameManualPoundItem.SavePoundSale: Boolean;
var nIdx: Integer;
    nVal,nNet,nBillValue,nDec: Double;
    nHint, nStr, nOutBill: string;
begin
  Result := False;
  //init

  if Trim(EditMID.Text) = '' then
  begin
    ShowMsg('��������Ϊ��', sHint);
    Exit;
  end;

  if Trim(EditPID.Text) = '' then
  begin
    ShowMsg('�ͻ�����Ϊ��', sHint);
    Exit;
  end;

  if FUIData.FNextStatus = sFlag_TruckBFM then
  begin
    nStr := Trim(EditBatchCode.Text);
    if (nStr = '') and (FUIData.FPType=sFlag_Sale) then
    begin
      ShowMsg('���κ�Ϊ��', sHint);
      Exit;
    end;

    if FUIData.FMData.FValue <= 0 then
    begin
      ShowMsg('���ë��', sHint);
      Exit;
    end;
  end else if TruckInFact(FUIData.FTruck) then Exit;

  if (FUIData.FPData.FValue <= 0) and (FUIData.FMData.FValue <= 0) then
  begin
    ShowMsg('���ȳ���', sHint);
    Exit;
  end;

  if (Pos('����', FUIData.FStockName)>0) and (Trim(EditTransport.Text)='') then
  if not QueryDlg('���䵥λΪ��,�Ƿ񱣴�', sAsk) then Exit;

  if (FUIData.FPData.FValue > 0) and (FUIData.FMData.FValue > 0) then
  begin
    if FUIData.FPData.FValue > FUIData.FMData.FValue then
    begin
      ShowMsg('Ƥ��ӦС��ë��', sHint);
      Exit;
    end;

    if not AdjustNCMaxValue then Exit;
    //����NC�ɷ�����

    nNet := FUIData.FMData.FValue - FUIData.FPData.FValue;
    //����
    nVal := nNet * 1000 - FInnerData.FValue * 1000;
    //�뿪Ʊ�����(����)

    EditWValue.Text := Format('%.2f', [nVal / 1000]);

    with gSysParam,FBillItems[0] do
    begin
      if FDaiPercent and ((FType = sFlag_Dai) or (FType = sFlag_Dai2)) then
      begin
        if nVal > 0 then
             FPoundDaiZ := Float2Float(FInnerData.FValue * FPoundDaiZ_1 * 1000,
                                       cPrecision, False)
        else FPoundDaiF := Float2Float(FInnerData.FValue * FPoundDaiF_1 * 1000,
                                       cPrecision, False);
      end;

      if (((FType = sFlag_Dai) or (FType = sFlag_Dai2)) and (
          ((nVal > 0) and (FPoundDaiZ > 0) and (nVal > FPoundDaiZ)) or
          ((nVal < 0) and (FPoundDaiF > 0) and (-nVal > FPoundDaiF)))) or
         ((FType = sFlag_San) and (
          (nVal < 0) and (FPoundSanF > 0) and (-nVal > FPoundSanF))) then
      begin
        nStr := '����[ %s ]ʵ��װ�������ϴ�,��������:' + #13#10#13#10 +
                '��.������: %.2f��' + #13#10 +
                '��.װ����: %.2f��' + #13#10 +
                '��.�����: %.2f����';

        if FDaiWCStop and ((FType = sFlag_Dai) or (FType = sFlag_Dai2)) then
        begin
          nStr := nStr + #13#10#13#10 + '��֪ͨ˾���������.';
          nStr := Format(nStr, [FTruck, FInnerData.FValue, nNet, nVal]);

          ShowDlg(nStr, sHint);
          Exit;
        end else
        begin
          nStr := nStr + #13#10#13#10 + '�Ƿ��������?';
          nStr := Format(nStr, [FTruck, FInnerData.FValue, nNet, nVal]);
          if not QueryDlg(nStr, sAsk) then Exit;
        end;
      end;

      if FType = sFlag_San then
      begin
        if nVal > 0 then
        begin
          nVal := Float2Float(nNet - FInnerData.FValue, cPrecision, True);
          if not MakeNewSanBill(nVal) then Exit;
          //ɢװ����ʱ���µ�
        end else

        if nVal < 0 then
        begin
          nVal := Float2Float(FInnerData.FValue - nNet, cPrecision, True);
          AdjustSanValue(nVal);
          //У��
        end;
      end;
    end;

    nBillValue := Abs(Float2Float(nNet, cPrecision, True));
    for nIdx:=Low(FBillItems) to High(FBillItems) do
    with FBillItems[nIdx] do
    begin
      if FValue > nBillValue then
           nDec := nBillValue
      else nDec := FValue;  

      FMData.FValue := FUIData.FPData.FValue + nDec;
      if nDec <= 0 then Continue;
      //�Ѵ�����

      nBillValue := nBillValue - nDec;

      if nIdx=High(FBillItems) then
        FMData.FValue := nBillValue + FMData.FValue;
    end;
    //���ݽ���
  end;

  for nIdx:=Low(FBillItems) to High(FBillItems) do
  with FBillItems[nIdx] do
  begin
    FPModel := FUIData.FPModel;
    FFactory := gSysParam.FFactNum;
    FBatchCode:=Trim(EditBatchCode.Text);
    FKZComment:=Trim(cxKZMemo.Text);
    FTransport:=Trim(EditTransport.Text);

    with FPData do
    begin
      FStation := FPoundTunnel.FID;
      FValue :=   FUIData.FPData.FValue;
      FOperator := gSysParam.FUserID;
    end;

    with FMData do
    begin
      FStation := FPoundTunnel.FID;
      FOperator := gSysParam.FUserID;
    end;

    if nIdx=0 then
    begin
      FPoundID:=sFlag_Yes;
    end;
  end;

  //��Ǹ����г�������
  Result := SaveLadingBills(FBillItems[0].FNextStatus,
    CombineBillItmes(FBillItems), nOutBill, nHint);
  //�������

  if not Result then ShowMsg(nHint, sHint);
  if Result and (FBillItems[0].FNextStatus=sFlag_TruckBFM) then
  begin
    if nOutBill='' then Exit;
    FListA.Clear;
    FListA.Text := nOutBill;
    nStr := 'Select P_ID from %s where P_Bill in (%s)';
    nStr := Format(nStr, [sTable_PoundLog,
      AdjustListStrFormat2(FListA, '''', True, ',', False)]);

    with FDM.QuerySQL(nStr) do
    begin
      if RecordCount < 1 then Exit;

      First;
      nIdx:=0;
      while not Eof do
      begin
        PrintSalePoundReport(Fields[0].AsString, nIdx=0);

        Inc(nIdx);
        Next;
      end;
    end;
  end;
end;

//Desc: �������
procedure TfFrameManualPoundItem.BtnSaveClick(Sender: TObject);
var nBool: Boolean;
begin
  nBool := False;
  try
    BtnSave.Enabled := False;
    ShowWaitForm(ParentForm, '���ڱ������', True);

    if (FInnerData.FPType=sFlag_Sale) or (FInnerData.FPType=sFlag_Dispatch) then
         nBool := SavePoundSale
    else nBool := SavePoundData;

    if nBool then
    begin
      gPoundTunnelManager.ClosePort(FPoundTunnel.FID);
      //�رձ�ͷ

      if RadioCC.Checked then
        PrintPoundReport(FUIData.FPoundID, True);
      //����ģʽ

      SetUIData(True);
      BroadcastFrameCommand(Self, cCmd_RefreshData);
      ShowMsg('���ر������', sHint);
    end;
  finally
    BtnSave.Enabled := not nBool;
    CloseWaitForm;
  end;
end;

procedure TfFrameManualPoundItem.EditPIDKeyPress(Sender: TObject;
  var Key: Char);
var nStr: string;
    nP: TFormCommandParam;
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    if EditPID.Properties.ReadOnly then Exit;

    if EditPID.ItemIndex >= 0 then
    begin
      nStr := EditPID.Properties.Items[EditPID.ItemIndex];
      if nStr = EditPID.Text then
      begin
        EditMIDPropertiesChange(EditPID);
        Exit; //���¼��ع�Ӧ����
      end;
    end;

    nP.FParamA := EditPID.Text;
    CreateBaseFormItem(cFI_FormGetCustom, FPopedom, @nP);
    if (nP.FCommand <> cCmd_ModalResult) or (nP.FParamA <> mrOK) then Exit;

    SetCtrlData(EditPID, nP.FParamB);
    if EditPID.ItemIndex < 0 then
    begin
      nStr := Format('%s=%s', [nP.FParamB, nP.FParamC]);
      InsertStringsItem(EditPID.Properties.Items, nStr);
      SetCtrlData(EditPID, nP.FParamB);
    end;
  end;
end;

//Date: 2014-12-28
//Parm: �貢����
//Desc: �ӵ�ǰ�ͻ����ö����п���ָ�������µ�
function TfFrameManualPoundItem.MakeNewSanBill(nBillValue: Double): Boolean;
var nDec: Double;
    nIdx,nInt, i: Integer;
    nP: TFormCommandParam;
    nOrder: TOrderItemInfo;
    nNewBill: TLadingBillItems;
    nStr, nOutBill: string;
begin
  FListA.Clear;
  Result := False;

  for nIdx:=Low(FBillItems) to High(FBillItems) do
    FListA.Add(FBillItems[nIdx].FZhiKa);
  nStr := AdjustListStrFormat2(FListA, '''', True, ',', False, False);

  FListB.Clear;
  FListB.Values['MeamKeys'] := nStr;

  if (not GetSQLQueryOrder(nStr, '103', FListB.Text)) or (nStr='') then Exit;

  with FDM.QueryTemp(nStr, True) do
  begin
    if RecordCount < 1 then
    begin
      nStr := StringReplace(FListA.Text, #13#10, ',', [rfReplaceAll]);
      nStr := Format('����[ %s ]��Ϣ�Ѷ�ʧ.', [nStr]);

      ShowDlg(nStr, sHint);
      Exit;
    end;

    SetLength(FOrderItems, RecordCount);
    nInt := 0;
    First;

    while not Eof do
    begin
      with FOrderItems[nInt] do
      begin
        FOrder := FieldByName('pk_meambill').AsString;
        FMaxValue := FieldByName('NPLANNUM').AsFloat;
        FKDValue := 0;
      end;

      Inc(nInt);
      Next;
    end;
  end;

  if not GetOrderFHValue(FListA) then Exit;
  //��ȡ�ѷ�����

  for nIdx:=Low(FOrderItems) to High(FOrderItems) do
  with FOrderItems[nIdx] do
  begin
    nStr := FListA.Values[FOrder];
    if not IsNumber(nStr, True) then Continue;

    i := -1;
    for nInt:=Low(FBillItems) to High(FBillItems) do
    if FBillItems[nInt].FZhiKa = FOrder then
    begin
      i := nInt;
      FMaxValue := FMaxValue - Float2Float(StrToFloat(nStr), cPrecision, False)
        - FBillItems[nInt].FValue;
      //������ = �ƻ��� - �ѷ��� - ������

      Break;
    end;

    if i <> nInt then FMaxValue := 0;
  end;

  //----------------------------------------------------------------------------
  for nIdx:=Low(FOrderItems) to High(FOrderItems) do
  begin
    with FOrderItems[nIdx] do
    begin
      if FMaxValue <= 0 then Break;
      //�޿�����

      if nBillValue <= 0 then Break;
      //�ѿ������

      nDec := FMaxValue;
      if nDec >= nBillValue then
        nDec := nBillValue;
      //����������

      FKDValue := nDec;
      nBillValue := Float2Float(nBillValue - nDec, cPrecision, True);
    end;
  end;

  FDM.ADOConn.BeginTrans;
  try
    for nIdx:=Low(FOrderItems) to High(FOrderItems) do
    with FOrderItems[nIdx] do
    begin
      if FKDValue <= 0 then Continue;
      //�޿�����

      for nInt:=Low(FBillItems) to High(FBillItems) do
      begin
        if FBillItems[nInt].FZhiKa <> FOrder then Continue;
        //xxxxx

        if FBillItems[nInt].FBillOrign = sFlag_BillZX then
        begin
          nStr := 'Update %s Set B_Freeze=B_Freeze+%.2f Where B_ID=''%s''';
          nStr := Format(nStr, [sTable_Order, FKDValue, FOrder]);
          FDM.ExecuteSQL(nStr);
        end;

        nStr := 'Update %s Set L_Value=L_Value+%.2f Where L_ID=''%s''';
        nStr := Format(nStr, [sTable_Bill, FKDValue, FBillItems[nInt].FID]);
        FDM.ExecuteSQL(nStr);
      end;
    end;

    FDM.ADOConn.CommitTrans;
    //���������
  except
    on E: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(E.Message, sHint);
      Exit;
    end;
  end;

  for nIdx:=Low(FOrderItems) to High(FOrderItems) do
  with FOrderItems[nIdx] do
  begin
    if FKDValue <= 0 then Continue;
    //�޿�����

    for nInt:=Low(FBillItems) to High(FBillItems) do
    begin
      if FBillItems[nInt].FZhiKa <> FOrder then Continue;
      //xxxxx

      FBillItems[nInt].FValue := FBillItems[nInt].FValue + FKDValue;
      //���¿�����

      FInnerData.FValue := FInnerData.FValue + FKDValue;
      FUIData.FValue := FInnerData.FValue;
    end;
  end;

  if nBillValue <= 0 then
  begin
    Result := True;
    Exit;
  end;
  //�ѿ������

  //----------------------------------------------------------------------------
  nStr := '���η���������[ %.2f ]��,��ѡ���µĶ���.';
  nStr := Format(nStr, [nBillValue]);
  ShowDlg(nStr, sHint);

  while True do
  begin
    nP.FParamA := FBillItems[0].FCusID;
    nP.FParamB := FBillItems[0].FStockNo;
    nP.FParamD := FBillItems[0].FCard;
    nP.FParamC := FBillItems[0].FPType;
    CreateBaseFormItem(cFI_FormGetOrder, PopedomItem, @nP);

    if (nP.FCommand <> cCmd_ModalResult) or (nP.FParamA <> mrOK) then Exit;
    nStr := nP.FParamB;

    AnalyzeOrderInfo(nStr, nOrder);
    if nOrder.FValue >= nBillValue then Break;

    nStr := '��������������,��������: ' + #13#10#13#10 +
            '��.������: %.2f ��'  + #13#10 +
            '��.������: %.2f ��'  + #13#10 +
            '��.��  ��: %.2f ��'  + #13#10#13#10 +
            '������ѡ�񶩵�.';
    nStr := Format(nStr, [nOrder.FValue, nBillValue, nBillValue - nOrder.FValue]);
    ShowDlg(nStr, sHint);
  end;

  nStr := 'Select * from %s b Left join %s p on b.L_ID=p.P_Bill ' +
          'where b.L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, sTable_PoundLog, FBillItems[0].FID]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      nStr := '������[ %s ]�Ѷ�ʧ,����ϵ����Ա.';
      nStr := Format(nStr, [FBillItems[0].FID]);

      ShowDlg(nStr, sHint);
      Exit;
    end;

    SetLength(nNewBill, 1);
    with nNewBill[0] do
    begin
      FSelected := True;
      FPoundID := sFlag_Yes;

      FCusID := nOrder.FCusID;
      FCusName:= nOrder.FCusName;

      FZhiKa := nOrder.FOrders;
      FCard  := nOrder.FBillID;

      FStockNo:= nOrder.FStockID;
      FStockName:=nOrder.FStockName;

      if nOrder.FBatchCode <> '' then
           FBatchCode := nOrder.FBatchCode
      else FBatchCode := FieldByName('L_Seal').AsString;

      FValue := nOrder.FValue;
      with FPData do
      begin
        FStation := FieldByName('P_PStation').AsString;
        FOperator:= FieldByName('P_PMan').AsString;
        FValue := FieldByName('L_PValue').AsFloat;
      end;

      FType := FieldByName('P_MType').AsString;
      FPType := FieldByName('P_Type').AsString;
      FPModel := FieldByName('P_PModel').AsString;
      FTruck := FieldByName('L_Truck').AsString;
      FNextStatus := sFlag_TruckBFP;

      FFactory := FieldByName('P_FactID').AsString;

      if not SaveLadingBills(FNextStatus, CombineBillItmes(nNewBill),
        nOutBill, nStr) then
      begin
        ShowDlg(nStr, sHint);
        Exit;
      end;
    end;

    FListA.Text := nOutBill;
    nNewBill[0].FID := FListA[0];
    nInt := Length(FBillItems);
    SetLength(FBillItems, nInt + 1);
    FBillItems[nInt] := nNewBill[0];

    FInnerData.FValue := FInnerData.FValue + nNewBill[0].FValue;
    FUIData := FInnerData;
  end;
  //�����µ�
  Result := True;
end;

procedure TfFrameManualPoundItem.EditBatchCodeEnter(Sender: TObject);
begin
  inherited;
  SelectNCBatchCode;
end;

procedure TfFrameManualPoundItem.SelectNCBatchCode;
var nP: TFrameCommandParam;
begin
  if (Length(FBillItems)<=0) or
    ((FInnerData.FPType<>sFlag_Sale) and (FInnerData.FPType<>sFlag_Dispatch))
  then Exit;

  nP.FParamA := FUIData.FStockNo;
  CreateBaseFormItem(cFI_FormGetNCBatch, '', @nP);

  if (nP.FParamA = mrOK) and (nP.FCommand=cCmd_ModalResult) then
       EditBatchCode.Text := nP.FParamB
  else EditBatchCode.Text := '';

  FInnerData:=FUIData;
  FInnerData.FBatchCode := EditBatchCode.Text;
  FUIData := FInnerData;
end;

procedure TfFrameManualPoundItem.EditBatchCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = Char(VK_RETURN) then
  begin
    Key := #0;        
    SelectNCBatchCode;
  end;
end;

procedure TfFrameManualPoundItem.BtnTruckPClick(Sender: TObject);
var nPValue: Double;
begin
  inherited;
  //ȡ����Ԥ��Ƥ��
  nPValue := GetTruckPValue(EditTruck.Text);
  if nPValue <= 0 then Exit;
  FHasGetP := True;

  if FInnerData.FPData.FValue>0 then
  begin
    AdjustProvideValue(nPValue);
  end
  else
  begin
    with FInnerData do
    begin
      FPData.FDate := Now;
      FPData.FValue := nPValue;
      FPData.FStation := FPoundTunnel.FID;
      FPData.FOperator := gSysParam.FUserID;
    end;

    FUIData := FInnerData;
    SetUIData(False);
  end;
end;

procedure TfFrameManualPoundItem.Timer_SaveFailTimer(Sender: TObject);
begin
  inherited;
  Timer_SaveFail.Enabled := False;
  SetUIData(True);
end;

end.
