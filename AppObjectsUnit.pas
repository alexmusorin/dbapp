unit AppObjectsUnit;

interface
uses Classes, ADODB, SysUtils,ActiveX, ConfigApp, testFormUnit, CollectionUnit, LinkTableUnit;

type

EInvalidParamCount = class(Exception)
  end;

EBadCallEE = class(Exception)
  end;

EInvalidParamType = class(Exception)
  end;

TVariablesObj = class(TInterfacedObject, IDispatch)
  private
    FVarLnk: IXMLVariableType;
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
    constructor Create(VarLnk:IXMLVariableType);
  end;

TModulesObj = class(TInterfacedObject, IDispatch)
  private
    FVarLnk: IXMLModuleType;
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
    constructor Create(VarLnk:IXMLModuleType);
  end;

TModuleGroupObj = class(TInterfacedObject, IDispatch)
  private
    FVarLnk: IXMLModuleGroupType;
    FModuleCollection:TCollectionObj;
    FModName: String;
    FModIndex: integer;
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
    constructor Create(VarLnk:IXMLModuleGroupType);
  end;

TFieldObj = class(TInterfacedObject, IDispatch)
  private
    FFldLnk: IXMLFieldType;
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
    constructor Create(FldLnk:IXMLFieldType);
  end;

TAppTablesObj = class(TInterfacedObject, IDispatch)
  private
    FTblLnk: IXMLTableType;
    FDialogForm:TTestDialog;
    FActionName:string;
    FFieldCollection:TCollectionObj;
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
    constructor Create(TblLnk:IXMLTableType);
  end;

TWEBObj = class(TInterfacedObject, IDispatch)
  private
    FWEBLnk: IXMLWEBPageType;
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
    constructor Create(WEBLnk:IXMLWEBPageType);
  end;

TFormObj = class(TInterfacedObject, IDispatch)
  private
    FFormLnk: IXMLFormType;
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
    constructor Create(FormLnk:IXMLFormType);
  end;

TTestEventObj = class(TInterfacedObject, IDispatch)
  private
    FEvent: IDispatch;
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
    constructor Create;
  end;


implementation

uses Windows, XMLIntf, Main, DataUnit, EncdDecd, Forms, dialogs;

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

{ TVariablesObj }

constructor TVariablesObj.Create(VarLnk: IXMLVariableType);
begin
  FVarLnk:=VarLnk;
end;

function TVariablesObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var BStr:TStringList;
begin
  Result := S_OK;
  case DispID of
  1:begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        OleVariant(VarResult^) := FVarLnk.Name;
      end;
   end;
   2: begin
     OleVariant(VarResult^) := FVarLnk.Text;
   end;
   3: begin
     //OleVariant(VarResult^) := FVarLnk.Text;
     if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
     begin
       BStr:=TStringList.Create;
       BStr.Text := FVarLnk.Text;
       OleVariant(VarResult^) := BStr.Values[dps.rgvarg^[pDispIds^[0]].bstrVal];
       BStr.Free;
     end;
   end;
   4: begin
     //OleVariant(VarResult^) := FVarLnk.Text;
     if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
     begin
       BStr:=TStringList.Create;
       BStr.Text := FVarLnk.Text;
       OleVariant(VarResult^) := Bstr.Names[IntValue(dps.rgvarg^[pDispIds^[0]])];
       BStr.Free;
     end;
   end;
   5: begin
       BStr:=TStringList.Create;
       BStr.Text := FVarLnk.Text;
       OleVariant(VarResult^) := BStr.Count;
       BStr.Free;
   end
  end;
end;

function TVariablesObj.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
type
  TDispIDsArray = array[0..0] of TDISPID;
  PDispIDsArray = ^TDispIDsArray;
var
  IDs: PDispIDsArray absolute DispIDs;
  i:integer;
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
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'VALUE' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'VALUES' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'NAMES' then
      begin
        IDs[0] := 4;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'COUNT' then
      begin
        IDs[0] := 5;
        Result:=S_OK;
      end;
    end;
