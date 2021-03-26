unit ScriptE;

interface

uses
  Windows, Messages, SysUtils, Classes, TypInfo, Controls, GridFrame, StdCtrls, CheckLst, EncdDecd,
  Forms, ActiveX, Graphics, activescp, scripts, ComObj, errfrm, displist, nmitems, ExtCtrls,
  Clipbrd, DelphiZXingQRCode, ComCtrls, SynMemo, DB, Series, Chart, Menus, Dialogs, PDF417Barcode;

ResourceString
  SBreakPointManager='Breakpoint manager';

  SErrDuplicateBreakpoints='Duplicated breakpoint';
  SErrInvalidItemSize='Incorrect item size (%d)';
  SErrReferencedObject='Object has references';
  SErrEvaluateTimeOut='Exoression time is expired. Answer is not available';
  SErrBreakPointNotSet='Can not set breakpoint on this line';
  SErrProcessNotAccesible='process is not accessible';
  SErrBreakpointBegin = 'Incorrect breakpoint condition: ';
  SErrBreakpointEnd = '. Error message: ';
  rsErrorOpenDebuggerFailed = 'Failed to start debugger session';
  rsErrorCauseBreak = 'Can not CauseBreak';

 type

  LongWord = DWORD;
  PLongWord = PDWORD;

  EInvalidParamCount = class(Exception)
  end;

  EInvalidParamType = class(Exception)
  end;

  IQueryPersistent = interface
  ['{26F5B6E1-9DA5-11D3-BCAD-00902759A497}']
    function GetPersistent: TPersistent;
  end;

  IEnumVariant = interface(IUnknown)
    ['{00020404-0000-0000-C000-000000000046}']
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  end;

  TVCLScriptControl = class;

  TVCLProxy = class(TInterfacedObject, IDispatch, IQueryPersistent)
  private
    FOwner: TPersistent;
    FScriptControl: TVCLScriptControl;
    FOnClick: IDispatch;
    FOnChange: IDispatch;
    FOnEnter: IDispatch;
    FOnExit: IDispatch;
    FOnMouseEnter: IDispatch;
    FOnMouseLeave: IDispatch;
    FOnMouseMove: IDispatch;
    FOnKeyPress: IDispatch;
    FOnKeyDown: IDispatch;
    FOnKeyUp: IDispatch;
    FOnDblClick: IDispatch;
    FOnTimer: IDispatch;
    FComp: Pointer;
    procedure ComponentClick(Sender: TObject);
    procedure ComponentChange(Sender: TObject);
    procedure ComponentEnter(Sender: TObject);
    procedure ComponentExit(Sender: TObject);
    procedure ComponentMouseEnter(Sender: TObject);
    procedure ComponentMouseLeave(Sender: TObject);
    procedure ComponentMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ComponentKeyPress(Sender: TObject; var Key: Char);
    procedure ComponentKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComponentKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComponentDblClick(Sender: TObject);
    procedure ComponentTimer(Sender: TObject);
    procedure ComponentTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure DoCreateControl(AName, AClassName: WideString; WithEvents: Boolean);
    function SetVCLProperty(PropInfo: PPropInfo; Argument: TVariantArg): HRESULT;
    function GetVCLProperty(PropInfo: PPropInfo; dps: TDispParams;
      PDispIds: PDispIdList; var Value: OleVariant): HRESULT;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    { IQueryPersistent }
    function GetPersistent: TPersistent;
  protected
    function DoInvoke (DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps : TDispParams; pDispIds : PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual;
  public
    constructor Create(AOwner: TPersistent; ScriptControl: TVCLScriptControl);
    destructor Destroy; override;
    procedure SetHandler(Control: TPersistent; Owner:TObject; Name: String);
  end;

  TVCLEnumerator = class(TInterfacedObject, IEnumVariant)
  private
    FEnumPosition: Integer;
    FOwner: TPersistent;
    FScriptControl: TVCLScriptControl;
    { IEnumVariant }
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  public
    constructor Create(AOwner: TPersistent; AScriptControl: TVCLScriptControl);
  end;

  TVCLScriptControl = class(TWinControl, IActiveScriptSite, IActiveScriptSiteWindow)
  private
    FProxyList: TList;
    FWinHandle: HWND;
    FListView: TListView;
    FEngine: IActiveScript;
    FParser: IActiveScriptParse;
    FNamedItems: TNamedItemList;
    FCanDebug: Boolean;
    FCodeMemo: TSynMemo;
    procedure CloseScriptEngine;
    procedure SetWinHandle(const Value: HWND);
    procedure SetListView(const Value: TListView);
    procedure SetCodeMemo(const Value: TSynMemo);
  protected
    { Protected declarations }
    function GetProxy(AOwner: TPersistent): IDispatch;
    procedure ProxyDestroyed(Address: Pointer);
    {IActiveScriptSite}
    function GetLCID(out plcid: LCID): HResult; stdcall;
    function GetItemInfo(pstrName: LPCOLESTR; dwReturnMask: DWORD;
      out ppiunkItem: IUnknown; out ppti: ITypeInfo): HResult; stdcall;
    function GetDocVersionString(out pbstrVersion: WideString): HResult; stdcall;
    function OnScriptTerminate(var pvarResult: OleVariant;
      var pexcepinfo: EXCEPINFO): HResult; stdcall;
    function OnStateChange(ssScriptState: SCRIPTSTATE): HResult; stdcall;
    function OnScriptError(const pscripterror: IActiveScriptError): HResult; stdcall;
    function OnEnterScript: HResult; stdcall;
    function OnLeaveScript: HResult; stdcall;
    function iParserText(const aCode: WideString): HResult; virtual;
  public
    FFuncList: TFuncList;
    FScriptDispatch: IDispatch;
    FTypeInfo: ITypeInfo;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;
    procedure RunProc(const Name: String);
    procedure RegisterClass(const Name: String; AClass: TPersistent); overload;
    procedure RegisterClass(const Name: String; Item: TInterfacedObject); overload;
    function RegisterObject(AClass: TPersistent):IDispatch;
    {IActiveSriptSiteWindow}
    function GetWindow(out phwnd: HWND): HResult; stdcall;
    function EnableModeless(fEnable: BOOL): HResult; stdcall;
    function SetScriptDispatch:boolean;
    procedure RunScript(Code: WideString);
    procedure CreateScriptEngine(Language: TScriptLanguage); virtual;
    procedure TerminateScript;
  published
    { Published declarations }
    property WinHandle:HWND read FWinHandle write SetWinHandle;
    property ListView:TListView read FListView write SetListView;
    property CodeMemo:TSynMemo read FCodeMemo write SetCodeMemo;
    property CanDebug: Boolean read FCanDebug write FCanDebug;
    procedure OnChangeHandler(Sender: TObject);
    procedure OnClickHandler(Sender: TObject);
    procedure OnEnterHandler(Sender: TObject);
    procedure OnExitHandler(Sender: TObject);
    procedure OnTimerHandler(Sender: TObject);
    procedure OnDataChangeHandler(Sender: TObject; Field: TField);
    procedure AfterScrollHandler(Sender: TObject; DataSet: TDataSet);
    procedure SetHandler(Control: TPersistent; Owner:TObject; Name: String);
  end;

   TAXErrorDebugEvent = procedure(const Sender: TObject; const aErrorDebug: IActiveScriptErrorDebug;
                var aEnterDebugger : BOOL;var aCallOnScriptErrorWhenContinuing : BOOL) of object;

  TVCLScriptControlDebug = class(TVCLScriptControl, IActiveScriptSiteDebug)
   protected
    FProcessDebugManager: IProcessDebugManager;
    FDebugApp: IDebugApplication;
    FDebugDocHelper: IDebugDocumentHelper;
    FAppCookie: DWORD;
    FAppName: WideString;
    FCanDebugError: Boolean;
    FBreakOnStart: Boolean;
    FOnErrorDebug: TAXErrorDebugEvent;

    procedure SetAppName(const Value: WideString);

    procedure InitDebugApplication;
    function iParserText(const aCode: WideString): HResult; override;
    procedure CreateScriptEngine(Language: TScriptLanguage); override;

    {IActiveScriptSiteDebug Interface}
    function GetDocumentContextFromPosition(const dwSourceContext : DWORD;
          const uCharacterOffset: ULONG; const uNumChars : ULONG;
          out ppsc : IDebugDocumentContext) : HRESULT; stdcall;

    function GetApplication(out ppda : IDebugApplication) : HRESULT; stdcall;
    function GetRootApplicationNode(out ppdanRoot : IDebugApplicationNode) : HRESULT; stdcall;
    function OnScriptErrorDebug(const pErrorDebug : IActiveScriptErrorDebug;
                out pfEnterDebugger : BOOL;out pfCallOnScriptErrorWhenContinuing : BOOL) : HRESULT; stdcall;
  public
    constructor Create(AOwner: TComponent);
    procedure DebugScript(Code: WideString);
    procedure OpenDebugger;
    property AppName: WideString read FAppName write SetAppName;
    property CanDebugError: Boolean read FCanDebugError write FCanDebugError default true;
    property BreakOnStart: Boolean read FBreakOnStart write FBreakOnStart;
    property OnErrorDebug: TAXErrorDebugEvent read FOnErrorDebug write FOnErrorDebug;
  end;




const
  IID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';

implementation

uses DataUnit;

{ Utility routines }

function ValidType(Argument: TVariantArg; TypeId: Integer;
  RaiseException: Boolean): Boolean;
begin
 Result := Argument.vt = TypeId;
 if RaiseException and (not Result) then
   raise EInvalidParamType.Create('');
end;

function CheckArgCount(Count: Integer; Accepted: array of Integer;
  RaiseException: Boolean): Boolean;
var
  I: Integer;
begin
  Result := FALSE;
  for I := Low(Accepted) to High(Accepted) do begin
    Result := Accepted[I] = Count;
    if Result then
      Break;
  end;
  if RaiseException and (not Result) then
    raise EInvalidParamCount.Create('');
end;

function isNotEvent(Value:string):boolean;
var isNotEv:boolean;
begin
  isNotEv:=true;
  if UpperCase(Value)='ONCLICK' then isNotEv:=false;
  if UpperCase(Value)='ONCHANGE' then isNotEv:=false;
  if UpperCase(Value)='ONENTER' then isNotEv:=false;
  if UpperCase(Value)='ONEXIT' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSEENTER' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSELEAVE' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSEMOVE' then isNotEv:=false;
  if UpperCase(Value)='ONKEYUP' then isNotEv:=false;
  if UpperCase(Value)='ONKEYDOWN' then isNotEv:=false;
  if UpperCase(Value)='ONKEYPRESS' then isNotEv:=false;
  if UpperCase(Value)='ONDBLCLICK' then isNotEv:=false;
  if UpperCase(Value)='ONTIMER' then isNotEv:=false;
  Result:=isNotEv;
end;

function IntValue(Argument: TVariantArg): Integer;
var
 VT: Word;
 ByRef: Boolean;
begin
 VT := Argument.vt;
 ByRef := (VT and VT_BYREF) = VT_BYREF;
 if ByRef then begin
   VT := VT and (not VT_BYREF);
   case VT of
     VT_I1: Result := Argument.pbVal^;
     VT_I2: Result := Argument.piVal^;
     VT_I4: Result := Argument.plVal^;
     VT_VARIANT: Result := Argument.pvarVal^;
   else
     Result := Argument.plVal^;
   end;
 end else
 case VT of
   VT_I1: Result := Argument.bVal;
   VT_I2: Result := Argument.iVal;
   VT_I4: Result := Argument.intVal;
 else
   Result := Argument.lVal;
 end;
end;

function ShiftToString(Shift: TShiftState):string;
var Res:string;
begin
  Res:='';
  if ssShift in Shift then res:=res+'ssShift ';
  if ssAlt in Shift then res:=res+'ssAlt ';
  if ssCtrl in Shift then res:=res+'ssCtrl ';
  if ssLeft in Shift then res:=res+'ssLeft ';
  if ssRight in Shift then res:=res+'ssRight ';
  if ssMiddle in Shift then res:=res+'ssMiddle ';
  if ssDouble in Shift then res:=res+'ssDouble ';
  Result:=res;
end;

type
  PNamesArray = ^TNamesArray;
  TNamesArray = array[0..0] of PWideChar;
  PDispIdsArray = ^TDispIdsArray;
  TDispIdsArray = array[0..0] of Integer;
  TVariantList = array [0..0] of OleVariant;

const
  DISPID_CONTROLS            = 1;
  DISPID_COUNT               = 2;
  DISPID_ADD                 = 3;
  DISPID_HASPROPERTY         = 4;
  DISPID_TEXT                = 5;
  DISPID_SHOW                = 6;
  DISPID_SHOWMODAL           = 7;
  DISPID_MODALRESULT         = 8;
  DISPID_CLEAR               = 9;
  DISPID_QUERY               = 10;
  DISPID_REFRESH             = 11;
  DISPID_SELECTED            = 12;
  DISPID_CHECKED             = 13;
  DISPID_DELETESELECTED      = 14;
  DISPID_LOADIMAGEFROMBASE64 = 15;
  DISPID_QRCODE              = 16;
  DISPID_COPYTOCLIPBOARD     = 17;
  DISPID_COMPONENT           = 18;
  DISPID_ADDSERIES           = 318;
  DISPID_CLEARSERIES         = 319;
  DISPID_CLOSE               = 320;
  DISPID_ONCLICK             = 321;
  DISPID_PDF417CODE          = 322;
  DISPID_BRINGTOFRONT        = 323;
  DISPID_SENDTOBACK          = 324;
  DISPID_FREE                = 325;
  DISPID_ONCHANGE            = 326;
  DISPID_ONENTER             = 327;
  DISPID_ONEXIT              = 328;
  DISPID_ONMOUSEENTER        = 329;
  DISPID_ONMOUSELEAVE        = 330;
  DISPID_ONMOUSEMOVE         = 331;
  DISPID_ONKEYUP             = 332;
  DISPID_ONKEYDOWN           = 333;
  DISPID_ONKEYPRESS          = 334;
  DISPID_ONDBLCLICK          = 335;
  DISPID_ONTIMER             = 336;
  DISPID_IMAGEINDEX          = 337;
  DISPID_SELECTEDINDEX       = 338;
  DISPID_ITEMS               = 339;
  DISPID_DELETE              = 340;
{ TVCLProxy }

procedure TVCLProxy.ComponentChange(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnChange<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnChange.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentClick(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnClick<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnClick.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentDblClick(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnDblClick<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnDblClick.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentEnter(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnEnter<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnEnter.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentExit(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnExit<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnExit.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnKeyDown<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 3;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant)*3);
    fillchar(Args^, sizeof(OleVariant)*3, 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[2]) := IDispatch(Self);
    OleVariant(Args[1]) := Key;
    OleVariant(Args[0]) := ShiftToString(Shift);
    {rc := }FOnKeyDown.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[2]), 1);
      FreeMem(Args, sizeof(OleVariant)*3);
    end;
  end;
end;

procedure TVCLProxy.ComponentKeyPress(Sender: TObject; var Key: Char);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnKeyPress<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 2;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant)*2);
    fillchar(Args^, sizeof(OleVariant)*2, 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[1]) := IDispatch(Self);
    OleVariant(Args[0]) := Key;
    {rc := }FOnKeyPress.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[1]), 1);
      FreeMem(Args, sizeof(OleVariant)*2);
    end;
  end;
