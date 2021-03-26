unit addonseditunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, ExtCtrls, ToolWin,SynEditRegexSearch, SynEditSearch, SynEditMiscClasses,
  SynEditAutoComplete, SynEditKeyCmds,SynMemo, SynEdit, SynHighlighterVBScript,SynCompletionProposal, addons, dataunit,
  ImgList, Menus, ExtActns, StdActns, SynEditTypes, StdCtrls;

type
  TAddOnsEditor = class(TForm)
    ToolBar1: TToolBar;
    Panel1: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    ActionList1: TActionList;
    ImageList1: TImageList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    FileRun1: TFileRun;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
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
    StatusBar1: TStatusBar;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    Edit1: TEdit;
    ToolButton18: TToolButton;
    HotKey1: THotKey;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    procedure FormCreate(Sender: TObject);
    procedure UpdateTreeView;
    procedure TreeView1Click(Sender: TObject);
    procedure setNodeImage(node: TTreeNode; imageIndex: integer);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure TreeView1Edited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure TreeView1Editing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
  private
    { Private declarations }
    fSearchFromCaret: boolean;
    SeletedmenuItem:IXMLMenuitemType;
    SelectedToolItem:IXMLToolitemType;
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
  public
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    CodeMemo: TSynMemo;
    vbsHighlighter:TSynVBScriptSyn;
    { Public declarations }
  end;


implementation

uses dlgSearchText, dlgReplaceText, dlgConfirmReplace, XMLIntf;

var
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
  gsReplaceTextHistory: string;

resourcestring
  STextNotFound = 'Text not found';

{$R *.dfm}

