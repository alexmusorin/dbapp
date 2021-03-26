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
    FRect: PRect; // ��������� �� ��������� ������

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
    Caption: '��������� � ������'; Kind: pkFolder; Help: 2; Hint: '���������� �������� ������ ���� � �������'
  );
begin
  Result := @DSK;
end;

class function TGsvBounds_INFO.ChildrenInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..4] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO )
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
    ( Name: '�����������'; Data: crDefault),
    ( Name: '�����������'; Data: crCross),
    ( Name: '���������'; Data: crHandPoint)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvCursor_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '������'; Kind: pkDropDownList; Help: 4; Hint: '��� ������� ����'
  );
begin
  Result := @DSK;
end;

{ TGsvColor16_INFO }

class function TGsvColor16_INFO.ListEnumItems(
  Index: Integer): PGsvObjectInspectorListItem;
const
  DSK: array[0..15] of TGsvObjectInspectorListItem = (
    ( Name: '������';       Data: clBlack ),
    ( Name: '����������';   Data: clMaroon ),
    ( Name: '������������'; Data: clGreen ),
    ( Name: '���������';    Data: clOlive ),
    ( Name: '����������';   Data: clNavy ),
    ( Name: '���������';    Data: clPurple ),
    ( Name: '���������';    Data: clTeal ),
    ( Name: '����������';   Data: clGray ),
    ( Name: '�����������';  Data: clSilver ),
    ( Name: '�������';      Data: clRed ),
    ( Name: '��������';     Data: clLime ),
    ( Name: '������';       Data: clYellow ),
    ( Name: '�����';        Data: clBlue ),
    ( Name: '�������';      Data: clFuchsia ),
    ( Name: '�������';      Data: clAqua ),
    ( Name: '�����';        Data: clWhite )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGsvColor16_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '����'; Kind: pkDropDownList; Help: 4; Hint: '���� �� ����������� ������'
  );
begin
  Result := @DSK;
end;

{ TGsvColorRGB_INFO }

class function TGsvColorRGB_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '����'; Kind: pkColorRgb
  );
begin
  Result := @DSK;
end;

{ TFontStyles_INFO }

class function TFontStyles_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..2] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Style'; Caption: '����������'; Kind: pkBoolean; Tag: Ord(fsBold) ),
    ( Name: 'Style'; Caption: '������'; Kind: pkBoolean; Tag: Ord(fsItalic) ),
    ( Name: 'Style'; Caption: '������������'; Kind: pkBoolean; Tag: Ord(fsUnderline) )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

{ TFont_INFO }

class function TFont_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '�����'; Kind: pkDialog; Help: 3; Hint: '��������� ������ - ��� ��� � ������'
  );
begin
  Result := @DSK;
end;

class function TFont_INFO.ChildrenInfo(Index: Integer):
  PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..2] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkText; Hint: '��� ������' ),
    ( Name: 'Size'; Caption: '������'; Kind: pkText; Hint: '������ � �������' ),
    ( Name: 'Style'; Caption: '�����'; Kind: pkSet; NestedClass: TFontStyles_INFO)
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
    ( Name: 'Name'; Caption: '���'; Kind: pkText; Hint: '��� ������' ),
    ( Name: 'Size'; Caption: '������'; Kind: pkText; Hint: '������ � �������' ),
    ( Name: 'Style'; Caption: '�����'; Kind: pkSet; NestedClass: TFontStyles_INFO ),
    ( Name: 'Color'; Caption: '����'; Kind: pkColor; NestedClass: TGsvColor16_INFO )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;


{ TButton_INFO }

class function TButton_INFO.TypeName: String;
begin
  Result := '������';
end;

class function TButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�������'; Kind: pkImmediateText; Help: 1; Hint: '������� �� ������' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkText; Help: 6; Hint: '����������� ��� ����������' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
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
    ( Name: '������� �� ���������' ),
    ( Name: '������� 1' ),
    ( Name: '������� 2' )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TLabelHint_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '���������'; Kind: pkTextList; Hint: '��������� �� ����������'
  );
begin
  Result := @DSK;
end;

{ TLabel_INFO }

class function TLabel_INFO.TypeName: String;
begin
  Result := '�����';
end;

class function TLabel_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  {DSK: array[0..7] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�������'; Kind: pkImmediateText; Help: 1 ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Hint'; NestedClass: TLabelHint_INFO ),
    ( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Font'; NestedType: 'TFontWithColor' ),
    ( Name: 'Color'; Caption: '����'; Kind: pkColorRGB ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean )
  );}
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�������'; Kind: pkImmediateText; Help: 1 ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFontWithColor' ),
    ( Name: 'Color'; Caption: '���� ����'; NestedClass: TGsvColorRGB_INFO ),
    ( Name: 'Alignment'; NestedClass: TGsvAlignment_INFO),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
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
    ( Name: 'Text'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    //( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TEdit_INFO.TypeName: String;
begin
  Result := '�����';
end;

{ TPanel_INFO }

class function TPanel_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TPanel_INFO.TypeName: String;
begin
   Result := '������';
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
    Caption: '���������'; Kind: pkDropDownList; Help: 4; Hint: '��������� ����������'
  );