end;

procedure TVCLProxy.ComponentKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnKeyUp<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 3;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant)*3);
    fillchar(Args^, sizeof(OleVariant)*3, 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[2]) := IDispatch(Self);
    OleVariant(Args[1]) := Key;
    OleVariant(Args[0]) := ShiftToString(Shift);
    {rc := }FOnKeyUp.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[2]), 1);
      FreeMem(Args, sizeof(OleVariant)*3);
    end;
  end;
end;

procedure TVCLProxy.ComponentMouseEnter(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnMouseEnter<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnMouseEnter.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentMouseLeave(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnMouseLeave<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnMouseLeave.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnMouseMove<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 4;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant)*4);
    fillchar(Args^, sizeof(OleVariant)*4, 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[3]) := IDispatch(Self);
    OleVariant(Args[2]) := ShiftToString(Shift);
    OleVariant(Args[1]) := X;
    OleVariant(Args[0]) := Y;
    {rc := }FOnMouseMove.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[3]), 1);
      FreeMem(Args, sizeof(OleVariant)*4);
    end;
  end;
end;

procedure TVCLProxy.ComponentTimer(Sender: TObject);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnTimer<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 1;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant));
    fillchar(Args^, sizeof(OleVariant), 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[0]) := IDispatch(Self);
    {rc := }FOnTimer.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[0]), 1);
      FreeMem(Args, sizeof(OleVariant));
    end;
  end;
end;

procedure TVCLProxy.ComponentTreeViewChange(Sender: TObject; Node: TTreeNode);
var Params: TDispParams;
    Result_: OleVariant;
    Args: PVariantArgList;
begin
  if FOnChange<>nil then
  begin
    Params.rgdispidNamedArgs := nil;
    Params.cArgs := 2;
    Params.cNamedArgs := 0;
    GetMem(Args, sizeof(OleVariant)*4);
    fillchar(Args^, sizeof(OleVariant)*4, 0);
    //Params.rgvarg := nil;
    Params.rgvarg := Args;
    OleVariant(Args[1]) := IDispatch(Self);
    OleVariant(Args[0]) := FScriptControl.GetProxy(Node);
    {rc := }FOnChange.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
    if Args <> nil then
    begin
      Finalize(OleVariant(Args[1]), 1);
      FreeMem(Args, sizeof(OleVariant)*2);
    end;
  end;
end;

constructor TVCLProxy.Create(AOwner: TPersistent;
  ScriptControl: TVCLScriptControl);
begin
  inherited Create;
  FOwner := AOwner;
  FScriptControl := ScriptControl;
  FComp := nil;
end;

function TVCLProxy.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  dps : TDispParams absolute Params;
  HasParams : boolean;
  pDispIds : PDispIdList;
  iDispIdsSize : integer;
  WS: WideString;
  I: Integer;
begin
  pDispIds := NIL;
  iDispIdsSize := 0;
  HasParams := (dps.cArgs > 0);
  if HasParams then
  begin
    iDispIdsSize := dps.cArgs * SizeOf(TDispId);
    GetMem(pDispIds, iDispIdsSize);
  end;
  try
    if HasParams then
      for I := 0 to dps.cArgs - 1 do
        pDispIds^[I] := dps.cArgs - 1 - I;
    try
      Result := DoInvoke(DispId, IID, LocaleID, Flags, dps, pDispIds, VarResult, ExcepInfo, ArgErr);
    except
      on E: EInvalidParamCount do Result := DISP_E_BADPARAMCOUNT;
      on E: EInvalidParamType do  Result := DISP_E_BADVARTYPE;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TVCLProxy');
          WS := E.Message;
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
    end;
  finally
    if HasParams then
      FreeMem(pDispIds, iDispIdsSize);
  end;
end;

function TVCLProxy.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;

function FindComponentRecurse(const FComponent: TWinControl; const ComponentName:String):TWinControl;
var i:integer;
    FFindComp: TWinControl;
begin
   FFindComp:=nil;
   for i := 0 to Pred(FComponent.ControlCount) do
   begin
     if AnsiUpperCase(ComponentName)=AnsiUpperCase(FComponent.Controls[i].Name) Then
       FFindComp:=TWinControl(FComponent.Controls[i])
      else
       FFindComp:=FindComponentRecurse(TWinControl(FComponent.Controls[i]), ComponentName);
     if Assigned(FFindComp) then Break;
   end;
   Result:=FFindComp;
end;

var
  S: String;
  Info: PPropInfo;
  j: integer;
