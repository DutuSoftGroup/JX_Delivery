{*******************************************************************************
  ����: dmzn@163.com 2014-09-01
  ����: �������
*******************************************************************************}
unit UFormGetZhiKa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFormNormal, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, cxListView,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxMCListBox, dxLayoutControl,
  StdCtrls, ExtCtrls, cxGraphics;

type
  TOrderItem = record
    FBillID:string;         //С����
    FOrderID: string;       //�������
    FStockID: string;       //���ϱ��
    FStockName: string;     //��������
    FSaleMan: string;       //ҵ��Ա
    FTruck: string;         //���ƺ���
    FBatchCode: string;     //���κ�
    FAreaName: string;      //�����ص�
    FValue: Double;         //��������
    FPlanNum: Double;       //�ƻ���

    FMKBillUnit: string;    //�Ƶ���˾
    FMKBillMan:string;      //�Ƶ���
    FMKBillDate: TDateTime; //�Ƶ�ʱ��
  end;

  TfFormGetZhiKa = class(TfFormNormal)
    dxLayout1Item7: TdxLayoutItem;
    ListInfo: TcxMCListBox;
    dxLayout1Item10: TdxLayoutItem;
    EditName: TcxComboBox;
    dxGroup2: TdxLayoutGroup;
    dxLayout1Item3: TdxLayoutItem;
    ListDetail: TcxListView;
    dxLayout1Item4: TdxLayoutItem;
    EditStock: TcxComboBox;
    TimerDelay: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditNamePropertiesEditValueChanged(Sender: TObject);
    procedure EditNameKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOKClick(Sender: TObject);
    procedure EditStockPropertiesEditValueChanged(Sender: TObject);
    procedure TimerDelayTimer(Sender: TObject);
  protected
    { Private declarations }
    FCusID: string;
    //�ͻ����
    FStockID: string;
    //���ϱ��
    FOrderType: string;
    //��������
    FOldBill : string;
    //��ѡ����
    FLastCusID: string;
    //�ϴοͻ�
    FListA: TStrings;
    FItems: array of TOrderItem;
    //�����б�
    procedure InitFormData(const nID: string);
    //��������
    procedure ClearCustomerInfo;
    function LoadCustomerInfo(const nID: string): Boolean;
    function LoadCustomerData(const nID: string): Boolean;
    //����ͻ�
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  DB, IniFiles, ULibFun, UFormBase, UMgrControl, UAdjustForm, UDataModule,
  UFormWait, UBase64, USysGrid, USysDB, USysConst, UBusinessConst, USysLoger;

var
  gParam: PFormCommandParam = nil;
  //ȫ��ʹ��

procedure WriteLog(nEvent: string);
begin
  gSysLoger.AddLog(TfFormGetZhiKa, '�ͻ���ȡ����', nEvent);
end;

class function TfFormGetZhiKa.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
begin
  Result := nil;
  if not Assigned(nParam) then Exit;
  gParam := nParam;

  with TfFormGetZhiKa.Create(Application) do
  try
    Caption := 'ѡ�񶩵�';
    FCusID := gParam.FParamA;
    FStockID := gParam.FParamB;
    FOrderType := gParam.FParamC;
    FOldBill := gParam.FParamD;

    FListA := TStringList.Create;
    EditName.Properties.ReadOnly := FCusID <> '';
    TimerDelay.Enabled := True;

    gParam.FCommand := cCmd_ModalResult;
    gParam.FParamA := ShowModal;
  finally
    FListA.Free;
    Free;
  end;
end;

class function TfFormGetZhiKa.FormID: integer;
begin
  Result := cFI_FormGetOrder;
end;

procedure TfFormGetZhiKa.FormCreate(Sender: TObject);
begin
  FLastCusID := '';
  LoadFormConfig(Self);
  LoadMCListBoxConfig(Name, ListInfo);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormGetZhiKa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveMCListBoxConfig(Name, ListInfo);
  SavecxListViewConfig(Name, ListDetail);
  
  SaveFormConfig(Self);
  ReleaseCtrlData(Self);
