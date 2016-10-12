unit UBusinessConst;

interface
uses SysUtils, cxMCListBox, cxListView, UDataModule, Classes, DB, Controls;

type
  TPoundStationData = record
    FStation  : string;            //��վ��ʶ
    FValue    : Double;           //Ƥ��
    FDate     : TDateTime;        //��������
    FOperator : string;           //����Ա
  end;

  PLadingBillItem = ^TLadingBillItem;
  TLadingBillItem = record
    FID         : string;          //��������
    FCard       : string;          //billcode
    FZhiKa      : string;          //pk_meambill
    FCusID      : string;          //�ͻ����
    FCusName    : string;          //�ͻ�����
    FTruck      : string;          //���ƺ���

    FType       : string;          //Ʒ������
    FStockNo    : string;          //Ʒ�ֱ��
    FStockName  : string;          //Ʒ������
    FValue      : Double;          //�����
    FPrice      : Double;          //�������

    FBatchCode  : string;          //���κ�
    FBatckrest  : Double;          //������ʣ����

    FStatus     : string;
    FNextStatus : string;

    FPData      : TPoundStationData; //��Ƥ
    FMData      : TPoundStationData; //��ë
    FFactory    : string;          //�������
    FPModel     : string;          //����ģʽ
    FPType      : string;          //ҵ������
    FPoundID    : string;          //���ؼ�¼
    FSelected   : Boolean;         //ѡ��״̬

    FKZValue    : Double;         //��������
    FKZComment  : string;         //����ԭ��
    FPDValue    : Double;         //��������
    FAreaName   : string;         //�ص�

    FMKBillUnit : string;         //�Ƶ���˾
    FMKBillMan  : string;         //�Ƶ���
    FMKBillDate : TDateTime;      //�Ƶ�ʱ��
    FTransport  : string;         //���䵥λ

    FBillOrign  : string;         //������Դ��N��NC��S���Կ�����

    FNCChanged  : Boolean;         //NC�������仯
    FChangeValue: Double;          //NC ����
  end;

  TLadingBillItems = array of TLadingBillItem;
  //�������б�

  TOrderItemInfo = record    
    FCusID: string;       //�ͻ���
    FCusName: string;     //�ͻ���
    FCusCode: string;     //�ͻ�����
    FSaleID: string;     //ҵ��Ա
    FSaleMan: string;     //ҵ��Ա 
    FStockID: string;     //���Ϻ�
    FStockName: string;   //������
    FStockType: string;   //��������
    FTruck: string;       //���ƺ�
    FBatchCode: string;   //���κ�
    FOrders: string;      //������(�ɶ���)
    FValue: Double;       //������

    FAreaName: string;    //�����ص�
    FBillID: string;      //xxxx

    FMaxValue: Double;      //������
    FKDValue: Double;       //������

    FMKBillUnit: string;    //�Ƶ���˾
    FMKBillMan:string;      //�Ƶ���
    FMKBillDate: TDateTime; //�Ƶ�ʱ��
  end;

  TOrderItems = array of TOrderItemInfo;
  //�����б�

