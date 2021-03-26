unit TextUnit;

interface

uses
  Classes, ADODB, Dialogs, ConfigApp, EncdDecd, XMLIntf;

type

IEnumVariant = interface(IUnknown)
    ['{00020404-0000-0000-C000-000000000046}']
    function Next(celt: LongWord; var rgvar : OleVariant;
      pceltFetched: PLongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out Enum: IEnumVariant): HResult; stdcall;
  end;

TTextEnumerator = class(TInterfacedObject, IEnumVariant)
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


  TText = class(TInterfacedObject, IDispatch)
  private
    FLines: TStringList;
    FPages:IXMLWEBPagesType;
    FProp: String;
  protected
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(WEBPages:IXMLWEBPagesType; TextString:String);
  end;

implementation

uses
  ActiveX, Windows, SysUtils, StrUtils;
{ TText }

constructor TText.Create(WEBPages:IXMLWEBPagesType; TextString:String);
begin
  FLines:=TStringList.Create;
  FLines.Text := TextString;
  FPages:=WEBPages;
end;

function TText.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      FProp := Name;
      IDs[0] := 1;
      if UpperCase(Name) = 'COUNT' then IDs[0] := 2;
      if UpperCase(Name) = 'SAVETOFILE' then IDs[0] := 3;
      if UpperCase(Name) = 'SAVEASWEBOBJECT' then IDs[0] := 4;
    end;
end;

function TText.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
   Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TText.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

const
  VARIANT_ALPHABOOL = 2;
  VARIANT_LOCALBOOL = 16;

function TText.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  P: TDISPPARAMS absolute Params;
  V: OleVariant;
  WebName:String;
  FIndFlag:boolean;
  i:integer;
  curPage:IXMLWEBPageType;
  Stream1,Stream2:TStringStream;
begin
  if (DispID = 1) and (Flags and DISPATCH_PROPERTYPUT<>0) then
    begin
      Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
      if Result <> S_OK then exit;
      FLines.Text:=AnsiReplaceStr(FLines.Text,'['+FProp+']',String(V));
    end
  else
  if (DispID = 2) then
  begin
    OleVariant(VarResult^):=FLines.Count;
  end else
  if (DispID = 3) then
  begin
    if P.cArgs=1 then
    begin
      Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
      if Result <> S_OK then exit;
      FLines.SaveToFile(String(V));
    end;
  end else
  if (DispID = 4) then
  begin
    Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
    if Result <> S_OK then exit;
    WebName:=String(V);
    for i := 0 to FPages.Count - 1 do
    begin
      FindFlag:=false;
      if AnsiUpperCase(WebName)=AnsiUpperCase(FPages.WEBPage[i].Name) then
      begin
        curPage:=FPages.WEBPage[i];
        FindFlag:=true;
      end;
    end;
    if not FindFlag then curPage:=FPages.Add;
      Stream1:=TStringStream.Create(Flines.Text);
      Stream2:=TStringStream.Create('');
      Stream1.Position:=0;
      EncodeStream(Stream1, Stream2);
      Stream2.Position:=0;
      if FindFlag then
        curPage.Text:=Stream2.DataString
      else
      begin
        curPage.Name:=WebName;
        curPage.ChildNodes.Add(curPage.OwnerDocument.CreateNode(Stream2.DataString,ntCData));
      end;
      Stream1.Free;
      Stream2.Free;
  end else
  if (DispID = DISPID_VALUE) then
  begin
    if (Flags and DISPATCH_PROPERTYPUT<>0) then
    begin
      Result := VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_BSTR);
      FLines.Text := String(V);
    end else
    begin
      if P.cArgs=0 then
        OleVariant(VarResult^):= FLines.Text;
      if P.cArgs=1 then
      begin
        VariantChangeType(V, OleVariant(P.rgvarg[0]), VARIANT_ALPHABOOL or VARIANT_LOCALBOOL, VT_I2);
        OleVariant(VarResult^):=FLines[Integer(V)];
      end;
    end;
  end else
  if Dispid=DISPID_NEWENUM then
  begin
    OleVariant(VarResult^) := TTextEnumerator.Create(FLines) as IEnumVariant;
  end
  else
  if DispID = DISPID_DESTRUCTOR then
  begin
     FLines.Free;
  end else
  Result := DISP_E_MEMBERNOTFOUND;
end;



{ TTextEnumerator }

function TTextEnumerator.Clone(out Enum: IEnumVariant): HResult;
var
  NewEnum: TTextEnumerator;
begin
  NewEnum := TTextEnumerator.Create(FOwner);
  NewEnum.FEnumPosition := FEnumPosition;
  Enum := NewEnum as IEnumVariant;
  Result := S_OK;
end;

constructor TTextEnumerator.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FEnumPosition := 0;
end;

function TTextEnumerator.Next(celt: LongWord; var rgvar: OleVariant;
  pceltFetched: PLongWord): HResult;
var
  III: Cardinal;
begin
  Result := S_OK;
  III := 0;
  if FOwner is TStringList then
  begin
    with TStringList(FOwner) do
    begin
      while (FEnumPosition < Count) and (III < celt) do begin
        TVariantList(rgvar)[III] := TStringList(FOwner)[FEnumPosition];
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

function TTextEnumerator.Reset: HResult;
begin
  FEnumPosition := 0;
  Result := S_OK;
end;

function TTextEnumerator.Skip(celt: LongWord): HResult;
var
  Total: Integer;
begin
  if FOwner is TStringList then
    Total := TStringList(FOwner).Count
  else
    Exit;
  if FEnumPosition + celt <= Total then begin
    Result := S_OK;
    Inc(FEnumPosition, celt)
  end;
end;

end.
