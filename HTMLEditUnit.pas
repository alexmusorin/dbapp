unit HTMLEditUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ConfigApp, SynMemo, SynEdit, SynHighlighterVBScript, SynHighlighterJScript,
  SynHighlighterHTML, SynHighlighterCSS, EncdDecd, SynEditRegexSearch, SynEditSearch, SynEditTypes,
  Menus, ActnList, ImgList, DataUnit, SynHighlighterMulti;

type
  THTMLEdit = class(TForm)
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    ImageList1: TImageList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N12: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure MenuClick(Sender: TObject);
  private
    { Private declarations }
    FHTMLObj: IXMLWEBPageType;
    CodeMemo:TSynMemo;
    SynMultiSyn1: TSynMultiSyn;
    vbsHighlighter:TSynVBScriptSyn;
    jsHighlighter:TSynJScriptSyn;
    htmlHighlighter:TSynHTMLSyn;
    cssHighlighter: TSynCSSSyn;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    fSearchFromCaret: boolean;
    procedure SetHTMLObj(const Value: IXMLWEBPageType);
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
  public
    { Public declarations }
    property HTMLObj: IXMLWEBPageType read FHTMLObj write SetHTMLObj;
  end;



implementation

{$R *.dfm}

{ TForm1 }

uses dlgSearchText, dlgReplaceText, dlgConfirmReplace, addons;

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

