unit UnitCP;

interface

Uses classes, TypInfo, SysUtils, Forms, DataUnit;

procedure GetClassProperty(AClass: string; AStrings: TStrings);
procedure GetClassProperty2(AClass: string; AStrings: TStrings);
//procedure GetClassProperties(AClass: TObject; AStrings: TStrings);
implementation

uses ConfigApp;

function TestPattern_(Value: string;
  patterns: array of string): boolean;
var i:integer;
    SumPos:integer;
begin
   SumPos:=0;
   for i := 0 to Length(patterns) - 1 do
     SumPos := SumPos + Pos(patterns[i],Value);
   Result := (SumPos > 0);
end;

function CreateAClass(const AClassName: string): TObject;

var
  C : TFormClass;
  SomeObject: TObject;
begin
  C := TFormClass(FindClass(AClassName));
  SomeObject := C.Create(nil);
  Result := SomeObject;
end;

function isNotEvent(Value:string):boolean;
var isNotEv:boolean;
begin
  isNotEv:=true;
  if UpperCase(Value)='ONCLICK' then isNotEv:=false;
  if UpperCase(Value)='ONCHANGE' then isNotEv:=false;
  if UpperCase(Value)='ONENTER' then isNotEv:=false;
  if UpperCase(Value)='ONEXIT' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSEENTER' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSELEAVE' then isNotEv:=false;
  if UpperCase(Value)='ONMOUSEMOVE' then isNotEv:=false;
  if UpperCase(Value)='ONKEYUP' then isNotEv:=false;
  if UpperCase(Value)='ONKEYDOWN' then isNotEv:=false;
  if UpperCase(Value)='ONKEYPRESS' then isNotEv:=false;
  if UpperCase(Value)='ONDBLCLICK' then isNotEv:=false;
  if UpperCase(Value)='ONTIMER' then isNotEv:=false;
  Result:=isNotEv;
end;

procedure GetClassProperties(AClass: TObject; AStrings: TStrings);
var
  PropList: PPropList;
  ClassTypeInfo: PTypeInfo;
  ClassTypeData: PTypeData;
  i: integer;

begin
  ClassTypeInfo := AClass.ClassInfo;
  ClassTypeData := GetTypeData(ClassTypeInfo);
  if ClassTypeData.PropCount <> 0 then
  begin
  GetMem(PropList, SizeOf(PPropInfo) * ClassTypeData.PropCount);
  try
    GetPropInfos(AClass.ClassInfo, PropList);
    for i := 0 to ClassTypeData.PropCount - 1 do
      if not (PropList[i]^.PropType^.Kind = tkMethod) then
        AStrings.Add(Format('%s=\color{clNavy}property \color{clBlack}\column{}\style{+B}%s\style{-B}: %s', [PropList[i]^.Name, PropList[i]^.Name, PropList[i]^.PropType^.Name]))
      else
        if not isNotEvent(PropList[i]^.Name) then
            AStrings.Add(Format('%s=\color{clNavy}property \color{clBlack}\column{}\style{+B}%s\style{-B}: %s', [PropList[i]^.Name, PropList[i]^.Name, PropList[i]^.PropType^.Name]));
    finally
      FreeMem(PropList, SizeOf(PPropInfo) * ClassTypeData.PropCount);
    end;
  end;
end;

procedure GetClassProperties2(AClass: TObject; AStrings: TStrings);
var
  PropList: PPropList;
  ClassTypeInfo: PTypeInfo;
  ClassTypeData: PTypeData;
  i: integer;

begin
  ClassTypeInfo := AClass.ClassInfo;
  ClassTypeData := GetTypeData(ClassTypeInfo);
  if ClassTypeData.PropCount <> 0 then
  begin
  GetMem(PropList, SizeOf(PPropInfo) * ClassTypeData.PropCount);
  try
    GetPropInfos(AClass.ClassInfo, PropList);
    for i := 0 to ClassTypeData.PropCount - 1 do
      if not (PropList[i]^.PropType^.Kind = tkMethod) then
        AStrings.Add(Format('property %s: %s', [PropList[i]^.Name, PropList[i]^.PropType^.Name]))
      else
        if not isNotEvent(PropList[i]^.Name) then
            AStrings.Add(Format('property %s: %s', [PropList[i]^.Name, PropList[i]^.PropType^.Name]));
    finally
      FreeMem(PropList, SizeOf(PPropInfo) * ClassTypeData.PropCount);
    end;
  end;
end;

procedure GetClassProperty(AClass: string; AStrings: TStrings);
var
  SomeComp: TObject;
  i:integer;