end;

//------------------------------------------------------------------------------
procedure TfFormGetZhiKa.TimerDelayTimer(Sender: TObject);
begin
  TimerDelay.Enabled := False;
  InitFormData(FCusID);
end;

procedure TfFormGetZhiKa.InitFormData(const nID: string);
begin
  dxLayout1Item10.AlignVert := avBottom;
  dxLayout1Item7.AlignVert := avClient;
  dxGroup1.AlignVert := avTop;
  ActiveControl := EditName;
  
  if nID <> '' then
    LoadCustomerData(nID);
  //xxxxx
end;

//Desc: ����ͻ���Ϣ
procedure TfFormGetZhiKa.ClearCustomerInfo;
begin
  SetLength(FItems, 0);
  ListInfo.Clear;
  ListDetail.Clear;
  AdjustCXComboBoxItem(EditStock, True);
end;

function TfFormGetZhiKa.LoadCustomerData(const nID: string): Boolean;
begin
  Result := False;
  if nID = FLastCusID then Exit;
  FLastCusID := nID;

  try
    ShowWaitForm(Self, '��ȡ����', True);    
    LockWindowUpdate(Handle);
    Result := LoadCustomerInfo(nID);
  finally
    LockWindowUpdate(0);
    CloseWaitForm;
  end;
end;

//Desc: ����nID�ͻ�����Ϣ
function TfFormGetZhiKa.LoadCustomerInfo(const nID: string): Boolean;
var nStr, nBillCode: string;
    nIdx: Integer;
    nDS: TDataSet;
