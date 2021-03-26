unit DataUnit;

interface

uses
  SysUtils, Classes,  ADODB, ChildWin, Forms, Variants, Windows, LinkTableUnit, DialogDB,
  StdCtrls, ExtCtrls, ScriptE, dbgobj, Scripts, ActiveX, ComCtrls, TableObj, QueryUnit, ConfigApp,
  SelectDBUnit, Dialogs, {SQLDialogUnit,} DB, TextUnit, ImgList, Controls, ComObj, ReportFormUnit, EncdDecd,
  BrowserFormUnit, ReportObj, IntfDocHostUIHandler, UNulContainer, SHDocVw, ConfIEProtocol, StrUtils, HTTPApp, UnitMyForm,
  IdBaseComponent, IdComponent, xmlbrowserdata, IdTCPServer, IdCustomHTTPServer, IdHTTPServer, ZLib, IdContext, addons,
  SynMemo, CodeObj, appobjects, IdHTTP, IdSSL, IdSSLOpenSSL, idMultipartFormData;

type

  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    ADOQuery1: TADOQuery;
    OpenDialog1: TOpenDialog;
    ADOCommand1: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DataModuleDestroy(Sender: TObject);
    procedure IdHTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
    fAction:String;
  public
    { Public declarations }
    RequestStr: TStringList;
    ResponseStr: TStringList;
    dHTTPServer: TIdHTTPServer;
    procedure ExecuteScript(Code:String);
    procedure ExecuteScriptInEditor(Code:String; CodeMemo:TSynMemo);
    procedure ExecuteScriptForForm(Code: String;const SourceComponent: TComponent);
    procedure ExecuteAddOn(Code: String; const Memo :TSynMemo; const TableName:String);
    procedure TerminateScript;
    procedure BeginDebug(Code:String; AppName:String);
    procedure GetPageNames(AString: TStrings);
    procedure OpenDB(FileName:String);
    procedure BrowserURLLoadHandler(URL: String; Stream: TStream);
  end;

TExternalContainer = class(TNulWBContainer, IDocHostUIHandler, IOleClientSite)
  private
    fExternalObj: IDispatch;  // external object implementation
  protected
    { Re-implemented IDocHostUIHandler method }
    function GetExternal(out ppDispatch: IDispatch): HResult; stdcall;
  public
    constructor Create(const HostedBrowser: TWebBrowser);
  end;

TApp = class(TInterfacedObject, IDispatch)
  private
    FPropName:string;
    FModName:string;
    FTableName:string;
    FFormName:String;
    fContainer: TExternalContainer;
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

TQueryFactory = class(TInterfacedObject, IDispatch)
  private
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

TFormFactory = class(TInterfacedObject, IDispatch)
  private
    FFormStyle:TFormStyle;
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
    constructor Create(FormStyle:TFormStyle);
  end;

TLinkFactory = class(TInterfacedObject, IDispatch)
  private
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

TReportFactory = class(TInterfacedObject, IDispatch)
  private
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

TVKAPI = class(TInterfacedObject, IDispatch)
  private
    FURL:String;
    FFileName:String;
    FidHTTP:TIdHTTP;
    FidSSLSocket: TidSSLIOHandlerSocketOpenSSL;
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

TTextDocumentFactory = class(TInterfacedObject, IDispatch)
  private
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

TExternalObj = class(TInterfacedObject, IDispatch)
  private
    FPropName: string;
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

TResponseObj = class(TInterfacedObject, IDispatch)
  private
    FLines: TStrings;
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
    constructor Create(ALines:TStrings);
  end;

TRequestObj = class(TInterfacedObject, IDispatch)
  private
    FLines: TStrings;
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
    constructor Create(ALines:TStrings);
  end;


EBadCallEE=class(Exception)

end;


var
  DM: TDM;
  VCLScriptControl:TVCLScriptControl;
  VCLScriptControlDebug:TVCLScriptControlDebug;
  Child: TMDIChild;
  TableList:TStringList;
  AppConf_:IXMLConfigurationType;
  Addons_:IXMLAddonsType;
  AppObjects_:IXMLClassesType;
  DDBForm:TDialogDBForm;

const
  DISPID_SHOWTABLE   = 1;
  DISPID_WORKDIR     = 2;
  DISPID_CONSTANT    = 3;
  DISPID_MAXIMIZEALL = 4;
  DISPID_LINKTO      = 5;
  DISPID_MODULES     = 6;
  DISPID_GETFILENAME = 7;
  DISPID_SQLDIALOG   = 8;
  DISPID_STRING      = 9;
  DISPID_COMPACTDB   = 10;
  DISPID_CLOSEALL    = 11;
  DISPID_SAVECONF    = 12;
  DISPID_WEB         = 13;
  DISPID_RUNSCRIPT   = 14;
  DISPID_QUERYSTRING = 300;
  DISPID_WRITE       = 301;
  DISPID_STARTSERVER = 302;
  DISPID_STOPSERVER  = 303;
  DISPID_PORT        = 304;
  DISPID_DBTABLES    = 305;
  DISPID_VARIABLES   = 306;
  DISPID_TABLES      = 307;
  DISPID_WEBOBJECTS  = 308;
  DISPID_FORMS       = 309;
  DISPID_TERMINATE   = 310;
  DISPID_NOCONFIGURE = 311;
  DISPID_CLOSETABLE  = 312;
  DISPID_ACTIONSTRING = 313;
  

function StringToComponentProc(Value: string; Panel_:TComponent): TComponent;
procedure SetComponentHandlers(const SourceComponent: TComponent; const parentForm: TForm);
procedure copyXmlNode(sourse:String; dest: IXMLClassType);
function DisplayLabel(FieldName:String):String;
procedure ExecuteScript(Group, Module: String);


implementation

uses main, XMLIntf,  TestFormUnit, CollectionUnit, AppObjectsUnit, SQLDialogUnit, Messages;

procedure ExecuteScript(Group, Module: String);
var i,j:integer;
begin
  if Assigned(AppConf_) then

  for i := 0 to AppConf_.Modules.Count-1 do
    if AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Name)=
       AnsiUpperCase(Group) then
       for j := 0 to AppConf_.Modules.Modulegroup[i].Count - 1 do
           if AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Module[j].Name)=
              AnsiUpperCase(Module) then
              begin
                DM.ExecuteScript(AppConf_.Modules.Modulegroup[i].Module[j].Text);
                Exit;
              end;
end;


function DisplayLabel(FieldName:String):String;
var j,i:integer;
    ResOut:string;
begin
   ResOut:='поле таблицы';
   for i := 0 to AppConf_.Tables.Count - 1 do
   begin
     for j := 0 to AppConf_.Tables.Table[i].Fields.Count - 1 do
        if AppConf_.Tables.Table[i].Fields.Field[j].Name=FieldName then
        begin
           ResOut:=AppConf_.Tables.Table[i].Fields.Field[j].Display;
           Break;
        end;
     if ResOut<>'поле таблицы' then Break;

   end;
  Result:=ResOut;      
end;

procedure copyXmlNode(sourse:String; dest: IXMLClassType);
var i:integer;
    temp:IXMLClassType;
begin
  temp:=nil;
  for i := 0 to AppObjects_.Count - 1 do
    if AppObjects_.Class_[i].Name = sourse then temp:= AppObjects_.Class_[i];
  if temp<>nil then
    for i := 0 to temp.Count - 1 do
    with dest.Add do
    begin
      Name:=temp.Classitem[i].Name;
      Type_:=temp.Classitem[i].Type_;
      Param:=temp.Classitem[i].Param;
      returnvalue:=temp.Classitem[i].Returnvalue;
      Text:=temp.Classitem[i].Text;
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


var
 DBTablesCollection:TCollectionObj;
 VariablesCollection:TCollectionObj;
 ModulesCollection:TCollectionObj;
 TablesCollection:TCollectionObj;
 WebObjectsCollection:TCollectionObj;
 FormsCollection:TCollectionObj;

const
  is_code = 1;
  is_smallcode = 2;
  is_plaintext = 0;

function ParseASP(ASPCode:string):String;
var i:integer;
    State:integer;
    TTest:String;
