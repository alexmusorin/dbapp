{*******************************************************}
{                                                       }
{      Метаданные объектов, свойства которых доступны   }
{    для наблюдения и изменения в инспекторе объектов   }
{                GsvObjectInspector                     }
{                                                       }
{        Copyright (C) 2003. Сергей Гурин               }
{                                                       }
{*******************************************************}

unit
  GsvObjectInspectorTypes;

interface

uses
  Classes, Types;

type
  // Виды свойств, отображаемых инспектором объектов
  TGsvObjectInspectorPropertyKind = (
    pkNone,          // недопустимое значение вида свойства
    pkText,          // значение свойства может быть представлено как текст.
                     // Изменение текста фиксируется по клавише Enter, по
                     // переходу к другому свойству или потере фокуса
    pkDropDownList,  // свойство имеет перечислимый список значений без
                     // возможности редактирования значения как текста
    pkDialog,        // значения свойства устанавливаются диалогом-мастером.
                     // Свойство этого типа обычно имеет подсвойства
    pkFolder,        // фиктивное свойство, позволяет организовать иерархический
                     // список свойств
    pkReadOnlyText,  // значение свойства может быть представлено текстом,
                     // но доступно только для чтения
    pkBoolean,       // свойство отображается как стандартный CheckBox, а не как
                     // перечислимый набор из двух значений
    pkImmediateText, // аналогично pkText, то изменение значения свойства
                     // фиксируются немедленно при любом изменении текста
    pkTextList,      // свойство подобно pkDropDownList, но его значение
                     // можно редактировать вручную, то есть диапазон значений
                     // может быть не ограничен списком
    pkSet,           // свойство-множество отображается как родительское для
                     // вложенного списка элементов множества, каждый из
                     // которых представляется как логическое значение
    pkColor,         // свойство типа TColor с отображением цветного
                     // прямоугольника и возможностью выбора цвета из списка
    pkColorRGB       // свойство типа TColor с отображением цветного
                     // прямоугольника, возможностью ввода цвета в формате R.G.B
                     // и возможностью выбора цвета с помощью диалога
  );

  TGsvObjectInspectorTypeInfoClass = class of TGsvObjectInspectorTypeInfo;

  { Описатель (дескриптор) свойства объекта для его отображения в инспекторе.
    Поле NestedType используется для задания строкового имени метатипа, который
    описывает набор его вложенных полей. Поле NestedClass - это альтернатива
    для NestedType в том случае, если метакласс известен во время компиляции.
    Поле Tag может быть использовано для определения каких-либо
    специфических данных для свойства, но для вида pkBoolean оно имеет
    имеет предопределенный смысл. Если свойство соответствует элементу
    множества, то значение Tag должно быть равно порядковому значению
    перечислимого элемента множества, например, для элемента fsBold из
    множества FontStyles значение Tag будет равно Ord(fsBold). Для свойства
    типа Boolean значение Tag должно быть равно 0.
  }
  TGsvObjectInspectorPropertyInfo = record
    // эти поля задаются константной записью или формируются динамически
    Name:         String;  // имя свойства в объекте
    Caption:      String;  // название свойства для инспектора
    Kind:         TGsvObjectInspectorPropertyKind; // вид свойства
    Tag:          LongInt; // специфические данные свойства
    NestedType:   String;  // тип сложного объекта, описывающего вложенные свойства
    NestedClass:  TGsvObjectInspectorTypeInfoClass; // класс сложного объекта
    Help:         Integer; // индекс справки
    Hint:         String;  // строка подсказки
    // следующие поля заполняются и используется инспектором
    HasChildren:  Boolean; // есть вложенные свойства
    Level:        Integer; // уровень свойства в дереве вложенных свойств
    Expanded:     Boolean; // признак раскрытия или скрытия вложенных свойств
    TheObject:    TObject; // объект, которому принадлежит свойство
    NestedObject: TObject; // объект вложенного свойства
  end;
  PGsvObjectInspectorPropertyInfo = ^TGsvObjectInspectorPropertyInfo;

  // Служебная структура данных для описания свойств-перечислений
  TGsvObjectInspectorListItem = record
    Name: string;  // имя элемента списка
    Data: LongInt; // значение элемента списка
  end;
  PGsvObjectInspectorListItem = ^TGsvObjectInspectorListItem;

  TGsvObjectInspectorStringListItem = record
    Name: string;  // имя элемента списка
    Data: String; // значение элемента списка
  end;
  PGsvObjectInspectorStringListItem = ^TGsvObjectInspectorStringListItem;

  { Абстрактный базовый класс метаданных (аттрибутов), описывающий свойства
    инспектируемого типа. Все классы метаданных должны порождаться от этого
    класса. Имя класса метаданных должно состоять из имени инспектируемого
    типа плюс суффикс _INFO. Например, для инспектируемого класса TButton,
    имя класса метаданных будет TButton_INFO }
  TGsvObjectInspectorTypeInfo = class
  public
    class function  ObjectName(AObject: TObject): String; virtual;
    class function  TypeName: String; virtual;
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; virtual;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; virtual;
    class procedure FillList(AObject: TObject; List: TStrings); virtual;
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); virtual;
    class function  IntegerToString(const Value: LongInt): String; virtual;
    class function  StringToInteger(const Value: String): LongInt; virtual;
    class function  CharToString(const Value: Char): String; virtual;
    class function  StringToChar(const Value: String): Char; virtual;
    class function  FloatToString(const Value: Extended): String; virtual;
    class function  StringToFloat(const Value: String): Extended; virtual;
    class function  ObjectToString(const Value: TObject): String; virtual;
  end;
  PGsvObjectInspectorTypeInfo = ^TGsvObjectInspectorTypeInfo;

  { Специализированный базовый класс метаданных, описывающий свойства
    перечислимого типа, в котором значения задаются в виде списка }
  TGsvObjectInspectorTypeListInfo = class(TGsvObjectInspectorTypeInfo)
  protected
    class function  ListEnumItems(Index: Integer): PGsvObjectInspectorListItem;
                    virtual;
  public
    class procedure FillList(AObject: TObject; List: TStrings); override;
    class function  IntegerToString(const Value: LongInt): String; override;
    class function  StringToInteger(const Value: String): LongInt; override;
  end;

  { Специализированный базовый класс метаданных, описывающий свойства
    диалога выбора шрифта }
  TGsvObjectInspectorTypeFontInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  TGsvObjectInspectorTypeStringsInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  TGsvObjectInspectorTypeBitmapInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  TGsvObjectInspectorTypePictureInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  TGsvObjectInspectorTypeItemsInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  TGsvObjectInspectorTypeTreeNodesInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  ObjectToString(const Value: TObject): String; override;
  end;

  { Специализированный базовый класс метаданных, описывающий свойства
    типа-множества }
  TGsvObjectInspectorTypeSetInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class function  IntegerToString(const Value: LongInt): String; override;
  end;

  { Специализированный базовый класс метаданных, описывающий свойства
    типа TColor с возможностью задания цвета в формате RGB и выбора
    цвета с помощью стандартного Windows-диалога }
  TGsvObjectInspectorTypeColorRGBInfo = class(TGsvObjectInspectorTypeInfo)
  public
    class procedure ShowDialog(Inspector: TComponent;
                    Info: PGsvObjectInspectorPropertyInfo;
                    const EditRect: TRect); override;
    class function  IntegerToString(const Value: LongInt): String; override;
    class function  StringToInteger(const Value: String): LongInt; override;
  end;

  // Описатель свойств одного уровня вложенности, используется в классе
  // TGsvObjectInspectorObjectInfo
  TGsvObjectInspectorTypeLevelInfo = record
    TheObject: TObject;
    Info:      TGsvObjectInspectorTypeInfoClass;
    Index:     Integer;
  end;

  // В отличие от класса TGsvObjectInspectorTypeInfo этот класс описывает
  // свойства конкретного объекта, а не типа. Класс предоставляет
  // инспектору информацию об объектах на основе метаданных
  TGsvObjectInspectorObjectInfo = class
  public
    constructor Create;
    destructor  Destroy; override;

  private
    FTypeInfo:   TGsvObjectInspectorTypeInfoClass; // информация о типе

    // данные для работы функции PropertyInfo
    FLevelInfo:  array of TGsvObjectInspectorTypeLevelInfo;
    FLevel:      Integer;
    FResultInfo: TGsvObjectInspectorPropertyInfo;

  protected
    FObject:  TObject; // инспектируемый объект

    function  GetObject: TObject; virtual;
    procedure SetObject(const Value: TObject); virtual;

  public
    function  ObjectName: String; virtual;
    function  ObjectTypeName: String; virtual;
    function  ObjectHelp: Integer; virtual;
    function  ObjectHint: String; virtual;
    function  PropertyInfo(Index: Integer): PGsvObjectInspectorPropertyInfo;
    procedure FillList(Info: PGsvObjectInspectorPropertyInfo;
              List: TStrings); virtual;
    procedure ShowDialog(Inspector: TComponent;
              Info: PGsvObjectInspectorPropertyInfo;
              const EditRect: TRect); virtual;
    function  GetStringValue(Info: PGsvObjectInspectorPropertyInfo):
              String; virtual;
    procedure SetStringValue(Info: PGsvObjectInspectorPropertyInfo;
              const Value: String); virtual;
    function  GetIntegerValue(Info: PGsvObjectInspectorPropertyInfo):
              LongInt; virtual;
    procedure SetIntegerValue(Info: PGsvObjectInspectorPropertyInfo;
              const Value: LongInt); virtual;

    property  TheObject: TObject read GetObject write SetObject;
  end;

  procedure GsvRegisterTypeInfo(AClass: TGsvObjectInspectorTypeInfoClass);
  procedure GsvRegisterTypesInfo(AClasses:
            array of TGsvObjectInspectorTypeInfoClass);
  function  GsvFindTypeInfo(const ATypeName: String):
            TGsvObjectInspectorTypeInfoClass;

  // вспомогательные процедуры и функции
  function  GsvGetBit(Value: LongInt; Bit: Integer): Boolean;
  function  GsvChangeBit(Value: LongInt; Bit: Integer): LongInt;
  function  GsvGetIntegerProperty(Info: PGsvObjectInspectorPropertyInfo):
            LongInt;
  procedure GsvSetIntegerProperty(Info: PGsvObjectInspectorPropertyInfo;
            const Value: LongInt);
  function  GsvGetStringProperty(Info: PGsvObjectInspectorPropertyInfo):
            String;
  procedure GsvSetStringProperty(Info: PGsvObjectInspectorPropertyInfo;
            const Value: String);

