unit QueryUnit;

interface

uses Classes,SysUtils,ActiveX,ADODB;

type
   EInvalidParamCount = class(Exception)
  end;

  EBadCallEE = class(Exception)
  end;

  EInvalidParamType = class(Exception)
  end;

IEnumVariant = interface(IUnknown)
    ['{00020404-0000-0000-C000-000000000046}']
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  end;

TQueryEnumerator = class(TInterfacedObject, IEnumVariant)
  private
    FEnumPosition: Integer;
    FOwner: TPersistent;
    //FScriptControl: TVCLScriptControl;
    { IEnumVariant }
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  public
    constructor Create(AOwner: TPersistent);
  end;

TDBQueryObj = class(TInterfacedObject, IDispatch)
  private
    FTable: TADOQuery;
    FFieldIndex: Integer;
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
    constructor Create(ATable: TADOQuery; FieldIndex:integer);
  end;

  TDBQueryEnumerator = class(TInterfacedObject, IEnumVariant)
  private
    FEnumPosition: LongWord;
    FList: TStringList;
    //FScriptControl: TVCLScriptControl;
    { IEnumVariant }
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  public
    constructor Create(AList: TStringList);
  end;

  TDBQuerysCollection  = class(TInterfacedObject, IDispatch)
  private
    FList: TStringList;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function GetItem(Index:Integer):IDispatch; overload;
    function GetItem(Index:String):IDispatch; overload;
  protected
    function DoInvoke (DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var dps : TDispParams; pDispIds : PDispIdList;
      VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual;
  public
    constructor Create(ATable: TADOQuery);
    destructor Destroy;
  end;

TQueryObj = class(TInterfacedObject, IDispatch)
  private
    FTable: TADOQuery;
    FCommand: TADOCommand;
    FFieldsCollection: TDBQuerysCollection;
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
    constructor Create(ATable: TADOQuery; ACommand:TADOCommand);
  end;

implementation

uses
  Windows, Dialogs, DB, TypInfo;

const
  DISPID_EDIT = 1;
  DISPID_INSERT = 2;
  DISPID_POST = 3;
  DISPID_OPEN = 4;
  DISPID_FIELD = 5;
  DISPID_FIRST = 6;
  DISPID_NEXT = 7;
  DISPID_PREV = 8;
  DISPID_LAST = 9;
  DISPID_EOF = 10;
  DISPID_BOF = 11;
  DISPID_CLOSE = 12;
  DISPID_SQL = 13;
  DISPID_EXECUTE = 14;
  DISPID_ISSTRING = 15;
  DISPID_ISDATETIME = 16;
  DISPID_ISINTEGER = 17;
  DISPID_ISFLOAT = 18;
  DISPID_ISAUTOINC = 19;
  DISPID_FIELDNAMES = 20;
  DISPID_FIELDCOUNT = 310;
  DISPID_FIELDS = 311;

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

{ TQueryObj }

constructor TQueryObj.Create(ATable: TADOQuery; ACommand:TADOCommand);
begin
  inherited Create;
  FTable:=ATable;
  FCommand:= ACommand;
  if ATable.Active then
  if not Assigned(FFieldsCollection) then
        begin
          FFieldsCollection:=TDBQuerysCollection.Create(FTable);
          FFieldsCollection._AddRef;
        end;
end;

function TQueryObj.DoInvoke(DispID: Integer; const IID: TGUID;
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
  DISPID_VALUE:
  begin
    if Flags = DISPATCH_PROPERTYPUT  then
        FTable.SQL.Text:=dps.rgvarg^[pDispIds^[0]].bstrVal;
  end;
  DISPID_NEWENUM:
  begin
    OleVariant(VarResult^) := TQueryEnumerator.Create(FTable) as IEnumVariant;
  end;
  {DISPID_EDIT:begin
   if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Edit;
      end;
  end;
  DISPID_INSERT:begin
   if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Insert;
      end;
  end;
  DISPID_POST:begin
    if (Flags = DISPATCH_METHOD) then
      begin
        FTable.Post;
      end;
  end;   }
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
        if not Assigned(FFieldsCollection) then
        begin
          FFieldsCollection:=TDBQuerysCollection.Create(FTable);
          FFieldsCollection._AddRef;
        end;
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
    DISPID_SQL:
    begin
      if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
        OleVariant(VarResult^):=FTable.SQL.Text
      else
      if Flags = DISPATCH_PROPERTYPUT  then
        FTable.SQL.Text:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    end;
    DISPID_EXECUTE:
    begin
      if (Flags = DISPATCH_METHOD) then
      begin
        FCommand.CommandText:=FTable.SQL.Text;
        FCommand.Execute;
      end;
    end;
    DISPID_FIELDCOUNT:
    begin
      OleVariant(VarResult^):=FTable.Fields.Count;
      Result := S_OK
    end;
  DISPID_FIELD:begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):=FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).AsVariant;
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].AsVariant;
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_FIELDS:
  begin
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(FFieldsCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=FFieldsCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=FFieldsCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_ISSTRING:
  begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):= FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DataType in [ftString, ftMemo, ftWideString];
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].DataType in [ftString, ftMemo, ftWideString];
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_ISDATETIME:
  begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):= FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DataType in [ftDateTime, ftTimeStamp, ftDate, ftTime];
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].DataType in [ftDateTime, ftTimeStamp, ftDate, ftTime];
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_ISINTEGER:
  begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):= FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DataType in [ftSmallint, ftInteger, ftWord, ftLargeint];
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].DataType in [ftSmallint, ftInteger, ftWord, ftLargeint];
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_ISFLOAT:
  begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):= FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DataType in [ftFloat, ftCurrency, ftBCD];
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].DataType in [ftFloat, ftCurrency, ftBCD];
    end
    else
      raise EInvalidParamType.Create('');
  end;
  DISPID_ISAUTOINC:
  begin
  if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    if _ValidType(0, VT_BSTR, FALSE) or _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
    begin
      if _ValidType(0, VT_BSTR, FALSE) then
        OleVariant(VarResult^):= FTable.FieldByName(dps.rgvarg^[pDispIds^[0]].bstrVal).DataType in [ftAutoInc];
      if _ValidType(0, VT_I2, FALSE) or _ValidType(0, VT_I4, FALSE) then
        OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].DataType in [ftAutoInc];
    end;
  end;
  DISPID_FIELDNAMES:
   begin
     if not (Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD) then  raise EBadCallEE.Create('');
    CheckArgCount(dps.cArgs, [1], TRUE);
    OleVariant(VarResult^):=FTable.Fields[_IntValue(0)].FieldName;
   end;
  40..260:begin
     if Flags = DISPATCH_PROPERTYGET or DISPATCH_METHOD then
     begin
       if not FTable.Fields[DispID-40].IsNull then
         OleVariant(VarResult^):=FTable.Fields[DispID-40].AsVariant
       else  OleVariant(VarResult^):='';
     end;
    if Flags = DISPATCH_PROPERTYPUT  then
    begin
      //FLines.Add(FTable.Fields[DispID-20].DisplayName+'='+dps.rgvarg^[pDispIds^[0]].bstrVal);
       case dps.rgvarg^[pDispIds^[0]].vt of
         VT_I2,VT_I4:  FTable.Fields[DispID-40].AsInteger:=dps.rgvarg^[pDispIds^[0]].lVal;
         VT_R4: FTable.Fields[DispID-40].AsFloat:= dps.rgvarg^[pDispIds^[0]].fltVal;
         VT_R8: FTable.Fields[DispID-40].AsFloat:= dps.rgvarg^[pDispIds^[0]].dblVal;
         VT_CY: FTable.Fields[DispID-40].AsCurrency:= dps.rgvarg^[pDispIds^[0]].cyVal;
         VT_DATE: FTable.Fields[DispID-40].AsDateTime:= dps.rgvarg^[pDispIds^[0]].date;
         VT_BSTR: FTable.Fields[DispID-40].AsString:= dps.rgvarg^[pDispIds^[0]].bstrVal;
       else
       ShowMessage('неизвестный науке зверь!');
        // FTable.Fields[DispID-20].AsVariant:=dps.rgvarg^[pDispIds^[0]].
       end;
    end;
  end;
  end;
