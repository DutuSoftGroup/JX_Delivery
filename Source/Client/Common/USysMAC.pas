{*******************************************************************************
  ����: dmzn@163.com 2010-8-16
  ����: ���ɿͻ��˽�ɫ��ʾ
*******************************************************************************}
unit USysMAC;

interface

uses
  Windows, Classes, SysUtils, NB30, WinSock;

function MakeActionID_MAC: string;
//��ɫ��ʶ
function GetLocalIPConfig(var nName,nIP: string): Boolean;
//��������,IP

implementation

//Desc: ��ȡnLana�ڵ��MAC��ַ
function GetAdapterInfo(const nLana: Char): String;
var nNCB: TNCB;
    nAdapter: TAdapterStatus;
begin
  Result := '';
  FillChar(nNCB, SizeOf(nNCB), #0);

  nNCB.ncb_lana_num := nLana;
  nNCB.ncb_command := Char(NCBRESET);
  if Netbios(@nNCB) <> Char(NRC_GOODRET) then Exit;

  FillChar(nNCB, SizeOf(nNCB), #0);
  nNCB.ncb_command := Char(NCBASTAT);
  nNCB.ncb_lana_num := nLana;
  nNCB.ncb_callname := '*';

  FillChar(nAdapter, SizeOf(nAdapter), #0);
  nNCB.ncb_buffer := @nAdapter;
  nNCB.ncb_length := SizeOf(nAdapter);

  if Netbios(@nNCB) = Char(NRC_GOODRET) then
  begin
    Result := IntToHex(Byte(nAdapter.adapter_address[0]), 2) + '-' +
              IntToHex(Byte(nAdapter.adapter_address[1]), 2) + '-' +
              IntToHex(Byte(nAdapter.adapter_address[2]), 2) + '-' +
              IntToHex(Byte(nAdapter.adapter_address[3]), 2) + '-' +
              IntToHex(Byte(nAdapter.adapter_address[4]), 2) + '-' +
              IntToHex(Byte(nAdapter.adapter_address[5]), 2);
  end;
end;

//Desc: ��ȡ����MAC��ַ
function MakeActionID_MAC: string;
var nNCB: TNCB;
    nEnum: TLanaEnum;
begin
  Result := '';
  FillChar(nNCB, SizeOf(nNCB), #0);

  nNCB.ncb_command := Char(NCBENUM);
  nNCB.ncb_buffer := @nEnum;
  nNCB.ncb_length := SizeOf(nEnum);

  if (Netbios(@nNCB) = Char(NRC_GOODRET)) and (Byte(nEnum.length) > 0) then
    Result := GetAdapterInfo(nEnum.lana[0]);
  //xxxxx
end;

//Desc: ��ȡ��������
function GetLocalIPConfig(var nName,nIP: string): Boolean;
var nP: PChar;
    nVer: WORD;
    nEnt: PHostEnt;
    nData: TWSAData;
    nBuf: array[0..128] of Char;
begin
  Result := False;
  nName := 'unknow';
  nIP := nName;
  
  nVer := MAKEWORD(1, 1);
  if WSAStartup(nVer, nData) = 0 then
  try
    GetHostName(@nBuf, 128);
    nEnt := gethostbyname(@nBuf);
    Result := Assigned(nEnt);

    if Result then
    begin
      nP := inet_ntoa(PInAddr(nEnt.h_addr_list^)^);
      nName := StrPas(nEnt.h_name);
      nIP := StrPas(nP);
    end;
  finally
    WSACleanup;
  end;
end; 

end.