begin
  Result := @DSK;
end;

{ TAnchors_INFO }

class function TAnchors_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Anchors'; Caption: '����'; Kind: pkBoolean; Tag: Ord(akLeft) ),
    ( Name: 'Anchors'; Caption: '����'; Kind: pkBoolean; Tag: Ord(akTop) ),
    ( Name: 'Anchors'; Caption: '�����'; Kind: pkBoolean; Tag: Ord(akRight) ),
    ( Name: 'Anchors'; Caption: '���'; Kind: pkBoolean; Tag: Ord(akBottom) )
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
    //( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    //( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'TabPosition'; NestedClass: TGsvTabPosition_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
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
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    //( NestedClass: TGsvBounds_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    //( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TTabSheet_INFO.TypeName: String;
begin
  Result := '������';
end;

{ TStrings_INFO }

class function TStrings_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '������'; Kind: pkDialog; Help: 3; Hint: '������'
  );
begin
  Result := @DSK;
end;

{ TComboBox_INFO }

class function TComboBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Text'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TComboBox_INFO.TypeName: String;
begin
  Result:='���� ������';
end;

{ TMemo_INFO }

class function TMemo_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Lines'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TMemo_INFO.TypeName: String;
begin
  Result:='������������� �����';
end;

{ TGroupBox_INFO }

class function TGroupBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGroupBox_INFO.TypeName: String;
begin
  Result:='������';
end;

{ TCheckBox_INFO }

class function TCheckBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..14] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Checked'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TCheckBox_INFO.TypeName: String;
begin
  Result:='������';
end;

{ TRadioButton_INFO }

class function TRadioButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..14] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Checked'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TRadioButton_INFO.TypeName: String;
begin
  Result:='�������������';
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
    Caption: '��������� �������'; Kind: pkDropDownList; Help: 4; Hint: '��������� ����������'
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
    Caption: '������������'; Kind: pkDropDownList; Help: 4; Hint: '������������ ������'
  );
begin
  Result := @DSK;
end;

{ TDateTimePicker_INFO }

class function TDateTimePicker_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Date'; Caption: '����'; Kind: pkText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TDateTimePicker_INFO.TypeName: String;
begin
  Result:='����� ����';
end;

{ TForm_INFO }

class function TForm_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..3] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TForm_INFO.TypeName: String;
begin
  Result:='����� �������';
end;

{ TBitmap_INFO }

class function TBitmap_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '�����������'; Kind: pkDialog; Help: 3; Hint: '�����������'
  );
begin
  Result := @DSK;
end;

{ TBitBtn_INFO }

class function TBitBtn_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�������'; Kind: pkImmediateText; Help: 1; Hint: '������� �� ������' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkText; Help: 6; Hint: '����������� ��� ����������' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Glyph'; NestedType: 'TBitmap' ),
    ( Name: 'Kind'; NestedClass: TGsvKind_INFO ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TBitBtn_INFO.TypeName: String;
begin
  Result := '������';
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
    Caption: '��� ������'; Kind: pkDropDownList; Help: 4; Hint: '��� ������'
  );
begin
  Result := @DSK;
end;

{ TGrid_Frame_INFO }

class function TGrid_Frame_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'FieldLabels'; NestedType: 'TStrings'),
    ( Name: 'CellStyles'; NestedType: 'TStrings'),
    ( Name: 'Query'; Caption: '������'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TGrid_Frame_INFO.TypeName: String;
begin
  Result:='�������'
end;

{ TImage_INFO }

class function TImage_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..13] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkText; Help: 6; Hint: '����������� ��� ����������' ), //pkReadOnlyText
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Picture'; NestedType: 'TPicture' ),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Autosize'; Caption: '����������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)

  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TImage_INFO.TypeName: String;
begin
  Result := '�������';
end;

{ TPicture_INFO }

class function TPicture_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '�����������'; Kind: pkDialog; Help: 3; Hint: '�����������'
  );
begin
  Result := @DSK;
end;

{ TProgressBar_INFO }

class function TProgressBar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..15] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Min'; Caption: '���.'; Kind: pkText),
    ( Name: 'Max'; Caption: '����.'; Kind: pkText),
    ( Name: 'Position'; Caption: '�������'; Kind: pkText),
    ( Name: 'Step'; Caption: '���'; Kind: pkText),
    ( Name: 'Smooth'; Caption: '������.'; Kind: pkBoolean),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TProgressBar_INFO.TypeName: String;