begin
  Result := S_OK;
  // Получаем имя функции или свойства
  S := PNamesArray(Names)[0];
  // Проверяем, есть ли VCL свойство с таким-же именем
  Info := GetPropInfo(FOwner.ClassInfo, S);
  
  /////////////////////////////////////////////////
  if FOwner is TGrid_Frame then
  for j := 0 to TGrid_Frame(FOwner).ADOQuery.Fields.Count-1 do
      begin
        if (AnsiUpperCase(TGrid_Frame(FOwner).ADOQuery.Fields[j].FieldName)=AnsiUpperCase(S)) or
           (AnsiUpperCase(TGrid_Frame(FOwner).ADOQuery.Fields[j].DisplayLabel)=AnsiUpperCase(S))  then
        begin
          PDispIdsArray(DispIds)[0] := j + 20;
          Result:=S_OK;
        end;
      end;
  {if FOwner is TWinControl then
  begin

      //TODO: старая версия поиска
     FComp := nil;
     FComp :=FindComponentRecurse(TWinControl(FOwner),S);
  end; }
  ///  ////////////////////////////////////////////

  if Assigned(Info) and isNotEvent(S) then begin
    // Свойство есть, возвращаем в качестве DispId
    // адрес структуры PropInfo
    PDispIdsArray(DispIds)[0] := Integer(Info);
    ////////////////////////////////////////////////////
    if (CompareText(S, 'ITEMS') = 0) and (FOwner is TTreeView) then
      PDispIdsArray(DispIds)[0] := DISPID_ITEMS;
  end else
  // Нет такого свойства, проверяем, не имя ли это
  // одной из определенных нами функций
  {if Assigned(FComp) then
  begin
    PDispIdsArray(DispIds)[0] := DISPID_COMPONENT;
  end else}
  if CompareText(S, 'CONTROLS') = 0 then begin
    if (FOwner is TWinControl) then
      PDispIdsArray(DispIds)[0] := DISPID_CONTROLS
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'BRINGTOFRONT') = 0 then begin
    if (FOwner is TImage) then
      PDispIdsArray(DispIds)[0] := DISPID_BRINGTOFRONT
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'SENDTOBACK') = 0 then begin
    if (FOwner is TImage) then
      PDispIdsArray(DispIds)[0] := DISPID_SENDTOBACK
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'COUNT') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TCollection
    // и TStrings
    if (FOwner is TCollection) or (FOwner is TStrings) or (FOwner is TTreeNodes)
       or (FOwner is TWinControl) then
      PDispIdsArray(DispIds)[0] := DISPID_COUNT
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'ADD') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TCollection
    // и TStrings
    if (FOwner is TCollection) or (FOwner is TStrings) or
       (FOwner is TWinControl) or (FOwner is TBarSeries) or
       (FOwner is TPieSeries) or (FOwner is TLineSeries) or
       (FOwner is TAreaSeries) or (FOwner is TPopUpMenu) or (FOwner is TTreeNodes) then
      PDispIdsArray(DispIds)[0] := DISPID_ADD
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'TEXT') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TStrings
    if (FOwner is TStrings) or (FOwner is TTreeNode) then
      PDispIdsArray(DispIds)[0] := DISPID_TEXT
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'FREE') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TStrings
    PDispIdsArray(DispIds)[0] := DISPID_FREE
  end
  else
  if CompareText(S, 'CLEAR') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TStrings
    if (FOwner is TStrings) or (FOwner is TAreaSeries) or
       (FOwner is TBarSeries) or
           (FOwner is TLineSeries) or (FOwner is TPieSeries)
           or (FOwner is TTreeNodes) then
      PDispIdsArray(DispIds)[0] := DISPID_CLEAR
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'SHOW') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TForm) then
      PDispIdsArray(DispIds)[0] := DISPID_SHOW
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'SHOWMODAL') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TForm) then
      PDispIdsArray(DispIds)[0] := DISPID_SHOWMODAL
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'CLOSE') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TForm) then
      PDispIdsArray(DispIds)[0] := DISPID_CLOSE
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'MODALRESULT') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TForm) then
      PDispIdsArray(DispIds)[0] := DISPID_MODALRESULT
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'SETQUERY') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TGrid_Frame) then
      PDispIdsArray(DispIds)[0] := DISPID_QUERY
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'REFRESH') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TGrid_Frame) then
      PDispIdsArray(DispIds)[0] := DISPID_REFRESH
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'SELECTED') = 0 then begin
    Result := S_OK;
    if (FOwner is TListBox) or (FOwner is TTreeView) then
      PDispIdsArray(DispIds)[0] := DISPID_SELECTED
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'DELETE') = 0 then begin
    Result := S_OK;
    if (FOwner is TTreeNode) then
      PDispIdsArray(DispIds)[0] := DISPID_DELETE
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'CHECKED') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TCheckListBox) then
      PDispIdsArray(DispIds)[0] := DISPID_CHECKED
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'DELETESELECTED') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TListBox) or (FOwner is TCheckListBox) then
      PDispIdsArray(DispIds)[0] := DISPID_DELETESELECTED
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'LOADIMAGEFROMBASE64') = 0 then begin
    Result := S_OK;
   
    if (FOwner is TImage) or (FOwner is TImageList) then
      PDispIdsArray(DispIds)[0] := DISPID_LOADIMAGEFROMBASE64
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'QRCODE') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TImage
    if (FOwner is TImage) then
      PDispIdsArray(DispIds)[0] := DISPID_QRCODE
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'PDF417CODE') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TImage
    if (FOwner is TImage) then
      PDispIdsArray(DispIds)[0] := DISPID_PDF417CODE
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'COPYTOCLIPBOARD') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TImage) then
      PDispIdsArray(DispIds)[0] := DISPID_COPYTOCLIPBOARD
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'ADDSERIES') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TChart) then
      PDispIdsArray(DispIds)[0] := DISPID_ADDSERIES
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'CLEARSERIES') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TChart) then
      PDispIdsArray(DispIds)[0] := DISPID_CLEARSERIES
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'IMAGEINDEX') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TTreeNode) then
      PDispIdsArray(DispIds)[0] := DISPID_IMAGEINDEX
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
   if CompareText(S, 'SELECTEDINDEX') = 0 then begin
    Result := S_OK;
    // Эта функция вызывается только для TForm
    if (FOwner is TTreeNode) then
      PDispIdsArray(DispIds)[0] := DISPID_SELECTEDINDEX
    else
      Result := DISP_E_UNKNOWNNAME;
  end
  else
  if CompareText(S, 'ONTIMER') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONTIMER;
  end else
  if CompareText(S, 'ONCLICK') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONCLICK;
  end else
  if CompareText(S, 'ONCHANGE') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONCHANGE;
  end else
  if CompareText(S, 'ONENTER') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONENTER;
  end else
  if CompareText(S, 'ONEXIT') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONEXIT;
  end else
  if CompareText(S, 'ONMOUSEENTER') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONMOUSEENTER;
  end else
  if CompareText(S, 'ONMOUSELEAVE') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONMOUSELEAVE;
  end else
  if CompareText(S, 'ONMOUSEMOVE') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONMOUSEMOVE;
  end else
  if CompareText(S, 'ONKEYUP') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONKEYUP;
  end else
  if CompareText(S, 'ONKEYDOWN') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONKEYDOWN;
  end else
  if CompareText(S, 'ONKEYPRESS') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONKEYPRESS;
  end else
  if CompareText(S, 'ONDBLCLICK') = 0 then begin
    Result := S_OK;
    PDispIdsArray(DispIds)[0] := DISPID_ONDBLCLICK;
  end else
  //DISPID_ADDSERIES
  if CompareText(S, 'HASPROPERTY') = 0 then
    PDispIdsArray(DispIds)[0] := DISPID_HASPROPERTY
  else
    if not (PDispIdsArray(DispIds)[0] in [20..220]) then Result := DISP_E_UNKNOWNNAME;
end;

function TVCLProxy.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams;
  pDispIds: PDispIdList; VarResult, ExcepInfo, ArgErr: Pointer): HResult;

 function _ValidType(Index, TypeId: Integer; RaiseException: Boolean): Boolean;
 // Проверяет параметр с номером Index на совпадение типа
 begin
   Result := ValidType(dps.rgvarg^[pDispIds^[Index]], TypeId, RaiseException);
 end;

 function _IntValue(Index: Integer): Integer;
 // Получает целое число для параметра с номером Index
 begin
   Result := IntValue(dps.rgvarg^[pDispIds^[Index]]);
 end;


var
  S: String;
  Put: Boolean;
  I: Integer;
  P: TPersistent;
  B: Boolean;
  OutValue: OleVariant;
  pVar: PVariant;
  Ms:TMemoryStream;
  SS:TStringStream;
  QRCodeBitmap:TBitmap;
  QRCode: TDelphiZXingQRCode;
  QRText: String;
  Scale:double;
  Row, Column:integer;
  Params: TDispParams;
  Result_: OleVariant;
  Bmp:TBitmap;
  PDF417BarcodeVCL1: TPDF417BarcodeVCL;
  tNode:TTreeNode;
  tNodeInt:integer;
