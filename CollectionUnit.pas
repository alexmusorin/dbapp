unit CollectionUnit;

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

TCollectionEnumerator = class(TInterfacedObject, IEnumVariant)
  private
    FEnumPosition: Integer;
    FDispatchList: TStringList;
    { IEnumVariant }
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  public
    constructor Create(DispatchList:TStringList);
  end;

TCollectionObj = class(TInterfacedObject, IDispatch)
  private
    FList: TStringList;
    FCollectionName:string;
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
    constructor Create(CollectionName:String; SubClassIndex:integer = 0);
    destructor Destroy;
    function GetItem(Index:Integer):IDispatch; overload;
    function GetItem(Index:String):IDispatch; overload;
  end;

implementation

uses Windows, TableObj, DataUnit, AppObjectsUnit, ConfigApp;

const DISPID_ITEM  = 1;
      DISPID_COUNT = 2;

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

function ValidType(Argument: TVariantArg; TypeId: Integer;
  RaiseException: Boolean): Boolean;
begin
 Result := Argument.vt = TypeId;
 if RaiseException and (not Result) then
   raise EInvalidParamType.Create('');
end;

{ TCollectionObj }

constructor TCollectionObj.Create(CollectionName: String; SubClassIndex:integer);
var i:integer;
    Obj:IDispatch;
