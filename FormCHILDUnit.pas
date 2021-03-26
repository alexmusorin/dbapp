unit FormCHILDUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls,GsvObjectInspectorTypes,
  GsvObjectInspectorGrid, HANDLES, StrUtils, StdCtrls, Buttons, UnitInfo, ConfigApp,
  ActnList, GridFrame, DataUnit, FilterDBGrid_, DB, ADODB, ActiveX, ComObj, Chart,
  SynEditRegexSearch, SynEditSearch, SynEditMiscClasses, SynUnicode, SynMemo, CheckLst,
  SynEdit, SynHighlighterDFM,SynCompletionProposal, SynEditAutoComplete, SynEditKeyCmds, Series;

type
  TFormDialog = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Splitter2: TSplitter;
    PanelLeft: TPanel;
    TreeView1: TTreeView;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ScrollBox1: TScrollBox;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    Action15: TAction;
    N34: TMenuItem;
    ToolButton22: TToolButton;
    ////////////////////////
    procedure OnEnumProperties(Sender: TObject; Index: Integer;
              out Info: PGsvObjectInspectorPropertyInfo);
    procedure OnGetStringValue(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo; out Value: String);
    procedure OnSetStringValue(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo; const Value: String);
    procedure OnGetIntegerValue(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo; out Value: LongInt);
    procedure OnSetIntegerValue(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo; const Value: LongInt);
    procedure OnFillList(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo; List: TStrings);
    procedure OnShowDialog(Inspector: TComponent;
              Info: PGsvObjectInspectorPropertyInfo; const EditRect: TRect);
    procedure OnHelp(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo);
    procedure OnHint(Sender: TObject;
              Info: PGsvObjectInspectorPropertyInfo);

    ////////////////////////
    procedure ObjMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ObjMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HANDLESMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure DialogFormClick(Sender: TObject);
    procedure DialogFormClose(Sender: TObject; var Action: TCloseAction);
    procedure InspectObject(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure ScrollBox1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure PopUpMenu(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
  private
    { Private declarations }
    FDialogForm: TForm;
    FFormName: string;
    FDialogFormName, FDialogFormCaption:String;
    FCounter:integer;
    HANDLES: TStretchHandle;
    ObjectManager:   TGsvObjectInspectorObjectInfo;
    ObjectInspector: TGsvObjectInspectorGrid;
    FFormCodeDFM: IXMLFormType;
    function getComponentClass: String;
    procedure StatusMessage(const S: String);
    procedure SetFormCodeDFM(const Value: IXMLFormType);
  public
    CodeMemo:TSynMemo;
    dfmHighlighter:TSynDFMSyn;
    { Public declarations }
    property FormCodeDFM:IXMLFormType read FFormCodeDFM write SetFormCodeDFM;
    property ComponentClass:String read getComponentClass;
    procedure InsertControl(AName, AClassName: WideString;
                            ParentControl: TWinControl; Position:TPoint);
    procedure LoadFormFromString(FormName,FormCode:string);
    procedure UpdateTreeView;
    function getFormSource:string;
    function FindInTreeView(Value:string):boolean;
  end;

type
      TDesignerHook = class(TInterfacedObject, IDesignerNotify, IDesignerHook)
      private
        FRoot: TComponent;
      public
        { IDesignerNotify }
        procedure Modified;
        procedure Notification(AnObject: TPersistent; Operation: TOperation);
      public
        { IDesignerHook }
        function GetCustomForm: TCustomForm;
        procedure SetCustomForm(Value: TCustomForm);
        function GetIsControl: Boolean;
        procedure SetIsControl(Value: Boolean);
        function IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
        procedure PaintGrid;
        procedure PaintMenu;
        procedure ValidateRename(AComponent: TComponent;
          const CurName, NewName: string);
        function UniqueName(const BaseName: string): string;
        function GetRoot: TComponent;
        property IsControl: Boolean read GetIsControl write SetIsControl;
        property Form: TCustomForm read GetCustomForm write SetCustomForm;
      end;

implementation

function addSpace(Value:String;SpaceCount:integer):string;
var i:integer;
    Str:String;
begin
   str:=Value;
   for i := 0 to SpaceCount do
      Str:=' '+Str;
   Result:=str;
end;

function ComponentToStringProc(Component: TComponent): string;
var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  BinStream := TMemoryStream.Create;
  try
    StrStream := TStringStream.Create(s);
    try
      BinStream.WriteComponent(Component);
      BinStream.Seek(0, soFromBeginning);
      ObjectBinaryToText(BinStream, StrStream);
      StrStream.Seek(0, soFromBeginning);
      Result:= StrStream.DataString;
    finally
      StrStream.Free;
    end;
  finally
    BinStream.Free
  end;
end;

function StringToComponentProc(Value: string; Parent:TComponent): TComponent;
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
      Result:= BinStream.ReadComponent(Parent);
    finally
      BinStream.Free;
    end;
  finally
    StrStream.Free;
  end;
end;

procedure FillComponentList(const SourceComponent: TComponent;
  var ChildsList: TStrings);
var
  I,posobj: Integer;
  tmpstr:string;
begin
  {for I := 0 to SourceComponent.ComponentCount - 1 do
  begin
     tmpstr:=ComponentToStringProc(SourceComponent.Components[I]);
     posobj:=Pos('object',RightStr(tmpstr,Length(tmpstr)-6));
     if posobj<>0 then tmpstr:=LeftStr(tmpstr,posobj+5);
     ChildsList.Add(tmpstr);
     FillComponentList(SourceComponent.Components[I],ChildsList);
     if posobj<>0 then  ChildsList.Add('end');
  end;}
  if SourceComponent.ClassName<>'TTreeView' then //Убираем TTimer
    for I := SourceComponent.ComponentCount - 1 downto 0 do
    begin
       tmpstr:=ComponentToStringProc(SourceComponent.Components[I]);
       posobj:=Pos('object',RightStr(tmpstr,Length(tmpstr)-6));
       if posobj<>0 then tmpstr:=LeftStr(tmpstr,posobj+5);
       ChildsList.Add(tmpstr);
       FillComponentList(SourceComponent.Components[I],ChildsList);
       if posobj<>0 then  ChildsList.Add('end');
    end;
end;

procedure FillChildComponentsList(const SourceComponent: TComponent; var TreeView:TTreeView;
  var ChildsList: TTreeNode);
var
  I, II: Integer;
  tnode:TTreeNode;
begin
  //рекурсивный поиск дочерних компонентов
  if SourceComponent.ClassName<>'TTreeView' then
  
  for I := 0 to SourceComponent.ComponentCount - 1 do
  begin
    tnode:=TreeView.Items.AddChildObject(ChildsList,SourceComponent.Components[I].Name+': '+SourceComponent.Components[I].ClassName,Pointer(SourceComponent.Components[I]));
    II:=19;
    if SourceComponent.Components[I].ClassName='TLabel' then II:=11;
    if SourceComponent.Components[I].ClassName='TEdit' then II:=5;
    if SourceComponent.Components[I].ClassName='TButton' then II:=2;
    if SourceComponent.Components[I].ClassName='TComboBox' then II:=4;
    if SourceComponent.Components[I].ClassName='TMemo' then  II:=18;
    if SourceComponent.Components[I].ClassName='TGroupBox' then II:=9;
    if SourceComponent.Components[I].ClassName='TCheckBox' then II:=3;
    if SourceComponent.Components[I].ClassName='TRadioButton' then II:=20;
    if SourceComponent.Components[I].ClassName='TPageControl' then II:=22;
    if SourceComponent.Components[I].ClassName='TTabSheet' then II:=19;
    if SourceComponent.Components[I].ClassName='TPanel' then II:=19;
    if SourceComponent.Components[I].ClassName='TDateTimePicker' then II:=12;
    if SourceComponent.Components[I].ClassName='TBitBtn' then II:=16;
    if SourceComponent.Components[I].ClassName='TImage' then II:=29;
    if SourceComponent.Components[I].ClassName='TProgressBar' then II:=30;
    if SourceComponent.Components[I].ClassName='TMonthCalendar' then II:=31;
    if SourceComponent.Components[I].ClassName='TListBox' then II:=32;
    if SourceComponent.Components[I].ClassName='TCheckListBox' then II:=33;
    if SourceComponent.Components[I].ClassName='TChart' then II:=34;
    if SourceComponent.Components[I].ClassName='TSplitter' then II:=35;
    if SourceComponent.Components[I].ClassName='TToolBar' then II:=36;
    if SourceComponent.Components[I].ClassName='TToolButton' then II:=16;
    if SourceComponent.Components[I].ClassName='TTreeView' then II:=37;
    tnode.ImageIndex:=II;
    tnode.SelectedIndex:=II;
    FillChildComponentsList(SourceComponent.Components[I], TreeView, tnode);
  end;  
end;

{$R *.dfm}

procedure TFormDialog.Action10Execute(Sender: TObject);
var obj:TControl;
begin
  if HANDLES.ChildCount>0 then
  begin
     Obj:=HANDLES.Children[0];
     HANDLES.Detach;
     TControl(Obj).SendToBack;
     HANDLES.Attach(Obj);
  end;
end;

procedure TFormDialog.Action11Execute(Sender: TObject);
Var TS:TTabSheet;
    NameCounter:integer;
begin
  if HANDLES.ChildCount>0 then
  if HANDLES.Children[0].ClassName='TPageControl' then
  begin
    TS:=TTabSheet.Create(TPageControl(HANDLES.Children[0]));
    TS.PageControl:=TPageControl(HANDLES.Children[0]);
    TS.Parent:=TPageControl(HANDLES.Children[0]);
    NameCounter:=1;
    while FindInTreeView('TabSheet'+IntToStr(NameCounter)+': TTabSheet') do Inc(NameCounter);
    TS.Name:='TabSheet'+IntToStr(NameCounter);
    TS.Caption:='Вкладка';
    TS.OnMouseDown:=ObjMouseDown;
    TS.OnMouseUp:=ObjMouseUp;
  end;
  UpdateTreeView;
end;

procedure TFormDialog.Action12Execute(Sender: TObject);
var Component:TControl;
begin
  if (HANDLES.ChildCount=1)
  and (MessageDlg('Удалить компонент '+HANDLES.Children[0].Name+'?',mtConfirmation,[mbYes,mbNo],0)=mrYes)
  then
  begin
    Component:=HANDLES.Children[0];
    HANDLES.Detach;
    Component.Free;
  end;
end;

procedure TFormDialog.Action13Execute(Sender: TObject);
begin
  //
end;

procedure TFormDialog.Action15Execute(Sender: TObject);
var TBTN:TToolButton;
    NameCounter:integer;
begin
  if HANDLES.ChildCount>0 then
  if HANDLES.Children[0].ClassName='TToolBar' then
  begin
    TBTN:=TToolButton.Create(TToolBar(HANDLES.Children[0]));
    TBTN.Parent:=TToolBar(HANDLES.Children[0]);
    NameCounter:=1;
    while FindInTreeView('ToolButton'+IntToStr(NameCounter)+': TToolButton') do Inc(NameCounter);
    TBTN.Name:='ToolButton'+IntToStr(NameCounter);
    TBTN.Caption:='Кнопка';
    TBTN.OnMouseDown:=ObjMouseDown;
    TBTN.OnMouseUp:=ObjMouseUp;
  end;
  UpdateTreeView;
end;

procedure TFormDialog.Action1Execute(Sender: TObject);
var i:integer;
    mintop:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
    mintop:=  HANDLES.Children[0].Top+HANDLES.Children[0].Height;
    for i := 0 to HANDLES.ChildCount - 1 do
      if mintop<HANDLES.Children[i].Top+HANDLES.Children[i].Height then
         mintop:=  HANDLES.Children[i].Top+HANDLES.Children[i].Height;
    for i := 0 to HANDLES.ChildCount - 1 do
      HANDLES.Children[i].Top:=mintop-HANDLES.Children[i].Height;
  end;
end;

procedure TFormDialog.Action2Execute(Sender: TObject);
var i:integer;
    mintop:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
    mintop:=  HANDLES.Children[0].Top;
    for i := 0 to HANDLES.ChildCount - 1 do
      if mintop>HANDLES.Children[i].Top then
         mintop:=  HANDLES.Children[i].Top;
    for i := 0 to HANDLES.ChildCount - 1 do
      HANDLES.Children[i].Top:=mintop;
  end;
end;

procedure TFormDialog.Action3Execute(Sender: TObject);
var i:integer;
    minleft:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
  minleft:=HANDLES.Children[0].Left;
  for i := 0 to HANDLES.ChildCount - 1 do
    if minleft>HANDLES.Children[i].Left then minleft:=HANDLES.Children[i].Left;

  for i := 0 to HANDLES.ChildCount - 1 do
    begin
      HANDLES.Children[i].Left:=minleft;
    end;
  end;
end;

procedure TFormDialog.Action4Execute(Sender: TObject);
var i:integer;
    maxright:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
    maxright:=HANDLES.Children[0].Left+HANDLES.Children[0].Width;
    for i := 0 to HANDLES.ChildCount - 1 do
      if maxright<HANDLES.Children[i].Left+HANDLES.Children[i].Width then
          maxright:=HANDLES.Children[i].Left+HANDLES.Children[i].Width;
    for i := 0 to HANDLES.ChildCount - 1 do
      HANDLES.Children[i].Left:=maxright-HANDLES.Children[i].Width;
  end;
end;

procedure TFormDialog.Action5Execute(Sender: TObject);
var i:integer;
    space:integer;
begin
  if HANDLES.ChildCount>2 then
  begin
    space:=HANDLES.Children[1].Top-HANDLES.Children[0].Top;
    for i := 1 to HANDLES.ChildCount - 2 do
       HANDLES.Children[i+1].Top:= HANDLES.Children[i].Top+space;
  end;
end;

procedure TFormDialog.Action6Execute(Sender: TObject);
begin
//
end;

procedure TFormDialog.Action7Execute(Sender: TObject);
var i:integer;
    val:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
    val:= HANDLES.Children[0].Width;
    for i := 0 to HANDLES.ChildCount - 1 do
      HANDLES.Children[i].Width:=val;
  end;
end;

procedure TFormDialog.Action8Execute(Sender: TObject);
var i:integer;
    val:integer;
begin
  if HANDLES.ChildCount>0 then
  begin
    val:= HANDLES.Children[0].Height;
    for i := 0 to HANDLES.ChildCount - 1 do
      HANDLES.Children[i].Height:=val;
  end;
end;

procedure TFormDialog.Action9Execute(Sender: TObject);
var obj:TControl;
begin
  if HANDLES.ChildCount>0 then
  begin
     Obj:=HANDLES.Children[0];
     HANDLES.Detach;
     TControl(Obj).BringToFront;
     HANDLES.Attach(Obj);
  end;
end;

procedure TFormDialog.DialogFormClick(Sender: TObject);
var cur: TPoint;
begin
  cur := TControl(Sender).ScreenToClient(Mouse.CursorPos);
  //ShowMessage(ComponentClass);
  if ComponentClass<>'' then
  begin
    InsertControl(RightStr(ComponentClass,length(ComponentClass)-1){+IntToStr(FCounter)},
                ComponentClass,FDialogForm,cur);
    Inc(FCounter);
    ToolButton1.Down:=true;
  end else HANDLES.Detach;

end;

procedure TFormDialog.DialogFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caNone;
end;

function TFormDialog.FindInTreeView(Value: string): boolean;
var i:integer;
begin
  Result:=false;
  for i := 0 to TreeView1.Items.Count - 1 do
    if AnsiUpperCase(Value)=AnsiUpperCase(LeftStr(TreeView1.Items[i].Text,Pos(':',TreeView1.Items[i].Text)-1)) then
      Result:=true;
end;

procedure TFormDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IXMLFormType(FFormCodeDFM).Text:=getFormSource;
  Action:=caFree;
end;

procedure TFormDialog.FormCreate(Sender: TObject);
begin
  inherited;
  FDialogForm:=TForm.Create(ScrollBox1);
  FDialogForm.Name:=FFormName;
  FDialogForm.Parent:=ScrollBox1;
  FDialogForm.OnClick:=DialogFormClick;
  FDialogForm.OnClose:=DialogFormClose;
  FDialogForm.Show;
  HANDLES:= TStretchHandle.Create(TForm(Sender));
  HANDLES.PopupMenu:=PopUpMenu1;
  PopUpMenu1.OnPopup:=PopUpMenu;
  HANDLES.OnMouseDown:=HANDLESMouseDown;
  ObjectManager                     := TGsvObjectInspectorObjectInfo.Create;
  ObjectInspector                   := TGsvObjectInspectorGrid.Create(Self);
  ObjectInspector.Parent            := PanelLeft;
  ObjectInspector.Align             := alClient;
  ObjectInspector.Visible           := True;
  ObjectInspector.RowHeight         := 18;
  ObjectInspector.DividerPosition   := 150;
  ObjectInspector.Font.Size         := 8;
  ObjectInspector.TabStop           := True;
  ObjectInspector.FolderFontColor   := clMaroon;
  ObjectInspector.FolderFontStyle   := [fsBold];
  ObjectInspector.DropDownCount     := 5;
  ObjectInspector.LongTextHintTime  := 3000;
  ObjectInspector.LongEditHintTime  := 3000;
  ObjectInspector.OnEnumProperties  := OnEnumProperties;
  ObjectInspector.OnGetStringValue  := OnGetStringValue;
  ObjectInspector.OnSetStringValue  := OnSetStringValue;
  ObjectInspector.OnGetIntegerValue := OnGetIntegerValue;
  ObjectInspector.OnSetIntegerValue := OnSetIntegerValue;
  ObjectInspector.OnFillList        := OnFillList;
  ObjectInspector.OnShowDialog      := OnShowDialog;
  ObjectInspector.OnHelp            := OnHelp;
  ObjectInspector.OnHint            := OnHint;
  FCounter:=1;
  //UpdateTreeView;
  {if Designer <> nil then Exit;
  Designer := TDesignerHook.Create;
  Designer.Form := FDialogForm;
  SetDesigning(True); }
  CodeMemo:=TSynMemo.Create(Application);
  CodeMemo.Parent:=TabSheet2;
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  CodeMemo.Font.Size:=10;
  dfmHighlighter:=TSynDFMSyn.Create(Application);
  //vbsHighlighter.KeyAttri.Foreground:=clNavy;
  dfmHighlighter.StringAttri.Foreground:=clMaroon;
  dfmHighlighter.IdentifierAttri.Foreground:=clNavy;
  dfmHighlighter.CommentAttribute.Foreground:=clGreen;
  dfmHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo.Highlighter:=dfmHighlighter;
end;

procedure TFormDialog.FormShow(Sender: TObject);
begin
  {if Designer <> nil then Exit;
  Designer := TDesignerHook.Create;
  Designer.Form := FDialogForm;
  SetDesigning(True); }
end;

function TFormDialog.getComponentClass: String;
begin
  Result:='';
  if ToolButton1.Down then Result:='';
  if ToolButton2.Down then Result:='TButton';
  if ToolButton3.Down then Result:='TEdit';
  if ToolButton4.Down then Result:='TLabel';
  if ToolButton5.Down then Result:='TMemo';
  if ToolButton6.Down then Result:='TPanel';
  if ToolButton7.Down then Result:='TComboBox';
  if ToolButton8.Down then Result:='TGroupBox';
  if ToolButton9.Down then Result:='TCheckBox';
  if ToolButton10.Down then Result:='TRadioButton';
  if ToolButton11.Down then Result:='TPageControl';
  if ToolButton12.Down then Result:='TDateTimePicker';
  if ToolButton13.Down then Result:='TBitBtn';
  if ToolButton14.Down then Result:='TImage';
  if ToolButton15.Down then Result:='TProgressBar';
  if ToolButton16.Down then Result:='TMonthCalendar';
  if ToolButton17.Down then Result:='TListBox';
  if ToolButton18.Down then Result:='TCheckListBox';
  if ToolButton19.Down then Result:='TChart';
  if ToolButton20.Down then Result:='TSplitter';
  if ToolButton21.Down then Result:='TToolBar';
  if ToolButton22.Down then Result:='TTreeView';
end;

function TFormDialog.getFormSource: string;
var BufStr:TStringList;
    str:TStrings;
    i,level:integer;
begin
  level:=0;
  BufStr:=TStringList.Create;
  BufStr.Add('object '+FDialogForm.Name+': TForm');
  BufStr.Add('  Width = '+IntToStr(FDialogForm.Width));
  BufStr.Add('  Height = '+IntToStr(FDialogForm.Height));
  BufStr.Add('  Caption = '''+FDialogForm.Caption+'''');
  Str:=BufStr;
  FillComponentList(FDialogForm,Str);
  BufStr.Text := StringReplace(BufStr.Text, #13#10'  '#13#10, #13#10, [rfReplaceAll]);
  BufStr.Text := StringReplace(BufStr.Text, #13#10#13#10, #13#10, [rfReplaceAll]);
  for i := 0 to BufStr.Count - 1 do
    begin
      if LeftStr(BufStr[i],6)='object' then level:=level+1;
      if LeftStr(BufStr[i],3)='end' then level:=level-1;
      BufStr[i]:=AddSpace(BufStr[i],level*2);
    end;
  BufStr.Add('end');
  Result:=BufStr.Text;
end;

procedure TFormDialog.HANDLESMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (HANDLES.ChildCount=1) then
  begin
    if HANDLES.Children[0] is TPanel then
    begin
       objMouseDown(TPanel(HANDLES.Children[0]),Button,Shift,X,Y);
       if  not ToolButton1.Down then
         ToolButton1.Down:=true;
    end;
  end;
end;

procedure TFormDialog.InsertControl(AName, AClassName: WideString;
  ParentControl: TWinControl; Position: TPoint);
var ThisClass: TControlClass;
    NewComponent: TComponent;
    TS:TTabSheet;
    NewName:string;
    NameCounter:integer;
begin
   if AClassName='TTimer' then Exit;
   
   ThisClass := TControlClass(GetClass(AClassName));
   NewName:=FDialogForm.Name+'_'+AName;
   NameCounter:=1;
   while FindInTreeView(NewName+IntToStr(NameCounter){+': '+AClassNAme}) do Inc(NameCounter);
   NewName:=NewName+IntToStr(NameCounter);
   if AClassName='TLabel' then
     begin
       NewComponent:=TLabel.Create(ParentControl);
       TLabel(NewComponent).Caption:=NewName;
       TLabel(NewComponent).Name:=NewName;
       TLabel(NewComponent).Top:=position.Y;
       TLabel(NewComponent).Left:=position.X;
       TLabel(NewComponent).Parent:=ParentControl;
       TLabel(NewComponent).OnMouseDown:=ObjMouseDown;
       TLabel(NewComponent).OnMouseUp:=ObjMouseUp;
       //TLabel(NewComponent).Hint:=NewName;
       //TLabel(NewComponent).ShowHint:=true;
       UpdateTreeView;
       Exit;
   end;
   if AClassName='TImage' then
     begin
       NewComponent:=TImage.Create(ParentControl);
       TImage(NewComponent).Name:=NewName;
       TImage(NewComponent).Top:=position.Y;
       TImage(NewComponent).Left:=position.X;
       TImage(NewComponent).Parent:=ParentControl;
       TImage(NewComponent).OnMouseDown:=ObjMouseDown;
       TImage(NewComponent).OnMouseUp:=ObjMouseUp;
       //TImage(NewComponent).Hint:=NewName;
       //TImage(NewComponent).ShowHint:=true;
       UpdateTreeView;
       Exit;
   end;
   if ThisClass<>nil then
   begin
     NewComponent:=ThisClass.Create(ParentControl);
     NewComponent.Name:=NewName;
     if NewComponent is TWinControl then
     begin
        TWinControl(NewComponent).Parent:=ParentControl;
        TWinControl(NewComponent).Top:=position.Y;
        TWinControl(NewComponent).Left:=position.X;
        TPanel(NewComponent).OnMouseDown:=ObjMouseDown;
        TPanel(NewComponent).OnMouseUp:=ObjMouseUp;
        //TPanel(NewComponent).Hint:=NewName;
        //TPanel(NewComponent).ShowHint:=true;
        InspectObject(NewComponent);
     end;
   end;
 
   if AClassName='TPageControl' then
   begin
     TS:=TTabSheet.Create(NewComponent);
     TS.Parent:=TPageControl(NewComponent);
     TS.Name:={FDialogForm.Name+'_'+}'TabSheet'+IntToStr(FCounter);
     TS.PageControl:=TPageControl(NewComponent);
     TS.Caption:='Вкладка';
     //TS.Hint:=FDialogForm.Name+'_'+'TabSheet'+IntToStr(FCounter);
     //TS.ShowHint:=true;
     TS.OnMouseDown:=ObjMouseDown;
     TS.OnMouseUp:=ObjMouseUp;
     Inc(FCounter);
   end;
   UpdateTreeView;
end;

procedure TFormDialog.InspectObject(Sender: TObject);
begin
  ObjectInspector.Clear;
  ObjectManager.TheObject := Sender;
  if Assigned(ObjectManager.TheObject) then
     ObjectInspector.NewObject
  else
    ObjectInspector.Clear;
end;

procedure TFormDialog.LoadFormFromString(FormName, FormCode: string);
var i:integer;
    BufComp:TComponent;
    PComp:TComponent;
begin
   FDialogForm:=TForm(StringToComponentProc(FormCode,FDialogForm));
   FDialogForm.Name:=FormName;
   for i:=FDialogForm.ComponentCount - 1 downto 0 do
  begin
     TPanel(FDialogForm.Components[i]).OnMouseDown:=ObjMouseDown;
     TPanel(FDialogForm.Components[i]).OnMouseUp:=ObjMouseUp;
     //ShowMessage(FDialogForm.Components[i].Name);
     if FDialogForm.Components[i].GetParentComponent<>nil then
     
      if FDialogForm.Components[i].GetParentComponent.Name<>FormName then
      begin
         BufCOmp:=FDialogForm.Components[i];
         PComp:=FDialogForm.Components[i].GetParentComponent;
         FDialogForm.RemoveComponent(FDialogForm.Components[i]);
         PComp.InsertComponent(BufCOmp);
      end;
  end;
  UpdateTreeView;
end;

procedure TFormDialog.ObjMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var cur: TPoint;
begin
  if (ComponentClass<>'') and
     ((Sender is TPanel) or
     (Sender is TGroupBox) or
     (Sender is TTabSheet)) and (Button = mbLeft) then
   begin
     cur.X:=X;
     cur.Y:=Y;
     InsertControl(RightStr(ComponentClass,length(ComponentClass)-1){+IntToStr(FCounter)},
                ComponentClass,TWinControl(Sender),cur);
     //Inc(FCounter);
   end;
  
end;

procedure TFormDialog.ObjMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
  begin
  if not (ssShift in Shift) then
  begin
    HANDLES.Detach;
    InspectObject(Sender);
  end;
  if  not ToolButton1.Down then
    ToolButton1.Down:=true
    else HANDLES.Attach(TControl(sender));
  end;
end;

procedure TFormDialog.OnEnumProperties(Sender: TObject; Index: Integer;
  out Info: PGsvObjectInspectorPropertyInfo);
begin
  Info := ObjectManager.PropertyInfo(Index);
end;

procedure TFormDialog.OnFillList(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo; List: TStrings);
begin
  try
    ObjectManager.FillList(Info, List);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
end;

procedure TFormDialog.OnGetIntegerValue(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo; out Value: Integer);
begin
  try
    Value := ObjectManager.GetIntegerValue(Info);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
end;

procedure TFormDialog.OnGetStringValue(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo; out Value: String);
begin
  try
    Value := ObjectManager.GetStringValue(Info);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
end;

procedure TFormDialog.OnHelp(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo);
begin
   if Assigned(Info) then
    with Info^ do
      StatusMessage(Format('%s: индекс справки: %d', [Caption, Help]));
end;

procedure TFormDialog.OnHint(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo);
begin
    if Assigned(Info) then begin
    with Info^ do begin
      if Hint <> '' then
        StatusMessage(Format('%s: %s', [Caption, Hint]))
      else
        StatusMessage(Caption);
    end;
  end;
end;

procedure TFormDialog.OnSetIntegerValue(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo; const Value: Integer);
begin
   try
    ObjectManager.SetIntegerValue(Info, Value);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
end;

procedure TFormDialog.OnSetStringValue(Sender: TObject;
  Info: PGsvObjectInspectorPropertyInfo; const Value: String);
var Component:TControl;
    isHandles:boolean;
begin
  isHandles:=false;
  Component:=nil;
  if (HANDLES.ChildCount>0) and (Info^.Name<>'Caption') and (Info^.Name<>'Text')
  then
  begin
     Component:=HANDLES.Children[0];
     HANDLES.Detach;
     isHandles:=true;
  end;
  try
    ObjectManager.SetStringValue(Info, Value);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
  if isHandles then  HANDLES.Attach(Component);
end;

procedure TFormDialog.OnShowDialog(Inspector: TComponent;
  Info: PGsvObjectInspectorPropertyInfo; const EditRect: TRect);
begin
      try
    ObjectManager.ShowDialog(Inspector, Info, EditRect);
  except
    on E: Exception do
      StatusMessage('Error: ' + E.Message);
  end;
end;

procedure TFormDialog.PageControl1Change(Sender: TObject);
begin
  If PageControl1.ActivePage = TabSheet2 then
  begin
    CodeMemo.Lines.Text := getFormSource;
    FDialogFormName := FDialogForm.Name;
    FDialogFormCaption := FDialogForm.Caption;
  end;
  {If PageControl1.ActivePage = TabSheet1 then
  begin
    FDialogForm.Free;
    FDialogForm:=TForm.Create(ScrollBox1);
    FDialogForm.Name:=FDialogFormName;
    FDialogForm.Caption := FDialogFormCaption;
    FDialogForm.Parent:=ScrollBox1;
    FDialogForm.OnClick:=DialogFormClick;
    FDialogForm.OnClose:=DialogFormClose;
    FDialogForm.Show;
    LoadFormFromString(FDialogFormName,CodeMemo.Lines.Text);
    TreeView1.Items.Clear;
    UpdateTreeView;
  end; }
end;

procedure TFormDialog.PopUpMenu(Sender: TObject);
begin
  if HANDLES.Children[0] is TPageControl then N15.Visible:=true
  else  N15.Visible:=false;
  if HANDLES.Children[0] is TToolBar then N34.Visible:=true
  else  N34.Visible:=false;
end;

procedure TFormDialog.ScrollBox1Click(Sender: TObject);
begin
  HANDLES.Detach;
end;

procedure TFormDialog.SetFormCodeDFM(const Value: IXMLFormType);
begin
  FFormCodeDFM := Value;
end;

procedure TFormDialog.StatusMessage(const S: String);
begin
  //
end;

procedure TFormDialog.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(node.Data) then
  begin
    HANDLES.Detach;
    if (node.Text<>'Форма') then HANDLES.Attach(TControl(node.Data));
    ObjectInspector.Clear;
    InspectObject(TControl(node.Data));
  end;
end;

procedure TFormDialog.UpdateTreeView;
var inode:TTreeNode;
begin
  TreeView1.Items.Clear;
  TreeView1.Items.AddChildObject(nil,'Форма',Pointer(FDialogForm));
  inode:=TreeView1.Items[0];
  inode.ImageIndex:=6;
  inode.SelectedIndex:=6;
  FillChildComponentsList(FDialogForm,TreeView1,inode);
  TreeView1.FullExpand;
  TreeView1.Items[0].MakeVisible; 
end;

{ TDesignerHook }

function TDesignerHook.GetCustomForm: TCustomForm;
begin
  if FRoot is TCustomForm then
        Result := TCustomForm(FRoot)
      else
        Result := nil;
end;

type
  TControlCrack = class(TControl);

function TDesignerHook.GetIsControl: Boolean;
begin
  if FRoot is TControl then
        Result := TControlCrack(FRoot).IsControl
      else
        result := False;
end;

function TDesignerHook.GetRoot: TComponent;
begin
  Result := FRoot;
end;

function TDesignerHook.IsDesignMsg(Sender: TControl;
  var Message: TMessage): Boolean;
begin
  if Sender is TBitBtn then Result:=true else Result:=false;
  
end;

procedure TDesignerHook.Modified;
begin
 //
end;

procedure TDesignerHook.Notification(AnObject: TPersistent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AnObject = FRoot) then
        FRoot := nil;
end;

procedure TDesignerHook.PaintGrid;
begin
  //
end;

procedure TDesignerHook.PaintMenu;
begin
  //
end;

procedure TDesignerHook.SetCustomForm(Value: TCustomForm);
begin
  FRoot := Value;
end;

procedure TDesignerHook.SetIsControl(Value: Boolean);
begin
  if FRoot is TControl then
        TControlCrack(FRoot).IsControl := Value;
end;

function TDesignerHook.UniqueName(const BaseName: string): string;
    var
      guid: TGuid;
      s: string;
    begin
      OleCheck(CoCreateGuid(guid));
      s := GuidToString(guid);
      s := Copy(s, 2, Length(s) - 2); // Убираем скобки{}
      s := StringReplace(s, '-', '', []);
      Result := BaseName + s;
    end;

procedure TDesignerHook.ValidateRename(AComponent: TComponent; const CurName,
  NewName: string);
begin
  //
end;

initialization

RegisterClasses([TPanel, TMemo, TButton, TComboBox, TLabel, TToolBar, TToolButton,
                   TEdit, TGroupBox, TCheckBox, TRadioButton, TGrid_Frame, TChart, 
                   TPageControl, TTabSheet, TDateTimePicker, TBitBtn, TImage,
                   TProgressBar, TMonthCalendar, TListBox, TCheckListBox, TTimer,
                   TBarSeries, TPieSeries, TLineSeries, TAreaSeries, TForm, TSplitter,
                   TPopupMenu, TMenuItem, TImageList, TTreeView, TTreeNode]);

end.
