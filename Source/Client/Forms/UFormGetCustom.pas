{*******************************************************************************
  ����: dmzn@163.com 2010-3-9
  ����: ѡ��ͻ�
*******************************************************************************}
unit UFormGetCustom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, dxLayoutControl, StdCtrls, cxControls,
  ComCtrls, cxListView, cxButtonEdit, cxLabel, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfFormGetCustom = class(TfFormNormal)
    EditCus: TcxButtonEdit;
    dxLayout1Item5: TdxLayoutItem;
    ListCustom: TcxListView;
    dxLayout1Item6: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item7: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure ListCustomKeyPress(Sender: TObject; var Key: Char);
    procedure EditCIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure ListCustomDblClick(Sender: TObject);
  private
    { Private declarations }
    FCusID,FCusName: string;
    //�ͻ���Ϣ
    procedure InitFormData(const nID: string);
    //��ʼ������
    function QueryCustom(const nType: Byte): Boolean;
    //��ѯ�ͻ�
    procedure GetResult;
    //��ȡ���
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}

uses
  IniFiles, ULibFun, UMgrControl, UAdjustForm, UFormCtrl, UFormBase, USysGrid,
  USysDB, USysConst, UDataModule, UBusinessConst;

class function TfFormGetCustom.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  with TfFormGetCustom.Create(Application) do
  begin
    Caption := 'ѡ��ͻ�';
    InitFormData(nP.FParamA);

    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;

    if nP.FParamA = mrOK then
    begin
      nP.FParamB := FCusID;
      nP.FParamC := FCusName;
    end;
    Free;
  end;
end;

class function TfFormGetCustom.FormID: integer;
begin
  Result := cFI_FormGetCustom;
end;

procedure TfFormGetCustom.FormCreate(Sender: TObject);
var nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    LoadFormConfig(Self, nIni);
    LoadcxListViewConfig(Name, ListCustom, nIni);
  finally
    nIni.Free;
  end;
end;

procedure TfFormGetCustom.FormClose(Sender: TObject;
  var Action: TCloseAction);
var nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    SaveFormConfig(Self, nIni);
    SavecxListViewConfig(Name, ListCustom, nIni);
  finally
    nIni.Free;
  end;

  ReleaseCtrlData(Self);
end;

//------------------------------------------------------------------------------
//Desc: ��ʼ����������
procedure TfFormGetCustom.InitFormData(const nID: string);
begin
  if nID <> '' then
  begin
    EditCus.Text := nID;
    if QueryCustom(10) then ActiveControl := ListCustom;
  end else ActiveControl := EditCus;
end;

//Date: 2010-3-9
//Parm: ��ѯ����(10: ������)
//Desc: ��ָ�����Ͳ�ѯ��ͬ
function TfFormGetCustom.QueryCustom(const nType: Byte): Boolean;
var nStr: string;
begin
  Result := False;
  ListCustom.Items.Clear; 
  nStr := GetQueryCustomerSQL(EditCus.Text, EditCus.Text);

  with FDM.QueryTemp(nStr, True) do
  if RecordCount > 0 then
  begin
    First;

    while not Eof do
    with ListCustom.Items.Add do
    begin
      Caption := FieldByName('custcode').AsString;
      SubItems.Add(FieldByName('custname').AsString);
      SubItems.Add(FieldByName('cmnecode').AsString);

      ImageIndex := cItemIconIndex;
      Next;
    end;

    ListCustom.ItemIndex := 0;
    Result := True;
  end;
end;

procedure TfFormGetCustom.EditCIDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  EditCus.Text := Trim(EditCus.Text);
  if (EditCus.Text <> '') and QueryCustom(10) then ListCustom.SetFocus;
end;

//Desc: ��ȡ���
procedure TfFormGetCustom.GetResult;
begin
  with ListCustom.Selected do
  begin
    FCusID := Caption;
    FCusName := SubItems[0];
  end;
end;

procedure TfFormGetCustom.ListCustomKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if ListCustom.ItemIndex > -1 then
    begin
      GetResult;
      ModalResult := mrOk;
    end;
  end;
end;

procedure TfFormGetCustom.ListCustomDblClick(Sender: TObject);
begin
  if ListCustom.ItemIndex > -1 then
  begin
    GetResult;
    ModalResult := mrOk;
  end;
end;

procedure TfFormGetCustom.BtnOKClick(Sender: TObject);
begin
  if ListCustom.ItemIndex > -1 then
  begin
    GetResult;
    ModalResult := mrOk;
  end else ShowMsg('���ڲ�ѯ�����ѡ��', sHint);
end;

initialization
  gControlManager.RegCtrl(TfFormGetCustom, TfFormGetCustom.FormID);
end.
