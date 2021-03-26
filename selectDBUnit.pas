unit selectDBUnit;

interface

uses Classes,SysUtils,ActiveX,ADODB,Forms, GridFrame, FilterDBGrid_,DialogDB;

type
   EInvalidParamCount = class(Exception)
  end;

  EBadCallEE = class(Exception)
  end;

  EInvalidParamType = class(Exception)
  end;

TDBDialogObj = class(TInterfacedObject, IDispatch)
  private
    DialogForm: TDialogDBForm;
    Grid_Frame:TGrid_Frame;
    fFieldName:String;
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
    constructor Create(DForm:TDialogDBForm);
  end;


implementation

uses
  Windows, Dialogs, DB, Controls, DataUnit;

const
  DISPID_ADD           = 1001;
  DISPID_CLEAR         = 1002;
  DISPID_SQL           = 1003;
  DISPID_FIELDNAME     = 1004;
  DISPID_QUERYRESULT   = 1005;
  DISPID_EXECUTE       = 1006;
  DISPID_DESCRFIELD    = 1007;
  DISPID_DESCRIPTION   = 1008;
  DISPID_DEFAULTFILTER = 1009;

{Utils}

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

{ TDBDialogObj }

constructor TDBDialogObj.Create;
begin
  inherited Create;
  //создание объекта
  DialogForm:=DForm;
end;

function TDBDialogObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
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

begin
  Result := S_OK;
  case DispID of
    0..255:begin
     if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
     begin
       if not DialogForm.Grid_Frame1.ADOQuery.Fields[DispID].IsNull then
         OleVariant(VarResult^):=DialogForm.Grid_Frame1.ADOQuery.Fields[DispID].AsVariant
       else  OleVariant(VarResult^):='';
     end;
    end;
    DISPID_ADD:
    begin
     if (Flags = DISPATCH_METHOD) then
     begin
       CheckArgCount(dps.cArgs, [3], TRUE);
       DialogForm.AddLabel(dps.rgvarg^[pDispIds^[0]].bstrVal,dps.rgvarg^[pDispIds^[1]].bstrVal,IntValue(dps.rgvarg^[pDispIds^[2]]));
     end;
    end;
    DISPID_CLEAR:
    begin
      if (Flags = DISPATCH_METHOD) then
     begin
       DialogForm.Clear;
     end;
    end;
    DISPID_SQL:
    begin
      if Flags = DISPATCH_PROPERTYPUT  then
        DialogForm.Query:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_FIELDNAME:
    begin
      if Flags = DISPATCH_PROPERTYPUT  then
        DialogForm.FieldName:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_QUERYRESULT:
    begin
       if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
      OleVariant(VarResult^):=DialogForm.resField;
    end;
    DISPID_EXECUTE:
    begin
      if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
      DialogForm.Grid_Frame1.DBGrid.SetFilter;
      OleVariant(VarResult^):=(DialogForm.ShowModal=mrOk);
    end;
    DISPID_DESCRFIELD:
    begin
      if Flags = DISPATCH_PROPERTYPUT  then
        DialogForm.DescrField:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_DESCRIPTION:
    begin
      if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
      OleVariant(VarResult^):=DialogForm.Description;
    end;
    DISPID_DEFAULTFILTER:
    begin
       if Flags = DISPATCH_PROPERTYPUT  then
        DialogForm.DefaultFilter:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
  end;

end;

function TDBDialogObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;
type
  TDispIDsArray = array[0..0] of TDISPID;
  PDispIDsArray = ^TDispIDsArray;
var
  IDs: PDispIDsArray absolute DispIDs;
  i,j: integer;
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
      ////////////////////////////////////
      for j := 0 to DialogForm.Grid_Frame1.ADOQuery.Fields.Count-1 do
      begin
        if AnsiUpperCase(DialogForm.Grid_Frame1.ADOQuery.Fields[j].FieldName)=AnsiUpperCase(Name) then
        begin
          IDs[0] := j;
          Result:=S_OK;
        end;
      end;
      ////////////////////////////////////
      if AnsiUpperCase(Name) = 'ADDLABEL' then
      begin
        IDs[0] := DISPID_ADD;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CLEAR' then
      begin
        IDs[0] := DISPID_CLEAR;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'SQL' then
      begin
        IDs[0] := DISPID_SQL;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'FIELD' then
      begin
        IDs[0] := DISPID_FIELDNAME;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'QUERYRESULT' then
      begin
        IDs[0] := DISPID_QUERYRESULT;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'EXECUTE' then
      begin
        IDs[0] := DISPID_EXECUTE;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DESCRIPTIONFIELD' then
      begin
        IDs[0] := DISPID_DESCRFIELD;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DESCRIPTION' then
      begin
        IDs[0] := DISPID_DESCRIPTION;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DEFAULTFILTER' then
      begin
        IDs[0] := DISPID_DEFAULTFILTER;
        Result:=S_OK;
      end;
    end;
end;

function TDBDialogObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TDBDialogObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TDBDialogObj.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBDialogObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBDialogObj');
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