procedure TAddOnsEditor.Action1Execute(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

procedure TAddOnsEditor.Action2Execute(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, FALSE);
end;

procedure TAddOnsEditor.Action3Execute(Sender: TObject);
begin
   ShowSearchReplaceDialog(TRUE);
end;

procedure TAddOnsEditor.Action4Execute(Sender: TObject);
var menuitem: IXMLMenuitemType;
    tnode:TTreeNode;
begin
  if TreeView1.Selected.Text='Меню' then
  begin
    menuitem:=IXMLMenuType(TreeView1.Selected.Data).Add;
    menuitem.Name:='New menu item';
    menuitem.ShortCut:=0;
    tnode:=TreeView1.Items.AddChildObject(TreeView1.Selected,'New menu item',Pointer(menuitem));
    setNodeImage(tnode,4);
    TreeView1.Select(tnode,[]);
    Edit1.Text := 'New menu item';
  end;
end;

procedure TAddOnsEditor.Action5Execute(Sender: TObject);
begin
  Addons_.OwnerDocument.SaveToFile('addons.xml');
end;

procedure TAddOnsEditor.Action6Execute(Sender: TObject);
var inode:IXMLNode;
    parentnode:IXMLNode;
begin
  if Assigned(TreeView1.Selected) then
  begin
    if (TreeView1.Selected.Text <> 'Дополнения') and
     (TreeView1.Selected.Text <> 'Кнопки') and
     (TreeView1.Selected.Text <> 'Кнопки')

      then
      begin
        if MessageDlg('Вы хотите удалить узел: '+#10#13+TreeView1.Selected.Text, mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          inode:=IXMLNode(TreeView1.Selected.Data);
          ParentNode:=inode.ParentNode;
          ParentNode.DOMNode.removeChild(inode.DOMNode);
          Addons_.Resync;
          updatetreeview;
          //TreeView1.Selected.Delete;
        end;
      end;
  end;
end;

procedure TAddOnsEditor.Action7Execute(Sender: TObject);
begin
  if TreeView1.Selected.Parent.Text='Меню' then
  begin
    IXMLMenuitemType(TreeView1.Selected.Data).Text := CodeMemo.Text;
    IXMLMenuitemType(TreeView1.Selected.Data).Name := Edit1.Text;
    IXMLMenuitemType(TreeView1.Selected.Data).ShortCut := HotKey1.HotKey;
  end;
end;

procedure TAddOnsEditor.DoSearchReplaceText(AReplace, ABackwards: boolean);
var
  Options: TSynSearchOptions;
begin
  //Statusbar.SimpleText := '';
  if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else
    Options := [];
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    CodeMemo.SearchEngine := SynEditRegexSearch
  else
    CodeMemo.SearchEngine := SynEditSearch;
  if CodeMemo.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);
    //Statusbar.SimpleText := STextNotFound;
    if ssoBackwards in Options then
      CodeMemo.BlockEnd := CodeMemo.BlockBegin
    else
      CodeMemo.BlockBegin := CodeMemo.BlockEnd;
    CodeMemo.CaretXY := CodeMemo.BlockBegin;
  end;

  if ConfirmReplaceDialog <> nil then
    ConfirmReplaceDialog.Free;
end;

procedure TAddOnsEditor.Edit1Change(Sender: TObject);
begin
  if TreeView1.Selected = nil then Exit;
  if (TreeView1.Selected.Text<>'Дополнения') and (TreeView1.Selected.Text<>'Кнопки') and (TreeView1.Selected.Text<>'Меню') then
  begin
    TreeView1.Selected.Text:=TEdit(sender).Text;
  end;
end;

procedure TAddOnsEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CodeMemo:=TSynMemo.Create(Application);
  CodeMemo.Parent:=TForm(sender);
  CodeMemo.Tag:=-1;
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  CodeMemo.Font.Size:=10;
  vbsHighlighter:=TSynVBScriptSyn.Create(Application);
  //vbsHighlighter.KeyAttri.Foreground:=clNavy;
  vbsHighlighter.StringAttri.Foreground:=clMaroon;
  vbsHighlighter.IdentifierAttri.Foreground:=clNavy;
  vbsHighlighter.CommentAttribute.Foreground:=clGreen;
  vbsHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo.Highlighter:=vbsHighlighter;
  UpdateTreeView;
  SeletedmenuItem:=nil;
  SelectedToolItem:=nil;
  SynEditSearch:= TSynEditSearch.Create(Application);
  SynEditRegexSearch:= TSynEditRegexSearch.Create(Application);
end;

procedure TAddOnsEditor.setNodeImage(node: TTreeNode; imageIndex: integer);
begin
  node.ImageIndex:=imageIndex;
  node.SelectedIndex:=imageIndex;
end;

procedure TAddOnsEditor.ShowSearchReplaceDialog(AReplace: boolean);
var
  dlg: TTextSearchDialog;
begin
  if AReplace then
    dlg := TTextReplaceDialog.Create(Self)
  else
    dlg := TTextSearchDialog.Create(Self);
  with dlg do try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if CodeMemo.SelAvail and (CodeMemo.BlockBegin.Line = CodeMemo.BlockEnd.Line)
      then
        SearchText := CodeMemo.SelText
      else
        SearchText := CodeMemo.GetWordAtRowCol(CodeMemo.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end;
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end;
      fSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchReplaceText(AReplace, gbSearchBackwards);
        fSearchFromCaret := TRUE;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TAddOnsEditor.TreeView1Click(Sender: TObject);
begin
  if TreeView1.Selected.Parent = nil then Exit;
  if TreeView1.Selected.Parent.Text='Меню' then
  begin
    if SeletedmenuItem<>nil then
    begin
      SeletedmenuItem.Text:= CodeMemo.Text;
      SeletedmenuItem.Name:=Edit1.Text;
      SeletedmenuItem.ShortCut:=HotKey1.HotKey;
    end;
    if SelectedToolItem<>nil then
    begin
      SelectedToolItem.Code:=CodeMemo.Text;
      SelectedToolItem.Name:=Edit1.Text;
    end;
    CodeMemo.Text := IXMLMenuitemType(TreeView1.Selected.Data).Text;
    Edit1.Text :=  IXMLMenuitemType(TreeView1.Selected.Data).Name;
    HotKey1.HotKey := IXMLMenuitemType(TreeView1.Selected.Data).ShortCut;
    SelectedToolItem:=nil;
    SeletedmenuItem:=IXMLMenuitemType(TreeView1.Selected.Data);
  end;
  if TreeView1.Selected.Parent.Text='Кнопки' then
  begin
    if SelectedToolItem<>nil then
    begin
      SelectedToolItem.Code:=CodeMemo.Text;
      SelectedToolItem.Name:=Edit1.Text;
    end;
    if SeletedmenuItem<>nil then
    begin
      SeletedmenuItem.Text:= CodeMemo.Text;
      SeletedmenuItem.Name:=Edit1.Text;
      SeletedmenuItem.ShortCut:=HotKey1.HotKey;
    end;
    CodeMemo.Text := IXMLToolitemType(TreeView1.Selected.Data).Code;
    Edit1.Text := IXMLToolitemType(TreeView1.Selected.Data).Name;
    HotKey1.HotKey := 0;
    SelectedToolItem:=IXMLToolitemType(TreeView1.Selected.Data);
    SeletedmenuItem:=nil;
  end;
end;

procedure TAddOnsEditor.TreeView1Edited(Sender: TObject; Node: TTreeNode;
  var S: string);
begin
  if (Node.Text<>'Дополнения') and (Node.Text<>'Кнопки') and (Node.Text<>'Меню') then
  begin
    if Node.Parent.Text='Кнопки' then
    begin
      IXMLToolitemType(Node.Data).Name := S;
    end;
    if Node.Parent.Text='Меню' then
    begin
      IXMLMenuitemType(Node.Data).Name := S;
    end;
  end;

end;

procedure TAddOnsEditor.TreeView1Editing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  if (Node.Text<>'Дополнения') and (Node.Text<>'Кнопки') and (Node.Text<>'Меню') then
    AllowEdit:=true
  else
    AllowEdit:=false;
end;

procedure TAddOnsEditor.UpdateTreeView;
var topnode,
    toolnode,
    menunode,
    tnode1:TTreeNode;
    i:integer;
begin
  TreeView1.Items.Clear;
  topnode:=TreeView1.Items.AddChildObjectFirst(nil,'Дополнения',Pointer(Addons_));
  setNodeImage(topnode,0);
  toolnode:=TreeView1.Items.AddChildObject(topnode, 'Кнопки', Pointer(Addons_.Toolbar));
  setNodeImage(toolnode,1);
  for i := 0 to Addons_.Toolbar.Count - 1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(toolnode,Addons_.Toolbar.Toolitem[i].Name, Pointer(Addons_.Toolbar.Toolitem[i]));
    setNodeImage(tnode1,2);
  end;
  menunode:=TreeView1.Items.AddChildObject(topnode, 'Меню', Pointer(Addons_.Menu));
  setNodeImage(menunode,3);
  for i := 0 to Addons_.Menu.Count - 1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(menunode,Addons_.Menu.Menuitem[i].Name, Pointer(Addons_.Menu.Menuitem[i]));
    setNodeImage(tnode1,4);
  end;
  TreeView1.FullExpand;
end;

end.