implementation

uses
  TypInfo, Windows, SysUtils, StrUtils, Dialogs, Graphics, StrDialog, BmpDialogUnit,
  TreeItemsDialogUnit, ComCtrls;

const
  GSV_DEFAULT_INFO: TGsvObjectInspectorPropertyInfo = (  );
  SERROR = 'Error';

var
  GsvTypesInfo: TStringList;

// Регистрация класса метаданных
procedure GsvRegisterTypeInfo(AClass: TGsvObjectInspectorTypeInfoClass);
begin
  if not Assigned(GsvTypesInfo) then begin
    GsvTypesInfo            := TStringList.Create;
    GsvTypesInfo.Duplicates := dupIgnore;
    GsvTypesInfo.Sorted     := True;
  end;
  GsvTypesInfo.AddObject(AClass.ClassName, TObject(AClass));
end;

// Регистрация массива классов метаданных
procedure GsvRegisterTypesInfo(aClasses:
  array of TGsvObjectInspectorTypeInfoClass);
var
  i: Integer;
begin
  for i := Low(AClasses) to High(AClasses) do
    GsvRegisterTypeInfo(AClasses[i]);
end;

// Поиск класса метаданных для заданного имени типа. Функция возвращает nil
// если класс не найден
function GsvFindTypeInfo(const ATypeName: String):
  TGsvObjectInspectorTypeInfoClass;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(GsvTypesInfo) then
    if GsvTypesInfo.Find(ATypeName + '_INFO', i) then
      Result := TGsvObjectInspectorTypeInfoClass(GsvTypesInfo.Objects[i]);
