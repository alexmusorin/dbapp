unit displist;

interface

uses
  Classes, Contnrs, ActiveX;

type
  TVar = class
  private
    FVarKind: TVarKind;
    FValue: OleVariant;
    FMemID: TMemberID;
    FVarType: TVarType;
    FName: string;
  public
    property VarKind: TVarKind read FVarKind;
    property MemID: TMemberID read FMemID;
    property VarType: TVarType read FVarType;
    property Value: OleVariant read FValue;
    property Name: string read FName;
  end;

  TVarList = class(TObjectList)
  private
    function GetItem(Index: integer): TVar;
  public
    constructor Create;
    procedure FillFromTypeInfo(const ti: ITypeInfo);
    procedure ToStrings(Strings: TStrings);
    property Items[Index: integer]: TVar read GetItem; default;
  end;

  TParam = class
  private
    FValue: string;
    FName: string;
  public
    property Name: string read FName;
    property Value: string read FValue write FValue;
  end;

  TParamList = class(TObjectList)
  private
    function GetItem(Index: integer): TParam;
  public
    constructor Create;
    property Items[Index: integer]: TParam read GetItem; default;
    procedure ToStrings(Strings: TStrings);
  end;

  TFunc = class
  private
    FName: string;
    FMemID: TMemberID;
    FVarType: TVarType;
    FParams: TParamList;
  public
    constructor Create;
    destructor Destroy; override;
    property MemID: TMemberID read FMemID;
    property VarType: TVarType read FVarType;
    property Name: string read FName;
    property Params: TParamList read FParams;
  end;

  TFuncList = class(TObjectList)
  private
    function GetItem(Index: integer): TFunc;
  public
    constructor Create;
    property Items[Index: integer]: TFunc read GetItem; default;
    procedure FillFromTypeInfo(const ti: ITypeInfo);
    procedure ToStrings(Strings: TStrings);
    function GetItemByName(FuncName:String): TFunc;
  end;

function VarTypeToString(vt: TVarType): string;

implementation

uses
  SysUtils;
  
function VarTypeToString(vt: TVarType): string;
const
  VT_0_14: array[0..14] of PChar = (
    'VT_EMPTY',
    'VT_NULL',
    'VT_I2',
    'VT_I4',
    'VT_R4',
    'VT_R8',
    'VT_CY',
    'VT_DATE',
    'VT_BSTR',
    'VT_DISPATCH',
    'VT_ERROR',
    'VT_BOOL',
    'VT_VARIANT',
    'VT_UNKNOWN',
    'VT_DECIMAL'
  );
  VT_16_31: array[16..31] of PChar = (
    'VT_I1',
    'VT_UI1',
    'VT_UI2',
    'VT_UI4',
    'VT_I8',
    'VT_UI8',
    'VT_INT',
    'VT_UINT',
    'VT_VOID',
    'VT_HRESULT',
    'VT_PTR',
    'VT_SAFEARRAY',
    'VT_CARRAY',
    'VT_USERDEFINED',
    'VT_LPSTR',
    'VT_LPWSTR'
  );
  VT_64_72: array[64..72] of PChar = (
    'VT_FILETIME',
    'VT_BLOB',
    'VT_STREAM',
    'VT_STORAGE',
    'VT_STREAMED_OBJECT',
    'VT_STORED_OBJECT',
    'VT_BLOB_OBJECT',
    'VT_CF',
    'VT_CLSID'
  );
  VT_73_76: array[73..76] of PChar = (
    'VT_STREAMED_PROPSET',
    'VT_STORED_PROPSET',
    'VT_BLOB_PROPSET',
    'VT_VERBOSE_ENUM'
  );
begin
  if vt and VT_TYPEMASK in  [0..14] then Result := VT_0_14[vt and VT_TYPEMASK]
  else if vt and VT_TYPEMASK in [16..31] then Result := VT_16_31[vt and VT_TYPEMASK]
  else if vt and VT_TYPEMASK in [64..72] then Result := VT_64_72[vt and VT_TYPEMASK]
  else if vt and VT_TYPEMASK in [73..76] then Result := VT_73_76[vt and VT_TYPEMASK]
  else Result := Format('0x%.4x', [vt and VT_TYPEMASK]);
  if (vt and not VT_TYPEMASK <> 0) and (Result <> '')
    then Result := Result + ' | ';
  case vt and not VT_TYPEMASK of
    0:;
    VT_VECTOR: Result := Result + 'VT_VETOR';
    VT_ARRAY: Result := Result + 'VT_ARRAY';
    VT_BYREF: Result := Result + 'VT_BYREF';
  else
    Result := Result + Format('0x%.4x', [vt and not VT_TYPEMASK]);
  end;
