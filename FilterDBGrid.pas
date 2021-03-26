unit FilterDBGrid;


interface

uses Variants, Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
      Graphics, Grids, DBGrids, StrUtils,ClipBrd,DB,Dialogs, GraphUtil, ADODB,
      Math, Masks, Menus;

type
TSortType = (stNone, stAsc, stDesc);

TCellStyle = class(TCollectionItem)
  private
    FFont: TFont;
    FColor: TColor;
    FBackgroundColor: TColor;
    FFieldName: String;
    FOperand: String;
    FFieldValue: string;
    FSingleCell: boolean;
    FImageIndex: integer;
    FImageOnly: boolean;
    procedure SetFont(const Value: TFont);
    procedure SetColor(const Value: TColor);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetFieldName(const Value: String);
    procedure SetOperand(const Value: String);
    procedure SetFieldValue(const Value: string);
    procedure SetSingleCell(const Value: boolean);
    procedure SetImageIndex(const Value: integer);
    procedure SetImageOnly(const Value: boolean);
  published
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property SingleCell:boolean read FSingleCell write SetSingleCell;
    property Font:TFont read FFont write SetFont;
    property Color:TColor read FColor write SetColor;
    property BackgroundColor:TColor read FBackgroundColor write SetBackgroundColor;
    property FieldName:String read FFieldName write SetFieldName;
    property Operand:String read FOperand write SetOperand;
    property FieldValue:string read FFieldValue write SetFieldValue;
    property ImageIndex:integer read FImageIndex write SetImageIndex;
    property ImageOnly:boolean read FImageOnly write SetImageOnly;
end;

TCellStyles = class(TCollection)
  private
    function GetCellStyle(Index: Integer): TCellStyle;
    procedure SetCellStyle(Index: Integer; const Value: TCellStyle);
  published
  public
    function  Add: TCellStyle;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    property Items[Index: Integer]: TCellStyle read GetCellStyle write SetCellStyle; default;
end;

TFilterEdit=class(TEdit)
     private
       FGrid: TCustomGrid;
       procedure InternalMove(const Loc: TRect; Redraw: Boolean);
       procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
     protected
       property  Grid: TCustomGrid read FGrid;
       procedure BoundsChanged;
       procedure UpdateContents(Key:char);
       procedure KeyDown(var Key: Word; Shift: TShiftState); override;
       procedure KeyPress(var Key: Char); override;
     public
       NewKey:String;
       constructor Create(AOwner: TComponent);override;
       procedure SetGrid(Value: TCustomGrid);
       procedure Hide;
       procedure Invalidate;
       procedure Move(const Loc: TRect);
       procedure Deselect;
       function Visible:boolean;
       procedure SetFocus;
     end;

TFilterColumn=class(TColumn)
  private
    FFilterValue:string;
    FSortType:TSortType;
    FItemList:TStringList;
    FSubHeader: String;
    procedure SetFilterValue(const Value: String);
    procedure SetSortType(const Value: TSortType);
    procedure SetSubHeader(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AddItem(Value:String);
    function FindItem(Value: String):boolean;
    function GetInfilter:string;
    procedure ClearItem;
    property Filter: String read FFilterValue write SetFilterValue;
    property SubHeader:String read FSubHeader write SetSubHeader;
    property SortType:TSortType read FSortType write SetSortType;
end;

TSetFilterEvent = procedure of object;
TEnterClickEvent = procedure of object;
TGetSQLEvent = procedure(SQL: String) of object;

type TFilterDBGrid=class(TDBGrid)
     private
       FIndicators: TImageList;
       FFilterEdit:TFilterEdit;
       FFilterCOl:integer;
       FSortColumn:integer;
       FDefaultDrawing: Boolean;
       FOnTitleClick:TDBGridClickEvent;
       FFilterEvent:TSetFilterEvent;
       UpBitmap:TBitmap;
       DownBitmap:TBitmap;
       FilterBitmap:TBitmap;
       FBookmarks: TBookmarkList;
       FFooterRowCount:integer;
       FTitleOffset, FIndicatorOffset: Byte;
       FSelRow: Integer;
       FFilters: TStringList;
       FDisplayLabels:TStringList;
       AltF9Flag:boolean;
    FCellStyles: TCellStyles;
    FImageList: TImageList;
    FOnGetSQLEvent: TGetSQLEvent;
    FOnEnterClickEvent: TenterClickEvent;
    FDefaultFilter: string;
       function CreateFilterEdit:TFilterEdit;
       function GetHeaderRect(ACol:Integer):TRect;
       procedure HideFilterEdit;
       procedure UpdateFilterEdit(Key:Char);
       procedure SetSortColumn(const Value: integer);
       function GetActiveRecord: Integer;
       function CheckFilter:boolean;
       function CheckSorted:boolean;
       procedure AddDataFilter(FieldName, Value: String);
       procedure AddNumFilter(FieldName, Value: String);
       procedure AddStringFilter(FieldName, Value: String);
    procedure SetFooterRowCount(const Value: integer);
    procedure SetCellStyles(const Value: TCellStyles);
    function CheckCellStyleId(DataLink:TGridDataLink;index:integer;SingleCell:boolean):boolean;
    procedure SetImageList(const Value: TImageList);
    procedure SetOnGetSQLEvent(const Value: TGetSQLEvent);
    procedure SetOnEnterClickEvent(const Value: TenterClickEvent);
    procedure SetDefaultFilter(const Value: string);
     protected
       property SelectedRows: TBookmarkList read FBookmarks;
       property IndicatorOffset: Byte read FIndicatorOffset;
       property DefaultDrawing: Boolean read FDefaultDrawing write FDefaultDrawing default True;
       function  CreateDataLink: TGridDataLink; dynamic;
       function  CreateColumns: TDBGridColumns; override;
       procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
                           AState: TGridDrawState);override;
       procedure LayoutChanged; override;
       procedure KeyDown(var Key: Word; Shift: TShiftState); override;
       procedure KeyPress(var Key: Char); override;
       procedure TitleClick(Column: TColumn); override;
       procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                          X, Y: Integer); override;
     public
       property DataLink;
       property RowHeights;
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure SetFilter;
       procedure Refresh;
       procedure SetFieldLabels;
       procedure AddLabel(FieldName,DisplayLabel:String;FieldWidth:Integer);
       procedure ClearLabels;
       function ColumnByFieldName(FieldName:String):TFilterColumn;
       property OnFilterEvent: TSetFilterEvent read FFilterEvent write FFilterEvent;
       property OnGetSQLEvent: TGetSQLEvent read FOnGetSQLEvent write SetOnGetSQLEvent;
       property OnEnterClickEvent: TEnterClickEvent read FOnEnterClickEvent write SetOnEnterClickEvent;
       property SortColumn:integer read FSortColumn write SetSortColumn;
       property ActiveRecord: Integer read GetActiveRecord;
       property FooterRowCount:integer read FFooterRowCount write SetFooterRowCount default 1;
       property CellStyles:TCellStyles read FCellStyles write SetCellStyles;
       property ImageList: TImageList read FImageList write SetImageList;
       property DefaultFilter: string read FDefaultFilter write SetDefaultFilter;
     end;