begin
   i:=1;
 State:=is_plaintext;
 TTest:='Response.Write "';
 while i<Length(ASPCode)-1 do
 begin
   if Copy(ASPCode,i,3)='<%=' then
   begin
     State:=is_smallcode;
     i:=i+3;
     TTest:=TTest+'" & ';
   end;
   if Copy(ASPCode,i,2)='<%' then
   begin
     State:=is_code;
     i:=i+2;
     TTest:=TTest+'"'#13#10;
   end;

   if Copy(ASPCode,i,2)='%>' then
   begin
     if State=is_smallcode then
        TTest:=TTest+' & "'
     else TTest:=TTest+#13#10'Response.write "';
     State:=is_plaintext;
     i:=i+2;
   end;
   if Copy(ASPCode,i,2)<>#13#10 then
   begin
     TTest:=TTest+Copy(ASPCode,i,1);
     if (Copy(ASPCode,i,1)='"') and (State=is_Plaintext)  then
     TTest:=TTest+'"';

     i:=i+1;
   end
   else
   begin
     if State=is_plaintext then TTest:=TTest+'"'#13#10'Response.Write "';
     if State=is_code then TTest:=TTest+#13#10;
     i:=i+2;
   end;
 end;
Result:=TTest+'"';
end;

procedure CompactDatabase_JRO(DatabaseName: string; DestDatabaseName: string =
  ''; Password: string = '');
const
  Provider = 'Provider=Microsoft.Jet.OLEDB.4.0;';
var
  TempName: array[0..MAX_PATH] of Char; // имя временного файла
  TempPath: string; // путь до него
  Name: string;
  Src, Dest: WideString;
  V: Variant;
begin
  try
    Src := Provider + 'Data Source=' + DatabaseName;
    if DestDatabaseName <> '' then
      Name := DestDatabaseName
    else
    begin
      // выходная база не указана - используем временный файл
      // получаем путь для временного файла
      TempPath := ExtractFilePath(DatabaseName);
      if TempPath = '' then
        TempPath := GetCurrentDir;
      //получаем имя временного файла
      GetTempFileName(PChar(TempPath), 'mdb', 0, TempName);
      Name := StrPas(TempName);
    end;
    DeleteFile(PChar(Name)); // этого файла не должно существовать :))
    Dest := Provider + 'Data Source=' + Name;
    if Password <> '' then
    begin
      Src := Src + ';Jet OLEDB:Database Password=' + Password;
      Dest := Dest + ';Jet OLEDB:Database Password=' + Password;
    end;

    V := CreateOleObject('jro.JetEngine');
    try
      V.CompactDatabase(Src, Dest); // сжимаем
    finally
      V := 0;
    end;
    if DestDatabaseName = '' then
    begin // т.к. выходная база не указана
      DeleteFile(PChar(DatabaseName)); //то удаляем не упакованную базу
      RenameFile(Name, DatabaseName); // и переименовываем упакованную базу
    end;
  except
    // выдаем сообщение об исключительной ситуации
    on E: Exception do
      ShowMessage('Ошибка упаковки БД '+e.message);
  end;
end;

function StringToComponentProc(Value: string; Panel_:TComponent): TComponent;
var
  StrStream:TStringStream;
  BinStream: TMemoryStream;
begin
  StrStream := TStringStream.Create(Value);
  try
    BinStream := TMemoryStream.Create;
    try
      ObjectTextToBinary(StrStream, BinStream);
      BinStream.Seek(0, soFromBeginning);
      Result:= BinStream.ReadComponent(Panel_);
    finally
      BinStream.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

procedure SetComponentHandlers(const SourceComponent: TComponent; const parentForm: TForm);
var i:integer;
begin
  for i := 0 to SourceComponent.ComponentCount - 1 do
  begin
    VCLScriptControl.RegisterClass(SourceComponent.Components[i].Name,SourceComponent.Components[i]);
    //TWinControl(SourceComponent.Components[i]).Parent:=parentForm;
    VCLScriptControl.SetHandler(SourceComponent.Components[i], MainForm, 'onClick');
    VCLScriptControl.SetHandler(SourceComponent.Components[i], MainForm, 'onChange');
    VCLScriptControl.SetHandler(SourceComponent.Components[i], MainForm, 'onEnter');
    VCLScriptControl.SetHandler(SourceComponent.Components[i], MainForm, 'onExit');
    SetComponentHandlers(SourceComponent.Components[i], parentForm);
  end;
end;





{$R *.dfm}

{ TDM }

procedure TDM.BeginDebug(Code: String; AppName:string);
  var
  Language: TScriptLanguage;
  i:integer;
begin
  VCLScriptControlDebug.CanDebug :=true;
  VCLScriptControlDebug.AppName:=AppName;
  Language := TScriptLanguage(0);
  VCLScriptControlDebug.CreateScriptEngine(Language);
  if DBTablesCollection<>nil then IDispatch(DBTablesCollection)._Release;
  DBTablesCollection:=TCollectionObj.Create('dbtables');
  IDispatch(DBTablesCollection)._AddRef;
  if VariablesCollection<>nil then IDispatch(VariablesCollection)._Release;
  VariablesCollection:=TCollectionObj.Create('variables');
  IDispatch(VariablesCollection)._AddRef;
  if ModulesCollection<>nil then IDispatch(ModulesCollection)._Release;
  ModulesCollection:=TCollectionObj.Create('modules');
  IDispatch(ModulesCollection)._AddRef;
  if TablesCollection<>nil then IDispatch(TablesCollection)._Release;
  TablesCollection:=TCollectionObj.Create('tables');
  IDispatch(TablesCollection)._AddRef;
  if WebObjectsCollection<>nil then IDispatch(WebObjectsCollection)._Release;
  WebObjectsCollection:=TCollectionObj.Create('webobjects');
  IDispatch(WebObjectsCollection)._AddRef;
  if FormsCollection<>nil then IDispatch(FormsCollection)._Release;
  FormsCollection:=TCollectionObj.Create('forms');
  IDispatch(FormsCollection)._AddRef;
  VCLScriptControl.RegisterClass('App',TApp.Create);
  VCLScriptControlDebug.RegisterClass('Debug',TDebug.Create(MainForm.Memo1.Lines,MainForm.ListView1));
  for i := 0 to TableList.Count- 1 do
  begin
    VCLScriptControlDebug.RegisterClass(TableList[i],TTableObj.Create(TADOTable(TableList.Objects[i])));
  end;
  VCLScriptControlDebug.RegisterClass('Dict',TDBDialogObj.Create(DDBForm));
  VCLScriptControlDebug.RegisterClass('Query',TQueryFactory.Create);
  VCLScriptControlDebug.RegisterClass('Form',TFormFactory.Create(fsNormal));
  VCLScriptControlDebug.RegisterClass('MDIForm',TFormFactory.Create(fsMDIChild));
  VCLScriptControlDebug.RegisterClass('LinkTo',TLinkFactory.Create);
  VCLScriptControlDebug.RegisterClass('Report',TReportFactory.Create);
  VCLScriptControlDebug.RegisterClass('TextDocument',TTextDocumentFactory.Create);
  VCLScriptControlDebug.RegisterClass('WorkPanel',MainForm.WorkPanel);
  VCLScriptControlDebug.RegisterClass('Request',TRequestObj.Create(RequestStr));
  VCLScriptControlDebug.RegisterClass('Response',TResponseObj.Create(ResponseStr));
  VCLScriptControlDebug.RegisterClass('TestObject',TTestEventObj.Create);
  VCLScriptControlDebug.BreakOnStart:=true;
  VCLScriptControlDebug.DebugScript(Code);
  VCLScriptControlDebug.CanDebug :=false;
end;


procedure TDM.BrowserURLLoadHandler(URL: String; Stream: TStream);
var i:integer;
    Stream1,Stream2:TStringStream;
    FindFlag:boolean;
    ReqStr:String;
    ReqHTML:String;