end;

{ TVarList }

constructor TVarList.Create;
begin
  inherited Create(true);
end;

procedure TVarList.FillFromTypeInfo(const ti: ITypeInfo);
var
  ta: PTypeAttr;
  vd: PVarDesc;
  i: integer;
  Name: WideString;
  NameCount: integer;
  V: TVar;
begin
  Clear;
  if ti = nil then exit;
  ti.GetTypeAttr(ta);
  for i := 0 to ta.cVars - 1 do
    begin
      ti.GetVarDesc(i, vd);
      ti.GetNames(vd.memid, @Name, 1, NameCount);
      V := TVar.Create;
      V.FMemID := vd.memid;
      V.FVarKind := vd.varkind;
      V.FName := Name;
      V.FVarType := vd.elemdescVar.tdesc.vt;
      if V.FVarKind = VAR_CONST then V.FValue := vd.lpvarValue^;
      Name := '';
      ti.ReleaseVarDesc(vd);
      Add(V);
    end;
  ti.ReleaseTypeAttr(ta);
end;

function TVarList.GetItem(Index: integer): TVar;
begin
  Result := inherited Items[Index] as TVar;
end;

procedure TVarList.ToStrings(Strings: TStrings);
var
  i: integer;
begin
  Strings.Clear;
  for i := 0 to Count - 1 do
    Strings.Add(Items[i].FName);
end;

{ TFuncList }

constructor TFuncList.Create;
begin
  inherited Create(true);
end;

procedure TFuncList.FillFromTypeInfo(const ti: ITypeInfo);
var
  ta: PTypeAttr;
  fd: PFuncDesc;
  i, j: integer;
  Names: PWideString;
  MemSize,
  MaxNames,
  NameCount: integer;
  F: TFunc;
  P: TParam;
begin
  Clear;
  if ti = nil then exit;
  ti.GetTypeAttr(ta);
  for i := 0 to ta.cFuncs - 1 do
    begin
      ti.GetFuncDesc(i, fd);
      MaxNames := fd.cParams+1;
      MemSize := MaxNames*sizeof(WideString);
      F := TFunc.Create;
      F.FMemID := fd.memid;
      F.FVarType := fd.elemdescFunc.tdesc.vt;
      GetMem(Names, MemSize);
      fillchar(Names^, MemSize, 0);
      ti.GetNames(fd.memid, PBStrList(Names), MaxNames, NameCount);
      F.FName := PBStrList(Names)[0];
      for j := 1 to fd.cParams do
        begin
          P := TParam.Create;
          P.FName := PBStrList(Names)[j];
          F.Params.Add(P);
        end;
      Finalize(Names^, MaxNames);
      FreeMem(Names, MemSize);
      ti.ReleaseFuncDesc(fd);
      Add(F);
    end;
  ti.ReleaseTypeAttr(ta);
end;

function TFuncList.GetItem(Index: integer): TFunc;
begin
  Result := inherited Items[Index] as TFunc;
end;

function TFuncList.GetItemByName(FuncName: String): TFunc;
var i:integer;
begin
  Result:=nil;
  for i := 0 to Count-1 do
    if UpperCase(Items[i].Name)=UpperCase(FuncName) then Result:=Items[i];
end;

procedure TFuncList.ToStrings(Strings: TStrings);
var
  i: integer;
begin
  Strings.Clear;
  for i := 0 to Count - 1 do
    Strings.Add(Items[i].FName);
end;

{ TParamList }

constructor TParamList.Create;
begin
  inherited Create(true);
end;

function TParamList.GetItem(Index: integer): TParam;
begin
  Result := inherited Items[Index] as TParam;
end;

procedure TParamList.ToStrings(Strings: TStrings);
var
  i: integer;
begin
  Strings.Clear;
  for i := 0 to Count - 1 do
    Strings.Add(Items[i].FName);
end;

{ TFunc }

constructor TFunc.Create;
begin
  inherited Create;
  FParams := TParamList.Create;
end;

destructor TFunc.Destroy;
begin
  FParams.Free;
  inherited Destroy;
end;

end.