begin
  Result := S_OK;
  case DispId of
   DISPID_VALUE:begin
     OleVariant(VarResult^) := LongInt(Pointer(FOwner));
   end;
   DISPID_NEWENUM: begin
        // У объекта запрашивают интерфейс IEnumVariant для ForEach
        // создаем класс, реализующий этот интерфейс
        OleVariant(VarResult^) := TVCLEnumerator.Create(FOwner, FScriptControl) as IEnumVariant;
      end;
   DISPID_COMPONENT: begin
     OleVariant(VarResult^) := FScriptControl.GetProxy(FComp);
   end;
   DISPID_CONTROLS: begin
        // Вызвана функция Controls
        with FOwner as TWinControl do
        begin
          // Проверяем параметр
          CheckArgCount(dps.cArgs, [1], TRUE);
          P := NIL;
          if _ValidType(0, VT_BSTR, FALSE) then begin
            // Если параметр - строка - ищем дочерний компонент
            // с таким именем
            S := dps.rgvarg^[pDispIds^[0]].bstrVal;
            for I := 0 to Pred(ControlCount) do
              if CompareText(S, Controls[I].Name) = 0 then begin
                P := Controls[I];
                Break;
              end;
          end else begin
            // Иначе - параметр - число, берем компонент по индексу
            I := _IntValue(0);
            P := Controls[I];
          end;
          if not Assigned(P) then
            // Компонент не найден
            raise EInvalidParamType.Create('');
          // Возвращаем интерфейс IDispatch для найденного компонента
          OleVariant(VarResult^) := FScriptControl.GetProxy(P);
        end;
      end;
   DISPID_COUNT: begin
        // Вызвана функция Count
        // Проверяем, что не было параметров
        CheckArgCount(dps.cArgs, [0], TRUE);
        if FOwner is TWinControl then
          // Возвращаем количество дочерних компонентов
          OleVariant(VarResult^) := (FOwner as TWinControl).ControlCount;
        if FOwner is TCollection then
          // Возвращаем количество элементов коллекции
          OleVariant(VarResult^) := TCollection(FOwner).Count
        else
        if FOwner is TStrings then
          // Возвращаем количество строк
          OleVariant(VarResult^) := TStrings(FOwner).Count;
        if FOwner is TTreeNodes then
          // Возвращаем количество строк
          OleVariant(VarResult^) := TTreeNodes(FOwner).Count;
      end;
   DISPID_CLEAR: begin
        // Вызвана функция Clear
        // Проверяем, что не было параметров
        CheckArgCount(dps.cArgs, [0], TRUE);
        if FOwner is TStrings then
          TStrings(FOwner).Clear;
        if (FOwner is TAreaSeries) or (FOwner is TBarSeries) or
           (FOwner is TLineSeries) or (FOwner is TPieSeries) then
        TCustomSeries(FOwner).Clear;
        if FOwner is TTreeNodes then
         TTreeNodes(FOwner).Clear;
      end;
   DISPID_TEXT: begin
        // Вызвана функция Text
        // Проверяем, что не было параметров
        if FOwner is TStrings then
        begin
          if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
          begin
              CheckArgCount(dps.cArgs, [0], TRUE);
              OleVariant(VarResult^) := TStrings(FOwner).Text;
          end else
          begin
            CheckArgCount(dps.cArgs, [1], TRUE);
            TStrings(FOwner).Text := dps.rgvarg^[pDispIds^[0]].bstrVal;
          end;
        end;
        //ShowMessage(FOwner.ClassName);
        if FOwner is TTreeNode then
        begin
          if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
          begin
              CheckArgCount(dps.cArgs, [0], TRUE);
              OleVariant(VarResult^) := TTreeNode(FOwner).Text;
          end else
          begin
            CheckArgCount(dps.cArgs, [1], TRUE);
            TTreeNode(FOwner).Text := dps.rgvarg^[pDispIds^[0]].bstrVal;
          end;
        end;
      end;
   DISPID_IMAGEINDEX: begin
     if FOwner is TTreeNode then
        begin
          if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
          begin
              CheckArgCount(dps.cArgs, [0], TRUE);
              OleVariant(VarResult^) := TTreeNode(FOwner).ImageIndex;
          end else
          begin
            CheckArgCount(dps.cArgs, [1], TRUE);
            TTreeNode(FOwner).ImageIndex := _IntValue(0);
          end;
        end;
   end;
   DISPID_SELECTEDINDEX: begin
     if FOwner is TTreeNode then
        begin
          if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
          begin
              CheckArgCount(dps.cArgs, [0], TRUE);
              OleVariant(VarResult^) := TTreeNode(FOwner).SelectedIndex;
          end else
          begin
            CheckArgCount(dps.cArgs, [1], TRUE);
            TTreeNode(FOwner).SelectedIndex := _IntValue(0);
          end;
        end;
   end;
   DISPID_DELETE: begin
      if FOwner is TTreeNode then
        begin
          TTreeNode(FOwner).Delete;
        end;
   end;
   DISPID_SHOW: begin
        // Вызвана функция Show
        // Проверяем, что не было параметров
        CheckArgCount(dps.cArgs, [0], TRUE);
        if FOwner is TForm then
          TForm(FOwner).Show;
      end;
   DISPID_SHOWMODAL: begin
        // Вызвана функция ShowModal
        // Проверяем, что не было параметров
        CheckArgCount(dps.cArgs, [0], TRUE);
        if FOwner is TForm then
          // Возвращаем ModalResult
          OleVariant(VarResult^) := TForm(FOwner).ShowModal;
      end;
   DISPID_CLOSE: begin
     if FOwner is TForm then TForm(FOwner).Close;
   end;
   DISPID_FREE: begin
     TWinControl(FOwner).Free;
   end;
   DISPID_MODALRESULT: begin
        // Вызвана функция ShowModal
        // Проверяем, что не было параметров
        //if Flags = DISPATCH_PROPERTYPUT or DISPATCH_METHOD then
        //begin
          CheckArgCount(dps.cArgs, [1], TRUE);
          if FOwner is TForm then
          // Возвращаем ModalResult
            TForm(FOwner).ModalResult := dps.rgvarg^[pDispIds^[0]].iVal;
        //end;
      end;
   DISPID_ADD: begin
        // Вызвана функция Add

        if (FOwner is TAreaSeries) or (FOwner is TBarSeries) or (FOwner is TLineSeries) or (FOwner is TPieSeries) then
        begin
          TCustomSeries(FOwner).Add(dps.rgvarg^[pDispIds^[0]].dblVal,dps.rgvarg^[pDispIds^[1]].bstrVal);
          Exit;
        end;
       // ShowMessage(FOwner.ClassName);
        if FOwner is TTreeNodes then
        begin
          CheckArgCount(dps.cArgs, [2], TRUE);
          tNodeInt:=_IntValue(0);
          tnode:=TTreeNode(tNodeInt);
          if tnodeint<>0 then
            OleVariant(VarResult^) :=  FScriptControl.GetProxy(TTreeNodes(FOwner).AddChild(tnode,dps.rgvarg^[pDispIds^[1]].bstrVal))
          else
            OleVariant(VarResult^) :=  FScriptControl.GetProxy(TTreeNodes(FOwner).Add(nil,dps.rgvarg^[pDispIds^[1]].bstrVal));
          Exit;
        end;
        if (FOwner is TWinControl) or (FOwner is TPopUpMenu) then begin
          // Проверяем количество аргументов
          CheckArgCount(dps.cArgs, [2,3], TRUE);
          // Проверяем типы обязательных аргументов
          _ValidType(0, VT_BSTR, TRUE);
          _ValidType(1, VT_BSTR, TRUE);
          // Третий аргумент - необязательный, если он не задан -
          // полагаем FALSE
          if (dps.cArgs = 3) and _ValidType(2, VT_BOOL, TRUE) then
            B := dps.rgvarg^[pDispIds^[0]].vbool
          else
            B := FALSE;
          // Вызываем метод для создания компонента
          DoCreateControl(dps.rgvarg^[pDispIds^[0]].bstrVal,
            dps.rgvarg^[pDispIds^[1]].bstrVal, B)
        end
        else
        if FOwner is TCollection then begin
          // Добавляем компонент
          P := TCollection(FOwner).Add;
          // И возвращаем его интерфейс IDispatch
          OleVariant(varResult^) := FScriptControl.GetProxy(P);
        end else
        if FOwner is TStrings then begin
          // Проверяем наличие аргументов
          CheckArgCount(dps.cArgs, [1,2], TRUE);
          // Проверяем, что аргумент - строка
          _ValidType(0, VT_BSTR, TRUE);
          if dps.cArgs = 2 then
            // Второй аргумент - позиция в списке
            I := _IntValue(1)
          else
            // Если его нету - вставляем в конец
            I := TStrings(FOwner).Count;
          // Добавляем строку
          TStrings(FOwner).Insert(I, dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
   DISPID_HASPROPERTY: begin
        // Вызвана функция HasProperty
        // Проверяем наличие аргумента
        CheckArgCount(dps.cArgs, [1], TRUE);
        // Проверяем тип аргумента
        _ValidType(0, VT_BSTR, TRUE);
        S := dps.rgvarg^[pDispIds^[0]].bstrVal;
        // Возвращаем True, если свойство есть
        OleVariant(varResult^) := Assigned(GetPropInfo(FOwner.ClassInfo, S));
      end;
   DISPID_QUERY:
   begin
     CheckArgCount(dps.cArgs, [1], TRUE);
     _ValidType(0, VT_BSTR, TRUE);
     if FOwner is TGrid_Frame then
     begin
        if TGrid_Frame(FOwner).ADOQuery.Connection=nil then
          TGrid_Frame(FOwner).ADOQuery.Connection:=DM.ADOConnection1;
        TGrid_Frame(FOwner).Query:=dps.rgvarg^[pDispIds^[0]].bstrVal;
     end;
   end;
   DISPID_REFRESH:
   begin
      if FOwner is TGrid_Frame then
       TGrid_Frame(FOwner).Refresh;
   end;
   DISPID_BRINGTOFRONT:
   begin
       TWinControl(FOwner).BringToFront;
   end;
   DISPID_SENDTOBACK:
   begin
     TWinControl(FOwner).SendToBack;
   end;
   DISPID_SELECTED:
   begin
      if (FOwner is TListBox) or (FOwner is TCheckListBox) then
      begin
        if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
          OleVariant(varResult^) := TListBox(FOwner).Selected[dps.rgvarg^[pDispIds^[0]].iVal];
        if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
        begin
          pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
          OleVariant(varResult^) := TListBox(FOwner).Selected[Integer(pVar^)];
        end;
      end;
      if (FOwner is TTreeView) then
      begin
        OleVariant(varResult^) := FScriptControl.GetProxy(TTreeView(FOwner).Selected)
      end;
   end;
   DISPID_ITEMS:begin
     if (FOwner is TTreeView) and (dps.cArgs=0) then
     begin
       OleVariant(varResult^) := FScriptControl.GetProxy(TTreeView(FOwner).Items);
     end;
     if (FOwner is TTreeView) and (dps.cArgs=1) then
     begin
       OleVariant(varResult^) := FScriptControl.GetProxy(TTreeView(FOwner).Items[_IntValue(0)]);
     end;
   end;
   DISPID_CHECKED:
   begin
     if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
     begin
      if FOwner is TCheckListBox then
      begin
        if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
          OleVariant(varResult^) := TCheckListBox(FOwner).Checked[dps.rgvarg^[pDispIds^[0]].iVal];
        if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
        begin
          pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
          OleVariant(varResult^) := TCheckListBox(FOwner).Checked[Integer(pVar^)];
        end;
      end;
     end;
     if Flags = DISPATCH_PROPERTYPUT  then
     begin
       if (_ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE)) and _ValidType(1, VT_BOOL, FALSE) then
          TCheckListBox(FOwner).Checked[dps.rgvarg^[pDispIds^[0]].iVal]:=dps.rgvarg^[pDispIds^[1]].vbool;
        if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) and _ValidType(1, VT_BOOL, FALSE) then
        begin
          pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
          TCheckListBox(FOwner).Checked[Integer(pVar^)]:=dps.rgvarg^[pDispIds^[1]].vbool;
        end;
     end;
   end;
   DISPID_DELETESELECTED:
   begin
     if (FOwner is TCheckListBox) or (FOwner is TListBox) then
     TListBox(FOwner).DeleteSelected;
   end;
   DISPID_LOADIMAGEFROMBASE64:
   begin
     Ms:=TMemoryStream.Create;
     SS:=TStringStream.Create(dps.rgvarg^[pDispIds^[0]].bstrVal);
     Ss.Position:=0;
     DecodeStream(Ss,Ms);
     Ms.Position:=0;
     if FOwner is TImage then
       TImage(FOwner).Picture.Bitmap.LoadFromStream(Ms)
     else
     begin
       Bmp:=TBitmap.Create;
       Bmp.LoadFromStream(Ms);
        TImageList(FOwner).AddMasked(Bmp,clWhite);
       Bmp.Free
     end;
     SS.Free;
     MS.Free;
   end;
   DISPID_QRCODE:
   begin
     QRCodeBitmap := TBitmap.Create;
     QRCode := TDelphiZXingQRCode.Create;
     QRText := dps.rgvarg^[pDispIds^[0]].bstrVal;
     QRCode.Data := QRText;
     QRCode.Encoding := TQRCodeEncoding(0);
     QRCode.QuietZone := StrToIntDef(QRText, 4);
     QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
     for Row := 0 to QRCode.Rows - 1 do
      begin
        for Column := 0 to QRCode.Columns - 1 do
        begin
          if (QRCode.IsBlack[Row, Column]) then
          begin
            QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack;
          end else
          begin
            QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
          end;
        end;
      end;
     if (TImage(FOwner).Width < TImage(FOwner).Height) then
      begin
        Scale := TImage(FOwner).Width / QRCodeBitmap.Width;
      end else
      begin
        Scale := TImage(FOwner).Height / QRCodeBitmap.Height;
      end;
     TImage(FOwner).Canvas.StretchDraw(Rect(0, 0, Trunc(Scale * QRCodeBitmap.Width), Trunc(Scale * QRCodeBitmap.Height)), QRCodeBitmap);
     QRCode.Free;
    QRCodeBitmap.Free;
   end;
   DISPID_PDF417CODE:
   begin
     //QRCodeBitmap := TBitmap.Create;
     PDF417BarcodeVCL1:=TPDF417BarcodeVCL.Create(Application);
     PDF417BarcodeVCL1.Lines.Text := dps.rgvarg^[pDispIds^[0]].bstrVal;
     PDF417BarcodeVCL1.DotSize := dps.rgvarg^[pDispIds^[1]].iVal;
     PDF417BarcodeVCL1.LineHeight := dps.rgvarg^[pDispIds^[2]].iVal;
     PDF417BarcodeVCL1.FixedColumn := dps.rgvarg^[pDispIds^[3]].iVal;
     PDF417BarcodeVCL1.Options := PDF417BarcodeVCL1.Options + [poAutoErrorLevel];
     TImage(FOwner).Canvas.StretchDraw(Rect(0, 0, PDF417BarcodeVCL1.Bitmap.Width, PDF417BarcodeVCL1.Bitmap.Height), PDF417BarcodeVCL1.Bitmap);
     PDF417BarcodeVCL1.Free;
   end;
   DISPID_COPYTOCLIPBOARD:
   begin
     Clipboard.Assign(TImage(FOwner).Picture);
   end;
   20..220: begin
     if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
     begin
       if not TGrid_Frame(FOwner).ADOQuery.Fields[DispID-20].IsNull then
         OleVariant(VarResult^):=TGrid_Frame(FOwner).ADOQuery.Fields[DispID-20].AsVariant
       else  OleVariant(VarResult^):='';
     end;
   end;
   DISPID_ADDSERIES:
   begin
     if _ValidType(0, VT_I4, FALSE) or _ValidType(0, VT_I2, FALSE) then
        TChart(FOwner).AddSeries(TCustomSeries(Pointer(dps.rgvarg^[pDispIds^[0]].intVal)));
     if _ValidType(0, VT_DISPATCH, FALSE) then
     begin
       Params.rgdispidNamedArgs := nil;
       Params.cArgs := 0;
       Params.cNamedArgs := 0;
       Params.rgvarg := nil;
       IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal).Invoke(0, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
       TChart(FOwner).AddSeries(TCustomSeries(Pointer(Integer(Result_))));
     end;
   end;
   DISPID_CLEARSERIES:
   begin
     TChart(FOwner).SeriesList.Clear;
   end;
   DISPID_ONTIMER: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnTimer:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TTimer(FOwner).OnTimer := ComponentTimer;
      end;
    end;
   DISPID_ONCLICK: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnClick:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        if FOwner.ClassName='TMenuItem' Then
           TMenuItem(FOwner).OnClick := ComponentClick
        Else TPanel(FOwner).OnClick := ComponentClick;
      end;
    end;
    DISPID_ONENTER: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnEnter:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnEnter := ComponentEnter;
      end;
    end;
    DISPID_ONEXIT: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnExit:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnExit := ComponentExit;
      end;
    end;
    DISPID_ONCHANGE: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnChange:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        if FOwner is TTreeView then
          TTreeView(FOwner).OnChange := ComponentTreeViewChange
        else TEdit(FOwner).OnChange := ComponentChange;
      end;
    end;
    DISPID_ONMOUSEENTER: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnMouseEnter:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnMouseEnter := ComponentMouseEnter;
      end;
    end;
    DISPID_ONMOUSELEAVE: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnMouseLeave:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnMouseLeave := ComponentMouseLeave;
      end;
    end;
    DISPID_ONKEYUP: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnKeyUp:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TEdit(FOwner).OnKeyUp := ComponentKeyUp;
      end;
    end;
    DISPID_ONKEYDOWN: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnKeyDown:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TEdit(FOwner).OnKeyDown := ComponentKeyDown;
      end;
    end;
    DISPID_ONKEYPRESS: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnKeyPress:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TEdit(FOwner).OnKeyPress := ComponentKeyPress;
      end;
    end;
    DISPID_ONDBLCLICK: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnDblClick:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnDblClick := ComponentDblClick;
      end;
    end;
    DISPID_ONMOUSEMOVE: begin
      if (Flags and DISPATCH_PROPERTYPUT) <> 0 then
      begin
        FOnMouseMove:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);
        TPanel(FOwner).OnMouseMove := ComponentMouseMove;
      end;
    end
  else
    // Это не наша функция, значит это свойство
    // Проверяем Flags, чтобы узнать устанавливается значение
    // или получается
    Put := (Flags and DISPATCH_PROPERTYPUT) <> 0;
    if Put then begin
      // Устанавливаем значение
      // Проверяем наличие аргумента
      CheckArgCount(dps.cArgs, [1], TRUE);
      // И устанавливаем свойство

      Result := SetVCLProperty(PPropInfo(DispId), dps.rgvarg^[pDispIds^[0]])
    end else begin
      // Получаем значение
      if DispId = 0 then begin
        // DispId = 0 - требуется свойство по умолчанию
        // Возвращаем свой IDispatch
        OleVariant(VarResult^) := Self as IDispatch;//IDispatch(TVCLProxy.Create(FOwner, FScriptControl));
        Result := S_OK;
        Exit;
      end;
      // Получаем значение свойства
      Result := GetVCLProperty(PPropInfo(DispId), dps, pDispIds, OutValue);
      if Result = S_OK then
        // Получили успешно - сохраняем результат
        OleVariant(VarResult^) := OutValue;
    end;
  end;
