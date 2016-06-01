{*******************************************************************************
  ����: fendou116688@163.com 2015-03-25
  ����: ѡ��NC����
*******************************************************************************}
unit UFormGetNCBill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, cxListView,
  cxDropDownEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxMCListBox,
  dxLayoutControl, StdCtrls;

type
  TfFormNCBill = class(TfFormNormal)
    dxLayout1Item7: TdxLayoutItem;
    ListInfo: TcxMCListBox;
    dxLayout1Item8: TdxLayoutItem;
    EditID: TcxButtonEdit;
    dxGroup2: TdxLayoutGroup;
    dxLayout1Item3: TdxLayoutItem;
    ListDetail: TcxListView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnOKClick(Sender: TObject);
    procedure ListDetailSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  protected
    { Private declarations }
    FShowPrice: Boolean;
    //��ʾ����
    FListA, FListB, FListC: TStrings;
    procedure InitFormData(const nID: string);
    //��������
    procedure ClearSaleBillInfo;
    function LoadSaleBillsInfo(const nID: string):Boolean;
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
  DB, IniFiles, ULibFun, UFormBase, UMgrControl, UAdjustForm, UDataModule,USysLoger,
  USysPopedom, USysGrid, USysDB, USysConst, UBusinessPacker, UBusinessConst;

var
  gParam: PFormCommandParam = nil;
  //ȫ��ʹ��

procedure WriteLog(nEvent: string);
begin
  gSysLoger.AddLog(TfFormNCBill, 'ѡ��NC����', nEvent);
end;

class function TfFormNCBill.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
begin
  Result := nil;
  if not Assigned(nParam) then Exit;
  gParam := nParam;

  with TfFormNCBill.Create(Application) do
  try
    Caption := 'ѡ�񶩵�';
    InitFormData(gParam.FParamA);
    FShowPrice := gPopedomManager.HasPopedom(nPopedom, sPopedom_ViewPrice);
    
    gParam.FCommand := cCmd_ModalResult;
    gParam.FParamA := ShowModal;
  finally
    Free;
  end;
end;

class function TfFormNCBill.FormID: integer;
begin
  Result := cFI_FormGetNCBill;
end;

procedure TfFormNCBill.FormCreate(Sender: TObject);
begin
  FListA := TStringList.Create;
  FListB := TStringList.Create;
  FListC := TStringList.Create;

  LoadMCListBoxConfig(Name, ListInfo);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormNCBill.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FListA.Free;
  FListB.Free;
  FListC.Free;
  
  SaveMCListBoxConfig(Name, ListInfo);
  SavecxListViewConfig(Name, ListDetail);
  ReleaseCtrlData(Self);
end;

//------------------------------------------------------------------------------
procedure TfFormNCBill.InitFormData(const nID: string);
begin
  dxGroup1.AlignVert := avTop;
  ActiveControl := EditID;
  LoadSaleBillsInfo(nID);
end;

//Desc: ��������Ϣ
procedure TfFormNCBill.ClearSaleBillInfo;
begin
  if not EditID.Focused then EditID.Clear;

  ListInfo.Clear;
  ActiveControl := EditID;
end;

//Desc: ����nID������Ϣ
function TfFormNCBill.LoadSaleBillsInfo(const nID: string): Boolean;
var nDS: TDataSet;
    nStr, nTmp: string;
    nIdx, nInt: Integer;
    nVal: Double;
    nRet: Boolean;
