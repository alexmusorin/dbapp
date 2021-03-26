unit UnitInfo;

interface

uses
  GsvObjectInspectorTypes, Classes, Types, Buttons;

type
  TGsvBounds_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvCursor_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvAlign_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvKind_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvTabPosition_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvColor16_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvColorRGB_INFO = class(TGsvObjectInspectorTypeColorRGBInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TFontStyles_INFO = class(TGsvObjectInspectorTypeSetInfo)
  public
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TGvsButtonStyles_INFO = class(TGsvObjectInspectorTypeListInfo)
   protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TAnchors_INFO = class(TGsvObjectInspectorTypeSetInfo)
  public
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TGsvAlignment_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TFont_INFO = class(TGsvObjectInspectorTypeFontInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TStrings_INFO = class(TGsvObjectInspectorTypeStringsInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;

  end;

  TTreeNodes_INFO = class(TGsvObjectInspectorTypeTreeNodesInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;

  end;

  TBitmap_INFO = class(TGsvObjectInspectorTypeBitmapInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TPicture_INFO = class(TGsvObjectInspectorTypePictureInfo)
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TFontWithColor_INFO = class(TFont_INFO)
  public
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TButton_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TToolButton_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TBitBtn_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TEdit_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TComboBox_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TDateTimePicker_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TMemo_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TGrid_Frame_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TPanel_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TToolBar_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TSplitter_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TChart_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TForm_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TGroupBox_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TCheckBox_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TRadioButton_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TPageControl_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TTabSheet_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TLabelHint_INFO = class(TGsvObjectInspectorTypeListInfo)
  protected
    class function  ListEnumItems(Index: Integer):
                    PGsvObjectInspectorListItem; override;
  public
    class function  TypeInfo: PGsvObjectInspectorPropertyInfo; override;
  end;

  TLabel_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TImage_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TProgressBar_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TMonthCalendar_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TListBox_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TCheckListBox_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  TTreeView_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  TypeName: String; override;
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

  {$M+}
  TRect_Proxy = class
  private
    FRect: PRect; // указатель на экземпляр записи

    function  GetLeft: Integer;
    function  GetTop: Integer;
    function  GetWidth: Integer;
    function  GetHeight: Integer;
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);

  public
    constructor Create(ARect: PRect);

  published
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
  end;
  {$M-}

  TRect_Proxy_INFO = class(TGsvObjectInspectorTypeInfo)
  public
    class function  ChildrenInfo(Index: Integer):
                    PGsvObjectInspectorPropertyInfo; override;
  end;

implementation

uses
  Controls, StdCtrls, Graphics, SysUtils, TypInfo, ComCtrls;

{ TGsvBounds_INFO }

class function TGsvBounds_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Положение и размер'; Kind: pkFolder; Help: 2; Hint: 'Координаты верхнего левого угла и размеры'
  );
begin
  Result := @DSK;
end;

class function TGsvBounds_INFO.ChildrenInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..4] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TGsvCursor_INFO }

class function TGsvCursor_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..2] of TGsvObjectInspectorListItem = (
    ( Name: 'Стандартный'; Data: crDefault),
    ( Name: 'Перекрестье'; Data: crCross),
    ( Name: 'Указатель'; Data: crHandPoint)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvCursor_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Курсор'; Kind: pkDropDownList; Help: 4; Hint: 'Вид курсора мыши'
  );
begin
  Result := @DSK;
end;

{ TGsvColor16_INFO }

class function TGsvColor16_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..15] of TGsvObjectInspectorListItem = (
    ( Name: 'Черный';       Data: clBlack ),
    ( Name: 'Коричневый';   Data: clMaroon ),
    ( Name: 'Темнозеленый'; Data: clGreen ),
    ( Name: 'Оливковый';    Data: clOlive ),
    ( Name: 'Фиолетовый';   Data: clNavy ),
    ( Name: 'Сиреневый';    Data: clPurple ),
    ( Name: 'Бирюзовый';    Data: clTeal ),
    ( Name: 'Темносерый';   Data: clGray ),
    ( Name: 'Светлосерый';  Data: clSilver ),
    ( Name: 'Красный';      Data: clRed ),
    ( Name: 'Травяной';     Data: clLime ),
    ( Name: 'Желтый';       Data: clYellow ),
    ( Name: 'Синий';        Data: clBlue ),
    ( Name: 'Розовый';      Data: clFuchsia ),
    ( Name: 'Голубой';      Data: clAqua ),
    ( Name: 'Белый';        Data: clWhite )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvColor16_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Цвет'; Kind: pkDropDownList; Help: 4; Hint: 'Один из стандартных цветов'
  );