function GetSQLQueryOrder(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function GetSQLQueryCustomer(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function GetSQLQueryDispatch(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function GetSQLQueryBatchCode(var nOutData: string; nInData: string='';
  nExtParam: string=''):Boolean;

function GetOrderGYValueLocal(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function GetOrderFHValueLocal(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function GetOrderFHValue(const nOrders: TStrings;
  const nQueryFreeze: Boolean=True): Boolean;
function GetOrderGYValue(const nOrders: TStrings): Boolean;
function GetNCBatchSent(nBatch: string): Double;
function GetTruckPValue(nTruck: string):Double;

function GetQueryCustomerSQL(const nCusID,nCusName: string): string;

function PrintBillReport(nBill: string; const nAsk: Boolean): Boolean;
function PrintPoundReport(const nPound: string; nAsk: Boolean): Boolean;
function PrintSalePoundReport(const nPound: string; nAsk: Boolean): Boolean;

function SaveTruckPoundItem(const nStrBills: String;
  var nOutData:string): Boolean;
function SaveLadingBills(const nPost: string; const nStrBills: String;
  var nOutBillID, nErrHint: string): Boolean;

function GetLadingBills(nID: string; var nOutBills: TLadingBillItems):Boolean;
function GetTruckPoundItem(const nTruck: string;
  var nPoundData: TLadingBillItems): Boolean;

function GetSerailID(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function SyncNC_ME03(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
function SyncNC_ME25(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;

function GetNCBillTypeCHS(const nNCType: string; var nSysType: string): string;

procedure AnalyzeOrderInfo(const nOrder: string; var nItem: TOrderItemInfo);
function BuildOrderInfo(const nItem: TOrderItemInfo): string;
procedure LoadOrderInfo(const nOrder: TOrderItemInfo; const nList: TcxMCListBox);
function LoadCustomerInfo(const nCID: string; const nList: TcxMCListBox;
 var nHint: string): TDataSet;
function LoadDispatchUnitInfo(const nUID: string; const nList: TcxMCListBox;
 var nHint: string): TDataSet;

function CombineBillItmes(const nItems: TLadingBillItems): string;
procedure AnalyseBillItems(const nData: string; var nItems: TLadingBillItems);

function TruckInFact(nTruck: string):Boolean;
function GetHistoryTruckPValue(nTruck: string): Double;
function VerifyTruckPValue(nPValue: Double; nTruck: string; var nOut: string):Boolean;

function SaveBill(var nOutData:string; const nBillData: TStrings=nil): string;
function DeleteBill(const nBill: string): Boolean;
function ChangeLadingTruckNo(const nBill,nTruck: string): Boolean;

function GetSysValidDate: Integer;
function LoadSysDictItem(const nItem: string; const nList: TStrings): TDataSet;

implementation
uses USysDB, USysConst, UFormCtrl, ULibFun, UBase64, UDataReport,
     UBusinessPacker, UFormBase, USysLoger, ZnMD5;

//Date: 2015/4/9
//Parm: NC��������;
//Desc: ��ȡNC�������Ͷ�Ӧϵͳ�������ͣ�
function GetNCBillTypeCHS(const nNCType: string; var nSysType: string): string;
begin
  if CompareStr(UpperCase(nNCType), 'ME25')=0 then
  begin
    Result := nNCType + '������';
    nSysType := sFlag_Sale;
  end
  else if CompareStr(UpperCase(nNCType), 'ME09')=0 then
  begin
    Result := nNCType + '������';
    nSysType := sFlag_Dispatch;
  end
  else if CompareStr(UpperCase(nNCType), 'ME03')=0 then
  begin
    Result := nNCType + '����Ӧ';
    nSysType := sFlag_Provide;
  end;
end;
//Date: 2014-12-24
//Parm: ������(���)[FIn.FData]
//Desc: ��ȡ�������ѷ�����
function GetOrderFHValue(const nOrders: TStrings;
  const nQueryFreeze: Boolean): Boolean;
var nOutData, nFlag:string;
begin
  if nQueryFreeze then
       nFlag := sFlag_Yes
  else nFlag := sFlag_No;
  Result := GetOrderFHValueLocal(nOutData, nOrders.Text, nFlag);
  if Result then nOrders.Text := nOutData;
end;

//Date: 2015-01-08
//Parm: �����б�
//Desc: ��ȡָ���ķ�����
function GetOrderGYValue(const nOrders: TStrings): Boolean;
var nOutData:string;
begin
  Result := GetOrderGYValueLocal(nOutData, nOrders.Text);
  if Result then nOrders.Text := nOutData;
end;

//Date: 2014-09-17
//Parm: ����������;�������
//Desc: ����nDataΪ�ṹ���б�����
procedure AnalyseBillItems(const nData: string; var nItems: TLadingBillItems);
var nStr: string;
    nIdx,nInt: Integer;
    nListA,nListB: TStrings;
begin
  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    nListA.Text := PackerDecodeStr(nData);
    //bill list
    nInt := 0;
    SetLength(nItems, nListA.Count);

    for nIdx:=0 to nListA.Count - 1 do
    begin
      nListB.Text := PackerDecodeStr(nListA[nIdx]);
      //bill item

      with nListB,nItems[nInt] do
      begin
        FID         := Values['ID'];
        FCard       := Values['Card'];
        FZhiKa      := Values['ZhiKa'];
        FCusID      := Values['CusID'];
        FCusName    := Values['CusName'];
        FTruck      := Values['Truck'];

        FBatchCode  := Values['BatchCode'];

        FType       := Values['Type'];
        FStockNo    := Values['StockNo'];
        FStockName  := Values['StockName'];

        FStatus     := Values['Status'];
        FNextStatus := Values['NextStatus'];

        FFactory    := Values['Factory'];
        FPModel     := Values['PModel'];
        FPType      := Values['PType'];
        FPoundID    := Values['PoundID'];
        FSelected   := Values['Selected'] = sFlag_Yes;

        with FPData do
        begin
          FStation  := Values['PStation'];
          FDate     := Str2DateTime(Values['PDate']);
          FOperator := Values['PMan'];

          nStr := Trim(Values['PValue']);
          if (nStr <> '') and IsNumber(nStr, True) then
               FPData.FValue := StrToFloat(nStr)
          else FPData.FValue := 0;
        end;

        with FMData do
        begin
          FStation  := Values['MStation'];
          FDate     := Str2DateTime(Values['MDate']);
          FOperator := Values['MMan'];

          nStr := Trim(Values['MValue']);
          if (nStr <> '') and IsNumber(nStr, True) then
               FMData.FValue := StrToFloat(nStr)
          else FMData.FValue := 0;
        end;

        nStr := Trim(Values['Value']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FValue := StrToFloat(nStr)
        else FValue := 0;

        nStr := Trim(Values['Price']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FPrice := StrToFloat(nStr)
        else FPrice := 0;

        nStr := Trim(Values['KZValue']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FKZValue := StrToFloat(nStr)
        else FKZValue := 0;

        FKZComment := Values['KZComment'];
        FAreaName  := Values['AreaName'];
        FTransport := Values['Transport'];

        FMKBillUnit:= Values['MKBillUnit'];
        FMKBillMan := Values['MKBillMan'];
        FMKBillDate:= Str2DateTime(Values['MKBillDate']);

        FBillOrign := Values['BillOrgin'];
      end;

      Inc(nInt);
    end;
  finally
    nListB.Free;
    nListA.Free;
  end;
end;

//Date: 2014-09-18
//Parm: �������б�
//Desc: ��nItems�ϲ�Ϊҵ������ܴ����
function CombineBillItmes(const nItems: TLadingBillItems): string;
var nIdx: Integer;
    nListA,nListB: TStrings;
begin
  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    Result := '';
    nListA.Clear;
    nListB.Clear;

    for nIdx:=Low(nItems) to High(nItems) do
    with nItems[nIdx] do
    begin
      if not FSelected then Continue;
      //ignored

      with nListB do
      begin
        Values['ID']         := FID;
        Values['Card']       := FCard;
        Values['ZhiKa']      := FZhiKa;
        Values['CusID']      := FCusID;
        Values['CusName']    := FCusName;
        Values['Truck']      := FTruck;

        Values['Type']       := FType;
        Values['StockNo']    := FStockNo;
        Values['StockName']  := FStockName;
        Values['Value']      := FloatToStr(FValue);
        Values['Price']      := FloatToStr(FPrice);

        Values['Status']     := FStatus;
        Values['NextStatus'] := FNextStatus;

        Values['Factory']    := FFactory;
        Values['PModel']     := FPModel;
        Values['PType']      := FPType;
        Values['PoundID']    := FPoundID;

        with FPData do
        begin
          Values['PStation'] := FStation;
          Values['PValue']   := FloatToStr(FPData.FValue);
          Values['PDate']    := DateTime2Str(FDate);
          Values['PMan']     := FOperator;
        end;

        with FMData do
        begin
          Values['MStation'] := FStation;
          Values['MValue']   := FloatToStr(FMData.FValue);
          Values['MDate']    := DateTime2Str(FDate);
          Values['MMan']     := FOperator;
        end;

        if FSelected then
             Values['Selected'] := sFlag_Yes
        else Values['Selected'] := sFlag_No;

        Values['KZValue']    := FloatToStr(FKZValue);
        Values['KZComment']  := FKZComment;

        Values['BatchCode']  := FBatchCode;
        Values['AreaName']   := FAreaName;
        Values['Transport']  := FTransport;

        Values['MKBillUnit']:= FMKBillUnit;
        Values['MKBillMan'] := FMKBillMan;
        Values['MKBillDate']:= DateTime2Str(FMKBillDate);

        Values['BillOrgin'] := FBillOrign;
      end;

      nListA.Add(PackerEncodeStr(nListB.Text));
      //add bill
    end;

    Result := PackerEncodeStr(nListA.Text);
    //pack all
  finally
    nListB.Free;
    nListA.Free;
  end;
end;

//Date: 2014-12-23
//Parm: ������;��������
//Desc: ����nOrder,����nItem
procedure AnalyzeOrderInfo(const nOrder: string; var nItem: TOrderItemInfo);
var nList: TStrings;
begin
  nList := TStringList.Create;
  try
    with nList,nItem do
    begin
      Text := DecodeBase64(nOrder);
      //����

      FCusID := Values['CusID'];
      FCusName := Values['CusName'];
      FSaleMan := Values['SaleMan'];
      FStockID := Values['StockID'];
      FStockName := Values['StockName'];
      FTruck := Values['Truck'];
      FBatchCode := Values['BatchCode'];
      FOrders := PackerDecodeStr(Values['Orders']);
      FValue := StrToFloat(Values['Value']);
      FBillID:= Values['BillID'];
      FAreaName:= Values['AreaName'];
      
      FMKBillUnit:= Values['MKBillUnit'];
      FMKBillMan := Values['MKBillMan'];
      FMKBillDate:= Str2DateTime(Values['MKBillDate']);
    end;
  finally
    nList.Free;
  end;
end;

//Date: 2014-12-23
//Parm: ������
//Desc: ��nItem���ݴ��
function BuildOrderInfo(const nItem: TOrderItemInfo): string;
var nList: TStrings;
begin
  nList := TStringList.Create;
  try
    with nList,nItem do
    begin
      Clear;
      Values['CusID']     := FCusID;
      Values['CusName']   := FCusName;
      Values['SaleMan']   := FSaleMan;
      Values['StockID']   := FStockID;
      Values['StockName'] := FStockName;
      Values['Truck']     := FTruck;
      Values['BatchCode'] := FBatchCode;
      Values['Orders']    := PackerEncodeStr(FOrders);
      Values['Value']     := FloatToStr(FValue);
      Values['BillID']    := FBillID;
      Values['AreaName']  := FAreaName;

      Values['MKBillUnit']:= FMKBillUnit;
      Values['MKBillMan'] := FMKBillMan;
      Values['MKBillDate']:= DateTime2Str(FMKBillDate);
    end;

    Result := EncodeBase64(nList.Text);
    //����
  finally
    nList.Free;
  end;
end;

//Date: 2014-12-23
//Parm: ����;�б�
//Desc: ��nOrder��ʵ��nList��
procedure LoadOrderInfo(const nOrder: TOrderItemInfo; const nList: TcxMCListBox);
var nStr: string;
begin
  with nList.Items, nOrder do
  begin
    Clear;
    nStr := StringReplace(FOrders, #13#10, ',', [rfReplaceAll]);

    Add('�ͻ����:' + nList.Delimiter + FCusID + ' ');
    Add('�ͻ�����:' + nList.Delimiter + FCusName + ' ');
    Add('ҵ������:' + nList.Delimiter + FSaleMan + ' ');
    Add('���ϱ��:' + nList.Delimiter + FStockID + ' ');
    Add('��������:' + nList.Delimiter + FStockName + ' ');
    Add('�������:' + nList.Delimiter + nStr + ' ');
    Add('�������:' + nList.Delimiter + Format('%.2f',[FValue]) + ' ��');
  end;
end;

//Desc: ����nCID�ͻ�����Ϣ��nList��,���������ݼ�
function LoadCustomerInfo(const nCID: string; const nList: TcxMCListBox;
 var nHint: string): TDataSet;
var nStr: string;
begin
  nStr := 'select custcode,t2.pk_cubasdoc,custname,user_name,' +
          't1.createtime from Bd_cumandoc t1' +
          '  left join bd_cubasdoc t2 on t2.pk_cubasdoc=t1.pk_cubasdoc' +
          '  left join sm_user t_su on t_su.cuserid=t1.creator ' +
          ' where custcode=''%s''';
  nStr := Format(nStr, [nCID]);

  nList.Clear;
  Result := FDM.QueryTemp(nStr, True);

  if Result.RecordCount > 0 then
  with nList.Items,Result do
  begin
    Add('�ͻ����:' + nList.Delimiter + FieldByName('custcode').AsString);
    Add('�ͻ�����:' + nList.Delimiter + FieldByName('custname').AsString + ' ');
    Add('�� �� ��:' + nList.Delimiter + FieldByName('user_name').AsString + ' ');
    Add('����ʱ��:' + nList.Delimiter + FieldByName('createtime').AsString + ' ');
  end else
  begin
    Result := nil;
    nHint := '�ͻ���Ϣ�Ѷ�ʧ';
  end;
end;

function LoadDispatchUnitInfo(const nUID: string; const nList: TcxMCListBox;
 var nHint: string): TDataSet;
var nStr: string;
begin
  nStr := 'select * from Bd_Corp where pk_Corp=''%s''';
  nStr := Format(nStr, [nUID]);

  nList.Clear;
  Result := FDM.QueryTemp(nStr, True);

  if Result.RecordCount > 0 then
  with nList.Items,Result do
  begin
    Add('�ͻ����:' + nList.Delimiter + FieldByName('unitcode').AsString);
    Add('�ͻ�����:' + nList.Delimiter + FieldByName('unitname').AsString + ' ');
  end else
  begin
    Result := nil;
    nHint := '�ͻ���Ϣ�Ѷ�ʧ';
  end;
end;

//------------------------------------------------------------------------------
//Desc: �����ֶ�����
function MakeField(const nDS: TDataSet; const nName: string; nPos: Integer;
 nField: string = ''): string;
var nStr: string;
begin
  if nPos > 0 then
       nStr := Format('%s_%d', [nName, nPos])
  else nStr := nName;

  if nField = '' then
    nField := nName;
  //xxxxx

  Result := Trim(nDS.FieldByName(nStr).AsString);
  Result := SF(nField, Result);
end;
//Date: 2015/4/9
//Parm: ����ID��
//Desc: ģ����ѯ�����б�
function GetLadingBills(nID: string; var nOutBills: TLadingBillItems):Boolean;
var nIdx: Integer;
    nStr: string;
    nP: TFormCommandParam;
    nListA, nListB, nListC:TStrings;
begin
  Result := False;

  nP.FParamA := nID;
  CreateBaseFormItem(cFI_FormGetNCBill, '', @nP);
  if (nP.FCommand <> cCmd_ModalResult) or (nP.FParamA <> mrOK) then
  begin
    Exit;
  end;

  Result := True;
  nListA := TStringList.Create;
  nListB := TStringList.Create;
  nListC := TStringList.Create;

  try
    nListA.Clear;
    nListA.Text := nP.FParamB;
    SetLength(nOutBills, nListA.Count);

    nListC.Clear;
    for nIdx:=0 to nListA.Count-1 do
    begin
      with nListB,nOutBills[nIdx] do
      begin
        Clear;
        Text := PackerDecodeStr(nListA[nIdx]);

        FID       := Values['BillID'];
        FCard     := Values['Card'];
        FZhiKa    := Values['ZhiKa'];

        FCusID    := Values['CusCode'];
        FCusName  := Values['CusName'];
        FAreaName := Values['AreaName'];
        //�ͻ���Ϣ

        FType     := Values['StockTP'];
        FStockNo  := Values['StockCD'];
        FStockName:= Values['StockNM'];
        FBatchCode:= Values['BatchCode'];
        //������Ϣ

        FTruck    := Values['Truck'];
        FValue    := StrToFloat(Values['KDValue']);
        //�����Լ�������

        GetNCBillTypeCHS(Values['BillType'], nStr);
        FPType    := nStr;
        //��������

        FMKBillUnit:= Values['MKBillUnit'];
        FMKBillMan := Values['MKBillMan'];
        FMKBillDate:= Str2DateTime(Values['MKBillDate']);

        FPoundID := '';
        FSelected := True;
        FNextStatus:=sFlag_TruckBFP;

        FBillOrign := Values['BillOrign'];
        nListC.Add(FCard);
      end;
    end;
  finally
    nListA.Free;
    nListB.Free;
    nListC.Free;
  end;
end;
//Date: 2015/4/9
//Parm: ���ƺ�
//Desc:  ���泵�ƺ�
function SaveTruck(nInData: string=''): Boolean;
var nStr: string;
begin
  Result := True;
  if nInData='' then Exit;

  nStr := 'Select Count(*) From %s Where T_Truck=''%s''';
  nStr := Format(nStr, [sTable_Truck, UpperCase(nInData)]);
  //xxxxx

  with FDM.QuerySQL(nStr) do
  if Fields[0].AsInteger < 1 then
  begin
    nStr := 'Insert Into %s(T_Truck, T_PY) Values(''%s'', ''%s'')';
    nStr := Format(nStr, [sTable_Truck, nInData, GetPinYinOfStr(nInData)]);
    FDM.ExecuteSQL(nStr);
  end;
end;
//Date: 2015/4/9
//Parm: ���ƺţ����ض�����Ϣ
//Desc:  ��ȡ���ƺ�δ��ɶ����б�
function GetTruckPoundItem(const nTruck: string;
  var nPoundData: TLadingBillItems): Boolean;
var nStr: string;
    nIdx: Integer;
begin
  nStr := 'Select * From %s left join %s on P_Bill=L_ID ' +
          'Where P_Truck=''%s'' And P_MValue Is Null And P_PModel=''%s''';
  nStr := Format(nStr, [sTable_PoundLog, sTable_Bill, nTruck, sFlag_PoundPD]);

  with FDM.QuerySQL(nStr) do
  begin
    if RecordCount > 0 then
    begin
      SetLength(nPoundData, RecordCount);

      First;
      nIdx := 0;
      while not Eof do
      begin
        with nPoundData[nIdx] do
        begin
          FID         := FieldByName('P_Bill').AsString;
          FCard       := FieldByName('P_Order').AsString;
          FBillOrign  := FieldByName('P_Card').AsString;

          FZhiKa      := FID;
          FCusID      := FieldByName('P_CusID').AsString;
          FCusName    := FieldByName('P_CusName').AsString;
          FTruck      := FieldByName('P_Truck').AsString;

          FType       := FieldByName('P_MType').AsString;
          FStockNo    := FieldByName('P_MID').AsString;
          FStockName  := FieldByName('P_MName').AsString;

          with FPData do
          begin
            FStation  := FieldByName('P_PStation').AsString;
            FValue    := FieldByName('P_PValue').AsFloat;
            FDate     := FieldByName('P_PDate').AsDateTime;
            FOperator := FieldByName('P_PMan').AsString;
          end;

          FValue      := FieldByName('P_LimValue').AsFloat;

          FFactory    := FieldByName('P_FactID').AsString;
          FPModel     := FieldByName('P_PModel').AsString;
          FPType      := FieldByName('P_Type').AsString;
          FPoundID    := FieldByName('P_ID').AsString;

          if FPType<>sFlag_Provide then
          begin
            FBatchCode:= FieldByName('L_Seal').AsString;
            FCard     := FieldByName('L_Card').AsString;
            FZhiKa    := FieldByName('L_ZhiKa').AsString;
          end;

          FStatus     := sFlag_TruckBFP;
          FNextStatus := sFlag_TruckBFM;

          FKZComment := FieldByName('P_KZComment').AsString;
          FTransport := FieldByName('P_Transport').AsString;
          FSelected   := True;
        end;
        Inc(nIdx);
        Next;
      end;
    end else
    begin
      SetLength(nPoundData, 1);
      FillChar(nPoundData[0], SizeOf(TLadingBillItem), #0);
      with nPoundData[0] do
      begin
        FTruck      := nTruck;
        FPModel     := sFlag_PoundPD;

        FStatus     := '';
        FNextStatus := sFlag_TruckBFP;
        FSelected   := True;
      end;
    end;
  end;

  Result := True;
end;
//Date: 2015/4/9
//Parm: �ͻ�ID;�ͻ�����
//Desc: ��ȡ�ͻ���Ϣ��ѯ���
function GetQueryCustomerSQL(const nCusID,nCusName: string): string;
var nSQL: string;
begin
  if GetSQLQueryCustomer(nSQL, nCusID, nCusName) then
       Result := nSQL
  else Result := '';
end;
//Date: 2015/4/9
//Parm: ������Ϣ����ѯ������
//Desc: ��ȡָ������ϵͳ������
function GetSerailID(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nInt: Integer;
    nStr,nP,nB: string;
    nListA: TStrings;
begin
  Result := False;
  nListA := TStringList.Create;
  try
    try
      nListA.Text := nInData;
      //param list

      nStr := 'Update %s Set B_Base=B_Base+1 ' +
              'Where B_Group=''%s'' And B_Object=''%s''';
      nStr := Format(nStr, [sTable_SerialBase, nListA.Values['Group'],
              nListA.Values['Object']]);
      FDM.ExecuteSQL(nStr);

      nStr := 'Select B_Prefix,B_IDLen,B_Base,B_Date,%s as B_Now From %s ' +
              'Where B_Group=''%s'' And B_Object=''%s''';
      nStr := Format(nStr, [sField_SQLServer_Now, sTable_SerialBase,
              nListA.Values['Group'], nListA.Values['Object']]);
      //xxxxx

      with FDM.QuerySQL(nStr) do
      begin
        if RecordCount < 1 then
        begin
          nOutData := 'û��[ %s.%s ]�ı�������.';
          nOutData := Format(nOutData, [nListA.Values['Group'], nListA.Values['Object']]);

          Exit;
        end;

        nP := FieldByName('B_Prefix').AsString;
        nB := FieldByName('B_Base').AsString;
        nInt := FieldByName('B_IDLen').AsInteger;

        if nExtParam = sFlag_Yes then //�����ڱ���
        begin
          nStr := Date2Str(FieldByName('B_Date').AsDateTime, False);
          //old date

          if (nStr <> Date2Str(FieldByName('B_Now').AsDateTime, False)) and
             (FieldByName('B_Now').AsDateTime > FieldByName('B_Date').AsDateTime) then
          begin
            nStr := 'Update %s Set B_Base=1,B_Date=%s ' +
                    'Where B_Group=''%s'' And B_Object=''%s''';
            nStr := Format(nStr, [sTable_SerialBase, sField_SQLServer_Now,
                    nListA.Values['Group'], nListA.Values['Object']]);
            FDM.ExecuteSQL(nStr);

            nB := '1';
            nStr := Date2Str(FieldByName('B_Now').AsDateTime, False);
            //now date
          end;

          System.Delete(nStr, 1, 2);
          //yymmdd
          nInt := nInt - Length(nP) - Length(nStr) - Length(nB);
          nOutData := nP + nStr + StringOfChar('0', nInt) + nB;
        end else
        begin
          nInt := nInt - Length(nP) - Length(nB);
          nStr := StringOfChar('0', nInt);
          nOutData := nP + nStr + nB;
        end;
      end;

      Result := True;
    except
      raise;
    end;
  finally
    nListA.Free;
  end;
end;

function SaveTruckPoundItem(const nStrBills: String;
  var nOutData:string): Boolean;
var nBills: TLadingBillItems;
  nListA, nListB: TStrings;
  nStr, nSQL: string;
  nNet, nVal: Double;
  nProvide: Boolean;
  nIdx: Integer;
begin
  Result := False;
  AnalyseBillItems(nStrBills, nBills);
  if Length(nBills)<1 then Exit;

  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    nListA.Clear;

    FDM.ADOConn.BeginTrans;
    try
      with nBills[0] do
      begin
        nProvide := (FID <> '') and (FID = FZhiKa);
        //�Ƿ�Ӧ

        if FPoundID = '' then
        begin
          SaveTruck(FTruck);
          //���泵�ƺ�

          nListB.Clear;
          nListB.Values['Group'] := sFlag_BusGroup;
          nListB.Values['Object'] := sFlag_PoundID;

          if not GetSerailID(FPoundID, nListB.Text, sFlag_Yes) then
            raise Exception.Create(FPoundID);
          //xxxxx

          if FPModel = sFlag_PoundLS then
               nStr := sFlag_Other
          else if nProvide then
               nStr := sFlag_Provide
          else nStr := sFlag_NChange;

          nSQL := MakeSQLByStr([
                  SF('P_ID', FPoundID),
                  SF('P_Type', nStr),
                  SF('P_Bill', FZhiKa),
                  SF('P_Order', FCard),
                  SF('P_Truck', FTruck),
                  SF('P_CusID', FCusID),
                  SF('P_CusName', FCusName),
                  SF('P_MID', FStockNo),
                  SF('P_MName', FStockName),
                  SF('P_MType', sFlag_San),
                  SF('P_LimValue',FValue, sfVal),
                  SF('P_PValue', FPData.FValue, sfVal),
                  SF('P_PDate', sField_SQLServer_Now, sfVal),
                  SF('P_PMan', FPData.FOperator),
                  SF('P_FactID', FFactory),
                  SF('P_PStation', FPData.FStation),
                  SF('P_Direction', '����'),
                  SF('P_Transport', FTransport),
                  SF('P_PModel', FPModel),
                  SF('P_Status', sFlag_TruckBFP),
                  SF('P_Valid', sFlag_Yes),
                  SF('P_Areaname', FAreaName),
                  SF('P_PrintNum', 1, sfVal),
                  SF('P_KZComment', FKZComment)
                  ], sTable_PoundLog, '', True);
          nListA.Add(nSQL);
        end else if (FPData.FValue<=0) or (FMData.FValue<=0) then
        begin
          nOutData := '���ȳ���';
          raise Exception.Create(nOutData);
        end;
       
        if (FMData.FValue>0) and (FPData.FValue>0) then
        begin
          if FMData.FValue > FPData.FValue then
          begin
            nVal := FPData.FValue;
            nNet := FMData.FValue - FPData.FValue;
          end else begin
            nVal := FMData.FValue;
            nNet := FPData.FValue - FMData.FValue;
          end;

          if not VerifyTruckPValue(nVal, FTruck, nOutData) then
          begin
            if not QueryDlg(nOutData, sHint) then
            begin
               nOutData := '���鳵��״̬';
               raise Exception.Create(nOutData);
            end;
          end;  

          nVal := 0;
          nStr := 'Select D_CusID,D_Value,D_Type From %s ' +
                  'Where D_Stock=''%s'' And D_Valid=''%s''';
          nStr := Format(nStr, [sTable_Deduct, FStockNo, sFlag_Yes]);

          with FDM.QuerySQL(nStr) do
          if RecordCount > 0 then
          begin
            First;

            while not Eof do
            begin
              if FieldByName('D_CusID').AsString = FCusID then
                Break;
              //�ͻ�+���ϲ�������

              Next;
            end;

            if Eof then First;
            //ʹ�õ�һ������

            //���ۼ���
            nStr := FieldByName('D_Type').AsString;

            if nStr = sFlag_DeductFix then
              nVal := FieldByName('D_Value').AsFloat;
            //��ֵ�ۼ�

            if nStr = sFlag_DeductPer then
            begin
              nVal := FieldByName('D_Value').AsFloat;
              nVal := nNet * nVal;
            end; //�����ۼ�

            if (nVal > 0) and (nNet > nVal) then
            begin
              if FMData.FValue > FPData.FValue then
                   FMData.FValue := (FMData.FValue*1000 - nVal*1000) / 1000
              else FPData.FValue := (FPData.FValue*1000 - nVal*1000) / 1000;
            end;
          end;

          if FNextStatus = sFlag_TruckBFP then
          begin
            nSQL := MakeSQLByStr([
                    SF('P_PValue', FPData.FValue, sfVal),
                    SF('P_PDate', sField_SQLServer_Now, sfVal),
                    SF('P_PMan', FPData.FOperator),
                    SF('P_PStation', FPData.FStation),
                    SF('P_MValue', FMData.FValue, sfVal),
                    SF('P_MDate', DateTime2Str(FMData.FDate)),
                    SF('P_MMan', FMData.FOperator),
                    SF('P_MStation', FMData.FStation),
                    SF('P_Transport', FTransport),
                    SF('P_PDValue', nVal, sfVal),
                    SF('P_KZValue', FKZValue, sfVal),
                    SF('P_KZComment', FKZComment)
                    ], sTable_PoundLog, SF('P_ID', FPoundID), False);
            //����ʱ,����Ƥ�ش�,����Ƥë������
            nListA.Add(nSQL);
          end else
          begin
            nSQL := MakeSQLByStr([
                    SF('P_MValue', FMData.FValue, sfVal),
                    SF('P_MDate', sField_SQLServer_Now, sfVal),
                    SF('P_MMan', FMData.FOperator),
                    SF('P_MStation', FMData.FStation),
                    SF('P_Transport', FTransport),
                    SF('P_PDValue', nVal, sfVal),
                    SF('P_KZValue', FKZValue, sfVal),
                    SF('P_KZComment', FKZComment)
                    ], sTable_PoundLog, SF('P_ID', FPoundID), False);
            //xxxxx
            nListA.Add(nSQL);
          end;

        end;

        //----------------------------------------------------------------------
        for nIdx:=0 to nListA.Count-1 do
          FDM.ExecuteSQL(nListA[nIdx]);

        if nProvide
         and ((FPData.FValue>0) and (FMData.FValue>0))
         and (not SyncNC_ME03(nOutData, FPoundID, '')) then
          raise Exception.Create(nOutData);
        //ͬ����Ӧ��NC
        
        FDM.ADOConn.CommitTrans;
        nOutData := FPoundID;
        Result := True;
      end;
    except
      on nErr: Exception do
      begin
        FDM.ADOConn.RollbackTrans;
        nOutData := nErr.Message;
        Exit;
      end;
    end;
  finally
    nListA.Free;
    nListB.Free;
  end;
end;


//Date: 2014-09-18
//Parm: ��λ;�������б�;�ѱ��潻�����б�
//Desc: ����nPost��λ�ϵĽ���������
function SaveLadingBills(const nPost: string; const nStrBills: String;
  var nOutBillID, nErrHint: string): Boolean;
var FListA, FListB, FListC, FListBID: TStrings;
    nSQL, nTmp, nStr, nBID, nPID:string;
    nBills: TLadingBillItems;
    nInt, nIdx, i: Integer;
    nMVal, nVal: Double;
begin
  Result := False;
  AnalyseBillItems(nStrBills, nBills);
  if Length(nBills) < 1 then Exit;

  FListA := TStringList.Create;
  FListB := TStringList.Create;
  FListC := TStringList.Create;
  FListBID := TStringList.Create;
  try
    FListA.Clear;
    FListBID.Clear;

    FDM.ADOConn.BeginTrans;
    //--------------------------------------------------------------------------
    try
      if nPost = sFlag_TruckBFP then //����Ƥ��
      begin
        nInt := -1;
        for nIdx:=Low(nBills) to High(nBills) do
        if nBills[nIdx].FPoundID = sFlag_Yes then
        begin
          nInt := nIdx;
          Break;
        end;

        if nInt < 0 then
        begin
          nErrHint := '��λ[ %s ]�ύ��Ƥ������Ϊ0.';
          nErrHint := Format(nErrHint, ['������Ƥ']);
          raise Exception.Create(nErrHint);
        end;

        if not VerifyTruckPValue(nBills[nIdx].FPData.FValue, nBills[nIdx].FTruck,
          nErrHint) then
        begin
          if not QueryDlg(nErrHint, sHint) then
          begin
             nErrHint := '���鳵��״̬';
             raise Exception.Create(nErrHint);
          end;
        end;

        SaveTruck(nBills[nIdx].FTruck);
        //���泵�ƺ�

        for nIdx:=Low(nBills) to High(nBills) do
        with nBills[nIdx] do
        begin
          FStatus := sFlag_TruckBFP;
          FNextStatus := sFlag_TruckBFM;

          if FBillOrign = sFlag_BillZX then
          begin
            nSQL := MakeSQLByStr([
                    SF('L_Status', FStatus),
                    SF('L_NextStatus', FNextStatus),
                    SF('L_PValue', nBills[nInt].FPData.FValue, sfVal),
                    SF('L_PDate', sField_SQLServer_Now, sfVal),
                    SF('L_PMan', nBills[nInt].FPData.FOperator)
                    ], sTable_Bill, SF('L_ID', FID), False);
            FListA.Add(nSQL);

            nBID := FID;
          end
          else
          begin
            FListC.Clear;
            FListC.Values['Group'] :=sFlag_BusGroup;
            FListC.Values['Object'] := sFlag_BillNo;
            //to get serial no

            if not GetSerailID(nBID, FListC.Text , sFlag_Yes) then
              raise Exception.Create(nBID);
            //xxxxx

            nSQL := MakeSQLByStr([
                    SF('L_ID', nBID),
                    SF('L_Card', FCard),
                    SF('L_ZhiKa', FZhiKa),
                    SF('L_CusID', FCusID),
                    SF('L_CusName', FCusName),
                    SF('L_CusPY', GetPinYinOfStr(FCusName)),

                    SF('L_Project', FMKBillUnit),
                    SF('L_Man', FMKBillMan),
                    SF('L_Date', sField_SQLServer_Now, sfVal),

                    SF('L_Type', FType),
                    SF('L_Seal', FBatchCode),
                    SF('L_StockNo', FStockNo),
                    SF('L_StockName', FStockName),

                    SF('L_Status', FStatus),
                    SF('L_NextStatus', FNextStatus),
                    SF('L_PValue', nBills[nInt].FPData.FValue, sfVal),
                    SF('L_PDate', sField_SQLServer_Now, sfVal),
                    SF('L_Truck', nBills[nInt].FTruck),
                    SF('L_PMan', nBills[nInt].FPData.FOperator)
                    ], sTable_Bill, '', True);
            FListA.Add(nSQL);
          end;

          FListC.Clear;
          FListC.Values['Group'] := sFlag_BusGroup;
          FListC.Values['Object'] := sFlag_PoundID;

          if not GetSerailID(nPID, FListC.Text , sFlag_Yes) then
            raise Exception.Create(nPID);
          //xxxxx

          nSQL := MakeSQLByStr([
                  SF('P_ID', nPID),
                  SF('P_Card', FBillOrign),
                  SF('P_Type', FPType),
                  SF('P_Bill', nBID),
                  SF('P_Order', FCard),
                  SF('P_Truck', FTruck),
                  SF('P_CusID', FCusID),
                  SF('P_CusName', FCusName),
                  SF('P_MID', FStockNo),
                  SF('P_MName', FStockName),
                  SF('P_MType', FType),
                  SF('P_LimValue', FValue, sfVal),
                  SF('P_PValue', nBills[nInt].FPData.FValue, sfVal),
                  SF('P_PDate', sField_SQLServer_Now, sfVal),
                  SF('P_PMan', nBills[nInt].FPData.FOperator),
                  SF('P_FactID', nBills[nInt].FFactory),
                  SF('P_PStation', nBills[nInt].FPData.FStation),
                  SF('P_Direction', '����'),
                  SF('P_AreaName', FAreaName),
                  SF('P_Transport', FTransport),
                  SF('P_PModel', FPModel),
                  SF('P_Status', sFlag_TruckBFP),
                  SF('P_Valid', sFlag_Yes),
                  SF('P_OutSeal', FBatchCode),
                  SF('P_KZComment', FKZComment),
                  SF('P_PrintNum', 1, sfVal)
                  ], sTable_PoundLog, '', True);
          FListA.Add(nSQL);

          FListBID.Add(nBID);
        end;
      end else

      //----------------------------------------------------------------------------
      if nPost = sFlag_TruckBFM then //����ë��
      begin
        nInt := -1;

        for nIdx:=Low(nBills) to High(nBills) do
        if nBills[nIdx].FPoundID = sFlag_Yes then
        begin
          nInt := nIdx;
          Break;
        end;

        if nInt < 0 then
        begin
          nErrHint := '��λ[ %s ]�ύ��ë������Ϊ0.';
          nErrHint := Format(nErrHint, ['������ë']);
          raise Exception.Create(nErrHint);
        end;

        nMVal:= 0;
        FListB.Clear;
        FListC.Clear;

        for nIdx:=Low(nBills) to High(nBills) do
        with nBills[nIdx] do
        begin
          FListC.Add(FID);
          nMVal := nMVal + FMData.FValue - FPData.FValue;

          if FPModel <> sFlag_PoundCC then
          begin
            nSQL := 'Select L_ID From %s Where L_ID=''%s'' And L_MValue Is Null';
            nSQL := Format(nSQL, [sTable_Bill, FID]);
            //δ��ë�ؼ�¼

            with FDM.QuerySQL(nSQL) do
            if RecordCount > 0 then
            begin
              First;

              while not Eof do
              begin
                FListB.Add(Fields[0].AsString);
                Next;
              end;
            end;
          end;
        end;

        for nIdx:=Low(nBills) to High(nBills) do
        with nBills[nIdx] do
        begin
          if nBills[nInt].FPModel = sFlag_PoundCC then
          begin
            i:= FListC.IndexOf(FID);
            if i>=0 then FListC.Delete(i);
            Continue;
          end;
          //����ģʽ,������״̬

          i := FListB.IndexOf(FID);
          if i >= 0 then
            FListB.Delete(i);
          //�ų����γ���

          if FType = sFlag_San then
               nVal:=FMData.FValue-FPData.FValue
          else nVal:=FValue;
          nMVal := nMVal - nVal;                           

          FBatckrest := 0;
          GetSQLQueryBatchCode(nStr, FStockNo, FBatchCode);
          with FDM.QueryTemp(nStr, True) do
          begin
            if RecordCount<1 then
            begin
              nErrHint := '����[%s]�����α���[%s]������';
              nErrHint := Format(nErrHint, [FStockName, FBatchCode]);
              raise Exception.Create(nErrHint);
            end;

            FBatckrest := FieldByName('nbatch').AsFloat -
              FieldByName('nlock').AsFloat - FieldByName('nsent').AsFloat
              - GetNCBatchSent(FBatchCode);
          end;

          if FBatckrest < nVal then
          begin
            nErrHint := '����[%s]�����α���[%s]����������Χ�������';
            nErrHint := Format(nErrHint, [FStockName, FBatchCode]);
            raise Exception.Create(nErrHint);
          end;

          nSQL := MakeSQLByStr([
                  SF('P_MValue', FMData.FValue, sfVal),
                  SF('P_PValue', FPData.FValue, sfVal),
                  SF('P_MDate', sField_SQLServer_Now, sfVal),
                  SF('P_MMan', nBills[nInt].FMData.FOperator),
                  SF('P_KZValue', 0, sfVal),
                  SF('P_KZComment', FKZComment),
                  SF('P_OutSeal', FBatchCode),
                  SF('P_Transport', FTransport),
                  SF('P_MStation', nBills[nInt].FMData.FStation)
                  ], sTable_PoundLog, SF('P_Bill', FID), False);
          FListA.Add(nSQL);
          //������Ϣ

          nSQL := MakeSQLByStr([SF('L_Value', nVal, sfVal),
                  SF('L_Status', sFlag_TruckBFM),
                  SF('L_NextStatus', ''),
                  SF('L_Seal', FBatchCode),
                  SF('L_MValue', FMData.FValue , sfVal),
                  SF('L_PValue', FPData.FValue, sfVal),
                  SF('L_MDate', sField_SQLServer_Now, sfVal),
                  SF('L_MMan', FMData.FOperator)
                  ], sTable_Bill, SF('L_ID', FID), False);
          FListA.Add(nSQL);
          //������Ϣ

          if FBillOrign = sFlag_BillZX then
          begin
            nSQL := 'Update %s Set B_HasDone=B_HasDone+(%.2f),' +
                    'B_Freeze=B_Freeze-(%.2f) Where B_ID=''%s''';
            nSQL := Format(nSQL, [sTable_Order, nVal, nVal, FZhiKa]);
            FListA.Add(nSQL); //���¶���
          end;  
        end;

        if FListB.Count > 0 then
        begin
          nTmp := AdjustListStrFormat2(FListB, '''', True, ',', False);
          //δ���ؽ������б�

          nStr := Format('L_ID In (%s)', [nTmp]);
          nSQL := MakeSQLByStr([
                  SF('L_PValue', nMVal, sfVal),
                  SF('L_PDate', sField_SQLServer_Now, sfVal),
                  SF('L_PMan', nBills[nInt].FMData.FOperator)
                  ], sTable_Bill, nStr, False);
          FListA.Add(nSQL);
          //û�г�ë�ص������¼��Ƥ��,���ڱ��ε�ë��

          nStr := Format('P_Bill In (%s)', [nTmp]);
          nSQL := MakeSQLByStr([
                  SF('P_PValue', nMVal, sfVal),
                  SF('P_PDate', sField_SQLServer_Now, sfVal),
                  SF('P_PMan', nBills[nInt].FMData.FOperator),
                  SF('P_KZValue', 0, sfVal),
                  SF('P_Transport', nBills[nInt].FTransport),
                  SF('P_KZComment', nBills[nInt].FKZComment),
                  SF('P_PStation', nBills[nInt].FMData.FStation)
                  ], sTable_PoundLog, nStr, False);
          FListA.Add(nSQL);
          //û�г�ë�صĹ�����¼��Ƥ��,���ڱ��ε�ë��
        end;

        FListBID.Text := FListC.Text;
      end;

      //------------------------------------------------------------------------
      for nIdx:=0 to FListA.Count - 1 do
        FDM.ExecuteSQL(FListA[nIdx]);
      //xxxxx

      if (nPost = sFlag_TruckBFM) and (FListC.Count>0) then
      if not SyncNC_ME25(nErrHint, FListC.Text, '') then
          raise Exception.Create(nErrHint);

      FDM.ADOConn.CommitTrans;

      nOutBillID := FListBID.Text;
      Result := True;
    except
      on E: Exception do
      begin
        FDM.ADOConn.RollbackTrans;
        ShowDlg(E.Message, sHint);
        nErrHint := '�������ʧ��';
        Exit;
      end;
    end;
  finally
    FListBID.Clear;
    FListA.Free;
    FListB.Free;
    FListC.Free;
  end;
end;

//Date: 2014-12-16
//Parm: ��ѯ����[nInData];��ѯ����[nExtParam]
//Desc: ���ݲ�ѯ����,����ָ�����Ͷ�����SQL��ѯ���
function GetSQLQueryOrder(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr,nType: string;
    nListA: TStrings;
begin
  Result := False;

  if nInData = '101' then           //���۶���
    nType := SF('VBILLTYPE', 'ME25')
  else if nInData = '102' then      //�������뵥
    nType := SF('VBILLTYPE', 'ME25')
  else if nInData = '103' then      //���۶��������뵥
    nType := SF('VBILLTYPE', 'ME25')

  else if nInData = '201' then      //�ɹ�����
    nType := SF('VBILLTYPE', 'ME03')
  else if nInData = '202' then      //�ɹ����뵥
    nType := SF('VBILLTYPE', 'ME03')
  else if nInData = '203' then      //�ɹ����������뵥
       nType := SF('VBILLTYPE', 'ME03')
  else nType := '';

  if nType = '' then
  begin
    nOutData := Format('��Ч�Ķ�����ѯ����( %s ).', [nInData]);
    Exit;
  end;

  nOutData := 'select ' +
     'distinct pk_meambill_b as pk_meambill,VBILLCODE,VBILLTYPE,COPERATOR,user_name,' +  //������ͷ
     'TMAKETIME,NPLANNUM,cvehicle,vbatchcode,unitname,areaclname,t1.vdef10,' +  //��������
     't1.pk_cumandoc,custcode,cmnecode,custname,t_cd.def30,' +                  //������Ϣ
     //'invcode,invname,invtype ' +                                             //����
     'vmeaninvcode,vmeaminvname,nmeamflag ' +                                   //
     'from meam_bill t1 ' +
     '  left join sm_user t_su on t_su.cuserid=t1.coperator ' +
     '  left join meam_bill_b t2 on t2.PK_MEAMBILL=t1.PK_MEAMBILL' +
     '  left join Bd_cumandoc t_cd on t_cd.pk_cumandoc=t1.pk_cumandoc' +
     '  left join bd_cubasdoc t_cb on t_cb.pk_cubasdoc=t_cd.pk_cubasdoc' +
     //'  left join Bd_invbasdoc t_ib on t_ib.pk_invbasdoc=t2.PK_INVBASDOC' +
     '  left join meam_invbasedoc t_ib on t_ib.pk_invmandoc=t2.pk_invmandoc' +
     '  left join bd_corp t_cp on t_cp.pk_corp=t1.pk_corp' +
     '  left join bd_areacl t_al on t_al.pk_areacl=t1.vdef1' +
     ' Where ';
  //xxxxx

  Result := True;
  nListA := TStringList.Create;
  try
    nListA.Text := nExtParam;

    if Pos('10', nInData)>0 then   //���ۿ��Ʒ��������Ϳ����֯
    begin
      nStr := AdjustListStrFormat(gSysParam.FWareHouseGroup, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_callbody_from In (' + nStr + ')) And ';
      //�����֯����

      nStr := AdjustListStrFormat(gSysParam.FWareHouseID, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_warehouse_from In (' + nStr + ')) And ';
      //�ֿ����

      nStr := AdjustListStrFormat(gSysParam.FCorpFrom, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_corp_from In (' + nStr + ')) And ';
      //���ۿ��Ʒ�������
    end else
    if Pos('20', nInData)>0 then //�ɹ������ջ������Ϳ����֯
    begin
      nStr := AdjustListStrFormat(gSysParam.FWareHouseGroup, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_callbody_main In (' + nStr + ')) And ';
      //�����֯����

      nStr := AdjustListStrFormat(gSysParam.FWareHouseID, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_warehouse_main In (' + nStr + ')) And ';
      //�ֿ����

      nStr := AdjustListStrFormat(gSysParam.FCorpFrom, '''', True, ',');
      if nStr<>'' then
        nOutData := nOutData + '(t2.pk_corp_main In (' + nStr + ')) And ';
      //�����ջ�����
    end;
//
//    nStr := AdjustListStrFormat(gSysParam.FWareHouseGroup, '''', True, ',');
//    if nStr<>'' then
//      nOutData := nOutData + '(t1.pk_callbody In (' + nStr + ')) And ';
//    //�����֯����
//
//    nStr := AdjustListStrFormat(gSysParam.FWareHouseID, '''', True, ',');
//    if nStr<>'' then
//      nOutData := nOutData + '(t1.pk_warehouse In (' + nStr + ')) And ';
//    //�ֿ����
//
//    nStr := AdjustListStrFormat(gSysParam.FCorpFrom, '''', True, ',');
//    if nStr<>'' then
//      nOutData := nOutData + '(t1.pk_corp In (' + nStr + ')) And ';
//    //��������

    nStr := nListA.Values['QueryAll'];
    if nStr = '' then
    begin
      nOutData := nOutData + '(crowstatus=0 And VBILLSTATUS=1 And t1.dr=0) And ';
      //��ǰ��Ч����
    end;

    nStr := nListA.Values['BillCode'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format('VBILLCODE Like ''%%%s%%''', [nStr]);
      Exit; //�����Ų�ѯ
    end;

    nStr := nListA.Values['MeamKeys'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format('pk_meambill_b In (%s)', [nStr]);
      Exit; //�����Ų�ѯ
    end;

    nStr := nListA.Values['NoDate'];
    if nStr = '' then
    begin
      nStr := '(t1.dbilldate>=''%s'' And t1.dbilldate<''%s'')';
      nOutData := nOutData + Format(nStr, [
                    nListA.Values['DateStart'],
                    nListA.Values['DateEnd']]);
      //��������

      nOutData := nOutData + ' And ';
    end;

    nOutData := nOutData + ' (' + nType + ') ';
    //��������

    nStr := nListA.Values['CustomerID'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format(' And custcode=''%s''', [nStr]);
      //���ͻ����
    end;

    nStr := nListA.Values['Filter'];
    if nStr <> '' then
    begin
      nOutData := nOutData + ' And (' + DecodeBase64(nStr) + ')';
      //��ѯ����
    end;

    nStr := nListA.Values['Order'];
    if nStr <> '' then
    begin
      nOutData := nOutData + ' Order By ' + nStr;
      //��������
    end;
  finally
    gSysLoger.AddLog('��ѯNC����:' + nOutData);
    nListA.Free;
  end;
end;
//Date: 2015/4/9
//Parm: ���ز�ѯ���;���ϱ��
//Desc: ��ȡNC��ѯ���ϱ����Ϣ���
function GetSQLQueryBatchCode(var nOutData: string; nInData: string='';
  nExtParam: string=''):Boolean;
var nStr: string;
begin
  nStr := 'Select  vinvcode,cbatchcode, nbatch, nlock, nsent ' +
    'From meam_batchinv m_inv ' +
    'inner join meam_batchmag m_mag on m_inv.pk_batchmag=m_mag.pk_batchmag ' +
    'Where m_inv.vinvcode=''%s'' and istatus=''1''';

  nOutData := Format(nStr, [nInData]);

  if nExtParam<>'' then
  begin
    nOutData := nOutData + ' And m_mag.cbatchcode=''%s''';
    nOutData := Format(nOutData, [nExtParam]);
  end;

  nStr := AdjustListStrFormat(gSysParam.FDepotID, '''', True, ',');
  if nStr<>'' then
    nOutData := nOutData + ' And (vwarehouse In (' + nStr + '))';
  //�����֯����

  nStr := AdjustListStrFormat(gSysParam.FCorpFrom, '''', True, ',');
  if nStr<>'' then
    nOutData := nOutData + ' And (pk_corp In (' + nStr + '))';
  //���ۿ��Ʒ�������

  gSysLoger.AddLog('��ѯNC�ó���ʹ�����κ�' + nOutData);
  Result := True;
end;


//Date: 2015-01-08
//Parm: ������Ϣ������ѯ����
//Desc: ���ݲ�ѯ��������������SQL��ѯ���
function GetSQLQueryDispatch(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr: string;
    nListA: TStrings;
begin
  nOutData := 'select ' +
     'pk_meambill_b as pk_meambill,VBILLCODE,VBILLTYPE,COPERATOR,user_name,' + //������ͷ
     'TMAKETIME,NPLANNUM,cvehicle,vbatchcode,t1.pk_corp_main,unitname,' +      //��������
     'invcode,invname,invtype ' +                                              //����
     'from meam_bill t1 ' +
     '  left join sm_user t_su on t_su.cuserid=t1.coperator ' +
     '  left join meam_bill_b t2 on t2.PK_MEAMBILL=t1.PK_MEAMBILL' +
     '  left join Bd_invbasdoc t_ib on t_ib.pk_invbasdoc=t2.PK_INVBASDOC' +
     '  left join bd_corp t_cp on t_cp.pk_corp=t1.pk_corp_main' +
     ' Where ' ;
  nOutData := nOutData + SF('VBILLTYPE', 'ME09');

  Result := True;

  nListA := TStringList.Create;
  try
    nListA.Text := nExtParam;

    nStr := nListA.Values['BillCode'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format(' And VBILLCODE Like ''%%%s%%''', [nStr]);
      Exit; //�����Ų�ѯ
    end;

    nStr := nListA.Values['MeamKeys'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format(' And pk_meambill_b In (%s)', [nStr]);
      Exit; //�����Ų�ѯ
    end;

    nStr := nListA.Values['NoDate'];
    if nStr = '' then
    begin
      nStr := ' And (TMAKETIME>=''%s'' And TMAKETIME<''%s'')';
      nOutData := nOutData + Format(nStr, [
                    nListA.Values['DateStart'],
                    nListA.Values['DateEnd']]);
      //��������
    end;

    nStr := nListA.Values['QueryAll'];
    if nStr = '' then
    begin
      nOutData := nOutData + ' And (crowstatus=0 And VBILLSTATUS=1)';
      //��ǰ��Ч����
    end;

    nStr := nListA.Values['Customer'];
    if nStr <> '' then
    begin
      nOutData := nOutData + Format(' And unitname Like ''%%%s%%''', [nStr]);
      //���ͻ����
    end;

    nStr := nListA.Values['Filter'];
    if nStr <> '' then
    begin
      nOutData := nOutData + ' And (' + DecodeBase64(nStr) + ')';
      //��ѯ����
    end;

    nStr := nListA.Values['Order'];
    if nStr <> '' then
    begin
      nOutData := nOutData + ' Order By ' + nStr;
      //��������
    end;
  finally
    nListA.Free;
  end;
end;

//Date: 2014-12-18
//Parm: �����Ϣ;�ͻ����;�ͻ�����;
//Desc: ����ģ����ѯ�ͻ���SQL���
function GetSQLQueryCustomer(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr: string;
begin
  Result := True;
  nOutData := 'Select DISTINCT on (custcode) custcode,custname,' +
      'cmnecode from Bd_cumandoc t1 ' +
      '  left join bd_cubasdoc t2 on t2.pk_cubasdoc=t1.pk_cubasdoc' +
      ' where ';
  //xxxxx

  if nInData <> '' then
  begin
    nStr := '(custcode like ''%%%s%%'')';
    nOutData := nOutData + Format(nStr, [nInData]);
    //�ͻ����ģ��
  end;

  if nExtParam <> '' then
  begin
    nStr := '(custname like ''%%%s%%'')';
    if nInData <> '' then
      nStr := ' or ' + nStr;
    nOutData := nOutData + Format(nStr, [nExtParam]);
    //�ͻ�����ģ��
  end;

  nOutData := nOutData + ' Group By custcode,custname,cmnecode';
end;

//Date: 2014-12-24
//Parm: ������(���)[������Ϣ;�����б�]
//Desc: ��ȡ�������ѷ�����
function GetOrderFHValueLocal(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr,nSQL,nID,nOrder: string;
    nListA, nListB: TStrings;
    nInt: Integer;
    nVal: Double;
begin
  nSQL := 'select distinct poundb.pk_sourcebill_b norder,sum(COALESCE(poundb.nnet,0)) nnet,' +
     'sum(COALESCE(poundb.nassnum,0)) nassnum from meam_poundbill_b poundb ' +
     '  inner join meam_poundbill poundh on poundb.pk_poundbill = poundh.pk_poundbill' +
     ' where COALESCE(poundb.dr,0)=0' +
     '  and poundh.nstatus = 100' +
     '  and COALESCE(poundh.dr,0)=0' +
     '  and poundh.bnowreturn=''N''' +
     '  and COALESCE(poundh.bbillreturn,''N'')=''N''';
  //nnet:������;nassnum:������

  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    nListA.Text := nInData;
    for nInt:=0 to nListA.Count - 1 do
      nListB.Values[nListA[nInt]] := '0';
    //Ĭ���ѷ�����Ϊ0

    nID := AdjustListStrFormat2(nListA, '''', True, ',', False);
    nStr := ' and pk_sourcebill_b in (%s) group by poundb.pk_sourcebill_b';
    nStr := nSQL + Format(nStr, [nID]);
    //ִ����
    with FDM.QueryTemp(nStr, True) do
    if RecordCount > 0 then
    begin
      First;

      while not Eof do
      begin
        nOrder := FieldByName('norder').AsString;
        nListB.Values[nOrder] := FieldByName('nnet').AsString;
        //�����ѷ���

        Next;
      end;
    end;

    nStr := ' and ( poundh.bbillreturn = ''Y'') and pk_sourcebill_b in (%s) ' +
            'group by poundb.pk_sourcebill_b';
    nStr := nSQL + Format(nStr, [nID]);
    //�˻���
    with FDM.QueryTemp(nStr, True) do
    if RecordCount > 0 then
    begin
      First;

      while not Eof do
      begin
        nOrder := FieldByName('norder').AsString;
        nStr := nListB.Values[nOrder];

        if not IsNumber(nStr, True) then
          nStr := '0';
        nVal := StrToFloat(nStr);
        //ȡ�ѷ�����

        nVal := nVal - FieldByName('nnet').AsFloat;
        //�ѷ�����=�ѷ����� - ԭ���˻���

        nListB.Values[nOrder] := FloatToStr(nVal);
        //�����ѷ���

        Next;
      end;
    end;

    if nExtParam = sFlag_Yes then
    begin
      nStr := 'Select B_ID,B_Freeze From %s Where B_ID In (%s)';
      nStr := Format(nStr, [sTable_Order, nID]);
      //������

      with FDM.QuerySQL(nStr, False) do
      if RecordCount > 0 then
      begin
        First;

        while not Eof do
        begin
          nOrder := FieldByName('B_ID').AsString;
          nStr := nListB.Values[nOrder];

          if not IsNumber(nStr, True) then
            nStr := '0';
          nVal := StrToFloat(nStr);
          //ȡ�ѷ�����

          nVal := nVal + FieldByName('B_Freeze').AsFloat;
          //�ѷ�����=�ѷ����� + ������

          nListB.Values[nOrder] := FloatToStr(nVal);
          //�����ѷ���

          Next;
        end;
      end;
    end;

    nOutData := nListB.Text;
    Result := True;
  finally
    nListA.Free;
    nListB.Free;
  end;
end;

//Date: 2015-01-08
//Parm: ������(���)[FIn.FData]
//Desc: ��ȡ�������ѷ�����
function GetOrderGYValueLocal(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr,nSQL,nID,nOrder: string;
    nListA, nListB: TStrings;
    nInt: Integer;
begin
  nSQL := 'select distinct poundb.pk_sourcebill_b norder,sum(COALESCE(poundb.nnet,0)) nnet,' +
     'sum(COALESCE(poundb.nassnum,0)) nassnum from meam_poundbill_b poundb ' +
     '  inner join meam_poundbill poundh on poundb.pk_poundbill = poundh.pk_poundbill' +
     ' where COALESCE(poundb.dr,0)=0' +
     '  and poundh.nstatus = 100' +
     '  and COALESCE(poundh.dr,0)=0';
  //nnet:������;nassnum:������


  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    nListA.Text := nInData;
    for nInt:=0 to nListA.Count - 1 do
      nListB.Values[nListA[nInt]] := '0';
    //Ĭ���ѷ�����Ϊ0

    nID := AdjustListStrFormat2(nListA, '''', True, ',', False);
    nStr := ' and pk_sourcebill_b in (%s) group by poundb.pk_sourcebill_b';
    nStr := nSQL + Format(nStr, [nID]);
    //ִ����

    with FDM.QueryTemp(nStr, True) do
    if RecordCount > 0 then
    begin
      First;

      while not Eof do
      begin
        nOrder := FieldByName('norder').AsString;
        nListB.Values[nOrder] := FieldByName('nnet').AsString;
        //�����ѷ���

        Next;
      end;
    end;

    nOutData := nListB.Text;
    Result := True;
  finally
    nListA.Free;
    nListB.Free;
  end;
end;

//Date: 2015/4/11
//Parm: ���ƺ�
//Desc: �����Ƿ��ѽ���
function TruckInFact(nTruck: string):Boolean;
var nStr: string;
begin
  Result := True;
  if nTruck='' then Exit;

  nStr := 'Select P_ID from %s where P_Truck=''%s'' and P_MValue is NULL' +
          ' and P_MDate is NULL and P_PModel<>''%s''';
  nStr := Format(nStr, [sTable_PoundLog, nTruck, sFlag_PoundLS]);
  //xxxxxx

  with FDM.QuerySQL(nStr) do
    if RecordCount > 0 then
    begin
      nStr := '����%s�ѽ���';
      nStr := Format(nStr, [nTruck]);

      ShowDlg(nStr, sHint);
      Exit;
    end;
  //������ëǰ����ʹ��

  Result := False;
end;

//Date: 2015/4/11
//Parm: ���ƺ�
//Desc: ��ȡ���ƺ���NCϵͳ�е�Ԥ��Ƥ��
function GetTruckPValue(nTruck: string):Double;
var nStr: string;
begin
  Result := 0;
  if nTruck='' then Exit;

  nStr := 'Select ndemptyload from meam_vehicle where vmainlicense=''%s'' ' +
          'And dr=0';
  nStr := Format(nStr, [nTruck]);

  with FDM.QueryTemp(nStr, True) do
  begin
    if RecordCount < 1 then Exit;

    Result := Fields[0].AsFloat;
  end;
end;
//Date: 2015/4/12
//Parm: ���ƺ�
//Desc:  ��ȡ��������ʷƤ��ƽ��ֵ
function GetHistoryTruckPValue(nTruck: string): Double;
var nCount: Integer;
    nTWeight: Double;
    nStr: string;
begin
  Result := 0;
  nStr := 'Select Count(1) as NUM, Sum(P_PValue) as TPValue From ' +
          '(Select Top 10 * From %s ' +
          'Where P_MValue>0 and P_PValue>0 and P_Truck=''%s'' ' +
          'Order by P_PDate desc) PL';
  nStr := Format(nStr, [sTable_PoundLog, nTruck]);

  with FDM.QuerySQL(nStr) do
  begin
    if RecordCount<1 then Exit;
    nCount := Fields[0].AsInteger;
    nTWeight := Fields[1].AsFloat;

    if nCount=0 then Exit;
    Result := nTWeight / nCount;
  end;
end;

function VerifyTruckPValue(nPValue: Double; nTruck: string; var nOut: string):Boolean;
var nVal,nLValue: Double;
begin
  Result := True;
  if nPValue<=0 then
  begin
    nOut := '����Ƥ��Ϊ0�������³���';
    Result := False;
    Exit;
  end;

  nLValue := GetHistoryTruckPValue(nTruck);
  if nLValue<=0 then Exit; //�״��볧����

  nVal := Abs(nLValue*1000 - nPValue*1000);
  if nVal<gSysParam.FPoundTruckP then Exit;

  Result := False;
  nOut := '�ճ���������ʷƤ���нϴ����' + #13#10
          +'�����Ϊ[%.2f]ǧ��' + #13#10
          +'��ȷ���Ƿ񱣴�?';
  nOut := Format(nOut, [nVal]);
end;

//Desc: ��ӡ�����
function PrintBillReport(nBill: string; const nAsk: Boolean): Boolean;
var nStr: string;
    nParam: TReportParamItem;
begin
  Result := False;

  if nAsk then
  begin
    nStr := '�Ƿ�Ҫ��ӡ�����?';
    if not QueryDlg(nStr, sAsk) then Exit;
  end;

  nBill := AdjustListStrFormat(nBill, '''', True, ',', False);
  //�������

  nStr := 'Select * From %s b Where L_ID In(%s)';
  nStr := Format(nStr, [sTable_Bill, nBill]);
  //xxxxx

  if FDM.QueryTemp(nStr).RecordCount < 1 then
  begin
    nStr := '���Ϊ[ %s ] �ļ�¼����Ч!!';
    nStr := Format(nStr, [nBill]);
    ShowMsg(nStr, sHint); Exit;
  end;

  nStr := gPath + sReportDir + 'LadingBill.fr3';
  if not FDR.LoadReportFile(nStr) then
  begin
    nStr := '�޷���ȷ���ر����ļ�';
    ShowMsg(nStr, sHint); Exit;
  end;

  nParam.FName := 'UserName';
  nParam.FValue := gSysParam.FUserID;
  FDR.AddParamItem(nParam);

  nParam.FName := 'Company';
  nParam.FValue := gSysParam.FHintText;
  FDR.AddParamItem(nParam);

  FDR.Dataset1.DataSet := FDM.SqlTemp;
  FDR.ShowReport;
  Result := FDR.PrintSuccess;
end;

//Date: 2012-4-15
//Parm: ��������;�Ƿ�ѯ��
//Desc: ��ӡnPound������¼
function PrintPoundReport(const nPound: string; nAsk: Boolean): Boolean;
var nStr: string;
    nParam: TReportParamItem;
begin
  Result := False;

  if nAsk then
  begin
    nStr := '�Ƿ�Ҫ��ӡ������?';
    if not QueryDlg(nStr, sAsk) then Exit;
  end;

  nStr := 'Select * From %s Where P_ID=''%s''';
  nStr := Format(nStr, [sTable_PoundLog, nPound]);

  if FDM.QueryTemp(nStr).RecordCount < 1 then
  begin
    nStr := '���ؼ�¼[ %s ] ����Ч!!';
    nStr := Format(nStr, [nPound]);
    ShowMsg(nStr, sHint); Exit;
  end;

  nStr := gPath + sReportDir + 'Pound.fr3';
  if not FDR.LoadReportFile(nStr) then
  begin
    nStr := '�޷���ȷ���ر����ļ�';
    ShowMsg(nStr, sHint); Exit;
  end;

  nParam.FName := 'UserName';
  nParam.FValue := gSysParam.FUserID;
  FDR.AddParamItem(nParam);

  nParam.FName := 'Company';
  nParam.FValue := gSysParam.FHintText;
  FDR.AddParamItem(nParam);

  FDR.Dataset1.DataSet := FDM.SqlTemp;
  FDR.ShowReport;
  Result := FDR.PrintSuccess;

  if Result  then
  begin
    nStr := 'Update %s Set P_PrintNum=P_PrintNum+1 Where P_ID=''%s''';
    nStr := Format(nStr, [sTable_PoundLog, nPound]);
    FDM.ExecuteSQL(nStr);
  end;
end;

//Date: 2012-4-15
//Parm: ��������;�Ƿ�ѯ��
//Desc: ��ӡ����nPound������¼
function PrintSalePoundReport(const nPound: string; nAsk: Boolean): Boolean;
var nStr: string;
    nParam: TReportParamItem;
begin
  Result := False;

  if nAsk then
  begin
    nStr := '�Ƿ�Ҫ��ӡ������?';
    if not QueryDlg(nStr, sAsk) then Exit;
  end;

  nStr := 'Select * From %s sp ' +
          'left join %s sbill on sp.P_Bill=sbill.L_ID ' + //
          'Where P_ID=''%s''';
  nStr := Format(nStr, [sTable_PoundLog, sTable_Bill, nPound]);

  if FDM.QueryTemp(nStr).RecordCount < 1 then
  begin
    nStr := '���ؼ�¼[ %s ] ����Ч!!';
    nStr := Format(nStr, [nPound]);
    ShowMsg(nStr, sHint); Exit;
  end;

  if FDM.SqlTemp.FieldByName('P_MType').AsString = sFlag_San then
        nStr := gPath + sReportDir + 'SalePound.fr3'
  else  nStr := gPath + sReportDir + 'SaleDaiPound.fr3';
  
  if not FDR.LoadReportFile(nStr) then
  begin
    nStr := '�޷���ȷ���ر����ļ�';
    ShowMsg(nStr, sHint); Exit;
  end;

  nParam.FName := 'UserName';
  nParam.FValue := gSysParam.FUserID;
  FDR.AddParamItem(nParam);

  nParam.FName := 'Company';
  nParam.FValue := gSysParam.FHintText;
  FDR.AddParamItem(nParam);

  FDR.Dataset1.DataSet := FDM.SqlTemp;
  FDR.ShowReport;
  Result := FDR.PrintSuccess;

  if Result  then
  begin
    nStr := 'Update %s Set P_PrintNum=P_PrintNum+1 Where P_ID=''%s''';
    nStr := Format(nStr, [sTable_PoundLog, nPound]);
    FDM.ExecuteSQL(nStr);
  end;
end;
//Date: 2015/4/9
//Parm: ������Ϣ;�ɹ�������;
//Desc: ͬ���ɹ��������ݵ�NC�����񵥱���
function SyncNC_ME03(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr,nSQL: string;
    nIdx: Integer;
    nDS: TDataSet;
    nListA: TStrings;
    nBills: TLadingBillItems;
begin
  Result := False;
  nStr := 'Select * From %s Where P_ID=''%s''';
  nStr := Format(nStr, [sTable_PoundLog, nInData]);

  with FDM.QuerySQL(nStr) do
  begin
    if RecordCount < 1 then
    begin
      nOutData := '���ص���[ %s ]��Ϣ�Ѷ�ʧ.';
      nOutData := Format(nOutData, [nInData]);
      Exit;
    end;

    SetLength(nBills, 1);
    First;

    with nBills[0] do
    begin
      FID      := FieldByName('P_Bill').AsString;
      FZhiKa   := FieldByName('P_Bill').AsString;
      FTruck   := FieldByName('P_Truck').AsString;
      FPoundID := FieldByName('P_ID').AsString;

      if FZhiKa = '' then
      begin
        nOutData := '���ص���[ %s ]�Ŷ�����Ϊ��.';
        nOutData := Format(nOutData, [nInData]);
        Exit;
      end;

      with FPData do
      begin
        FValue    := FieldByName('P_PValue').AsFloat;
        FDate     := FieldByName('P_PDate').AsDateTime;
        FOperator := FieldByName('P_PMan').AsString;
      end;

      with FMData do
      begin
        FValue    := FieldByName('P_MValue').AsFloat;
        FDate     := FieldByName('P_MDate').AsDateTime;
        FOperator := FieldByName('P_MMan').AsString;
      end;

      FKZValue := FieldByName('P_KZValue').AsFloat;
      FKZComment:= FieldByName('P_KZComment').AsString;
      FPDValue := FieldByName('P_PDValue').AsFloat;

      FValue := Float2Float(FMData.FValue - FPData.FValue - FKZValue,
        cPrecision, False);
      //��Ӧ��
    end;
  end;

  //----------------------------------------------------------------------------
  nStr := 'select t1.*,t2.* from meam_bill t1 ' +
          '  left join meam_bill_b t2 on t2.PK_MEAMBILL=t1.PK_MEAMBILL ' +
          'where pk_meambill_b=''%s''';
  nStr := Format(nStr, [nBills[0].FID]);

  nListA := TStringList.Create;
  try
    nDS := FDM.QueryTemp(nStr, True);
    with nDS do
    begin
      if RecordCount < 1 then
      begin
        nOutData := 'NC����[ %s ]��Ϣ�Ѷ�ʧ.';
        nOutData := Format(nOutData, [nBills[0].FID]);
        Exit;
      end;

      nListA.Clear;
      nIdx := 0;
      First;

      nSQL := MakeSQLByStr([SF('bbillreturn', 'N'),
              SF('bneedcheckgross', 'N'),
              SF('bneedchecktare', 'N'),
              SF('bnowreturn', 'N'),
              SF('bpackage', 'N'),
              SF('bpushbillstatus', 'N'),
              SF('bsame_ew', 'N'),

              SF('nabatenum', nBills[nIdx].FKZValue, sfVal),
              SF('nclientabatenum', nBills[nIdx].FPDValue, sfVal),
              SF('breturn', FieldByName('breplenishflag').AsString),
              SF('cmainunit', FieldByName('cmainunit').AsString),
              SF('coperatorid', FieldByName('coperator').AsString),

              MakeField(nDS, 'pk_callbody_main', 1, 'cincalbodyid'),
              MakeField(nDS, 'pk_corp_main', 1, 'cincorpid'),
              MakeField(nDS, 'pk_warehouse_main', 1, 'cinwarehouseid'),

              SF('cvehicle', nBills[nIdx].FTruck),
              SF('dbizdate', Date2Str(nBills[nIdx].FPData.FDate)),
              SF('dconfirmdate', Date2Str(nBills[nIdx].FPData.FDate)),
              SF('dconfirmtime', DateTime2Str(nBills[nIdx].FPData.FDate)),
              SF('ddelivmaketime', DateTime2Str(nBills[nIdx].FPData.FDate)),
              SF('dgrossdate', Date2Str(nBills[nIdx].FMData.FDate)),
              SF('dgrosstime', DateTime2Str(nBills[nIdx].FMData.FDate)),
              SF('dlastmoditime', DateTime2Str(nBills[nIdx].FPData.FDate)),
              SF('dmaketime', DateTime2Str(nBills[nIdx].FPData.FDate)),
              SF('dr', 0, sfVal),
              SF('dtaredate', Date2Str(nBills[nIdx].FPData.FDate)),
              SF('dtaretime', DateTime2Str(nBills[nIdx].FPData.FDate)),
              SF('ncreatetype', FieldByName('icreatetype').AsInteger, sfVal),
              SF('ndelivbillprintcount', 1, sfVal),
              SF('ngross', nBills[nIdx].FMData.FValue, sfVal),
              SF('nmeammodel', FieldByName('nmeammodel').AsInteger, sfVal),
              SF('nnet', nBills[nIdx].FValue, sfVal),
              SF('nplannum', FieldByName('nplannum').AsFloat, sfVal),
              SF('nstatus', '100', sfVal),
              SF('ntare', nBills[nIdx].FPData.FValue, sfVal),
              SF('ntareauditstatus', 1, sfVal),
              SF('nweighmodel', '1', sfVal),

              SF('pk_bsmodel', '0001ZA1000000001SIJ7'),
              SF('pk_corp', FieldByName('pk_corp').AsString),

              SF('pk_cumandoc', FieldByName('pk_cumandoc').AsString),
              SF('pk_invbasdoc', FieldByName('pk_invbasdoc').AsString),
              SF('pk_invmandoc', FieldByName('pk_invmandoc').AsString),
              SF('pk_poundbill', nBills[nIdx].FPoundID),
              SF('ts', DateTime2Str(nBills[nIdx].FMData.FDate)),
              SF('vbillcode', nBills[nIdx].FPoundID),
              MakeField(nDS, 'vdef1', 0),
              MakeField(nDS, 'vdef10', 0),
              MakeField(nDS, 'vdef11', 0),
              MakeField(nDS, 'vdef12', 0),
              MakeField(nDS, 'vdef13', 0),
              MakeField(nDS, 'vdef14', 0),
              MakeField(nDS, 'vdef15', 0),
              MakeField(nDS, 'vdef16', 0),
              MakeField(nDS, 'vdef17', 0),
              MakeField(nDS, 'vdef18', 0),
              MakeField(nDS, 'vdef19', 0),
              MakeField(nDS, 'vdef2', 0),
              MakeField(nDS, 'vdef20', 0),
              MakeField(nDS, 'vdef3', 0),
              MakeField(nDS, 'vdef4', 0),
              MakeField(nDS, 'vdef5', 0),
              MakeField(nDS, 'vdef6', 0),
              MakeField(nDS, 'vdef7', 0),
              MakeField(nDS, 'vdef8', 0),
              MakeField(nDS, 'vdef9', 0),
              SF('vsourcebillcode', FieldByName('vbillcode').AsString),
              SF('wayofpoundcorrent', '1')
              ], 'meam_poundbill', '', True);
      nListA.Add(nSQL);

      nSQL := MakeSQLByStr([SF('cassunit', FieldByName('cassunit').AsString),
              SF('dbizdate', Date2Str(nBills[nIdx].FPData.FDate)),
              SF('dr', 0, sfVal),
              SF('nassrate', FieldByName('nassrate').AsFloat, sfVal),
              SF('nassnum', FieldByName('nplanassnum').AsFloat, sfVal),
              SF('nexecnum', FieldByName('nexecnum').AsFloat, sfVal),
              SF('nnet', nBills[nIdx].FValue, sfVal),
              SF('nplannum', FieldByName('nplannum').AsFloat, sfVal),

              SF('pk_poundbill', nBills[nIdx].FPoundID),
              SF('pk_poundbill_b', nBills[nIdx].FPoundID + '_2'),
              SF('pk_sourcebill', FieldByName('pk_meambill').AsString),
              SF('pk_sourcebill_b', FieldByName('pk_meambill_b').AsString),
              SF('ts', DateTime2Str(nBills[nIdx].FMData.FDate)),
              SF('vbatchcode', FieldByName('vbatchcode').AsString),
              MakeField(nDS, 'vdef1', 1),
              MakeField(nDS, 'vdef10', 1),
              MakeField(nDS, 'vdef11', 1),
              MakeField(nDS, 'vdef12', 1),
              MakeField(nDS, 'vdef13', 1),
              MakeField(nDS, 'vdef14', 1),
              MakeField(nDS, 'vdef15', 1),
              MakeField(nDS, 'vdef16', 1),
              MakeField(nDS, 'vdef17', 1),
              MakeField(nDS, 'vdef18', 1),
              MakeField(nDS, 'vdef19', 1),
              MakeField(nDS, 'vdef2', 1),
              MakeField(nDS, 'vdef20', 1),
              MakeField(nDS, 'vdef3', 1),
              MakeField(nDS, 'vdef4', 1),
              MakeField(nDS, 'vdef5', 1),
              MakeField(nDS, 'vdef6', 1),
              MakeField(nDS, 'vdef7', 1),
              MakeField(nDS, 'vdef8', 1),
              MakeField(nDS, 'vdef9', 1),
              SF('vsourcebillcode', FieldByName('vbillcode').AsString)
              ], 'meam_poundbill_b', '', True);
      nListA.Add(nSQL);

      //FDM.ADOConn.BeginTrans;
      try
        for nIdx:=0 to nListA.Count - 1 do
          FDM.ExecuteSQL(nListA[nIdx], True);
        //xxxxx

        nStr := 'Select 1+0';
        FDM.QueryTemp(nStr, False);
        Result := True;
      except
        on E:Exception do
        begin
          //FDM.ADOConn.RollbackTrans;
          nOutData := 'ͬ��NC�����񵥴���,����: ' + E.Message;
          Exit;
        end;
      end;
    end;
  finally
    nListA.Free;
  end;
end;

//Date: 2014-12-29
//Parm: ������(���)[������Ϣ;ͬ��������]
//Desc: ͬ���������������ݵ�NC�����񵥱���
function SyncNC_ME25(var nOutData: string; nInData: string='';
  nExtParam: string=''): Boolean;
var nStr,nSQL: string;
    nIdx: Integer;
    nDS: TDataSet;
    nListA, nListC: TStrings;
    nDateMin: TDateTime;
    nBills: TLadingBillItems;
begin
  Result := False;

  nListA := TStringList.Create;
  nListC := TStringList.Create;

  try
    nListA.Text := nInData;
    nStr := AdjustListStrFormat2(nListA, '''', True, ',', False, False);

    nSQL := 'Select L_ID,L_ZhiKa,L_SaleMan,L_Truck,L_Value,L_PValue,L_PDate,' +
            'L_PMan,L_MValue,L_MDate,L_MMan,L_OutFact,L_Date,L_Seal, P_ID,P_Type ' +
            'From %s Left Join %s On P_Bill=L_ID ' +
            'Where L_ID In (%s)';
    nSQL := Format(nSQL, [sTable_Bill, sTable_PoundLog, nStr]);

    with FDM.QuerySQL(nSQL) do
    begin
      if RecordCount < 1 then
      begin
        nOutData := '������[ %s ]��Ϣ�Ѷ�ʧ.';
        nOutData := Format(nOutData, [CombinStr(nListA, ',', False)]);
        Exit;
      end;

      nListC.Clear;
      nListC.Values['Group'] := sFlag_BusGroup;
      nListC.Values['Object'] := sFlag_PoundID;

      SetLength(nBills, RecordCount);
      nIdx := 0;

      nListA.Clear;
      First;

      while not Eof do
      begin
        with nBills[nIdx] do
        begin
          FID         := FieldByName('L_ID').AsString;
          FZhiKa      := FieldByName('L_ZhiKa').AsString;
          FPType       := FieldByName('P_Type').AsString;
          FTruck      := FieldByName('L_Truck').AsString;
          FValue      := FieldByName('L_Value').AsFloat;
          FBatchCode  := FieldByName('L_Seal').AsString;

          if nListA.IndexOf(FZhiKa) < 0 then
            nListA.Add(FZhiKa);
          //������

          FPoundID := FieldByName('P_ID').AsString;
          //�񵥱��
          if FPoundID = '' then
          begin
            if not GetSerailID(FPoundID, nListC.Text, sFlag_Yes) then
              raise Exception.Create(FPoundID);
          end;

          nDateMin := Str2Date('2000-01-01');
          //��С���ڲο�

          with FPData do
          begin
            FValue    := FieldByName('L_PValue').AsFloat;
            FDate     := FieldByName('L_PDate').AsDateTime;
            FOperator := FieldByName('L_PMan').AsString;

            if FDate < nDateMin then
              FDate := FieldByName('L_Date').AsDateTime;
            //xxxxx

            if FDate < nDateMin then
              FDate := Date();
            //xxxxx
          end;

          with FMData do
          begin
            FValue    := FieldByName('L_MValue').AsFloat;
            FDate     := FieldByName('L_MDate').AsDateTime;
            FOperator := FieldByName('L_MMan').AsString;

            if FDate < nDateMin then
              FDate := FieldByName('L_OutFact').AsDateTime;
            //xxxxx

            if FDate < nDateMin then
              FDate := Date();
            //xxxxx
          end;
        end;

        Inc(nIdx);
        Next;
      end;
    end;

    //----------------------------------------------------------------------------
    nStr := AdjustListStrFormat2(nListA, '''', True, ',', False, False);
    //�����б�

    nSQL := 'select t1.*,t2.* from meam_bill t1 ' +
            '  left join meam_bill_b t2 on t2.PK_MEAMBILL=t1.PK_MEAMBILL ' +
            'where pk_meambill_b in (%s)';
    nSQL := Format(nSQL, [nStr]);

    nDS := FDM.QueryTemp(nSQL, True);
    with nDS do
    begin
      if RecordCount < 1 then
      begin
        nOutData := '������[ %s ]��Ϣ�Ѷ�ʧ.';
        nOutData := Format(nOutData, [CombinStr(nListA, ',', False)]);
        Exit;
      end;

      nListA.Clear;
      //init sql list

      for nIdx:=Low(nBills) to High(nBills) do
      begin
        First;
        //init cursor

        while not Eof do
        begin
          nStr := FieldByName('pk_meambill_b').AsString;
          if nStr = nBills[nIdx].FZhiKa then Break;
          Next;
        end;

        if Eof then Continue;
        //������ʧ���账��

        if nBills[nIdx].FPType = sFlag_Sale then
             nBills[nIdx].FPType := '0001AA10000000009NEY'
        else nBills[nIdx].FPType := '0001ZA1000000001VYRH';
        //ҵ������תҵ��ģʽ

        nSQL := MakeSQLByStr([SF('bbillreturn', 'N'),
                SF('bneedcheckgross', 'N'),
                SF('bneedchecktare', 'N'),
                SF('bnowreturn', 'N'),
                SF('bpackage', 'N'),
                SF('bpushbillstatus', 'N'),
                SF('breturn', 'N'),
                SF('bsame_ew', 'N'),

                SF('cmainunit', FieldByName('cmainunit').AsString),
                SF('coperatorid', FieldByName('coperator').AsString),

                MakeField(nDS, 'pk_corp_from', 1, 'coutcorpid'),
                MakeField(nDS, 'pk_callbody_from', 1, 'coutcalbodyid'),
                MakeField(nDS, 'pk_warehouse_from', 1, 'coutwarehouseid'),
                MakeField(nDS, 'pk_warehouse_main', 0, 'cinwarehouseid'),
                MakeField(nDS, 'pk_callbody_main', 0, 'cincalbodyid'),
                MakeField(nDS, 'pk_corp_main', 0, 'cincorpid'),

                SF('cvehicle', nBills[nIdx].FTruck),
                SF('dbizdate', Date2Str(nBills[nIdx].FMData.FDate)),
                SF('dconfirmdate', Date2Str(nBills[nIdx].FPData.FDate)),
                SF('dconfirmtime', DateTime2Str(nBills[nIdx].FPData.FDate)),
                SF('ddelivmaketime', DateTime2Str(nBills[nIdx].FPData.FDate)),
                SF('dgrossdate', Date2Str(nBills[nIdx].FMData.FDate)),
                SF('dgrosstime', DateTime2Str(nBills[nIdx].FMData.FDate)),
                SF('dlastmoditime', DateTime2Str(nBills[nIdx].FPData.FDate)),
                SF('dmaketime', DateTime2Str(nBills[nIdx].FPData.FDate)),
                SF('dr', 0, sfVal),
                SF('dtaredate', Date2Str(nBills[nIdx].FPData.FDate)),
                SF('dtaretime', DateTime2Str(nBills[nIdx].FPData.FDate)),
                SF('ncreatetype', 1, sfVal),
                SF('ndelivbillprintcount', 1, sfVal),
                SF('ngross', nBills[nIdx].FMData.FValue, sfVal),
                SF('nmeammodel', 0, sfVal),
                SF('nnet', nBills[nIdx].FValue, sfVal),
                SF('nplannum', FieldByName('nplannum').AsFloat, sfVal),
                SF('nstatus', '100', sfVal),
                SF('ntare', nBills[nIdx].FPData.FValue, sfVal),
                SF('ntareauditstatus', 1, sfVal),
                SF('nweighmodel', '0', sfVal),

                SF('pk_bsmodel', nBills[nIdx].FPType),
                //SF('pk_corp', FieldByName('pk_corp').AsString),
                MakeField(nDS, 'pk_corp_from', 1, 'pk_corp'),

                SF('pk_cumandoc', FieldByName('pk_cumandoc').AsString),
                SF('pk_invbasdoc', FieldByName('pk_invbasdoc').AsString),
                SF('pk_invmandoc', FieldByName('pk_invmandoc').AsString),
                SF('pk_poundbill', nBills[nIdx].FPoundID),
                SF('ts', DateTime2Str(nBills[nIdx].FMData.FDate)),
                SF('vbillcode', nBills[nIdx].FPoundID),
                MakeField(nDS, 'vdef1', 0),
                MakeField(nDS, 'vdef10', 0),
                MakeField(nDS, 'vdef11', 0),
                MakeField(nDS, 'vdef12', 0),
                MakeField(nDS, 'vdef13', 0),
                MakeField(nDS, 'vdef14', 0),
                MakeField(nDS, 'vdef15', 0),
                MakeField(nDS, 'vdef16', 0),
                MakeField(nDS, 'vdef17', 0),
                MakeField(nDS, 'vdef18', 0),
                MakeField(nDS, 'vdef19', 0),
                MakeField(nDS, 'vdef2', 0),
                MakeField(nDS, 'vdef20', 0),
                MakeField(nDS, 'vdef3', 0),
                MakeField(nDS, 'vdef4', 0),
                MakeField(nDS, 'vdef5', 0),
                MakeField(nDS, 'vdef6', 0),
                MakeField(nDS, 'vdef7', 0),
                MakeField(nDS, 'vdef8', 0),
                MakeField(nDS, 'vdef9', 0),
                SF('vsourcebillcode', FieldByName('vbillcode').AsString),
                SF('wayofpoundcorrent', '1')
                ], 'meam_poundbill', '', True);
        nListA.Add(nSQL);

        nSQL := MakeSQLByStr([SF('cassunit', FieldByName('cassunit').AsString),
                SF('dbizdate', Date2Str(nBills[nIdx].FMData.FDate)),
                SF('dr', 0, sfVal),
                SF('nassrate', FieldByName('nassrate').AsString, sfVal),
                SF('nconfirmnum', nBills[nIdx].FValue, sfVal),
                SF('ndelivplannum', nBills[nIdx].FValue, sfVal),
                SF('nexecnum', FieldByName('nexecnum').AsFloat, sfVal),
                SF('nnet', nBills[nIdx].FValue, sfVal),
                SF('nplannum', FieldByName('nplannum').AsFloat, sfVal),

                MakeField(nDS, 'pk_corp_from', 1, 'pk_corp'),

                SF('pk_poundbill', nBills[nIdx].FPoundID),
                SF('pk_poundbill_b', nBills[nIdx].FPoundID + '_2'),
                SF('pk_sourcebill', FieldByName('pk_meambill').AsString),
                SF('pk_sourcebill_b', FieldByName('pk_meambill_b').AsString),
                SF('ts', DateTime2Str(nBills[nIdx].FMData.FDate)),
                //SF('vbatchcode', FieldByName('vbatchcode').AsString), //�ش�������
                SF('vbatchcode', nBills[nIdx].FBatchCode), //����Ϊ��ѡ���κ�
                MakeField(nDS, 'vdef1', 1),
                MakeField(nDS, 'vdef10', 1),
                MakeField(nDS, 'vdef11', 1),
                MakeField(nDS, 'vdef12', 1),
                MakeField(nDS, 'vdef13', 1),
                MakeField(nDS, 'vdef14', 1),
                MakeField(nDS, 'vdef15', 1),
                MakeField(nDS, 'vdef16', 1),
                MakeField(nDS, 'vdef17', 1),
                MakeField(nDS, 'vdef18', 1),
                MakeField(nDS, 'vdef19', 1),
                MakeField(nDS, 'vdef2', 1),
                MakeField(nDS, 'vdef20', 1),
                MakeField(nDS, 'vdef3', 1),
                MakeField(nDS, 'vdef4', 1),
                MakeField(nDS, 'vdef5', 1),
                MakeField(nDS, 'vdef6', 1),
                MakeField(nDS, 'vdef7', 1),
                MakeField(nDS, 'vdef8', 1),
                MakeField(nDS, 'vdef9', 1),
                SF('vsourcebillcode', FieldByName('vbillcode').AsString)
                ], 'meam_poundbill_b', '', True);
        nListA.Add(nSQL);
      end;

      try
        for nIdx:=0 to nListA.Count - 1 do
          FDM.ExecuteSQL(nListA[nIdx], True);
        //xxxxx

        nStr := 'Select 1+0';
        FDM.QueryTemp(nStr, False);
        Result := True;
      except
        on E:Exception do
        begin
          nOutData := 'ͬ��NC�����񵥴���,����: ' + E.Message;
          Exit;
        end;
      end;
    end;
  finally
    nListA.Free;
    nListC.Free;
  end;
end;
//Date: 2015/4/14
//Parm: ���κ�
//Desc: ��ȡ�����κ��ѷ�����
function GetNCBatchSent(nBatch: string): Double;
var nStr,nSQL: string;
    nnetVal, nsumVal: Double;
begin
  nnetVal := 0;
  nsumVal := 0;

  nSQL := 'select distinct sum(COALESCE(poundb.nnet,0)) nnet,' +
     'sum(COALESCE(poundb.nassnum,0)) nassnum from meam_poundbill_b poundb ' +
     '  inner join meam_poundbill poundh on poundb.pk_poundbill = poundh.pk_poundbill' +
     ' where COALESCE(poundb.dr,0)=0' +
     '  and poundh.nstatus = 100' +
     '  and COALESCE(poundh.dr,0)=0' +
     '  and poundh.bnowreturn=''N''' +
     '  and COALESCE(poundh.bbillreturn,''N'')=''N''';
  //nnet:������;nassnum:������

  nStr := ' and vbatchcode = ''%s''';
  nStr := nSQL + Format(nStr, [nBatch]);
  //ִ����
  gSysLoger.AddLog('��ѯ�����ѷ�����:' + nStr);
  with FDM.QueryTemp(nStr, True) do
  if RecordCount > 0 then
  begin
    nnetVal := Fields[0].AsFloat;
  end;

  nStr := ' and ( poundh.bbillreturn = ''Y'') and vbatchcode = ''%s''';
  nStr := nSQL + Format(nStr, [nBatch]);
  //�˻���
  gSysLoger.AddLog('��ѯ�������˻���:' + nStr);
  with FDM.QueryTemp(nStr, True) do
  if RecordCount > 0 then
  begin
    nsumVal := Fields[0].AsFloat;
  end;

  Result := nnetVal - nsumVal;
end;

//Date: 2014-12-26
//Parm: �����б�
//Desc: ��nOrders����������С��������
procedure SortOrderByValue(var nOrders: TOrderItems);
var i,j,nInt: Integer;
    nItem: TOrderItemInfo;
begin
  nInt := High(nOrders);
  //xxxxx

  for i:=Low(nOrders) to nInt do
   for j:=i+1 to nInt do
    if nOrders[j].FMaxValue < nOrders[i].FMaxValue then
    begin
      nItem := nOrders[i];
      nOrders[i] := nOrders[j];
      nOrders[j] := nItem;
    end;
  //ð������
end;

function VerifyBeforSave(var nOrderItems: TOrderItems;
    nBillData: TStrings=nil): Boolean;
var nIdx,nInt: Integer;
    nVal,nDec: Double;
    nStr, nOutData: string;
    nListB,nListC: TStrings;
begin
  Result := False;

  //TWorkerBusinessCommander.CallMe(cBC_SaveTruckInfo, nTruck, '', @nOut);
  //���泵�ƺ�
  SaveTruck(nBillData.Values['Truck']);

  nListB := TStringList.Create;
  nListC := TStringList.Create;
  try
    //----------------------------------------------------------------------------
    nStr := nBillData.Values['Orders'];
    nListB.Text := PackerDecodeStr(nStr);
    nStr := AdjustListStrFormat2(nListB, '''', True, ',', False, False);

    nListC.Clear;
    nListC.Values['MeamKeys'] := nStr;

    if not GetSQLQueryOrder(nOutData, '103', nListC.Text) then
    begin
      nStr := StringReplace(nListB.Text, #13#10, ',', [rfReplaceAll]);
      nOutData := Format('��ȡ[ %s ]������Ϣʧ��', [nStr]);
      ShowDlg(nOutData, sWarn);
      Exit;
    end;

    with FDM.QueryTemp(nOutData, True), nBillData do
    begin
      if RecordCount < 1 then
      begin
        nStr := StringReplace(nListB.Text, #13#10, ',', [rfReplaceAll]);
        nOutData := Format('����[ %s ]��Ϣ�Ѷ�ʧ.', [nStr]);
        ShowDlg(nOutData, sWarn);
        Exit;
      end;

      SetLength(nOrderItems, RecordCount);
      nInt := 0;
      First;

      while not Eof do
      begin
        with nOrderItems[nInt] do
        begin
          FOrders := FieldByName('pk_meambill').AsString;
          FBillID := FieldByName('VBILLCODE').AsString;

          if Values['CusID']='' then
               FCusID := FieldByName('custcode').AsString
          else FCusID := Values['CusID'];

          if Values['CusName']='' then
               FCusName := FieldByName('custname').AsString
          else FCusName := Values['CusName'];

          FCusCode := FieldByName('def30').AsString;
          if FCusCode = '' then FCusCode := '00';

          FStockID := FieldByName('vmeaninvcode').AsString;
          FStockName := FieldByName('vmeaminvname').AsString;
          FStockType := FieldByName('nmeamflag').AsString;
          FMaxValue := FieldByName('NPLANNUM').AsFloat;
          FKDValue := 0;

          FSaleID := '001';
          FSaleMan := FieldByName('VBILLTYPE').AsString;

          FMKBillUnit:= FieldByName('unitname').AsString;
          FMKBillMan:= FieldByName('user_name').AsString;
          FAreaName  := FieldByName('areaclname').AsString;
        end;

        Inc(nInt);
        Next;
      end;
    end;

    //----------------------------------------------------------------------------
    nStr := PackerEncodeStr(nListB.Text);
    //�����б�

    if not GetOrderFHValue(nListB) then
    begin
      nStr := StringReplace(nListB.Text, #13#10, ',', [rfReplaceAll]);
      nOutData := Format('��ȡ[ %s ]����������ʧ��', [nStr]);
      ShowDlg(nOutData, sWarn);
      Exit;
    end;

    for nIdx:=Low(nOrderItems) to High(nOrderItems) do
    begin
      nStr := nListB.Values[nOrderItems[nIdx].FOrders];
      if not IsNumber(nStr, True) then Continue;

      with nOrderItems[nIdx] do
        FMaxValue := FMaxValue - StrToFloat(nStr);
      //������ = �ƻ��� - �ѷ���
    end;

    SortOrderByValue(nOrderItems);
    //����������С��������

    //----------------------------------------------------------------------------
    nStr := nBillData.Values['Value'];
    nVal := Float2Float(StrToFloat(nStr), cPrecision, True);

    for nIdx:=Low(nOrderItems) to High(nOrderItems) do
    begin
      if nVal <= 0 then Break;
      //�������Ѵ������

      nDec := Float2Float(nOrderItems[nIdx].FMaxValue, cPrecision, False);
      //����������

      if nDec >= nVal then
        nDec := nVal;
      //����������ֱ�ӿ۳�������

      with nOrderItems[nIdx] do
      begin
        //FMaxValue := Float2Float(FMaxValue, cPrecision, False) - nDec;
        FKDValue := nDec;
      end;

      nVal := Float2Float(nVal - nDec, cPrecision, True);
      //����ʣ����
    end;

    if nVal > 0 then
    begin
      nOutData := '�������������������[ %.2f ]��,����ʧ��.';
      nOutData := Format(nOutData, [nVal]);
      ShowDlg(nOutData, sWarn);
      Exit;
    end;

    Result := True;
    //verify done
  finally
    nListB.Free;
    nListC.Free;
  end;  
end;

function SaveBill(var nOutData:string; const nBillData: TStrings=nil): string;
var nStr,nSQL,nOutBill: string;
    nIdx,nInt: Integer;
    nListA: TStrings;
    nOrderItems: TOrderItems;
begin
  Result := '';
  SetLength(nOrderItems, 0);
  if not VerifyBeforSave(nOrderItems, nBillData) then Exit;

  nListA := TStringList.Create;
  try
    FDM.ADOConn.BeginTrans;
    try
      for nIdx:=Low(nOrderItems) to High(nOrderItems) do
      begin
        if nOrderItems[nIdx].FKDValue <= 0 then Continue;
        //�޿�����

        nListA.Clear;
        nListA.Values['Group'] :=sFlag_BusGroup;
        nListA.Values['Object'] := sFlag_BillNo;
        //to get serial no

        if not GetSerailID(nOutBill, nListA.Text, sFlag_Yes) then
          raise  Exception.Create(nOutBill);
        //xxxxx

        nOutData := nOutData + nOutBill + ',';
        //combine bill

        nStr := MakeSQLByStr([SF('L_ID', nOutBill),
                SF('L_Card', nOrderItems[nIdx].FBillID),
                SF('L_ZhiKa', nOrderItems[nIdx].FOrders),
                SF('L_CusID', nOrderItems[nIdx].FCusID),
                SF('L_CusName', nOrderItems[nIdx].FCusName),
                SF('L_CusPY', GetPinYinOfStr(nOrderItems[nIdx].FCusName)),
                SF('L_CusCode', nOrderItems[nIdx].FCusCode),
                SF('L_SaleID', nOrderItems[nIdx].FSaleID),
                SF('L_SaleMan', nOrderItems[nIdx].FSaleMan),
                SF('L_Area', nOrderItems[nIdx].FAreaName),

                SF('L_Type', nOrderItems[nIdx].FStockType),
                SF('L_StockNo', nOrderItems[nIdx].FStockID),
                SF('L_StockName', nOrderItems[nIdx].FStockName),
                SF('L_PackStyle', nBillData.Values['Pack']),
                SF('L_Value', nOrderItems[nIdx].FKDValue, sfVal),
                SF('L_Price', 0, sfVal),

                SF('L_Truck', nBillData.Values['Truck']),
                SF('L_Status', sFlag_BillNew),
                SF('L_Lading', nBillData.Values['Lading']),
                SF('L_IsVIP', nBillData.Values['IsVIP']),
                SF('L_Seal', nBillData.Values['Seal']),
                SF('L_Man', gSysParam.FUserID),
                SF('L_Project', nOrderItems[nIdx].FMKBillUnit),
                SF('L_Date', sField_SQLServer_Now, sfVal)
                ], sTable_Bill, '', True);
        FDM.ExecuteSQL(nStr, False);

        if nBillData.Values['Post'] = sFlag_TruckBFM then //ɢװ����ʱ����
        begin
          nStr := nBillData.Values['PValue'];
          if not IsNumber(nStr, True) then
            nStr := '0';
          //xxxxx

          nStr := MakeSQLByStr([SF('L_Status', sFlag_TruckBFP),
                  SF('L_NextStatus', sFlag_TruckBFM),
                  SF('L_InTime', sField_SQLServer_Now, sfVal),
                  SF('L_PValue', nStr, sfVal),
                  SF('L_PDate', sField_SQLServer_Now, sfVal),
                  SF('L_PMan', gSysParam.FUserID),
                  SF('L_LadeTime', sField_SQLServer_Now, sfVal), 
                  SF('L_LadeMan', gSysParam.FUserID),
                  SF('L_Card', nBillData.Values['Card'])
                  ], sTable_Bill, SF('L_ID', nOutBill), False);
          FDM.ExecuteSQL(nStr, False);
        end else

        if nBillData.Values['BuDan'] = sFlag_Yes then //����
        begin
          nStr := MakeSQLByStr([SF('L_Status', sFlag_TruckBFM),
                  SF('L_InTime', sField_SQLServer_Now, sfVal),
                  SF('L_PValue', 0, sfVal),
                  SF('L_PDate', sField_SQLServer_Now, sfVal),
                  SF('L_PMan', gSysParam.FUserID),
                  SF('L_MValue', nOrderItems[nIdx].FKDValue, sfVal),
                  SF('L_MDate', sField_SQLServer_Now, sfVal),
                  SF('L_MMan', gSysParam.FUserID),
                  SF('L_OutFact', sField_SQLServer_Now, sfVal),
                  SF('L_OutMan', gSysParam.FUserID),
                  SF('L_Card', nOrderItems[nIdx].FBillID)
                  ], sTable_Bill, SF('L_ID', nOutBill), False);
          FDM.ExecuteSQL(nStr, False);
        end;

        if nBillData.Values['BuDan'] = sFlag_Yes then //����
        begin
          nStr := 'Update %s Set B_HasDone=B_HasDone+%.2f Where B_ID=''%s''';
          nStr := Format(nStr, [sTable_Order, nOrderItems[nIdx].FKDValue,
                  nOrderItems[nIdx].FOrders]);
          nInt := FDM.ExecuteSQL(nStr, False);

          if nInt < 1 then
          begin
            nSQL := MakeSQLByStr([
              SF('B_ID', nOrderItems[nIdx].FOrders),
              SF('B_HasDone', nOrderItems[nIdx].FKDValue, sfVal)
              ], sTable_Order, '', True);
            FDM.ExecuteSQL(nStr, False);
          end;
        end else
        begin
          nStr := 'Update %s Set B_Freeze=B_Freeze+%.2f Where B_ID=''%s''';
          nStr := Format(nStr, [sTable_Order, nOrderItems[nIdx].FKDValue,
                  nOrderItems[nIdx].FOrders]);
          nInt := FDM.ExecuteSQL(nStr, False);;

          if nInt < 1 then
          begin
            nStr := MakeSQLByStr([
              SF('B_ID', nOrderItems[nIdx].FOrders),
              SF('B_Freeze', nOrderItems[nIdx].FKDValue, sfVal)
              ], sTable_Order, '', True);
            FDM.ExecuteSQL(nStr, False);;
          end;
        end;
      end;

      nIdx := Length(nOutData);
      if Copy(nOutData, nIdx, 1) = ',' then
        System.Delete(nOutData, nIdx, 1);
      //xxxxx

      FDM.ADOConn.CommitTrans;
      Result := nOutData;
    except
      FDM.ADOConn.RollbackTrans;
      raise;
    end;
  finally
    nListA.Free;
  end;
end;

function DeleteBill(const nBill: string): Boolean;
var nIdx: Integer;
    nHasOut: Boolean;
    nVal: Double;
    nStr,nP,nZK: string;
begin
  Result := False;
  //init

  nStr := 'Select L_ZhiKa,L_Value,L_MDate From %s ' +
          'Where L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, nBill]);

  with FDM.QuerySQL(nStr, False) do
  begin
    if RecordCount < 1 then
    begin
      nStr := '������[ %s ]����Ч.';
      nStr := Format(nStr, [nBill]);
      ShowDlg(nStr, sHint);
      Exit;
    end;

    nHasOut := FieldByName('L_MDate').AsString <> '';
    //�ѳ���

    if nHasOut then
    begin
      nStr := '������[ %s ]�ѳ���,������ɾ��.';
      nStr := Format(nStr, [nBill]);
      ShowDlg(nStr, sHint);
      Exit;
    end;

    nZK  := FieldByName('L_ZhiKa').AsString;
    nVal := FieldByName('L_Value').AsFloat;
  end;

  FDM.ADOConn.BeginTrans;
  try
    //--------------------------------------------------------------------------
    if nHasOut then
    begin
      nStr := 'Update %s Set B_HasDone=B_HasDone-(%.2f) Where B_ID=''%s''';
      nStr := Format(nStr, [sTable_Order, nVal, nZK]);
      FDM.ExecuteSQL(nStr, False);
      //�ͷŷ�����
    end else
    begin
      nStr := 'Update %s Set B_Freeze=B_Freeze-(%.2f) Where B_ID=''%s''';
      nStr := Format(nStr, [sTable_Order, nVal, nZK]);
      FDM.ExecuteSQL(nStr, False);
      //�ͷŶ�����
    end;
    
    //--------------------------------------------------------------------------
    nStr := Format('Select * From %s Where 1<>1', [sTable_Bill]);
    //only for fields
    nP := '';

    with FDM.QuerySQL(nStr, False) do
    begin
      for nIdx:=0 to FieldCount - 1 do
       if (Fields[nIdx].DataType <> ftAutoInc) and
          (Pos('L_Del', Fields[nIdx].FieldName) < 1) then
        nP := nP + Fields[nIdx].FieldName + ',';
      //�����ֶ�,������ɾ��

      System.Delete(nP, Length(nP), 1);
    end;

    nStr := 'Insert Into $BB($FL,L_DelMan,L_DelDate) ' +
            'Select $FL,''$User'',$Now From $BI Where L_ID=''$ID''';
    nStr := MacroValue(nStr, [MI('$BB', sTable_BillBak),
            MI('$FL', nP), MI('$User', gSysParam.FUserID),
            MI('$Now', sField_SQLServer_Now),
            MI('$BI', sTable_Bill), MI('$ID', nBill)]);
    FDM.ExecuteSQL(nStr, False);

    nStr := 'Delete From %s Where L_ID=''%s''';
    nStr := Format(nStr, [sTable_Bill, nBill]);
    FDM.ExecuteSQL(nStr, False);

    FDM.ADOConn.CommitTrans;
    Result := True;
  except
    FDM.ADOConn.RollbackTrans;
    raise;
  end;
end;

function ChangeLadingTruckNo(const nBill,nTruck: string): Boolean;
var nStr: string;
begin
  Result := False;

  nStr := 'Select L_Truck,L_PDate From %s Where L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, nBill]);

  with FDM.QuerySQL(nStr) do
  begin
    if RecordCount <> 1 then
    begin
      nStr := '������[ %s ]����Ч.';
      nStr := Format(nStr, [nBill]);
      ShowDlg(nStr, sWarn);
      Exit;
    end;

    if Fields[1].AsString <> '' then
    begin
      nStr := '������[ %s ]�����,�޷��޸ĳ��ƺ�.';
      nStr := Format(nStr, [nBill]);
      ShowDlg(nStr, sWarn);
      Exit;
    end;
  end;

  nStr := 'Update %s Set L_Truck=''%s'' Where L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, nTruck, nBill]);
  FDM.ExecuteSQL(nStr);
  //�����޸���Ϣ
  Result := True;
end;

function GetSysValidDate: Integer;
var nStr: string;
    nDate: TDate;
    nInt: Integer;
begin
  Result := 0;
  nDate := Date();
  //server now

  nStr := 'Select D_Value,D_ParamB From %s ' +
          'Where D_Name=''%s'' and D_Memo=''%s''';
  nStr := Format(nStr, [sTable_SysDict, sFlag_SysParam, sFlag_ValidDate]);

  with FDM.QuerySQL(nStr, False) do
  if RecordCount > 0 then
  begin
    nStr := 'dmzn_stock_' + Fields[0].AsString;
    nStr := MD5Print(MD5String(nStr));

    if nStr = Fields[1].AsString then
      nDate := Str2Date(Fields[0].AsString);
    //xxxxx
  end;

  nInt := Trunc(nDate - Date());
  //xxxxx

  if nInt <= 0 then
  begin
    nStr := 'ϵͳ�ѹ��� %d ��,����ϵ����Ա!!';
    nStr := Format(nStr, [-nInt]);
    ShowDlg(nStr, sWarn);
    Exit;
  end;

  if nInt <= 7 then
  begin
    nStr := Format('ϵͳ�� %d ������', [nInt]);
    ShowMsg(nStr, sHint);
  end;

  Result := nInt;
end;

function LoadSysDictItem(const nItem: string; const nList: TStrings): TDataSet;
var nStr: string;
begin
  nList.Clear;
  nStr := MacroValue(sQuery_SysDict, [MI('$Table', sTable_SysDict),
                                      MI('$Name', nItem)]);
  Result := FDM.QuerySQL(nStr);

  if Result.RecordCount > 0 then
  with Result do
  begin
    First;

    while not Eof do
    begin
      nList.Add(FieldByName('D_Value').AsString);
      Next;
    end;
  end else Result := nil;
end;

end.