implementation

{$R Filter.res}

uses Types;

{ TFilterEdit }

const
  bmArrow = 'DBGARROW';
  bmEdit = 'DBEDIT';
  bmInsert = 'DBINSERT';
  bmMultiDot = 'DBMULTIDOT';
  bmMultiArrow = 'DBMULTIARROW';

var DrawBitmap: TBitmap;
    UserCount:integer;


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
  Buffer:=StringReplace(Buffer,'и','and',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'или','or',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'из','in',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'пусто','null',[rfReplaceAll]);
  Buffer:=StringReplace(Buffer,'не','not',[rfReplaceAll]);
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
  Buffer:=StringReplace(Buffer,'null',FieldName_+' is null',[rfReplaceAll]);
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

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean; DefaultRowHeight:Integer);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold{, Left}: Integer;
  I: TColorRef;
  MyRECT:TRect;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    {case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end; }
    MyRECT:=Rect(ARect.Left-1,ARect.Top-1,ARect.Right+1,ARect.Bottom-DefaultRowHeight);
    GradientFillCanvas(ACanvas,clWindow,$00EFD3C6,MyRECT,gdVertical);
    SetBkMode(ACanvas.Handle, TRANSPARENT);
    DrawText(ACanvas.Handle, PAnsiChar(Text), Length(Text), ARect, DT_LEFT or DT_WORDBREAK or DT_WORD_ELLIPSIS or DT_NOCLIP);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then  
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

function CheckFilter(FT:TFieldType;Value:string):boolean;
begin
  {case FT of
  ftString,ftWideString:Result:=true;
  ftSmallint, ftInteger, ftWord,ftLargeint,ftAutoInc:
  begin
    TempFL:=true;
    for ic:=1 to Length(Value) do
    if not (Value[ic] in ['0'..'9']) then TempFL:=false;
    Result:=TempFL;
  end;
  else Result:=true;
  end;}
  REsult:=true
end;

procedure TFilterEdit.BoundsChanged;
var
  R: TRect;
begin
  R := Rect(2, 2, Width - 2, Height);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;


constructor TFilterEdit.Create(AOwner: TComponent);
begin
  inherited;
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  DoubleBuffered := False;
  NewKey:='';
  //Color:=clBtnFace;
  Color:=clMoneyGreen;
end;

procedure TFilterEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

procedure TFilterEdit.Hide;
begin
  if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
      SWP_NOREDRAW);
    if Focused then Windows.SetFocus(Grid.Handle);
  end;
end;

procedure TFilterEdit.InternalMove(const Loc: TRect; Redraw: Boolean);
begin
  if IsRectEmpty(Loc) then Hide
  else
  begin
    CreateHandle;
    Redraw := Redraw or not IsWindowVisible(Handle);
    Invalidate;
    with Loc do
      SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top,
        SWP_SHOWWINDOW or SWP_NOREDRAW);
    BoundsChanged;
    if Redraw then Invalidate;
    if Grid.Focused then
      Windows.SetFocus(Handle);
  end;
end;

procedure TFilterEdit.Invalidate;
var
  Cur: TRect;
begin
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Grid.Handle, Cur, 2);
  ValidateRect(Grid.Handle, @Cur);
  InvalidateRect(Grid.Handle, @Cur, False);
end;

procedure TFilterEdit.KeyDown(var Key: Word; Shift: TShiftState);
var Index1:integer;

begin
  if (Key=13) or (Key = VK_DOWN) then
  begin
    Key:=0;
    Hide;
    TFilterColumn(TFilterDBGrid(Grid).Columns[TDBGrid(Grid).SelectedIndex]).Filter:=Text;
    Grid.SetFocus;
    Index1:=TFilterDBGrid(Grid).SelectedIndex;
    TFilterDBGrid(Grid).SetFilter;
    TFilterDBGrid(Grid).SelectedIndex:=Index1;
    TFilterDBGrid(Grid).Repaint;
  end;
  inherited;
end;

procedure TFilterEdit.KeyPress(var Key: Char);
begin
  if Key=#13 then Key:=#0;
  inherited KeyPress(Key);
end;

procedure TFilterEdit.Move(const Loc: TRect);
begin
  InternalMove(Loc, True);
end;

procedure TFilterEdit.SetFocus;
begin
  if IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TFilterEdit.SetGrid(Value: TCustomGrid);
begin
  FGrid:=Value;
end;

procedure TFilterEdit.UpdateContents;
begin
  Text:=TFilterColumn(TFilterDBGrid(Grid).Columns[TDBGrid(Grid).SelectedIndex]).Filter+Key;
end;

function TFilterEdit.Visible: boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TFilterEdit.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  TFilterColumn(TFilterDBGrid(Grid).Columns[TDBGrid(Grid).SelectedIndex]).Filter:=Text;
  Hide;
end;

{ TFilterDBGrid }





procedure TFilterDBGrid.AddDataFilter(FieldName, Value: String);
var Bfilter:String;
begin
  if Pos('_',Value)<>0 then
  Begin
    FFilters.Add(' ('+FieldName+' LIKE ''%'+Value+'%'') ');
  End else
  Begin
    BFilter:=DateAsADOSQL(Value);
    if Bfilter[1]='#' then BFilter:='='+Bfilter;
    BFilter:=ParseStr(Bfilter, FieldName);
    FFilters.Add('('+Bfilter+')');
  End;