procedure THTMLEdit.Action1Execute(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

procedure THTMLEdit.Action2Execute(Sender: TObject);
begin
 DoSearchReplaceText(FALSE, FALSE);
end;

procedure THTMLEdit.Action3Execute(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, TRUE);
end;

procedure THTMLEdit.Action4Execute(Sender: TObject);
begin
 ShowSearchReplaceDialog(TRUE);
end;

procedure THTMLEdit.Action5Execute(Sender: TObject);
begin
   with TSaveDialog.Create(Application) do
  begin
    if Execute and (FileName<>'') then
        CodeMemo.Lines.SaveToFile(FileName);
  end;
end;

procedure THTMLEdit.Action6Execute(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    if Execute and (FileName<>'') then
        CodeMemo.Lines.LoadFromFile(FileName);
  end;
end;

procedure THTMLEdit.DoSearchReplaceText(AReplace, ABackwards: boolean);
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

procedure THTMLEdit.FormClose(Sender: TObject; var Action: TCloseAction);
var Stream1,Stream2:TStringStream;
begin
  Stream1:=TStringStream.Create(CodeMemo.Lines.Text);
  Stream2:=TStringStream.Create('');
  Stream1.Position:=0;
  EncodeStream(Stream1,Stream2);
  Stream2.Position:=0;
  FHTMLObj.Text:=Stream2.DataString;
  Stream1.Free;
  Stream2.Free;
  Action:=caFree;
end;

procedure THTMLEdit.FormCreate(Sender: TObject);
var MenuItem:TMenuItem;
    i:integer;
begin
  inherited;
  CodeMemo:=TSynMemo.Create(Application);
  CodeMemo.Parent:=TForm(sender);
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  CodeMemo.Font.Size:=10;
  SynEditSearch:= TSynEditSearch.Create(Application);
  SynEditRegexSearch:= TSynEditRegexSearch.Create(Application);
  if addons_<>nil then
  begin
    for i := 0 to addons_.Menu.Count - 1 do
    begin
      MenuItem:=TMenuItem.Create(N12);
      MenuItem.Caption:=addons_.Menu.Menuitem[i].Name;
      MenuItem.Tag:=Integer(Pointer(addons_.Menu.Menuitem[i]));
      MenuItem.OnClick:=MenuClick;
      if addons_.Menu.Menuitem[i].ShortCut<>0 then MenuItem.ShortCut:=addons_.Menu.Menuitem[i].ShortCut;
      N12.Add(MenuItem);
    end;
  end;
end;

procedure THTMLEdit.MenuClick(Sender: TObject);
begin
  DM.ExecuteAddOn(IXMLMenuitemType(Pointer(TMenuItem(Sender).Tag)).Text,CodeMemo,'');
end;

procedure THTMLEdit.SetHTMLObj(const Value: IXMLWEBPageType);
var Stream1,Stream2:TStringStream;
    FileExt:String;
begin
  FHTMLObj := Value;
  Stream1:=TStringStream.Create(FHTMLObj.Text);
  Stream2:=TStringStream.Create('');
  Stream1.Position:=0;
  DecodeStream(Stream1,Stream2);
  Stream2.Position:=0;
  CodeMemo.Lines.Text:=Stream2.DataString;
  Stream1.Free;
  Stream2.Free;
  FileExt:=AnsiUpperCase(ExtractFileExt(FHTMLObj.Name));
  if( FileExt='.HTM') or (FileExt='.HTML') or (FileExt='.ASP') then
  begin
    //htmlHighlighter:=TSynHTMLSyn.Create(Application);
    //CodeMemo.Highlighter:=htmlHighlighter;
    SynMultiSyn1:=TSynMultiSyn.Create(Application);
    htmlHighlighter:=TSynHTMLSyn.Create(Application);
    vbsHighlighter:=TSynVBScriptSyn.Create(Application);
    vbsHighlighter.StringAttri.Foreground:=clMaroon;
    vbsHighlighter.IdentifierAttri.Foreground:=clNavy;
    vbsHighlighter.CommentAttribute.Foreground:=clGreen;
    vbsHighlighter.NumberAttri.Foreground:=clMaroon;
    jsHighlighter:=TSynJScriptSyn.Create(Application);
    jsHighlighter.StringAttri.Foreground:=clMaroon;
    jsHighlighter.IdentifierAttri.Foreground:=clNavy;
    jsHighlighter.CommentAttribute.Foreground:=clGreen;
    jsHighlighter.NumberAttri.Foreground:=clMaroon;
    cssHighlighter:=TSynCSSSyn.Create(Application);
    SynMultiSyn1.Schemes.Clear;
    SynMultiSyn1.Schemes.Add;
    with SynMultiSyn1.Schemes.Items[0] do
    begin
      StartExpr:='<%';
      EndExpr:='%>';
      MarkerAttri.Background := clNone;
      MarkerAttri.Foreground := clPurple;
      SchemeName := 'VBS Full';
      Highlighter:=vbsHighlighter;
    end;
    SynMultiSyn1.Schemes.Add;
    with SynMultiSyn1.Schemes.Items[1] do
    begin
        StartExpr := '<style type="text/css">';
        EndExpr := '</style>';
        Highlighter := cssHighlighter;
        MarkerAttri.Background := clNone;
        MarkerAttri.Foreground := clPurple;
        SchemeName := 'CSS Full';
    end;
    SynMultiSyn1.Schemes.Add;
    with SynMultiSyn1.Schemes.Items[2] do
    begin
        StartExpr := '<style>';
        EndExpr := '</style>';
        Highlighter := cssHighlighter;
        MarkerAttri.Background := clNone;
        MarkerAttri.Foreground := clFuchsia;
        SchemeName := 'CSS Style';
    end;
    SynMultiSyn1.Schemes.Add;
    with SynMultiSyn1.Schemes.Items[3] do
    begin
        StartExpr := '<script language="JavaScript" type="text/javascript">';
        EndExpr := '</script>';
        Highlighter := jsHighlighter;
        MarkerAttri.Background := clNone;
        MarkerAttri.Foreground := clMaroon;
        SchemeName := 'JS Full';
    end;
    SynMultiSyn1.Schemes.Add;
    with SynMultiSyn1.Schemes.Items[4] do
    begin
        StartExpr := '<script>';
        EndExpr := '</script>';
        Highlighter := jsHighlighter;
        MarkerAttri.Background := clNone;
        MarkerAttri.Foreground := clRed;
        SchemeName := 'JS Script';
    end;
    SynMultiSyn1.DefaultHighlighter:=htmlHighlighter;
    CodeMemo.Highlighter:=SynMultiSyn1;
  end;
  if( FileExt='.JS') then
  begin
    jsHighlighter:=TSynJScriptSyn.Create(Application);
    jsHighlighter.StringAttri.Foreground:=clMaroon;
    jsHighlighter.IdentifierAttri.Foreground:=clNavy;
    jsHighlighter.CommentAttribute.Foreground:=clGreen;
    jsHighlighter.NumberAttri.Foreground:=clMaroon;
    CodeMemo.Highlighter:=jsHighlighter;
  end;
  if( FileExt='.CSS') then
  begin
    cssHighlighter:=TSynCSSSyn.Create(Application);
    CodeMemo.Highlighter:=cssHighlighter;
  end;
  if( FileExt='.VBS') then
  begin
    vbsHighlighter:=TSynVBScriptSyn.Create(Application);
    vbsHighlighter.StringAttri.Foreground:=clMaroon;
    vbsHighlighter.IdentifierAttri.Foreground:=clNavy;
    vbsHighlighter.CommentAttribute.Foreground:=clGreen;
    vbsHighlighter.NumberAttri.Foreground:=clMaroon;
    CodeMemo.Highlighter:=vbsHighlighter;
  end;
end;

procedure THTMLEdit.ShowSearchReplaceDialog(AReplace: boolean);
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

end.