end;

// Вспомогательная функция - выделяет бит из слова и возвращает True если
// бит установлен и False если бит сброшен
function GsvGetBit(Value: LongInt; Bit: Integer): Boolean;
begin
  if (Bit >= 0) and (Bit < 32) then
    Result := (Value and (1 shl Bit)) <> 0
  else
    Result := False;
end;

// Изменение значения бита на противоположное
function GsvChangeBit(Value: LongInt; Bit: Integer): LongInt;
begin
  if (Bit >= 0) and (Bit < 32) then
    Result := Value xor (1 shl Bit)
  else
    Result := Value;
end;

// Получение целочисленного свойства на основе RTTI
function GsvGetIntegerProperty(Info: PGsvObjectInspectorPropertyInfo):
  LongInt;
var
  obj: TObject;
  nm:  String;
begin
  Result := 0;
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then
    Exit;
  case PropType(obj, nm) of
    tkInteger,
    tkEnumeration,
    tkSet,
    tkChar:
      Result := GetOrdProp(obj, nm);
  end;
end;

// Установка целочисленного свойства на основе RTTI
procedure GsvSetIntegerProperty(Info: PGsvObjectInspectorPropertyInfo;
  const Value: LongInt);
var
  obj: TObject;
  nm:  String;
begin
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then
    Exit;
  case PropType(obj, nm) of
    tkInteger,
    tkEnumeration,
    tkSet,
    tkChar:
      SetOrdProp(obj, nm, Value);
  end;
end;

// Получение строкового свойства на основе RTTI
function GsvGetStringProperty(Info: PGsvObjectInspectorPropertyInfo):
  String;
var
  obj: TObject;
  nm:  String;
  I: integer;
  PropInfo: PPropInfo;
begin
  Result := '';
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then
    Exit;
  case PropType(obj, nm) of
    tkString,
    tkLString:
      Result := GetStrProp(obj, nm);
    tkEnumeration:
    begin
      I := GetOrdProp(obj, nm);
      Result := GetEnumName(PropInfo^.PropType^, I);
    end;
  end;