end;

procedure TFilterDBGrid.AddLabel(FieldName, DisplayLabel: String;
  FieldWidth: Integer);
begin
  FDisplayLabels.AddObject(FieldName+'='+DisplayLabel,Pointer(FieldWidth));
end;

procedure TFilterDBGrid.AddNumFilter(FieldName, Value: String);
var Bfilter:String;
begin
  BFilter:=ParseStr(Value,FieldName);
  FFilters.Add('('+Bfilter+')');
end;

procedure TFilterDBGrid.AddStringFilter(FieldName, Value: String);
begin
  if (Pos('in (',Value)<>0) or (Pos('из (',Value)=1) then
  begin
    FFilters.Add(' ('+FieldName+' '+StringReplace(Value,'из (', 'in (', [rfReplaceAll])+')');
  end else
  begin
    if (LowerCase(Value)='null') or (LowerCase(Value)='пусто') then
    begin
      FFilters.Add('('+FieldName+'='''' or '+FieldName+' is null) ');
    end
    else if (LowerCase(Value)='not null') or (LowerCase(Value)='!null') or (LowerCase(Value)='!пусто') or (LowerCase(Value)='не пусто') then
    begin
      FFilters.Add('('+FieldName+'<>'''' and not '+FieldName+' is null) ');
    end else
    if Value[1]='!' then
    begin
      Value:=RightStr(Value,Length(Value)-1);
      FFilters.Add('(not ('+FieldName+' LIKE '''+Value+'%'')) ');
    end
    else
      FFilters.Add(' ('+FieldName+' LIKE '''+Value+'%'') ');
  end;
end;

function TFilterDBGrid.CheckCellStyleId(DataLink: TGridDataLink;
  index: integer; SingleCell:boolean): boolean;
var j:integer;
    res:boolean;
    V1,V2:String;
    D1,D2: TDate;
    F1,F2: Double;
    I1,I2: Integer;
begin
  res:=false;
  if CellStyles.Items[index].SingleCell=SingleCell then
  try
    for j := 0 to DataLink.FieldCount - 1 do
    begin
       if (AnsiUpperCase(CellStyles.Items[index].FieldName)=AnsiUpperCase(DataLink.Fields[j].FieldName)) then
       begin
         V1:=CellStyles.Items[index].FieldValue;
         V2:=DataLink.Fields[j].DisplayText;
         if V1='null' then
         begin
           if (CellStyles.Items[index].Operand='=') and DataLink.Fields[j].IsNull then res:=true;
           if (CellStyles.Items[index].Operand='<>') and not DataLink.Fields[j].IsNull then res:=true;
         end else
         try
         case DataLink.Fields[j].DataType of
           ftString, ftMemo, ftWideString: begin
             if (CellStyles.Items[index].Operand='=') and (V1=V2) then res:=true;
             if (CellStyles.Items[index].Operand='<>') and (V1<>V2) then res:=true;
             if (CellStyles.Items[index].Operand='like') and MatchesMask(V2,V1) then res:=true;
           end;
           ftDateTime, ftTimeStamp, ftDate, ftTime: begin
            D1:=StrToDate(V1);
            D2:=StrToDate(V2);
            if (CellStyles.Items[index].Operand='=') and (D1=D2) then res:=true;
            if (CellStyles.Items[index].Operand='>') and (D1<D2) then res:=true;
            if (CellStyles.Items[index].Operand='<') and (D1>D2) then res:=true;
            if (CellStyles.Items[index].Operand='<=') and (D1>=D2) then res:=true;
            if (CellStyles.Items[index].Operand='>=') and (D1<=D2) then res:=true;
            if (CellStyles.Items[index].Operand='<>') and (D1<>D2) then res:=true;
           end;
           ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc: begin
            I1:=StrToInt(V1);
            I2:=StrToInt(V2);
            if (CellStyles.Items[index].Operand='=') and (I1=I2) then res:=true;
            if (CellStyles.Items[index].Operand='>') and (I1<I2) then res:=true;
            if (CellStyles.Items[index].Operand='<') and (I1>I2) then res:=true;
            if (CellStyles.Items[index].Operand='<=') and (I1>=I2) then res:=true;
            if (CellStyles.Items[index].Operand='>=') and (I1<=I2) then res:=true;
            if (CellStyles.Items[index].Operand='<>') and (I1<>I2) then res:=true;
           end;
           ftFloat, ftCurrency, ftBCD: begin
            F1:=StrToFloat(V1);
            F2:=StrToFloat(V2);
            if (CellStyles.Items[index].Operand='=') and (F1=F2) then res:=true;
            if (CellStyles.Items[index].Operand='>') and (F1<F2) then res:=true;
            if (CellStyles.Items[index].Operand='<') and (F1>F2) then res:=true;
            if (CellStyles.Items[index].Operand='<=') and (F1>=F2) then res:=true;
            if (CellStyles.Items[index].Operand='>=') and (F1<=F2) then res:=true;
            if (CellStyles.Items[index].Operand='<>') and (F1<>F2) then res:=true;
           end;
         end;
         except
           res:=false;
         end;
       end;
    end;
  except
    res:=false;
  end;
    result:=res;
end;


function TFilterDBGrid.CheckFilter: boolean;
var i:integer;
begin
  Result:=true;
  for i := 0 to Columns.Count - 1 do
    if TFilterColumn(Columns.Items[i]).Filter<>'' then exit;
  Result:=false;
end;

function TFilterDBGrid.CheckSorted: boolean;
var i:integer;
begin
  Result:=true;
  for i := 0 to Columns.Count - 1 do
    if TFilterColumn(Columns.Items[i]).SortType<>stNone then exit;
  Result:=false;
end;

procedure TFilterDBGrid.ClearLabels;
begin
  FDisplayLabels.Clear;
end;

