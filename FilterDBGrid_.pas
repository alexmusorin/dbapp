unit FilterDBGrid_;


interface

uses Variants, Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
      Graphics, Grids, DBGrids,StrUtils,ClipBrd,DB,Dialogs, GraphUtil;

type TFilterEdit=class(TEdit)
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

TSetFilterEvent = procedure of object;

type TFilterDBGrid=class(TDBGrid)
     private
       
       FFilterEdit:TFilterEdit;
       FFilterCOl:integer;
       FSortColumn:integer;
       FOnTitleClick:TDBGridClickEvent;
       FFilterEvent:TSetFilterEvent;
       function CreateFilterEdit:TFilterEdit;
       procedure HideFilterEdit;
       procedure UpdateFilterEdit(Key:Char);
       function CheckFilters:boolean;
       procedure SetSortColumn(const Value: integer);
    function GetActiveRecord: Integer;
     protected
       procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
                           AState: TGridDrawState);override;
       procedure LayoutChanged; override;
       procedure KeyDown(var Key: Word; Shift: TShiftState); override;
       procedure KeyPress(var Key: Char); override;
       procedure TitleClick(Column: TColumn); dynamic;
       procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                          X, Y: Integer); override;

       function BeginColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean; override;
       function EndColumnDrag(var Origin, Destination: Integer; const MousePt: TPoint): Boolean;override;
     public
       Filters:TStringList;
       ImageList:TImageList;
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure SetFilter;
       property OnFilterEvent: TSetFilterEvent read FFilterEvent write FFilterEvent;
       property SortColumn:integer read FSortColumn write SetSortColumn;
       property ActiveRecord: Integer read GetActiveRecord;
     end;

implementation

uses Types;

{ TFilterEdit }

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
    TFilterDBGrid(Grid).Filters[TDBGrid(Grid).SelectedIndex]:=Text;
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
  Text:=TFilterDBGrid(Grid).Filters[TDBGrid(Grid).SelectedIndex]+Key;
end;

function TFilterEdit.Visible: boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TFilterEdit.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  TFilterDBGrid(Grid).Filters[TDBGrid(Grid).SelectedIndex]:=Text;
  Hide;
end;

{ TFilterDBGrid }

function TFilterDBGrid.BeginColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
begin
  if MousePt.y>2*DefaultRowHeight then
  Result:=false else result:=true;
  IF Result Then Result:= Inherited BeginColumnDrag(Origin,Destination,MousePt);
end;

function TFilterDBGrid.CheckFilters: boolean;
var i:integer;
begin
  Result:=false;
  for i:=0 to Filters.Count-1 do
  if Filters.Strings[i]<>'' then Result:=true;
end;



constructor TFilterDBGrid.Create(AOwner: TComponent);
var i:integer;
begin
  inherited;
  Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit];
  ReadOnly:=true;
  Filters:=TStringList.Create;
  for i:=0 to 100 do Filters.Add('');
  FSortColumn:=-1;

end;

function TFilterDBGrid.CreateFilterEdit: TFilterEdit;
begin
  Result:=TFilterEdit.Create(Self);
end;

destructor TFilterDBGrid.Destroy;
begin
  Filters.Free;
  FFilterEdit.Free;
  inherited;
end;

procedure TFilterDBGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var TitleText : String;
    DataCol:integer;
    MyRECT:TRect;
    FilterText:String;
    GrRect:TRect;

begin
  if (dgTitles in Options) and (gdFixed in AState) and (ARow = 0) and
     (ACol <> 0) then
     begin
       if csLoading in ComponentState then
       begin
         Canvas.Brush.Color := Color;
         Canvas.FillRect(ARect);
         Exit;
       end;
       DataCol := ACol;
       if dgIndicator in Options then
         Dec(DataCol);
       //if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
       // InflateRect(ARect, -1, -1);
       TitleText := Columns[DataCol].Title.Caption;
       FilterText:=Filters.Strings[DataCol];
       Canvas.Brush.Color := FixedColor;
       //Canvas.FillRect(ARect);
       GrRect:=Rect(ARect.Left,ARect.Top,ARect.Right,ARect.Bottom-DefaultRowHeight);
       GradientFillCanvas(Canvas,clWindow,$00EFD3C6,GRRect,gdVertical);
       Canvas.Font := Font;
       ///////////////////////////
       MyRECT:=Rect(ARect.Left+2,ARect.Top,ARect.Right+2,ARect.Bottom-DefaultRowHeight);
       Canvas.Font.Style:=[fsBold];
       SetBkMode(Canvas.Handle,TRANSPARENT);
       DrawText(Canvas.Handle, PAnsiChar(TitleText), Length(TitleText), MyRECT, DT_LEFT or DT_WORDBREAK or DT_WORD_ELLIPSIS or DT_NOCLIP);
       Canvas.Font.Style:=[];
       ////////////////////////////////////
       ///dasdada
       ///////////////////////////
       if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
       begin
         InflateRect(ARect, 1, 1);
         MyRECT:=Rect(ARect.Left+1,ARect.Top,ARect.Right,ARect.Bottom-DefaultRowHeight);
         DrawEdge(Canvas.Handle, MyRECT, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
         DrawEdge(Canvas.Handle, MyRECT, BDR_RAISEDINNER, BF_TOPLEFT);
         MyRECT:=Rect(ARect.Left,ARect.Top+DefaultRowHeight*2,ARect.Right,ARect.Bottom);
         //DrawEdge(Canvas.Handle, MyRECT, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
         //DrawEdge(Canvas.Handle, MyRECT, BDR_RAISEDINNER, BF_TOPLEFT);
         Canvas.Brush.Color:=clMoneyGreen;
         Canvas.FillRect(MyRect);
         //GradientFillCanvas(Canvas,clMoneyGreen,clWhite,MyRect,gdVertical);
         //Canvas.Pen.Color:=clLtGray;
         Canvas.Pen.Color:=clTeal;
         Canvas.Rectangle(MyRect);
         Canvas.Font.Color:=clBlack;
         ///////////////////////////////////////////////
         MyRECT:=Rect(ARect.Left+15,ARect.Top+2*DefaultRowHeight+2,ARect.Right+2,ARect.Bottom);
         DrawText(Canvas.Handle, PAnsiChar(FilterText), Length(FilterText), MyRECT, DT_SINGLELINE or DT_LEFT or DT_WORD_ELLIPSIS or DT_NOCLIP);
         if FilterText<>'' then ImageList.Draw(Canvas,MyRECT.Left-13,MyRECT.Top+1,0);
       end;
       if FSortColumn=DataCol then
           ImageList.Draw(Canvas,ARect.Right-19,DefaultRowHeight+5,1);
       if FSortColumn-500=DataCol then
           ImageList.Draw(Canvas,ARect.Right-19,DefaultRowHeight+5,2);
       
     end
     else
     begin
       if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
       [dgRowLines, dgColLines]) then
       begin
         InflateRect(ARect, 1, 1);
         //GradientFillCanvas(Canvas,clWindow,$00D6D6D6,GRRect,gdVertical);
       end;
       inherited;
       if (dgTitles in Options) and (gdFixed in AState) and (ARow = 0) and
       (ACol = 0) and CheckFilters then
       begin
         Canvas.Brush.Color:=clBlue;
         InflateRect(ARect, -2, -20);
         Canvas.FillRect(Arect);
         InflateRect(ARect, 2, 20);
         //ImageList.Draw(Canvas,0,35,0);
       end;
     end;
     Canvas.Brush.Color := FixedColor;