end;

function TVCLProxy.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := NIL;
  Result := E_NOTIMPL;
end;

function TVCLProxy.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := E_NOTIMPL;
end;

procedure TVCLProxy.SetHandler(Control: TPersistent; Owner:TObject; Name: String);
  // Функция устанавливает обработчик события Name на метод формы
  // с именем Name + 'Handler'
  var
    Method: TMethod;
    PropInfo: PPropInfo;
  begin
    // Получаем информацию RTTI
    PropInfo := GetPropInfo(Control.ClassInfo, Name);
    if Assigned(PropInfo) then begin
      // Получаем адрес обработчика
      Method.Code := FScriptControl.MethodAddress(Name + 'Handler');
      if Assigned(Method.Code) then begin
        // Обработчик есть
        Method.Data := FScriptControl;
        // Устанавливаем обработчик
        SetMethodProp(Control, PropInfo, Method);
      end;
    end;
  end;

procedure TVCLProxy.DoCreateControl(AName, AClassName: WideString; WithEvents: Boolean);
var
  ThisClass: TControlClass;
  C: TComponent;
  NewOwner: TCustomForm;
begin
  // Назначаем свойство Owner на форму
  if FOwner is TPopupMenu then
  begin
    //ThisClass := TControlClass(GetClass(AClassName));
    C := TMenuItem.Create(FOwner as TPopupMenu);
    C.Name := AName;
    (FOwner as TPopupMenu).Items.Add(TMenuItem(C));
    //TControl(C).Parent := FOwner as TPopupMenu;
  end else
  begin
    if not (FOwner is TCustomForm) then
      NewOwner := GetParentForm(FOwner as TControl)
    else
      NewOwner := FOwner as TCustomForm;
    // Получаем класс создаваемого компонента
    ThisClass := TControlClass(GetClass(AClassName));
    // Создаем компонент
    C := ThisClass.Create(NewOwner);
    // Назначаем имя
    C.Name := AName;
    if C is TControl then
      // Назначаем свойство Parent
      TControl(C).Parent := FOwner as TWinControl;

    if C is TTabSheet then
         TTabSheet(C).PageControl := FOwner as TPageControl;
    
  end;
  if WithEvents then begin
    // Устанавливаем обработчики
    SetHandler(C, NewOwner, 'OnClick');
    SetHandler(C, NewOwner, 'OnChange');
    SetHandler(C, NewOwner, 'OnEnter');
    SetHandler(C, NewOwner, 'OnExit');
    SetHandler(C, NewOwner, 'OnTimer');
    SetHandler(C, NewOwner, 'OnDataChange');
    SetHandler(C, NewOwner, 'AfterScroll');
  end;
  // Создаем класс реализующий интерфейс IDispatch и добавляем его
  // в пространство имен TScriptControl
  FScriptControl.RegisterClass(AName, C);
  //TVCLProxy.Create(C, FScriptControl) as IDispatch, False);