end;

function TQueryObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
        if AnsiUpperCase(FTable.Fields[j].DisplayName)=AnsiUpperCase(Name) then
        begin
          IDs[0] := j + 40;
          Result:=S_OK;
        end;
      end;
      ////////////////////////////////////
      {if AnsiUpperCase(Name) = 'EDIT' then
      begin
        IDs[0] := DISPID_EDIT;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'INSERT' then
      begin
        IDs[0] := DISPID_INSERT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'POST' then
      begin
        IDs[0] := DISPID_POST;
        Result:=S_OK;
      end; }
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
      if UpperCase(Name) = 'FIELDS' then
      begin
        IDs[0] := DISPID_FIELDS;
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
      if UpperCase(Name) = 'SQL' then
      begin
        IDs[0] := DISPID_SQL;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'EXECUTE' then
      begin
        IDs[0] := DISPID_EXECUTE;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'ISSTRING' then
      begin
        IDs[0] := DISPID_ISSTRING;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'ISDATETIME' then
      begin
        IDs[0] := DISPID_ISDATETIME;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'ISINTEGER' then
      begin
        IDs[0] := DISPID_ISINTEGER;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'ISFLOAT' then
      begin
        IDs[0] := DISPID_ISFLOAT;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'ISAUTOINC' then
      begin
        IDs[0] := DISPID_ISAUTOINC;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIELDNAMES' then
      begin
        IDs[0] := DISPID_FIELDNAMES;
        Result:=S_OK;
      end;
      if UpperCase(Name) = 'FIELDCOUNT' then
      begin
        IDs[0] := DISPID_FIELDCOUNT;
        Result:=S_OK;
      end;
    end;