begin
  FList:=TStringList.Create;
  FCollectionName:=CollectionName;
  if CollectionName='dbtables' then
  begin
    for i := 0 to TableList.Count- 1 do
    begin
      Obj:=IDispatch(TTableObj.Create(TADOTable(TableList.Objects[i])));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(TableList.Strings[i]),Pointer(Obj));
    end;
  end;
  if CollectionName='variables' then
  begin
    for i := 0 to AppConf_.Variables.Count - 1 do
    begin
      Obj:=IDispatch(TVariablesObj.Create(AppConf_.Variables.Variable[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.Variables.Variable[i].Name),Pointer(Obj));
    end;
  end;
  if CollectionName='modulegroups' then
  begin
    for i := 0 to AppConf_.Modules.Count - 1 do
    begin
      Obj:=IDispatch(TModulegroupObj.Create(AppConf_.Modules.Modulegroup[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Name),Pointer(Obj));
    end;
  end;
  if CollectionName='tables' then
  begin
    for i := 0 to AppConf_.Tables.Count - 1 do
    begin
      Obj:=IDispatch(TAppTablesObj.Create(AppConf_.Tables.Table[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.Tables.Table[i].Name), Pointer(Obj));
    end;
  end;
  if CollectionName='fields' then
  begin
    for i := 0 to AppConf_.Tables[subClassIndex].Fields.Count - 1 do
    begin
      Obj:=IDispatch(TFieldObj.Create(AppConf_.Tables.Table[subClassIndex].Fields.Field[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.Tables.Table[subClassIndex].Fields.Field[i].Name), Pointer(Obj));
    end;
  end;
  if CollectionName='modules' then
  begin
    for i := 0 to AppConf_.Modules.Modulegroup[subClassIndex].Count - 1 do
    begin
      Obj:=IDispatch(TModulesobj.Create(AppConf_.Modules.Modulegroup[subClassIndex].Module[i]));
      Obj._AddRef;
      FList.AddObject(AnsiUpperCase(AppConf_.Modules.Modulegroup[subClassIndex].Module[i].Name),Pointer(Obj));
    end;
  end;
  if CollectionName='webobjects' then
  begin
    for i := 0 to AppConf_.WEBPages.Count - 1 do
    begin
      Obj:=IDispatch(TWEBObj.Create(AppConf_.WEBPages.WEBPage[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.WEBPages.WEBPage[i].Name), Pointer(Obj));
    end;
  end;
  if CollectionName='forms' then
  begin
    for i := 0 to AppConf_.Forms.Count - 1 do
    begin
      Obj:=IDispatch(TFormObj.Create(AppConf_.Forms.Form[i]));
      Obj._AddRef;
      //FList.Add(Pointer(Obj));
      FList.AddObject(AnsiUpperCase(AppConf_.Forms.Form[i].Name),Pointer(Obj));
    end;
  end;
end;

destructor TCollectionObj.Destroy;
var i:integer;
begin
  for i := 0 to FList.Count - 1 do
  Begin
    if FCollectionName='dbtables' then TTableObj(FList.Objects[i]).Free;
  End;  
  FList.Clear;
end;

function TCollectionObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;

function _ValidType(Index, TypeId: Integer; RaiseException: Boolean): Boolean;
 // Проверяет параметр с номером Index на совпадение типа
 begin
   Result := ValidType(dps.rgvarg^[pDispIds^[Index]], TypeId, RaiseException);
 end;

begin
  Result := S_OK;
  case DispID of

  DISPID_NEWENUM:
  begin
    OleVariant(VarResult^) := TCollectionEnumerator.Create(FList) as IEnumVariant;
  end;
  DISPID_ITEM:begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) := IDispatch(Pointer(FList.Objects[IntValue(dps.rgvarg^[pDispIds^[0]])]))
        else
        begin
          OleVariant(VarResult^) := IDispatch(Pointer(FList.Objects[fList.IndexOf(AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal))]));
        end;
      end;
   end;
   DISPID_COUNT: begin
     OleVariant(VarResult^) := FList.Count;
   end;
  end;
end;

function TCollectionObj.GetIDsOfNames(const IID: TGUID; Names: Pointer;
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
  for i := 0 to NameCount - 1 do
    IDs[i] := DISPID_UNKNOWN;
  if NameCount = 1 then
    begin
      Name := PWideChar(Names^);
      Result := DISP_E_UNKNOWNNAME;

      if AnsiUpperCase(Name) = 'ITEM' then
      begin
        IDs[0] := DISPID_ITEM;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'COUNT' then
      begin
        IDs[0] := DISPID_COUNT;
        Result:=S_OK;
      end;
    end;
end;

function TCollectionObj.GetItem(Index: Integer): IDispatch;
begin
  Result:=IDispatch(Pointer(FList.Objects[Index]));
end;

function TCollectionObj.GetItem(Index: String): IDispatch;
begin
  Result:=IDispatch(Pointer(FList.Objects[fList.IndexOf(AnsiUpperCase(Index))]));
end;

function TCollectionObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TCollectionObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TCollectionObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TCollectionObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TCollectionObj');
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


{ TCollectionEnumerator }

function TCollectionEnumerator.Clone(out Enum: IEnumVariant): HResult;
var
  NewEnum: TCollectionEnumerator;
begin
  NewEnum := TCollectionEnumerator.Create(FDispatchList);
  NewEnum.FEnumPosition := FEnumPosition;
  Enum := NewEnum as IEnumVariant;
  Result := S_OK;
end;


constructor TCollectionEnumerator.Create(DispatchList:TStringList);
begin
  FDispatchList:=DispatchList;
end;

function TCollectionEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  pceltFetched: PLongWord): HResult;
var
  III: Cardinal;
begin
  Result := S_OK;
  III := 0;
  if FDispatchList<>nil then
  begin
      while (FEnumPosition < FDispatchList.Count) and (III < celt) do begin
        TVariantList(rgvar)[III] := IDispatch(Pointer(FDispatchList.Objects[FEnumPosition]));
        Inc(III);
        Inc(FEnumPosition);
      end;
  end else
    Result := S_FALSE;
  if III <> celt then
    Result := S_FALSE;
  if Assigned(pceltFetched) then
    pceltFetched^ := III;
end;

function TCollectionEnumerator.Reset: HResult;
begin
  FEnumPosition := 0;
  Result := S_OK;
end;

function TCollectionEnumerator.Skip(celt: LongWord): HResult;
var
  Total: Integer;
begin
  if FDispatchList<>nil then
    Total := FDispatchList.Count
  else
    Exit;
  if FEnumPosition + celt <= Total then begin
    Result := S_OK;
    Inc(FEnumPosition, celt)
  end;
end;

end.