end;

function TVCLProxy.SetVCLProperty(PropInfo: PPropInfo;
  Argument: TVariantArg): HResult;
var
  I, J, K, CommaPos: Integer;
  GoodToken: Boolean;
  S, S1: String;
  DT: TDateTime;
  ST: TSystemTime;
  IP: IQueryPersistent;
  Data, TypeData: PTypeData;
  TypeInfo: PTypeInfo;
begin
  Result := S_OK;
  case PropInfo^.PropType^.Kind of
    tkChar, tkString, tkLString, tkWChar, tkWString: // Символьная строка
      begin
        // Проверяем тип параметра
        ValidType(Argument, VT_BSTR, TRUE);
        // И устанавливаем свойство
        SetStrProp(FOwner, PropInfo, Argument.bstrVal);
      end;
    tkInteger:  // Целое число
      begin
        // Проверяем тип свойства на TCursor, TColor
        // если он совпадает и передано символьное значение
        // пытаемся получить его идентификатор
        if (UpperCase(PropInfo^.PropType^.Name) = 'TCURSOR') and
          (Argument.vt = VT_BSTR) then begin
          if not IdentToCursor(Argument.bstrVal, I) then begin
            Result := DISP_E_BADVARTYPE;
            Exit;
          end;
        end else
        if (UpperCase(PropInfo^.PropType^.Name) = 'TCOLOR') and
          (Argument.vt = VT_BSTR) then begin
          if not IdentToColor(Argument.bstrVal, I) then begin
            Result := DISP_E_BADVARTYPE;
            Exit;
          end;
        end else
          // Просто цифра
          I := IntValue(Argument);
        // Устанавливаем свойство
        SetOrdProp(FOwner, PropInfo, I);
      end;
    tkEnumeration:
      // Перечислимый тип
      begin
        // Проверяем на тип Boolean - для него в VBScript есть
        // отдельный тип данных
        if CompareText(PropInfo^.PropType^.Name, 'BOOLEAN') = 0 then begin
          // Проверяем тип данных аргумента
          ValidType(Argument, VT_BOOL, TRUE);
          // Это свойство Boolean - получаем значение и устанавливаем его
          SetOrdProp(FOwner, PropInfo, Integer(Argument.vBool));
        end else begin
          // Иначе - перечислимый тип передается в виде символьной строки
          // Проверяем тип данных аргумента
          ValidType(Argument, VT_BSTR, TRUE);
          // Получаем значение
          S := Trim(Argument.bstrVal);
          // Переводим в Integer
          I := GetEnumValue(PropInfo^.PropType^, S);
          // Если успешно - устанавливаем свойство
          if I >= 0 then
            SetOrdProp(FOwner, PropInfo, I)
          else
            raise EInvalidParamType.Create('');
        end;
      end;
    tkClass:
      // Объектный тип
      begin
        // Проверяем тип данных - должен быть интерфейс IDispatch
        ValidType(Argument, VT_DISPATCH, TRUE);
        if Assigned(Argument.dispVal) then begin
          // Передано непустое значение
          // Получаем интерфейс IQueryPersistent
          IP := IDispatch(Argument.dispVal) as IQueryPersistent;
          // Получаем ссылку на класс, представителем которого
          // является интерфейс
          I := Integer(IP.GetPersistent);
        end else
          // Иначе - очищаем свойство
          I := 0;
        // Устанавливаем значение
        SetOrdProp(FOwner, PropInfo, I);
      end;
   tkFloat:
      // Число с плавающей точкой
      begin
        if (PropInfo^.PropType^ = System.TypeInfo(TDateTime)) or
           (PropInfo^.PropType^ = System.TypeInfo(TDate)) then begin
          // Проверяем тип данных аргумента
          if Argument.vt = VT_BSTR then begin
            DT := StrToDate(Argument.bstrVal);
          end else begin
            ValidType(Argument, VT_DATE, TRUE);
            if VariantTimeToSystemTime(Argument.date, ST) <> 0 then
              DT := SystemTimeToDateTime(ST)
            else begin
              Result := DISP_E_BADVARTYPE;
              Exit;
            end;
          end;
          SetFloatProp(FOwner, PropInfo, DT);
        end else begin
          // Проверяем тип данных аргумента
          ValidType(Argument, VT_R8, TRUE);
          // Устанавливаем значение}
          SetFloatProp(FOwner, PropInfo, Argument.dblVal);
        end;
      end;
   tkSet:
      // Набор
      begin
        // Проверяем тип данных, должна быть символьная строка
        ValidType(Argument, VT_BSTR, TRUE);
        // Получаем данные
        S := Trim(Argument.bstrVal);
        // Получаем информацию RTTI
        Data := GetTypeData(PropInfo^.PropType^);
        TypeInfo := Data^.CompType^;
        TypeData := GetTypeData(TypeInfo);
        I := 0;
        while Length(S) > 0 do begin
          // Проходим по строке, выбирая разделенные запятыми
          // значения идентификаторов
          CommaPos := Pos(',', S);
          if CommaPos = 0 then
            CommaPos := Length(S) + 1;
          S1 := Trim(System.Copy(S, 1, CommaPos - 1));
          System.Delete(S, 1, CommaPos);
          if Length(S1) > 0 then begin
            // Поверяем, какому из допустимых значений соответствует
            // полученный идентификатор
            K := 1;
            GoodToken := FALSE;
            for J := TypeData^.MinValue to TypeData^.MaxValue do begin
              if CompareText(S1, GetEnumName(TypeInfo , J)) = 0 then begin
                // Идентификатор найден, добавляем его в маску
                I := I or K;
                GoodToken := TRUE;
              end;
              K := K shl 1;
            end;
            if not GoodToken then begin
              // Идентификатор не найдет
              Result := DISP_E_BADVARTYPE;
              Exit;
            end;
          end;
        end;
        // Устанавливаем значение свойства
        SetOrdProp(FOwner, PropInfo, I);
      end;
    tkVariant:
      // Вариант
      begin
        // Проверяем тип данных аргумента
        ValidType(Argument, VT_VARIANT, TRUE);
        // Устанавливаем значение
        SetVariantProp(FOwner, PropInfo, Argument.pvarVal^);
      end;
   else
     // Остальные типы данных OLE не поддерживаются
     Result := DISP_E_MEMBERNOTFOUND;
  end;
end;

function TVCLProxy.GetVCLProperty(PropInfo: PPropInfo; dps: TDispParams;
  PDispIds: PDispIdList; var Value: OleVariant): HResult;
var
  I, J, K: Integer;
  S: String;
  P, P1: TPersistent;
  Data: PTypeData;
  DT: TDateTime;
  TypeInfo: PTypeInfo;
begin
  Result := S_OK;
  case PropInfo^.PropType^.Kind of
    tkString, tkLString, tkWChar, tkWString:
      // Символьная строка
      Value := GetStrProp(FOwner, PropInfo);
    tkChar, tkInteger:
      // Целое число
      Value := GetOrdProp(FOwner, PropInfo);
    tkEnumeration:
      // Перечислимый тип
      begin
        // Проверяем, не Boolean ли это
        if CompareText(PropInfo^.PropType^.Name, 'BOOLEAN') = 0 then begin
          // Передаем как Boolean
          Value := Boolean(GetOrdProp(FOwner, PropInfo));
        end else begin
          // Остальные - передаем как строку
          I := GetOrdProp(FOwner, PropInfo);
          Value := GetEnumName(PropInfo^.PropType^, I);
        end;
      end;
    tkClass:
      // Класс
      begin
        // Получаем значение свойства
        P := TPersistent(GetOrdProp(FOwner, PropInfo));
        if Assigned(P) and (P is TCollection) and (dps.cArgs = 1) then begin
          // Запрошен элемент коллекции с индексом (есть параметр)
          if ValidType(dps.rgvarg^[pDispIds^[0]], VT_BSTR, FALSE) then begin
            // Параметр строковый, ищем элемент по свойству
            // DisplayName
            S := dps.rgvarg^[pDispIds^[0]].bstrVal;
            P1 := NIL;
            for I := 0 to Pred(TCollection(P).Count) do
              if CompareText(S, TCollection(P).Items[I].DisplayName) = 0 then begin
                P1 := TCollection(P).Items[I];
                Break;
              end;
            if Assigned(P1) then
              // Найден - возвращаем интерфейс IDispatch
              Value := FScriptControl.GetProxy(P1)
               //IDispatch(TVCLProxy.Create(P1, FScriptControl))
            else
              // Не найден
              Result := DISP_E_MEMBERNOTFOUND;
          end else begin
            // Параметр целый, возвращаем элемент по индексу
            I := IntValue(dps.rgvarg^[pDispIds^[0]]);
            if (I >= 0) and (I < TCollection(P).Count) then begin
              P := TCollection(P).Items[I];
              Value := FScriptControl.GetProxy(P);
                //IDispatch(TVCLProxy.Create(P, FScriptControl));
            end else
              Result := DISP_E_MEMBERNOTFOUND;
          end;
        end
        else
        if Assigned(P) and (P is TStrings) and (dps.cArgs = 1) then begin
          // Запрошен элемент из Strings с индексом (есть параметр)
          if ValidType(dps.rgvarg^[pDispIds^[0]], VT_BSTR, FALSE) then begin
            // Параметр строковый - возвращаем значение свойства Values
            S := dps.rgvarg^[pDispIds^[0]].bstrVal;
            Value := TStrings(P).Values[S];
          end else begin
            // Параметр целый, возвращаем строку по индексу
            I := IntValue(dps.rgvarg^[pDispIds^[0]]);
            if (I >= 0) and (I < TStrings(P).Count) then
              Value := TStrings(P)[I]
            else
              Result := DISP_E_MEMBERNOTFOUND;
          end;
        end
        else
          // Общий случай, возвращаем интерфейс IDispatch свойства
          if Assigned(P) then
            Value := FScriptControl.GetProxy(P)
              //IDispatch(TVCLProxy.Create(P, FScriptControl))
          else
            // Или Unassigned, если оно = NIL
            Value := 0;
      end;
    tkFloat:
      // Число с плавающей точкой
      begin
        if (PropInfo^.PropType^ = System.TypeInfo(TDateTime)) or
           (PropInfo^.PropType^ = System.TypeInfo(TDate)) then begin
          DT := GetFloatProp(FOwner, PropInfo);
          Value := DT;
        end else
          Value := GetFloatProp(FOwner, PropInfo);
      end;
    tkSet:
      // Набор
      begin
        // Получаем значение свойства (битовая маска)
        I := GetOrdProp(FOwner, PropInfo);
        // Получаем информацию RTTI
        Data := GetTypeData(PropInfo^.PropType^);
        TypeInfo := Data^.CompType^;
        // Формируем строку с набором значений
        S := '';
        if I <> 0 then begin
          for K := 0 to 31 do begin
            J := 1 shl K;
            if (J and I) = J then
              S := S + GetEnumName(TypeInfo, K) + ',';
          end;
          System.Delete(S, Length(S), 1);
        end;
        Value := S;
      end;
    tkVariant:
      // Вариант
      Value := GetVariantProp(FOwner, PropInfo);
  else
    // Остальные типы не поддерживаются
    Result := DISP_E_MEMBERNOTFOUND;
  end;