end;

// Установка строкового свойства на основе RTTI
procedure GsvSetStringProperty(Info: PGsvObjectInspectorPropertyInfo;
  const Value: String);
var
  obj: TObject;
  nm:  String;
begin
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then
    Exit;
  case PropType(obj, nm) of
    tkString,
    tkLString:
      SetStrProp(obj, nm, Value);
  end;
end;

{ TGsvObjectInspectorTypeInfo }

// Получение имени объекта
class function TGsvObjectInspectorTypeInfo.ObjectName(
  AObject: TObject): String;
begin
  Result := '';
  if Assigned(AObject) then
    if AObject is TComponent then
      Result := TComponent(AObject).Name;
end;

// Получение названия типа
class function TGsvObjectInspectorTypeInfo.TypeName: String;
begin
  Result := '';
end;

// Получение информации о типе, как о свойстве. Если в родительском свойстве
// какие-то поля свойства не определены, то используется соответствующие
// поля вложенного объекта
class function TGsvObjectInspectorTypeInfo.TypeInfo:
  PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = ( );
begin
  Result := @DSK;
end;

// Функция получения дескриптора свойства по его индексу. Используется как
// CallBack-функция внешних перечислителей свойств. Если свойство с таким
// индексом отсутствует, то функция возвращает nil, а иначе функция
// возвращает указатель на структуру дескриптора свойства с заданным индексом.
class function TGsvObjectInspectorTypeInfo.ChildrenInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
begin
  Result := nil;
end;

// Задача процедуры - заполнить перечислимый список значений, соответствующих
// свойству объекта с указанным именем
class procedure TGsvObjectInspectorTypeInfo.FillList(AObject: TObject;
  List: TStrings);
begin
end;

// Задача процедуры - вызвать диалог для установки значения свойства
class procedure TGsvObjectInspectorTypeInfo.ShowDialog(Inspector: TComponent;
  Info: PGsvObjectInspectorPropertyInfo; const EditRect: TRect);
begin
end;

// Функция должна преобразовать целочисленное значение в строку
class function TGsvObjectInspectorTypeInfo.IntegerToString(
  const Value: LongInt): String;
begin
  Result := IntToStr(Value);
end;

// Функция должна преобразовать строковое значение в целочисленное. Если
// преобразование невозможно, то функция должна возбуждать исключение
class function TGsvObjectInspectorTypeInfo.StringToInteger(
  const Value: String): LongInt;
begin
  Result := StrToInt(Value);
end;

// Функция должна вернуть некоторое строковое значение, которое
// наиболее полно характеризует данные объекта
class function TGsvObjectInspectorTypeInfo.CharToString(
  const Value: Char): String;
begin
  if Value >= #33 then
    Result := Value
  else
    Result := Format('#%d', [Ord(Value)]);
end;

class function TGsvObjectInspectorTypeInfo.StringToChar(
  const Value: String): Char;
var
  len: Integer;
begin
  len := Length(Value);
  if len = 0 then
    Result := #0
  else if Value[1] <> '#' then
    Result := Value[1]
  else if len = 1 then
    Result := '#'
  else
    Result := Char(StrToInt(RightStr(Value, len - 1)));
end;

class function TGsvObjectInspectorTypeInfo.FloatToString(
  const Value: Extended): String;
begin
  Result := Format('%g', [Value]);
end;

class function TGsvObjectInspectorTypeInfo.StringToFloat(
  const Value: String): Extended;
begin
  Result := StrToFloat(Value);
end;

class function TGsvObjectInspectorTypeInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result := '';
end;


{ TGsvObjectInspectorTypeListInfo }

// В наследуемом классе функция должна вернуть указатель элемент
// типа PGsvObjectInspectorListItem, описывающий имя и значение элемента
// списка-перечисления в зависимости от его индекса. Если все элементы
// перечислены, то функция возвращает nil
class function TGsvObjectInspectorTypeListInfo.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
begin
  Result := nil;
end;

class procedure TGsvObjectInspectorTypeListInfo.FillList(AObject: TObject;
  List: TStrings);
var
  i: Integer;
  p: PGsvObjectInspectorListItem;
begin
  i := 0;
  p := ListEnumItems(0);
  while Assigned(p) do begin
    List.AddObject(p^.Name, TObject(p^.Data));
    Inc(i);
    p := ListEnumItems(i);
  end;
end;

class function TGsvObjectInspectorTypeListInfo.IntegerToString(
  const Value: Integer): String;
var
  i: Integer;
  p: PGsvObjectInspectorListItem;
begin
  Result := '';
  i      := 0;
  p      := ListEnumItems(0);
  while Assigned(p) do begin
    if p^.Data = Value then begin
      Result := p^.Name;
      Break;
    end;
    Inc(i);
    p := ListEnumItems(i);
  end;