begin
  Result := '��������';
end;

{ TCheckListBox_INFO }

class function TCheckListBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'Columns'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TCheckListBox_INFO.TypeName: String;
begin
  Result := '��� ����';
end;

{ TListBox_INFO }

class function TListBox_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..16] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Items'; NestedType: 'TStrings'),
    ( Name: 'Cursor'; NestedClass: TGsvCursor_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'Columns'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TListBox_INFO.TypeName: String;
begin
  Result := '����';
end;

{ TMonthCalendar_INFO }

class function TMonthCalendar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..12] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Date'; Caption: '����'; Kind: pkText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'TabOrder'; Caption: '�������'; Kind: pkText),
    ( Name: 'TabStop'; Caption: 'TabStop'; Kind: pkBoolean),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TMonthCalendar_INFO.TypeName: String;
begin
  Result := '���������';
end;

{ TChart_INFO }

class function TChart_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..8] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Anchors'; Caption: '��������'; Kind: pkSet; NestedClass: TAnchors_INFO ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TChart_INFO.TypeName: String;
begin
  Result:='���������';
end;

{ TSplitter_INFO }

class function TSplitter_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..7] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TSplitter_INFO.TypeName: String;
begin
  Result:='��������';
end;

{ TToolBar_INFO }

class function TToolBar_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Font'; NestedType: 'TFont' ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'AutoSize'; Caption: '���. �������'; Kind: pkBoolean ),
    ( Name: 'Flat'; Caption: '������'; Kind: pkBoolean ),
    ( Name: 'List'; Caption: '��� ������'; Kind: pkBoolean ),
    ( Name: 'ShowCaptions'; Caption: '�����. �����'; Kind: pkBoolean ),
    ( Name: 'Wrapable'; Caption: '�������'; Kind: pkBoolean )
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TToolBar_INFO.TypeName: String;
begin
  Result:='������ ������';
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
    Caption: '����� ������'; Kind: pkDropDownList; Help: 4; Hint: '����� ������'
  );
begin
  Result := @DSK;
end;

{ TToolButton_INFO }

class function TToolButton_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Caption'; Caption: '�����'; Kind: pkImmediateText; Help: 1; Hint: '����� � ���� �����' ),
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'ImageIndex'; Caption: '�������'; Kind: pkText; Help: 1; Hint: '������ �������' ),
    ( Name: 'Style'; NestedClass: TGvsButtonStyles_INFO ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'AutoSize'; Caption: '���. �������'; Kind: pkBoolean ),
    ( Name: 'Grouped'; Caption: '�����������'; Kind: pkBoolean ),
    ( Name: 'Down'; Caption: '�������'; Kind: pkBoolean ),
    ( Name: 'Marked'; Caption: '�������'; Kind: pkBoolean ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TToolButton_INFO.TypeName: String;
begin
  Result:='������ �� ������';
end;

{ TTreeView_INFO }

class function TTreeView_INFO.ChildrenInfo(
  Index: Integer): PGsvObjectInspectorPropertyInfo;
const
  DSK: array[0..10] of TGsvObjectInspectorPropertyInfo = (
    ( Name: 'Name'; Caption: '���'; Kind: pkReadOnlyText; Help: 6; Hint: '����������� ��� ����������' ),
    ( Name: 'Left'; Caption: '����� ����'; Kind: pkText ),
    ( Name: 'Top'; Caption: '������� ����'; Kind: pkText ),
    ( Name: 'Width'; Caption: '������'; Kind: pkText ),
    ( Name: 'Height'; Caption: '������'; Kind: pkText ),
    ( Name: 'Align'; NestedClass: TGsvAlign_INFO ),
    ( Name: 'Items'; NestedType: 'TTreeNodes'),
    ( Name: 'Visible'; Caption: '���������'; Kind: pkBoolean ),
    ( Name: 'Tag'; Caption: '���'; Kind: pkText; Help: 1 ),
    ( Name: 'Hint'; Caption: '���������'; Kind: pkText),
    ( Name: 'ShowHint'; Caption: '��������� ���������'; Kind: pkBoolean)
  );
begin
  if Index <= High(DSK) then Result := @DSK[Index]
  else                       Result := nil;
end;

class function TTreeView_INFO.TypeName: String;
begin
  Result:='������';
end;

{ TTreeItems_INFO }

class function TTreeNodes_INFO.TypeInfo: PGsvObjectInspectorPropertyInfo;
const
  DSK: TGsvObjectInspectorPropertyInfo = (
    Caption: '�������� ������'; Kind: pkDialog; Help: 3; Hint: '�������� ������'
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