end;

function TVCLProxy.GetPersistent: TPersistent;
begin
  // Реализация IQueryPersistent
  // Возвращаем ссылку на класс
  Result := FOwner;
end;

destructor TVCLProxy.Destroy;
begin
  // Удаляем себя из списка объектов TVCLProxy
  FScriptControl.ProxyDestroyed(Self);
  inherited;
end;

{ TVCLEnumerator }

constructor TVCLEnumerator.Create(AOwner: TPersistent;
  AScriptControl: TVCLScriptControl);
begin
  inherited Create;
  FOwner := AOwner;
  FScriptControl := AScriptControl;
  FEnumPosition := 0;
end;

function TVCLEnumerator.Clone(out Enum: IEnumVariant): HResult;
var
  NewEnum: TVCLEnumerator;
begin
  NewEnum := TVCLEnumerator.Create(FOwner, FScriptControl);
  NewEnum.FEnumPosition := FEnumPosition;
  Enum := NewEnum as IEnumVariant;
  Result := S_OK;
end;

function TVCLEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  pceltFetched: PLongWord): HResult;
var
  I: Cardinal;
begin
  Result := S_OK;
  I := 0;
  if FOwner is TWinControl then begin
    with TWinControl(FOwner) do begin
      while (FEnumPosition < ControlCount) and (I < celt) do begin
        TVariantList(rgvar)[I] :=
          FScriptControl.GetProxy(Controls[FEnumPosition]);
//          TVCLProxy.Create(Controls[FEnumPosition], FScriptControl) as IDispatch;
        Inc(I);
        Inc(FEnumPosition);
      end;
    end;
  end
  else
  if FOwner is TCollection then begin
    with TCollection(FOwner) do begin
      while (FEnumPosition < Count) and (I < celt) do begin
        TVariantList(rgvar)[I] :=
          FScriptControl.GetProxy(Items[FEnumPosition]);
//          TVCLProxy.Create(Items[FEnumPosition], FScriptControl) as IDispatch;
        Inc(I);
        Inc(FEnumPosition);
      end;
    end;
  end
  else
  if FOwner is TStrings then begin
    with TStrings(FOwner) do begin
      while (FEnumPosition < Count) and (I < celt) do begin
        TVariantList(rgvar)[I] := TStrings(FOwner)[FEnumPosition];
        Inc(I);
        Inc(FEnumPosition);
      end;
    end;
  end else
    Result := S_FALSE;
  if I <> celt then
    Result := S_FALSE;
  if Assigned(pceltFetched) then
    pceltFetched^ := I;
end;

function TVCLEnumerator.Reset: HResult;
begin
  FEnumPosition := 0;
  Result := S_OK;
end;

function TVCLEnumerator.Skip(celt: LongWord): HResult;
var
  Total: Integer;
begin
  Result := S_FALSE;
  if FOwner is TWinControl then
    Total := TWinControl(FOwner).ControlCount
  else
  if FOwner is TCollection then
    Total := TCollection(FOwner).Count
  else
  if FOwner is TStrings then
    Total := TStrings(FOwner).Count
  else
    Exit;
  {$WARNINGS OFF}
  if FEnumPosition + celt <= Total then begin
  {$WARNINGS ON}
    Result := S_OK;
    Inc(FEnumPosition, celt)
  end;
end;

{ TVCLScriptControl }


procedure TVCLScriptControl.AfterScrollHandler(Sender: TObject; DataSet: TDataSet);
begin
  RunProc(TControl(Sender).Name+'_AfterScroll');
end;

procedure TVCLScriptControl.CloseScriptEngine;
begin
  FParser := nil;
  if FEngine <> nil then FEngine.Close;
  FEngine := nil;
  FNamedItems.Clear;
  FProxyList.Clear;
end;


constructor TVCLScriptControl.Create(AOwner: TComponent);
begin
  inherited;
  FProxyList := TList.Create;
  FFuncList:= TFuncList.Create;
  FNamedItems := TNamedItemList.Create;
end;

procedure TVCLScriptControl.CreateScriptEngine(Language: TScriptLanguage);
begin
  CloseScriptEngine;
  FEngine := CreateComObject(ScriptCLSIDs[Language]) as IActiveScript;
  FParser := FEngine as IActiveScriptParse;
  FEngine.SetScriptSite(Self);
  FParser.InitNew;
end;

destructor TVCLScriptControl.Destroy;
begin
  FProxyList.Free;
  FProxyList := NIL;
  inherited;
end;

function TVCLScriptControl.EnableModeless(fEnable: BOOL): HResult;
begin
  Result := S_OK;
end;

function TVCLScriptControl.GetDocVersionString(
  out pbstrVersion: WideString): HResult;
begin
   Result := E_NOTIMPL;
end;

function TVCLScriptControl.GetItemInfo(pstrName: LPCOLESTR; dwReturnMask: DWORD;
  out ppiunkItem: IInterface; out ppti: ITypeInfo): HResult;
begin
  if @ppiunkItem <> nil then Pointer(ppiunkItem) := nil;
  if @ppti <> nil then Pointer(ppti) := nil;
  if (dwReturnMask and SCRIPTINFO_IUNKNOWN) <> 0
    then ppiunkItem := FNamedItems.GetItemIUnknown(pstrName);
  Result := S_OK;
end;

function TVCLScriptControl.GetLCID(out plcid: LCID): HResult;
begin
  plcid := GetSystemDefaultLCID;
  Result := S_OK;
end;

function TVCLScriptControl.GetProxy(AOwner: TPersistent): IDispatch;
var
  I: Integer;
  QP: IQueryPersistent;
begin
  Result := NIL;
  with FProxyList do
    for I := 0 to Pred(Count) do begin
      if TObject(FProxyList[I]).GetInterface(IQueryPersistent, QP) and
         (QP.GetPersistent = AOwner) then begin
        Result := TVCLProxy(FProxyList[I]) as IDispatch;
        Exit;
      end;
    end;
  I := FProxyList.Add(TVCLProxy.Create(AOwner, Self));
  Result := TVCLProxy(FProxyList[I]) as IDispatch;
end;

function TVCLScriptControl.GetWindow(out phwnd: HWND): HResult;
begin
  phwnd := FWinHandle;
  Result := S_OK;
end;

function TVCLScriptControl.iParserText(const aCode: WideString): HResult;
var
  aResult: OleVariant;
  ExcepInfo: TExcepInfo;
begin
  //if FCanDebug then
  Result := FParser.ParseScriptText(PWideChar(ACode), nil, nil, nil, 0, 0, SCRIPTTEXT_ISVISIBLE, aResult, ExcepInfo);
end;


procedure TVCLScriptControl.OnChangeHandler(Sender: TObject);
begin
  RunProc(TControl(Sender).Name+'_onChange');
end;

procedure TVCLScriptControl.OnClickHandler(Sender: TObject);
begin
  RunProc(TControl(Sender).Name+'_onClick');
end;

procedure TVCLScriptControl.OnDataChangeHandler(Sender: TObject; Field: TField);
begin
 RunProc(TControl(Sender).Name+'_onDataChange');
end;

procedure TVCLScriptControl.OnEnterHandler(Sender: TObject);
begin
  RunProc(TControl(Sender).Name+'_onEnter');
end;

function TVCLScriptControl.OnEnterScript: HResult;
begin
  Result := S_OK;
end;

procedure TVCLScriptControl.OnExitHandler(Sender: TObject);
begin
  RunProc(TControl(Sender).Name+'_onExit');
end;

procedure TVCLScriptControl.OnTimerHandler(Sender: TObject);
begin
  RunProc((Sender as TComponent).Name + '_' + 'OnTimer');
end;

function TVCLScriptControl.OnLeaveScript: HResult;
begin
  Result := S_OK;
end;

function TVCLScriptControl.OnScriptError(
  const pscripterror: IActiveScriptError): HResult;
var
  ei: EXCEPINFO;
  Context: DWORD;
  Line: UINT;
  Pos: integer;
  SourceLineW: WideString;
  SourceLine: string;