end;

function TFilterDBGrid.EndColumnDrag(var Origin, Destination: Integer;
  const MousePt: TPoint): Boolean;
var cnt:integer;
    Bstr1:String;
begin
  Result := inherited EndColumnDrag(Origin, Destination, MousePt);
  if Origin>Destination then
  begin
    if Origin>0 then BStr1:=Filters.Strings[Origin-1];
    for cnt:=Origin downto Destination do
    begin
       if cnt-2 > -1 then Filters.Strings[cnt-1]:=Filters.Strings[cnt-2];
    end;
    if Destination>0 then Filters.Strings[Destination-1]:=BStr1;
  end;
  if Origin<Destination then
  begin
    if Origin>0 then BStr1:=Filters.Strings[Origin-1];
    for cnt:=Origin+1 to Destination do
    begin
       if cnt-2 > -1 then Filters.Strings[cnt-2]:=Filters.Strings[cnt-1];
    end;
    if Destination>0 then Filters.Strings[Destination-1]:=BStr1;
  end;
end;

function TFilterDBGrid.GetActiveRecord: Integer;
begin
    Result:=DataLink.ActiveRecord;
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
begin
  inherited;
  if (Key=VK_UP) and (ssCtrl in Shift) then
  begin
    if FFilterEdit<>nil then FFilterEdit.NewKey:='';
    UpdateFilterEdit(#0);
  End;
  if (Key=VK_DELETE) then
  begin
    Filters.Strings[SelectedIndex]:='';
    if Assigned(FFilterEdit) then FFilterEdit.Text:='';
    Ind1:=SelectedIndex;
    SetFilter;
    SelectedIndex:=ind1;
    Repaint;
  end;
  if (Key=VK_INSERT) and (ssCtrl in Shift) then
  ClipBoard.AsText:=Columns[SelectedIndex].Field.AsString;
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
  RowHeights[0]:=DefaultRowHeight*3;
  //ColWidths[0]:=18;
end;



procedure TFilterDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
  var
  Cell: TGridCoord;
  NRect:TRect;
begin
  inherited;
  Cell := MouseCoord(X,Y);
  if (Y < 3*DefaultRowHeight) and (Y>2*DefaultRowHeight) and (Cell.x>0) then
  begin
    SelectedIndex:= Cell.x-1;
    NRect:=CellRect(Cell.X, Cell.Y);
    if FFilterEdit<>nil then FFilterEdit.NewKey:='';
    UpdateFilterEdit(#0);
    FFilterEdit.Move(Rect(nRect.Left,2*DefaultRowHeight+2,nRect.Right-1,3*DefaultRowHeight-1));
    FFilterEdit.Text:=Filters[Cell.x-1];
  end;
end;

procedure TFilterDBGrid.SetFilter;
begin
  if Assigned(OnFilterEvent) then FFilterEvent;
end;

procedure TFilterDBGrid.SetSortColumn(const Value: integer);
begin
  FSortColumn := Value;
  Repaint;
end;



procedure TFilterDBGrid.TitleClick(Column: TColumn);
begin
  if Assigned(FOnTitleClick) then FOnTitleClick(Column);
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
       // UpdateEditor(Key);
        //FFilterEdit.SelStart:=FFilterEdit.Perform(EM_SCROLLCARET,1,0)+100;
      end;
      UpdateEditor(Key);
        FFilterEdit.SelStart:=FFilterEdit.Perform(EM_SCROLLCARET,1,0)+100;
    end;
    NRect:=CellRect(Col, Row);
    FFilterEdit.Move(Rect(nRect.Left,2*DefaultRowHeight+2,nRect.Right-1,3*DefaultRowHeight-1));
end;





end.