begin
  Result := @DSK;
end;

{ TGsvColorRGB_INFO }

class function TGsvColorRGB_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Цвет'; Kind: pkColorRgb
  );
begin
  Result := @DSK;
end;

{ TFontStyles_INFO }

class function TFontStyles_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..2] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Style'; Caption: 'Полужирный'; Kind: pkBoolean; Tag: Ord(fsBold) ),
    ( Name: 'Style'; Caption: 'Курсив'; Kind: pkBoolean; Tag: Ord(fsItalic) ),
    ( Name: 'Style'; Caption: 'Подчеркнутый'; Kind: pkBoolean; Tag: Ord(fsUnderline) )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TFont_INFO }

class function TFont_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Шрифт'; Kind: pkDialog; Help: 3; Hint: 'Параметры шрифта - его имя и размер'
  );
begin
  Result := @DSK;
end;

class function TFont_INFO.ChildrenInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..2] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkText; Hint: 'Имя шрифта' ),
    ( Name: 'Size'; Caption: 'Размер'; Kind: pkText; Hint: 'Размер в пунктах' ),
    ( Name: 'Style'; Caption: 'Стиль'; Kind: pkSet; NestedClass: TFontStyles_INFO)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TFontWithColor_INFO }

class function TFontWithColor_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkText; Hint: 'Имя шрифта' ),
    ( Name: 'Size'; Caption: 'Размер'; Kind: pkText; Hint: 'Размер в пунктах' ),
    ( Name: 'Style'; Caption: 'Стиль'; Kind: pkSet; NestedClass: TFontStyles_INFO ),
    ( Name: 'Color'; Caption: 'Цвет'; Kind: pkColor; NestedClass: TGsvColor16_INFO )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;


{ TButton_INFO }

class function TButton_INFO.TypeName: String;
begin
  Result := 'Кнопка';
end;

class function TButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Надпись'; Kind: pkImmediateText; Help: 1; Hint: 'Надпись на кнопке' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkText; Help: 6; Hint: 'Программное имя компонента' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TLabelHint_INFO }

class function TLabelHint_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..2] of TGsvObjectInspectorListItem = (
    ( Name: 'Вариант по умолчанию' ),
    ( Name: 'Вариант 1' ),
    ( Name: 'Вариант 2' )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TLabelHint_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Подсказка'; Kind: pkTextList; Hint: 'Подсказка по компоненту'
  );
begin
  Result := @DSK;
end;

{ TLabel_INFO }

class function TLabel_INFO.TypeName: String;
begin
  Result := 'Метка';
end;

class function TLabel_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  {DSK: array[0..7] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Надпись'; Kind: pkImmediateText; Help: 1 ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Hint'; NestedClass: TLabelHint_INFO ),
    ( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Font'; NestedType: 'TFontWithColor' ),
    ( Name: 'Color'; Caption: 'Цвет'; Kind: pkColorRGB ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean )
  );}
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Надпись'; Kind: pkImmediateText; Help: 1 ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFontWithColor' ),
    ( Name: 'Color'; Caption: 'Цвет фона'; NestedClass: TGsvColorRGB_INFO ),
    ( Name: 'Alignment'; NestedClass: TGsvAlignment_INFO),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TRect_Proxy }

constructor TRect_Proxy.Create(ARect: PRect);
begin
  Assert(Assigned(ARect));
  FRect := ARect;
end;

function TRect_Proxy.GetLeft: Integer;
begin
  result := FRect^.Left;
end;

function TRect_Proxy.GetTop: Integer;
begin
  result := FRect^.Top;
end;

function TRect_Proxy.GetWidth: Integer;
begin
  result := FRect^.Right - FRect^.Left;
end;

function TRect_Proxy.GetHeight: Integer;
begin
  result := FRect^.Bottom - FRect^.Top;
end;

procedure TRect_Proxy.SetLeft(const Value: Integer);
var
  w: Integer;
begin
  w           := Width;
  FRect^.Left := Value;
  Width       := w;
end;

procedure TRect_Proxy.SetTop(const Value: Integer);
var
  h: Integer;
begin
  h          := Height;
  FRect^.Top := Value;
  Height     := h;
end;

procedure TRect_Proxy.SetWidth(const Value: Integer);
begin
  FRect^.Right := FRect^.Left + Value;
end;

procedure TRect_Proxy.SetHeight(const Value: Integer);
begin
  FRect^.Bottom := FRect^.Top + Value;
