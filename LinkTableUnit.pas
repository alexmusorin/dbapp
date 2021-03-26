unit LinkTableUnit;

interface

uses Classes,SysUtils,ActiveX,ADODB, Variants;

type
   EInvalidParamCount = class(Exception)
  end;

  EBadCallEE = class(Exception)
  end;

  EInvalidParamType = class(Exception)
  end;

TLinkObj = class(TInterfacedObject, IDispatch)
  private
    FTable: TADOQuery;
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
    constructor Create(ATable: TADOQuery);
  end;

implementation

uses
  Windows, Dialogs, DB;

const
  DISPID_SQL    = 3;
  DISPID_OPEN   = 4;
  DISPID_FIELD  = 5;
  DISPID_FIRST  = 6;
  DISPID_NEXT   = 7;
  DISPID_PREV   = 8;
  DISPID_LAST   = 9;
  DISPID_EOF    = 10;
  DISPID_BOF    = 11;
  DISPID_CLOSE  = 12;
  DISPID_COLUMN = 13;
  DISPID_FIELDCOUNT = 14;
  DISPID_FIELDNAMES = 15;

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

{ TLinkObj }

constructor TLinkObj.Create(ATable: TADOQuery);
begin
  inherited Create;
  FTable:=ATable;
end;

function TLinkObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var pVar: PVariant;
    //mVar:Variant;

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
  DISPID_SQL:begin
     if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
     OleVariant(VarResult^):=FTable.SQL.Text;
  end;
  DISPID_CLOSE:begin
   if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Close;
      end;
  end;
  DISPID_OPEN:begin
    if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Open;
      end;
  end;
  DISPID_NEXT:
    begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Next;
        Result := S_OK
      end;
    end;
    DISPID_PREV:
    begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Prior;
        Result := S_OK
      end;
    end;
    DISPID_FIRST:
    begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FTable.First;
        Result := S_OK
      end;
    end;
    DISPID_LAST:
    begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Last;
        Result := S_OK
      end;
    end;
    DISPID_EOF:
    begin
      OleVariant(VarResult^):=FTable.Eof;
      Result := S_OK
    end;
    DISPID_BOF:
    begin
      OleVariant(VarResult^):=FTable.Bof;
      Result := S_OK
    end;
  DISPID_FIELD:begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):=FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).AsVariant;
      if _ValidType(0, VT_I2, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[dps.rgvarg^[pDispIds^[0]].iVal].AsVariant;
      if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
      begin
        pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
        case VarType(pVar^) of
          varSmallint, varInteger, varInt64:
            OleVariant(VarResult^):=FTable.Fields[Integer(pVar^)].AsVariant;
          varOleStr,varString: OleVariant(VarResult^):=FTable.FieldByName(String(pVar^)).AsVariant;
        end;
      end
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_COLUMN:begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or  _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):=FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DisplayLabel;
      if _ValidType(0, VT_I2, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[dps.rgvarg^[pDispIds^[0]].iVal].DisplayLabel;
      if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
      begin
        pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
        case VarType(pVar^) of
          varSmallint, varInteger, varInt64:
            OleVariant(VarResult^):=FTable.Fields[Integer(pVar^)].DisplayLabel;
          varOleStr,varString: OleVariant(VarResult^):=FTable.FieldByName(String(pVar^)).DisplayLabel;
        end;
      end
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_FIELDCOUNT:
    begin
      OleVariant(VarResult^):=FTable.Fields.Count;
      Result := S_OK
    end;
  DISPID_FIELDNAMES:begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_I2, FALSE) or  _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
    begin
      if _ValidType(0, VT_I2, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[dps.rgvarg^[pDispIds^[0]].iVal].FieldName;
      if _ValidType(0, VT_BYREF+VT_VARIANT, FALSE) then
      begin
        pVar:=dps.rgvarg^[pDispIds^[0]].pVarVal;
        case VarType(pVar^) of
          varSmallint, varInteger, varInt64:
            OleVariant(VarResult^):=FTable.Fields[Integer(pVar^)].DisplayLabel;
          varOleStr,varString: OleVariant(VarResult^):=FTable.FieldByName(String(pVar^)).FieldName;
        end;
      end
    end
    else
      raise EInvalidParamType.Create('');
  end;
  20..220:begin
     if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
     begin
       if not FTable.Fields[DispID-20].IsNull then
         OleVariant(VarResult^):=FTable.Fields[DispID-20].AsVariant
       else  OleVariant(VarResult^):='';
     end;
    if Flags = DISPATCH_PROPERTYPUT  then
    begin
      //FLines.Add(FTable.Fields[DispID-20].DisplayName+'='+dps.rgvarg^[pDispIds^[0]].bstrVal);
       case dps.rgvarg^[pDispIds^[0]].vt of
         VT_I2,VT_I4:  FTable.Fields[DispID-20].AsInteger:=dps.rgvarg^[pDispIds^[0]].lVal;
         VT_R4: FTable.Fields[DispID-20].AsFloat:= dps.rgvarg^[pDispIds^[0]].fltVal;
         VT_R8: FTable.Fields[DispID-20].AsFloat:= dps.rgvarg^[pDispIds^[0]].dblVal;
         VT_CY: FTable.Fields[DispID-20].AsCurrency:= dps.rgvarg^[pDispIds^[0]].cyVal;
         VT_DATE: FTable.Fields[DispID-20].AsDateTime:= dps.rgvarg^[pDispIds^[0]].date;
         VT_BSTR: FTable.Fields[DispID-20].AsString:= dps.rgvarg^[pDispIds^[0]].bstrVal;
       else
       ShowMessage('неизвестный науке зверь!');
        // FTable.Fields[DispID-20].AsVariant:=dps.rgvarg^[pDispIds^[0]].
       end;
    end;
  end;
  end;
end;

function TLinkObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      for j := 0 to FTable.Fields.Count-1 do
      begin
        if (AnsiUpperCase(FTable.Fields[j].FieldName)=AnsiUpperCase(Name)) or
           (AnsiUpperCase(FTable.Fields[j].DisplayLabel)=AnsiUpperCase(Name))  then
        begin
          IDs[0] := j + 20;
          Result:=S_OK;
        end;
      end;
      ////////////////////////////////////
      if UpperCase(Name) = 'SQL' then
      begin
        IDs[0] := DISPID_SQL;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'OPEN' then
      begin
        IDs[0] := DISPID_OPEN;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIELD' then
      begin
        IDs[0] := DISPID_FIELD;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'CLOSE' then
      begin
        IDs[0] := DISPID_CLOSE;
        Result:=S_OK;
      end;
      ////////////////////////////////////
      if UpperCase(Name) = 'NEXT' then
      begin
        IDs[0] := DISPID_NEXT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'PREV' then
      begin
        IDs[0] := DISPID_PREV;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIRST' then
      begin
        IDs[0] := DISPID_FIRST;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'LAST' then
      begin
        IDs[0] := DISPID_LAST;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'BOF' then
      begin
        IDs[0] := DISPID_BOF;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'EOF' then
      begin
        IDs[0] := DISPID_EOF;
        Result:=S_OK;
      end;
       if UpperCase(Name) = 'COLUMN' then
      begin
        IDs[0] := DISPID_COLUMN;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIELDCOUNT' then
      begin
        IDs[0] := DISPID_FIELDCOUNT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIELDNAMES' then
      begin
        IDs[0] := DISPID_FIELDNAMES;
        Result:=S_OK;
      end;
    end;
end;

function TLinkObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TLinkObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TLinkObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TLinkObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TLinkObj');
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