begin
  AStrings.Clear;
  if TestPattern_(AClass,['TFORM','TPANEL','TGROUPBOX','TTABSHEET','TPAGECONTROL','TTOOLBAR']) then
  begin
    AStrings.Add('Add=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Add Component, ClassName, [Events = false]\style{-B}');
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}: Integer');
  end;
  if AClass='REPORT' then
  begin
    AStrings.Add('PDF417Param=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}PDF417Param\style{-B} Col, Row');
    AStrings.Add('ShowReport=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ShowReport\style{-B}');
    AStrings.Add('PDF417Code=\color{clNavy}property \color{clBlack}\column{}\style{+B}PDF417Code\Style{-B}(Object): Text');
    AStrings.Add('QRCode=\color{clNavy}property \color{clBlack}\column{}\style{+B}QRCode\Style{-B}(Object): Text');
    AStrings.Add('LoadImage=\color{clNavy}property \color{clBlack}\column{}\style{+B}LoadImage\Style{-B}(Object): Base64Text');
  end;
  if AClass='TFORM' then 
  begin
    AStrings.Add('Show=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Show\style{-B}');
    AStrings.Add('Close=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Close\style{-B}');
    AStrings.Add('ShowModal=\color{clBlue}function \color{clBlack}\column{}\style{+B}ShowModal\style{-B}: ModalResult');
    AStrings.Add('ModalResult=\color{clNavy}property \color{clBlack}\column{}\style{+B}ModalResult\Style{-B}: ModalResult');
  end;
  if TestPattern_(AClass,['TGRID_FRAME']) then
  begin
    AStrings.Add('SetQuery=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SetQuery NewQuery\style{-B}');
    AStrings.Add('Refresh=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Refresh\style{-B}');
  end;
  if TestPattern_(AClass,['TLISTBOX', 'TCHECKLISTBOX']) then
  begin
    AStrings.Add('Selected=\color{clNavy}property \color{clBlack}\column{}\style{+B}Selected(ID)\Style{-B}: boolean');
    AStrings.Add('DeleteSelected=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}DeleteSelected\style{-B}');
    if AClass='TCHECKLISTBOX' then AStrings.Add('Checked=\color{clNavy}property \color{clBlack}\column{}\style{+B}Checked(ID)\Style{-B}: boolean');
  end;
  if TestPattern_(AClass,['TLINESERIES', 'TBARSERIES', 'TPIESERIES', 'TAREASERIES']) then
  begin
    AStrings.Add('Add=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Add Value, Caption, [Color]\style{-B}');
    AStrings.Add('Clear=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Clear\style{-B}');
  end;
  if AClass='TCHART' then
  begin
   AStrings.Add('AddSeries=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}AddSeries Series\style{-B}');
   AStrings.Add('ClearSeries=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ClearSeries\style{-B}');
  end;
  if AClass='TIMAGE' then
  begin
    AStrings.Add('LoadImageFromBase64=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}LoadImageFromBase64 BASE64String\style{-B}');
    AStrings.Add('QRCode=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}QRCode Value\style{-B}');
    AStrings.Add('CopyToClipboard=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CopyToClipboard\style{-B}');
  end;
  if Copy(AClass,1,1)='T' then
  begin
    AStrings.Add('Controls=\color{clBlue}function \color{clBlack}\column{}\style{+B}Controls(ID)\style{-B}: IDispatch');
    AStrings.Add('HasProperty=\color{clBlue}function \color{clBlack}\column{}\style{+B}HasProperty(PropertyName)\style{-B}: boolean');
    SomeComp := CreateAClass(AClass);
    GetClassProperties(SomeComp, AStrings);
    SomeComp.Free;
  end;
  if AClass='ERR' then
  begin
     AStrings.Add('Clear=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Clear\style{-B}');
     AStrings.Add('Raise=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Raise\style{-B} number, source, description, helpfile, helpcontext');
     AStrings.Add('Description=\color{clNavy}property \color{clBlack}\column{}\style{+B}Description\Style{-B}: String');
     AStrings.Add('Number=\color{clNavy}property \color{clBlack}\column{}\style{+B}Number\Style{-B}: Integer');
     AStrings.Add('Source=\color{clNavy}property \color{clBlack}\column{}\style{+B}Source\Style{-B}: String');
     AStrings.Add('HelpFile=\color{clNavy}property \color{clBlack}\column{}\style{+B}HelpFile\Style{-B}: String');
     AStrings.Add('HelpContext=\color{clNavy}property \color{clBlack}\column{}\style{+B}HelpContext\Style{-B}: String');
  end;
  if AClass = 'DEBUG' then
  begin
    AStrings.Add('Print=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Print "..."\style{-B}');
    AStrings.Add('Error=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Error "..."\style{-B}');
    AStrings.Add('Warning=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Warning "..."\style{-B}');
    AStrings.Add('Info=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Info "..."\style{-B}');
    AStrings.Add('ClearText=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ClearText\style{-B}');
    AStrings.Add('ClearMessages=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ClearMessages\style{-B}');
  end;
  if AClass = 'DICT' then
  begin
     AStrings.Add('Field=\color{clNavy}property \color{clBlack}\column{}\style{+B}Field\Style{-B}: String');
     AStrings.Add('DescriptionField=\color{clNavy}property \color{clBlack}\column{}\style{+B}DescriptionField\Style{-B}: String');
     AStrings.Add('DefaultFilter=\color{clNavy}property \color{clBlack}\column{}\style{+B}DefaultFilter\Style{-B}: String');
     AStrings.Add('Description=\color{clNavy}property \color{clBlack}\column{}\style{+B}Description\Style{-B}: String');
     AStrings.Add('SQLDialog=\color{clNavy}property \color{clBlack}\column{}\style{+B}SQLDialog\Style{-B}: String');
     AStrings.Add('SQL=\color{clNavy}property \color{clBlack}\column{}\style{+B}SQL\Style{-B}: String');
     AStrings.Add('QueryResult=\color{clNavy}property \color{clBlack}\column{}\style{+B}QueryResult\Style{-B}: String');
     AStrings.Add('Clear=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Clear\style{-B}');
     AStrings.Add('AddLabel=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}AddLabel\style{-B} Field, Label, Size');
     AStrings.Add('Execute=\color{clBlue}function \color{clBlack}\column{}\style{+B}Execute\style{-B}:Boolean');

  end;
  if AClass = 'APP' then
  begin
    AStrings.Add('WorkDir=\color{clNavy}property \color{clBlack}\column{}\style{+B}WorkDir\Style{-B}: String');
    AStrings.Add('DBTables=\color{clNavy}property \color{clBlack}\column{}\style{+B}DBTables\Style{-B}: Collection');
    AStrings.Add('Variables=\color{clNavy}property \color{clBlack}\column{}\style{+B}Variables\Style{-B}: Collection');
    AStrings.Add('ModuleGroups=\color{clNavy}property \color{clBlack}\column{}\style{+B}ModuleGroups\Style{-B}: Collection');
    AStrings.Add('Tables=\color{clNavy}property \color{clBlack}\column{}\style{+B}Tables\Style{-B}: Collection');
    AStrings.Add('WebObjects=\color{clNavy}property \color{clBlack}\column{}\style{+B}WebObjects\Style{-B}: Collection');
    AStrings.Add('Forms=\color{clNavy}property \color{clBlack}\column{}\style{+B}Forms\Style{-B}: Collection');
    AStrings.Add('GetFileName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetFileName\style{-B}:String');
    AStrings.Add('ShowTable=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ShowTable "..."\style{-B}');
    AStrings.Add('CloseAllWindow=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CloseAllWindow\style{-B}');
    AStrings.Add('SaveConfiguration=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SaveConfiguration\style{-B}');
    AStrings.Add('MaximizeAll=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MaximizeAll\style{-B}');
    AStrings.Add('CompactDB=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CompactDB\style{-B}');
    AStrings.Add('SaveConfiguration=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SaveConfiguration\style{-B}');
    AStrings.Add('StartServer=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}StartServer\style{-B}');
    AStrings.Add('StopServer=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}StopServer\style{-B}');
    AStrings.Add('Navigate=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Navigate "WEBPage"\style{-B}');
    AStrings.Add('Port=\color{clNavy}property \color{clBlack}\column{}\style{+B}Port\Style{-B}: Integer');
    AStrings.Add('SQLDialog=\color{clNavy}property \color{clBlack}\column{}\style{+B}SQLDiaolg\Style{-B}: String');
    AStrings.Add('Terminate=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Terminate\style{-B}');
    AStrings.Add('noConfigure=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}noConfigure\style{-B}');
    for i := 0 to AppConf_.Variables.Count-1 do
      AStrings.Add('['+AppConf_.Variables.Variable[i].Name+']=\color{clGreen}constant \color{clBlack}\column{}\style{+B}['+AppConf_.Variables.Variable[i].Name+']\style{-B}');
    for i := 0 to AppConf_.Modules.Count-1 do
      //AStrings.Add('['+AppConf_.Modules.Module[i].Name+']=\color{clMaroon}modulegroup \color{clBlack}\column{}\style{+B}['+AppConf_.Modules.Module[i].Name+']\style{-B}');
      AStrings.Add('['+AppConf_.Modules.Modulegroup[i].Name+']=\color{clMaroon}modulegroup \color{clBlack}\column{}\style{+B}['+AppConf_.Modules.Modulegroup[i].Name+']\style{-B}');
    for i := 0 to AppConf_.Tables.Count-1 do
      AStrings.Add('['+AppConf_.Tables.Table[i].Name+']=\color{clMoneyGreen}table \color{clBlack}\column{}\style{+B}['+AppConf_.Tables.Table[i].Name+']\style{-B}');
    for i := 0 to AppConf_.Forms.Count-1 do
      AStrings.Add('['+AppConf_.Forms.Form[i].Name+']=\color{clSkyBlue}form \color{clBlack}\column{}\style{+B}['+AppConf_.Forms.Form[i].Name+']\style{-B}');
  end;
  if AClass = 'QUERY' then
  begin
    AStrings.Add('SQL=\color{clNavy}property \color{clBlack}\column{}\style{+B}SQL\style{-B}: String');
    AStrings.Add('Open=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Open\style{-B}');
    AStrings.Add('Close=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Close\style{-B}');
    AStrings.Add('First=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}First\style{-B}');
    AStrings.Add('Last=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Last\style{-B}');
    AStrings.Add('Next=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Next\style{-B}');
    AStrings.Add('Prev=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Prev\style{-B}');
    AStrings.Add('EOF=\color{clBlue}function \color{clBlack}\column{}\style{+B}EOF\style{-B}: boolean');
    AStrings.Add('BOF=\color{clBlue}function \color{clBlack}\column{}\style{+B}BOF\style{-B}: boolean');
    AStrings.Add('Field=\color{clBlue}function \color{clBlack}\column{}\style{+B}Field(field_id)\style{-B}: Variant');
    AStrings.Add('Execute=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Execute\style{-B}');
  end;
  if AClass = 'LINK' then
  begin
    AStrings.Add('SQL=\color{clNavy}property \color{clBlack}\column{}\style{+B}SQL\style{-B}: String');
    AStrings.Add('Open=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Open\style{-B}');
    AStrings.Add('Close=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Close\style{-B}');
    AStrings.Add('First=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}First\style{-B}');
    AStrings.Add('Last=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Last\style{-B}');
    AStrings.Add('Next=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Next\style{-B}');
    AStrings.Add('Prev=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Prev\style{-B}');
    AStrings.Add('EOF=\color{clBlue}function \color{clBlack}\column{}\style{+B}EOF\style{-B}: boolean');
    AStrings.Add('BOF=\color{clBlue}function \color{clBlack}\column{}\style{+B}BOF\style{-B}: boolean');
    AStrings.Add('Field=\color{clBlue}function \color{clBlack}\column{}\style{+B}Field(field_id)\style{-B}: Variant');
    AStrings.Add('Column=\color{clBlue}function \color{clBlack}\column{}\style{+B}Column(field_id)\style{-B}: String');
    AStrings.Add('FieldNames=\color{clBlue}function \color{clBlack}\column{}\style{+B}FieldNames(field_id)\style{-B}: String');
  end;
  /////////////////////////////////////
  ////////////////////////////////////
  if AClass = '' then
  begin
    AStrings.Add('App=\color{clMaroon}object \color{clBlack}\column{}\style{+B}App\style{-B}');
    AStrings.Add('Debug=\color{clMaroon}object \color{clBlack}\column{}\style{+B}Debug\style{-B}');
    AStrings.Add('Dict=\color{clMaroon}object \color{clBlack}\column{}\style{+B}Dict\style{-B}');
    AStrings.Add('Abs=\color{clBlue}function \color{clBlack}\column{}\style{+B}Abs(x)\style{-B}');
    AStrings.Add('Int=\color{clBlue}function \color{clBlack}\column{}\style{+B}Int(x)\style{-B}');
    AStrings.Add('Fix=\color{clBlue}function \color{clBlack}\column{}\style{+B}Fix(x)\style{-B}');
    AStrings.Add('Sgn=\color{clBlue}function \color{clBlack}\column{}\style{+B}Sgn(x)\style{-B}');
    AStrings.Add('Round=\color{clBlue}function \color{clBlack}\column{}\style{+B}Round(x, [numdecimal])\style{-B}');
    AStrings.Add('Rnd=\color{clBlue}function \color{clBlack}\column{}\style{+B}Rnd([x])\style{-B}');
    AStrings.Add('Sqr=\color{clBlue}function \color{clBlack}\column{}\style{+B}Sqr(x)\style{-B}');
    AStrings.Add('Sin=\color{clBlue}function \color{clBlack}\column{}\style{+B}Sin(x)\style{-B}');
    AStrings.Add('Cos=\color{clBlue}function \color{clBlack}\column{}\style{+B}Cos(x)\style{-B}');
    AStrings.Add('Tan=\color{clBlue}function \color{clBlack}\column{}\style{+B}Tan(x)\style{-B}');
    AStrings.Add('Atn=\color{clBlue}function \color{clBlack}\column{}\style{+B}Atn(x)\style{-B}');
    AStrings.Add('Exp=\color{clBlue}function \color{clBlack}\column{}\style{+B}Exp(x)\style{-B}');
    AStrings.Add('Log=\color{clBlue}function \color{clBlack}\column{}\style{+B}Log(x)\style{-B}');
    AStrings.Add('Asc=\color{clBlue}function \color{clBlack}\column{}\style{+B}Asc(str)\style{-B}');
    AStrings.Add('GetRef=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetRef(Object)\style{-B}');
    AStrings.Add('Chr=\color{clBlue}function \color{clBlack}\column{}\style{+B}Chr(code)\style{-B}');
    AStrings.Add('InStr=\color{clBlue}function \color{clBlack}\column{}\style{+B}InStr([start,] str1, str2[, compare])\style{-B}');
    AStrings.Add('InStrRev=\color{clBlue}function \color{clBlack}\column{}\style{+B}InStrRev(str1, str2[, start[, compare]])\style{-B}');
    AStrings.Add('Join=\color{clBlue}function \color{clBlack}\column{}\style{+B}Join(list[, delim])\style{-B}');
    AStrings.Add('Split=\color{clBlue}function \color{clBlack}\column{}\style{+B}Split(expr[, delim[, count[, compare]]])\style{-B}');
    AStrings.Add('LCase=\color{clBlue}function \color{clBlack}\column{}\style{+B}LCase(str)\style{-B}');
    AStrings.Add('UCase=\color{clBlue}function \color{clBlack}\column{}\style{+B}UCase(str)\style{-B}');
    AStrings.Add('Left=\color{clBlue}function \color{clBlack}\column{}\style{+B}Left(str, len)\style{-B}');
    AStrings.Add('Right=\color{clBlue}function \color{clBlack}\column{}\style{+B}Right(str, len)\style{-B}');
    AStrings.Add('Mid=\color{clBlue}function \color{clBlack}\column{}\style{+B}Mid(str, start[, len]))\style{-B}');
    AStrings.Add('Len=\color{clBlue}function \color{clBlack}\column{}\style{+B}Len(str)\style{-B}');
    AStrings.Add('LTrim=\color{clBlue}function \color{clBlack}\column{}\style{+B}LTrim(str)\style{-B}');
    AStrings.Add('RTrim=\color{clBlue}function \color{clBlack}\column{}\style{+B}RTrim(str)\style{-B}');
    AStrings.Add('Trim=\color{clBlue}function \color{clBlack}\column{}\style{+B}Trim(str)\style{-B}');
    AStrings.Add('Replace=\color{clBlue}function \color{clBlack}\column{}\style{+B}Replace(expr, find, replacewith[, start[, count[, compare]]])\style{-B}');
    AStrings.Add('Space=\color{clBlue}function \color{clBlack}\column{}\style{+B}Space(x)\style{-B}');
    AStrings.Add('String=\color{clBlue}function \color{clBlack}\column{}\style{+B}String(number, char)\style{-B}');
    AStrings.Add('StrComp=\color{clBlue}function \color{clBlack}\column{}\style{+B}StrComp(str1, str2[, compare])\style{-B}');
    AStrings.Add('StrReverse=\color{clBlue}function \color{clBlack}\column{}\style{+B}StrReverse(str)\style{-B}');
    AStrings.Add('FormatCurrency=\color{clBlue}function \color{clBlack}\column{}\style{+B}FormatCurrency(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])\style{-B}');
    AStrings.Add('FormatDateTime=\color{clBlue}function \color{clBlack}\column{}\style{+B}FormatDateTime(date[, namedFormat])\style{-B}');
    AStrings.Add('FormatNumber=\color{clBlue}function \color{clBlack}\column{}\style{+B}FormatNumber(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])\style{-B}');
    AStrings.Add('FormatPercent=\color{clBlue}function \color{clBlack}\column{}\style{+B}FormatPercent(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])\style{-B}');
    AStrings.Add('Date=\color{clBlue}function \color{clBlack}\column{}\style{+B}Date()\style{-B}');
    AStrings.Add('Now=\color{clBlue}function \color{clBlack}\column{}\style{+B}Now()\style{-B}');
    AStrings.Add('Time=\color{clBlue}function \color{clBlack}\column{}\style{+B}Time()\style{-B}');
    AStrings.Add('Timer=\color{clBlue}function \color{clBlack}\column{}\style{+B}Timer()\style{-B}');
    AStrings.Add('IsDate=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsDate(expr)\style{-B}');
    AStrings.Add('Year=\color{clBlue}function \color{clBlack}\column{}\style{+B}Year(date)\style{-B}');
    AStrings.Add('Month=\color{clBlue}function \color{clBlack}\column{}\style{+B}Month(date)\style{-B}');
    AStrings.Add('Day=\color{clBlue}function \color{clBlack}\column{}\style{+B}Day(date)\style{-B}');
    AStrings.Add('Weekday=\color{clBlue}function \color{clBlack}\column{}\style{+B}Weekday(date[, firstdayofweek])\style{-B}');
    AStrings.Add('Hour=\color{clBlue}function \color{clBlack}\column{}\style{+B}Hour(time)\style{-B}');
    AStrings.Add('Minute=\color{clBlue}function \color{clBlack}\column{}\style{+B}Minute(time)\style{-B}');
    AStrings.Add('Second=\color{clBlue}function \color{clBlack}\column{}\style{+B}Second(time)\style{-B}');
    AStrings.Add('DateValue=\color{clBlue}function \color{clBlack}\column{}\style{+B}DateValue(date)\style{-B}');
    AStrings.Add('TimeValue=\color{clBlue}function \color{clBlack}\column{}\style{+B}TimeValue(time)\style{-B}');
    AStrings.Add('DateSerial=\color{clBlue}function \color{clBlack}\column{}\style{+B}DateSerial(year, month, day)\style{-B}');
    AStrings.Add('TimeSerial=\color{clBlue}function \color{clBlack}\column{}\style{+B}TimeSerial(hour, minute, second)\style{-B}');
    AStrings.Add('MonthName=\color{clBlue}function \color{clBlack}\column{}\style{+B}MonthName(month[, abbr])\style{-B}');
    AStrings.Add('WeekdayName=\color{clBlue}function \color{clBlack}\column{}\style{+B}WeekdayName(weekday[, abbr[, firstdayofweek]])\style{-B}');
    AStrings.Add('DateAdd=\color{clBlue}function \color{clBlack}\column{}\style{+B}DateAdd(interval, number, date)\style{-B}');
    AStrings.Add('DateDiff=\color{clBlue}function \color{clBlack}\column{}\style{+B}DateDiff(interval, date1, date2[, firstdayofweek[, firstweekofyear]])\style{-B}');
    AStrings.Add('DatePart=\color{clBlue}function \color{clBlack}\column{}\style{+B}DatePart(interval, date[, firstdayofweek[, firstweekofyear]])\style{-B}');
    AStrings.Add('Array=\color{clBlue}function \color{clBlack}\column{}\style{+B}Array(arglist)\style{-B}');
    AStrings.Add('LBound=\color{clBlue}function \color{clBlack}\column{}\style{+B}LBound(arrayname[, dimension])\style{-B}');
    AStrings.Add('UBound=\color{clBlue}function \color{clBlack}\column{}\style{+B}UBound(arrayname[, dimension])\style{-B}');
    AStrings.Add('Filter=\color{clBlue}function \color{clBlack}\column{}\style{+B}Filter(inputStrings, value[, include[, compare]])\style{-B}');
    AStrings.Add('IsArray=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsArray(varname)\style{-B}');
    AStrings.Add('IsDate=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsDate(varname)\style{-B}');
    AStrings.Add('IsEmpty=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsEmpty(varname)\style{-B}');
    AStrings.Add('IsNull=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsNull(varname)\style{-B}');
    AStrings.Add('IsNumeric=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsNumeric(varname)\style{-B}');
    AStrings.Add('IsObject=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsObject(varname)\style{-B}');
    AStrings.Add('VarType=\color{clBlue}function \color{clBlack}\column{}\style{+B}VarType(varname)\style{-B}');
    AStrings.Add('TypeName=\color{clBlue}function \color{clBlack}\column{}\style{+B}TypeName(varname)\style{-B}');
    AStrings.Add('Hex=\color{clBlue}function \color{clBlack}\column{}\style{+B}Hex(number)\style{-B}');
    AStrings.Add('Oct=\color{clBlue}function \color{clBlack}\column{}\style{+B}Oct(number)\style{-B}');
    AStrings.Add('MsgBox=\color{clBlue}function \color{clBlack}\column{}\style{+B}MsgBox(prompt[, buttons][, title][, helpfile, context])\style{-B}');
    AStrings.Add('InputBox=\color{clBlue}function \color{clBlack}\column{}\style{+B}InputBox(prompt[, title][, default][, xpos][, ypos][, helpfile, context])\style{-B}');
    AStrings.Add('CreateObject=\color{clBlue}function \color{clBlack}\column{}\style{+B}CreateObject(servername.typename[, location])\style{-B}');
    AStrings.Add('GetObject=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetObject([pathname][, classname])\style{-B}');
    AStrings.Add('CBool=\color{clBlue}function \color{clBlack}\column{}\style{+B}CBool(expr)\style{-B}');
    AStrings.Add('CByte=\color{clBlue}function \color{clBlack}\column{}\style{+B}CByte(expr)\style{-B}');
    AStrings.Add('CCur=\color{clBlue}function \color{clBlack}\column{}\style{+B}CCur(expr)\style{-B}');
    AStrings.Add('CDate=\color{clBlue}function \color{clBlack}\column{}\style{+B}CDate(expr)\style{-B}');
    AStrings.Add('CDbl=\color{clBlue}function \color{clBlack}\column{}\style{+B}CDbl(expr)\style{-B}');
    AStrings.Add('CInt=\color{clBlue}function \color{clBlack}\column{}\style{+B}CInt(expr)\style{-B}');
    AStrings.Add('CLng=\color{clBlue}function \color{clBlack}\column{}\style{+B}CLng(expr)\style{-B}');
    AStrings.Add('CSng=\color{clBlue}function \color{clBlack}\column{}\style{+B}CSng(expr)\style{-B}');
    AStrings.Add('CStr=\color{clBlue}function \color{clBlack}\column{}\style{+B}CStr(expr)\style{-B}');
    AStrings.Add('Eval=\color{clBlue}function \color{clBlack}\column{}\style{+B}Eval(expr)\style{-B}');
    AStrings.Add('GetLocale=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetLocale()\style{-B}');
    AStrings.Add('SetLocale=\color{clBlue}function \color{clBlack}\column{}\style{+B}SetLocale(lcid)\style{-B}');
    AStrings.Add('ScriptEngine=\color{clBlue}function \color{clBlack}\column{}\style{+B}ScriptEngine()\style{-B}');
    AStrings.Add('ScriptEngineBuildVersion=\color{clBlue}function \color{clBlack}\column{}\style{+B}ScriptEngineBuildVersion()\style{-B}');
    AStrings.Add('ScriptEngineMajorVersion=\color{clBlue}function \color{clBlack}\column{}\style{+B}ScriptEngineMajorVersion()\style{-B}');
    AStrings.Add('ScriptEngineMinorVersion=\color{clBlue}function \color{clBlack}\column{}\style{+B}ScriptEngineMinorVersion()\style{-B}');
    AStrings.Add('RGB=\color{clBlue}function \color{clBlack}\column{}\style{+B}RGB(red, green, blue)\style{-B}');
    AStrings.Add('vbOKOnly=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbOKOnly\style{-B}');
    AStrings.Add('vbOKCancel=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbOKCancel\style{-B}');
    AStrings.Add('vbAbortRetryIgnore=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbAbortRetryIgnore\style{-B}');
    AStrings.Add('vbYesNoCancel=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbYesNoCancel\style{-B}');
    AStrings.Add('vbYesNo=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbYesNo\style{-B}');
    AStrings.Add('vbRetryCancel=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbRetryCancel\style{-B}');
    AStrings.Add('vbCritical=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbCritical\style{-B}');
    AStrings.Add('vbQuestion=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbQuestion\style{-B}');
    AStrings.Add('vbExclamation=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbExclamation\style{-B}');
    AStrings.Add('vbInformation=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbInformation\style{-B}');
    AStrings.Add('vbDefaultButton1=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDefaultButton1\style{-B}');
    AStrings.Add('vbDefaultButton2=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDefaultButton2\style{-B}');
    AStrings.Add('vbDefaultButton3=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDefaultButton3\style{-B}');
    AStrings.Add('vbDefaultButton4=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDefaultButton4\style{-B}');
    AStrings.Add('vbApplicationModal=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbApplicationModal\style{-B}');
    AStrings.Add('vbSystemModal=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbSystemModal\style{-B}');
    AStrings.Add('vbOK=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbOK\style{-B}');
    AStrings.Add('vbCancel=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbCancel\style{-B}');
    AStrings.Add('vbAbort=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbAbort\style{-B}');
    AStrings.Add('vbRetry=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbRetry\style{-B}');
    AStrings.Add('vbIgnore=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbIgnore\style{-B}');
    AStrings.Add('vbYes=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbYes\style{-B}');
    AStrings.Add('vbNo=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbNo\style{-B}');
    AStrings.Add('vbCr=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbCr\style{-B}');
    AStrings.Add('VbCrLf=\color{clGreen}constant \color{clBlack}\column{}\style{+B}VbCrLf\style{-B}');
    AStrings.Add('vbFormFeed=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFormFeed\style{-B}');
    AStrings.Add('vbLf=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbLf\style{-B}');
    AStrings.Add('vbNewLine=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbNewLine\style{-B}');
    AStrings.Add('vbNullChar=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbNullChar\style{-B}');
    AStrings.Add('vbNullString=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbNullString\style{-B}');
    AStrings.Add('vbTab=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbTab\style{-B}');
    AStrings.Add('vbVerticalTab=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbVerticalTab\style{-B}');
    AStrings.Add('vbSunday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbSunday\style{-B}');
    AStrings.Add('vbMonday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbMonday\style{-B}');
    AStrings.Add('vbTuesday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbTuesday\style{-B}');
    AStrings.Add('vbWednesday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbWednesday\style{-B}');
    AStrings.Add('vbThursday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbThursday\style{-B}');
    AStrings.Add('vbFriday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFriday\style{-B}');
    AStrings.Add('vbSaturday=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbSaturday\style{-B}');
    AStrings.Add('vbUseSystemDayOfWeek=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbUseSystemDayOfWeek\style{-B}');
    AStrings.Add('vbFirstJan1=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFirstJan1\style{-B}');
    AStrings.Add('vbFirstFourDays=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFirstFourDays\style{-B}');
    AStrings.Add('vbFirstFullWeek=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFirstFullWeek\style{-B}');
    AStrings.Add('vbGeneralDate=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbGeneralDate\style{-B}');
    AStrings.Add('vbLongDate=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbLongDate\style{-B}');
    AStrings.Add('vbShortDate=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbShortDate\style{-B}');
    AStrings.Add('vbLongTime=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbLongTime\style{-B}');
    AStrings.Add('vbShortTime=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbShortTime\style{-B}');
    AStrings.Add('vbBlack=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbBlack\style{-B}');
    AStrings.Add('vbRed=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbRed\style{-B}');
    AStrings.Add('vbGreen=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbGreen\style{-B}');
    AStrings.Add('vbYellow=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbYellow\style{-B}');
    AStrings.Add('vbBlue=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbBlue\style{-B}');
    AStrings.Add('vbMagenta=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbMagenta\style{-B}');
    AStrings.Add('vbCyan=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbCyan\style{-B}');
    AStrings.Add('vbWhite=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbWhite\style{-B}');
    AStrings.Add('vbBinaryCompare=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbBinaryCompare\style{-B}');
    AStrings.Add('vbTextCompare=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbTextCompare\style{-B}');
    AStrings.Add('vbObjectError=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbObjectError\style{-B}');
    AStrings.Add('vbUseDefault=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbUseDefault\style{-B}');
    AStrings.Add('vbTrue=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbTrue\style{-B}');
    AStrings.Add('vbFalse=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbFalse\style{-B}');
    AStrings.Add('vbEmpty=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbEmpty\style{-B}');
    AStrings.Add('vbNull=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbNull\style{-B}');
    AStrings.Add('vbInteger=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbInteger\style{-B}');
    AStrings.Add('vbLong=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbLong\style{-B}');
    AStrings.Add('vbSingle=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbSingle\style{-B}');
    AStrings.Add('vbDouble=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDouble\style{-B}');
    AStrings.Add('vbCurrency=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbCurrency\style{-B}');
    AStrings.Add('vbDate=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDate\style{-B}');
    AStrings.Add('vbString=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbString\style{-B}');
    AStrings.Add('vbObject=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbObject\style{-B}');
    AStrings.Add('vbError=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbError\style{-B}');
    AStrings.Add('vbBoolean=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbBoolean\style{-B}');
    AStrings.Add('vbVariant=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbVariant\style{-B}');
    AStrings.Add('vbDataObject=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDataObject\style{-B}');
    AStrings.Add('vbDecimal=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbDecimal\style{-B}');
    AStrings.Add('vbByte=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbByte\style{-B}');
    AStrings.Add('vbArray=\color{clGreen}constant \color{clBlack}\column{}\style{+B}vbArray\style{-B}');
  end;
  if AClass = 'FONT' then
  begin
    AStrings.Add('Charset=\color{clNavy}property \color{clBlack}\column{}\style{+B}Charset\style{-B}: TFontCharset');
    AStrings.Add('Color=\color{clNavy}property \color{clBlack}\column{}\style{+B}Color\style{-B}: TColor');
    AStrings.Add('Height=\color{clNavy}property \color{clBlack}\column{}\style{+B}Height\style{-B}: Integer');
    AStrings.Add('Name=\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\style{-B}: TFontName');
    AStrings.Add('Orientation=\color{clNavy}property \color{clBlack}\column{}\style{+B}Orientation\style{-B}: Integer');
    AStrings.Add('Pitch=\color{clNavy}property \color{clBlack}\column{}\style{+B}Pitch\style{-B}: TFontPitch');
    AStrings.Add('Size=\color{clNavy}property \color{clBlack}\column{}\style{+B}Size\style{-B}: Integer');
    AStrings.Add('Style=\color{clNavy}property \color{clBlack}\column{}\style{+B}Style\style{-B}: TFontStyles');
  end;
  if AClass = 'LINES' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}: Integer');
    AStrings.Add('Add=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Add\style{-B}(Value:String,[Index: Integer])');
    AStrings.Add('Clear=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Clear\style{-B}');
    AStrings.Add('Text=\color{clNavy}property \color{clBlack}\column{}\style{+B}Text\style{-B}: String');
  end;
  if AClass = 'ISHELLDISPATCH' then
  begin
    AStrings.Add('Application=\color{clNavy}property \color{clBlack}\column{}\style{+B}Application\Style{-B}:IShellDispatch');
    AStrings.Add('Parent=\color{clNavy}property \color{clBlack}\column{}\style{+B}Parent\Style{-B}:IShellDispatch');
    AStrings.Add('MinimizeAll=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MinimizeAll\style{-B}');
    AStrings.Add('UndoMinimizeAll=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}UndoMinimizeAll\style{-B}');
    AStrings.Add('TileHorizontally=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}TileHorizontally\style{-B}');
    AStrings.Add('TileVertically=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}TileVerticaly\style{-B}');
    AStrings.Add('CascadeWindows=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CascadeWindows\style{-B}');
    AStrings.Add('Explore=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Explore(path)\style{-B}');
    AStrings.Add('Open=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Open(path)\style{-B}');
    AStrings.Add('NameSpace=\color{clBlue}function \color{clBlack}\column{}\style{+B}NameSpace(path)\style{-B}:IShellFolder');
    AStrings.Add('FileRun=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}FileRun\style{-B}');
    AStrings.Add('FindComputer=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}FindComputer\style{-B}');
    AStrings.Add('FindFiles=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}FindFiles\style{-B}');
    AStrings.Add('FindPrinter=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}FindPrinter([Name],[Location],[Model})\style{-B}');
    AStrings.Add('Help=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Help\style{-B}');
    AStrings.Add('ShutdownWindows=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ShutdownWindows\style{-B}');
    AStrings.Add('SetTime=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SetTime\style{-B}');
    AStrings.Add('TrayProperties=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}TrayProperties\style{-B}');
    AStrings.Add('ControlPanelItem=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ControlPanelItem(Filename)\style{-B}');
    AStrings.Add('BrowseForFolder=\color{clBlue}function \color{clBlack}\column{}\style{+B}BrowseForFolder(hwnd, title, ptions, [root folder])\style{-B}:IShellFolder');
    AStrings.Add('Windows=\color{clBlue}function \color{clBlack}\column{}\style{+B}Windows\style{-B}:IShellWindows');
    AStrings.Add('CanStartStopService=\color{clBlue}function \color{clBlack}\column{}\style{+B}CanStartStopService([erviceName)\style{-B}:boolean');
    AStrings.Add('IsServiceRunning=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsServiceRunning(ServiceName)\style{-B}:boolean');
    AStrings.Add('ServiceStart=\color{clBlue}function \color{clBlack}\column{}\style{+B}ServiceStart(ServiceName, [Persistent])\style{-B}:boolean');
    AStrings.Add('ServiceStop=\color{clBlue}function \color{clBlack}\column{}\style{+B}ServiceStop(ServiceName, [Persistent])\style{-B}:boolean');
    AStrings.Add('GetSystemInformation=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetSystemInformation(Name)\style{-B}:integer');
    AStrings.Add('IsRestricted=\color{clBlue}function \color{clBlack}\column{}\style{+B}IsRestricted(Group, Restriction)\style{-B}:integer');
    AStrings.Add('ShellExecute=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ShellExecute(File, {Arguments], [Directory], [Operation], [Show])\style{-B}');
    AStrings.Add('AddToRecent=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}AddToRecent(File, [Category])\style{-B}');
    AStrings.Add('ExplorerPolicy=\color{clBlue}function \color{clBlack}\column{}\style{+B}ExplorerPolicy(PolycyName)\style{-B}:variant');
    AStrings.Add('GetSetting=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetSetting(Setting)\style{-B}:variant');
    AStrings.Add('ToggleDesktop=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}ToggleDesktop\style{-B}');
    AStrings.Add('WindowsSecurity=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}WindowsSecurity\style{-B}');
  end;
 if AClass = 'ISHELLFOLDER' then
  begin
    AStrings.Add('Title=\color{clNavy}property \color{clBlack}\column{}\style{+B}Title\style{-B}:string');
    AStrings.Add('Self=\color{clNavy}property \color{clBlack}\column{}\style{+B}Self\style{-B}:IShellFolderItem');
    AStrings.Add('ParentFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}ParentFolder\style{-B}:IShellFolder');
    AStrings.Add('Application=\color{clNavy}property \color{clBlack}\column{}\style{+B}Application\style{-B}:IShellDispatch');
    AStrings.Add('OfflineStatus=propety \column{}\style{+B}OfflineStatus\style{-B}:integer');
    AStrings.Add('NewFolder=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}NewFolder(Name, [options])\style{-B}');
    AStrings.Add('CopyHere=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CopyHere(Path, [options])\style{-B}');
    AStrings.Add('MoveHere=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MoveHere(Path, [options])\style{-B}');
    AStrings.Add('Items=\color{clBlue}function \color{clBlack}\column{}\style{+B}Items\style{-B}:IShellFolderItems');
    AStrings.Add('ParseName=\color{clBlue}function \color{clBlack}\column{}\style{+B}ParseName(Name)\style{-B}:IShellFolderItem');
    AStrings.Add('GetDetailsOf=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetDetailsOf(Obj, options)\style{-B}:string');
    AStrings.Add('DissmisedWebViewBarricade=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}DissmisedWebViewBarricade\style{-B}');
    AStrings.Add('Synchronize=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Synchronize\style{-B}');
  end;
  if AClass = 'ISHELLFOLDERITEMS' then
  begin
    AStrings.Add('Application=\color{clNavy}property \color{clBlack}\column{}\style{+B}Application\style{-B}:IShellDispatch');
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Verbs=\color{clNavy}property \color{clBlack}\column{}\style{+B}Verbs\style{-B}:IShellFolderItemVerbs');
    AStrings.Add('Item=\color{clBlue}function \color{clBlack}\column{}\style{+B}Item\style{-B}:IShellFolderItem');
    AStrings.Add('InvokeVerbEx=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}InvokeVerbEx([Verb], [Args])\style{-B}');
    AStrings.Add('Filter=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Filter(flags, Filter)\style{-B}');
  end;
   if AClass = 'ISHELLFOLDERITEM' then
  begin
    AStrings.Add('Application=\color{clNavy}property \color{clBlack}\column{}\style{+B}Application\style{-B}:IShellDispatch');
    AStrings.Add('GetFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}GetFolder\style{-B}:IShellFolder');
    AStrings.Add('GetLink=\color{clNavy}property \color{clBlack}\column{}\style{+B}GetLink\style{-B}:IShellLinkObject');
    AStrings.Add('IsBrowsable=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsBrowsable\style{-B}:boolean');
    AStrings.Add('IsFileSystem=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsFileSystem\style{-B}:boolean');
    AStrings.Add('IfFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsFolder\style{-B}:boolean');
    AStrings.Add('IsLink=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsLink\style{-B}:boolean');
    AStrings.Add('ModifyDate=\color{clNavy}property \color{clBlack}\column{}\style{+B}ModifyDate\style{-B}:string');
    AStrings.Add('Name=\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\style{-B}:string');
    AStrings.Add('Parent=\color{clNavy}property \color{clBlack}\column{}\style{+B}Parent\style{-B}:IShellFolder');
    AStrings.Add('Path=\color{clNavy}property \color{clBlack}\column{}\style{+B}Path\style{-B}:string');
    AStrings.Add('Size=\color{clNavy}property \color{clBlack}\column{}\style{+B}Size\style{-B}:integer');
    AStrings.Add('Type=propety \column{}\style{+B}Type\style{-B}:string');
    AStrings.Add('InvokeVerb=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}InvokeVerb([Verb])\style{-B}');
    AStrings.Add('InvokeVerbEx=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}InvokeVerbEx([Verb], [Args])\style{-B}');
    AStrings.Add('Verbs=\color{clBlue}function \color{clBlack}\column{}\style{+B}Verbs\style{-B}:IShellFolderItemVerbs');
    AStrings.Add('ExtendedProperty=\color{clBlue}function \color{clBlack}\column{}\style{+B}ExtendedProperty(Name)\style{-B}');
  end;
  if AClass = 'ISHELLWINDOWS' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}');
  end;
  if AClass = 'ISHELLLINKOBJECT' then
  begin
    AStrings.Add('Arguments=\color{clNavy}property \color{clBlack}\column{}\style{+B}Arguments\style{-B}:string');
    AStrings.Add('Description=\color{clNavy}property \color{clBlack}\column{}\style{+B}Description\style{-B}:string');
    AStrings.Add('HotKey=\color{clNavy}property \color{clBlack}\column{}\style{+B}HotKey\style{-B}:integer');
    AStrings.Add('Path=\color{clNavy}property \color{clBlack}\column{}\style{+B}Path\style{-B}:string');
    AStrings.Add('ShowCommand=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShowCommand\style{-B}:integer');
    AStrings.Add('WorkingDirectory=\color{clNavy}property \color{clBlack}\column{}\style{+B}WorkingDirectory\style{-B}:string');
    AStrings.Add('Target=\color{clNavy}property \color{clBlack}\column{}\style{+B}Target\style{-B}:IForderItem');
    AStrings.Add('GetIconLocation=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetIconLocation(Path)\style{-B}:integer');
    AStrings.Add('Resolve=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Resolve(Flags)\style{-B}');
    AStrings.Add('Save=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Save(File)\style{-B}');
    AStrings.Add('SetIconLocation=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SetIconLocation(Path, Index)\style{-B}');
  end;
  if AClass = 'ISHELLFOLDERITEMVERBS' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}:IFoldeItemVerb');
  end;
  if AClass = 'ISHELLFOLDERITEMVERB' then
  begin
    AStrings.Add('Name=\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\style{-B}:string');
    AStrings.Add('DoIt=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}DoIt\style{-B}');
  end;
  if AClass = 'IREGEXP' then
  begin
    AStrings.Add('Global=\color{clNavy}property \color{clBlack}\column{}\style{+B}Global\style{-B}:boolean');
    AStrings.Add('IgnoreCase=\color{clNavy}property \color{clBlack}\column{}\style{+B}IgnoreCase\style{-B}:boolean');
    AStrings.Add('Pattern=\color{clNavy}property \color{clBlack}\column{}\style{+B}Pattern\style{-B}:string');
    AStrings.Add('Multiline=\color{clNavy}property \color{clBlack}\column{}\style{+B}MultiLine\style{-B}:boolean');
    AStrings.Add('Replace=\color{clBlue}function \color{clBlack}\column{}\style{+B}Replace(strSource,strReplace)\style{-B}:string');
    AStrings.Add('Test=\color{clBlue}function \color{clBlack}\column{}\style{+B}Test(strSource)style{-B}:boolean');
    AStrings.Add('Execute=\color{clBlue}function \color{clBlack}\column{}\style{+B}Execute(strSource)\style{-B}:IRegExpMatches');
  end;
  if AClass = 'IREGEXPMATCHES' then
  begin
   AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
   AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}:IRegExpMatch');
  end;
  if AClass = 'IREGEXPMATCH' then
  begin
    AStrings.Add('Value=propety \column{}\style{+B}Value\style{-B}:string');
    AStrings.Add('FirstIndex=propety \column{}\style{+B}FirsIndex\style{-B}:integer');
    AStrings.Add('Length=propety \column{}\style{+B}Length\style{-B}:integer');
  end;
  if AClass = 'IFILESYSTEMOBJECT' then
  begin
    AStrings.Add('Drives=\color{clNavy}property \color{clBlack}\column{}\style{+B}Drives\style{-B}: IDriveCollection');
    AStrings.Add('BuildPath=\color{clBlue}function \color{clBlack}\column{}\style{+B}BuildPath(Path: OleStr;Name: OleStr)\style{-B}: OleStr');
    AStrings.Add('GetDriveName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetDriveName\style{-B}: OleStr');
    AStrings.Add('GetParentFolderName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetParentFolderName\style{-B}: OleStr');
    AStrings.Add('GetFileName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetFileName\style{-B}: OleStr');
    AStrings.Add('function \column{}\style{+B}GetBaseName\style{-B}: OleStr');
    AStrings.Add('GetBaseName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetExtensionName\style{-B}: OleStr');
    AStrings.Add('GetAbsolutePathName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetAbsolutePathName\style{-B}: OleStr');
    AStrings.Add('GetTempName=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetTempName\style{-B}: OleStr');
    AStrings.Add('DriveExists=\color{clBlue}function \color{clBlack}\column{}\style{+B}DriveExists\style{-B}: Boolean');
    AStrings.Add('FileExists=\color{clBlue}function \color{clBlack}\column{}\style{+B}FileExists\style{-B}: Boolean');
    AStrings.Add('FolderExists=\color{clBlue}function \color{clBlack}\column{}\style{+B}FolderExists\style{-B}: Boolean');
    AStrings.Add('GetDrive=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetDrive\style{-B}: IDrive');
    AStrings.Add('GetFile=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetFile\style{-B}: IFile');
    AStrings.Add('GetFolder=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetFolder\style{-B}: IFolder');
    AStrings.Add('GetSpecialFolder=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetSpecialFolder\style{-B}: IFolder');
    AStrings.Add('DeleteFile=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}DeleteFile(FileSpec: OleStr;Force: Boolean)\style{-B}');
    AStrings.Add('DeleteFolder=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}DeleteFolder(FolderSpec: OleStr;Force: Boolean)\style{-B}');
    AStrings.Add('MoveFile=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MoveFile(Source: OleStr;Destination: OleStr)\style{-B}');
    AStrings.Add('MoveFolder=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MoveFolder(Source: OleStr;Destination: OleStr)\style{-B}');
    AStrings.Add('CopyFile=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CopyFile(Source: OleStr;Destination: OleStr;OverWriteFiles: Boolean)\style{-B}');
    AStrings.Add('CopyFolder=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}CopyFolder(Source: OleStr;Destination: OleStr;OverWriteFiles: Boolean)\style{-B}');
    AStrings.Add('CreateFolder=\color{clBlue}function \color{clBlack}\column{}\style{+B}CreateFolder\style{-B}: IFolder');
    AStrings.Add('CreateTextFile=\color{clBlue}function \color{clBlack}\column{}\style{+B}CreateTextFile(FileName: OleStr;Overwrite: Boolean;Unicode: Boolean)\style{-B}: ITextStream');
    AStrings.Add('OpenTextFile=\color{clBlue}function \color{clBlack}\column{}\style{+B}OpenTextFile(FileName: OleStr;IOMode: IOMode;Create: Boolean;Format: Tristate)\style{-B}: ITextStream');
    AStrings.Add('GetStandardStream=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetStandardStream(StandardStreamType: StandardStreamTypes;Unicode: Boolean)\style{-B}: ITextStream');
    AStrings.Add('GetFileVersion=\color{clBlue}function \color{clBlack}\column{}\style{+B}GetFileVersion\style{-B}: OleStr');
  end;
  if AClass = 'IDRIVECOLLECTION' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}:IDrive');
  end;
  if AClass = 'IDRIVE' then
  begin
    AStrings.Add('Path=\color{clNavy}property \color{clBlack}\column{}\style{+B}Path\style{-B}:OleStr');
    AStrings.Add('DriveLetter=\color{clNavy}property \color{clBlack}\column{}\style{+B}DriveLetter\style{-B}:OleStr');
    AStrings.Add('ShareName=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShareName\style{-B}:OleStr');
    AStrings.Add('DriveType=\color{clNavy}property \color{clBlack}\column{}\style{+B}DriveType\style{-B}:DriveTypeConst');
    AStrings.Add('RootFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}RootFolder\style{-B}:IFolder');
    AStrings.Add('AvailableSpace=\color{clNavy}property \color{clBlack}\column{}\style{+B}AvailableSpace\style{-B}:Variant');
    AStrings.Add('FreeSpace=\color{clNavy}property \color{clBlack}\column{}\style{+B}FreeSpace\style{-B}:Variant');
    AStrings.Add('TotalSize=\color{clNavy}property \color{clBlack}\column{}\style{+B}TotalSize\style{-B}:Variant');
    AStrings.Add('VolumeName=\color{clNavy}property \color{clBlack}\column{}\style{+B}VolumeName\style{-B}:OleStr');
    AStrings.Add('FileSystem=\color{clNavy}property \color{clBlack}\column{}\style{+B}FileSystem\style{-B}:OleStr');
    AStrings.Add('SerialNumber=\color{clNavy}property \color{clBlack}\column{}\style{+B}SerialNumber\style{-B}:Integer');
    AStrings.Add('IsReady=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsReady\style{-B}:Boolean');
  end;
  if AClass = 'IFILECOLLECTION' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}:IFile');
  end;
  if AClass = 'IFILE' then
  begin
    AStrings.Add('Path=\color{clNavy}property \color{clBlack}\column{}\style{+B}Path\style{-B}:OleStr');
    AStrings.Add('Name=\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\style{-B}:OleStr');
    AStrings.Add('ShortPath=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShortPath\style{-B}:OleStr');
    AStrings.Add('ShortName=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShortName\style{-B}:OleStr');
    AStrings.Add('Drive=\color{clNavy}property \color{clBlack}\column{}\style{+B}Drive\style{-B}:IDrive');
    AStrings.Add('ParentFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}ParentFolder\style{-B}:IFolder');
    AStrings.Add('Attributes=\color{clNavy}property \color{clBlack}\column{}\style{+B}Attributes\style{-B}:FileAttribute');
    AStrings.Add('DateCreated=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateCreated\style{-B}:Date');
    AStrings.Add('DateLastModified=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateLastModified\style{-B}:Date');
    AStrings.Add('DateLastAccessed=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateLastAccessed\style{-B}:Date');
    AStrings.Add('Size=\color{clNavy}property \color{clBlack}\column{}\style{+B}Size\style{-B}:Variant');
    AStrings.Add('Type=\color{clNavy}property \color{clBlack}\column{}\style{+B}Type\style{-B}:OleStr');
    AStrings.Add('Delete=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Delete\style{-B}');
    AStrings.Add('Copy=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Copy(Destination :OleStr; OverWriteFiles :Boolean)\style{-B}');
    AStrings.Add('Move=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Move\style{-B}');
    AStrings.Add('OpenAsTextStream=\color{clBlue}function \color{clBlack}\column{}\style{+B}OpenAsTextStream(IOMode :IOMode; Format :Tristate)\style{-B}:ITextStream');
  end;
  if AClass = 'IFOLDERCOLLECTION' then
  begin
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:integer');
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item\style{-B}:IFolder');
  end;
  if AClass = 'IFOLDER' then
  begin
    AStrings.Add('Path=\color{clNavy}property \color{clBlack}\column{}\style{+B}Path\style{-B}:OleStr');
    AStrings.Add('Name=\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\style{-B}:OleStr');
    AStrings.Add('ShortPath=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShortPath\style{-B}:OleStr');
    AStrings.Add('ShortName=\color{clNavy}property \color{clBlack}\column{}\style{+B}ShortName\style{-B}:OleStr');
    AStrings.Add('Drive=\color{clNavy}property \color{clBlack}\column{}\style{+B}Drive\style{-B}:IDrive');
    AStrings.Add('ParentFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}ParentFolder\style{-B}:IFolder');
    AStrings.Add('Attributes=\color{clNavy}property \color{clBlack}\column{}\style{+B}Attributes\style{-B}:FileAttribute');
    AStrings.Add('DateCreated=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateCreated\style{-B}:Date');
    AStrings.Add('DateLastModified=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateLastModified\style{-B}:Date');
    AStrings.Add('DateLastAccessed=\color{clNavy}property \color{clBlack}\column{}\style{+B}DateLastAccessed\style{-B}:Date');
    AStrings.Add('Type=\color{clNavy}property \color{clBlack}\column{}\style{+B}Type\style{-B}:OleStr');
    AStrings.Add('Delete=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Delete\style{-B}');
    AStrings.Add('Copy=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Copy(Destination :OleStr; OverWriteFiles :Boolean)\style{-B}');
    AStrings.Add('Move=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Move\style{-B}');
    AStrings.Add('IsRootFolder=\color{clNavy}property \color{clBlack}\column{}\style{+B}IsRootFolder\style{-B}:Boolean');
    AStrings.Add('Size=\color{clNavy}property \color{clBlack}\column{}\style{+B}Size\style{-B}:Variant');
    AStrings.Add('SubFolders=\color{clNavy}property \color{clBlack}\column{}\style{+B}SubFolders\style{-B}:IFolderCollection');
    AStrings.Add('Files=\color{clNavy}property \color{clBlack}\column{}\style{+B}Files\style{-B}:IFileCollection');
    AStrings.Add('CreateTextFile=\color{clBlue}function \color{clBlack}\column{}\style{+B}CreateTextFile(FileName :OleStr; Overwrite :Boolean; Unicode :Boolean)\style{-B}:ITextStream');
  end;
  if AClass = 'ITEXTSTREAM' then
  begin
    AStrings.Add('Line=\color{clNavy}property \color{clBlack}\column{}\style{+B}Line\style{-B}:Integer');
    AStrings.Add('Column=\color{clNavy}property \color{clBlack}\column{}\style{+B}Column\style{-B}:Integer');
    AStrings.Add('AtEndOfStream=\color{clNavy}property \color{clBlack}\column{}\style{+B}AtEndOfStream\style{-B}:Boolean');
    AStrings.Add('AtEndOfLine=\color{clNavy}property \color{clBlack}\column{}\style{+B}AtEndOfLine\style{-B}:Boolean');
    AStrings.Add('Read=\color{clBlue}function \color{clBlack}\column{}\style{+B}Read(NumberOfChars)\style{-B}:OleStr');
    AStrings.Add('ReadLine=\color{clBlue}function \color{clBlack}\column{}\style{+B}ReadLine\style{-B}:OleStr');
    AStrings.Add('ReadAll=\color{clBlue}function \color{clBlack}\column{}\style{+B}ReadAll\style{-B}:OleStr');
    AStrings.Add('Write=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Write(String)\style{-B}');
    AStrings.Add('WriteLine=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}WriteLine(String)\style{-B}');
    AStrings.Add('WriteBlankLines=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}WriteBlankLines(NumberOfString)\style{-B}');
    AStrings.Add('Skip=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Skip(NumberOfChars)\style{-B}');
    AStrings.Add('SkipLine=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SkipLine\style{-B}');
    AStrings.Add('Close=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Close\style{-B}');
  end;
  if AClass = 'IDICTIONARY' then
  begin
    AStrings.Add('Item=\color{clNavy}property \color{clBlack}\column{}\style{+B}Item(Key :Variant; riid :Variant)\style{-B}');
    AStrings.Add('Add=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Add(Key :Variant; Item :Variant)\style{-B}');
    AStrings.Add('Count=\color{clNavy}property \color{clBlack}\column{}\style{+B}Count\style{-B}:Integer');
    AStrings.Add('Exists=\color{clBlue}function \color{clBlack}\column{}\style{+B}Exists\style{-B}:Boolean');
    AStrings.Add('Items=\color{clBlue}function \color{clBlack}\column{}\style{+B}Items\style{-B}:Variant');
    AStrings.Add('Key=\color{clNavy}property \color{clBlack}\column{}\style{+B}Key(Key :Variant; Item :Variant)\style{-B}');
    AStrings.Add('Keys=\color{clBlue}function \color{clBlack}\column{}\style{+B}Keys\style{-B}:Variant');
    AStrings.Add('Remove=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Remove\style{-B}');
    AStrings.Add('RemoveAll=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}RemoveAll\style{-B}');
    AStrings.Add('CompareMode=\color{clNavy}property \color{clBlack}\column{}\style{+B}CompareMode\style{-B}:CompareMethod');
    AStrings.Add('HashVal=\color{clNavy}property \color{clBlack}\column{}\style{+B}HashVal\style{-B}:Variant');
  end;
  if AClass = 'IWSHSHELL' then
  begin
    AStrings.Add('CurrentDirectory=\color{clNavy}property \color{clBlack}\column{}\style{+B}CurrentDirectory\style{-B}:OleStr');
    AStrings.Add('Environment=\color{clNavy}property \color{clBlack}\column{}\style{+B}Environment([type])\style{-B}');
    AStrings.Add('SpecialFolders=\color{clNavy}property \color{clBlack}\column{}\style{+B}SpecialFolders([WshFolders])\style{-B}');
    AStrings.Add('ExpandEnvironmentStrings=\color{clBlue}function \color{clBlack}\column{}\style{+B}ExpandEnvironmentStrings(<String>)\style{-B}:OleStr');
    AStrings.Add('Popup=\color{clBlue}function \color{clBlack}\column{}\style{+B}Popup(<Text>,<SecondsToWait>,<Title>,<Type>)\Style{-B}:integer');
    AStrings.Add('SendKeys=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SendKeys(<String>)\style{-B}');
    AStrings.Add('Run=\color{clBlue}function \color{clBlack}\column{}\style{+B}Run(<Command>,<WindowStyle>,<WaitOnReturn>)\style{-B}:integer');
    AStrings.Add('Exec=\color{clBlue}function \color{clBlack}\column{}\style{+B}Exec(<Command>)\style{-B}:IWshScriptExec');
    AStrings.Add('AppActivate=\color{clBlue}function \color{clBlack}\column{}\style{+B}AppActivate(<Title>)\style{-B}:boolean');
    AStrings.Add('RegDelete=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}RegDelete(<Name>)\style{-B}');
    AStrings.Add('RegRead=\color{clBlue}function \color{clBlack}\column{}\style{+B}RegRead(<Name>)\style{-B}:Variant');
    AStrings.Add('RegWrite=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}RegWrite(<Name>,<Value>,<Type>)\style{-B}');
    AStrings.Add('LogEvent=\color{clBlue}function \color{clBlack}\column{}\style{+B}LogEvent(<Type>,<Message>,<Target>)\style{-B}:boolean');
    AStrings.Add('CreateShortcut=\color{clBlue}function \color{clBlack}\column{}\style{+B}CreateShortcut(<Path>)\style{-B}:IWhShortCut');
  end;
  if AClass = 'IWSHSCRIPTEXEC' then
  begin
    AStrings.Add('ExitCode=\color{clNavy}property \color{clBlack}\column{}\style{+B}ExitCode\style{-B}:integer');
    AStrings.Add('ProccesID=\color{clNavy}property \color{clBlack}\column{}\style{+B}ProcessID\style{-B}:integer');
    AStrings.Add('Status=\color{clNavy}property \color{clBlack}\column{}\style{+B}Status\style{-B}:integer');
    AStrings.Add('Terminate=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Terminate\style{-B}');
  end;
  if AClass = 'IWSHSHORTCUT' then
  begin
    AStrings.Add('Arguments=\color{clNavy}property \color{clBlack}\column{}\style{+B}Arguments\style{-B}:string');
    AStrings.Add('Description=\color{clNavy}property \color{clBlack}\column{}\style{+B}Description\style{-B}:string');
    AStrings.Add('FullName=\color{clNavy}property \color{clBlack}\column{}\style{+B}FullName\style{-B}:string');
    AStrings.Add('Hotkey=\color{clNavy}property \color{clBlack}\column{}\style{+B}Hotkey\style{-B}:string');
    AStrings.Add('IconLocation=\color{clNavy}property \color{clBlack}\column{}\style{+B}IconLocation\style{-B}:string');
    AStrings.Add('TargetPath=\color{clNavy}property \color{clBlack}\column{}\style{+B}TargetPath\style{-B}:string');
    AStrings.Add('WindowStyle=\color{clNavy}property \color{clBlack}\column{}\style{+B}WindowStyle\style{-B}:integer');
    AStrings.Add('WorkingDirectory=\color{clNavy}property \color{clBlack}\column{}\style{+B}WorkingDirectory\style{-B}:string');
  end;
  if AClass = 'IWSHNETWORK' then
  begin
    AStrings.Add('ComputerName=\color{clNavy}property \color{clBlack}\column{}\style{+B}ComputerName\{-B}:string');
    AStrings.Add('UserName=\color{clNavy}property \color{clBlack}\column{}\style{+B}UserName\{-B}:string');
    AStrings.Add('UserDomain=\color{clNavy}property \color{clBlack}\column{}\style{+B}UserDomain\{-B}:string');
    AStrings.Add('EnumNetworkDrives=\color{clBlue}function \color{clBlack}\column{}\style{+B}EnumNetworkDrives\{-B}');
    AStrings.Add('EnumPrinterConnections=\color{clBlue}function \color{clBlack}\column{}\style{+B}EnumPrinterConnections\{-B}');
    AStrings.Add('MapNetworkDrive=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}MapNetworkDrive(<LocalName>,<RemoteName>,<UpdateProfile>, <User>,<Password>)\style{-B}');
    AStrings.Add('RemoveNetworkDrive=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}RemoveNetworkDrive(<Name>,<Force>,<UpdateProfile>)\style{-B}');
    AStrings.Add('AddPrinterConnection=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}AddPrinterConnection(<LocalName>,<RemoteName>,<UpdateProfile>, <User>,<Password>)\style{-B}');
    AStrings.Add('AddWindowsPrinterConnection=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}AddWindowsPrinterConnection(<PrinterPath>,<DriverName>,<Port>) \style{-B}');
    AStrings.Add('RemovePrinterConnection=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}RemovePrinterConnection(<Name>,<Force>,<UpdateProfile>) \style{-B}');
    AStrings.Add('SetDefaultPrinter=\color{clTeal}procedure \color{clBlack}\column{}\style{+B}SetDefaultPrinter(<Name>)\style{-B}');
  end;