end;

{ TRect_Proxy_INFO }

class function TRect_Proxy_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    NestedClass: TGsvBounds_INFO
  );
begin
  if Index = 0 then Result := @DSK
  else              Result := nil;
end;

{ TEdit_INFO }

class function TEdit_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..14] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Text'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    //( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TEdit_INFO.TypeName: String;
begin
  Result := 'Текст';
end;

{ TPanel_INFO }

class function TPanel_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TPanel_INFO.TypeName: String;
begin
   Result := 'Панель';
end;

{ TGsvAlign_INFO }

class function TGsvAlign_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
  const
  DSK: array[0..6] of TGsvObjectInspectorListItem = (
    ( Name: 'alClient'; Data: Ord(alClient)),
    ( Name: 'alLeft'; Data: Ord(alLeft)),
    ( Name: 'alRight'; Data: Ord(alRight)),
    ( Name: 'alTop'; Data: Ord(alTop)),
    ( Name: 'alBottom'; Data: Ord(alBottom)),
    ( Name: 'alNone'; Data: Ord(alNone)),
    ( Name: 'alCustom'; Data: Ord(alCustom))
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;


class function TGsvAlign_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Положение'; Kind: pkDropDownList; Help: 4; Hint: 'Положение компонента'
  );
begin
  Result := @DSK;
end;

{ TAnchors_INFO }

class function TAnchors_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Anchors'; Caption: 'Лево'; Kind: pkBoolean; Tag: Ord(akLeft) ),
    ( Name: 'Anchors'; Caption: 'Верх'; Kind: pkBoolean; Tag: Ord(akTop) ),
    ( Name: 'Anchors'; Caption: 'Право'; Kind: pkBoolean; Tag: Ord(akRight) ),
    ( Name: 'Anchors'; Caption: 'Низ'; Kind: pkBoolean; Tag: Ord(akBottom) )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TPageControl_INFO }

class function TPageControl_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    //( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    //( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'TabPosition'; NestedClass: TGsvTabPosition_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TPageControl_INFO.TypeName: String;
begin
  Result := 'PageControl';
end;

{ TTabSheet_INFO }

class function TTabSheet_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    //( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    //( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TTabSheet_INFO.TypeName: String;
begin
  Result := 'Панель';
end;

{ TStrings_INFO }

class function TStrings_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Строки'; Kind: pkDialog; Help: 3; Hint: 'Строки'
  );
begin
  Result := @DSK;
end;

{ TComboBox_INFO }

class function TComboBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Text'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TComboBox_INFO.TypeName: String;
begin
  Result:='Поле выбора';
end;

{ TMemo_INFO }

class function TMemo_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Lines'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TMemo_INFO.TypeName: String;
begin
  Result:='Многострочный текст';
end;

{ TGroupBox_INFO }

class function TGroupBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGroupBox_INFO.TypeName: String;
begin
  Result:='Группа';
end;

{ TCheckBox_INFO }

class function TCheckBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..14] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Checked'; Caption: 'Состояние'; Kind: pkBoolean ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TCheckBox_INFO.TypeName: String;
begin
  Result:='Флажок';
end;

{ TRadioButton_INFO }

class function TRadioButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..14] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Checked'; Caption: 'Состояние'; Kind: pkBoolean ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TRadioButton_INFO.TypeName: String;
begin
  Result:='Переключатель';
end;

{ TGsvTabPosition_INFO }

class function TGsvTabPosition_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
  const
  DSK: array[0..3] of TGsvObjectInspectorListItem = (
    ( Name: 'tpLeft'; Data: Ord(tpLeft)),
    ( Name: 'tpRight'; Data: Ord(tpRight)),
    ( Name: 'tpTop'; Data: Ord(tpTop)),
    ( Name: 'tpBottom'; Data: Ord(tpBottom))
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvTabPosition_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Положение вкладок'; Kind: pkDropDownList; Help: 4; Hint: 'Положение компонента'
  );
begin
  Result := @DSK;
end;

{ TAlignment_INFO }



{ TGsvAlignment_INFO }

class function TGsvAlignment_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
  const
  DSK: array[0..2] of TGsvObjectInspectorListItem = (
    ( Name: 'taCenter'; Data: Ord(taCenter)),
    ( Name: 'taLeftJustify'; Data: Ord(taLeftJustify)),
    ( Name: 'taRightJustify'; Data: Ord(taRightJustify))
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvAlignment_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Выравнивание'; Kind: pkDropDownList; Help: 4; Hint: 'Выравнивание текста'
  );