function TFilterDBGrid.ColumnByFieldName(FieldName: String): TFilterColumn;
var i:integer;
begin
  for I := 0 to Columns.Count - 1 do
  begin
    Result:=TFilterColumn(Columns.Items[i]);
    if WideCompareText(Columns.Items[i].FieldName, FieldName) = 0 then Exit;
  end;
  Result:=nil;
end;

constructor TFilterDBGrid.Create(AOwner: TComponent);
var Bmp:TBitmap;
begin
  inherited Create(AOwner);
  inherited DefaultDrawing := False;
  AltF9Flag:=false;
  FAcquireFocus := True;
  FFooterRowCount:=1;
  Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  ReadOnly:=true;
  UsesBitmap;
  UpBitmap:=TBitmap.Create;
  UpBitmap.Handle:=LoadBitmap(hInstance,'UP');
  UpBitmap.TransparentColor:=clWhite;
  UpBitmap.Transparent:=true;
  DownBitmap:=TBitmap.Create;
  DownBitmap.Handle:=LoadBitmap(hInstance,'DOWN');
  DownBitmap.TransparentColor:=clWhite;
  DownBitmap.Transparent:=true;
  FilterBitmap:=TBitmap.Create;
  FilterBitmap.Handle:=LoadBitmap(hInstance,'FILTER');
  FilterBitmap.Transparent:=true;
  Filterbitmap.TransparentColor:=clWhite;
  FBookmarks := TBookmarkList.Create(Self);
  FDisplayLabels:=TStringList.Create;
  FDefaultDrawing := True;
  FTitleOffset:=1;
  FIndicatorOffset:=1;
  FFilters := TStringList.Create;
  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    FIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    FIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    FIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;
  FCellStyles:=TCellStyles.Create(TCellStyle);

end;

function TFilterDBGrid.CreateColumns: TDBGridColumns;
begin
  Result := TDBGridColumns.Create(Self, TFilterColumn);
end;

function TFilterDBGrid.CreateDataLink: TGridDataLink;
begin
  Result := TGridDataLink.Create(Self);
end;

function TFilterDBGrid.CreateFilterEdit: TFilterEdit;
begin
  Result:=TFilterEdit.Create(Self);
end;

destructor TFilterDBGrid.Destroy;
begin
  UpBitmap.Free;
  DownBitmap.Free;
  FFilterEdit.Free;
  FilterBitmap.Free;
  FIndicators.Free;
  FBookmarks.Free;
  FFilters.Free;
  FDisplayLabels.Free;
  FCellStyles.Free;
  inherited;
end;