end;

class function TGsvObjectInspectorTypeListInfo.StringToInteger(
  const Value: String): LongInt;
var
  i: Integer;
  p: PGsvObjectInspectorListItem;
begin
  Result := 0;
  i      := 0;
  p      := ListEnumItems(0);
  while Assigned(p) do begin
    if p^.Name = Value then begin
      Result := p^.Data;
      Break;
    end;
    Inc(i);
    p := ListEnumItems(i);
  end;
end;


{ TGsvObjectInspectorTypeFontInfo }

class procedure TGsvObjectInspectorTypeFontInfo.ShowDialog(Inspector: TComponent;
  Info: PGsvObjectInspectorPropertyInfo; const EditRect: TRect);
var
  dlg: TFontDialog;
  fnt: TFont;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TFont) then
    Exit;
  fnt := TFont(Info^.NestedObject);
  dlg := TFontDialog.Create(Inspector);
  try
    dlg.Font.Assign(fnt);
    if dlg.Execute then
      fnt.Assign(dlg.Font);
  finally
    dlg.Free;
  end;
end;

class function TGsvObjectInspectorTypeFontInfo.ObjectToString(
  const Value: TObject): String;
begin
  if Assigned(Value) then
    if Value is TFont then
      with TFont(Value) do
        Result := Format('%s, %d', [Name, Size]);
end;


{ TGsvObjectInspectorTypeSetInfo }

class function TGsvObjectInspectorTypeSetInfo.IntegerToString(
  const Value: LongInt): String;
var
  i: Integer;
  p: PGsvObjectInspectorPropertyInfo;
begin
  Result := '';
  i      := 0;
  p      := ChildrenInfo(0);
  while Assigned(p) do begin
    if p^.Kind = pkBoolean then begin
      if GsvGetBit(Value, p^.Tag) then begin
        if Result <> '' then
          Result := Result + ', ';
        Result := Result + p^.Caption;
      end;
    end;
    Inc(i);
    p := ChildrenInfo(i);
  end;
end;

{ TGsvObjectInspectorTypeColorRGBInfo }

class procedure TGsvObjectInspectorTypeColorRGBInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
const
  CC: array[0..15] of String = (
    {Black}   'ColorA=000000',
    {Maroon}  'ColorB=000080',
    {Green}   'ColorC=008000',
    {Olive}   'ColorD=008080',
    {Navy}    'ColorE=800000',
    {Purple}  'ColorF=800080',
    {Teal}    'ColorG=808000',
    {Gray}    'ColorH=808080',
    {Silver}  'ColorI=C0C0C0',
    {Red}     'ColorJ=0000FF',
    {Lime}    'ColorK=00FF00',
    {Yellow}  'ColorL=00FFFF',
    {Blue}    'ColorM=FF0000',
    {Fuchsia} 'ColorN=FF00FF',
    {Aqua}    'ColorO=FFFF00',
    {White}   'ColorP=FFFFFF'
  );
var
  dlg: TColorDialog;
  i:   Integer;
begin
  if not Assigned(Info) then
    Exit;
  dlg := TColorDialog.Create(Inspector);
  try
    dlg.Color   := GsvGetIntegerProperty(Info);
    dlg.Options := dlg.Options + [cdFullOpen];
    for i := 0 to High(CC) do
      dlg.CustomColors.Add(CC[i]);
    if dlg.Execute then
      GsvSetIntegerProperty(Info, dlg.Color);
  finally
    dlg.Free;
  end;
end;

class function TGsvObjectInspectorTypeColorRGBInfo.IntegerToString(
  const Value: Integer): String;
begin
  result := Format('%d.%d.%d', [Value and $FF, (Value shr 8) and $FF,
            (Value shr 16) and $FF]);
end;

class function TGsvObjectInspectorTypeColorRGBInfo.StringToInteger(
  const Value: String): LongInt;
var
  ci:      array[0..2] of Byte;
  ps, len: Integer;

  function ConvNumber: Integer;
  var
    c: Char;
  begin
    Result := 0;
    while ps <= len do begin
      c := Value[ps];
      if c = '.' then begin
        Inc(ps);
        Break;
      end;
      if c in ['0'..'9'] then
        Result := Result * 10 + (Ord(c) - Ord('0'))
      else
        Break;
      Inc(ps);
    end;
  end;

begin
  ps     := 1;
  len    := Length(Value);
  ci[0]  := Byte(ConvNumber);
  ci[1]  := Byte(ConvNumber);
  ci[2]  := Byte(ConvNumber);
  Result := RGB(ci[0], ci[1], ci[2]);
end;

{ TGsvObjectInspectorObjectInfo }

constructor TGsvObjectInspectorObjectInfo.Create;
begin
  SetLength(FLevelInfo, 8);
end;