begin
  Result := @DSK;
end;

{ TDateTimePicker_INFO }

class function TDateTimePicker_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Date'; Caption: 'Дата'; Kind: pkText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TDateTimePicker_INFO.TypeName: String;
begin
  Result:='Выбор даты';
end;

{ TForm_INFO }

class function TForm_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TForm_INFO.TypeName: String;
begin
  Result:='Форма диалога';
end;

{ TBitmap_INFO }

class function TBitmap_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Изображение'; Kind: pkDialog; Help: 3; Hint: 'Изображение'
  );
begin
  Result := @DSK;
end;

{ TBitBtn_INFO }

class function TBitBtn_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Надпись'; Kind: pkImmediateText; Help: 1; Hint: 'Надпись на кнопке' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkText; Help: 6; Hint: 'Программное имя компонента' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Glyph'; NestedType: 'TBitmap' ),
    ( Name: 'Kind'; NestedClass: TGsvKind_INFO ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TBitBtn_INFO.TypeName: String;
begin
  Result := 'Кнопка';
end;

{ TGsvKind_INFO }

class function TGsvKind_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..10] of TGsvObjectInspectorListItem = (
    ( Name: 'bkCustom'; Data: Ord(bkCustom)),
    ( Name: 'bkOK'; Data: Ord(bkOK)),
    ( Name: 'bkCancel'; Data: Ord(bkCancel)),
    ( Name: 'bkHelp'; Data: Ord(bkHelp)),
    ( Name: 'bkYes'; Data: Ord(bkYes)),
    ( Name: 'bkNo'; Data: Ord(bkNo)),
    ( Name: 'bkClose'; Data: Ord(bkClose)),
	( Name: 'bkAbort'; Data: Ord(bkAbort)),
	( Name: 'bkRetry'; Data: Ord(bkRetry)),
	( Name: 'bkIgnore'; Data: Ord(bkIgnore)),
	( Name: 'bkAll'; Data: Ord(bkAll))
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvKind_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Вид кнопки'; Kind: pkDropDownList; Help: 4; Hint: 'Вид кнопки'
  );
begin
  Result := @DSK;
end;

{ TGrid_Frame_INFO }

class function TGrid_Frame_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'FieldLabels'; NestedType: 'TStrings'),
    ( Name: 'CellStyles'; NestedType: 'TStrings'),
    ( Name: 'Query'; Caption: 'Запрос'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGrid_Frame_INFO.TypeName: String;
begin
  Result:='Таблица'
end;

{ TImage_INFO }

class function TImage_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..13] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkText; Help: 6; Hint: 'Программное имя компонента' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Picture'; NestedType: 'TPicture' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Autosize'; Caption: 'Авторазмер'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)

  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TImage_INFO.TypeName: String;
begin
  Result := 'Рисунок';
end;

{ TPicture_INFO }

class function TPicture_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Изображение'; Kind: pkDialog; Help: 3; Hint: 'Изображение'
  );
begin
  Result := @DSK;
end;

{ TProgressBar_INFO }

class function TProgressBar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Min'; Caption: 'Мин.'; Kind: pkText),
    ( Name: 'Max'; Caption: 'Макс.'; Kind: pkText),
    ( Name: 'Position'; Caption: 'Позиция'; Kind: pkText),
    ( Name: 'Step'; Caption: 'Шаг'; Kind: pkText),
    ( Name: 'Smooth'; Caption: 'Непрер.'; Kind: pkBoolean),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TProgressBar_INFO.TypeName: String;
begin
  Result := 'Прогресс';
end;

{ TCheckListBox_INFO }

class function TCheckListBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'Columns'; Caption: 'Столбцы'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TCheckListBox_INFO.TypeName: String;
begin
  Result := 'Чек лист';
end;

{ TListBox_INFO }

class function TListBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'Columns'; Caption: 'Столбцы'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TListBox_INFO.TypeName: String;
begin
  Result := 'лист';
end;

{ TMonthCalendar_INFO }

class function TMonthCalendar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Date'; Caption: 'Дата'; Kind: pkText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: 'Порядок'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TMonthCalendar_INFO.TypeName: String;
begin
  Result := 'Календарь';
end;

{ TChart_INFO }

class function TChart_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..8] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: 'Привязка'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TChart_INFO.TypeName: String;
begin
  Result:='Диаграмма';
end;

{ TSplitter_INFO }

class function TSplitter_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..7] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TSplitter_INFO.TypeName: String;
begin
  Result:='Ползунок';
end;

