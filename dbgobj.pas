unit dbgobj;

interface

uses
  Classes, ComCtrls;

type
  TDebug = class(TInterfacedObject, IDispatch)
  private
    FLines: TStrings;
    FListView:TListView;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(ALines: TStrings; AListView: TListView);
  end;

implementation

uses
  ActiveX, Windows, SysUtils, UnitCP;

{ TDebug }

const
  DISPID_PRINT = 1;
  DISPID_ERROR = 2;
  DISPID_WARNING = 3;
  DISPID_INFO = 4;
  DISPID_CLEARTEXT = 5;
  DISPID_CLEARMESSAGES = 6;
  DISPID_PROPERTYS = 7;

constructor TDebug.Create(ALines: TStrings; AListView: TListView);
begin
  inherited Create;
  FLines := ALines;
  FListView := AListView;
end;

function TDebug.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if UpperCase(Name) = 'PRINT' then IDs[0] := DISPID_PRINT
      else if UpperCase(Name) = 'ERROR' then IDs[0] := DISPID_ERROR
      else if UpperCase(Name) = 'WARNING' then IDs[0] := DISPID_WARNING
      else if UpperCase(Name) = 'INFO' then IDs[0] := DISPID_INFO
      else if UpperCase(Name) = 'CLEARTEXT' then IDs[0] := DISPID_CLEARTEXT
      else if UpperCase(Name) = 'CLEARMESSAGES' then IDs[0] := DISPID_CLEARMESSAGES
      else if UpperCase(Name) = 'PROPERTYS' then IDs[0] := DISPID_PROPERTYS
      else Result := DISP_E_UNKNOWNNAME;
    end;
end;

function TDebug.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TDebug.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

const
  VARIANT_ALPHABOOL = 2;
  VARIANT_LOCALBOOL = 16;
  
function TDebug.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  P: TDISPPARAMS absolute Params;
  i: integer;
  S: string;
  V: OleVariant;
  PropList: TStringList;
begin
  {if (DispID = DISPID_PRINT) and (Flags = DISPATCH_METHOD) then
    begin
      S := '';
      for i := P.cArgs - 1 downto 0 do
        begin
          Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
          if Result <> S_OK then exit;
          if S <> '' then S := S + ' ';
          S := S + V;
        end;
      FLines.Add(S);
      Result := S_OK;
    end
  else Result := DISP_E_MEMBERNOTFOUND;}
  if (DispID = DISPID_PRINT) and (Flags = DISPATCH_METHOD) then
    begin
      S := '';
      for i := P.cArgs - 1 downto 0 do
        begin
          Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
          if Result <> S_OK then exit;
          if S <> '' then S := S + ' ';
          S := S + V;
        end;
      FLines.Add(S);
      Result := S_OK;
    end
  else
  if (DispID = DISPID_ERROR) and (Flags = DISPATCH_METHOD) then
    begin
      S := '';
      for i := P.cArgs - 1 downto 0 do
        begin
          Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
          if Result <> S_OK then exit;
          if S <> '' then S := S + ' ';
          S := S + V;
        end;
      with FListView.Items.Add do
      begin
        Caption:='система';
        StateIndex:=0;
        ImageIndex:=-1;
        SubItems.Add(S);
      end;
      Result := S_OK;
    end
  else
  if (DispID = DISPID_WARNING) and (Flags = DISPATCH_METHOD) then
    begin
      S := '';
      for i := P.cArgs - 1 downto 0 do
        begin
          Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
          if Result <> S_OK then exit;
          if S <> '' then S := S + ' ';
          S := S + V;
        end;
      with FListView.Items.Add do
      begin
        Caption:='система';
        StateIndex:=2;
        ImageIndex:=-1;
        SubItems.Add(S);
      end;
      Result := S_OK;
    end
  else
  if (DispID = DISPID_INFO) and (Flags = DISPATCH_METHOD) then
    begin
      S := '';
      for i := P.cArgs - 1 downto 0 do
        begin
          Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
          if Result <> S_OK then exit;
          if S <> '' then S := S + ' ';
          S := S + V;
        end;
      with FListView.Items.Add do
      begin
        Caption:='система';
        StateIndex:=1;
        ImageIndex:=-1;
        SubItems.Add(S);
      end;
      Result := S_OK;
    end
  else
  if (DispID = DISPID_CLEARTEXT) and (Flags = DISPATCH_METHOD) then
    begin
      Flines.Clear;
    end else
  if (DispID = DISPID_CLEARMESSAGES) and (Flags = DISPATCH_METHOD) then
    begin
      FListView.Items.Clear;
    end else
  if (DispID = DISPID_VALUE) then
  begin

    Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    FLines.Add(V);
  end else
  if (DispID = DISPID_PROPERTYS) then
  begin
    PropList:= TStringList.Create;
    Result := VariantChangeType(V, OleVariant(P.rgvarg[i]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    GetClassProperty2(String(V), PropList);
    FLines.Add(PropList.Text);
  end else
  Result := DISP_E_MEMBERNOTFOUND;
end;

end.