begin
  ClearCustomerInfo;
  if FOrderType = sFlag_Dispatch then
       nDS := UBusinessConst.LoadDispatchUnitInfo(nID, ListInfo, nStr)
  else nDS := UBusinessConst.LoadCustomerInfo(nID, ListInfo, nStr);
  Result := Assigned(nDS);

  if not Result then
  begin
    ShowMsg(nStr, sHint); Exit;
  end;

  if FOrderType = sFlag_Dispatch then
       nStr := nDS.FieldByName('unitname').AsString
  else nStr := nDS.FieldByName('custname').AsString;

  if GetStringsItemIndex(EditName.Properties.Items, nID) < 0 then
  begin
    nStr := Format('%s=%s', [nID, nStr]);
    InsertStringsItem(EditName.Properties.Items, nStr);
  end;

  SetCtrlData(EditName, nID);
  //customer info done

  if FOrderType = sFlag_Dispatch then
  begin
    //----------------------------------------------------------------------------
    FListA.Values['NoDate'] := sFlag_Yes;
    FListA.Values['Customer'] := nDS.FieldByName('unitname').AsString;
    FListA.Values['Order'] := 'invcode,invtype ASC';

    if not GetSQLQueryDispatch(nStr, '', FListA.Text) then
      Exit;
  end else
  begin
    //----------------------------------------------------------------------------
    FListA.Values['NoDate'] := sFlag_Yes;
    FListA.Values['CustomerID'] := nID;
    FListA.Values['Order'] := 'nmeamflag,NPLANNUM ASC';
    if FOrderType = sFlag_Sale then
         nStr := '103'
    else nStr := '203';
    if not GetSQLQueryOrder(nStr, nStr, FListA.Text) then
      Exit;
  end;    

  with FDM.QueryTemp(nStr, True) do
  begin
    if RecordCount < 1 then
    begin
      ShowMsg('���ȴ�������', sHint);
      Exit;
    end;

    InsertStringsItem(EditStock.Properties.Items, '1.ȫ������');
    SetLength(FItems, RecordCount);
    nIdx := 0;

    FListA.Clear;
    First;

    while not Eof do
    begin
      if FOrderType = sFlag_Dispatch then
           nStr := nDS.FieldByName('invcode').AsString
      else nStr := nDS.FieldByName('vmeaninvcode').AsString;
      //xxxxx

      nBillCode := FieldByName('vbillcode').AsString;
      if (FStockID = '') or ((FStockID = nStr) and (FOldBill<>nBillCode)) then
      begin
        with FItems[nIdx] do
        begin
          FBillID  := FieldByName('vbillcode').AsString;
          FOrderID := FieldByName('PK_MEAMBILL').AsString;
          FSaleMan := FieldByName('VBILLTYPE').AsString;

          FStockID := nStr;
          if FOrderType = sFlag_Dispatch then
               FStockName := nDS.FieldByName('invname').AsString
          else FStockName := nDS.FieldByName('vmeaminvname').AsString;

          FTruck := FieldByName('cvehicle').AsString;
          FBatchCode := FieldByName('vbatchcode').AsString;

          if FOrderType = sFlag_Provide then
          begin
            FAreaName := FieldByName('vdef10').AsString;
            ListDetail.Column[2].Caption := '����(��)';
            ListDetail.Column[3].Caption := '���';
          end else if FOrderType = sFlag_Sale then
          begin
            FAreaName := FieldByName('areaclname').AsString;
          end;

          FValue := 0;
          FPlanNum := FieldByName('NPLANNUM').AsFloat;
          FListA.Add(FOrderID);

          FMKBillUnit := FieldByName('unitname').AsString;
          FMKBillMan  := FieldByName('user_name').AsString;
          FMKBillDate := Str2DateTime(FieldByName('TMAKETIME').AsString);

          if GetStringsItemIndex(EditStock.Properties.Items, FStockID) < 0 then
          begin
            nStr := IntToStr(EditStock.Properties.Items.Count + 1);
            nStr := Format('%s=%s', [FStockID, nStr + '.' + FStockName]);
            InsertStringsItem(EditStock.Properties.Items, nStr);
          end;
        end;
      end else FItems[nIdx].FOrderID := '';

      Inc(nIdx);
      Next;
    end;

    if ((FOrderType = sFlag_Sale) or (FOrderType = sFlag_Dispatch))
      and (FListA.Count > 0) then
    begin
      if not GetOrderFHValue(FListA) then Exit;
      //��ȡ�ѷ�����

      for nIdx:=Low(FItems) to High(FItems) do
      begin
        nStr := FListA.Values[FItems[nIdx].FOrderID];
        if not IsNumber(nStr, True) then Continue;

        FItems[nIdx].FValue := FItems[nIdx].FPlanNum -
                               Float2Float(StrToFloat(nStr), cPrecision, True);
        //������ = �ƻ��� - �ѷ���
      end;
    end else

    if (FOrderType = sFlag_Provide) and (FListA.Count > 0) then
    begin
      if not GetOrderGYValue(FListA) then Exit;
      //��ȡ�ѹ�Ӧ��

      for nIdx:=Low(FItems) to High(FItems) do
      begin
        nStr := FListA.Values[FItems[nIdx].FOrderID];
        if not IsNumber(nStr, True) then Continue;

        FItems[nIdx].FValue := FItems[nIdx].FPlanNum -
                               Float2Float(StrToFloat(nStr), cPrecision, True);
        //������ = �ƻ��� - �ѹ�����
      end;
    end;
  end;

  EditStock.ItemIndex := 0;
  //Ĭ��ȫ��
end;

procedure TfFormGetZhiKa.EditStockPropertiesEditValueChanged(Sender: TObject);
var nStr: string;
    nIdx: Integer;
begin
  ListDetail.Clear;
  if EditStock.ItemIndex > 0 then
       nStr := GetCtrlData(EditStock)
  else nStr := '';

  for nIdx:=Low(FItems) to High(FItems) do
  begin
    if FItems[nIdx].FOrderID = '' then Continue;
    if (nStr <> '') and (nStr <> FItems[nIdx].FStockID) then Continue;
    //Ʒ��ƥ�䲻ͨ��

    if FloatRelation(FItems[nIdx].FValue, 0, rtLE, cPrecision) then Continue;
    //�޿����� 

    with ListDetail.Items.Add,FItems[nIdx] do
    begin
      Caption := FBillID;
      SubItems.Add(FStockName);
      SubItems.Add(Format('%.2f', [FValue]));
      SubItems.Add(FAreaName);

      Data := Pointer(nIdx);
    end;
  end;

  if ListDetail.Items.Count = 1 then
    ListDetail.Items[0].Checked := True;
  //xxxxx