destructor TGsvObjectInspectorObjectInfo.Destroy;
begin
  FLevelInfo := nil;
  inherited;
end;

function TGsvObjectInspectorObjectInfo.GetObject: TObject;
begin
  Result := FObject;
end;

procedure TGsvObjectInspectorObjectInfo.SetObject(const Value: TObject);
begin
  //if FObject <> Value then begin
    FObject   := nil;
    FTypeInfo := nil;
    if Assigned(Value) then begin
      FTypeInfo := GsvFindTypeInfo(Value.ClassName);
      if Assigned(FTypeInfo) then
        FObject := Value;
    end;
  //end;
end;

// Получение имени объекта, если в информации типа имеется имя свойства,
// через которое можно получить имя объекта
function TGsvObjectInspectorObjectInfo.ObjectName: String;
begin
  if Assigned(FTypeInfo) then Result := FTypeInfo.ObjectName(FObject)
  else                        Result := '';
end;

// Получение названия типа объекта
function TGsvObjectInspectorObjectInfo.ObjectTypeName: String;
begin
  if Assigned(FTypeInfo) then Result := FTypeInfo.TypeName
  else                        Result := '';
end;

// Получение индекса справки по объектам данного типа
function TGsvObjectInspectorObjectInfo.ObjectHelp: Integer;
var
  p: PGsvObjectInspectorPropertyInfo;
begin
  Result := 0;
  if Assigned(FTypeInfo) then begin
    p := FTypeInfo.TypeInfo;
    if Assigned(p) then
      Result := p^.Help;
  end;
end;

// Получение подсказки по объектам данного типа
function TGsvObjectInspectorObjectInfo.ObjectHint: String;
var
  p: PGsvObjectInspectorPropertyInfo;
begin
  Result := '';
  if Assigned(FTypeInfo) then begin
    p := FTypeInfo.TypeInfo;
    if Assigned(p) then
      Result := p^.Hint;
  end;
end;

// Получение дескриптора свойства по индексу
function TGsvObjectInspectorObjectInfo.PropertyInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
var
  p, pc: PGsvObjectInspectorPropertyInfo;
  obj:   TObject;
begin
  Result := nil;

  // инициализация итерации по всем свойствам объекта
  if Index = 0 then begin
    if not Assigned(FObject) then
      Exit;
    FLevel                  := 0;
    FLevelInfo[0].TheObject := FObject;
    FLevelInfo[0].Info      := FTypeInfo;
    FLevelInfo[0].Index     := 0;
  end;
  if not Assigned(FLevelInfo[FLevel].TheObject) then
    Exit;
  if not Assigned(FLevelInfo[FLevel].Info) then
    Exit;

  while True do begin
    // получаем дескриптор текущего свойства и инкрементируем индекс для
    // доступа к следующему дескриптору
    p := FLevelInfo[FLevel].Info.ChildrenInfo(FLevelInfo[FLevel].Index);
    Inc(FLevelInfo[FLevel].Index);
    if not Assigned(p) then begin
      // свойств больше нет, заканчиваем уровень
      if FLevel = 0 then begin
        // уровней больше нет, заканчиваем перечисление
        Exit;
      end
      else begin
        // переходим на предыдущий уровень и обрабатываем его следующее свойство
        Dec(FLevel);
        Continue;
      end;
    end;

    // копируем поля свойства в выходной буфер и заполняем динамические поля
    FResultInfo              := p^;
    FResultInfo.Level        := FLevel;
    FResultInfo.TheObject    := FLevelInfo[FLevel].TheObject;
    FResultInfo.NestedObject := FLevelInfo[FLevel].TheObject;

    // идентифицируем вложенный класс по имени его типа
    if p^.NestedType <> '' then begin
      FResultInfo.NestedClass := GsvFindTypeInfo(p^.NestedType);
      if not Assigned(FResultInfo.NestedClass) then begin
        // информация о типе вложенного свойства не найдена, игнорируем его
        // и переходим к следующему свойству
        Continue;
      end;
    end;

    if not Assigned(FResultInfo.NestedClass) then begin // простое свойство
      if FResultInfo.Kind = pkNone then begin
        // вид свойства не определен, игнорируем его и переходим к
        // следующему свойству
        Continue;
      end;
      // возвращаем заполненный дескриптор свойства и выходим
      Result := @FResultInfo;
      Exit;
    end
    else begin // свойство, имеющее вложенные свойства
      // контролируем заполненность полей объекта и, при необходимости,
      // используем информацию из вложенного объекта (если она есть)
      pc := FResultInfo.NestedClass.TypeInfo;
      if Assigned(pc) then begin
        if p^.Caption = '' then
          FResultInfo.Caption := pc^.Caption;
        if p^.Kind = pkNone then
          FResultInfo.Kind := pc^.Kind;
        if p^.Help = 0 then
          FResultInfo.Help := pc^.Help;
        if p^.Hint = '' then
          FResultInfo.Hint := pc^.Hint;
      end;
      if FResultInfo.Kind = pkNone then begin
        // вид свойства не определен, игнорируем его и переходим к
        // следующему свойству
        Continue;
      end;
      // определяем указатель на вложенный объект
      obj := FLevelInfo[FLevel].TheObject;
      if p^.Name <> '' then begin
        // если вложенное свойство - класс, то определяем объект этого класса
        if PropType(obj, p^.Name) = tkClass then begin
          try
            obj := GetObjectProp(obj, p^.Name);
            FResultInfo.NestedObject := obj;
          except
            obj := nil;
          end;
        end;
      end;
      if not Assigned(obj) then begin
        // вложенный объект не найден, игнорируем его и переходим к
        // следующему свойству текущего объекта
        Continue;
      end;
      // если вложенные свойства есть, то делаем подготовку для перехода
      // на следующий уровень
      if FResultInfo.NestedClass.ChildrenInfo(0) <> nil then begin
        Inc(FLevel);
        if FLevel > High(FLevelInfo) then
          SetLength(FLevelInfo, Length(FLevelInfo) + 8);
        FLevelInfo[FLevel].TheObject := obj;
        FLevelInfo[FLevel].Info      := FResultInfo.NestedClass;
        FLevelInfo[FLevel].Index     := 0;
      end;
      // возвращаем заполненный дескриптор свойства и выходим
      Result := @FResultInfo;
      Exit;
    end;
  end;