function FileName:string;
begin
      // when loading from file, URL is page.htm/[image.xxx]
      Result := AnsiReplaceStr(URL, '/', '\');
      //MainForm.Memo1.Lines.Add(URL);
      if Result[Length(Result)] = '\' then Result := LeftStr(Result, Length(Result) - 1);
      if Pos('?',Result)<>0 then
      begin
        ReqStr:=RightStr(Result,Length(Result)-Pos('?',Result));
        ReqStr:=AnsiReplaceStr(ReqStr,'&',#13#10);
        RequestStr.Text:=HTTPDecode(ReqStr);
        Result:=LeftStr(Result, Pos('?',Result)-1);
      end;
      Result := ExtractFileName(Result);
end;



begin
   FindFlag:=false;
   for i := 0 to AppConf_.WEBPages.Count - 1 do
   begin
     if AnsiUpperCase(AppConf_.WEBPages.WEBPage[i].Name)=AnsiUpperCase(filename) then
     begin
       if AnsiUpperCase(ExtractFileExt(filename))<>'.ASP' then
       begin
         Stream1:=TStringStream.Create(AppConf_.WEBPages.WEBPage[i].Text);
         Stream1.Position:=0;
         DecodeStream(Stream1,Stream);
         Stream.Position:=0;
       end else
       begin
         Stream1:=TStringStream.Create(AppConf_.WEBPages.WEBPage[i].Text);
         Stream1.Position:=0;
         Stream2:=TStringStream.Create('');
         DecodeStream(Stream1,Stream2);
         Stream2.Position:=0;
         ResponseStr.Clear;
         //MainForm.Memo1.Lines.Text := ParseASP(Stream2.DataString+'  ');
         ExecuteScript(ParseASP(Stream2.DataString+'  '));
         //MainForm.Memo1.Lines.Text := ResponseStr.Text;
         TStringStream(Stream).WriteString(ResponseStr.Text);
         Stream.Position:=0;
       end;
       FindFlag:=true;
     end;
   end;
   if not FindFlag then
   begin
     ReqHTML:='<h3>список переменных</h3><ul>';
     for i := 0 to RequestStr.Count - 1 do
       ReqHTML:=ReqHTML+'<li>'+RequestStr[i]+'</li>';
     ReqHTML:=ReqHTML+'</ul>';
       
     TStringStream(Stream).WriteString(AnsiReplaceStr('<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"><title>404 страница</title></head><body><H1>Страница не найдена (404 ошибка)</H1><p>страница <b>#ADR#</b> еще не создана</p>'+
                                                      '</body></html>','#ADR#',filename+' '+ReqHTML));
     Stream.Position:=0;
   end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  VCLScriptControl:=TVCLScriptControl.Create(MainForm);
  VCLScriptControl.WinHandle:=MainForm.Handle;
  VCLScriptControl.ListView:=MainForm.ListView1;
  VCLScriptControlDebug:= TVCLScriptControlDebug.Create(MainForm);
  VCLScriptControlDebug.WinHandle:=MainForm.Handle;
  TableList:=TStringList.Create;
  DDBForm:=TDialogDBForm.Create(application);
  DDBForm.Connection:=DM.ADOConnection1;
  RegisterMyProtocol;
  SetBrowserURLLoadHandler(BrowserURLLoadHandler);
  RequestStr:=TStringList.Create;
  ResponseStr := TStringList.Create;
  dHTTPServer := TIdHTTPServer.Create(Application);
  //dHTTPServer.DefaultPort:= 8080;
  dHTTPServer.OnCommandGet:=IdHTTPServerCommandGet;
  //dHTTPServer.Active:=true;
  MainForm.StatusBar.Panels[3].Text:='Server OFF';
  if FileExists('addons.xml') then addons_:=loadaddons('addons.xml');
  if FileExists('mdiappobj.xml') then
  begin
    AppObjects_:=Loadclasses('mdiappobj.xml');
  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  UnregisterMyProtocol;
end;

procedure TDM.ExecuteAddOn(Code: String; const Memo: TSynMemo; const tableName:string);
var
  Language: TScriptLanguage;
begin
  Language := TScriptLanguage(0);
  VCLScriptControl.CreateScriptEngine(Language);
  if DBTablesCollection<>nil then IDispatch(DBTablesCollection)._Release;
  DBTablesCollection:=TCollectionObj.Create('dbtables');
  IDispatch(DBTablesCollection)._AddRef;
  if VariablesCollection<>nil then IDispatch(VariablesCollection)._Release;
  VariablesCollection:=TCollectionObj.Create('variables');
  IDispatch(VariablesCollection)._AddRef;
  if ModulesCollection<>nil then IDispatch(ModulesCollection)._Release;
  ModulesCollection:=TCollectionObj.Create('modulegroups');
  IDispatch(ModulesCollection)._AddRef;
  if TablesCollection<>nil then IDispatch(TablesCollection)._Release;
  TablesCollection:=TCollectionObj.Create('tables');
  IDispatch(TablesCollection)._AddRef;
  if WebObjectsCollection<>nil then IDispatch(WebObjectsCollection)._Release;
  WebObjectsCollection:=TCollectionObj.Create('webobjects');
  IDispatch(WebObjectsCollection)._AddRef;
  if FormsCollection<>nil then IDispatch(FormsCollection)._Release;
  FormsCollection:=TCollectionObj.Create('forms');
  IDispatch(FormsCollection)._AddRef;
  VCLScriptControl.RegisterClass('App',TApp.Create);
  VCLScriptControl.RegisterClass('Debug',TDebug.Create(MainForm.Memo1.Lines,MainForm.ListView1));
  VCLScriptControl.RegisterClass('Query',TQueryFactory.Create);
  VCLScriptControl.RegisterClass('Form',TFormFactory.Create(fsNormal));
  VCLScriptControl.RegisterClass('CodeMemo',TCodeObj.Create(Memo,tableName));
  VCLScriptControl.RegisterClass('TextDocument',TTextDocumentFactory.Create);
  VCLScriptControl.RunScript(Code);
end;

procedure TDM.ExecuteScript(Code: String);
var
  Language: TScriptLanguage;
  i:integer;
begin
  Language := TScriptLanguage(0);
  VCLScriptControl.CreateScriptEngine(Language);
  if DBTablesCollection<>nil then IDispatch(DBTablesCollection)._Release;
  DBTablesCollection:=TCollectionObj.Create('dbtables');
  IDispatch(DBTablesCollection)._AddRef;
  if VariablesCollection<>nil then IDispatch(VariablesCollection)._Release;
  VariablesCollection:=TCollectionObj.Create('variables');
  IDispatch(VariablesCollection)._AddRef;
  if ModulesCollection<>nil then IDispatch(ModulesCollection)._Release;
  ModulesCollection:=TCollectionObj.Create('modulegroups');
  IDispatch(ModulesCollection)._AddRef;
  if TablesCollection<>nil then IDispatch(TablesCollection)._Release;
  TablesCollection:=TCollectionObj.Create('tables');
  IDispatch(TablesCollection)._AddRef;
  if WebObjectsCollection<>nil then IDispatch(WebObjectsCollection)._Release;
  WebObjectsCollection:=TCollectionObj.Create('webobjects');
  IDispatch(WebObjectsCollection)._AddRef;
  if FormsCollection<>nil then IDispatch(FormsCollection)._Release;
  FormsCollection:=TCollectionObj.Create('forms');
  IDispatch(FormsCollection)._AddRef;
  VCLScriptControl.RegisterClass('App',TApp.Create);
  {if Pos('DEBUG', AnsiUpperCase(Code))<>0 then
  begin
    Child := nil;
    for i := 0 to MainForm.MDIChildCount - 1 do
      if MainForm.MDIChildren[i].Caption='Отладка' then
        Child := TMDIChild(MainForm.MDIChildren[i]);
    if not Assigned(Child) then Child := TMDIChild.Create(Application);
    Child.Caption := 'Отладка';}
    VCLScriptControl.RegisterClass('Debug',TDebug.Create(MainForm.Memo1.Lines,MainForm.ListView1));
  //end;
  for i := 0 to TableList.Count- 1 do
  begin
    VCLScriptControl.RegisterClass(TableList[i],TTableObj.Create(TADOTable(TableList.Objects[i])));
  end;
  VCLScriptControl.RegisterClass('Dict',TDBDialogObj.Create(DDBForm));
  VCLScriptControl.RegisterClass('Query',TQueryFactory.Create);
  VCLScriptControl.RegisterClass('Form',TFormFactory.Create(fsNormal));
  VCLScriptControl.RegisterClass('MDIForm',TFormFactory.Create(fsMDIChild));
  VCLScriptControl.RegisterClass('LinkTo',TLinkFactory.Create);
  VCLScriptControl.RegisterClass('Report',TReportFactory.Create);
  VCLScriptControl.RegisterClass('TextDocument',TTextDocumentFactory.Create);
  VCLScriptControl.RegisterClass('WorkPanel',MainForm.WorkPanel);
  VCLScriptControl.RegisterClass('Request',TRequestObj.Create(RequestStr));
  VCLScriptControl.RegisterClass('Response',TResponseObj.Create(ResponseStr));
  VCLScriptControl.RegisterClass('TestObject',TTestEventObj.Create);
  VCLScriptControl.RegisterClass('VKAPI',TVKAPI.Create);
  VCLScriptControl.RunScript(Code);
end;

procedure TDM.ExecuteScriptForForm(Code: String;
  const SourceComponent: TComponent);
  var
  Language: TScriptLanguage;
  i:integer;
begin
  Language := TScriptLanguage(0);
  VCLScriptControl.CreateScriptEngine(Language);
  if DBTablesCollection<>nil then IDispatch(DBTablesCollection)._Release;
  DBTablesCollection:=TCollectionObj.Create('dbtables');
  IDispatch(DBTablesCollection)._AddRef;
  if VariablesCollection<>nil then IDispatch(VariablesCollection)._Release;
  VariablesCollection:=TCollectionObj.Create('variables');
  IDispatch(VariablesCollection)._AddRef;
  if ModulesCollection<>nil then IDispatch(ModulesCollection)._Release;
  ModulesCollection:=TCollectionObj.Create('modulegroups');
  IDispatch(ModulesCollection)._AddRef;
  if TablesCollection<>nil then IDispatch(TablesCollection)._Release;
  TablesCollection:=TCollectionObj.Create('tables');
  IDispatch(TablesCollection)._AddRef;
  if WebObjectsCollection<>nil then IDispatch(WebObjectsCollection)._Release;
  WebObjectsCollection:=TCollectionObj.Create('webobjects');
  IDispatch(WebObjectsCollection)._AddRef;
  if FormsCollection<>nil then IDispatch(FormsCollection)._Release;
  FormsCollection:=TCollectionObj.Create('forms');
  IDispatch(FormsCollection)._AddRef;
  VCLScriptControl.RegisterClass('App',TApp.Create);
  {if Pos('DEBUG', AnsiUpperCase(Code))<>0 then
  begin
    Child := nil;
    for i := 0 to MainForm.MDIChildCount - 1 do
      if MainForm.MDIChildren[i].Caption='Отладка' then
        Child := TMDIChild(MainForm.MDIChildren[i]);
    if not Assigned(Child) then Child := TMDIChild.Create(Application);
    Child.Caption := 'Отладка';}
    VCLScriptControl.RegisterClass('Debug',TDebug.Create(MainForm.Memo1.Lines,MainForm.ListView1));
  //end;
  for i := 0 to TableList.Count- 1 do
  begin
    VCLScriptControl.RegisterClass(TableList[i],TTableObj.Create(TADOTable(TableList.Objects[i])));
  end;
  VCLScriptControl.RegisterClass('Dict',TDBDialogObj.Create(DDBForm));
  VCLScriptControl.RegisterClass('Query',TQueryFactory.Create);
  VCLScriptControl.RegisterClass('Form',TFormFactory.Create(fsNormal));
  VCLScriptControl.RegisterClass('MDIForm',TFormFactory.Create(fsMDIChild));
  VCLScriptControl.RegisterClass('LinkTo',TLinkFactory.Create);
  VCLScriptControl.RegisterClass('Report',TReportFactory.Create);
  VCLScriptControl.RegisterClass('TextDocument',TTextDocumentFactory.Create);
  VCLScriptControl.RegisterClass('WorkPanel',MainForm.WorkPanel);
  VCLScriptControl.RegisterClass('Request',TRequestObj.Create(RequestStr));
  VCLScriptControl.RegisterClass('Response',TResponseObj.Create(ResponseStr));
  VCLScriptControl.RegisterClass('TestObject',TTestEventObj.Create);
  VCLScriptControl.RegisterClass('VKAPI',TVKAPI.Create);
  SetComponentHandlers(SourceComponent, TForm(SourceComponent));
  VCLScriptControl.RunScript(Code);
end;



procedure TDM.ExecuteScriptInEditor(Code: String; CodeMemo: TSynMemo);
var
  Language: TScriptLanguage;
  i:integer;
begin
  Language := TScriptLanguage(0);
  VCLScriptControl.CreateScriptEngine(Language);
  if DBTablesCollection<>nil then IDispatch(DBTablesCollection)._Release;
  DBTablesCollection:=TCollectionObj.Create('dbtables');
  IDispatch(DBTablesCollection)._AddRef;
  if VariablesCollection<>nil then IDispatch(VariablesCollection)._Release;
  VariablesCollection:=TCollectionObj.Create('variables');
  IDispatch(VariablesCollection)._AddRef;
  if ModulesCollection<>nil then IDispatch(ModulesCollection)._Release;
  ModulesCollection:=TCollectionObj.Create('modulegroups');
  IDispatch(ModulesCollection)._AddRef;
  if TablesCollection<>nil then IDispatch(TablesCollection)._Release;
  TablesCollection:=TCollectionObj.Create('tables');
  IDispatch(TablesCollection)._AddRef;
  if WebObjectsCollection<>nil then IDispatch(WebObjectsCollection)._Release;
  WebObjectsCollection:=TCollectionObj.Create('webobjects');
  IDispatch(WebObjectsCollection)._AddRef;
  if FormsCollection<>nil then IDispatch(FormsCollection)._Release;
  FormsCollection:=TCollectionObj.Create('forms');
  IDispatch(FormsCollection)._AddRef;
  VCLScriptControl.RegisterClass('App',TApp.Create);
  {if Pos('DEBUG', AnsiUpperCase(Code))<>0 then
  begin
    Child := nil;
    for i := 0 to MainForm.MDIChildCount - 1 do
      if MainForm.MDIChildren[i].Caption='Отладка' then
        Child := TMDIChild(MainForm.MDIChildren[i]);
    if not Assigned(Child) then Child := TMDIChild.Create(Application);
    Child.Caption := 'Отладка';}
    VCLScriptControl.RegisterClass('Debug',TDebug.Create(MainForm.Memo1.Lines,MainForm.ListView1));
  //end;
  for i := 0 to TableList.Count- 1 do
  begin
    VCLScriptControl.RegisterClass(TableList[i],TTableObj.Create(TADOTable(TableList.Objects[i])));
  end;
  VCLScriptControl.RegisterClass('Dict',TDBDialogObj.Create(DDBForm));
  VCLScriptControl.RegisterClass('Query',TQueryFactory.Create);
  VCLScriptControl.RegisterClass('Form',TFormFactory.Create(fsNormal));
  VCLScriptControl.RegisterClass('MDIForm',TFormFactory.Create(fsMDIChild));
  VCLScriptControl.RegisterClass('LinkTo',TLinkFactory.Create);
  VCLScriptControl.RegisterClass('Report',TReportFactory.Create);
  VCLScriptControl.RegisterClass('TextDocument',TTextDocumentFactory.Create);
  VCLScriptControl.RegisterClass('WorkPanel',MainForm.WorkPanel);
  VCLScriptControl.RegisterClass('Request',TRequestObj.Create(RequestStr));
  VCLScriptControl.RegisterClass('Response',TResponseObj.Create(ResponseStr));
  VCLScriptControl.RegisterClass('TestObject',TTestEventObj.Create);
  VCLScriptControl.RegisterClass('VKAPI',TVKAPI.Create);
  VCLScriptControl.CodeMemo:=CodeMemo;
  CodeMemo.Tag:=-1;
  CodeMemo.Invalidate;
  VCLScriptControl.RunScript(Code);
end;


procedure TDM.FormActivate(Sender: TObject);
var i:integer;
begin
 { for i := 0 to AppConf_.Modules.Count - 1 do
  if UpperCase(AppConf_.Modules.Module[i].Name)=UpperCase(TForm(Sender).Name+'_OnActivate') then
  begin
    DM.ExecuteScriptForForm(AppConf_.Modules.Module[i].Text,TForm(Sender));
  end;  }
end;

procedure TDM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TDM.FormKeyPress(Sender: TObject; var Key: Char);
 begin
   if Key = #13 then
   begin
     Key := #0;
     { check if SHIFT - Key is pressed }
     if GetKeyState(VK_Shift) and $8000 <> 0 then
       PostMessage((Sender as TForm).Handle, WM_NEXTDLGCTL, 1, 0)
     else
       PostMessage((Sender as TForm).Handle, WM_NEXTDLGCTL, 0, 0);
   end;
 end;

procedure TDM.FormShow(Sender: TObject);
begin
  (Sender as TForm).BringToFront;
end;

procedure TDM.GetPageNames(AString: TStrings);
var i:integer;
begin
  for i := 0 to AppConf_.Tables.Count - 1 do
    AString.Add(AppConf_.Tables.Table[i].Name);
    
end;

procedure TDM.IdHTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var i:integer;
    Stream1,Stream2, Stream3:TStringStream;
    FindFlag:boolean;
    ReqStr:String;
    ReqHTML:String;

function FileName:string;
begin
      // when loading from file, URL is page.htm/[image.xxx]
      Result := AnsiReplaceStr(ARequestInfo.Document, '/', '\');
      //MainForm.Memo1.Lines.Add(ARequestInfo.Document+'?'+ARequestInfo.Params.Text);
      if Result[Length(Result)] = '\' then Result := LeftStr(Result, Length(Result) - 1);
      ReqStr:=RightStr(Result,Length(Result)-Pos('?',Result));
      ReqStr:=AnsiReplaceStr(ReqStr,'&',#13#10);
      RequestStr.Text:=HTTPDecode(ARequestInfo.Params.Text);
      Result := ExtractFileName(Result);
end;



begin
   FindFlag:=false;
   for i := 0 to AppConf_.WEBPages.Count - 1 do
   begin
     if AnsiUpperCase(AppConf_.WEBPages.WEBPage[i].Name)=AnsiUpperCase(filename) then
     begin
       if AnsiUpperCase(ExtractFileExt(filename))<>'.ASP' then
       begin
         Stream1:=TStringStream.Create(AppConf_.WEBPages.WEBPage[i].Text);
         Stream2:=TStringStream.Create('');
         Stream1.Position:=0;
         DecodeStream(Stream1,Stream2);
         Stream2.Position:=0;
         if AnsiUpperCase(ExtractFileExt(filename))='.CSS' then  AResponseInfo.CustomHeaders.Add('Content-type: text/css');
         AResponseInfo.ContentStream:=Stream2;
       end else
       begin
         Stream1:=TStringStream.Create(AppConf_.WEBPages.WEBPage[i].Text);
         Stream3:=TStringStream.Create('');
         Stream1.Position:=0;
         Stream2:=TStringStream.Create('');
         DecodeStream(Stream1,Stream2);
         Stream2.Position:=0;
         ResponseStr.Clear;
         ExecuteScript(ParseASP(Stream2.DataString+'  '));
         TStringStream(Stream3).WriteString(ResponseStr.Text);
         Stream3.Position:=0;
         AResponseInfo.ContentStream:=Stream3;
       end;
       FindFlag:=true;
     end;
   end;
   if not FindFlag then
   begin
     ReqHTML:='<h3>список переменных</h3><ul>';
     for i := 0 to RequestStr.Count - 1 do
       ReqHTML:=ReqHTML+'<li>'+RequestStr[i]+'</li>';
     ReqHTML:=ReqHTML+'</ul>';
     Stream2:=TStringStream.Create('');
     TStringStream(Stream2).WriteString(AnsiReplaceStr('<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1251"><title>404 страница</title></head><body><H1>Страница не найдена (404 ошибка)</H1><p>страница <b>#ADR#</b> еще не создана</p>'+
                                                      '</body></html>','#ADR#',filename+' '+ReqHTML));
     Stream2.Position:=0;
     AResponseInfo.ContentStream:=Stream2;
   end;

end;


procedure TDM.OpenDB(FileName: String);
var i:integer;
    NTable:TADOTable;
begin
  ADOConnection1.Close;
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+FileName+';Persist Security Info=False';
  ADOConnection1.Open;
  TableList.Clear;
  ADOConnection1.GetTableNames(TableList);
  for i := 0 to TableList.Count- 1 do
  begin
    NTable:=TADOTable.Create(Application);
    NTable.Connection:=ADOConnection1;
    NTable.TableName:=TableList[i];
    TableList.Objects[i]:=Pointer(NTable);
  end;
end;

procedure TDM.TerminateScript;
begin
  VCLScriptControl.TerminateScript;
end;

constructor TApp.Create;
begin
  inherited Create;
end;



function TApp.DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var dps: TDispParams; pDispIds: PDispIdList; VarResult,
  ExcepInfo, ArgErr: Pointer): HResult;

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

var Buffer:TStringList;
    i,j:integer;
    AQuery:TADOQuery;
    SQLDialog:TSQLDialog;
    WebForm:TBrowserForm;
    S:String;
    ZStream: TCompressionStream;
    MStream: TMemoryStream;
    FStream: TFileStream;
    GFilter: String;
begin
  Result := S_OK;
  case DispID of
  DISPID_SHOWTABLE:begin
    for i := 0 to AppConf_.Tables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.tables.table[i].Name)=AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
        begin
           if CheckArgCount(dps.cArgs, [1], FALSE) then MainForm.ShowTableWindow(AppConf_.tables.table[i],'');
           if CheckArgCount(dps.cArgs, [2], FALSE) then MainForm.ShowTableWindow(AppConf_.tables.table[i],dps.rgvarg^[pDispIds^[1]].bstrVal);
        end;
      end;
  end;
  DISPID_CLOSETABLE:
  begin
    for i := MainForm.MDIChildCount - 1 downto 0  do
      if AnsiUpperCase(MainForm.MDIChildren[i].Caption)=
         AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
      begin
        MainForm.MDIChildren[i].Close;
        MainForm.MDIChildren[i].Free;
      end;
  end;
  DISPID_WORKDIR:
  begin
    if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
       OleVariant(VarResult^):= ExtractFilePath(Paramstr(0));
  end;
  DISPID_MODULES:
  begin
    //OleVariant(VarResult^):= IDispatch(ModulesCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(ModulesCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=ModulesCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=ModulesCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_CONSTANT:
  begin
    if dps.cArgs=1 then
    begin
      for i := 0 to AppConf_.Variables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
        OleVariant(VarResult^):= AppConf_.Variables.Variable[i].Text;
      end;
    end;
  end;
  DISPID_MAXIMIZEALL:
  begin
    if MainForm.MDIChildCount>0 Then
    Mainform.MDIChildren[0].WindowState:=wsMaximized;
  end;
  DISPID_LINKTO:
  begin
   for i := 0 to MainForm.MDIChildCount - 1 do
      if AnsiUpperCase(MainForm.MDIChildren[i].Caption)=
         AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
      begin
        AQuery:= TTestDialog(MainForm.MDIChildren[i]).Grid_Frame1.ADOQuery;
      end;
    OleVariant(VarResult^):= IDispatch(TLinkObj.Create(AQuery));
  end;
  DISPID_GETFILENAME:
  begin
    if DM.OpenDialog1.Execute and (DM.OpenDialog1.FileName<>'') then
       OleVariant(VarResult^):= DM.OpenDialog1.FileName
    else
      OleVariant(VarResult^):= '';
  end;
  DISPID_SQLDIALOG:
  begin
    if dps.cArgs=1 then
    begin
      SQLDialog:=TSQLDialog.Create(Application);
      SQLDialog.SQL:=dps.rgvarg^[pDispIds^[0]].bstrVal;
      SQLDialog.Show;
    end;
  end;
  DISPID_ACTIONSTRING: begin

    OleVariant(VarResult^):=DM.fAction;
  end;
  DISPID_STRING:
  begin
    if FPropName<>'' then
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      for i := 0 to AppConf_.Variables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(FPropName) then
        begin
          if dps.cArgs=0 then
            OleVariant(VarResult^):= AppConf_.Variables.Variable[i].Text;
          if dps.cArgs=1  then
          begin
            if ValidType(dps.rgvarg^[pDispIds^[0]], VT_BSTR, FALSE) then begin
            // Параметр строковый - возвращаем значение свойства Values
            S := dps.rgvarg^[pDispIds^[0]].bstrVal;
            Buffer:=TStringList.Create;
            Buffer.Text:=AppConf_.Variables.Variable[i].Text;
            OleVariant(VarResult^) := Buffer.Values[S];
            Buffer.Free;
          end else begin
            // Параметр целый, возвращаем строку по индексу
            j := IntValue(dps.rgvarg^[pDispIds^[0]]);
            Buffer:=TStringList.Create;
            Buffer.Text:=AppConf_.Variables.Variable[i].Text;
            if (j >= 0) and (j < Buffer.Count) then
            begin
              Buffer:=TStringList.Create;
              Buffer.Text:=AppConf_.Variables.Variable[i].Text;
              OleVariant(VarResult^) := Buffer[j];
              Buffer.Free;
            end
            else
              Result := DISP_E_MEMBERNOTFOUND;
          end;
        end;
        end;
      end;
      if Flags = DISPATCH_PROPERTYPUT  then
      for i := 0 to AppConf_.Variables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(FPropName) then
        AppConf_.Variables.Variable[i].Text := dps.rgvarg^[pDispIds^[0]].bstrVal;
      end;
      FPropName:='';
    end;
    if FModName<>'' then
    begin
      {for i := 0 to AppConf_.Modules.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Modules.Module[i].Name)=AnsiUpperCase(FModName) then
          OleVariant(VarResult^):= AppConf_.Modules.Module[i].Text;
      end; }
      for i := 0 to AppConf_.Modules.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Name)=AnsiUpperCase(FModName) then
          OleVariant(VarResult^):= IDispatch(TModuleGroupObj.Create(AppConf_.Modules.Modulegroup[i]));
      end;
    end;
    if FTableName<>'' then
    begin
      for i := 0 to AppConf_.Tables.Count  - 1 do
      begin
        if AnsiUpperCase(FTableName)=AnsiUpperCase(AppConf_.Tables.Table[i].Name) then
        begin
          OleVariant(VarResult^):=IDispatch(TAppTablesObj.Create(AppConf_.Tables.Table[i]));
          FTableName:='';
        end;
      end;
    end;
    if FFormName<>'' then
    begin
      for i := 0 to AppConf_.Forms.Count  - 1 do
      begin
        if AnsiUpperCase(FFormName)=AnsiUpperCase(AppConf_.Forms.Form[i].Name) then
        begin
          OleVariant(VarResult^):=IDispatch(TFormObj.Create(AppConf_.Forms.Form[i]));
          FFormName:='';
        end;
      end;
    end;
  end;
  DISPID_COMPACTDB:
  begin
    DM.ADOConnection1.Close;
    CompactDatabase_JRO(AppConf_.Linkto);
    DM.OpenDB(AppConf_.Linkto);
  end;
  DISPID_CLOSEALL:
  begin
    MainForm.CloseAllChild;
  end;
  DISPID_SAVECONF:
  begin
    if MainForm.FFileName<>'' then
    begin
      if AnsiUpperCase(ExtractFileExt(MainForm.FFileName))='.XML' then
         AppConf_.OwnerDocument.SaveToFile(MainForm.FFileName)
      else
      begin
        MStream := TMemoryStream.Create;
        AppConf_.OwnerDocument.SaveToStream(MStream);
        MStream.Position:=0;
        FStream:= TFileStream.Create(MainForm.FFileName,fmCreate);
        ZStream:= TCompressionStream.Create(clDefault, FStream);
        ZStream.CopyFrom(MStream,MStream.Size);
        ZStream.Free;
        MStream.Free;
        FStream.Free;
      end;
    end;
  end;
  DISPID_WEB:
  begin
     WebForm:=TBrowserForm.Create(Application);
     WebForm.OnClose:=DM.FormClose;
     WebForm.Show;
     fContainer := TExternalContainer.Create(WebForm.WB);
     if dps.cArgs=1 then
     begin
       WebForm.WB.Navigate(dps.rgvarg^[pDispIds^[0]].bstrVal);
     end;
  end;
  DISPID_STARTSERVER: begin
    DM.dHTTPServer.Active:=true;
    MainForm.StatusBar.Panels[3].Text:='Server ON';
  end;
  DISPID_STOPSERVER: begin
    DM.dHTTPServer.Active:=False;
    MainForm.StatusBar.Panels[3].Text:='Server OFF';
  end;
  DISPID_PORT: begin
    DM.dHTTPServer.DefaultPort:=IntValue(dps.rgvarg^[pDispIds^[0]]);
  end;
  DISPID_DBTABLES:begin
    //OleVariant(VarResult^):= IDispatch(DBTablesCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(DBTablesCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=DBTablesCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=DBTablesCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_VARIABLES:begin
    //OleVariant(VarResult^):= IDispatch(VariablesCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(VariablesCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=VariablesCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=VariablesCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_TABLES:begin
    //OleVariant(VarResult^):= IDispatch(TablesCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(TablesCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=TablesCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=TablesCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_WEBOBJECTS:begin
    //OleVariant(VarResult^):= IDispatch(WebObjectsCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(WebObjectsCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=WebObjectsCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=WebObjectsCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_FORMS:begin
    //OleVariant(VarResult^):= IDispatch(FormsCollection);
    if CheckArgCount(dps.cArgs, [0], FALSE) then
       OleVariant(VarResult^):=IDispatch(FormsCollection)
    else
    begin
      if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
      begin
        if not _ValidType(0, VT_BSTR, FALSE) then
          OleVariant(VarResult^) :=FormsCollection.GetItem(_IntValue(0))
        else
        begin
          OleVariant(VarResult^) :=FormsCollection.GetItem(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
      end;
    end;
  end;
  DISPID_TERMINATE:
  begin
    Application.Terminate;
  end;
  DISPID_NOCONFIGURE:
  begin
    Mainform.isEditing:=false;
    Mainform.StatusBar.Panels[2].Text:='Запрет изменения параметров';
    Mainform.PageControl1.ActivePage:=Mainform.TabSheet3;
  end;
  end;
end;

function TApp.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'SHOWTABLE' then
      begin
        IDs[0] := DISPID_SHOWTABLE;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'CLOSETABLE' then
      begin
        IDs[0] := DISPID_CLOSETABLE;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'WORKDIR' then
      begin
        IDs[0] := DISPID_WORKDIR;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'CONSTANT' then
      begin
        IDs[0] := DISPID_CONSTANT;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'MAXIMIZEALL' then
      begin
        IDs[0] := DISPID_MAXIMIZEALL;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'LINKTO' then
      begin
        IDs[0] := DISPID_LINKTO;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'MODULEGROUPS' then
      begin
        IDs[0] := DISPID_MODULES;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'GETFILENAME' then
      begin
        IDs[0] := DISPID_GETFILENAME;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'SQLDIALOG' then
      begin
        IDs[0] := DISPID_SQLDIALOG;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'COMPACTDB' then
      begin
        IDs[0] := DISPID_COMPACTDB;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'CLOSEALLWINDOW' then
      begin
        IDs[0] := DISPID_CLOSEALL;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'NAVIGATE' then
      begin
        IDs[0] := DISPID_WEB;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'STARTSERVER' then
      begin
        IDs[0] := DISPID_STARTSERVER;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'STOPSERVER' then
      begin
        IDs[0] := DISPID_STOPSERVER;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'PORT' then
      begin
        IDs[0] := DISPID_PORT;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'DBTABLES' then
      begin
        IDs[0] := DISPID_DBTABLES;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'VARIABLES' then
      begin
        IDs[0] := DISPID_VARIABLES;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'TABLES' then
      begin
        IDs[0] := DISPID_TABLES;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'WEBOBJECTS' then
      begin
        IDs[0] := DISPID_WEBOBJECTS;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'FORMS' then
      begin
        IDs[0] := DISPID_FORMS;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'SAVECONFIGURATION' then
      begin
        IDs[0] := DISPID_SAVECONF;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'TERMINATE' then
      begin
        IDs[0] := DISPID_TERMINATE;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'NOCONFIGURE' then
      begin
        IDs[0] := DISPID_NOCONFIGURE;
        Result:=S_OK;
      end else
      if AnsiUpperCase(Name) = 'ACTIONSTRING' then
      begin
        IDs[0] := DISPID_ACTIONSTRING;
        Result:=S_OK;
      end else
      begin
        FPropName:='';
        FModName:='';
        for i := 0 to AppConf_.Modules.Count - 1 do
        begin
          if AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Name)=AnsiUpperCase(Name) then
             FModName:=Name;
        end;
        for i := 0 to AppConf_.Variables.Count - 1 do
        begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(Name) then
           FPropName:=Name;
        end;
        for i := 0 to AppConf_.Tables.Count - 1 do
        begin
        if AnsiUpperCase(AppConf_.Tables.Table[i].Name)=AnsiUpperCase(Name) then
           FTableName:=Name;
        end;
        for i := 0 to AppConf_.Forms.Count - 1 do
        begin
        if AnsiUpperCase(AppConf_.Forms.Form[i].Name)=AnsiUpperCase(Name) then
           FFormName:=Name;
        end;
        if (FPropName<>'') or (FModName<>'') or (FTableName<>'') or (FFormName<>'') then
        begin
          IDs[0] := DISPID_STRING;
          Result:=S_OK;
        end;
      end;
    end;
