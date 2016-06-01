{*******************************************************************************
  ����: dmzn@163.com 2014-06-10
  ����: �ֶ�����
*******************************************************************************}
unit UFramePoundManual;

{$I Link.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFrameBase, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, ADODB, ExtCtrls, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, Menus;

type
  TfFramePoundManual = class(TBaseFrame)
    WorkPanel: TScrollBox;
    Timer1: TTimer;
    cxSplitter1: TcxSplitter;
    SQLQuery: TADOQuery;
    DataSource1: TDataSource;
    cxGrid1: TcxGrid;
    cxView1: TcxGridDBTableView;
    cxLevel1: TcxGridLevel;
    PMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure WorkPanelMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure LoadPoundItems;
    //����ͨ��
    procedure LoadPoundData(const nWhere: string = '');
    //��������
  public
    { Public declarations }
    class function FrameID: integer; override;
    function FrameTitle: string; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    function DealCommand(Sender: TObject; const nCmd: integer): integer; override;
    //����̳�
  end;

implementation

{$R *.dfm}

uses
  IniFiles, UlibFun, UMgrControl, UMgrPoundTunnels, UFramePoundManualItem,
  UDataModule, UFormWait, USysDataDict, USysGrid, USysLoger, USysConst, USysDB;

class function TfFramePoundManual.FrameID: integer;
begin
  Result := cFI_FramePoundManual;
end;

function TfFramePoundManual.FrameTitle: string;
begin
  Result := '���� - �˹�';
end;

procedure TfFramePoundManual.OnCreateFrame;
var nInt: Integer;
    nIni: TIniFile;
begin
  inherited;
  gSysParam.FIsManual := True;

  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    nInt := nIni.ReadInteger(Name, 'GridHeight', 0);
    if nInt > 20 then
      cxGrid1.Height := nInt;
    //xxxxx

    gSysEntityManager.BuildViewColumn(cxView1, 'MAIN_E03');
    InitTableView(Name, cxView1, nIni);
  finally
    nIni.Free;
  end;

  if not Assigned(gPoundTunnelManager) then
  begin
    gPoundTunnelManager := TPoundTunnelManager.Create;
    gPoundTunnelManager.LoadConfig(gPath + 'Tunnels.xml');
  end;
end;

procedure TfFramePoundManual.OnDestroyFrame;
var nIni: TIniFile;
begin
  gSysParam.FIsManual := False;
  //�ر��ֶ�����

  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    nIni.WriteInteger(Name, 'GridHeight', cxGrid1.Height);
    SaveUserDefineTableView(Name, cxView1, nIni);
  finally
    nIni.Free;
  end;

  inherited;
end;

function TfFramePoundManual.DealCommand(Sender: TObject;
  const nCmd: integer): integer;
begin
  if (Sender is TfFrameManualPoundItem) and (nCmd = cCmd_RefreshData) then
    LoadPoundData;
  Result := 0;
end;

//------------------------------------------------------------------------------
//Desc: ��ʱ����ͨ��
procedure TfFramePoundManual.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  if gSysParam.FFactNum = '' then
  begin
    ShowDlg('ϵͳ��Ҫ��Ȩ���ܳ���,����ϵ����Ա.', sHint);
    Exit;
  end;

  LoadPoundItems;
  LoadPoundData;
end;

//Desc: ֧�ֹ���
procedure TfFramePoundManual.WorkPanelMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  with WorkPanel do
    VertScrollBar.Position := VertScrollBar.Position - WheelDelta;
  //xxxxx
end;

//Desc: ����ͨ��
procedure TfFramePoundManual.LoadPoundItems;
var nIdx: Integer;
    nT: PPTTunnelItem;
begin
  with gPoundTunnelManager do
  begin
    for nIdx:=0 to Tunnels.Count - 1 do
    begin
      nT := Tunnels[nIdx];
      //tunnel

      with TfFrameManualPoundItem.Create(Self) do
      begin
        Name := 'fFrameManualPoundItem' + IntToStr(nIdx);
        Parent := WorkPanel;

        Align := alTop;
        HintLabel.Caption := nT.FName;
        PoundTunnel := nT;
      end;
    end;
  end;
end;

//Desc: ��������
procedure TfFramePoundManual.LoadPoundData(const nWhere: string);
var nStr: string;
begin
  ShowWaitForm(ParentForm, '��ȡ����');
  try
    nStr := 'Select * From $TB Where (P_PDate Is Null Or P_MDate Is Null)' +
            ' And (P_PDate > $Now-2 Or P_MDate > $Now-2) And (P_PModel<>''$Tmp'')';
    nStr := MacroValue(nStr, [MI('$TB', sTable_PoundLog),
            MI('$Now', sField_SQLServer_Now), MI('$Tmp', sFlag_PoundLS)]);
    //xxxxx

    if nWhere <> '' then
      nStr := nStr + ' And (' + nWhere + ')';
    FDM.QueryData(SQLQuery, nStr, False);
  finally
    CloseWaitForm;
  end;
end;

procedure TfFramePoundManual.N1Click(Sender: TObject);
begin
  LoadPoundData('');
end;

initialization
  gControlManager.RegCtrl(TfFramePoundManual, TfFramePoundManual.FrameID);
end.
