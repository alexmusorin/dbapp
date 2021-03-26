unit ConfIEProtockol;

interface

uses Classes;

const
  ProtocolName = 'conf';

type
  TFileLoadHandler = procedure (URL: String; Stream: TStream) of object;

procedure RegisterMyProtocol;
procedure UnregisterMyProtocol;

procedure SetBrowserURLLoadHandler(Value: TFileLoadHandler);

implementation

uses Windows, ActiveX, UrlMon, ComObj, ComServ, StrUtils, SysUtils;

var
  FileLoadHandler: TFileLoadHandler;

type
  TMyProtocolForStupidIE = class(TComObject, IInternetProtocolRoot, IInternetProtocol)
  private { IInternetProtocolRoot }
    function Start(szUrl: LPCWSTR; OIProtSink: IInternetProtocolSink; OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
    function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
    function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
    function Terminate(dwOptions: DWORD): HResult; stdcall;
    function Suspend: HResult; stdcall;
    function Resume: HResult; stdcall;
  private { IInternetProtocol }
    function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
    function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD; out libNewPosition: ULARGE_INTEGER): HResult; stdcall;
    function LockRequest(dwOptions: DWORD): HResult; stdcall;
    function UnlockRequest: HResult; stdcall;
  private
    ProtSink: IInternetProtocolSink;
    BindInfo: IInternetBindInfo;
    Stream: TMemoryStream;
    function LoadDataToStream(URL: String): Boolean;
  public
    destructor Destroy; override;
    procedure Initialize; override;
  end;

{ TMyProtocolForStupidIE }

function TMyProtocolForStupidIE.Abort(hrReason: HResult;
  dwOptions: DWORD): HResult;
begin
  Result := Inet_E_Invalid_Request;
end;

function TMyProtocolForStupidIE.Continue(
  const ProtocolData: TProtocolData): HResult;
begin
  Result := Inet_E_Invalid_Request;
end;

destructor TMyProtocolForStupidIE.Destroy;
begin
  Stream.Free;
  inherited;
end;

procedure TMyProtocolForStupidIE.Initialize;
begin
  inherited;
  Stream := TMemoryStream.Create;
end;

function TMyProtocolForStupidIE.LoadDataToStream(URL: String): Boolean;
var
  grfBINDF: DWORD;
  _bindinfo: TBindInfo;

  function GetCacheFileName: String;
  begin
    Result := ReplaceStr(URL, '/', '\');
    if Result[Length(Result)] = '\' then Result := LeftStr(Result, Length(Result) - 1);
    Result := ExtractFileName(Result);
  end;

begin
  URL := RightStr(URL, Length(URL) - Length(ProtocolName) - 3);

  // говорим универсальный MIME тип
  ProtSink.ReportProgress(BINDSTATUS_MIMETYPEAVAILABLE, 'application/octet-stream');
  // сообщаем что есть файл в кеше. ≈сть ли он там на самом деле, не имеет значени¤
  // если сказать им¤ файла с ошибками (например передать URL) то мы не сможем загрузить mht
  ProtSink.ReportProgress(BINDSTATUS_CACHEFILENAMEAVAILABLE, PWideChar(GetCacheFileName));

  try
    if Assigned(FileLoadHandler) then
    begin
      FileLoadHandler(URL, Stream);
      Result := True;
    end;
  except
    Result := False;
  end;

end;

function TMyProtocolForStupidIE.LockRequest(dwOptions: DWORD): HResult;
begin
  Result := S_OK;
end;

function TMyProtocolForStupidIE.Read(pv: Pointer; cb: ULONG;
  out cbRead: ULONG): HResult;
begin
    Result := S_FALSE;
  if Stream.Position < Stream.Size then
  begin
    cbRead := Stream.Read(pv^, cb);
    if Stream.Position < Stream.Size then
      ProtSink.ReportData(BSCF_INTERMEDIATEDATANOTIFICATION, Stream.Position, Stream.Size) else
      ProtSink.ReportData(BSCF_LASTDATANOTIFICATION, Stream.Position, Stream.Size);
    Result := S_OK;
  end else
    Result := S_FALSE;
    ProtSink.ReportResult(S_OK, 0, nil);
end;

function TMyProtocolForStupidIE.Resume: HResult;
begin

end;

function TMyProtocolForStupidIE.Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
  out libNewPosition: ULARGE_INTEGER): HResult;
begin
  Result := Inet_E_Invalid_Request;
end;

function TMyProtocolForStupidIE.Start(szUrl: LPCWSTR;
  OIProtSink: IInternetProtocolSink; OIBindInfo: IInternetBindInfo; grfPI,
  dwReserved: DWORD): HResult;
begin
    //провер¤ем аргументы, которые нам понадоб¤тс¤
  if ((szUrl = nil) or (OIProtSink = nil)) then
    Result := E_INVALIDARG
  //загружаем данные
  else
  begin
    ProtSink := OIProtSink;
    BindInfo := OIBindInfo;
    if LoadDataToStream(szUrl) then
    begin
      //информируем о том что есть что отображать
      ProtSink.ReportData(BSCF_FIRSTDATANOTIFICATION, 0, Stream.Size);
      Result := S_OK;
    end else
      Result := INET_E_DOWNLOAD_FAILURE;
  end;
end;

function TMyProtocolForStupidIE.Suspend: HResult;
begin
  Result := Inet_E_Invalid_Request;
end;

function TMyProtocolForStupidIE.Terminate(dwOptions: DWORD): HResult;
begin
  ProtSink._Release;
  BindInfo._Release;
  Result := S_OK;
end;

function TMyProtocolForStupidIE.UnlockRequest: HResult;
begin
  Result := S_OK;
end;

procedure SetBrowserURLLoadHandler(Value: TFileLoadHandler);
begin
  FileLoadHandler := Value;
end;

const
  Class_MyProtocol: TGUID = '{D22F6C28-B464-47A4-B6ED-43E134C557DD}';

procedure CreateMyProtocol;
begin
  TComObjectFactory.Create(ComServer, TMyProtocolForStupidIE, Class_MyProtocol, TMyProtocolForStupidIE.ClassName, TMyProtocolForStupidIE.ClassName, ciMultiInstance);
end;

var
  Factory: IClassFactory;
  InternetSession: IInternetSession;

procedure RegisterMyProtocol;
begin
  CoGetClassObject(Class_MyProtocol, CLSCTX_SERVER, nil, IClassFactory, Factory);
  CoInternetGetSession(0, InternetSession, 0);
  InternetSession.RegisterNameSpace(Factory, Class_MyProtocol, ProtocolName, 0, nil, 0);
end;

procedure UnregisterMyProtocol;
begin
  InternetSession.UnregisterNameSpace(Factory, ProtocolName);
end;

initialization
  CreateMyProtocol;

end.