{ TToolBar_INFO }

class function TToolBar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'AutoSize'; Caption: 'Изм. размера'; Kind: pkBoolean ),
    ( Name: 'Flat'; Caption: 'Рельеф'; Kind: pkBoolean ),
    ( Name: 'List'; Caption: 'Как список'; Kind: pkBoolean ),
    ( Name: 'ShowCaptions'; Caption: 'Видим. меток'; Kind: pkBoolean ),
    ( Name: 'Wrapable'; Caption: 'Перенос'; Kind: pkBoolean )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TToolBar_INFO.TypeName: String;
begin
  Result:='Панель кнопок';
end;

{ TButtonStyles_INFO }



{ TGvsButtonStyles_INFO }

class function TGvsButtonStyles_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..5] of TGsvObjectInspectorListItem = (
    ( Name: 'tbsButton'; Data: Ord(tbsButton)),
    ( Name: 'tbsCheck'; Data: Ord(tbsCheck)),
    ( Name: 'tbsDropDown'; Data: Ord(tbsDropDown)),
    ( Name: 'tbsSeparator'; Data: Ord(tbsSeparator)),
    ( Name: 'tbsDivider'; Data: Ord(tbsDivider)),
    ( Name: 'tbsTextButton'; Data: Ord(tbsTextButton))
);
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGvsButtonStyles_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Стиль кнопки'; Kind: pkDropDownList; Help: 4; Hint: 'Стиль кнопки'
  );
begin
  Result := @DSK;
end;

{ TToolButton_INFO }

class function TToolButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: 'Текст'; Kind: pkImmediateText; Help: 1; Hint: 'Текст в поле ввода' ),
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'ImageIndex'; Caption: 'Рисунок'; Kind: pkText; Help: 1; Hint: 'Индекс рисунка' ),
    ( Name: 'Style'; NestedClass: TGvsButtonStyles_INFO ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'AutoSize'; Caption: 'Изм. размера'; Kind: pkBoolean ),
    ( Name: 'Grouped'; Caption: 'Группировка'; Kind: pkBoolean ),
    ( Name: 'Down'; Caption: 'Нажатие'; Kind: pkBoolean ),
    ( Name: 'Marked'; Caption: 'Пометка'; Kind: pkBoolean ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TToolButton_INFO.TypeName: String;
begin
  Result:='Кнопка на панели';
end;

{ TTreeView_INFO }

class function TTreeView_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: 'Имя'; Kind: pkReadOnlyText; Help: 6; Hint: 'Программное имя компонента' ),
    ( Name: 'Left'; Caption: 'Левый край'; Kind: pkText ),
    ( Name: 'Top'; Caption: 'Верхний край'; Kind: pkText ),
    ( Name: 'Width'; Caption: 'Ширина'; Kind: pkText ),
    ( Name: 'Height'; Caption: 'Высота'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Items'; NestedType: 'TTreeNodes'),
    ( Name: 'Visible'; Caption: 'Видимость'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: 'Тэг'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: 'Подсказка'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: 'Видимость подсказки'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TTreeView_INFO.TypeName: String;
begin
  Result:='Дерево';
end;

{ TTreeItems_INFO }

class function TTreeNodes_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: 'Элементы дерева'; Kind: pkDialog; Help: 3; Hint: 'Элементы дерева'
  );
begin
  Result := @DSK;
end;

initialization
  GsvRegisterTypesInfo([TGsvBounds_INFO, TGsvCursor_INFO, TFontStyles_INFO, TBitmap_INFO, TPicture_INFO, TGsvKind_INFO, TGvsButtonStyles_INFO,
    TFont_INFO, TFontWithColor_INFO, TButton_INFO, TLabel_INFO, TDateTimePicker_INFO, TForm_INFO, TBitBtn_INFO, TToolBar_INFO, TToolButton_INFO,
    TRect_Proxy_INFO, TEdit_INFO, TPanel_INFO, TGsvAlign_INFO,TAnchors_INFO,TPageControl_INFO,TTabSheet_INFO, TGrid_Frame_INFO,
    TStrings_INFO, TComboBox_INFO, TMemo_INFO, TGroupBox_INFO, TCheckBox_INFO, TChart_INFO, TRadioButton_INFO, TGsvTabPosition_INFO,
    TGsvAlignment_INFO, TImage_INFO,TProgressBar_INFO, TCheckListBox_INFO, TListBox_INFO, TMonthCalendar_INFO,TSplitter_INFO,TTreeView_INFO, TTreeNodes_INFO]);

end.