end;

function TQueryObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TQueryObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TQueryObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TQueryObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TQueryObj');
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

{ TQueryEnumerator }

function TQueryEnumerator.Clone(out Enum: IEnumVariant): HResult;
var
  NewEnum: TQueryEnumerator;
begin
  NewEnum := TQueryEnumerator.Create(FOwner);
  NewEnum.FEnumPosition := FEnumPosition;
  Enum := NewEnum as IEnumVariant;
  Result := S_OK;
end;

constructor TQueryEnumerator.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FEnumPosition := 0;
end;

function TQueryEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  pceltFetched: PLongWord): HResult;
var
  III: Cardinal;
begin
  Result := S_OK;
  III := 0;
  if FOwner is TADOQuery then
  begin
    with TADOTable(FOwner) do
    begin
      while (FEnumPosition < Fields.Count) and (III < celt) do begin
        TVariantList(rgvar)[III] := TADOQuery(FOwner).Fields[FEnumPosition].AsVariant;
        Inc(III);
        Inc(FEnumPosition);
      end;
    end;
  end else
    Result := S_FALSE;
  if III <> celt then
    Result := S_FALSE;
  if Assigned(pceltFetched) then
    pceltFetched^ := III;
end;

function TQueryEnumerator.Reset: HResult;
begin
  FEnumPosition := 0;
  Result := S_OK;
end;

function TQueryEnumerator.Skip(celt: LongWord): HResult;
var
  Total: Integer;
begin
  if FOwner is TADOQuery then
    Total := TADOQuery(FOwner).Fields.Count
  else
    Exit;
  if FEnumPosition + celt <= Total then begin
    Result := S_OK;
    Inc(FEnumPosition, celt)
  end;
end;

  { TDBQueryObj }

const
  DISPID_NAME  = 1;
  DISPID_FIELDVALUE = 2;
  DISPID_TYPE  = 3;
  DISPID_COUNT = 4;
  DISPID_DATASIZE = 5;
  DISPID_DISPLAYWIDTH = 6;
  DISPID_DISPLAYLABEL = 7;


constructor TDBQueryObj.Create(ATable: TADOQuery; FieldIndex: integer);
begin
  inherited Create;
  FTable:=ATable;
  FFieldIndex := FieldIndex;
end;

function TDBQueryObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  case DispID of
    DISPID_NAME:
    begin
      OleVariant(VarResult^):=FTable.Fields[FFieldIndex].FieldName;
    end;
    DISPID_TYPE:
    begin
      OleVariant(VarResult^):=GetEnumName(TypeInfo(TFieldType), Ord(FTable.Fields[FFieldIndex].DataType))
    end;
    DISPID_FIELDVALUE:
    begin
      OleVariant(VarResult^):=FTable.Fields[FFieldIndex].AsVariant;
    end;
    DISPID_DATASIZE:
    begin
      OleVariant(VarResult^):=FTable.Fields[FFieldIndex].DataSize;
    end;
    DISPID_DISPLAYWIDTH:
    begin
      OleVariant(VarResult^):=FTable.Fields[FFieldIndex].DisplayWidth;
    end;
    DISPID_DISPLAYLABEL:
    begin
      OleVariant(VarResult^):=FTable.Fields[FFieldIndex].DisplayLabel;
    end;
  end;
end;

function TDBQueryObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
  for i := 0 to NameCount - 1 do IDs[i] := DISPID_UNKNOWN;
  if NameCount = 1 then
    begin
      Name := PWideChar(Names^);
      Result := DISP_E_UNKNOWNNAME;
    end;
   ////////////////////
   if UpperCase(Name) = 'FIELDNAME' then
      begin
        IDs[0] := DISPID_NAME;
        Result:=S_OK;
      end;
   if UpperCase(Name) = 'DATATYPE' then
      begin
        IDs[0] := DISPID_TYPE;
        Result:=S_OK;
      end;
   if UpperCase(Name) = 'VALUE' then
      begin
        IDs[0] := DISPID_FIELDVALUE;
        Result:=S_OK;
      end;
   if UpperCase(Name) = 'DATASIZE' then
      begin
        IDs[0] := DISPID_DATASIZE;
        Result:=S_OK;
      end;
   if UpperCase(Name) = 'DISPLAYWIDTH' then
      begin
        IDs[0] := DISPID_DISPLAYWIDTH;
        Result:=S_OK;
      end;
   if UpperCase(Name) = 'DISPLAYLABEL' then
      begin
        IDs[0] := DISPID_DISPLAYLABEL;
        Result:=S_OK;
      end;
   ////////////////////
end;

function TDBQueryObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TDBQueryObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TDBQueryObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBQueryObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBQueryObj');
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

{ TDBQuerysCollection }

constructor TDBQuerysCollection.Create(ATable: TADOQuery);
var i:integer;
    Obj:IDispatch;
begin
  FList:=TStringList.Create;
  for i := 0 to ATable.Fields.Count -1 do
  begin
    Obj := IDispatch(TDBQueryObj.Create(ATable,i));
    Obj._AddRef;
    FList.AddObject(ATable.Fields[i].FieldName,Pointer(Obj));
  end;
end;

destructor TDBQuerysCollection.Destroy;
begin
  FList.Free;
  inherited;
end;

function TDBQuerysCollection.DoInvoke(DispID: Integer; const IID: TGUID;
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
    DISPID_NEWENUM:
    begin
      OleVariant(VarResult^) := TDBQueryEnumerator.Create(FList) as IEnumVariant;
    end;
    DISPID_VALUE:
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) := IDispatch(Pointer(FList.Objects[_IntValue(0)]))
        else
        begin
          OleVariant(VarResult^) := IDispatch(Pointer(FList.Objects[fList.IndexOf(AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal))]));
        end;
      end;
    end;
    DISPID_COUNT:
    begin
      OleVariant(VarResult^) := FList.Count;
    end;
  end;
end;

function TDBQuerysCollection.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
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
  for i := 0 to NameCount - 1 do IDs[i] := DISPID_UNKNOWN;
  if NameCount = 1 then
    begin
      Name := PWideChar(Names^);
      Result := DISP_E_UNKNOWNNAME;
    end;
   //////////////////////////
   if UpperCase(Name) = 'COUNT' then
      begin
        IDs[0] := DISPID_COUNT;
        Result:=S_OK;
      end;
end;

function TDBQuerysCollection.GetItem(Index: Integer): IDispatch;
begin
 Result:=IDispatch(Pointer(FList.Objects[Index]));
end;

function TDBQuerysCollection.GetItem(Index: String): IDispatch;
begin
 Result:=IDispatch(Pointer(FList.Objects[fList.IndexOf(AnsiUpperCase(Index))]));
end;

function TDBQuerysCollection.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TDBQuerysCollection.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TDBQuerysCollection.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBQuerysCollection');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TDBQuerysCollection');
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

{ TDBQueryEnumerator }

function TDBQueryEnumerator.Clone(out Enum: IEnumVariant): HResult;
var
  NewEnum: TDBQueryEnumerator;
begin
  NewEnum := TDBQueryEnumerator.Create(FList);
  NewEnum.FEnumPosition := FEnumPosition;
  Enum := NewEnum as IEnumVariant;
  Result := S_OK;
end;

constructor TDBQueryEnumerator.Create(AList: TStringList);
begin
  FList := TStringList.Create;
  FList.Assign(AList);
end;

function TDBQueryEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  pceltFetched: PLongWord): HResult;
var
  III: LongWord;
begin
  Result := S_OK;
  III := 0;
  while (FEnumPosition < FList.Count) and (III < celt) do begin
    TVariantList(rgvar)[III] := IDispatch(Pointer(FList.Objects[FEnumPosition]));
    Inc(III);
    Inc(FEnumPosition);
  end;
  if III <> celt then
    Result := S_FALSE;
  if Assigned(pceltFetched) then
    pceltFetched^ := III;
end;

function TDBQueryEnumerator.Reset: HResult;
begin
  FEnumPosition := 0;
  Result := S_OK;
end;

function TDBQueryEnumerator.Skip(celt: LongWord): HResult;
var
  Total: LongWord;
begin
  Total := FList.Count;
  if (FEnumPosition + celt) <= Total then begin
    Result := S_OK;
    Inc(FEnumPosition, celt)
  end;
end;

end.