end;

function TApp.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TApp.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TApp.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TApp');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TApp');
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

{ TQueryFactory }

constructor TQueryFactory.Create;
begin
  inherited create
end;

function TQueryFactory.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var AQuery:TADOQuery;
    ACommand:TADOCommand;
begin
  Result := S_OK;
  if DispID=DISPID_VALUE then
  begin
        AQuery:=TADOQuery.Create(Application);
        ACommand:=TADOCommand.Create(Application);
        AQuery.Connection:=DM.ADOConnection1;
        ACommand.Connection:=DM.ADOConnection1;
        if dps.cArgs=1 then
        begin
          AQuery.SQL.Text:=dps.rgvarg^[pDispIds^[0]].bstrVal;
          ACommand.CommandText:=dps.rgvarg^[pDispIds^[0]].bstrVal;
          if Pos('SELECT',AnsiUpperCase(AQuery.SQL.Text))=1 then
            AQuery.Open;
        end;
        OleVariant(VarResult^):= IDispatch(TQueryObj.Create(AQuery,ACommand));
  end;
end;

function TQueryFactory.GetIDsOfNames(const IID: TGUID; Names: Pointer;
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
    end;
end;

function TQueryFactory.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TQueryFactory.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TQueryFactory.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TQueryFactory');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TQueryFactory');
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

