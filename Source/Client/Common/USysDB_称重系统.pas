{*******************************************************************************
  ����: dmzn@163.com 2008-08-07
  ����: ϵͳ���ݿⳣ������

  ��ע:
  *.�Զ�����SQL���,֧�ֱ���:$Inc,����;$Float,����;$Integer=sFlag_Integer;
    $Decimal=sFlag_Decimal;$Image,��������
*******************************************************************************}
unit USysDB;

{$I Link.inc}
interface

uses
  SysUtils, Classes;

const
  cSysDatabaseName: array[0..4] of String = (
     'Access', 'SQL', 'MySQL', 'Oracle', 'DB2');
  //db names

  cPrecision            = 100;
  {-----------------------------------------------------------------------------
   ����: ���㾫��
   *.����Ϊ�ֵļ�����,С��ֵ�Ƚϻ����������ʱ�������,���Ի��ȷŴ�,ȥ��
     С��λ������������.�Ŵ����ɾ���ֵȷ��.
  -----------------------------------------------------------------------------}

type
  TSysDatabaseType = (dtAccess, dtSQLServer, dtMySQL, dtOracle, dtDB2);
  //db types

  PSysTableItem = ^TSysTableItem;
  TSysTableItem = record
    FTable: string;
    FNewSQL: string;
  end;
  //ϵͳ����

var
  gSysTableList: TList = nil;                        //ϵͳ������
  gSysDBType: TSysDatabaseType = dtSQLServer;        //ϵͳ��������

//------------------------------------------------------------------------------
const
  //�����ֶ�
  sField_Access_AutoInc          = 'Counter';
  sField_SQLServer_AutoInc       = 'Integer IDENTITY (1,1) PRIMARY KEY';

  //С���ֶ�
  sField_Access_Decimal          = 'Float';
  sField_SQLServer_Decimal       = 'Decimal(35, 5)';

  //ͼƬ�ֶ�
  sField_Access_Image            = 'OLEObject';
  sField_SQLServer_Image         = 'Image';

  //�������
  sField_SQLServer_Now           = 'getDate()';