end;

procedure TfFormGetZhiKa.EditNamePropertiesEditValueChanged(Sender: TObject);
begin
  if (EditName.ItemIndex > -1) and EditName.Focused then
    LoadCustomerData(GetCtrlData(EditName));
  //xxxxx
end;

//Desc: ѡ��ͻ�
procedure TfFormGetZhiKa.EditNameKeyPress(Sender: TObject; var Key: Char);
var nStr: string;
    nP: TFormCommandParam;
begin
  if Key = #13 then
  begin
    Key := #0;
    if EditName.Properties.ReadOnly then Exit;

    nP.FParamA := EditName.Text;
    CreateBaseFormItem(cFI_FormGetCustom, '', @nP);
    if (nP.FCommand <> cCmd_ModalResult) or (nP.FParamA <> mrOK) then Exit;
    
    FLastCusID := '';
    EditName.ItemIndex := -1;
    SetCtrlData(EditName, nP.FParamB);

    if EditName.ItemIndex < 0 then
    begin
      nStr := Format('%s=%s', [nP.FParamB, nP.FParamC]);
      InsertStringsItem(EditName.Properties.Items, nStr);
      SetCtrlData(EditName, nP.FParamB);
    end;
  end;
end;

procedure TfFormGetZhiKa.BtnOKClick(Sender: TObject);
var nStr: string;
    nIdx,nInt: Integer;
    nOrder: TOrderItemInfo;
begin
  FillChar(nOrder, SizeOf(nOrder), #0);
  FListA.Clear;
  nStr := '';

  for nIdx:=ListDetail.Items.Count - 1 downto 0 do
  if ListDetail.Items[nIdx].Checked then
  begin
    nInt := Integer(ListDetail.Items[nIdx].Data);
    if (nStr <> '') and (nStr <> FItems[nInt].FStockID) then
    begin
      ShowMsg('��ֹ��ͬƷ�ֺϵ�', sHint);
      Exit;
    end;

    if nStr = '' then //��һ��ѡ����
    begin
      with nOrder do
      begin
        FCusID := GetCtrlData(EditName);
        FCusName := EditName.Text;
        FStockID := FItems[nInt].FStockID;
        FStockName := FItems[nInt].FStockName;
        FSaleMan := FItems[nInt].FSaleMan;
        FValue := FItems[nInt].FValue;
        FBillID:= FItems[nInt].FBillID;
        FAreaName:=FItems[nInt].FAreaName;

        FMKBillUnit := FItems[nInt].FMKBillUnit;
        FMKBillMan  := FItems[nInt].FMKBillMan;
        FMKBillDate := FItems[nInt].FMKBillDate;
      end;

      nStr := FItems[nInt].FStockID;
      //�ο����Ϻ�
    end else
    begin
      if FOrderType = sFlag_Provide then
      begin
        ShowMsg('�ɹ�ҵ���ܲ���', sHint);
        Exit;
      end;

      nOrder.FValue := nOrder.FValue + FItems[nInt].FValue;
      //���ӿ�����
    end;

    if FItems[nInt].FTruck <> '' then
      nOrder.FTruck := FItems[nInt].FTruck;
    //���ƺ���

    if FItems[nInt].FBatchCode <> '' then
      nOrder.FBatchCode := FItems[nInt].FBatchCode;
    //���κ�

    FListA.Add(FItems[nInt].FOrderID);
  end;

  if nStr = '' then
  begin
    ShowMsg('����ѡ�񶩵�', sHint);
    Exit;
  end;

  nOrder.FOrders := FListA.Text;
  gParam.FParamB := BuildOrderInfo(nOrder);
  ModalResult := mrOk;
end;

initialization
  gControlManager.RegCtrl(TfFormGetZhiKa, TfFormGetZhiKa.FormID);
end.