{ TFormFactory }

constructor TFormFactory.Create(FormStyle:TFormStyle);
begin
 inherited Create;
 FFormStyle:=FormStyle;
end;

function TFormFactory.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var DForm:TForm;
    Buffer:TStringList;
    i:integer;
    Obj:IDispatch;
begin
   Result := S_OK;
  if DispID=DISPID_VALUE then
  begin
    if dps.cArgs=0 then
        begin
          DForm:=TForm.Create(nil);
          DForm.Position:=poScreenCenter;
          DForm.OnKeyPress:=DM.FormKeyPress;
          DForm.KeyPreview:=true;
          DForm.FormStyle:=FFormStyle;
          if FFormStyle=fsMDIChild then Dform.OnClose:=DM.FormClose;
          Obj:= IDispatch(VCLScriptControl.RegisterObject(DForm));
          OleVariant(VarResult^):= Obj;
        end else
        if dps.cArgs=1 then
        begin
          DForm:=TForm.Create(nil);
          DForm.Position:=poScreenCenter;
          DForm.OnKeyPress:=DM.FormKeyPress;
          DForm.KeyPreview:=true;
          DForm.FormStyle:=FFormStyle;
          if FFormStyle=fsMDIChild then
          begin
            Dform.OnClose:=DM.FormClose;
            DForm.OnActivate:= DM.FormActivate;
          end;
          Buffer:=TStringList.Create;
           for i := 0 to AppConf_.Forms.Count - 1 do
            begin
              if AnsiUpperCase(AppConf_.Forms.Form[i].Name)=AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
              Buffer.Text:=AppConf_.Forms.Form[i].Text;
            end;
            DForm:=TForm(StringToComponentProc(Buffer.Text,DForm));
            SetComponentHandlers(DForm,DForm);
          Buffer.Free;
          Obj:= IDispatch(VCLScriptControl.RegisterObject(DForm));
          OleVariant(VarResult^):= Obj;
        end;
  end;