begin
  Result := S_OK;
  if pscripterror = nil then exit;
  pscripterror.GetExceptionInfo(ei);
  if @ei.pfnDeferredFillIn <> nil then ei.pfnDeferredFillIn(@ei);
  pscripterror.GetSourcePosition(Context, Line, Pos);
  pscripterror.GetSourceLineText(SourceLineW);
  SourceLine := SourceLineW;
  //FListView.Clear;
  If FCodeMemo<>nil then
  begin
    FCodeMemo.Tag:=Line+1;
    FCodeMemo.Invalidate;
  end;
  with FListView.Items.Add do
  begin
    //SubItems.Add('');
    ImageIndex:=-1;
    StateIndex:=0;
    Caption:=IntToStr(Line+1)+':'+IntToStr(Pos+1);
    //SubItems.Add(IntToStr(Line+1)+':'+IntToStr(Pos+1));
    SubItems.Add(ei.bstrDescription+' ('+ei.bstrSource+')');
  end;
end;

function TVCLScriptControl.OnScriptTerminate(var pvarResult: OleVariant;
  var pexcepinfo: EXCEPINFO): HResult;
begin
  Result := S_OK;
end;

function TVCLScriptControl.OnStateChange(ssScriptState: SCRIPTSTATE): HResult;
begin
  Result := S_OK;
end;


procedure TVCLScriptControl.ProxyDestroyed(Address: Pointer);
var iIndex:integer;
begin
  if Assigned(FProxyList) then
    with FProxyList do
    begin
      iIndex:=IndexOf(Address);
      if iIndex<>-1 then Delete(iIndex);
    end;
end;

procedure TVCLScriptControl.RegisterClass(const Name: String;
  AClass: TPersistent);
var
  NameW: WideString;
begin
  FNamedItems.AddItem(Name, GetProxy(AClass));
  NameW := Name;
  FEngine.AddNamedItem(PWideChar(NameW), SCRIPTITEM_ISVISIBLE);
end;

procedure TVCLScriptControl.RegisterClass(const Name: String;
  Item: TInterfacedObject);
var
  NameW: WideString;
begin
  FNamedItems.AddItem(Name, Item);
  NameW := Name;
  FEngine.AddNamedItem(PWideChar(NameW), SCRIPTITEM_ISVISIBLE);
end;

function TVCLScriptControl.RegisterObject(AClass: TPersistent): IDispatch;
begin
  Result:=GetProxy(AClass);
end;

procedure TVCLScriptControl.RunProc(const Name: String);
var DispID: TDispID;
    Params: TDispParams;
    Result: OleVariant;
    rc: HResult;
    Func:TFunc;
begin
   FFuncList.Clear;
   if not SetScriptDispatch then exit;
   if FScriptDispatch = nil then exit;
   FScriptDispatch.GetTypeInfo(0, GetSystemDefaultLCID, FTypeInfo);
   FFuncList.FillFromTypeInfo(FTypeInfo);
   //////////////////////////////////////////////////////
   Params.rgdispidNamedArgs := nil;
   Params.cArgs := 0;
   Params.cNamedArgs := 0;
   Params.rgvarg := nil;
   Func := FFuncList.GetItemByName(Name);
   if Assigned(Func) then
   begin
     DispID:=Func.MemID;
     rc := FScriptDispatch.Invoke(DispID, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result, nil, nil);
     OleCheck(rc);
   end;
end;

procedure TVCLScriptControl.RunScript(Code: WideString);
var
  Result: OleVariant;
  ExcepInfo: TEXCEPINFO;
begin
  FListView.Clear;
  Application.ProcessMessages;
  FParser.ParseScriptText(PWideChar(Code), nil, nil, nil, 0, 0, SCRIPTITEM_ISSOURCE, Result, ExcepInfo);
end;

procedure TVCLScriptControl.SetCodeMemo(const Value: TSynMemo);
begin
  FCodeMemo := Value;
end;

procedure TVCLScriptControl.SetHandler(Control: TPersistent; Owner: TObject;
  Name: String);
  var
    Method: TMethod;
    PropInfo: PPropInfo;
  begin
    // Получаем информацию RTTI
    PropInfo := GetPropInfo(Control.ClassInfo, Name);
    if Assigned(PropInfo) then begin
      // Получаем адрес обработчика
      Method.Code := MethodAddress(Name + 'Handler');
      if Assigned(Method.Code) then begin
        // Обработчик есть
        Method.Data := Self;
        // Устанавливаем обработчик
        SetMethodProp(Control, PropInfo, Method);
      end;
    end;
  end;

procedure TVCLScriptControl.SetListView(const Value: TListView);
begin
  FListView := Value;
end;

function TVCLScriptControl.SetScriptDispatch: boolean;
var
  TypeInfoCount: integer;
begin
  FTypeInfo := nil;
  if FEngine <> nil then
  begin
    OleCheck(FEngine.GetScriptDispatch(nil, FScriptDispatch));
    FScriptDispatch.GetTypeInfoCount(TypeInfoCount);
    Result:=TypeInfoCount > 0;
  end else Result:=false;
end;

procedure TVCLScriptControl.SetWinHandle(const Value: HWND);
begin
  FWinHandle := Value;
end;


procedure TVCLScriptControl.TerminateScript;
begin
  FEngine.Close;
end;

{ TVCLScriptControlDebug }

constructor TVCLScriptControlDebug.Create(AOwner: TComponent);
begin
  //inherited;
  FCanDebugError := True;
  inherited;
end;

procedure TVCLScriptControlDebug.CreateScriptEngine(Language: TScriptLanguage);
begin
  if FCanDebug then
    InitDebugApplication;
  inherited;
end;

procedure TVCLScriptControlDebug.DebugScript(Code: WideString);
begin
  iParserText(Code);
end;

function TVCLScriptControlDebug.GetApplication(
  out ppda: IDebugApplication): HRESULT;
begin
  ppda := FDebugApp;

  if Assigned(FDebugApp) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

function TVCLScriptControlDebug.GetDocumentContextFromPosition(
  const dwSourceContext: DWORD; const uCharacterOffset, uNumChars: ULONG;
  out ppsc: IDebugDocumentContext): HRESULT;
var
  vStartPos: LongWord;
begin
  vStartPos := 0;
  if Assigned(FDebugDocHelper) then
  begin
    Result := FDebugDocHelper.GetScriptBlockInfo(dwSourceContext, IActiveScript(vStartPos), vStartPos, vStartPos);
    if Result = S_OK then
      Result := FDebugDocHelper.CreateDebugDocumentContext(vStartPos + uCharacterOffset, uNumChars, ppsc);
  end
  else
    Result := E_NOTIMPL;
end;

function TVCLScriptControlDebug.GetRootApplicationNode(
  out ppdanRoot: IDebugApplicationNode): HRESULT;
begin
    if Assigned(FDebugDocHelper) then
    Result := FDebugDocHelper.GetDebugApplicationNode(ppdanRoot)
  else
    Result := E_NOTIMPL;
end;

procedure TVCLScriptControlDebug.InitDebugApplication;
var
  hr: HRESULT;
begin
  hr := CoCreateInstance(CLSID_ProcessDebugManager, nil,
        CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER
        or CLSCTX_LOCAL_SERVER, IProcessDebugManager, FProcessDebugManager);
  OleCheck(hr);

  hr := FProcessDebugManager.CreateApplication(FDebugApp);
  OleCheck(hr);

  hr := FDebugApp.SetName(PWideChar(FAppName));
  OleCheck(hr);

  hr := FProcessDebugManager.AddApplication(FDebugApp, FAppCookie);
  OleCheck(hr);

  hr := FProcessDebugManager.CreateDebugDocumentHelper(nil, FDebugDocHelper);
  OleCheck(hr);

  hr := FDebugDocHelper.Init(FDebugApp, PWideChar(AppName), 'Scripted Current Text', TEXT_DOC_ATTR_READONLY);
  OleCheck(hr);

  hr := FDebugDocHelper.Attach(nil);
  OleCheck(hr);

  hr := FDebugDocHelper.SetDocumentAttr(TEXT_DOC_ATTR_READONLY);
  OleCheck(hr);
end;

function TVCLScriptControlDebug.iParserText(const aCode: WideString): HResult;
var
  hr: HRESULT;
  dw: Longword;
begin
  if FCanDebug then
  begin
    hr := FDebugDocHelper.AddUnicodeText(PWideChar(aCode));
    OleCheck(hr);
  
    //it seems that the DefineScriptBlock can execute once only!
    hr := FDebugDocHelper.DefineScriptBlock(0, Length(aCode), FEngine, False, dw);
    //OleCheck(hr);
  end;

  Result := inherited iParserText(aCode);

  if FCanDebug and FBreakOnStart then
  begin
    //startup the debugger session
    hr := FDebugDocHelper.BringDocumentToTop();
    if hr <> S_OK then
     raise Exception.CreateRes(@rsErrorOpenDebuggerFailed);
    //OleCheck(hr);

    hr := FDebugApp.CauseBreak();
    if hr <> S_OK then 
      raise Exception.CreateRes(@rsErrorCauseBreak);
    //OleCheck(hr);
  end;
end;


function TVCLScriptControlDebug.OnScriptErrorDebug(
  const pErrorDebug: IActiveScriptErrorDebug; out pfEnterDebugger,
  pfCallOnScriptErrorWhenContinuing: BOOL): HRESULT;
begin
  pfEnterDebugger := FCanDebugError;
  if Assigned(FOnErrorDebug) Then
    FOnErrorDebug(Self, pErrorDebug, pfEnterDebugger, pfCallOnScriptErrorWhenContinuing);
  if FCanDebug then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

procedure TVCLScriptControlDebug.OpenDebugger;
begin
    if Assigned(FDebugApp) Then
    if FDebugApp.StartDebugSession() <> S_OK then
      Raise Exception.CreateRes(@rsErrorOpenDebuggerFailed);
end;

procedure TVCLScriptControlDebug.SetAppName(const Value: WideString);
begin
    if Value <> FAppName Then
  begin
    if Assigned(FDebugApp) then
    begin
      OleCheck(FDebugApp.SetName(PWideChar(Value)));
    end;
    FAppName := Value;
  end;
end;

end.