end;

procedure TGsvObjectInspectorObjectInfo.FillList(
  Info: PGsvObjectInspectorPropertyInfo; List: TStrings);
var
  obj: TObject;
  cls: TGsvObjectInspectorTypeInfoClass;
begin
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  cls := Info^.NestedClass;
  if Assigned(cls) then
    cls.FillList(obj, List);
end;

procedure TGsvObjectInspectorObjectInfo.ShowDialog(Inspector: TComponent;
  Info: PGsvObjectInspectorPropertyInfo; const EditRect: TRect);
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedClass) then
    Exit;
  Info^.NestedClass.ShowDialog(Inspector, Info, EditRect);
end;

// Получение строкового представления свойства через RTTI
function TGsvObjectInspectorObjectInfo.GetStringValue(
  Info: PGsvObjectInspectorPropertyInfo): String;
var
  obj: TObject;
  nm:  String;
  cls: TGsvObjectInspectorTypeInfoClass;
begin
  Result := '';
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then begin
    Result := SERROR;
    Exit;
  end;
  cls := Info^.NestedClass;
  try
    // если для свойства определен вложенный класс, то преобразование в строку
    // выполняется им, иначе используется стандартное преобразование
    case PropType(obj, nm) of
      tkInteger,
      tkEnumeration,
      tkSet:
        if Assigned(cls) then
          Result := cls.IntegerToString(GetOrdProp(obj, nm))
        else
          Result := TGsvObjectInspectorTypeInfo.IntegerToString(
                      GetOrdProp(obj, nm));
      tkChar:
        if Assigned(cls) then
          Result := cls.CharToString(Char(GetOrdProp(obj, nm)))
        else
          Result := TGsvObjectInspectorTypeInfo.CharToString(
                      Char(GetOrdProp(obj, nm)));
      tkFloat:
        if Assigned(cls) then
          Result := cls.FloatToString(GetFloatProp(obj, nm))
        else
          Result := TGsvObjectInspectorTypeInfo.FloatToString(
                      GetFloatProp(obj, nm));
      tkString,
      tkLString:
        Result := GetStrProp(obj, nm);
      tkClass:
        if Assigned(cls) then
          Result := cls.ObjectToString(GetObjectProp(obj, nm));
    end;
  except
    Result := SERROR;
  end;
end;

// Установка свойства через RTTI на основе его строкового представления
procedure TGsvObjectInspectorObjectInfo.SetStringValue(
  Info: PGsvObjectInspectorPropertyInfo; const Value: String);
var
  obj: TObject;
  nm:  String;
  cls: TGsvObjectInspectorTypeInfoClass;