end;

function TFormFactory.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
    end;
end;


function TFormFactory.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TFormFactory.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TFormFactory.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormFactory');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TFormFactory');
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

{ TLinkFactory }

constructor TLinkFactory.Create;
begin
  inherited Create;
end;

function TLinkFactory.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var i:integer;
    AQuery:TADOQuery;
begin
  Result := S_OK;
  if DispId = DISPID_VALUE then
  begin
   for i := 0 to MainForm.MDIChildCount - 1 do
      if AnsiUpperCase(MainForm.MDIChildren[i].Caption)=
         AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
      begin
        AQuery:= TTestDialog(MainForm.MDIChildren[i]).Grid_Frame1.ADOQuery;
      end;
    OleVariant(VarResult^):= IDispatch(TLinkObj.Create(AQuery));
  end;
end;

function TLinkFactory.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
    end;
end;

function TLinkFactory.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TLinkFactory.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TLinkFactory.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TLinkFactory');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TLinkFactory');
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

{ TReportFactory }

constructor TReportFactory.Create;
begin
  inherited Create;
end;

function TReportFactory.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var DForm:TReportForm;
    i:integer;
    Ms:TMemoryStream;
    SS:TStringStream;
begin
  Result := S_OK;
  if DispID=DISPID_VALUE then
  begin
       if dps.cArgs=1 then
        begin
          DForm:=TReportForm.Create(nil);
          DForm.Position:=poScreenCenter;
          DForm.OnClose:=DM.FormClose;
           for i := 0 to AppConf_.Reports.Count - 1 do
            begin
              if AnsiUpperCase(AppConf_.Reports.Report[i].Name)=AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
              begin
                DForm.Caption:= AppConf_.Reports.Report[i].Name;
                Ms:=TMemoryStream.Create;
                SS:=TStringStream.Create(AppConf_.Reports.Report[i].Text);
                SS.Position:=0;
                DecodeStream(SS,Ms);
                Ms.Position:=0;
                DForm.frReport.LoadFromStream(Ms);
                Ms.Free;
                Ss.Free;
                if AppConf_.Reports.Report[i].SQL<>'' then
                begin
                  DM.ADOQuery1.Close;
                  DM.ADOQuery1.SQL.Text:=AppConf_.Reports.Report[i].SQL;
                  DM.ADOQuery1.Open;
                  DForm.frDBDataSet.DataSet:=DM.ADOQuery1;
                  DForm.frReport.Dataset:=DForm.frDBDataSet;
                end;
              end;
            end;
           OleVariant(VarResult^):= IDispatch(TReport.Create(DForm));
        end;
  end;
