unit CodeFOrmUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynMemo, SynEdit, SynHighlighterVBScript,SynCompletionProposal, ExtCtrls,
  ComCtrls, DataUnit, StrUtils, ImgList, ConfigApp, MyStackUnit, UnitCP, SynUnicode,
  StdCtrls, Menus, ActnList, SynEditRegexSearch, SynEditSearch, SynEditMiscClasses,
  SynEditAutoComplete, SynEditKeyCmds, XPMan, StdActns;

type
  TCodeForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    Action2: TAction;
    N4: TMenuItem;
    Action3: TAction;
    N5: TMenuItem;
    Action4: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    Action5: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    Action6: TAction;
    N10: TMenuItem;
    ImageList1: TImageList;
    Action7: TAction;
    N11: TMenuItem;
    Action8: TAction;
    N12: TMenuItem;
    PopupMenu1: TPopupMenu;
    N13: TMenuItem;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    StepOver1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SynCompletionProposal1Execute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: WideString; var x, y: Integer;
  var CanExecute: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CodeMemoChange(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure actSearchUpdate(Sender: TObject);
    procedure SynEditorReplaceText(Sender: TObject; const ASearch,
      AReplace: UnicodeString; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure actSearchReplaceUpdate(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure SynMemo1SpecialLineColors(Sender: TObject; Line: Integer;
                                        var Special: Boolean; var FG, BG: TColor);
    procedure CodeFormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FXMLActionType: IXMLActionType;
    FXMLForms: IXMLFormsType;
    FXMLModuleType: IXMLModuleType;
    fSearchFromCaret: boolean;
    fAutoComplete: TSynAutoComplete;
    FTreeView: TTreeView;
    FErrorPos: integer;
    FXMLTable: IXMLTableType;
    FGridFilter: string;
    procedure SetXMLActionType(const Value: IXMLActionType);
    procedure SetXMLForms(const Value: IXMLFormsType);
    procedure SetXMLModuleType(const Value: IXMLModuleType);
    procedure DoSearchReplaceText(AReplace: boolean; ABackwards: boolean);
    procedure ShowSearchReplaceDialog(AReplace: boolean);
    procedure SetTreeView(const Value: TTreeView);
    procedure SetErrorPos(const Value: integer);
    procedure SetXMLTable(const Value: IXMLTableType);
    procedure SetGridFilter(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    CodeMemo:TSynMemo;
    vbsHighlighter:TSynVBScriptSyn;
    SynCompletionProposal1: TSynCompletionProposal;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    property XMLActionType:IXMLActionType read FXMLActionType write SetXMLActionType;
    property XMLModuleType:IXMLModuleType read FXMLModuleType write SetXMLModuleType;
    property XMLForms:IXMLFormsType read FXMLForms write SetXMLForms;
    property XMLTable:IXMLTableType read FXMLTable write SetXMLTable;
    property TreeView:TTreeView read FTreeView write SetTreeView;
    property ErrorPos:integer read FErrorPos write SetErrorPos;
    Property GridFilter:string read FGridFilter write SetGridFilter;
    function FindTable(tableName:String):integer;
    function DeleteComment(Value: string): string;
    function FindSynonim(Value:string):String;
    function GetSetVar(Value: string): string;
    procedure ScanWith;
    function TestSynonim(Value:String):String;
    function TestPattern(Value:string; patterns: array of string):boolean;
    function ReplaceVar(Value:String):string;
    procedure SetFormVar(Formcode:string; AResult:TStrings);
  end;


implementation

uses XMLIntf, dlgSearchText, dlgReplaceText, dlgConfirmReplace, SynEditTypes, SynEditMiscProcs, addons;
var
  WithList, SynonimList: TStringList;
  Stack:TMyStack;
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

{ TCodeForm }

procedure TCodeForm.Action1Execute(Sender: TObject);
begin
  //DM.ExecuteScript(CodeMemo.Lines.Text);
  DM.ExecuteScriptInEditor(CodeMemo.Lines.Text, CodeMemo);
end;

procedure TCodeForm.Action2Execute(Sender: TObject);
begin
  ShowSearchReplaceDialog(FALSE);
end;

procedure TCodeForm.Action3Execute(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, FALSE);
end;

procedure TCodeForm.Action4Execute(Sender: TObject);
begin
  DoSearchReplaceText(FALSE, TRUE);
end;

procedure TCodeForm.Action5Execute(Sender: TObject);
begin
  ShowSearchReplaceDialog(TRUE);
end;

procedure TCodeForm.Action6Execute(Sender: TObject);
begin
  with TSaveDialog.Create(Application) do
  begin
    Filter:='*.vbs|*.vbs|*.*|*.*';
    if Execute and (FileName<>'') then
        CodeMemo.Lines.SaveToFile(FileName);
  end;
end;

procedure TCodeForm.Action7Execute(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    Filter:='*.vbs|*.vbs|*.*|*.*';
    if Execute and (FileName<>'') then
        CodeMemo.Lines.LoadFromFile(FileName);
  end;
end;

procedure TCodeForm.Action8Execute(Sender: TObject);
begin
 DM.BeginDebug(CodeMemo.Lines.Text, Caption);
end;

procedure TCodeForm.Action9Execute(Sender: TObject);
begin
//
end;

procedure TCodeForm.actSearchReplaceUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (gsSearchText <> '')
    and not CodeMemo.ReadOnly;
end;

procedure TCodeForm.actSearchUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := gsSearchText <> '';
end;

procedure TCodeForm.CodeMemoChange(Sender: TObject);
begin
  ScanWith;
end;

function TCodeForm.DeleteComment(Value: string): string;
begin
  if Pos('''',Value)<>0 then
    Result:=trim(LeftStr(Value,Pos('''',Value)-1))
  else Result:=Value;
end;

procedure TCodeForm.DoSearchReplaceText(AReplace, ABackwards: boolean);
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

function TCodeForm.FindSynonim(Value: string): String;
var i:integer;
begin
  Result:='';
  for i := 0 to SynonimList.Count - 1 do
    if AnsiUpperCase(Value)=SynonimList.Names[i] then
       Result:= SynonimList.ValueFromIndex[i];
end;

function TCodeForm.FindTable(tableName: String): integer;
var i:integer;
begin
  Result:=-1;
  for i := 0 to FTreeView.Items.Count - 1 do
    if (FTreeView.Items[i].Parent=nil) and
    (UpperCase(FTreeView.Items[i].Text)=UpperCase(tableName)) then Result:=i;
end;

procedure TCodeForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FXMLActionType) then IXMLActionType(FXMLActionType).Text:=CodeMemo.Lines.Text;
  if Assigned(FXMLModuleType) then IXMLModuleType(FXMLModuleType).Text:=CodeMemo.Lines.Text;
  Action:=caFree;
end;

procedure TCodeForm.FormCreate(Sender: TObject);
var MenuItem:TMenuItem;
    i:integer;
begin
  inherited;
   FXMLActionType := nil;
   FXMLModuleType := nil;

  CodeMemo:=TSynMemo.Create(Application);
  CodeMemo.Parent:=TForm(sender);
  CodeMemo.Tag:=-1;
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  CodeMemo.Font.Size:=10;
  CodeMemo.PopupMenu:=PopupMenu1;
  Codememo.OnMouseDown:=CodeFormMouseDown;
  vbsHighlighter:=TSynVBScriptSyn.Create(Application);
  //vbsHighlighter.KeyAttri.Foreground:=clNavy;
  vbsHighlighter.StringAttri.Foreground:=clMaroon;
  vbsHighlighter.IdentifierAttri.Foreground:=clNavy;
  vbsHighlighter.CommentAttribute.Foreground:=clGreen;
  vbsHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo.Highlighter:=vbsHighlighter;
  CodeMemo.OnChange:=CodeMemoChange;
  CodeMemo.OnSpecialLineColors:=SynMemo1SpecialLineColors;
  SynCompletionProposal1:=TSynCompletionProposal.Create(Application);
  SynCompletionProposal1.Options := [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter];
  SynCompletionProposal1.TriggerChars:='._"';
  SynCompletionProposal1.EndOfTokenChr:='()=. ';
  SynCompletionProposal1.Editor:=CodeMemo;
  SynCompletionProposal1.OnExecute:=SynCompletionProposal1Execute;
  SynCompletionProposal1.Title:='VBScript property';
  with SynCompletionProposal1.Columns.Add do
     ColumnWidth := 60;
  SynCompletionProposal1.Width:=400;
  //SynCompletionProposal1.OnExecute:=SynCompletionProposal1Execute;
  //SynCompletionProposal1.OnCodeCompletion:=codecomp;
  WithList := TStringList.Create;
  SynonimList := TStringList.Create;
  SynEditSearch:= TSynEditSearch.Create(Application);
  SynEditRegexSearch:= TSynEditRegexSearch.Create(Application);
  Stack:=TMyStack.Create;
  fAutoComplete := TSynAutoComplete.Create(Self);
  fAutoComplete.Editor := CodeMemo;
  fAutoComplete.AutoCompleteList.LoadFromFile(ExtractFilePath(ParamStr(0))+'VBScript.dci');
  CodeMemo.AddKey(ecAutoCompletion, word('J'), [ssCtrl], 0, []);
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

procedure TCodeForm.CodeFormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    ShowMessage(CodeMemo.WordAtMouse);
end;

function TCodeForm.GetSetVar(Value: string): string;
var BufferStr:string;
begin
  BufferStr:=AnsiUpperCase(Value); //верхний регистр
  BufferStr:=TRIM(BufferStr);           //обрезать пробелы
  BufferStr:=LeftStr(BufferStr,Pos('=',BufferStr)-1); //обрезать до пробела
  BufferStr:=RightStr(BufferStr,length(BufferStr)-3); //обрезать set
  BufferStr:=Trim(BufferStr);
  Result:=BufferStr;
end;

procedure TCodeForm.MenuClick(Sender: TObject);
var tname:string;
begin
  if Assigned(FXMLActionType) then tname:=IXMLTableType(FXMLTable).Name
  else tname:='';
  DM.ExecuteAddOn(IXMLMenuitemType(Pointer(TMenuItem(Sender).Tag)).Text,CodeMemo,tname);
end;

function TCodeForm.ReplaceVar(Value: String): string;
var i:integer;
    BuffStr1:String;
    BuffStr2:String;
begin
  BuffStr1:=LeftStr(Value,Pos('=',Value));
  BuffStr2:=RightStr(Value,Length(Value)-Length(BuffStr1));
  for i := 0 to SynonimList.Count - 1 do
     BuffStr2 := ReplaceStr(BuffStr2,SynonimList.Names[i],SynonimList.ValueFromIndex[i]);
 // Memo1.Lines.Add(BuffStr1 + ReplaceStr(BuffStr2,'LINES','ITEMS'));
  Result := BuffStr1 + ReplaceStr(BuffStr2,'LINES','ITEMS');
end;

procedure TCodeForm.ScanWith;
var i,j:integer;
    Str, SS, Wname: string;
    FormStr:string;

begin

   WName:='';
   WithList.Clear;
   SynonimList.Clear;
   SynonimList.Add('APP=APP');
   SynonimList.Add('FONT=FONT');
   SynonimList.Add('LINES=LINES');
   SynonimList.Add('ITEMS=LINES');
   SynonimList.Add('DEBUG=DEBUG');
   SynonimList.Add('ERR=ERR');
   SynonimList.Add('DICT=DICT');
   SynonimList.Add('FORM=TFORM');
   SynonimList.Add('QUERY=QUERY');
   SynonimList.Add('LINKTO=LINK');
   SynonimList.Add('REPORT=REPORT');
   SynonimList.Add('WORKPANEL=TPANEL');
   for i := 0 to CodeMemo.Lines.Count - 1 do
   begin
     Str:=Trim(AnsiUpperCase(CodeMemo.Lines.Strings[i]));
     SS:=TestSynonim(Str);
     if SS<>'' then
        SynonimList.Add(SS);
     if Pos('FORM(',Str)<>0 then
     begin
       if Pos('"',Str)<>0 then FormStr:=RightStr(Str,Length(str)-Pos('"',Str));
       FormStr:=LeftStr(FormStr,Pos('"',FormStr)-1);
       if Formstr<>'' then
       begin
         //Memo1.Lines.Add(Formstr+'=TFORM');
         for j := 0 to FXMLForms.Count - 1 do
         begin
           if AnsiUpperCase(FXMLForms.Form[j].Name)=FormStr then
           begin
             //SetFormVar(FXMLForms.Form[j].Text,Memo1.Lines);
             SetFormVar(FXMLForms.Form[j].Text,SynonimList);
           end;
         end;
       end;
     end;
     if Pos('WITH', Str)=1 then
     begin
       Str:=Trim(ReplaceStr(Str,'WITH',''));
       WName:=Str;
       Stack.Add(Str);
     end;
     if Pos('END WITH',Str)<>0 then
     begin
       Stack.Take;
       WName:=Stack.Top;
     end;
     if Pos('(',WName)<>0 then
       WName:=Copy(WName, 1, Pos('(',WName)-1);
     WithList.Add(WName);
     if Stack.isEmpty then WName :='';
   end;
end;

procedure TCodeForm.SetErrorPos(const Value: integer);
begin
  FErrorPos := Value;
end;

procedure TCodeForm.SetFormVar(FormCode: string; AResult: TStrings);
var FBuf:TStringList;
    i:integer;
begin
  FBuf:=TStringList.Create;
  FBuf.Text:=FormCode;
  for i := 1 to FBuf.Count - 1 do
  if pos('object',FBuf[i])<>0 then
  begin
    AResult.Add(AnsiUpperCase(
                 AnsiReplaceStr(
                   AnsiReplaceStr(
                      Trim(
                        AnsiReplaceStr(Fbuf[i],'object ','')
                      ),':','=')
                   ,' ','')
                 )
               );
  end;
  FBuf.Free;
end;

procedure TCodeForm.SetGridFilter(const Value: string);
begin
  FGridFilter := Value;
end;

procedure TCodeForm.SetTreeView(const Value: TTreeView);
begin
  FTreeView := Value;
end;

procedure TCodeForm.SetXMLActionType(const Value: IXMLActionType);
begin
  FXMLActionType := Value;
end;

procedure TCodeForm.SetXMLForms(const Value: IXMLFormsType);
begin
  FXMLForms := Value;
end;

procedure TCodeForm.SetXMLModuleType(const Value: IXMLModuleType);
begin
  FXMLModuleType := Value;
end;

procedure TCodeForm.SetXMLTable(const Value: IXMLTableType);
begin
  FXMLTable := Value;
end;

procedure TCodeForm.ShowSearchReplaceDialog(AReplace: boolean);
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

procedure TCodeForm.SynCompletionProposal1Execute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: WideString; var x, y: Integer;
  var CanExecute: Boolean);
var TBuf,EDStr,DStr:string;
    TC:char;
    token,synon:String;
    tindex,i,j:integer;
    FuncList1:TStringList;
begin
  //ѕолучаем токен и trigerChar
  CanExecute:=false;
  token:=trim(SynCompletionProposal1.PreviousToken);
  //Memo1.Lines.Add(token);
  if Codememo.CaretX>1 then
  begin
    TBuf:=CodeMemo.Lines.Strings[Codememo.CaretY-1][Codememo.CaretX-1];
    if TBuf<>'' then TC:=TBuf[1] else TC:=' ';
  end else TC:=' ';
  //¬ зависимости от  trigerChar
  case TC of
  '.': begin
  if (token='') and (withList.Count>0) then token:=withList[Codememo.CaretY-1];
  synon :=FindSynonim(token);
  if synon<>'' then
  begin
    CanExecute:=true;
    FuncList1:=TStringList.Create;
    GetClassProperty(synon,FuncList1);
    with SynCompletionProposal1 do
    begin
     InsertList.Clear;
     ItemList.Clear;
     for i := 0 to FuncList1.Count - 1 do
     begin
       InsertList.Add(FuncList1.Names[i]);
       ItemList.Add(FuncList1.ValueFromIndex[i]);
     end;
    end;
    Funclist1.Free;
  end else
  begin
  tindex:=FindTable(token);
  if tindex<>-1 then
  begin
    CanExecute:=true;
    with SynCompletionProposal1 do
    begin
      InsertList.Clear;
      ItemList.Clear;
      for i := 0 to FTreeView.Items[tindex].Count - 1 do
        begin
          InsertList.Add(Copy(FTreeView.Items[tindex].Item[i].Text,1,Pos(':',FTreeView.Items[tindex].Item[i].Text)-1));
          ItemList.Add('\color{clNavy}field \color{clBlack}\column{}\style{+B}'+AnsiReplaceStr(FTreeView.Items[tindex].Item[i].Text,': ','\style{-B} :'));
        end;
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Open'+'\style{-B}');
      InsertList.Add('Open');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Close');
      InsertList.Add('Close');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Insert'+'\style{-B}');
      InsertList.Add('Insert');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Edit'+'\style{-B}');
      InsertList.Add('Edit');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Last'+'\style{-B}');
      InsertList.Add('Last');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'First'+'\style{-B}');
      InsertList.Add('First');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Next'+'\style{-B}');
      InsertList.Add('Next');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Prev'+'\style{-B}');
      InsertList.Add('Prev');
      ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}'+'Post'+'\style{-B}');
      InsertList.Add('Post');
      ItemList.Add('\color{clBlue}function \color{clBlack}\column{}\style{+B}'+'EOF'+'\style{-B}');
      InsertList.Add('EOF');
      ItemList.Add('\color{clBlue}function \color{clBlack}\column{}\style{+B}'+'BOF'+'\style{-B}');
      InsertList.Add('BOF');
    end;
  end;
  if Pos(']',token)<>0 then
  begin
    if Pos('[',token)<>0 then
       token:=Copy(token,2,Length(token)-2)
    else
    begin
      TBuf:=CodeMemo.Lines.Strings[Codememo.CaretY-1];
      i:=Codememo.CaretX-3;
      token:='';
      while (TBuf[i]<>'[') and (i>0) do
      begin
       token:= TBuf[i]+token;
       i:=i-1;
      end;
    end;
    for i := 0 to AppConf_.Tables.Count - 1 do
      if AnsiUpperCase(token)=AnsiUpperCase(appConf_.Tables.Table[i].Name) then
      begin
      CanExecute:=true;
      with SynCompletionProposal1 do
      begin
        InsertList.Clear;
        ItemList.Clear;
        InsertList.Add('Name');
        ItemList.Add('\color{clNavy}property \color{clBlack}\column{}\style{+B}Name\Style{-B}: String');
        InsertList.Add('Query');
        ItemList.Add('\color{clNavy}property \color{clBlack}\column{}\style{+B}Query\Style{-B}: String');
        InsertList.Add('Table');
        ItemList.Add('\color{clNavy}property \color{clBlack}\column{}\style{+B}Table\Style{-B}: IDispatch');
        InsertList.Add('Show');
        ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Show\style{-B}');
        InsertList.Add('Refresh');
        ItemList.Add('\color{clTeal}procedure \color{clBlack}\column{}\style{+B}Refresh\style{-B}');
        for j := 0 to  appConf_.Tables.Table[i].Actions.Count - 1 do
        begin
          InsertList.Add('['+appConf_.Tables.Table[i].Actions.Action[j].Name+']');
          ItemList.Add('\color{clMoneyGreen}action \color{clBlack}\column{}\style{+B}['+appConf_.Tables.Table[i].Actions.Action[j].Name+']\style{-B}');
        end;  
      end;
      end;
    for i := 0 to AppConf_.Modules.Count-1 do
      if AnsiUpperCase(token)=AnsiUpperCase(AppConf_.Modules.Modulegroup[i].Name) then
      begin
        CanExecute:=true;
        with SynCompletionProposal1 do
        begin
          InsertList.Clear;
          ItemList.Clear;
          for j := 0 to AppConf_.Modules.Modulegroup[i].Count - 1 do
          begin
            InsertList.Add('['+AppConf_.Modules.Modulegroup[i].Module[j].Name+']');
            ItemList.Add('\color{clBlue}модуль \color{clBlack}\column{}\style{+B}['+AppConf_.Modules.Modulegroup[i].Module[j].Name+']\style{-B}');
          end;
        end;
      end;
  end;
  end;
  end;
  '"':begin
    i:=Codememo.CaretX-2;
    token:='';
    while (i>0) and
          (CodeMemo.Lines.Strings[Codememo.CaretY-1][i]<>' ') and
          (CodeMemo.Lines.Strings[Codememo.CaretY-1][i]<>'=') do
    begin
      token:=CodeMemo.Lines.Strings[Codememo.CaretY-1][i]+token;
      i:=i-1;
    end;
    token:=AnsiUpperCase(token);
    with SynCompletionProposal1 do
    begin
      InsertList.Clear;
      ItemList.Clear;
      if token='REPORT(' then
      begin
        for i := 0 to AppConf_.Reports.Count - 1 do
        begin
          InsertList.Add('"'+AppConf_.Reports.Report[i].Name+'")');
          ItemList.Add('\color{clBlue}отчет \color{clBlack}\column{}\style{+B}'+AppConf_.Reports.Report[i].Name+'\style{-B}');
        end;
      end;
      if (token='FORM(') or (token='MDIFORM(')  then
      begin
        for i := 0 to AppConf_.Forms.Count - 1 do
        begin
          InsertList.Add('"'+AppConf_.Forms.Form[i].Name+'")');
          ItemList.Add('\color{clBlue}форма \color{clBlack}\column{}\style{+B}'+AppConf_.Forms.Form[i].Name+'('+AppConf_.Forms.Form[i].Caption+')'+'\style{-B}');
        end;
      end;
      if token='LINKTO(' then
      begin
        for i := 0 to AppConf_.Tables.Count - 1 do
        begin
          InsertList.Add('"'+AppConf_.Tables.Table[i].Name+'")');
          ItemList.Add('\color{clBlue}таблица \color{clBlack}\column{}\style{+B}'+AppConf_.Tables.Table[i].Name+'\style{-B}');
        end;
      end;
      if token='TEXTDOCUMENT(' then
      begin
        for i := 0 to AppConf_.Variables.Count - 1 do
        begin
          InsertList.Add('"'+AppConf_.Variables.Variable[i].Name+'")');
          ItemList.Add('\color{clBlue}константа \color{clBlack}\column{}\style{+B}'+AppConf_.Variables.Variable[i].Name+'\style{-B}');
        end;
      end;
    end;
  end;
  '_':begin
   with SynCompletionProposal1 do
  begin
  InsertList.Clear;
  ItemList.Clear;
  for i:=0 to SynonimList.Count - 1 do
  begin
     if Pos(AnsiUpperCase(token),SynonimList.Names[i])=1 then
     begin
       EdStr:=SynonimList.Names[i];
       EdStr:=AnsiLowerCase(EdStr);
       EdStr[1]:=AnsiUpperCase(EdStr[1])[1];
       EdStr[Pos('_',EdStr)+1]:=AnsiUpperCase(EdStr[Pos('_',EdStr)+1])[1];
       DStr:=SynonimList.ValueFromIndex[i];
       DStr:=AnsiLowerCase(DStr);
       DStr[1]:=AnsiUpperCase(DStr[1])[1];
       DStr[2]:=AnsiUpperCase(DStr[2])[1];
       InsertList.Add(EdStr);
       ItemList.Add('object \column{}\style{+B}'+EdStr+'\style{-B}:'+Dstr);
     end;
     if (Pos(LeftStr(AnsiUpperCase(token),length(token)-1),SynonimList.Names[i])=1)
         and (length(token)> length(SynonimList.Names[i])) then
     begin
       EdStr:=SynonimList.Names[i];
       EdStr:=AnsiLowerCase(EdStr);
       EdStr[1]:=AnsiUpperCase(EdStr[1])[1];
       EdStr[Pos('_',EdStr)+1]:=AnsiUpperCase(EdStr[Pos('_',EdStr)+1])[1];
       InsertList.Add(EdStr+'_OnClick');
       ItemList.Add('action \column{}\style{+B}'+EdStr+'_OnClick\style{-B}');
       InsertList.Add(EdStr+'_OnExit');
       ItemList.Add('action \column{}\style{+B}'+EdStr+'_OnExit\style{-B}');
       InsertList.Add(EdStr+'_OnEnter');
       ItemList.Add('action \column{}\style{+B}'+EdStr+'_OnEnter\style{-B}');
       InsertList.Add(EdStr+'_OnChange');
       ItemList.Add('action \column{}\style{+B}'+EdStr+'_OnChange\style{-B}');
     end;
    end;
  end;
  if SynCompletionProposal1.InsertList.Count>0 then CanExecute:=true;
  end
  else
  begin
    CanExecute:=true;
    FuncList1:=TStringList.Create;
    if DM.ADOConnection1.Connected then
    begin
      DM.ADOConnection1.GetTableNames(FuncList1);
      SynCompletionProposal1.InsertList.Clear;
      SynCompletionProposal1.ItemList.Clear;
      for i := 0 to FuncList1.Count - 1 do
      begin
         SynCompletionProposal1.InsertList.Add(FuncList1[i]);
         SynCompletionProposal1.ItemList.Add('\color{clMaroon}object \color{clBlack}\column{}\style{+B}'+FuncList1[i]+'\style{-B}');
      end;
    end;
    GetClassProperty(synon,FuncList1);
    with SynCompletionProposal1 do
    begin
     for i := 0 to FuncList1.Count - 1 do
     begin
       InsertList.Add(FuncList1.Names[i]);
       ItemList.Add(FuncList1.ValueFromIndex[i]);
     end;
    end;
    Funclist1.Free;
  end;
  end;  //end case

end;

procedure TCodeForm.SynEditorReplaceText(Sender: TObject; const ASearch,
  AReplace: UnicodeString; Line, Column: Integer;
  var Action: TSynReplaceAction);
var
  APos: TPoint;
  EditRect: TRect;
begin
  if ASearch = AReplace then
    Action := raSkip
  else begin
    APos := CodeMemo.ClientToScreen(
      CodeMemo.RowColumnToPixels(
      CodeMemo.BufferToDisplayPos(
        BufferCoord(Column, Line) ) ) );
    EditRect := ClientRect;
    EditRect.TopLeft := ClientToScreen(EditRect.TopLeft);
    EditRect.BottomRight := ClientToScreen(EditRect.BottomRight);

    if ConfirmReplaceDialog = nil then
      ConfirmReplaceDialog := TConfirmReplaceDialog.Create(Application);
    ConfirmReplaceDialog.PrepareShow(EditRect, APos.X, APos.Y,
      APos.Y + CodeMemo.LineHeight, ASearch);
    case ConfirmReplaceDialog.ShowModal of
      mrYes: Action := raReplace;
      mrYesToAll: Action := raReplaceAll;
      mrNo: Action := raSkip;
      else Action := raCancel;
    end;
  end;
end;

procedure TCodeForm.SynMemo1SpecialLineColors(Sender: TObject; Line: Integer;
  var Special: Boolean; var FG, BG: TColor);
begin
  if (tSynMemo(Sender).Tag<>-1) and (Line=tSynMemo(Sender).Tag) then
  begin
    Special:=true;
    BG:=clRed;
  end;
  if tSynMemo(Sender).Tag=-1 then Special:=false;
end;

function TCodeForm.TestPattern(Value: string;
  patterns: array of string): boolean;
var i:integer;
    SumPos:integer;
begin
   SumPos:=0;
   for i := 0 to Length(patterns) - 1 do
     SumPos := SumPos + Pos(patterns[i],Value);
   Result := (SumPos > 0);
end;

function TCodeForm.TestSynonim(Value: String): String;
var BStr:String;
    ObjToken:string;
begin
   BStr:=Trim(DeleteComment(AnsiUpperCase(Value)));
   Result:='';
   If Pos('SET ', AnsiUpperCase(Trim(Value)))=1 then
   begin
   if TestPattern(BStr,['APP.CREATEFORM',' FORM(','=FROM(']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'TFORM';
   end else
   if TestPattern(BStr,['APP.CREATEQUERY', ' QUERY(', '=QUERY(']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'QUERY';
   end else
   if TestPattern(BStr,['APP.LINKTO', ' LINKTO(', '=LINKTO(']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'LINK';
   end else
   if TestPattern(BStr,[' REPORT(', '=REPORT(']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'REPORT';
   end else
   if TestPattern(ReplaceVar(BStr),['SHELL.APPLICATION', 'ISHELLDISPATCH.APPLICATION', 'ISHELLDISPATCH.PARENT', 'ISHELLFOLDER.APPLICATION', 'ISHELLFOLDERITEMS.APPLICATION']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLDISPATCH';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLDISPATCH.NAMESPACE','ISHELLDISPATCH.BROWSEFORFOLDER','ISHELLFOLDER.PARENTFOLDER','ISHELLFOLDERITEM.GETFOLDER','ISHELLFOLDERITEM.PARENT']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLFOLDER';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLFOLDER.ITEMS']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLFOLDERITEMS';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLFOLDERITEMS.ITEM','ISHELLFOLDER.ITEMS.ITEM','ISHELLFOLDER.SELF','ISHELLLINKOBJECT.TARGET']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLFOLDERITEM';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLDISPATCH.WINDOWS']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLWINDOWS';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLFOLDERITEM.GETLINK']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLLINKOBJECT';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLFOLDERITEMS.VERBS','ISHELLFOLDERITEM.VERBS']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLFOLDERITEMVERBS';
   end else
   if TestPattern(ReplaceVar(BStr),['ISHELLFOLDERITEMVERBS.ITEM']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ISHELLFOLDERITEMVERB';
   end else
   if TestPattern(ReplaceVar(BStr),['VBSCRIPT.REGEXP']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IREGEXP';
   end else
   if TestPattern(ReplaceVar(BStr),['IREGEXP.EXECUTE']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IREGEXPMATCHES';
   end else
   if TestPattern(ReplaceVar(BStr),['REGEXPMATCHES.ITEM']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IREGEXPMATCH';
   end else
   if TestPattern(ReplaceVar(BStr),['SCRIPTING.FILESYSTEMOBJECT']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IFILESYSTEMOBJECT';
   end else
   if TestPattern(ReplaceVar(BStr),['IFILESYSTEMOBJECT.DRIVES']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IDRIVECOLLECTION';
   end else
   if TestPattern(ReplaceVar(BStr),['IDRIVECOLLECTION.ITEM', 'IFILESYSTEMOBJECT.GETDRIVE', 'IFOLDER.DRIVE', 'IFILE.DRIVE']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IDRIVE';
   end else
   if TestPattern(ReplaceVar(BStr),['IFOLDER.FILES']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IFILECOLLECTION';
   end else
   if TestPattern(ReplaceVar(BStr),['IFILESYSTEMOBJECT.GETFILE','IFOLDER.FILES.ITEM',  'IFILECOLLECTION.ITEM']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IFILE';
   end else
   if TestPattern(ReplaceVar(BStr),['IFOLDER.SUBFOLDERS']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IFOLDERCOLLECTION';
   end else
   if TestPattern(ReplaceVar(BStr),['IFILESYSTEMOBJECT.GETFOLDER', 'IFILESYSTEMOBJECT.GETSPECIALFOLDER', 'IFOLDERCOLLECTION.ITEM', 'IDRIVE.ROOTFOLDER', 'IFOLDER.PARENTFOLDER']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IFOLDER';
   end else
   if TestPattern(ReplaceVar(BStr),['IFILESYSTEMOBJECT.CREATETEXTFILE','IFILESYSTEMOBJECT.GETSTANDARDSTREAM','IFILESYSTEMOBJECT.OPENTEXTFILE','IFILE.OPENASTEXTSTREAM','IFOLDER.CREATETEXTFILE']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'ITEXTSTREAM';
   end else
   if TestPattern(ReplaceVar(BStr),['SCRIPTING.DICTIONARY']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IDICTIONARY';
   end else
   if TestPattern(ReplaceVar(BStr),['WSCRIPT.SHELL']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IWSHSHELL';
   end else
   if TestPattern(ReplaceVar(BStr),['IWSHSHELL.EXEC']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IWSHSCRIPTEXEC';
   end else
   if TestPattern(ReplaceVar(BStr),['IWSHSHELL.CREATESHORTCUT']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IWSHSHORTCUT';
   end else
   if TestPattern(ReplaceVar(BStr),['WSCRIPT.NETWORK']) then
   begin
     ObjToken:=GetSetVar(BStr);
     Result:=ObjToken+'='+'IWSHNETWORK';
   end;
   end
   else
   if Pos('.ADD',BStr)<>0 then
   begin
     ObjToken:=RightStr(BStr,Length(BStr)-Pos('.ADD',BStr)-4);
     ObjToken:=ReplaceStr(ObjToken,'.ADD','');
     ObjToken:=ReplaceStr(ObjToken,'"','');
     ObjToken:=ReplaceStr(ObjToken,' ','');
     ObjToken:=ReplaceStr(ObjToken,',TRUE','');
     ObjToken:=ReplaceStr(ObjToken,',FALSE','');
     ObjToken:=ReplaceStr(ObjToken,',','=');
     Result:=ObjToken;
   end;
end;

end.
