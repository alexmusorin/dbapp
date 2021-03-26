unit MyUtils;

interface
uses Classes,StrUtils,SysUtils,Controls;

function ParseStr(Str,FieldName_:String):string;
function DateAsSQL(Dat:String):String;
function DateAsADOSQL(Str:String):String;
function FindInList(List:TStringList; Value:String):boolean;
procedure DeleteFromList(List:TStringList;Value:string);
function GetValue(List:TStringList;index:integer):String;

implementation
{ Functions }


function ParseStr(Str,FieldName_:String):string;
var SpaceC:integer;
    Buffer:string;
begin
  Buffer:=LowerCase(Str);
  for SpaceC:=1 to 10 do
  begin
    Buffer:=StringReplace(Buffer,'!!',' ',[rfReplaceAll]);
    Buffer:=StringReplace(Buffer,'  ',' ',[rfReplaceAll]);
  end;
  Buffer:=Trim(Buffer);
  if (Buffer<>'') and (Buffer[1] in ['0'..'9']) Then Buffer:='='+Buffer;
  Buffer:=StringReplace(Buffer,'!','not ',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'<>','<&',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'<=','<*',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'>=','>*',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'>',FieldName_+'>',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'<',FieldName_+'<',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'=',FieldName_+'=',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'&','>',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'*','=',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'in (',FieldName_+' in (',[rfReplaceAll]);
  Result:=Buffer;
end;


function DateAsSQL(Dat:String):String;
var Dat1:TDate;
begin
   Dat1:=StrToDate(Dat);
   Result:=StringReplace(FormatDateTime('mm.dd.yyyy',dat1),'.','/',[rfReplaceAll]);
   Result:='#'+Result+'#';
end;

function DateAsADOSQL(Str:String):String;
var BSL:TStringList;
    BSTR:String;
    cnti:integer;
begin
  BSL:=TStringList.Create;
  BStr:='';
  Result:=str;
  cnti:=1;
  while cnti<=Length(Str) do
  begin
    if not (Str[cnti] in ['0'..'9','.']) then
    begin
      inc(cnti);
      if BStr<>'' then
      begin
       BSL.Add(Bstr);
       BStr:='';
      end;
    end
    else
    begin
      BStr:=BStr+Str[cnti];
      inc(cnti);
    end;
  end;
  if BStr<>'' then BSL.Add(Bstr);
  for cnti:=0 to BSL.Count-1 do
  begin
     Result:=StringReplace(Result,BSL[cnti],DateAsSQL(BSL[cnti]),[rfReplaceAll]);
  end;
  BSL.Free;
end;

function FindInList(List:TStringList;Value:String):boolean;
var i:integer;
begin
  Result:=false;
  for i:=0 to List.Count-1 do
  if CompareStr(List.Strings[i],Value)=0 then Result:=true;
end;

procedure DeleteFromList(List:TStringList;Value:string);
var i:integer;
begin
  for i:=List.Count-1 downto 0 do
  if CompareStr(List.Strings[i],Value)=0 then List.Delete(i);
end;

function GetValue(List:TStringList;index:integer):String;
var ep:integer;
begin
  ep:=Pos('=',List.Strings[index]);
  Result:=RightStr(List.Strings[index],Length(List.Strings[index])-ep);
end;


end.
 