begin
  ClearSaleBillInfo;

  nInt := 0;
  ListDetail.Clear;
  EditID.Text := nID;

  FListA.Clear;
  FListA.Values['BillCode'] := nID;

  nRet := GetSQLQueryOrder(nStr , '103', FListA.Text);

  FListA.Clear;
  FListC.Clear;
  //xxxxx

  if nRet then
  begin

    nDS := FDM.QueryTemp(nStr, True);
    if Assigned(nDS) then
    with nDS do
    begin
      First;

      while not Eof do
      begin
        with FListB do
        begin
          Clear;
          Values['BillType']  := FieldByName('VBILLTYPE').AsString;
          Values['Card']      := FieldByName('VBILLCODE').AsString;
          Values['ZhiKa']     := FieldByName('pk_meambill').AsString;
          Values['CusCode']   := FieldByName('custcode').AsString;
          Values['CusName']   := FieldByName('custname').AsString;
          Values['AreaName']  := FieldByName('areaclname').AsString;

          Values['Truck']     := FieldByName('cvehicle').AsString;
          Values['KDValue']   := Format('%.2f', [FieldByName('nplannum').AsFloat]);

          Values['StockTP']   := FieldByName('nmeamflag').AsString;
          Values['StockCD']   := FieldByName('vmeaninvcode').AsString;
          Values['StockNM']   := FieldByName('vmeaminvname').AsString;
          Values['BatchCode'] := FieldByName('vbatchcode').AsString;

          Values['MKBillUnit']:= FieldByName('unitname').AsString;
          Values['MKBillMan'] := FieldByName('user_name').AsString;
          Values['MKBillDate']:= FieldByName('TMAKETIME').AsString;

          Values['BillOrign'] := sFlag_BillNC;
          //xxxxxx

          FListA.Add(FListB.Values['ZhiKa']);
        end;

        FListC.Add(PackerEncodeStr(FListB.Text));
        Next;
      end;

      if RecordCount>0 then
      begin
        GetOrderFHValue(FListA);
        for nIdx:=FListC.Count-1 downto 0 do
        begin
          nTmp := FListC[nIdx];
          FListB.Text := PackerDecodeStr(nTmp);

          nStr := FListB.Values['ZhiKa'];
          if not IsNumber(FListA.Values[nStr], True) then
          begin
            FListC.Delete(nIdx);
            Continue;
          end;

          nVal := Float2Float(StrToFloat(FListB.Values['KDValue']), cPrecision, False)
             - Float2Float(StrToFloat(FListA.Values[nStr]), cPrecision, False);
          if nVal<=0 then
          begin
            FListC.Delete(nIdx);
            Continue;
          end;

          FListB.Values['KDValue'] := Format('%.2f', [nVal]);
          FListC[nIdx] := PackerEncodeStr(FListB.Text);

          with ListDetail.Items.Add do
          begin
            Inc(nInt);
            Checked := False;
            Caption := FListB.Values['Card'];

            SubItems.Add(GetNCBillTypeCHS(FListB.Values['BillType'], nTmp));
            SubItems.Add(FListB.Values['CusName']);
            SubItems.Add(FListB.Values['StockNM']);
            SubItems.Add(FListB.Values['KDValue']);
          end;
        end;
      end;  
    end;
  end;
  //��NC��ȡ����

  nStr := 'Select * From %s Where L_ID Like ''%%%s%%'' And L_MDate IS NULL';
  nStr := Format(nStr, [sTable_Bill, nID]);
  //xxxxx

  with FDM.QueryTemp(nStr, False) do
  begin
    First;
    while not Eof do
    begin
      with FListB do
      begin
        Clear;
        Values['BillID']    := FieldByName('L_ID').AsString;
        Values['BillType']  := FieldByName('L_SaleMan').AsString;
        Values['Card']      := FieldByName('L_Card').AsString;
        Values['ZhiKa']     := FieldByName('L_ZhiKa').AsString;
        Values['CusCode']   := FieldByName('L_CusID').AsString;
        Values['CusName']   := FieldByName('L_CusName').AsString;

        Values['Truck']     := FieldByName('L_Truck').AsString;
        Values['KDValue']   := FieldByName('L_Value').AsString;

        Values['StockTP']   := FieldByName('L_Type').AsString;
        Values['StockCD']   := FieldByName('L_StockNo').AsString;
        Values['StockNM']   := FieldByName('L_StockName').AsString;
        Values['BatchCode'] := FieldByName('L_Seal').AsString;

        Values['MKBillUnit']:= FieldByName('L_Project').AsString;
        Values['MKBillMan'] := FieldByName('L_Man').AsString;
        Values['MKBillDate']:= FieldByName('L_Date').AsString;

        Values['BillOrign'] := sFlag_BillZX;
        //xxxxx
        
        FListA.Add(FListB.Values['ZhiKa']);

        with ListDetail.Items.Add do
        begin
          Inc(nInt);
          Checked := False;
          Caption := FListB.Values['BillID'];

          SubItems.Add(GetNCBillTypeCHS(FListB.Values['BillType'], nTmp));
          SubItems.Add(FListB.Values['CusName']);
          SubItems.Add(FListB.Values['StockNM']);
          SubItems.Add(FListB.Values['KDValue']);
        end;
      end;

      FListC.Add(PackerEncodeStr(FListB.Text));
      Next;
    end;
  end;  
  //־�Ż�ȡ����

  Result := nInt>0;
  BtnOK.Enabled := Result;
  if (not Result) then
  begin
    nStr := '������Ϣ������';
    ShowMsg(nStr, sHint);
    Exit;
  end;

  with ListDetail do
  begin
    if Items.Count < 1 then Exit;
    if Items.Count = 1 then Items[0].Checked := True;
    Items[0].Selected := True;
  end;  

  ActiveControl := BtnOK;
  //׼������
end;

procedure TfFormNCBill.EditIDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  EditID.Text := Trim(EditID.Text);
  if EditID.Text = '' then
  begin
    ClearSaleBillInfo;
    ShowMsg('����д��Ч���', sHint);
  end else LoadSaleBillsInfo(EditID.Text);
end;


//Desc: ѡ��ͻ�
procedure TfFormNCBill.BtnOKClick(Sender: TObject);
var nIdx, nInt, nSelect: Integer;
    nTmp: string;
begin
  nSelect := 0;

  for nIdx:=ListDetail.Items.Count-1 downto 0 do
  begin
    if ListDetail.Items[nIdx].Checked then Inc(nSelect)
    else
    begin
      for nInt:=FListC.Count-1 downto 0  do
      begin
        nTmp := FListC[nInt];
        FListB.Text := PackerDecodeStr(nTmp);

        nTmp := FListB.Values['BillOrign'];
        if ((nTmp=sFlag_BillZX)
            and (FListB.Values['BillID']=ListDetail.Items[nIdx].Caption))
          or ((nTmp=sFlag_BillNC)
            and (FListB.Values['Card'] = ListDetail.Items[nIdx].Caption)) then
        begin
          FListC.Delete(nInt);
          Break;
        end;
      end;  
    end;  
  end;

  if nSelect <> 1 then
  begin
    ShowMsg('��ѡ��Ψһ����', sHint);
    Exit;
  end;

  gParam.FParamB := FListC.Text;
  ModalResult := mrOk;
end;

procedure TfFormNCBill.ListDetailSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  inherited;

  ListInfo.Clear;
  with ListInfo.Items do
  begin
    Add('�������:' + Delimiter + Item.Caption);
    Add('��������:' + Delimiter + Item.SubItems[0]);
    Add('�ͻ�����:' + Delimiter + Item.SubItems[1]);
    Add('��������:' + Delimiter + Item.SubItems[2]);
    Add('�� �� ��:' + Delimiter + Item.SubItems[3]);
  end;

  EditID.Text := Item.Caption;
end;

initialization
  gControlManager.RegCtrl(TfFormNCBill, TfFormNCBill.FormID);
end.