end;

function TVariablesObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TVariablesObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TVariablesObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TVariablesObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TVariablesObj');
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

{ TModulesObj }

constructor TModulesObj.Create(VarLnk: IXMLModuleType);
begin
  FVarLnk:=VarLnk;
end;

function TModulesObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  case DispID of
  1:begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        OleVariant(VarResult^) := FVarLnk.Name;
      end;
   end;
   2: begin
     OleVariant(VarResult^) := FVarLnk.Text;
   end;
   3: begin
     OleVariant(VarResult^) := FVarLnk.MType;
   end;
  end;
end;

function TModulesObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CODE' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'TYPE' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
    end;
end;

function TModulesObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TModulesObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TModulesObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TModulesObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TModulesObj');
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

{ TAppTablesObj }

constructor TAppTablesObj.Create(TblLnk: IXMLTableType);
var i:integer;
begin
  FTblLnk:=TblLnk;
  FDialogForm:=nil;
  i:=0;
  while TblLnk.Name<>Appconf_.Tables.Table[i].Name do Inc(i);
  FFieldCollection:=TCollectionObj.Create('fields', i);
  IDispatch(FFieldCollection)._AddRef;
end;

function TAppTablesObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
  var i:integer;
  AQuery:TADOQuery;

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
  1:begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        OleVariant(VarResult^) := FTblLnk.Name;
      end;
   end;

   2: begin
     OleVariant(VarResult^) := FTblLnk.Query;
   end;

   3: begin
     for i := 0 to FtblLnk.Actions.Count - 1 do
     begin
      if AnsiUpperCase(FActionName)=AnsiUpperCase(FTblLnk.Actions.Action[i].Name) then
        OleVariant(VarResult^) := FTblLnk.Actions.Action[i].Text;
     end;
   end;

   4:begin
     if CheckArgCount(dps.cArgs, [0], FALSE) then FDialogForm:=MainForm.ShowTableWindow(FTblLnk,'');
     if CheckArgCount(dps.cArgs, [1], FALSE) then
     begin
        FDialogForm:=MainForm.ShowTableWindow(FTblLnk,dps.rgvarg^[pDispIds^[0]].bstrVal);
     end;
   end;

   5:begin
      //OleVariant(VarResult^) := IDispatch(FFieldCollection);
      if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(FFieldCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=FFieldCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=FFieldCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;

   end;
   6: begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
         //OleVariant(VarResult^):=IDispatch(TLinkObj.Create(MainForm.ShowTableWindow(FTblLnk,'').Grid_Frame1.ADOQuery));
      for i := 0 to MainForm.MDIChildCount - 1 do
      if AnsiUpperCase(MainForm.MDIChildren[i].Caption)=
         AnsiUpperCase(fTblLnk.Name) then
      begin
        AQuery:= TTestDialog(MainForm.MDIChildren[i]).Grid_Frame1.ADOQuery;
      end;
        OleVariant(VarResult^):= IDispatch(TLinkObj.Create(AQuery));
      end;
   end;
   7: begin
      if (Flags = DISPATCH_METHOD) then
      begin
        //MainForm.ShowTableWindow(FTblLnk,'').Grid_Frame1.Refresh;
      for i := 0 to MainForm.MDIChildCount - 1 do
      if AnsiUpperCase(MainForm.MDIChildren[i].Caption)=
         AnsiUpperCase(fTblLnk.Name) then
      begin
        TTestDialog(MainForm.MDIChildren[i]).Grid_Frame1.Refresh;
      end;

        Result := S_OK
      end;
   end;
  end;
end;

function TAppTablesObj.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
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
      for j := 0 to FTblLnk.Actions.Count - 1 do
      begin
        if AnsiUpperCase(Name)=AnsiUpperCase(FTblLnk.Actions.Action[j].Name) then
        begin
          IDs[0] := 3;
          FActionName:=Name;
          Result:=S_OK;
        end;
      end;
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'QUERY' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'SHOW' then
      begin
        IDs[0] := 4;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'FIELDS' then
      begin
        IDs[0] := 5;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'TABLE' then
      begin
        IDs[0] := 6;
        Result := S_OK;
      end;
      if AnsiUpperCase(Name) = 'REFRESH' then
      begin
        IDs[0] := 7;
        Result := S_OK;
      end;
    end;
end;

function TAppTablesObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
   Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TAppTablesObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TAppTablesObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTablesObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTablesObj');
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

{ TFieldObj }

constructor TFieldObj.Create(FldLnk: IXMLFieldType);
begin
  FFldLnk:=FldLnk;
end;

function TFieldObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  case DispID of
    1:begin
      OleVariant(VarResult^) := FFldLnk.Name;
    end;
    2:begin
      OleVariant(VarResult^) := FFldLnk.Display;
    end;
  end;
end;

function TFieldObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'FIELDNAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DISPLAYLABEL' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DATATYPE' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DATASIZE' then
      begin
        IDs[0] := 4;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'DATAWIDTH' then
      begin
        IDs[0] := 5;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'VALUE' then
      begin
        IDs[0] := 6;
        Result:=S_OK;
      end;
    end;
end;

function TFieldObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TFieldObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TFieldObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFieldObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFieldObj');
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

{ TWEBObj }

constructor TWEBObj.Create(WEBLnk: IXMLWEBPageType);
begin
  FWEBLnk:=WEBLnk;
end;

function TWEBObj.DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var dps: TDispParams; pDispIds: PDispIdList; VarResult,
  ExcepInfo, ArgErr: Pointer): HResult;