ResourceString     
  {*Ȩ����*}
  sPopedom_Read       = 'A';                         //���
  sPopedom_Add        = 'B';                         //���
  sPopedom_Edit       = 'C';                         //�޸�
  sPopedom_Delete     = 'D';                         //ɾ��
  sPopedom_Preview    = 'E';                         //Ԥ��
  sPopedom_Print      = 'F';                         //��ӡ
  sPopedom_Export     = 'G';                         //����
  sPopedom_ViewPrice  = 'H';                         //�鿴����
  sPopedom_KouZa      = 'I';                         //����

  {*��ر��*}
  sFlag_Yes           = 'Y';                         //��
  sFlag_No            = 'N';                         //��
  sFlag_Enabled       = 'Y';                         //����
  sFlag_Disabled      = 'N';                         //����

  sFlag_Integer       = 'I';                         //����
  sFlag_Decimal       = 'D';                         //С��

  sFlag_PoundBZ       = 'B';                         //��׼
  sFlag_PoundPZ       = 'Z';                         //Ƥ��
  sFlag_PoundPD       = 'P';                         //���
  sFlag_PoundCC       = 'C';                         //����(����ģʽ)
  sFlag_PoundLS       = 'L';                         //��ʱ

  sFlag_BillNew       = 'N';                         //�µ�
  sFlag_BillEdit      = 'E';                         //�޸�
  sFlag_BillDel       = 'D';                         //ɾ��
  sFlag_BillLading    = 'L';                         //�����
  sFlag_BillPick      = 'P';                         //����
  sFlag_BillPost      = 'G';                         //����
  sFlag_BillDone      = 'O';                         //���

  sFlag_BillNC        = 'N';                         //NC����
  sFlag_BillZX        = 'S';                         //־�ſ���

  sFlag_PoundIfDai    = 'PoundIFDai';                //��װ�Ƿ����
  sFlag_PoundWuCha    = 'PoundWuCha';                //����������
  sFlag_PoundPWuChaZ  = 'PoundPWuChaZ';              //Ƥ�������
  sFlag_PoundPWuChaF  = 'PoundPWuChaF';              //Ƥ�ظ����
  sFlag_PDaiWuChaZ    = 'PoundDaiWuChaZ';            //��װ�����
  sFlag_PDaiWuChaF    = 'PoundDaiWuChaF';            //��װ�����
  sFlag_PDaiPercent   = 'PoundDaiPercent';           //�������������
  sFlag_PDaiWuChaStop = 'PoundDaiWuChaStop';         //���ʱֹͣҵ��
  sFlag_PSanWuChaF    = 'PoundSanWuChaF';            //ɢװ�����
  sFlag_PTruckPWuCha  = 'PoundTruckPValue';          //�ճ�Ƥ���

  sFlag_DeductFix     = 'F';                         //�̶�ֵ�ۼ�
  sFlag_DeductPer     = 'P';                         //�ٷֱȿۼ�

  sFlag_TruckBFP      = 'P';                         //����Ƥ�س���
  sFlag_TruckBFM      = 'M';                         //����ë�س���

  sFlag_OrderInFact   = 'OrderInFact';               //�������ֿɷ�������
  sFlag_InDepot       = 'Depot';                     //�����

  sFlag_InFact        = 'Factory';                   //�����ɷ����գ�������
  sFlag_InWHouse      = 'Warehouse';                 //���ɷ����գ�������
  sFlag_InWHID        = 'WarehouseID';               //�ֿ�ɷ����գ������� 

  sFlag_TypeShip      = 'S';                         //����
  sFlag_TypeZT        = 'Z';                         //ջ̨
  sFlag_TypeVIP       = 'V';                         //VIP
  sFlag_TypeCommon    = 'C';                         //��ͨ,��������

  sFlag_Provide       = 'P';                         //��Ӧ
  sFlag_Dispatch      = 'D';                         //����
  sFlag_Sale          = 'S';                         //����
  sFlag_NChange       = 'N';                         //�ڲ�
  sFlag_Returns       = 'R';                         //�˻�
  sFlag_Other         = 'O';                         //����

  sFlag_San           = '0';                         //ɢװˮ��
  sFlag_Dai           = '1';                         //��װˮ��
  sFlag_Dai2          = '2';                         //��װˮ��

  sFlag_BusGroup      = 'BusFunction';               //ҵ�������
  sFlag_PoundID       = 'Bus_Pound';                 //���ؼ�¼
  sFlag_BillNo        = 'Bus_Bill';                  //��������

  sFlag_CommonItem    = 'CommonItem';                //������Ϣ
  sFlag_PoundLogItem  = 'PoundLogItem';              //������Ϣ
  sFlag_CustomerItem  = 'CustomerItem';              //�ͻ���Ϣ��
  sFlag_BillItem      = 'BillItem';                  //�ᵥ��Ϣ��
  sFlag_ProviderItem  = 'ProInfoItem';               //��Ӧ����Ϣ��
  sFlag_MaterailsItem = 'MaterailsItem';             //ԭ������Ϣ��
  sFlag_TransportItem = 'TransportItem';             //���䵥λ��Ϣ��

  sFlag_SysParam      = 'SysParam';                  //ϵͳ����
  sFlag_EnableBakdb   = 'Uses_BackDB';               //���ÿ�
  sFlag_PrintBill     = 'PrintStockBill';            //���ӡ����
  sFlag_ValidDate     = 'SysValidDate';              //��Ч��

  {*���ݱ�*}
  sTable_Group        = 'Sys_Group';                 //�û���
  sTable_User         = 'Sys_User';                  //�û���
  sTable_Menu         = 'Sys_Menu';                  //�˵���
  sTable_Popedom      = 'Sys_Popedom';               //Ȩ�ޱ�
  sTable_PopItem      = 'Sys_PopItem';               //Ȩ����
  sTable_Entity       = 'Sys_Entity';                //�ֵ�ʵ��
  sTable_DictItem     = 'Sys_DataDict';              //�ֵ���ϸ

  sTable_SysDict      = 'Sys_Dict';                  //ϵͳ�ֵ�
  sTable_ExtInfo      = 'Sys_ExtInfo';               //������Ϣ
  sTable_SysLog       = 'Sys_EventLog';              //ϵͳ��־
  sTable_BaseInfo     = 'Sys_BaseInfo';              //������Ϣ
  sTable_SerialBase   = 'Sys_SerialBase';            //��������
  sTable_SerialStatus = 'Sys_SerialStatus';          //���״̬
  sTable_WorkePC      = 'Sys_WorkePC';               //��֤��Ȩ

  sTable_Provider     = 'P_Provider';                //�ͻ���
  sTable_Materails    = 'P_Materails';               //���ϱ�
  sTable_Transport    = 'P_Transport';               //���䵥λ��
  sTable_PoundLog     = 'Sys_PoundLog';              //��������
  sTable_PoundBak     = 'Sys_PoundBak';              //��������
  sTable_Deduct       = 'S_PoundDeduct';             //��������

  sTable_Truck        = 'S_Truck';                   //������
  sTable_Bill         = 'S_Bill';                    //�����
  sTable_BillBak      = 'S_BillBak';                 //�����
  sTable_Order        = 'S_Order';                   //���۶���

  {*�½���*}
  sSQL_NewSysDict = 'Create Table $Table(D_ID $Inc, D_Name varChar(15),' +
       'D_Desc varChar(30), D_Value varChar(50), D_Memo varChar(20),' +
       'D_ParamA $Float, D_ParamB varChar(50), D_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   ϵͳ�ֵ�: SysDict
   *.D_ID: ���
   *.D_Name: ����
   *.D_Desc: ����
   *.D_Value: ȡֵ
   *.D_Memo: �����Ϣ
   *.D_ParamA: �������
   *.D_ParamB: �ַ�����
   *.D_Index: ��ʾ����
  -----------------------------------------------------------------------------}
  
  sSQL_NewExtInfo = 'Create Table $Table(I_ID $Inc, I_Group varChar(20),' +
       'I_ItemID varChar(20), I_Item varChar(30), I_Info varChar(500),' +
       'I_ParamA $Float, I_ParamB varChar(50), I_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   ��չ��Ϣ��: ExtInfo
   *.I_ID: ���
   *.I_Group: ��Ϣ����
   *.I_ItemID: ��Ϣ��ʶ
   *.I_Item: ��Ϣ��
   *.I_Info: ��Ϣ����
   *.I_ParamA: �������
   *.I_ParamB: �ַ�����
   *.I_Memo: ��ע��Ϣ
   *.I_Index: ��ʾ����
  -----------------------------------------------------------------------------}
  
  sSQL_NewSysLog = 'Create Table $Table(L_ID $Inc, L_Date DateTime,' +
       'L_Man varChar(32),L_Group varChar(20), L_ItemID varChar(20),' +
       'L_KeyID varChar(20), L_Event varChar(220))';
  {-----------------------------------------------------------------------------
   ϵͳ��־: SysLog
   *.L_ID: ���
   *.L_Date: ��������
   *.L_Man: ������
   *.L_Group: ��Ϣ����
   *.L_ItemID: ��Ϣ��ʶ
   *.L_KeyID: ������ʶ
   *.L_Event: �¼�
  -----------------------------------------------------------------------------}

  sSQL_NewBaseInfo = 'Create Table $Table(B_ID $Inc, B_Group varChar(15),' +
       'B_Text varChar(100), B_Py varChar(25), B_Memo varChar(50),' +
       'B_PID Integer, B_Index Float)';
  {-----------------------------------------------------------------------------
   ������Ϣ��: BaseInfo
   *.B_ID: ���
   *.B_Group: ����
   *.B_Text: ����
   *.B_Py: ƴ����д
   *.B_Memo: ��ע��Ϣ
   *.B_PID: �ϼ��ڵ�
   *.B_Index: ����˳��
  -----------------------------------------------------------------------------}

  sSQL_NewSerialBase = 'Create Table $Table(R_ID $Inc, B_Group varChar(15),' +
       'B_Object varChar(32), B_Prefix varChar(25), B_IDLen Integer,' +
       'B_Base Integer, B_Date DateTime)';
  {-----------------------------------------------------------------------------
   ���б�Ż�����: SerialBase
   *.R_ID: ���
   *.B_Group: ����
   *.B_Object: ����
   *.B_Prefix: ǰ׺
   *.B_IDLen: ��ų�
   *.B_Base: ����
   *.B_Date: �ο�����
  -----------------------------------------------------------------------------}

  sSQL_NewSerialStatus = 'Create Table $Table(R_ID $Inc, S_Object varChar(32),' +
       'S_SerailID varChar(32), S_PairID varChar(32), S_Status Char(1),' +
       'S_Date DateTime)';
  {-----------------------------------------------------------------------------
   ����״̬��: SerialStatus
   *.R_ID: ���
   *.S_Object: ����
   *.S_SerailID: ���б��
   *.S_PairID: ��Ա��
   *.S_Status: ״̬(Y,N)
   *.S_Date: ����ʱ��
  -----------------------------------------------------------------------------}

  sSQL_NewWorkePC = 'Create Table $Table(R_ID $Inc, W_Name varChar(100),' +
       'W_MAC varChar(32), W_Factory varChar(32), W_Serial varChar(32),' +
       'W_Departmen varChar(32), W_ReqMan varChar(32), W_ReqTime DateTime,' +
       'W_RatifyMan varChar(32), W_RatifyTime DateTime, W_Valid Char(1))';
  {-----------------------------------------------------------------------------
   ������Ȩ: WorkPC
   *.R_ID: ���
   *.W_Name: ��������
   *.W_MAC: MAC��ַ
   *.W_Factory: �������
   *.W_Departmen: ����
   *.W_Serial: ���
   *.W_ReqMan,W_ReqTime: ��������
   *.W_RatifyMan,W_RatifyTime: ��׼
   *.W_Valid: ��Ч(Y/N)
  -----------------------------------------------------------------------------}

  sSQL_NewProvider = 'Create Table $Table(R_ID $Inc, P_ID varChar(32),' +
       'P_Name varChar(80),P_PY varChar(80), P_Phone varChar(20),' +
       'P_Saler varChar(32),P_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   ��Ӧ��: Provider
   *.P_ID: ���
   *.P_Name: ����
   *.P_PY: ƴ����д
   *.P_Phone: ��ϵ��ʽ
   *.P_Saler: ҵ��Ա
   *.P_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewTransport = 'Create Table $Table(R_ID $Inc, T_ID varChar(32),' +
       'T_Name varChar(80),T_PY varChar(80), T_Phone varChar(20),' +
       'T_Man varChar(32),T_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   ���䵥λ: Transport
   *.T_ID: ���
   *.T_Name: ����
   *.T_PY: ƴ����д
   *.T_Phone: ��ϵ��ʽ
   *.T_Man: ҵ��Ա
   *.T_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewMaterails = 'Create Table $Table(R_ID $Inc, M_ID varChar(32),' +
       'M_Name varChar(80),M_PY varChar(80),M_Unit varChar(20),M_Price $Float,' +
       'M_PrePValue Char(1), M_PrePTime Integer, M_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   ���ϱ�: Materails
   *.M_ID: ���
   *.M_Name: ����
   *.M_PY: ƴ����д
   *.M_Unit: ��λ
   *.M_PrePValue: Ԥ��Ƥ��
   *.M_PrePTime: Ƥ��ʱ��(��)
   *.M_Memo: ��ע
  -----------------------------------------------------------------------------}

    sSQL_NewPoundLog = 'Create Table $Table(R_ID $Inc, P_ID varChar(15),' +
       'P_Type varChar(1), P_Order varChar(30), P_Card varChar(30),' +
       'P_Bill varChar(30), P_Truck varChar(15), P_CusID varChar(32),' +
       'P_CusName varChar(80), P_MID varChar(32),P_MName varChar(80),' +
       'P_MType varChar(10), P_LimValue $Float,' +
       'P_PValue $Float, P_PDate DateTime, P_PMan varChar(32), ' +
       'P_MValue $Float, P_MDate DateTime, P_MMan varChar(32), ' +
       'P_FactID varChar(32), P_PStation varChar(10), P_MStation varChar(10),' +
       'P_Direction varChar(10), P_PModel varChar(10), P_Status Char(1),' +
       'P_Valid Char(1), P_PrintNum Integer Default 1,' +
       'P_DelMan varChar(32), P_DelDate DateTime, ' +
       'P_PDValue $Float,P_Areaname varChar(100),P_OutSeal varChar(20),' +
       'P_Transport varChar(100),P_KZValue $Float,P_KZComment varChar(300))';
  {-----------------------------------------------------------------------------
   ������¼: PoundLog
   *.P_ID: ���
   *.P_Type: ����(����,��Ӧ,��ʱ)
   *.P_Order: ������
   *.P_Bill: ������
   *.P_Truck: ����
   *.P_CusID: �ͻ���
   *.P_CusName: ������
   *.P_MID: ���Ϻ�
   *.P_MName: ������
   *.P_MType: ��,ɢ��
   *.P_LimValue: Ʊ��
   *.P_PValue,P_PDate,P_PMan: Ƥ��
   *.P_MValue,P_MDate,P_MMan: ë��
   *.P_FactID: �������
   *.P_PStation,P_MStation: ���ذ�վ
   *.P_Direction: ��������(��,��)
   *.P_PModel: ����ģʽ(��׼,��Ե�)
   *.P_Status: ��¼״̬
   *.P_Valid: �Ƿ���Ч
   *.P_PrintNum: ��ӡ����
   *.P_DelMan,P_DelDate: ɾ����¼
   *.P_PDValue: ����
   *.P_Transport:���䵥λ
   *.P_Areaname, P_OutSeal: �����߷�����λ,�������
   *.P_KZValue,P_KZComment:���ӣ���ԭ��
  -----------------------------------------------------------------------------}

  sSQL_NewDeduct = 'Create Table $Table(R_ID $Inc, D_Stock varChar(32),' +
       'D_Name varChar(80), D_CusID varChar(32), D_CusName varChar(80),' +
       'D_Value $Float, D_Type Char(1), D_Valid Char(1))';
  {-----------------------------------------------------------------------------
   ���α����: Batcode
   *.R_ID: ���
   *.D_Stock: ���Ϻ�
   *.D_Name: ������
   *.D_CusID: �ͻ���
   *.D_CusName: �ͻ���
   *.D_Value: ȡֵ
   *.D_Type: ����(F,�̶�ֵ;P,�ٷֱ�)
   *.D_Valid: �Ƿ���Ч(Y/N)
  -----------------------------------------------------------------------------}

  sSQL_NewTruck = 'Create Table $Table(R_ID $Inc, T_Truck varChar(15), ' +
       'T_PY varChar(15), T_Owner varChar(32), T_Phone varChar(15), ' +
       'T_PrePValue $Float, T_PrePMan varChar(32), T_PrePTime DateTime, ' +
       'T_PrePUse Char(1), T_MinPVal $Float, T_MaxPVal $Float, ' +
       'T_PValue $Float Default 0, T_PTime Integer Default 0,' +
       'T_PlateColor varChar(12),T_Type varChar(12), T_LastTime DateTime, ' +
       'T_Card varChar(32), T_CardUse Char(1), T_NoVerify Char(1),' +
       'T_Valid Char(1), T_VIPTruck Char(1))';
  {-----------------------------------------------------------------------------
   ������Ϣ:Truck
   *.R_ID: ��¼��
   *.T_Truck: ���ƺ�
   *.T_PY: ����ƴ��
   *.T_Owner: ����
   *.T_Phone: ��ϵ��ʽ
   *.T_PrePValue: Ԥ��Ƥ��
   *.T_PrePMan: Ԥ��˾��
   *.T_PrePTime: Ԥ��ʱ��
   *.T_PrePUse: ʹ��Ԥ��
   *.T_MinPVal: ��ʷ��СƤ��
   *.T_MaxPVal: ��ʷ���Ƥ��
   *.T_PValue: ��ЧƤ��
   *.T_PTime: ��Ƥ����
   *.T_PlateColor: ������ɫ
   *.T_Type: ����
   *.T_LastTime: �ϴλ
   *.T_Card: ���ӱ�ǩ
   *.T_CardUse: ʹ�õ���ǩ(Y/N)
   *.T_NoVerify: ��У��ʱ��
   *.T_Valid: �Ƿ���Ч
   *.T_VIPTruck:�Ƿ�VIP

   ��Чƽ��Ƥ���㷨:
   T_PValue = (T_PValue * T_PTime + ��Ƥ��) / (T_PTime + 1)
  -----------------------------------------------------------------------------}

  sSQL_NewBill = 'Create Table $Table(R_ID $Inc, L_ID varChar(20),' +
       'L_Card varChar(30), L_ZhiKa varChar(30), L_Project varChar(100),' +
       'L_Area varChar(50), L_CusID varChar(20), L_CusName varChar(80),' +
       'L_CusPY varChar(80), L_CusCode varChar(15),' +
       'L_SaleID varChar(20), L_SaleMan varChar(32),' +
       'L_Type Char(1), L_StockNo varChar(20), L_StockName varChar(80),' +
       'L_Value $Float, L_Price $Float, L_PackStyle Char(1),' +
       'L_Truck varChar(15), L_Status Char(1), L_NextStatus Char(1),' +
       'L_InTime DateTime, L_InMan varChar(32),' +
       'L_PValue $Float, L_PDate DateTime, L_PMan varChar(32),' +
       'L_MValue $Float, L_MDate DateTime, L_MMan varChar(32),' +
       'L_LadeTime DateTime, L_LadeMan varChar(32), ' +
       'L_LadeLine varChar(15), L_LineName varChar(32), ' +
       'L_DaiTotal Integer , L_DaiNormal Integer, L_DaiBuCha Integer,' +
       'L_OutFact DateTime, L_OutMan varChar(32),' +
       'L_Lading Char(1), L_IsVIP varChar(1), L_Seal varChar(100),' +
       'L_HYDan varChar(15), L_Man varChar(32), L_Date DateTime,' +
       'L_DelMan varChar(8), L_DelDate DateTime)';
  {-----------------------------------------------------------------------------
   ��������: Bill
   *.R_ID: ���
   *.L_ID: �ᵥ��
   *.L_Card: �ſ���
   *.L_ZhiKa: ֽ����
   *.L_Area: ����
   *.L_CusID,L_CusName,L_CusPY:�ͻ�
   *.L_CusCode:�ͻ�����
   *.L_SaleID,L_SaleMan:ҵ��Ա
   *.L_Type: ����(��,ɢ)
   *.L_StockNo: ���ϱ��
   *.L_StockName: �������� 
   *.L_Value: �����
   *.L_Price: �������
   *.L_PackStyle: ��װ����(ֽ����)
   *.L_Truck: ������
   *.L_Status,L_NextStatus:״̬����
   *.L_InTime,L_InMan: ��������
   *.L_PValue,L_PDate,L_PMan: ��Ƥ��
   *.L_MValue,L_MDate,L_MMan: ��ë��
   *.L_LadeTime,L_LadeMan: ����ʱ��,������
   *.L_LadeLine,L_LineName: ����ͨ��
   *.L_DaiTotal,L_DaiNormal,L_DaiBuCha:��װ,����,����
   *.L_OutFact,L_OutMan: ��������
   *.L_Lading: �����ʽ(����,�ͻ�)
   *.L_IsVIP:VIP��
   *.L_Seal: ��ǩ��
   *.L_HYDan: ���鵥
   *.L_Man:������
   *.L_Date:����ʱ��
   *.L_DelMan: ������ɾ����Ա
   *.L_DelDate: ������ɾ��ʱ��
   *.L_Memo: ������ע
  -----------------------------------------------------------------------------}

  sSQL_NewOrder = 'Create Table $Table(R_ID $Inc, B_ID varChar(20),' +
       'B_Freeze $Float, B_HasDone $Float)';
  {-----------------------------------------------------------------------------
   ������: Order
   *.R_ID: ��¼���
   *.B_ID: ������
   *.B_Freeze: ������
   *.B_HasDone: �����
  -----------------------------------------------------------------------------}

  //----------------------------------------------------------------------------
  // ���ݲ�ѯ
  //----------------------------------------------------------------------------
  sQuery_SysDict = 'Select D_ID, D_Value, D_Memo, D_ParamA, ' +
         'D_ParamB From $Table Where D_Name=''$Name'' Order By D_Index ASC';
  {-----------------------------------------------------------------------------
   �������ֵ��ȡ����
   *.$Table:�����ֵ��
   *.$Name:�ֵ�������
  -----------------------------------------------------------------------------}

  sQuery_ExtInfo = 'Select I_ID, I_Item, I_Info From $Table Where ' +
         'I_Group=''$Group'' and I_ItemID=''$ID'' Order By I_Index Desc';
  {-----------------------------------------------------------------------------
   ����չ��Ϣ���ȡ����
   *.$Table:��չ��Ϣ��
   *.$Group:��������
   *.$ID:��Ϣ��ʶ
  -----------------------------------------------------------------------------}

