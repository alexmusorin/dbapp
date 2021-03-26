unit SQLDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, ComCtrls, ToolWin, SynEdit, SynMemo, SynHighlighterSQL,
  ExtActns, StdActns, GridFrame, ExtCtrls, TypInfo, DB, JoinDialogUnit, SynCompletionProposal, Grids,
  Menus, ComObj;

type
  TSQLDialog = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Grid_Frame1: TGrid_Frame;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SUM1: TMenuItem;
    AVG1: TMenuItem;
    MIN1: TMenuItem;
    MAX1: TMenuItem;
    FIRST1: TMenuItem;
    LAST1: TMenuItem;
    COUNT1: TMenuItem;
    STDEV1: TMenuItem;
    STDEVP1: TMenuItem;
    VAR1: TMenuItem;
    VARP1: TMenuItem;
    ToolButton6: TToolButton;
    Action5: TAction;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure SynCompletionProposal1Execute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: WideString; var x, y: Integer;
  var CanExecute: Boolean);
    procedure Action1Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure SynMemoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure SynMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1DblClick(Sender: TObject);
    procedure STATFNClick(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
  private
    function getSQL: WideString;
    procedure setSQL(const Value: WideString);
    { Private declarations }
  public
    CodeMemo:TSynMemo;
    SynCompletionProposal1: TSynCompletionProposal;
    sqlHighlighter:TSynSQLSyn;
    { Public declarations }
    property SQL:WideString read getSQL write setSQL;
    procedure gettablefield(ATable:string; AStrings:TStrings);
    function Execute:boolean;
    function FindTable(tableName: String): integer;
  end;



implementation

uses DataUnit, ValEdit, StrUtils;

{$R *.dfm}

procedure TSQLDialog.Action1Execute(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
   Filter:='*.sql|*.sql|*.*|*.*';
   if Execute and (FileName<>'') then
     CodeMemo.Lines.LoadFromFile(FileName);
   Free;
  end;
end;

procedure TSQLDialog.Action2Execute(Sender: TObject);
begin
  if (fsModal in TForm(self).FormState) then
    ModalResult:=mrOk
  else
  with TSaveDialog.Create(Application) do
  begin
   Filter:='*.sql|*.sql|*.*|*.*';
   if Execute and (FileName<>'') then
     CodeMemo.Lines.SaveToFile(FileName);
   Free;
  end;
end;

procedure TSQLDialog.Action3Execute(Sender: TObject);
begin
  CodeMemo.Lines.Text:='';
end;

procedure TSQLDialog.Action4Execute(Sender: TObject);
begin
  if (Pos('SELECT',AnsiUpperCase(Trim(CodeMemo.Lines.Text)))=1) and
  (Pos('INTO',AnsiUpperCase(Trim(CodeMemo.Lines.Text)))=0) then
  begin
    Grid_Frame1.Query:=CodeMemo.Lines.Text;
    PageControl1.ActivePage:=TabSheet2;
  end
  else
  begin
  try
    DM.ADOCommand1.CommandText:= CodeMemo.Lines.Text;
    DM.ADOCommand1.Execute;
    Statusbar1.Panels[0].Text:='Запрос выполнен успешно';
  except
    on E: Exception do begin
      Statusbar1.Panels[0].Text:='Ошибка: '+E.Message;
    end;
  end;
  end;
end;

procedure TSQLDialog.Action5Execute(Sender: TObject);
var ExApp,Sheet,XLRange: variant;
    i,j:integer;
begin
  if Grid_Frame1.ADOQuery.Active=true then
  begin
    ExApp:=CreateOleObject('Excel.Application');
    ExApp.visible:=false;
    ExApp.WorkBooks.Add;
    Sheet:=ExApp.WorkBooks[1].WorkSheets[1];
    for i:=0 to Grid_Frame1.ADOQuery.FieldCount-1 do
    begin
      Sheet.Cells[1,i+1]:=Grid_Frame1.ADOQuery.Fields[i].FieldName;
    end;
    j:=2;
    Grid_Frame1.ADOQuery.First;
    while not Grid_Frame1.ADOQuery.Eof do
    begin
      for i:=0 to Grid_Frame1.ADOQuery.FieldCount-1 do
        Sheet.Cells[j,i+1]:=''''+Grid_Frame1.ADOQuery.Fields[i].AsString;
      j:=j+1;
      Grid_Frame1.ADOQuery.Next;
    end;
    ExApp.visible:=true;
    XLRange := Sheet.Range[Sheet.Cells[1, 1].Address, Sheet.Cells[j-1, Grid_Frame1.ADOQuery.FieldCount].Address];
    XLRange.AutoFormat(6);
  end else
    Statusbar1.Panels[0].Text:='Ошибка: Запрос не выполнен. Выгрузка не возможна';
end;

function TSQLDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TSQLDialog.FindTable(tableName: String): integer;
var i:integer;
begin
  Result:=-1;
  for i := 0 to TreeView1.Items.Count - 1 do
    if (TreeView1.Items[i].Parent=nil) and
    (UpperCase(TreeView1.Items[i].Text)=UpperCase(tableName)) then Result:=i;
end;

procedure TSQLDialog.FormCreate(Sender: TObject);
var i, j:integer;
    SList:TStringList;
    inode:TTreeNode;
    FT:TFieldType;
begin
  inherited;
  CodeMemo:=TSynMemo.Create(TabSheet1);
  CodeMemo.Parent:=TabSheet1;
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  CodeMemo.OnDragDrop:=SynMemoDragDrop;
  CodeMemo.OnDragOver:=SynMemoDragOver;
  CodeMemo.PopupMenu:=PopupMenu1;
  SQLHighlighter:=TSynSQLSyn.Create(Application);
  SQLHighlighter.StringAttri.Foreground:=clMaroon;
  SQLHighlighter.IdentifierAttri.Foreground:=clNavy;
  SQLHighlighter.CommentAttribute.Foreground:=clGreen;
  SQLHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo.Highlighter:=SQLHighlighter;
  SynCompletionProposal1:=TSynCompletionProposal.Create(Application);
  SynCompletionProposal1.Options := [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter];
  SynCompletionProposal1.TriggerChars:='._"';
  SynCompletionProposal1.EndOfTokenChr:='()=. ';
  SynCompletionProposal1.Editor:=CodeMemo;
  SynCompletionProposal1.OnExecute:=SynCompletionProposal1Execute;
  SynCompletionProposal1.Title:='Table property';
  with SynCompletionProposal1.Columns.Add do
     ColumnWidth := 60;
  SynCompletionProposal1.Width:=400;
  Grid_Frame1.ADOQuery.Connection:=DM.ADOConnection1;
  if DM.ADOConnection1.Connected then
  begin
       SList:=TStringList.Create;
       TreeView1.Items.Clear;
       DM.ADOConnection1.GetTableNames(SList);
       for i := 0 to SList.Count - 1 do
        begin
          inode:=TreeView1.Items.AddChild(nil,SList[i]);
          with inode do
          begin
            ImageIndex:=5;
            SelectedIndex:=5;
            DM.ADOTable1.Close;
            DM.ADOTable1.TableName:=SList[i];
            DM.ADOTable1.Open;
            With TreeView1.Items.AddChildObject(inode,'*: all fields',nil) do
              begin
                ImageIndex:=4;
                SelectedIndex:=4;
              end;
            for j := 0 to DM.ADOTable1.FieldCount - 1 do
            begin
              FT:=DM.ADOTable1.FieldDefList.FieldDefs[j].DataType;
              With TreeView1.Items.AddChildObject(inode,DM.ADOTable1.Fields[j].DisplayName+': '+GetEnumName(TypeInfo(TFieldType), Ord(FT)),
                                                  Pointer(Ord(DM.ADOTable1.FieldDefList.FieldDefs[j].DataType))) do
              begin
                ImageIndex:=4;
                SelectedIndex:=4;
              end;
            end;
          end;
        end;
  end;
end;

function TSQLDialog.getSQL: WideString;
begin
  Result:=Grid_Frame1.ADOQuery.SQL.Text;
end;

procedure TSQLDialog.gettablefield(ATable:string; AStrings: TStrings);
var SList:TStringList;
    i:integer;
begin
  SList:=TStringList.Create;
  DM.ADOConnection1.GetFieldNames(ATable,SList);
  for I := 0 to SList.Count - 1 do
    AStrings.Add(ATable+'.'+SList[i]);
end;

procedure TSQLDialog.setSQL(const Value: WideString);
begin
  CodeMemo.Lines.Text:=Value;
end;

procedure TSQLDialog.ToolButton3Click(Sender: TObject);
begin
  CodeMemo.Lines.Text:='';
end;

procedure TSQLDialog.TreeView1DblClick(Sender: TObject);
begin
  CodeMemo.SelText:=Copy(TreeView1.Selected.Text,1,Pos(':',TreeView1.Selected.Text)-1);
end;

procedure TSQLDialog.STATFNClick(Sender: TObject);
begin
  CodeMemo.SelText:=ReplaceStr(TMenuItem(Sender).Caption,'&','')+'('+CodeMemo.SelText+')';
end;

procedure TSQLDialog.SynCompletionProposal1Execute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: WideString; var x, y: Integer;
  var CanExecute: Boolean);
var token, TBuf:string;
    TC: char;
    tindex,i: integer;
begin
  token:=trim(SynCompletionProposal1.PreviousToken);
  if Codememo.CaretX>1 then
  begin
    TBuf:=CodeMemo.Lines.Strings[Codememo.CaretY-1][Codememo.CaretX-1];
    if TBuf<>'' then TC:=TBuf[1] else TC:=' ';
  end else TC:=' ';
  case TC of
  '.': begin
         tindex:=FindTable(token);
         if tindex<>-1 then
         begin
           CanExecute:=true;
           with SynCompletionProposal1 do
           begin
             InsertList.Clear;
             ItemList.Clear;
             for i := 0 to TreeView1.Items[tindex].Count - 1 do
             begin
               InsertList.Add(Copy(TreeView1.Items[tindex].Item[i].Text,1,Pos(':',TreeView1.Items[tindex].Item[i].Text)-1));
               ItemList.Add('\color{clNavy}field \color{clBlack}\column{}\style{+B}'+AnsiReplaceStr(TreeView1.Items[tindex].Item[i].Text,': ','\style{-B} :'));
             end;
           end;
         end;
       end;
  ' ': begin
         CanExecute:=true;
         with SynCompletionProposal1 do
           begin
             InsertList.Clear;
             ItemList.Clear;
             for i := 0 to TreeView1.Items.Count - 1 do
             if (TreeView1.Items[i].Parent=nil) then
             begin
               InsertList.Add(TreeView1.Items[i].Text);
               ItemList.Add('\color{clNavy}table \color{clBlack}\column{}\style{+B}'+TreeView1.Items[i].Text+'\style{-B}');
             end;
             InsertList.Add('SELECT');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}SELECT\style{-B}');
             InsertList.Add('FROM');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}FROM\style{-B}');
             InsertList.Add('WHERE');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}WHERE\style{-B}');
             InsertList.Add('ORDER BY');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}ORDER BY\style{-B}');
             InsertList.Add('GROUP BY');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}GROUP BY\style{-B}');
             InsertList.Add('DISTINCT');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}DISTINCT\style{-B}');
             InsertList.Add('UNION ALL');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}UNION ALL\style{-B}');
             InsertList.Add('INNER');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}INNER\style{-B}');
             InsertList.Add('LEFT');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}LEFT\style{-B}');
             InsertList.Add('RIGHT');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}RIGHT\style{-B}');
             InsertList.Add('JOIN');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}JOIN\style{-B}');
             InsertList.Add('ON');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}ON\style{-B}');
             InsertList.Add('INTO');
             ItemList.Add('\color{clNavy}keyword \color{clBlack}\column{}\style{+B}INTO\style{-B}');
           end;
       end;
  end;
end;

procedure TSQLDialog.SynMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
var i,j:integer;
    TableList:TStringList;
    fieldList:TStringList;
    FS, TS: String;
    CurrentTbl:String;
begin
  TableList:=TStringList.Create;
  fieldList:=TStringList.Create;
  for i := 0 to TreeView1.Items.Count - 1 do
    if TreeView1.Items[i].Selected then
    begin
      if TreeView1.Items[i].Parent<>nil then
      begin
        if TableList.IndexOf(TreeView1.Items[i].Parent.Text)=-1 then
          TableList.Add(TreeView1.Items[i].Parent.Text);
          FieldList.Add(TreeView1.Items[i].Parent.Text+'.'+Copy(TreeView1.Items[i].Text,1,Pos(':',TreeView1.Items[i].Text)-1));
      end else
      begin
        if TableList.IndexOf(TreeView1.Items[i].Text)=-1 then
          TableList.Add(TreeView1.Items[i].Text);
      end;

    end;
   FS:='';
   if TableList.Count>1 then for i := 0 to TableList.Count - 2 do TS:=TS+TableList[i]+', '+#13#10;
   if TableList.Count>0 then TS:=TS+TableList[TableList.Count - 1];
   if FieldList.Count>1 then for i := 0 to FieldList.Count - 2 do FS:=FS+FieldList[i]+', '+#13#10+'       ';
   if FieldList.Count>0 then FS:=FS+FieldList[FieldList.Count - 1]+#13#10;
   if tableList.Count>1 then
   begin
     with TJoinDialog.Create(Application) do
     begin
       for i := 0 to tableList.Count - 2 do
       begin
         ValueListEditor1.InsertRow('Левая таблица','',true);
         ValueListEditor1.InsertRow('Правая таблица','',true);
         ValueListEditor1.InsertRow('Тип объединения','',true);
         with ValueListEditor1.ItemProps[i*3+2] do
         begin
           EditStyle:=esPickList;
           PickList.Add('INNER JOIN');
           PickList.Add('LEFT JOIN');
           PickList.Add('RIGHT JOIN');
           ReadOnly:=True;
         end;
         with ValueListEditor1.ItemProps[i*3] do
         begin
           EditStyle:=esPickList;
           for j := 0 to TableList.Count - 1 do
             gettablefield(TableList[j],PickList);
           ReadOnly:=True;
         end;
         with ValueListEditor1.ItemProps[i*3+1] do
         begin
           EditStyle:=esPickList;
           for j := 0 to TableList.Count - 1 do
             gettablefield(TableList[j],PickList);
           ReadOnly:=True;
         end;
       end;
       if Execute then
       begin
         CurrentTbl:=ValueListEditor1.Strings.ValueFromIndex[ValueListEditor1.Strings.Count-2];
         CurrentTbl:=Copy(CurrentTbl,1,Pos('.',CurrentTbl)-1);
         for i := TableList.Count - 2 downto 0 do
         begin
           CurrentTbl:=Copy(ValueListEditor1.Strings.ValueFromIndex[i*3],1,Pos('.',ValueListEditor1.Strings.ValueFromIndex[i*3])-1)+' '+
                       ValueListEditor1.Strings.ValueFromIndex[i*3+2]+' '+
                       CurrentTbl+#13#10+'       ON '+
                       ValueListEditor1.Strings.ValueFromIndex[i*3]+' = '+
                       ValueListEditor1.Strings.ValueFromIndex[i*3+1];
                       if i>0 then CurrentTbl:='('+#13#10+'     '+CurrentTbl+')';
         end;
       end;
     end;
   end;
   if TableList.Count=1 then CurrentTbl:=TS;
   if FS<>'' then Codememo.Lines.Text:='SELECT '+FS+'FROM '+CurrentTbl+' '
   else Codememo.Lines.Text:='SELECT * FROM '+TS+' ';
   tablelist.Free;
   fieldlist.Free;
end;

procedure TSQLDialog.SynMemoDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=(Source is TTreeView);
end;

end.
