unit CodeObj;

interface

uses Classes,SysUtils,ActiveX,SynMemo;

type
   EInvalidParamCount = class(Exception)
  end;

  EBadCallEE = class(Exception)
  end;

  EInvalidParamType = class(Exception)
  end;

TCodeObj = class(TInterfacedObject, IDispatch)
  private
    FMemo: TSynMemo;
    FTableName:String;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  protected
    function DoInvoke (DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps : TDispParams; pDispIds : PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual;
  public
    constructor Create(CodeMemo: TSynMemo; const TableName: string);
  end;

implementation

uses Windows, SynEdit;
Const
    DISPID_TEXT = 1;
    DISPID_SELTEXT = 2;
    DISPID_CURRENTSTR = 3;
    DISPID_SELSTART = 4;
    DISPID_SELEND = 5;
    DISPID_SELECTALL = 6;
    DISPID_TABLENAME = 7;

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
     VT_VARIANT: Result := Argument.pvarVal^;
   else
     Result := Argument.plVal^;
   end;
 end else
 case VT of
   VT_I1: Result := Argument.bVal;
   VT_I2: Result := Argument.iVal;
 else
   Result := Argument.lVal;
 end;
end;

{ TCodeObj }

constructor TCodeObj.Create(CodeMemo: TSynMemo; const TableName:string);
begin
  inherited Create;
  FMemo:=CodeMemo;
  FTableName:=TableName;
end;

function TCodeObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  case DispID of
    DISPID_TEXT: begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FMemo.Text
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FMemo.Text:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_SELTEXT: begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FMemo.SelText
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FMemo.SelText:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_CURRENTSTR: begin
       if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FMemo.Lines[FMemo.CaretY-1]
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FMemo.Lines[FMemo.CaretY-1]:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_SELSTART: begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FMemo.SelStart
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FMemo.SelStart:=dps.rgvarg^[pDispIds^[0]].iVal;
    end;
    DISPID_SELEND: begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FMemo.SelEnd
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FMemo.SelEnd:=dps.rgvarg^[pDispIds^[0]].iVal;
    end;
    DISPID_SELECTALL:begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FMemo.SelectAll;
      end;
    end;
    DISPID_TABLENAME: begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FTableName;
    end;
  end;
end;

function TCodeObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;
type
  TDispIDsArray = array[0..0] of TDISPID;
  PDispIDsArray = ^TDispIDsArray;
var
  IDs: PDispIDsArray absolute DispIDs;
  i: integer;
  Name: WideString;
begin
  if NameCount > 1 then Result := DISP_E_UNKNOWNNAME
  else
    if NameCount < 1 then Result := E_INVALIDARG
    else Result := S_OK;
  for i := 0 to NameCount - 1 do
    IDs[i] := DISPID_UNKNOWN;
  if NameCount = 1 then
    begin
      Name := PWideChar(Names^);
      Result := DISP_E_UNKNOWNNAME;
      if UpperCase(Name) = 'TEXT' then
      begin
        IDs[0] := DISPID_TEXT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'SELTEXT' Then
      begin
        IDs[0] := DISPID_SELTEXT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'CURRENTSTR' then
      begin
        IDs[0] := DISPID_CURRENTSTR;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'SELSTART' then
      begin
        IDs[0] := DISPID_SELSTART;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'SELEND' then
      begin
        IDs[0] := DISPID_SELEND;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'SELECTALL' then
      begin
        IDs[0] := DISPID_SELECTALL;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'TABLENAME' then
      begin
        IDs[0] := DISPID_TABLENAME;
        Result:=S_OK;
      end;
    end;
end;

function TCodeObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TCodeObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TCodeObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
      on E: EBadCallEE do begin
          if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TCodeObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TCodeObj');
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
end.