implementation

//------------------------------------------------------------------------------
//Desc: ���ϵͳ����
procedure AddSysTableItem(const nTable,nNewSQL: string);
var nP: PSysTableItem;
begin
  New(nP);
  gSysTableList.Add(nP);

  nP.FTable := nTable;
  nP.FNewSQL := nNewSQL;
end;

//Desc: ϵͳ��
procedure InitSysTableList;
begin
  gSysTableList := TList.Create;

  AddSysTableItem(sTable_SysDict, sSQL_NewSysDict);
  AddSysTableItem(sTable_ExtInfo, sSQL_NewExtInfo);
  AddSysTableItem(sTable_SysLog, sSQL_NewSysLog);

  AddSysTableItem(sTable_BaseInfo, sSQL_NewBaseInfo);
  AddSysTableItem(sTable_SerialBase, sSQL_NewSerialBase);
  AddSysTableItem(sTable_SerialStatus, sSQL_NewSerialStatus);
  AddSysTableItem(sTable_WorkePC, sSQL_NewWorkePC);

  AddSysTableItem(sTable_PoundLog, sSQL_NewPoundLog);
  AddSysTableItem(sTable_PoundBak, sSQL_NewPoundLog);
  AddSysTableItem(sTable_Deduct, sSQL_NewDeduct);
  AddSysTableItem(sTable_Provider, sSQL_NewProvider);
  AddSysTableItem(sTable_Materails, sSQL_NewMaterails);
  AddSysTableItem(sTable_Transport, sSQL_NewTransport);

  AddSysTableItem(sTable_Truck, sSQL_NewTruck);
  AddSysTableItem(sTable_Bill, sSQL_NewBill);
  AddSysTableItem(sTable_BillBak, sSQL_NewBill);
  AddSysTableItem(sTable_Order, sSQL_NewOrder);
end;

//Desc: ����ϵͳ��
procedure ClearSysTableList;
var nIdx: integer;
begin
  for nIdx:= gSysTableList.Count - 1 downto 0 do
  begin
    Dispose(PSysTableItem(gSysTableList[nIdx]));
    gSysTableList.Delete(nIdx);
  end;

  FreeAndNil(gSysTableList);
end;

initialization
  InitSysTableList;
finalization
  ClearSysTableList;
end.