end;

function TReportFactory.GetIDsOfNames(const IID: TGUID; Names: Pointer;
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
    end;
end;

function TReportFactory.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TReportFactory.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TReportFactory.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TReportFactory');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TReportFactory');
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

{ TExternalObj }

constructor TExternalObj.Create;
begin
  inherited create;
end;

function TExternalObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var i,j:integer;
    S:string;
    Buffer:TStringList;
begin
  Result := S_OK;
  Case Dispid of
  DISPID_RUNSCRIPT:
  begin
    DM.fAction := dps.rgvarg^[pDispIds^[0]].bstrVal;
    ExecuteScript('Application', 'Actions');
  end;
  DISPID_STRING:
  begin
    if FPropName<>'' then
    begin
      for i := 0 to AppConf_.Variables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(FPropName) then
        begin
          if dps.cArgs=0 then
            OleVariant(VarResult^):= AppConf_.Variables.Variable[i].Text;
          if dps.cArgs=1  then
          begin
            if ValidType(dps.rgvarg^[pDispIds^[0]], VT_BSTR, FALSE) then begin
            // Параметр строковый - возвращаем значение свойства Values
            S := dps.rgvarg^[pDispIds^[0]].bstrVal;
            Buffer:=TStringList.Create;
            Buffer.Text:=AppConf_.Variables.Variable[i].Text;
            OleVariant(VarResult^) := Buffer.Values[S];
            Buffer.Free;
          end else begin
            // Параметр целый, возвращаем строку по индексу
            j := IntValue(dps.rgvarg^[pDispIds^[0]]);
            Buffer:=TStringList.Create;
            Buffer.Text:=AppConf_.Variables.Variable[i].Text;
            if (j >= 0) and (j < Buffer.Count) then
            begin
              Buffer:=TStringList.Create;
              Buffer.Text:=AppConf_.Variables.Variable[i].Text;
              OleVariant(VarResult^) := Buffer[j];
              Buffer.Free;
            end
            else
              Result := DISP_E_MEMBERNOTFOUND;
          end;
        end;
        end;
      end;
      if Flags = DISPATCH_PROPERTYPUT  then
      for i := 0 to AppConf_.Variables.Count - 1 do
      begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(FPropName) then
        AppConf_.Variables.Variable[i].Text := dps.rgvarg^[pDispIds^[0]].bstrVal;
      end;
    end;
  end;
  End;