procedure TFilterDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  FrameOffs: Byte;

  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      FBookmarks.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;

  procedure DrawTitleCell(ACol, ARow: Integer; Column: TColumn; var AState: TGridDrawState);
  const
    ScrollArrows: array [Boolean, Boolean] of Integer =
      ((DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT), (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
  var
    MasterCol: TColumn;
    TitleRect, TextRect, ButtonRect, MyRect: TRect;
    I: Integer;
    InBiDiMode: Boolean;
    FilterText: String;
    SubHeader: String;
    SubRect:TRect;
  begin
    TitleRect := CalcTitleRect(Column, ARow, MasterCol);

    if MasterCol = nil then
    begin
      Canvas.FillRect(ARect);
      Exit;
    end;

    Canvas.Font := MasterCol.Title.Font;
    Canvas.Font.Name:='Tahoma';
    //Canvas.Brush.Color := MasterCol.Title.Color;
    if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
      InflateRect(TitleRect, -1, -1);
    TextRect := TitleRect;
    I := GetSystemMetrics(SM_CXHSCROLL);
    if ((TextRect.Right - TextRect.Left) > I) and MasterCol.Expandable then
    begin
      Dec(TextRect.Right, I);
      ButtonRect := TitleRect;
      ButtonRect.Left := TextRect.Right;
      I := SaveDC(Canvas.Handle);
      try
        Canvas.FillRect(ButtonRect);
        InflateRect(ButtonRect, -1, -1);
        IntersectClipRect(Canvas.Handle, ButtonRect.Left,
          ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom);
        InflateRect(ButtonRect, 1, 1);
        InBiDiMode := Canvas.CanvasOrientation = coRightToLeft;
        if InBiDiMode then { stretch the arrows box }
          Inc(ButtonRect.Right, GetSystemMetrics(SM_CXHSCROLL) + 4);
        DrawFrameControl(Canvas.Handle, ButtonRect, DFC_SCROLL,
          ScrollArrows[InBiDiMode, MasterCol.Expanded] or DFCS_FLAT);
      finally
        RestoreDC(Canvas.Handle, I);
      end;
    end;
    with MasterCol.Title do
    begin
      SubHeader:=TFilterColumn(MasterCol).SubHeader;
      if SubHeader<>'' Then
      begin
        TextRect.Top:=TextRect.Top+DefaultRowheight;
        SubRect:=GetHeaderRect(ACol);
        Canvas.Pen.Color:=clBlack;
        Canvas.Rectangle(SubRect);
        SubRect.Bottom:=SubRect.Bottom-1;
        GradientFillCanvas(Canvas,clWindow,$00EFD3C6,SubRect,gdVertical);
        SetBkMode(Canvas.Handle, TRANSPARENT);
        InflateRect(SubRect,-2,-1);
        DrawText(Canvas.Handle, PAnsiChar(SubHeader), Length(SubHeader), SubRect, DT_SINGLELINE or DT_LEFT or DT_WORD_ELLIPSIS or DT_NOCLIP);
      end;
      WriteText(Canvas, TextRect, FrameOffs, FrameOffs, Caption, Alignment,
        IsRightToLeft, DefaultRowHeight);
      FilterText:=TFilterColumn(MasterCol).Filter;
      MyRECT:=Rect(ARect.Left,ARect.Top+DefaultRowHeight*3-1,ARect.Right,ARect.Bottom);
      InflateRect(MyRECT,2,2);
      Canvas.Brush.Color:=clMoneyGreen;
      Canvas.FillRect(MyRect);
      Canvas.Pen.Color:=clTeal;
      Canvas.Rectangle(MyRect);
      Canvas.Font.Style:=[];
      MyRECT:=Rect(ARect.Left+15,ARect.Top+3*DefaultRowHeight+2,ARect.Right+2,ARect.Bottom);
      DrawText(Canvas.Handle, PAnsiChar(FilterText), Length(FilterText), MyRECT, {DT_SINGLELINE}DT_WORDBREAK or DT_LEFT or DT_WORD_ELLIPSIS or DT_NOCLIP);
      if FilterText<>'' then Canvas.Draw(MyRECT.Left-13,MyRECT.Top+1,FilterBitmap);
      if TFilterColumn(MasterCol).SortType=stAsc then
           Canvas.Draw(ARect.Right-19,DefaultRowHeight*2+3,DownBitmap);
       if TFilterColumn(MasterCol).SortType=stDesc then
           Canvas.Draw(ARect.Right-19,DefaultRowHeight*2+3,UpBitmap);
    end;
    AState := AState - [gdFixed];  // prevent box drawing later
  end;

var
  OldActive: Integer;
  Indicator: Integer;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TColumn;
  MultiSelected: Boolean;
  ALeft: Integer;
  i:integer;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    //Canvas.FillRect(ARect);
    InflateRect(ARect, 1, 1);
    GradientFillCanvas(Canvas,clWindow,$00EFD3C6,ARect,gdVertical);
    if (dgTitles in Options) and (gdFixed in AState)  then
       begin
         if not CheckFilter then
            DrawFrameControl(Canvas.Handle,Rect(1,10,10,20),DFC_BUTTON,DFCS_BUTTONPUSH or DFCS_FLAT)
         else
            DrawFrameControl(Canvas.Handle,Rect(1,10,10,20),DFC_CAPTION,DFCS_BUTTONCHECK or DFCS_FLAT);
         if not CheckSorted then
            DrawFrameControl(Canvas.Handle,Rect(1,21,10,31),DFC_BUTTON,DFCS_BUTTONPUSH or DFCS_FLAT)
         else
            DrawFrameControl(Canvas.Handle,Rect(1,21,10,31),DFC_CAPTION,DFCS_BUTTONCHECK or DFCS_FLAT);
         if not AltF9Flag then
            DrawFrameControl(Canvas.Handle,Rect(1,32,10,42),DFC_BUTTON,DFCS_BUTTONPUSH or DFCS_FLAT)
         else
            DrawFrameControl(Canvas.Handle,Rect(1,32,10,42),DFC_CAPTION,DFCS_BUTTONCHECK or DFCS_FLAT);
       end;
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := DataLink.ActiveRecord;
        try
          Datalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          Datalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = DataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if DataLink.DataSet <> nil then
          case DataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> Datalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        FIndicators.BkColor := FixedColor;
        ALeft := ARect.Right - FIndicators.Width - FrameOffs;
        if Canvas.CanvasOrientation = coRightToLeft then Inc(ALeft);
        FIndicators.Draw(Canvas, ALeft,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator, True);
        if ARow = Datalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    Font.Color := clBlack;
    DrawColumn := Columns[ACol];
    if not DrawColumn.Showing then Exit;
    if not (gdFixed in AState) then
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    if ARow < 0 then
      DrawTitleCell(ACol, ARow + FTitleOffset, DrawColumn, AState)
    else if (DataLink = nil) or not DataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if DataLink.ActiveRecord = Row-1 then
        begin
          Brush.Color:=RGB($FD,$FD,$CC);
        end;
        if Highlight  then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if not Enabled then
          Font.Color := clGrayText;
        if FDefaultDrawing then
        /////////////////////////////////////////////////
         for i := 0 to CellStyles.Count - 1 do
         begin
           if CheckCellStyleId(DataLink,i,false) then
           begin
            if not Highlight then
             begin
             Font.Assign(Cellstyles.Items[i].Font);
             Brush.Color:=Cellstyles.Items[i].Color;
             end;
           end;
           if CheckCellStyleId(DataLink,i,true) then
           begin
              if not Highlight and (AnsiUpperCase(Cellstyles.Items[i].FieldName)=AnsiUpperCase(DrawColumn.Field.FieldName)) and not Cellstyles.Items[i].ImageOnly then
              begin
                Font.Assign(Cellstyles.Items[i].Font);
                Brush.Color:=Cellstyles.Items[i].Color;
              end;
              if Assigned(FImageList) and (Cellstyles.Items[i].ImageIndex<>-1) and (AnsiUpperCase(Cellstyles.Items[i].FieldName)=AnsiUpperCase(DrawColumn.Field.FieldName)) then
              begin
                Canvas.FillRect(ARect);
                FImageList.Draw(Canvas,ARect.Left+1,ARect.Top,Cellstyles.Items[i].ImageIndex);
                ARect.Left:=ARect.Left+18;
              end;
           end;
         end;
         if (DataLink.ActiveRecord = Row-1) and (Brush.Color=clWhite) then
         begin
           Brush.Color:=RGB($FD,$FD,$CC);
         end;
          ///  ///////////////////////////////////////////
         Canvas.FillRect(ARect);
         InflateRect(ARect,-1,-1);
         if TFilterColumn(DrawColumn).FindItem(DrawColumn.Field.DisplayText) then
         begin
           DrawFrameControl(Canvas.Handle,Rect(ARect.Left,ARect.Top,ARect.Left+12,ARect.Top+12),DFC_BUTTON,DFCS_CHECKED);
           ARect.Left:=ARect.Left+13;
           DrawText(Canvas.Handle, PAnsiChar(Value), Length(Value), ARect, DT_SINGLELINE or DT_LEFT or DT_WORD_ELLIPSIS or DT_NOCLIP);
         end
         else DrawText(Canvas.Handle, PAnsiChar(Value), Length(Value), ARect, DT_SINGLELINE or DT_LEFT or DT_WORD_ELLIPSIS or DT_NOCLIP);
         InflateRect(ARect,1,1);
         DrawDataCell(ARect, DrawColumn.Field, AState);
         DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        DataLink.ActiveRecord := OldActive;
      end;
      if FDefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self) then
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
end;




function TFilterDBGrid.GetActiveRecord: Integer;
begin
    Result:=DataLink.ActiveRecord;
end;


function TFilterDBGrid.GetHeaderRect(ACol: Integer): TRect;
var i:integer;
    SubHeader:String;
    HeaderWidth:integer;
    MasterCol:TColumn;
    MinLeft:Integer;
    TitleRect:TRect;
begin
  SubHeader:=TFilterColumn(Columns[ACol]).SubHeader;
  HeaderWidth:=0;
  MinLeft:=1000000000;
  for i := 0 to Columns.Count - 1 do
  begin
    if TFilterColumn(Columns[i]).SubHeader=SubHeader then
    begin
       TitleRect:=CalcTitleRect(Columns[i],0,MasterCol);
       HeaderWidth:=HeaderWidth+(TitleRect.Right-TitleRect.Left)+1;
       if (TitleRect.Left<MinLeft) and (TitleRect.Left<>0) then
         MinLeft:=TitleRect.Left;
    end;
  end;
  Result:= Rect(MinLeft,0,MinLeft+HeaderWidth-1,DefaultRowHeight);
end;

procedure TFilterDBGrid.HideFilterEdit;
begin
  if FFilterEdit <> nil then
    try
      //UpdateText;
    finally
      FFilterCol := -1;
      FFilterEdit.Hide;
    end;
end;

procedure TFilterDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var ind1:integer;
    i:integer;
    ADC:TADOQuery;
begin
  inherited;
  if (Key=VK_UP) and (ssCtrl in Shift) then
  begin
    if FFilterEdit<>nil then FFilterEdit.NewKey:='';
    UpdateFilterEdit(#0);
  End;
  if (Key=VK_F9) and (ssAlt in Shift) then
  begin
    AltF9Flag:=not AltF9Flag;
    SetFilter;
  end;
  if (Key=VK_F8) and (ssCtrl in Shift) and DataSource.DataSet.Active then
  begin
    ADC:=TADOQuery.Create(Application);
    ADC.Connection:=TADOQuery(DataSource.DataSet).Connection;
    if Columns[SelectedIndex].Field.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc, ftFloat, ftCurrency, ftBCD] then
    begin
       ADC.SQL.Text :='select Count(*), sum('+Columns[SelectedIndex].Field.FieldName+') from ('+TADOQuery(DataSource.DataSet).SQL.Text+')';
       ADC.Open;
       ShowMessage('Число записей: '+ADC.Fields.Fields[0].AsString+' Сумма по полю ['+Columns[SelectedIndex].Field.DisplayLabel+']: '+ADC.Fields.Fields[1].AsString);
    end
    else
    begin
      ADC.SQL.Text :='select Count(*) from ('+TADOQuery(DataSource.DataSet).SQL.Text+')';
      ADC.Open;
      ShowMessage('Число записей: '+ADC.Fields.Fields[0].AsString);
    end;
    ADC.Free;
  end;
  if (Key=VK_F4) and (ssShift in Shift) then
  begin
    if Assigned(FOnGetSQLEvent) and DataSource.DataSet.Active then
      FOnGetSQLEvent(TADOQuery(DataSource.DataSet).SQL.Text);
  end;
  if (Key=VK_DELETE) and (Shift = []) then
  begin
    TFilterColumn(Columns[SelectedIndex]).Filter:='';
    if Assigned(FFilterEdit) then FFilterEdit.Text:='';
    Ind1:=SelectedIndex;
    SetFilter;
    SelectedIndex:=ind1;
    Repaint;
  end;
  if (Key=VK_DELETE) and (ssCtrl in Shift) then
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      TFilterColumn(Columns[i]).Filter:='';
      TFilterColumn(Columns[i]).ClearItem;
      TFilterColumn(Columns[i]).SortType:=stNone;
    end;
    SetFilter;
    AltF9Flag:=false;
  end;
  if (Key=VK_INSERT) and (ssCtrl in Shift) then
  ClipBoard.AsText:=Columns[SelectedIndex].Field.AsString;
  if (Key=VK_INSERT) and (Shift = []) then
  begin
    TFilterColumn(Columns[SelectedIndex]).AddItem(Columns[SelectedIndex].Field.AsString);
    TADOQuery(DataSource.DataSet).Next;
    Repaint;
  end;
  If (Key = VK_RETURN) and Assigned(FOnEnterClickEvent) then FOnEnterClickEvent;

end;

procedure TFilterDBGrid.KeyPress(var Key: Char);
begin
  if Key in [#32..#255] then
  begin
    if FFilterEdit<>nil then FFilterEdit.KeyPress(Key);
    UpdateFilterEdit(Key);
  end
  else inherited;
end;

procedure TFilterDBGrid.LayoutChanged;
begin
  inherited;
  if dgTitles in Options then RowHeights[0]:=DefaultRowHeight*4;
end;



procedure TFilterDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
  var
  Cell: TGridCoord;
  NRect:TRect;
begin
  inherited;
  Cell := MouseCoord(X,Y);
  if (Y < 4*DefaultRowHeight) and (Y>3*DefaultRowHeight) and (Cell.x>0) then
  begin
    SelectedIndex:= Cell.x-1;
    NRect:=CellRect(Cell.X, Cell.Y);
    if FFilterEdit<>nil then FFilterEdit.NewKey:='';
    UpdateFilterEdit(#0);
    FFilterEdit.Move(Rect(nRect.Left,3*DefaultRowHeight+2,nRect.Right-1,4*DefaultRowHeight-1));
    FFilterEdit.Text:=TFilterColumn(Columns[Cell.x-1]).Filter;
  end;
end;



procedure TFilterDBGrid.Refresh;
var Bookmark: TBookmark;
    sPos: integer;
begin
   Bookmark:= TADOQuery(DataSource.DataSet).GetBookmark;
   sPos := GetScrollPos(self.Handle, SB_VERT);
   try
     TADOQuery(DataSource.DataSet).DisableControls;
     TADOQuery(DataSource.DataSet).Close;
     TADOQuery(DataSource.DataSet).Open;
     TADOQuery(DataSource.DataSet).EnableControls;
     if TADOQuery(DataSource.DataSet).BookmarkValid(Bookmark) then TADOQuery(DataSource.DataSet).GotoBookmark(Bookmark);
     PostMessage(self.Handle, WM_VSCROLL, SB_THUMBPOSITION or (sPos shl 16), 0);
     PostMessage(self.Handle, WM_VSCROLL, SB_THUMBPOSITION or (sPos shl 16), 0);
   finally
     TADOQuery(DataSource.DataSet).FreeBookmark(Bookmark);
   end;
   SetFieldLabels;
end;

procedure TFilterDBGrid.SetCellStyles(const Value: TCellStyles);
begin
  CellStyles.Assign(Value);
end;

procedure TFilterDBGrid.SetDefaultFilter(const Value: string);
begin
  FDefaultFilter := Value;
end;

procedure TFilterDBGrid.SetFieldLabels;
var i:integer;
    Header,SubHeader:string;
begin
  for i := 0 to FDisplayLabels.Count - 1 do
  begin
    if Pos('|',FDisplayLabels.ValueFromIndex[i])<>0 then
    begin
      Header:=LeftStr(FDisplayLabels.ValueFromIndex[i],Pos('|',FDisplayLabels.ValueFromIndex[i])-1);
      SubHeader:=RightStr(FDisplayLabels.ValueFromIndex[i],Length(FDisplayLabels.ValueFromIndex[i])-Length(Header)-1);
    end
    else
    begin
      Header:=FDisplayLabels.ValueFromIndex[i];
      SubHeader:='';
    end;
    TADOQuery(DataSource.DataSet).FieldByName(FDisplayLabels.Names[i]).DisplayLabel:=Header;
    ColumnByFieldName(FDisplayLabels.Names[i]).SubHeader:=SubHeader;
    TADOQuery(DataSource.DataSet).FieldByName(FDisplayLabels.Names[i]).DisplayWidth:=Integer(FDisplayLabels.Objects[i]);
  end;
end;

procedure TFilterDBGrid.SetFilter;
var i:integer;
    SQL:String;
    SQLInFilter:String;
    OldSQL:string;
    OrderBy:TStringList;
begin
  //if Assigned(OnFilterEvent) then FFilterEvent;
  if DataSource.DataSet is TADOQuery then
  begin
    SQL:=TADOQuery(DataSource.DataSet).SQL.Text;
    if Pos('WHERE (1=1)',AnsiUpperCase(SQL))=0 then SQL:=SQL+' WHERE (1=1)';
    if Pos('WHERE (1=1)',AnsiUpperCase(SQL))<>0 Then SQL:=LeftStr(SQL,Pos('WHERE (1=1)',AnsiUpperCase(SQL))+11);
    if FDefaultFilter='' then FDefaultFilter:='(0=0)';
    SQL:=SQL + ' and ' + FDefaultFilter + ' ';
    FFilters.Clear;
    for i := 0 to Columns.Count - 1 do
    begin
      if TFilterColumn(Columns.Items[i]).Filter<>'' then
      begin
        Case Columns.Items[i].Field.DataType of
          ftString,ftWideString,ftUnknown: AddStringFilter(Columns.Items[i].Field.FieldName,TFilterColumn(Columns.Items[i]).Filter);
          ftAutoInc,ftLargeint,ftFloat,ftWord,ftCurrency,ftSmallint,ftInteger, ftBCD:AddNumFilter(Columns.Items[i].Field.FieldName,TFilterColumn(Columns.Items[i]).Filter);
          ftDateTime,ftDate:AddDataFilter(Columns.Items[i].Field.FieldName,TFilterColumn(Columns.Items[i]).Filter);
        End;
      end;
    end;
  end;
  for i := 0 to FFilters.Count - 1 do
    SQL:=SQL+' and '+FFilters[i];
  if AltF9Flag then
  begin
    SQLInFilter:='';
    for i := 0 to Columns.Count - 1 do
      if TFilterColumn(Columns.Items[i]).GetInfilter<>'' then SQLInFilter:=SQLInFilter+' or '+TFilterColumn(Columns.Items[i]).GetInfilter;
    if SQLInFilter<>'' then SQLInFilter:=' and ((1=0) '+SQLInFilter+') ';
    SQL:=SQL+SQLInFilter;
  end;
  OrderBy:=TStringList.Create;
  for i := 0 to Columns.Count - 1 do
  begin
     if TFilterColumn(Columns.Items[i]).SortType = stAsc then
        OrderBy.Add(Columns.Items[i].Field.FieldName+' ASC');
     if TFilterColumn(Columns.Items[i]).SortType = stDesc then
        OrderBy.Add(Columns.Items[i].Field.FieldName+' DESC');
  end;
  if OrderBy.Count>0 then
    SQL:=SQL+' ORDER BY '+ ReplaceStr(OrderBy.CommaText,'"','');
  OrderBy.Free;
  TADOQuery(DataSource.DataSet).Close;
  OldSql:= TADOQuery(DataSource.DataSet).SQL.Text;
  try
    TADOQuery(DataSource.DataSet).SQL.Text:=SQL;
    TADOQuery(DataSource.DataSet).Open;
  except
    on E: Exception do
    begin
      TADOQuery(DataSource.DataSet).SQL.Text:=OldSQL;
      TADOQuery(DataSource.DataSet).Open;
    end;
  end;
  SetFieldLabels;
end;

procedure TFilterDBGrid.SetFooterRowCount(const Value: integer);
begin
  FFooterRowCount := Value;
end;

procedure TFilterDBGrid.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
end;

procedure TFilterDBGrid.SetOnEnterClickEvent(const Value: TenterClickEvent);
begin
  FOnEnterClickEvent := Value;
end;

procedure TFilterDBGrid.SetOnGetSQLEvent(const Value: TGetSQLEvent);
begin
  FOnGetSQLEvent := Value;
end;

procedure TFilterDBGrid.SetSortColumn(const Value: integer);
begin
  FSortColumn := Value;
  Repaint;
end;



procedure TFilterDBGrid.TitleClick(Column: TColumn);
begin
   case TFilterColumn(Column).SortType of
    stDesc: TFilterColumn(Column).SortType:=stNone;
    stAsc:  TFilterColumn(Column).SortType:=stDesc;
    stNone: TFilterColumn(Column).SortType:=stAsc;
  end;
  inherited TitleClick(Column);
  if DataSource.DataSet.Active then
  begin
    Repaint;
    SetFilter;
  end;
end;

procedure TFilterDBGrid.UpdateFilterEdit(Key:Char);
var NRect:TRect;

 procedure UpdateEditor(Key_:Char);
  begin
    FFilterCol := Col;
    FFilterEdit.UpdateContents(Key_);
  end;

begin
   if FFilterEdit = nil then
    begin
      FFilterEdit := CreateFilterEdit;
      FFilterEdit.AutoSelect:=false;
      FFilterEdit.SetGrid(Self);
      FFilterEdit.Parent := Self;
      UpdateEditor(Key);
      FFilterEdit.SelStart:=FFilterEdit.Perform(EM_SCROLLCARET,1,0)+100;
    end
    else
    begin
      if (Col <> FFilterCol) then
      begin
        HideFilterEdit;
      end;
      UpdateEditor(Key);
        FFilterEdit.SelStart:=FFilterEdit.Perform(EM_SCROLLCARET,1,0)+100;
    end;
    NRect:=CellRect(Col, Row);
    FFilterEdit.Move(Rect(nRect.Left,3*DefaultRowHeight+2,nRect.Right-1,4*DefaultRowHeight-1));
end;





{ TFilterColumn }

procedure TFilterColumn.AddItem(Value: String);
begin
  if FItemList.IndexOf(Value)=-1 then
     FItemList.Add(Value)
  else FItemList.Delete(FItemList.IndexOf(Value));
end;

procedure TFilterColumn.ClearItem;
begin
  FItemList.Clear;
end;

constructor TFilterColumn.Create(Collection: TCollection);
begin
  inherited;
  fItemList:=TStringList.Create;
end;

destructor TFilterColumn.Destroy;
begin
  FitemList.Free;
  inherited;
end;

function TFilterColumn.FindItem(Value: String): boolean;
begin
  Result:=(FItemList.IndexOf(Value)<>-1)
end;

function TFilterColumn.GetInfilter: string;
Var FilterStr:String;
    i:integer;
begin
  FitemList.QuoteChar:='''';
  case Field.DataType of
    ftString,ftWideString,ftUnknown:
    begin
      if fItemList.Count>0 then
      begin
        FilterStr:='';
        for i := 0 to fItemList.Count - 1 do
           FilterStr:=FilterStr+','''+fItemList[i]+'''';
        FilterStr:=RightStr(FilterStr,Length(FilterStr)-1);
        Result:=' ('+Field.FieldName+' in ('+FilterStr+')) '
      end
      else Result:='';
    end;
    ftDateTime,ftDate:
    begin
      for i := 0 to fItemList.Count - 1 do
         if fItemList[i][1]<>'#' then fItemList[i]:=DateAsSQL(fItemList[i]);
      if fItemList.Count>0 then
        Result:=' ('+Field.FieldName+' in ('+FitemList.CommaText+')) '
      else Result:='';
    end;
    ftAutoInc,ftLargeint,ftFloat,ftWord,ftCurrency,ftSmallint,ftInteger, ftBCD:
    begin
      if fItemList.Count>0 then
        Result:=' ('+Field.FieldName+' in ('+FitemList.CommaText+')) '
      else Result:='';
    end;
  end;
end;

procedure TFilterColumn.SetFilterValue(const Value: String);
begin
  FFilterValue := Value;
end;

procedure TFilterColumn.SetSortType(const Value: TSortType);
begin
  FSortType := Value;
end;

procedure TFilterColumn.SetSubHeader(const Value: String);
begin
  FSubHeader := Value;
end;

{ TCellStyle }

procedure TCellStyle.Assign(Source: TPersistent);
begin
  //

end;

constructor TCellStyle.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFont:=TFont.Create;
  FColor:=clWhite;
  FSingleCell:=false;
  FImageIndex:=-1;
  FImageOnly:=false;
end;

destructor TCellStyle.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TCellStyle.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
end;

procedure TCellStyle.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TCellStyle.SetFieldName(const Value: String);
begin
  FFieldName := Value;
end;

procedure TCellStyle.SetFieldValue(const Value: string);
begin
  FFieldValue := Value;
end;

procedure TCellStyle.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TCellStyle.SetImageIndex(const Value: integer);
begin
  FImageIndex := Value;
end;

procedure TCellStyle.SetImageOnly(const Value: boolean);
begin
  FImageOnly := Value;
end;

procedure TCellStyle.SetOperand(const Value: String);
begin
  FOperand := Value;
end;

procedure TCellStyle.SetSingleCell(const Value: boolean);
begin
  FSingleCell := Value;
end;

{ TCellStyles }

function TCellStyles.Add: TCellStyle;
begin
  Result:=TCellStyle(inherited Add);
end;

function TCellStyles.GetCellStyle(Index: Integer): TCellStyle;
begin
  Result := TCellStyle(inherited Items[Index]);
end;

procedure TCellStyles.LoadFromFile(const Filename: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(Filename, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

type
  TCellStyleWrapper = class(TComponent)
  private
    FCellStyles: TCellStyles;
  published
    property CellStyles: TCellStyles read FCellStyles write FCellStyles;
  end;

procedure TCellStyles.LoadFromStream(S: TStream);
var
  Wrapper: TCellStyleWrapper;
begin
  Wrapper := TCellStyleWrapper.Create(nil);
  try
    S.ReadComponent(Wrapper);
    Assign(Wrapper.CellStyles);
  finally
    Wrapper.CellStyles.Free;
    Wrapper.Free;
  end;
end;

procedure TCellStyles.SaveToFile(const Filename: string);
var
  S: TStream;
begin
  S := TFileStream.Create(Filename, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TCellStyles.SaveToStream(S: TStream);
var
  Wrapper: TCellStyleWrapper;
begin
  Wrapper := TCellStyleWrapper.Create(nil);
  try
    Wrapper.CellStyles := Self;
    S.WriteComponent(Wrapper);
  finally
    Wrapper.Free;
  end;
end;

procedure TCellStyles.SetCellStyle(Index: Integer; const Value: TCellStyle);
begin
  Items[Index].Assign(Value);
end;

end.