begin
  if not Assigned(Info) then
    Exit;
  obj := Info^.TheObject;
  if not Assigned(obj) then
    Exit;
  nm := Info^.Name;
  if nm = '' then
    Exit;
  cls := Info^.NestedClass;
  // если для свойства определен вложенный класс, то преобразование из строки
  // выполняется им, иначе используется стандартное преобразование
  case PropType(obj, nm) of
    tkInteger,
    tkEnumeration,
    tkSet:
      if Assigned(cls) then
        SetOrdProp(obj, nm, cls.StringToInteger(Value))
      else
        SetOrdProp(obj, nm,
          TGsvObjectInspectorTypeInfo.StringToInteger(Value));
    tkChar:
      if Assigned(cls) then
        SetOrdProp(obj, nm, Ord(cls.StringToChar(Value)))
      else
        SetOrdProp(obj, nm, Ord(
          TGsvObjectInspectorTypeInfo.StringToChar(Value)));
    tkFloat:
      if Assigned(cls) then
        SetFloatProp(obj, nm, cls.StringToFloat(Value))
      else
        SetFloatProp(obj, nm,
          TGsvObjectInspectorTypeInfo.StringToFloat(Value));
    tkString,
    tkLString:
      SetStrProp(obj, nm, Value);
  end;
end;

// Получение целочисленного представления свойства через RTTI
function TGsvObjectInspectorObjectInfo.GetIntegerValue(
  Info: PGsvObjectInspectorPropertyInfo): LongInt;
begin
  Result := GsvGetIntegerProperty(Info);
end;

// Установка свойства через RTTI на основе его целочисленного представления
procedure TGsvObjectInspectorObjectInfo.SetIntegerValue(
  Info: PGsvObjectInspectorPropertyInfo; const Value: LongInt);
begin
  GsvSetIntegerProperty(Info, Value);
end;

{ TGsvObjectInspectorTypeStringsInfo }

class function TGsvObjectInspectorTypeStringsInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result:='(TStrings)';
end;

class procedure TGsvObjectInspectorTypeStringsInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
var
  dlg: TStringsDialog;
  str: TStrings;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TStrings) then
    Exit;
  str := TStrings(Info^.NestedObject);
  dlg := TStringsDialog.Create(Inspector);
  try
    dlg.Strings.Assign(str);
    if dlg.Execute then
      str.Assign(dlg.Strings);
  finally
    dlg.Free;
  end;

end;

{ TGsvObjectInspectorTypeItemsInfo }

class function TGsvObjectInspectorTypeItemsInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result:='(TStrings)';
end;

class procedure TGsvObjectInspectorTypeItemsInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
var
  dlg: TStringsDialog;
  str: TStrings;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TStrings) then
    Exit;
  str := TStrings(Info^.NestedObject);
  dlg := TStringsDialog.Create(Inspector);
  try
    //dlg.Font.Assign(fnt);
    dlg.Strings.Assign(str);
    if dlg.Execute then
      str.Assign(dlg.Strings);
  finally
    dlg.Free;
  end;

end;

{ TGsvObjectInspectorTypeBitmapInfo }

class function TGsvObjectInspectorTypeBitmapInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result:='(TBitmap)';
end;

class procedure TGsvObjectInspectorTypeBitmapInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
var
  bmp: TBitmap;
  BmpDialog:TBMPDialog;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TBitmap) then
    Exit;
  bmp:=TBitmap(Info^.NestedObject);
  BmpDialog:=TBMPDialog.Create(Inspector);
  try
     BmpDialog.Bitmap.Assign(bmp);
     if bmpDialog.Execute then
        bmp.Assign(BmpDialog.Bitmap);
  finally
    BmpDialog.Free;
  end;
end;

{ TGsvObjectInspectorTypePictureInfo }

class function TGsvObjectInspectorTypePictureInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result:='(TPicture)';
end;

class procedure TGsvObjectInspectorTypePictureInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
var
  bmp: TPicture;
  BmpDialog:TBMPDialog;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TPicture) then
    Exit;
  bmp:=TPicture(Info^.NestedObject);
  BmpDialog:=TBMPDialog.Create(Inspector);
  try
     BmpDialog.Picture.Assign(bmp);
     if bmpDialog.Execute then
        bmp.Assign(BmpDialog.Picture);
  finally
    BmpDialog.Free;
  end;
end;

{ TGsvObjectInspectorTypeTreeItemsInfo }

class function TGsvObjectInspectorTypeTreeNodesInfo.ObjectToString(
  const Value: TObject): String;
begin
  Result:='(TTreeItems)';
end;

class procedure TGsvObjectInspectorTypeTreeNodesInfo.ShowDialog(
  Inspector: TComponent; Info: PGsvObjectInspectorPropertyInfo;
  const EditRect: TRect);
var
  dlg: TTreeItemsDialog;
  str: TTreeNodes;
begin
  if not Assigned(Info) then
    Exit;
  if not Assigned(Info^.NestedObject) then
    Exit;
  if not (Info^.NestedObject is TTreeNodes) then
    Exit;
  str := TTreeNodes(Info^.NestedObject);
  dlg := TTreeItemsDialog.Create(Inspector);
  try
    //dlg.Font.Assign(fnt);
    dlg.TreeNodes.Assign(str);
    if dlg.Execute then
      str.Assign(dlg.TreeNodes);
  finally
    dlg.Free;
  end;

end;

end.