end;

function TExternalObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'ACTION' then
      begin
        IDs[0] := DISPID_RUNSCRIPT;
        Result:=S_OK;
      end
      else
      begin
        FPropName:='';
        for i := 0 to AppConf_.Variables.Count - 1 do
        begin
        if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(Name) then
           FPropName:=Name;
        end;
        if (FPropName<>'') then
        begin
          IDs[0] := DISPID_STRING;
          Result:=S_OK;
        end;
      end;
    end;
end;

function TExternalObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TExternalObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TExternalObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TExternalObj');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TExternalObj');
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

{ TExternalContainer }

constructor TExternalContainer.Create(const HostedBrowser: TWebBrowser);
begin
  inherited;
  fExternalObj := IDispatch(TExternalObj.Create);
end;

function TExternalContainer.GetExternal(out ppDispatch: IDispatch): HResult;
begin
  ppDispatch := fExternalObj;
  Result := S_OK; // indicates we've provided script
end;



{ TTextDocumentFactory }

constructor TTextDocumentFactory.Create;
begin
  inherited create;
end;

function TTextDocumentFactory.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var i:integer;
    BStr:String;
begin
Result := S_OK;
  BStr:='';
  if DispID=DISPID_VALUE then
  begin
    if dps.cArgs=0 then
        begin
          OleVariant(VarResult^):= IDispatch(TText.Create(AppConf_.WEBPages,''));
        end else
        begin
          for i := 0 to AppConf_.Variables.Count - 1 do
          begin
            if AnsiUpperCase(AppConf_.Variables.Variable[i].Name)=AnsiUpperCase(dps.rgvarg^[pDispIds^[0]].bstrVal) then
              BStr:=AppConf_.Variables.Variable[i].Text;
          end;
          OleVariant(VarResult^):= IDispatch(TText.Create(AppConf_.WEBPages,BStr));
        end;
  end;
end;

function TTextDocumentFactory.GetIDsOfNames(const IID: TGUID; Names: Pointer;
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
    end;
end;


function TTextDocumentFactory.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TTextDocumentFactory.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TTextDocumentFactory.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTextDocumentFactory');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTextDocumentFactory');
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

{ TResponseObj }

constructor TResponseObj.Create(ALines: TStrings);
begin
  inherited Create;
  FLines := ALines;
end;

function TResponseObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  if DispID=DISPID_WRITE then
  begin
    if dps.cArgs=1 then
        begin
          FLines.Add(dps.rgvarg^[pDispIds^[0]].bstrVal);
        end;
  end;
end;

function TResponseObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'WRITE' then
      begin
        IDs[0] := DISPID_WRITE;
        Result:=S_OK;
      end;
    end;
end;

function TResponseObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TResponseObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TResponseObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TResponseObj');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TResponseObj');
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

{ TRequestObj }

constructor TRequestObj.Create(ALines: TStrings);
begin
  inherited Create;
  FLines := ALines;
end;

function TRequestObj.DoInvoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var dps: TDispParams; pDispIds: PDispIdList;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  if DispID=DISPID_QUERYSTRING then
  begin
    if dps.cArgs=1 then
        begin
          OleVariant(VarResult^):= FLines.Values[dps.rgvarg^[pDispIds^[0]].bstrVal];
        end;
  end;
end;

function TRequestObj.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'QUERYSTRING' then
      begin
        IDs[0] := DISPID_QUERYSTRING;
        Result:=S_OK;
      end;
    end;
end;


function TRequestObj.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TRequestObj.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TRequestObj.Invoke(DispID: Integer; const IID: TGUID;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TTRequestObj');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TRequestObj');
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



{ TVKAPI }

Const
  DISPID_GET         = 1;
  DISPID_POST        = 2;
  DISPID_READTIMEOUT = 3;
  DISPID_URL         = 4;
  DISPID_FILENAME    = 5;

constructor TVKAPI.Create;
begin
  FidHTTP:=TIdHTTP.Create(Application);
  FidSSLSocket:=TidSSLIOHandlerSocketOpenSSL.Create(Application);
  FidHTTP.IOHandler:=FidSSLSocket;
  inherited;
end;

function TVKAPI.DoInvoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var dps: TDispParams; pDispIds: PDispIdList; VarResult,
  ExcepInfo, ArgErr: Pointer): HResult;
var Data:TIdMultipartFormDataStream;
begin
  Result := S_OK;
  case Dispid of
  DISPID_GET:
  begin
    if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
    begin
      OleVariant(VarResult^) :=FidHTTP.Get(FURL);
    end;
  end;
  DISPID_POST:
  begin
    if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then
    begin
      Data:=TIdMultipartFormDataStream.Create;
      Data.AddFile('file1',FFileName,'image/jpeg');
      OleVariant(VarResult^) := FidHTTP.Post(FURL,Data);
      Data.Free;
    end;
  end;
  DISPID_READTIMEOUT:
  begin
     FidHTTP.ReadTimeout:=IntValue(dps.rgvarg^[pDispIds^[0]]);
  end;
  DISPID_URL:
  begin
    if Flags = DISPATCH_PROPERTYPUT  then FURL:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then OleVariant(VarResult^) := FURL;
  end;
  DISPID_FILENAME:
  begin
    if Flags = DISPATCH_PROPERTYPUT  then FFileName:=dps.rgvarg^[pDispIds^[0]].bstrVal;
    if (Flags = DISPATCH_METHOD or DISPATCH_PROPERTYGET) then OleVariant(VarResult^) := FFileName;
  end;
  end;
end;

function TVKAPI.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
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
      if AnsiUpperCase(Name) = 'GET' then
      begin
        IDs[0] := DISPID_GET;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'POST' then
      begin
        IDs[0] := DISPID_POST;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'READTIMEOUT' then
      begin
        IDs[0] := DISPID_READTIMEOUT;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'URL' then
      begin
        IDs[0] := DISPID_URL;
        Result:=S_OK;
      end;
      if AnsiUpperCase(Name) = 'FILENAME' then
      begin
        IDs[0] := DISPID_FILENAME;
        Result:=S_OK;
      end;
    end;
end;

function TVKAPI.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TVKAPI.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK
end;

function TVKAPI.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
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
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TVKAPI');
          TExcepInfo(ExcepInfo^).bstrDescription := SysAllocString(PWideChar(WS));
        end;
        Result := DISP_E_EXCEPTION;
      end;
      on E: Exception do begin
        if Assigned(ExcepInfo) then begin
          FillChar(ExcepInfo^, SizeOf(TExcepInfo), 0);
          TExcepInfo(ExcepInfo^).wCode := 1001;
          TExcepInfo(ExcepInfo^).BStrSource := SysAllocString('TVKAPI');
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