var Stream1, Stream2: TStringStream;
begin
  Result := S_OK;
  case DispID of
    1:begin
      OleVariant(VarResult^) := FWEBlnk.Name;
    end;
    2:begin
      Stream1:=TStringStream.Create(FWEBLnk.Text);
      Stream2:=TStringStream.Create('');
      Stream1.Position:=0;
      DecodeStream(Stream1,Stream2);
      Stream2.Position:=0;
      OleVariant(VarResult^) := Stream2.DataString;
      Stream1.Free;
      Stream2.Free;
    end;
    3:begin
      OleVariant(VarResult^) := FWEBLnk.Text;
    end;
  end;
end;

function TWEBObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CONTENT' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'BASE64CONTENT' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
    end;
end;

function TWEBObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TWEBObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TWEBObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TWEBObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TWEBObj');
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

{ TFormObj }

constructor TFormObj.Create(FormLnk: IXMLFormType);
begin
  FFormLnk:=FormLnk;
end;

function TFormObj.DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var dps: TDispParams; pDispIds: PDispIdList; VarResult,
  ExcepInfo, ArgErr: Pointer): HResult;
var DForm:TForm;
    Obj:IDispatch;
begin
  Result := S_OK;
  case DispID of
    1:begin
      OleVariant(VarResult^) := FFORMlnk.Name;
    end;
    2:begin
      OleVariant(VarResult^) := FFORMLnk.Caption;
    end;
    3:begin
      OleVariant(VarResult^) := FFORMLnk.Text;
    end;
    4:begin
          DForm:=TForm.Create(nil);
          DForm.Position:=poScreenCenter;
          DForm.OnKeyPress:=DM.FormKeyPress;
          DForm.KeyPreview:=true;
          DForm:=TForm(StringToComponentProc(FFORMLnk.Text,DForm));
          SetComponentHandlers(DForm, DForm);
          Obj:= IDispatch(VCLScriptControl.RegisterObject(DForm));
          OleVariant(VarResult^):= Obj;
    end;
  end;
end;

function TFormObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CAPTION' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CODE' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'CREATE' then
      begin
        IDs[0] := 4;
        Result:=S_OK;
      end;
    end;
end;

function TFormObj.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TFormObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TFormObj.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormObj');
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

{ TTestEventObj }
const
  IID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';

constructor TTestEventObj.Create;
begin
  FEvent:=nil;
end;

function TTestEventObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var Params: TDispParams;
    Result_: OleVariant;
    //rc: HResult;
    Args: PVariantArgList;
begin
  Result := S_OK;
  case DispID of
    1: begin
      if (Flags = DISPATCH_PROPERTYPUT) then
      begin
        FEvent:=IDispatch(dps.rgvarg^[pDispIds^[0]].dispVal);

      end;
    end;
    2: begin
       if FEvent<>nil then
       begin
         Params.rgdispidNamedArgs := nil;
         Params.cArgs := 1;
         Params.cNamedArgs := 0;
         GetMem(Args, sizeof(OleVariant));
         fillchar(Args^, sizeof(OleVariant), 0);
         //Params.rgvarg := nil;
         Params.rgvarg := Args;
         OleVariant(Args[0]) := IDispatch(Self);
         {rc := }FEvent.Invoke(DISPID_VALUE, IID_NULL, GetSystemDefaultLCID, DISPATCH_METHOD, Params, @Result_, nil, nil);
         if Args <> nil then
         begin
           Finalize(OleVariant(Args[0]), 1);
           FreeMem(Args, sizeof(OleVariant));
         end;
       end;
    end;
    3:begin
      OleVariant(VarResult^) := 'тестовая строка для ответа'
    end;
  end;
end;

function TTestEventObj.GetIDsOfNames(const IID: TGUID; Names: Pointer;
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
      if AnsiUpperCase(Name) = 'ONSIMPLEEVENT' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'KICK' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'TESTSTRING' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end;
    end;
end;

function TTestEventObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
 Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TTestEventObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TTestEventObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTestEventObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTestEventObj');
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

{ TModuleGroupObj }

constructor TModuleGroupObj.Create(VarLnk: IXMLModuleGroupType);
var i:integer;
begin
  FVarLnk:= VarLnk;
  i:=0;
  while VarLnk.Name<>Appconf_.Modules.Modulegroup[i].Name do Inc(i);
  FModuleCollection:=TCollectionObj.Create('modules', i);
  IDispatch(FModuleCollection)._AddRef;
end;

function TModuleGroupObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var i:integer;

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
  1:begin
   if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        OleVariant(VarResult^) := FVarLnk.Name;
      end;
   end;
   2: begin
     OleVariant(VarResult^) := FVarLnk.Visible;
   end;
   3: begin
      //OleVariant(VarResult^) := IDispatch(FFieldCollection);
      if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(FModuleCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=FModuleCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=FModuleCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;

   end;
   4: begin
      if FModIndex<>-1 then
      OleVariant(VarResult^):=FVarLnk.Module[FModIndex].Text
      else OleVariant(VarResult^):='';
   end;
  end;
end;

function TModuleGroupObj.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
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
      if AnsiUpperCase(Name) = 'NAME' then
      begin
        IDs[0] := 1;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'VISIBLE' then
      begin
        IDs[0] := 2;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'MODULES' then
      begin
        IDs[0] := 3;
        Result:=S_OK;
      end else
      begin
        FModName:='';
        FModIndex:=-1;
        for j:=0 to FVarLnk.Count - 1 do
          if AnsiUpperCase(FVarLnk.Module[j].Name)=
             AnsiUpperCase(Name)
          then
          begin
            FModName:=Name;
            FModIndex:=j;
            IDs[0] := 4;
            Result:=S_OK;
          end;
      end;
    end;
end;

function TModuleGroupObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TModuleGroupObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TModuleGroupObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormObj');
          WS := 'Не поддерживается вызов метода в качестве процедуры';
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormObj');
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