end;

procedure GetClassProperty2(AClass: string; AStrings: TStrings);
var
  SomeComp: TObject;
  i:integer;
begin
  AStrings.Clear;
  if TestPattern_(AClass,['TFORM','TPANEL','TGROUPBOX','TTABSHEET','TPAGECONTROL','TTOOLBAR']) then
  begin
    AStrings.Add('procedure Add Component, ClassName, [Events = false]');
    AStrings.Add('property Count: Integer');
  end;
  if AClass='REPORT' then
  begin
    AStrings.Add('procedure PDF417Param Col, Row');
    AStrings.Add('procedure ShowReport');
    AStrings.Add('property PDF417Code(Object): Text');
    AStrings.Add('property QRCode(Object): Text');
    AStrings.Add('property LoadImage(Object): Base64Text');
  end;
  if AClass='TFORM' then 
  begin
    AStrings.Add('procedure Show');
    AStrings.Add('procedure Close');
    AStrings.Add('function ShowModal: ModalResult');
    AStrings.Add('property ModalResult: ModalResult');
  end;
  if TestPattern_(AClass,['TGRID_FRAME']) then
  begin
    AStrings.Add('procedure SetQuery NewQuery');
    AStrings.Add('procedure Refresh');
  end;
  if TestPattern_(AClass,['TLISTBOX', 'TCHECKLISTBOX']) then
  begin
    AStrings.Add('property Selected(ID): boolean');
    AStrings.Add('procedure DeleteSelected');
    if AClass='TCHECKLISTBOX' then AStrings.Add('property Checked(ID): boolean');
  end;
  if TestPattern_(AClass,['TLINESERIES', 'TBARSERIES', 'TPIESERIES', 'TAREASERIES']) then
  begin
    AStrings.Add('procedure Add Value, Caption, [Color]');
    AStrings.Add('Cprocedure Clear');
  end;
  if AClass='TCHART' then
  begin
   AStrings.Add('procedure AddSeries Series');
   AStrings.Add('procedure ClearSeries');
  end;
  if AClass='TIMAGE' then
  begin
    AStrings.Add('procedure LoadImageFromBase64 BASE64String');
    AStrings.Add('procedure QRCode Value');
    AStrings.Add('procedure CopyToClipboard');
  end;
  if Copy(AClass,1,1)='T' then
  begin
    AStrings.Add('function Controls(ID): IDispatch');
    AStrings.Add('function HasProperty(PropertyName): boolean');
    SomeComp := CreateAClass(AClass);
    GetClassProperties2(SomeComp, AStrings);
    SomeComp.Free;
  end;
  if AClass='ERR' then
  begin
     AStrings.Add('procedure Clear');
     AStrings.Add('procedure Raise number, source, description, helpfile, helpcontext');
     AStrings.Add('property Description: String');
     AStrings.Add('property Number: Integer');
     AStrings.Add('property Source: String');
     AStrings.Add('property HelpFile: String');
     AStrings.Add('property HelpContext: String');
  end;
  if AClass = 'DEBUG' then
  begin
    AStrings.Add('procedure Print "..."');
    AStrings.Add('procedure Error "..."');
    AStrings.Add('procedure Warning "..."');
    AStrings.Add('procedure Info "..."');
    AStrings.Add('procedure ClearText');
    AStrings.Add('procedure ClearMessages');
  end;
  if AClass = 'DICT' then
  begin
     AStrings.Add('property Field: String');
     AStrings.Add('property DescriptionField: String');
     AStrings.Add('property Description: String');
     AStrings.Add('property SQLDialog: String');
     AStrings.Add('property SQL: String');
     AStrings.Add('property QueryResult: String');
     AStrings.Add('procedure Clear');
     AStrings.Add('procedure Add "..."');
     AStrings.Add('function Execute:Boolean');

  end;
  if AClass = 'APP' then
  begin
    AStrings.Add('property WorkDir: String');
    AStrings.Add('property DBTables: Collection');
    AStrings.Add('property Variables: Collection');
    AStrings.Add('property ModuleGroupss: Collection');
    AStrings.Add('property Tables: Collection');
    AStrings.Add('property WebObjects: Collection');
    AStrings.Add('property Forms: Collection');
    AStrings.Add('function GetFileName:String');
    AStrings.Add('procedure ShowTable "..."');
    AStrings.Add('procedure CloseAllWindow');
    AStrings.Add('procedure SaveConfiguration');
    AStrings.Add('procedure MaximizeAll');
    AStrings.Add('procedure CompactDB');
    AStrings.Add('procedure SaveConfiguration');
    AStrings.Add('procedure StartServer');
    AStrings.Add('procedure StopServer');
    AStrings.Add('procedure Navigate "WEBPage"');
    AStrings.Add('property Port: Integer');
    AStrings.Add('property SQLDiaolg: String');
    AStrings.Add('procedure Terminate');
    AStrings.Add('procedure noConfigure');
    for i := 0 to AppConf_.Variables.Count-1 do
      AStrings.Add('constant ['+AppConf_.Variables.Variable[i].Name+']');
    for i := 0 to AppConf_.Modules.Count-1 do
      AStrings.Add('modulegroup ['+AppConf_.Modules.Modulegroup[i].Name+']');
    for i := 0 to AppConf_.Tables.Count-1 do
      AStrings.Add('table ['+AppConf_.Tables.Table[i].Name+']');
    for i := 0 to AppConf_.Forms.Count-1 do
      AStrings.Add('form ['+AppConf_.Forms.Form[i].Name+']');
  end;
  if AClass = 'QUERY' then
  begin
    AStrings.Add('property SQL: String');
    AStrings.Add('procedure Open');
    AStrings.Add('procedure Close');
    AStrings.Add('procedure First');
    AStrings.Add('procedure Last');
    AStrings.Add('procedure Next');
    AStrings.Add('procedure Prev');
    AStrings.Add('function EOF: boolean');
    AStrings.Add('function BOF: boolean');
    AStrings.Add('function Field(field_id): Variant');
    AStrings.Add('procedure Execute');
  end;
  if AClass = 'LINK' then
  begin
    AStrings.Add('property SQL: String');
    AStrings.Add('procedure Open');
    AStrings.Add('procedure Close');
    AStrings.Add('procedure First');
    AStrings.Add('procedure Last');
    AStrings.Add('procedure Next');
    AStrings.Add('procedure Prev');
    AStrings.Add('function EOF: boolean');
    AStrings.Add('function BOF: boolean');
    AStrings.Add('function Field(field_id): Variant');
    AStrings.Add('Cfunction Column(field_id): String');
    AStrings.Add('function FieldNames(field_id): String');
  end;
  /////////////////////////////////////
  ////////////////////////////////////
  if AClass = '' then
  begin
    AStrings.Add('object App');
    AStrings.Add('object Debug');
    AStrings.Add('object Dict');
    AStrings.Add('function Abs(x)');
    AStrings.Add('function Int(x)');
    AStrings.Add('function Fix(x)');
    AStrings.Add('function Sgn(x)');
    AStrings.Add('function Round(x, [numdecimal])');
    AStrings.Add('function Rnd([x])');
    AStrings.Add('function Sqr(x)');
    AStrings.Add('function Sin(x)');
    AStrings.Add('function Cos(x)');
    AStrings.Add('function Tan(x)');
    AStrings.Add('function Atn(x)');
    AStrings.Add('function Exp(x)');
    AStrings.Add('function Log(x)');
    AStrings.Add('function Asc(str)');
    AStrings.Add('function GetRef(Object)');
    AStrings.Add('function Chr(code)');
    AStrings.Add('function InStr([start,] str1, str2[, compare])');
    AStrings.Add('function InStrRev(str1, str2[, start[, compare]])');
    AStrings.Add('function Join(list[, delim])');
    AStrings.Add('function Split(expr[, delim[, count[, compare]]])');
    AStrings.Add('function LCase(str)');
    AStrings.Add('function UCase(str)');
    AStrings.Add('function Left(str, len)');
    AStrings.Add('function Right(str, len)');
    AStrings.Add('function Mid(str, start[, len]))');
    AStrings.Add('function Len(str)');
    AStrings.Add('function LTrim(str)');
    AStrings.Add('function RTrim(str)');
    AStrings.Add('function Trim(str)');
    AStrings.Add('function Replace(expr, find, replacewith[, start[, count[, compare]]])');
    AStrings.Add('function Space(x)');
    AStrings.Add('function String(number, char)');
    AStrings.Add('function StrComp(str1, str2[, compare])');
    AStrings.Add('function StrReverse(str)');
    AStrings.Add('function FormatCurrency(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])');
    AStrings.Add('function FormatDateTime(date[, namedFormat])');
    AStrings.Add('function FormatNumber(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])');
    AStrings.Add('function FormatPercent(expr[, numDigitsAfterDecimal[, includeLeadDigit[, useParens[, groupDigits]]]])');
    AStrings.Add('function Date()');
    AStrings.Add('function Now()');
    AStrings.Add('function Time()');
    AStrings.Add('function Timer()');
    AStrings.Add('function IsDate(expr)');
    AStrings.Add('function Year(date)');
    AStrings.Add('function Month(date)');
    AStrings.Add('function Day(date)');
    AStrings.Add('function Weekday(date[, firstdayofweek])');
    AStrings.Add('function Hour(time)');
    AStrings.Add('function Minute(time)');
    AStrings.Add('function Second(time)');
    AStrings.Add('function DateValue(date)');
    AStrings.Add('function TimeValue(time)');
    AStrings.Add('function DateSerial(year, month, day)');
    AStrings.Add('function TimeSerial(hour, minute, second)');
    AStrings.Add('function MonthName(month[, abbr])');
    AStrings.Add('function WeekdayName(weekday[, abbr[, firstdayofweek]])');
    AStrings.Add('function DateAdd(interval, number, date)');
    AStrings.Add('function DateDiff(interval, date1, date2[, firstdayofweek[, firstweekofyear]])');
    AStrings.Add('function DatePart(interval, date[, firstdayofweek[, firstweekofyear]])');
    AStrings.Add('function Array(arglist)');
    AStrings.Add('function LBound(arrayname[, dimension])');
    AStrings.Add('function UBound(arrayname[, dimension])');
    AStrings.Add('function Filter(inputStrings, value[, include[, compare]])');
    AStrings.Add('function IsArray(varname)');
    AStrings.Add('function IsDate(varname)');
    AStrings.Add('function IsEmpty(varname)');
    AStrings.Add('function IsNull(varname)');
    AStrings.Add('function IsNumeric(varname)');
    AStrings.Add('function IsObject(varname)');
    AStrings.Add('function VarType(varname)');
    AStrings.Add('function TypeName(varname)');
    AStrings.Add('function Hex(number)');
    AStrings.Add('function Oct(number)');
    AStrings.Add('function MsgBox(prompt[, buttons][, title][, helpfile, context])');
    AStrings.Add('function InputBox(prompt[, title][, default][, xpos][, ypos][, helpfile, context])');
    AStrings.Add('function CreateObject(servername.typename[, location])');
    AStrings.Add('function GetObject([pathname][, classname])');
    AStrings.Add('function CBool(expr)');
    AStrings.Add('function CByte(expr)');
    AStrings.Add('function CCur(expr)');
    AStrings.Add('function CDate(expr)');
    AStrings.Add('function CDbl(expr)');
    AStrings.Add('function CInt(expr)');
    AStrings.Add('function CLng(expr)');
    AStrings.Add('function CSng(expr)');
    AStrings.Add('function CStr(expr)');
    AStrings.Add('function Eval(expr)');
    AStrings.Add('function GetLocale()');
    AStrings.Add('function SetLocale(lcid)');
    AStrings.Add('function ScriptEngine()');
    AStrings.Add('function ScriptEngineBuildVersion()');
    AStrings.Add('function ScriptEngineMajorVersion()');
    AStrings.Add('function ScriptEngineMinorVersion()');
    AStrings.Add('function RGB(red, green, blue)');
    AStrings.Add('constant vbOKOnly');
    AStrings.Add('constant vbOKCancel');
    AStrings.Add('constant vbAbortRetryIgnore');
    AStrings.Add('constant vbYesNoCancel');
    AStrings.Add('constant vbYesNo');
    AStrings.Add('constant vbRetryCancel');
    AStrings.Add('constant vbCritical');
    AStrings.Add('constant vbQuestion');
    AStrings.Add('constant vbExclamation');
    AStrings.Add('constant vbInformation');
    AStrings.Add('constant vbDefaultButton1');
    AStrings.Add('constant vbDefaultButton2');
    AStrings.Add('constant vbDefaultButton3');
    AStrings.Add('constant vbDefaultButton4');
    AStrings.Add('constant vbApplicationModal');
    AStrings.Add('constant vbSystemModal');
    AStrings.Add('constant vbOK');
    AStrings.Add('constant vbCancel');
    AStrings.Add('constant vbAbort');
    AStrings.Add('constant vbRetry');
    AStrings.Add('constant vbIgnore');
    AStrings.Add('constant vbYes');
    AStrings.Add('constant vbNo');
    AStrings.Add('constant vbCr');
    AStrings.Add('constant VbCrLf');
    AStrings.Add('constant vbFormFeed');
    AStrings.Add('constant vbLf');
    AStrings.Add('constant vbNewLine');
    AStrings.Add('constant vbNullChar');
    AStrings.Add('constant vbNullString');
    AStrings.Add('constant vbTab');
    AStrings.Add('constant vbVerticalTab');
    AStrings.Add('constant vbSunday');
    AStrings.Add('constant vbMonday');
    AStrings.Add('constant vbTuesday');
    AStrings.Add('constant vbWednesday');
    AStrings.Add('constant vbThursday');
    AStrings.Add('constant vbFriday');
    AStrings.Add('constant vbSaturday');
    AStrings.Add('constant vbUseSystemDayOfWeek');
    AStrings.Add('constant vbFirstJan1');
    AStrings.Add('constant vbFirstFourDays');
    AStrings.Add('constant vbFirstFullWeek');
    AStrings.Add('constant vbGeneralDate');
    AStrings.Add('constant vbLongDate');
    AStrings.Add('constant vbShortDate');
    AStrings.Add('constant vbLongTime');
    AStrings.Add('constant vbShortTime');
    AStrings.Add('constant vbBlack');
    AStrings.Add('constant vbRed');
    AStrings.Add('constant vbGreen');
    AStrings.Add('constant vbYellow');
    AStrings.Add('constant vbBlue');
    AStrings.Add('constant vbMagenta');
    AStrings.Add('constant vbCyan');
    AStrings.Add('constant vbWhite');
    AStrings.Add('constant vbBinaryCompare');
    AStrings.Add('constant vbTextCompare');
    AStrings.Add('constant vbObjectError');
    AStrings.Add('constant vbUseDefault');
    AStrings.Add('constant vbTrue');
    AStrings.Add('constant vbFalse');
    AStrings.Add('constant vbEmpty');
    AStrings.Add('constant vbNull');
    AStrings.Add('constant vbInteger');
    AStrings.Add('constant vbLong');
    AStrings.Add('constant vbSingle');
    AStrings.Add('constant vbDouble');
    AStrings.Add('constant vbCurrency');
    AStrings.Add('constant vbDate');
    AStrings.Add('constant vbString');
    AStrings.Add('constant vbObject');
    AStrings.Add('constant vbError');
    AStrings.Add('constant vbBoolean');
    AStrings.Add('constant vbVariant');
    AStrings.Add('constant vbDataObject');
    AStrings.Add('constant vbDecimal');
    AStrings.Add('constant vbByte');
    AStrings.Add('constant vbArray');
  end;
  if AClass = 'FONT' then
  begin
    AStrings.Add('property Charset: TFontCharset');
    AStrings.Add('property Color: TColor');
    AStrings.Add('property Height: Integer');
    AStrings.Add('property Name: TFontName');
    AStrings.Add('property Orientation: Integer');
    AStrings.Add('property Pitch: TFontPitch');
    AStrings.Add('property Size: Integer');
    AStrings.Add('property Style: TFontStyles');
  end;
  if AClass = 'LINES' then
  begin
    AStrings.Add('property Count: Integer');
    AStrings.Add('procedure Add(Value:String,[Index: Integer])');
    AStrings.Add('procedure Clear');
    AStrings.Add('property Text: String');
  end;
  if AClass = 'ISHELLDISPATCH' then
  begin
    AStrings.Add('property Application:IShellDispatch');
    AStrings.Add('property Parent:IShellDispatch');
    AStrings.Add('procedure MinimizeAll');
    AStrings.Add('procedure UndoMinimizeAll');
    AStrings.Add('procedure TileHorizontally');
    AStrings.Add('procedure TileVerticaly');
    AStrings.Add('procedure CascadeWindows');
    AStrings.Add('procedure Explore(path)');
    AStrings.Add('procedure Open(path)');
    AStrings.Add('function NameSpace(path):IShellFolder');
    AStrings.Add('procedure FileRun');
    AStrings.Add('procedure FindComputer');
    AStrings.Add('procedure FindFiles');
    AStrings.Add('procedure FindPrinter([Name],[Location],[Model})');
    AStrings.Add('procedure Help');
    AStrings.Add('procedure ShutdownWindows');
    AStrings.Add('procedure SetTime');
    AStrings.Add('procedure TrayProperties');
    AStrings.Add('procedure ControlPanelItem(Filename)');
    AStrings.Add('function BrowseForFolder(hwnd, title, ptions, [root folder]):IShellFolder');
    AStrings.Add('function Windows:IShellWindows');
    AStrings.Add('function CanStartStopService([erviceName):boolean');
    AStrings.Add('function IsServiceRunning(ServiceName):boolean');
    AStrings.Add('function ServiceStart(ServiceName, [Persistent]):boolean');
    AStrings.Add('function ServiceStop(ServiceName, [Persistent]):boolean');
    AStrings.Add('function GetSystemInformation(Name):integer');
    AStrings.Add('function IsRestricted(Group, Restriction):integer');
    AStrings.Add('procedure ShellExecute(File, {Arguments], [Directory], [Operation], [Show])');
    AStrings.Add('procedure AddToRecent(File, [Category])');
    AStrings.Add('function ExplorerPolicy(PolycyName):variant');
    AStrings.Add('function GetSetting(Setting):variant');
    AStrings.Add('procedure ToggleDesktop');
    AStrings.Add('procedure WindowsSecurity');
  end;
 if AClass = 'ISHELLFOLDER' then
  begin
    AStrings.Add('property Title:string');
    AStrings.Add('property Self:IShellFolderItem');
    AStrings.Add('property ParentFolder:IShellFolder');
    AStrings.Add('property Application:IShellDispatch');
    AStrings.Add('propety OfflineStatus:integer');
    AStrings.Add('procedure NewFolder(Name, [options])');
    AStrings.Add('procedure CopyHere(Path, [options])');
    AStrings.Add('procedure MoveHere(Path, [options])');
    AStrings.Add('function Items:IShellFolderItems');
    AStrings.Add('function ParseName(Name):IShellFolderItem');
    AStrings.Add('function GetDetailsOf(Obj, options):string');
    AStrings.Add('procedure DissmisedWebViewBarricade');
    AStrings.Add('procedure Synchronize');
  end;
  if AClass = 'ISHELLFOLDERITEMS' then
  begin
    AStrings.Add('property Application:IShellDispatch');
    AStrings.Add('property Count:integer');
    AStrings.Add('property Verbs:IShellFolderItemVerbs');
    AStrings.Add('function Item:IShellFolderItem');
    AStrings.Add('procedure InvokeVerbEx([Verb], [Args])');
    AStrings.Add('procedure Filter(flags, Filter)');
  end;
   if AClass = 'ISHELLFOLDERITEM' then
  begin
    AStrings.Add('property Application:IShellDispatch');
    AStrings.Add('property GetFolder:IShellFolder');
    AStrings.Add('property GetLink:IShellLinkObject');
    AStrings.Add('property IsBrowsable:boolean');
    AStrings.Add('property IsFileSystem:boolean');
    AStrings.Add('property IsFolder:boolean');
    AStrings.Add('property IsLink:boolean');
    AStrings.Add('property ModifyDate:string');
    AStrings.Add('property Name:string');
    AStrings.Add('property Parent:IShellFolder');
    AStrings.Add('property Path:string');
    AStrings.Add('property Size:integer');
    AStrings.Add('propety Type:string');
    AStrings.Add('procedure InvokeVerb([Verb])');
    AStrings.Add('procedure InvokeVerbEx([Verb], [Args])');
    AStrings.Add('function Verbs:IShellFolderItemVerbs');
    AStrings.Add('function ExtendedProperty(Name)');
  end;
  if AClass = 'ISHELLWINDOWS' then
  begin
    AStrings.Add('property Count:integer');
    AStrings.Add('property Item');
  end;
  if AClass = 'ISHELLLINKOBJECT' then
  begin
    AStrings.Add('property Arguments:string');
    AStrings.Add('property Description:string');
    AStrings.Add('property HotKey:integer');
    AStrings.Add('property Path:string');
    AStrings.Add('property ShowCommand:integer');
    AStrings.Add('property WorkingDirectory:string');
    AStrings.Add('property Target:IForderItem');
    AStrings.Add('function GetIconLocation(Path):integer');
    AStrings.Add('procedure Resolve(Flags)');
    AStrings.Add('procedure Save(File)');
    AStrings.Add('procedure SetIconLocation(Path, Index)');
  end;
  if AClass = 'ISHELLFOLDERITEMVERBS' then
  begin
    AStrings.Add('property Count:integer');
    AStrings.Add('property Item:IFoldeItemVerb');
  end;
  if AClass = 'ISHELLFOLDERITEMVERB' then
  begin
    AStrings.Add('property Name:string');
    AStrings.Add('procedure DoIt');
  end;
  if AClass = 'IREGEXP' then
  begin
    AStrings.Add('property Global:boolean');
    AStrings.Add('property IgnoreCase:boolean');
    AStrings.Add('property Pattern:string');
    AStrings.Add('property MultiLine:boolean');
    AStrings.Add('function Replace(strSource,strReplace):string');
    AStrings.Add('function Test(strSource)style{-B}:boolean');
    AStrings.Add('function Execute(strSource):IRegExpMatches');
  end;
  if AClass = 'IREGEXPMATCHES' then
  begin
   AStrings.Add('property Count:integer');
   AStrings.Add('property Item:IRegExpMatch');
  end;
  if AClass = 'IREGEXPMATCH' then
  begin
    AStrings.Add('propety Value:string');
    AStrings.Add('propety FirsIndex:integer');
    AStrings.Add('propety Length:integer');
  end;
  if AClass = 'IFILESYSTEMOBJECT' then
  begin
    AStrings.Add('property Drives: IDriveCollection');
    AStrings.Add('function BuildPath(Path: OleStr;Name: OleStr): OleStr');
    AStrings.Add('function GetDriveName: OleStr');
    AStrings.Add('function GetParentFolderName: OleStr');
    AStrings.Add('function GetFileName: OleStr');
    AStrings.Add('function GetBaseName: OleStr');
    AStrings.Add('function GetExtensionName: OleStr');
    AStrings.Add('function GetAbsolutePathName: OleStr');
    AStrings.Add('function GetTempName: OleStr');
    AStrings.Add('function DriveExists: Boolean');
    AStrings.Add('function FileExists: Boolean');
    AStrings.Add('function FolderExists: Boolean');
    AStrings.Add('function GetDrive: IDrive');
    AStrings.Add('function GetFile: IFile');
    AStrings.Add('function GetFolder: IFolder');
    AStrings.Add('function GetSpecialFolder: IFolder');
    AStrings.Add('procedure DeleteFile(FileSpec: OleStr;Force: Boolean)');
    AStrings.Add('procedure DeleteFolder(FolderSpec: OleStr;Force: Boolean)');
    AStrings.Add('procedure MoveFile(Source: OleStr;Destination: OleStr)');
    AStrings.Add('procedure MoveFolder(Source: OleStr;Destination: OleStr)');
    AStrings.Add('procedure CopyFile(Source: OleStr;Destination: OleStr;OverWriteFiles: Boolean)');
    AStrings.Add('procedure CopyFolder(Source: OleStr;Destination: OleStr;OverWriteFiles: Boolean)');
    AStrings.Add('function CreateFolder: IFolder');
    AStrings.Add('function CreateTextFile(FileName: OleStr;Overwrite: Boolean;Unicode: Boolean): ITextStream');
    AStrings.Add('function OpenTextFile(FileName: OleStr;IOMode: IOMode;Create: Boolean;Format: Tristate): ITextStream');
    AStrings.Add('function GetStandardStream(StandardStreamType: StandardStreamTypes;Unicode: Boolean): ITextStream');
    AStrings.Add('function GetFileVersion: OleStr');
  end;
  if AClass = 'IDRIVECOLLECTION' then
  begin
    AStrings.Add('property Count:integer');
    AStrings.Add('property Item:IDrive');
  end;
  if AClass = 'IDRIVE' then
  begin
    AStrings.Add('property Path:OleStr');
    AStrings.Add('property DriveLetter:OleStr');
    AStrings.Add('property ShareName:OleStr');
    AStrings.Add('property DriveType:DriveTypeConst');
    AStrings.Add('property RootFolder:IFolder');
    AStrings.Add('property AvailableSpace:Variant');
    AStrings.Add('property FreeSpace:Variant');
    AStrings.Add('property TotalSize:Variant');
    AStrings.Add('property VolumeName:OleStr');
    AStrings.Add('property FileSystem:OleStr');
    AStrings.Add('property SerialNumber:Integer');
    AStrings.Add('property IsReady:Boolean');
  end;
  if AClass = 'IFILECOLLECTION' then
  begin
    AStrings.Add('property Count:integer');
    AStrings.Add('property Item:IFile');
  end;
  if AClass = 'IFILE' then
  begin
    AStrings.Add('property Path:OleStr');
    AStrings.Add('property Name:OleStr');
    AStrings.Add('property ShortPath:OleStr');
    AStrings.Add('property ShortName:OleStr');
    AStrings.Add('property Drive:IDrive');
    AStrings.Add('property ParentFolder:IFolder');
    AStrings.Add('property Attributes:FileAttribute');
    AStrings.Add('property DateCreated:Date');
    AStrings.Add('property DateLastModified:Date');
    AStrings.Add('property DateLastAccessed:Date');
    AStrings.Add('property Size:Variant');
    AStrings.Add('property Type:OleStr');
    AStrings.Add('procedure Delete');
    AStrings.Add('procedure Copy(Destination :OleStr; OverWriteFiles :Boolean)');
    AStrings.Add('procedure Move');
    AStrings.Add('function OpenAsTextStream(IOMode :IOMode; Format :Tristate):ITextStream');
  end;
  if AClass = 'IFOLDERCOLLECTION' then
  begin
    AStrings.Add('property Count:integer');
    AStrings.Add('property Item:IFolder');
  end;
  if AClass = 'IFOLDER' then
  begin
    AStrings.Add('property Path:OleStr');
    AStrings.Add('property Name:OleStr');
    AStrings.Add('property ShortPath:OleStr');
    AStrings.Add('property ShortName:OleStr');
    AStrings.Add('property Drive:IDrive');
    AStrings.Add('property ParentFolder:IFolder');
    AStrings.Add('property Attributes:FileAttribute');
    AStrings.Add('property DateCreated:Date');
    AStrings.Add('property DateLastModified:Date');
    AStrings.Add('property DateLastAccessed:Date');
    AStrings.Add('property Type:OleStr');
    AStrings.Add('procedure Delete');
    AStrings.Add('procedure Copy(Destination :OleStr; OverWriteFiles :Boolean)');
    AStrings.Add('procedure Move');
    AStrings.Add('property IsRootFolder:Boolean');
    AStrings.Add('property Size:Variant');
    AStrings.Add('property SubFolders:IFolderCollection');
    AStrings.Add('property Files:IFileCollection');
    AStrings.Add('function CreateTextFile(FileName :OleStr; Overwrite :Boolean; Unicode :Boolean):ITextStream');
  end;
  if AClass = 'ITEXTSTREAM' then
  begin
    AStrings.Add('property Line:Integer');
    AStrings.Add('property Column:Integer');
    AStrings.Add('property AtEndOfStream:Boolean');
    AStrings.Add('property AtEndOfLine:Boolean');
    AStrings.Add('function Read(NumberOfChars):OleStr');
    AStrings.Add('function ReadLine:OleStr');
    AStrings.Add('function ReadAll:OleStr');
    AStrings.Add('procedure Write(String)');
    AStrings.Add('procedure WriteLine(String)');
    AStrings.Add('procedure WriteBlankLines(NumberOfString)');
    AStrings.Add('procedure Skip(NumberOfChars)');
    AStrings.Add('procedure SkipLine');
    AStrings.Add('procedure Close');
  end;
  if AClass = 'IDICTIONARY' then
  begin
    AStrings.Add('property Item(Key :Variant; riid :Variant)');
    AStrings.Add('procedure Add(Key :Variant; Item :Variant)');
    AStrings.Add('property Count:Integer');
    AStrings.Add('function Exists:Boolean');
    AStrings.Add('function Items:Variant');
    AStrings.Add('property Key(Key :Variant; Item :Variant)');
    AStrings.Add('function Keys:Variant');
    AStrings.Add('procedure Remove');
    AStrings.Add('procedure RemoveAll');
    AStrings.Add('property CompareMode:CompareMethod');
    AStrings.Add('property HashVal:Variant');
  end;
  if AClass = 'IWSHSHELL' then
  begin
    AStrings.Add('property CurrentDirectory:OleStr');
    AStrings.Add('property Environment([type])');
    AStrings.Add('property SpecialFolders([WshFolders])');
    AStrings.Add('function ExpandEnvironmentStrings(<String>):OleStr');
    AStrings.Add('function Popup(<Text>,<SecondsToWait>,<Title>,<Type>):integer');
    AStrings.Add('procedure SendKeys(<String>)');
    AStrings.Add('function Run(<Command>,<WindowStyle>,<WaitOnReturn>):integer');
    AStrings.Add('function Exec(<Command>):IWshScriptExec');
    AStrings.Add('function AppActivate(<Title>):boolean');
    AStrings.Add('procedure RegDelete(<Name>)');
    AStrings.Add('function RegRead(<Name>):Variant');
    AStrings.Add('procedure RegWrite(<Name>,<Value>,<Type>)');
    AStrings.Add('function LogEvent(<Type>,<Message>,<Target>):boolean');
    AStrings.Add('function CreateShortcut(<Path>):IWhShortCut');
  end;
  if AClass = 'IWSHSCRIPTEXEC' then
  begin
    AStrings.Add('property ExitCode:integer');
    AStrings.Add('property ProcessID:integer');
    AStrings.Add('property Status:integer');
    AStrings.Add('procedure Terminate');
  end;
  if AClass = 'IWSHSHORTCUT' then
  begin
    AStrings.Add('property Arguments:string');
    AStrings.Add('property Description:string');
    AStrings.Add('property FullName:string');
    AStrings.Add('property Hotkey:string');
    AStrings.Add('property IconLocation:string');
    AStrings.Add('property TargetPath:string');
    AStrings.Add('property WindowStyle:integer');
    AStrings.Add('property WorkingDirectory:string');
  end;
  if AClass = 'IWSHNETWORK' then
  begin
    AStrings.Add('property ComputerName:string');
    AStrings.Add('property UserName:string');
    AStrings.Add('property UserDomain:string');
    AStrings.Add('function EnumNetworkDrives');
    AStrings.Add('function EnumPrinterConnections');
    AStrings.Add('procedure MapNetworkDrive(<LocalName>,<RemoteName>,<UpdateProfile>, <User>,<Password>)');
    AStrings.Add('procedure RemoveNetworkDrive(<Name>,<Force>,<UpdateProfile>)');
    AStrings.Add('procedure AddPrinterConnection(<LocalName>,<RemoteName>,<UpdateProfile>, <User>,<Password>)');
    AStrings.Add('procedure AddWindowsPrinterConnection(<PrinterPath>,<DriverName>,<Port>) ');
    AStrings.Add('procedure RemovePrinterConnection(<Name>,<Force>,<UpdateProfile>) ');
    AStrings.Add('procedure SetDefaultPrinter(<Name>)');
  end;
end;
end.
