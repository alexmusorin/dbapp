unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns, SQLDialogUnit,
  ActnList, ToolWin, ImgList, ConfigApp, AddTableForm, AddActionUnit,TestFormUnit,
   msxmldom, XMLDoc,XMLIntf, FormCHILDUnit, CodeFormUnit, FormCreationUnit, TypInfo, DB,
  FieldDialogUnit, StyleDialogUnit, SelDialogUnit, QueryDialogUnit, DataUnit, ConstUnit,
  XPMan, ConfigDialogUnit, ModuleDialogUnit, EncdDecd, ReportDialogUnit, WEBDialogUnit,
  HTMLEditUnit, ZLib, xmldom, jpeg, addonseditunit, Tabs, DockTabSet, StrUtils,
  ModuleGroupDialogUnit,ADODB;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ImageList1: TImageList;
    ImageList2: TImageList;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
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
    Action4: TAction;
    N5: TMenuItem;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    TreeView2: TTreeView;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Action5: TAction;
    XPManifest1: TXPManifest;
    TabSheet3: TTabSheet;
    Action6: TAction;
    N6: TMenuItem;
    XMLDocument1: TXMLDocument;
    ToolButton14: TToolButton;
    Panel2: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    ImageList3: TImageList;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ListView1: TListView;
    Memo1: TMemo;
    Action7: TAction;
    N7: TMenuItem;
    Image1: TImage;
    ToolButton16: TToolButton;
    Action8: TAction;
    N8: TMenuItem;
    ScrollBox1: TScrollBox;
    WorkPanel: TPanel;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure TreeView1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView2DblClick(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure ToolButton14Click(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  public
    FFileName:string;
    isEditing:boolean;
    FCanSave: boolean;
    { Public declarations }
    procedure setNodeImage(node:TTreeNode; imageIndex:integer);
    Procedure UpdateTreeView;
    procedure UpdateWorkPanel;
    procedure CloseAllChild;
    function FindWindow(Value:string):boolean;
    function WBF(Value:string; Filter:string):TForm;
    function WBFToolWin(Value:string):TForm;
    procedure OpenConfFile(Filename:String);
    function ShowTableWindow(tableNode:IXMLTableType; Filter:string):TTestDialog;
  end;

var
  MainForm: TMainForm;


implementation

{$R *.dfm}

uses CHILDWIN, about, BrowserFormUnit, ObjectBrowserUnit, xmlbrowserdata,
  FilterDBGrid, DBGrids;

procedure TMainForm.Action1Execute(Sender: TObject);
var constnode:IXMLVariableType;
    tablenode:IXMLTableType;
    stylenode:IXMLMarkType;
    fieldnode:IXMLFieldType;
    selnode:IXMLSelectionType;
    formnode:IXMLFormType;
    actionnode:IXMLActionType;
    ModuleNode:IXMLModuleType;
    ModuleGroupNode:IXMLModulegroupType;
    ReportNode:IXMLReportType;
    WEBNode:IXMLWEbPageType;
    i:integer;
    Ms:TMemoryStream;
    SS:TStringStream;
begin
  if TreeView1.Selected=nil then exit;
  
  if TreeView1.Selected.Text='Таблицы' then
  with TAddTableDialog.Create(Application) do
  begin
    if Execute then
    begin
       tablenode:=IXMLTablesType(TreeView1.Selected.Data).Add;
       if TableName<>'' then tablenode.Name:=TableName else tablenode.Name:=TableLinkTo;
       tablenode.Linkto:=TableLinkTo;
       tablenode.Query:=SQL;
       for i := 0 to Fields.Count-1 do
          with tablenode.Fields.Add do
          begin
            Name:= Fields[i];
            Display:= Fields[i];
          end;
       //TreeView1.Items.AddChildObject(TreeView1.Selected,TableName,Pointer(tablenode));
       UpdateTreeView;
    end;
    Free;
    Exit;
  end;
  if TreeView1.Selected.Text='Константы' then
  with TConstDialog.Create(Application) do
  begin
    if Execute then
    begin
      constnode:=IXMLVariablesType(TreeView1.Selected.Data).Add;
      constnode.Name:=ConstName;
      constnode.ChildNodes.Add(constnode.OwnerDocument.CreateNode(ConstValue,ntCData));
      //constnode.OwnerDocument.CreateNode(ConstValue,ntCData);
      //TreeView1.Items.AddChildObject(TreeView1.Selected,ConstName,Pointer(constnode));
    end;
    UpdateTreeView;
    Free;
    Exit;
  end;
  if TreeView1.Selected.Text='Стили ячеек' then
  with TStyleDialog.Create(Application) do
  begin
    if Execute then
    begin
      stylenode:=IXMLMarkingsType(TreeView1.Selected.Data).Add;
      stylenode.Foreground:=FontColor;
      stylenode.Background:=Background;
      stylenode.Style:=FontStyle;
      stylenode.ChildNodes.Add(stylenode.OwnerDocument.CreateNode(Condition,ntCData));
    end;
    UpdateTreeView;
    Free;
    Exit;
  end;
  if TreeView1.Selected.Text='Поля' then
  with TFieldDialog.Create(Application) do
  begin
     DM.ADOQuery1.SQL.Text:=IXMLTableType(TreeView1.Selected.Parent.Data).Query;
     DM.ADOQuery1.Open;

     DM.ADOQuery1.GetFieldNames(ComboBox1.Items);

     if Execute then
     begin
       fieldnode:=IXMLFieldsType(TreeView1.Selected.Data).Add;
       fieldnode.Name:=BDField;
       if FieldName<>'' then fieldnode.Display:=FieldName
       else  fieldnode.Display:=BDField;
     end;
     UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Text='Выборки' then
  with TSelDialog.Create(Application) do
  begin
     if Execute then
     begin
       selnode:=IXMLSelectionsType(TreeView1.Selected.Data).Add;
       selnode.Name:=SelName;
       selnode.ChildNodes.Add(selnode.OwnerDocument.CreateNode(SQL,ntCData));
     end;
     UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Text='Формы' then
  with TFormCreationDialog.Create(Application) do
  begin
    if Execute then
    begin
      formnode:=IXMLFormsType(TreeView1.Selected.Data).Add;
      formnode.Name:=FormName;
      formNode.Caption:=FormCaption;
      formnode.ChildNodes.Add(formnode.OwnerDocument.CreateNode(CodeOfForm,ntCData));
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Text='Действия' then
  with TAddActionDialog.Create(application) do
  begin
    if Execute then
    begin
      actionnode:=IXMLActionsType(TreeView1.Selected.Data).Add;
      actionnode.Name:=ActionName;
      actionnode.Popup:=ActionType;
      actionnode.Imageindex:=ImageIndex;
      actionnode.ShortCut:=ShortCut;
      ActionNode.ChildNodes.Add(actionnode.OwnerDocument.CreateNode('''действие '+ActionName,ntCData));
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Parent.Text='Модули' then
  with TModuleDialog.Create(application) do
  begin
    if Execute then
    begin
      Modulenode:=IXMLModulegroupType(TreeView1.Selected.Data).Add;
      Modulenode.Name:=ModuleName;
      Modulenode.MType:=MType;
      //actionnode.Popup:=ActionType;
      ModuleNode.ChildNodes.Add(Modulenode.OwnerDocument.CreateNode('''Модуль '+ModuleName,ntCData));
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Text='Модули' then
  with TModuleGroupDialog.Create(Application) do
  begin
    If Execute then
    begin
      ModuleGroupNode:=IXMLModulestype(TreeView1.Selected.Data).add;
      ModuleGroupNode.Name:=GroupName;
      if ExecGroup then ModuleGroupNode.Visible:=1 else ModuleGroupNode.Visible:=0;
      //ModuleGroupNode.ChildNodes.Add()
    end;
    UpdateTreeView;
     Free;
     Exit;
  end;
  if TreeView1.Selected.Text='Отчеты(FR)' then
  with TReportDialog.Create(Application) do
  begin
    if Execute then
    begin
      ReportNode:=IXMLReportsType(TreeView1.Selected.Data).Add;
      ReportNode.SQL:=SQLText;
      ReportNode.Name:=RepName;
      Ms:=TMemoryStream.Create;
      SS:=TStringStream.Create('');
      frReport.SaveToStream(Ms);
      Ms.Position:=0;
      EncodeStream(Ms,Ss);
      ReportNode.ChildNodes.Add(ReportNode.OwnerDocument.CreateNode(SS.DataString,ntCData));
      Ms.Free;
      SS.Free;
    end;
    UpdateTreeView;
    Free;
    Exit;
  end;
  if TreeView1.Selected.Text='WEB ресурсы' then
  with TWEBDialog.Create(Application) do
  begin
    if Execute then
    begin
      WEBNode:=IXMLWEBPagesType(TreeView1.Selected.Data).Add;
      WEBNode.Name:=ObjName;
      WEBNode.ChildNodes.Add(WEBNode.OwnerDocument.CreateNode(BASE64RES,ntCData));
    end;
    UpdateTreeView;
    Free;
    Exit;
  end;
end;

procedure TMainForm.Action2Execute(Sender: TObject);
var QueryDialog:TQueryDialog;
    FormDialog:TFormDialog;
    CodeDialog:TCodeForm;
    HTMLDialog:THTMLEdit;
    Ms:TMemoryStream;
    SS:TStringStream;
    FileExt:string;
begin
  if TreeView1.Selected.Parent = nil then Exit;
  if TreeView1.Selected.Parent.Text='Константы' then
  with TConstDialog.Create(Application) do
  begin
    ConstName:=IXMLVariableType(TreeView1.Selected.Data).Name;
    ConstValue:= IXMLVariableType(TreeView1.Selected.Data).Text;
    if Execute then
    begin
      IXMLVariableType(TreeView1.Selected.Data).Name:=ConstName;
      IXMLVariableType(TreeView1.Selected.Data).Text:=ConstValue;
    end;
    UpdateTreeView;
    Free;
    Exit;
  end;
  if TreeView1.Selected.Parent.Text='Поля' then
  with TFieldDialog.Create(Application) do
  begin
    FieldName:=IXMLFieldType(TreeView1.Selected.Data).Display;
    BDField:=IXMLFieldType(TreeView1.Selected.Data).Name;
    ComboBox1.Enabled:=false;
    if Execute then IXMLFieldType(TreeView1.Selected.Data).Display:=FieldName;
    UpdateTreeView;
    
    Free;
    Exit;
  end;
  if TreeView1.Selected.Parent.Text='Стили ячеек' then
  with TStyleDialog.Create(Application) do
  begin
    FontColor:=IXMLMarkType(TreeView1.Selected.Data).Foreground;
    Background:=IXMLMarkType(TreeView1.Selected.Data).Background;
    FontStyle:=IXMLMarkType(TreeView1.Selected.Data).Style;
    Condition:=IXMLMarkType(TreeView1.Selected.Data).Text;
    if Execute then
    begin
      IXMLMarkType(TreeView1.Selected.Data).Foreground:=FontColor;
      IXMLMarkType(TreeView1.Selected.Data).Background:=Background;
      IXMLMarkType(TreeView1.Selected.Data).Style:=FontStyle;
      IXMLMarkType(TreeView1.Selected.Data).Text:=Condition;
    end;
    UpdateTreeView;
    Free;Exit;
  end;
  if TreeView1.Selected.Parent.Text='Выборки' then
  with TSelDialog.Create(Application) do
  begin
     SelName:=IXMLSelectionType(TreeView1.Selected.Data).Name;
     SQL:= IXMLSelectionType(TreeView1.Selected.Data).Text;
     if Execute then
     begin
       IXMLSelectionType(TreeView1.Selected.Data).Name:=SelName;
       IXMLSelectionType(TreeView1.Selected.Data).Text:=SQL;
     end;
     UpdateTreeView;
     Free;Exit;
  end;
  if TreeView1.Selected.Parent.Text='Отчеты(FR)' then
  with TReportDialog.Create(Application) do
  begin
    RepName:=IXMLReportType(TreeView1.Selected.Data).Name;
    SQLText:=IXMLReportType(TreeView1.Selected.Data).SQL;
    Ms:=TMemoryStream.Create;
    SS:=TStringStream.Create(IXMLReportType(TreeView1.Selected.Data).Text);
    SS.Position:=0;
    DecodeStream(SS,Ms);
    Ms.Position:=0;
    frReport.LoadFromStream(Ms);
    Ms.Free;
    Ss.Free;
    if Execute then
    begin
      IXMLReportType(TreeView1.Selected.Data).SQL:=SQLText;
      IXMLReportType(TreeView1.Selected.Data).Name:=RepName;
      Ms:=TMemoryStream.Create;
      SS:=TStringStream.Create('');
      frReport.SaveToStream(Ms);
      Ms.Position:=0;
      EncodeStream(Ms,Ss);
      IXMLReportType(TreeView1.Selected.Data).Text:=SS.DataString;
      Ms.Free;
      SS.Free;
    end;
  end;
  if TreeView1.Selected.Text='Запрос' then
  begin
    QueryDialog:=TQueryDialog.Create(Application);
    QueryDialog.Caption:='Запрос для таблицы: '+IXMLTableType(TreeView1.Selected.Data).Name;
    QueryDialog.CodeMemo.Lines.Text:=IXMLTableType(TreeView1.Selected.Data).Query;
    QueryDialog.XMLTableType:=IXMLTableType(TreeView1.Selected.Data);
    //Query:=IXMLTableType(TreeView1.Selected.Data).Query;
    {if Execute then
    begin
      IXMLTableType(TreeView1.Selected.Data).Query:=Query;
    end; }
  end;
  if TreeView1.Selected.Parent.Text='Формы' then
  begin
     FormDialog:=TFormDialog.Create(Application);
     FormDialog.Caption:='Форма: '+IXMLFormType(TreeView1.Selected.Data).Name+
                        '('+IXMLFormType(TreeView1.Selected.Data).Caption+')';
     FormDialog.LoadFormFromString(IXMLFormType(TreeView1.Selected.Data).Name,
     IXMLFormType(TreeView1.Selected.Data).Text);
     FormDialog.FormCodeDFM:= IXMLFormType(TreeView1.Selected.Data);
  end;
  if TreeView1.Selected.Parent.Text='Действия' then
  begin
    if not FindWindow('Действие: '+TreeView1.Selected.Parent.Parent.Text+'->'+IXMLActionType(TreeView1.Selected.Data).Name) then
    begin
      CodeDialog:=TCodeForm.Create(Application);
      CodeDialog.XMLActionType:=IXMLActionType(TreeView1.Selected.Data);
      CodeDialog.XMLForms:=AppConf_.Forms;
      CodeDialog.XmlTable:=IXMLTableType(TreeView1.Selected.Parent.Parent.Data);
      CodeDialog.TreeView:=TreeView2;
      CodeDialog.Caption:='Действие: '+TreeView1.Selected.Parent.Parent.Text+'->'+IXMLActionType(TreeView1.Selected.Data).Name;
      CodeDialog.CodeMemo.Lines.Text:=IXMLActionType(TreeView1.Selected.Data).Text;
    end else WBFToolWin('Действие: '+TreeView1.Selected.Parent.Parent.Text+'->'+IXMLActionType(TreeView1.Selected.Data).Name);
  end;
  if TreeView1.Selected.Parent.Parent.Text='Модули' then
  begin
    if not FindWindow('Модуль: '+ TreeView1.Selected.Parent.Text + '->' +IXMLModuleType(TreeView1.Selected.Data).Name) then
    begin
      CodeDialog:=TCodeForm.Create(Application);
      CodeDialog.XMLModuleType:=IXMLModuleType(TreeView1.Selected.Data);
      CodeDialog.XMLForms:=AppConf_.Forms;
      CodeDialog.TreeView:=TreeView2;
      CodeDialog.Caption:='Модуль: '+TreeView1.Selected.Parent.Text + '->' +IXMLModuleType(TreeView1.Selected.Data).Name;
      CodeDialog.CodeMemo.Lines.Text:=IXMLModuleType(TreeView1.Selected.Data).Text;
    end else WBFToolWin('Модуль: '+ TreeView1.Selected.Parent.Text + '->' + IXMLModuleType(TreeView1.Selected.Data).Name);
  end;
  if TreeView1.Selected.Parent.Text='WEB ресурсы' then
  begin
    FileExt:=AnsiUpperCase(ExtractFileExt(IXMLWEBPageType(TreeView1.Selected.Data).Name));
    if (FileExt='.HTM') or (FileExt='.HTML') or (FileExt='.JS') or (FileExt='.VB') or (FileExt='.VBS') or (FileExt='.CSS') or (FileExt='.ASP') then
    begin
    if not FindWindow('HTML: '+IXMLWEBPageType(TreeView1.Selected.Data).Name) then
    begin
      HTMLDialog:=THTMLEdit.Create(Application);
      HTMLDialog.HTMLObj:=IXMLWEBPageType(TreeView1.Selected.Data);
      HTMLDialog.Caption:='HTML: '+IXMLWEBPageType(TreeView1.Selected.Data).Name;
    end else WBFToolWin('HTML: '+IXMLWEBPageType(TreeView1.Selected.Data).Name);
    end else ShowMessage('Система не редактирует данный формат объектов');
  end;
end;

procedure TMainForm.Action3Execute(Sender: TObject);
var inode:IXMLNode;
    parentnode:IXMLNode;
begin
  if Assigned(TreeView1.Selected) then
  begin
    if (TreeView1.Selected.Text <> 'Константы') or
     (TreeView1.Selected.Text <> 'Таблицы') or
     (TreeView1.Selected.Text <> 'Поля') or
     (TreeView1.Selected.Text <> 'Стили ячеек') or
     (TreeView1.Selected.Text <> 'Действия') or
     (TreeView1.Selected.Text <> 'Выборки') or
     (TreeView1.Selected.Text <> 'Формы') or
     (TreeView1.Selected.Text <> 'Модули') or
     (TreeView1.Selected.Text = 'Отчеты(FR)') or
     (TreeView1.Selected.Text = 'WEB ресуры')
      then
      begin
        if MessageDlg('Вы хотите удалить узел: '+#10#13+TreeView1.Selected.Text, mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          inode:=IXMLNode(TreeView1.Selected.Data);
          ParentNode:=inode.ParentNode;
          ParentNode.DOMNode.removeChild(inode.DOMNode);
          AppConf_.Resync;
          UpdateTreeView;
          //TreeView1.Selected.Delete;
        end;
      end;
  end;
end;

procedure TMainForm.Action4Execute(Sender: TObject);
var  WebForm:TBrowserForm;
     //fContainer: TExternalContainer;
begin
 if TreeView1.Selected.Parent.Text='Таблицы' then
   ShowTableWindow(IXMLTableType(TreeView1.Selected.Data),'');
 if TreeView1.Selected.Parent.Text='WEB ресурсы' then 
 begin
     WebForm:=TBrowserForm.Create(Application);
     WebForm.OnClose:=DM.FormClose;
     WebForm.Show;
     {fContainer := }TExternalContainer.Create(WebForm.WB);
     WebForm.WB.Navigate('conf://'+IXMLWEBPageType(TreeView1.Selected.Data).Name);
 end;
end;

procedure TMainForm.Action5Execute(Sender: TObject);
var SQLDialog:TSQLDialog;
begin
  SQLDialog:=TSQLDialog.Create(Application);
  SQLDialog.Show;
end;

procedure TMainForm.Action6Execute(Sender: TObject);
var actionnode:IXMLActionType;
begin
  if TreeView1.Selected.Parent.Text='Действия' then
  with TAddActionDialog.Create(application) do
  begin
    actionnode:=IXMLActionType(TreeView1.Selected.Data);
    ActionName:=actionnode.Name;
    ActionType:=actionnode.Popup;
    ImageIndex:=actionnode.Imageindex;
    ShortCut:=actionnode.ShortCut;
    if Execute then
    begin
      actionnode:=IXMLActionType(TreeView1.Selected.Data);
      actionnode.Name:=ActionName;
      actionnode.Popup:=ActionType;
      actionnode.Imageindex:=ImageIndex;
      actionnode.ShortCut:=ShortCut;
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Parent.Parent.Text='Модули' then
  with TModuleDialog.Create(application) do
  begin
    ModuleName:=IXMLModuleType(TreeView1.Selected.Data).Name;
    MType:=IXMLModuleType(TreeView1.Selected.Data).MType;
    if Execute then
    begin
      IXMLModuleType(TreeView1.Selected.Data).Name:=ModuleName;
      IXMLModuleType(TreeView1.Selected.Data).MType:=MType;
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
  if TreeView1.Selected.Parent.Text='Модули' then
  with TModuleGroupDialog.Create(application) do
  begin
    groupName:=IXMLModulegroupType(TreeView1.Selected.Data).Name;
    ExecGroup:=(IXMLModulegroupType(TreeView1.Selected.Data).Visible=1);
    if Execute then
    begin
      IXMLModuleGroupType(TreeView1.Selected.Data).Name:=groupName;
      if ExecGroup then IXMLModuleGroupType(TreeView1.Selected.Data).Visible:=1
      else IXMLModuleGroupType(TreeView1.Selected.Data).Visible:=0;
    end;
    UpdateTreeView;
     Free;
     exit;
  end;
end;

procedure TMainForm.Action7Execute(Sender: TObject);
var AddonsForm:TAddOnsEditor;
begin
  AddonsForm:=TAddOnsEditor.Create(Application);
  AddonsForm.Show;
end;

procedure TMainForm.Action8Execute(Sender: TObject);
var ObjBows:TOjBrowForm;
begin
  ObjBows:=TOjBrowForm.Create(Application);
  ObjBows.Show;
end;

procedure TMainForm.CloseAllChild;
var i:integer;
begin
  for i := MainForm.MDIChildCount - 1 downto 0 do
  begin
    MainForm.MDIChildren[i].Close;
    MainForm.MDIChildren[i].Free;
  end;
end;




procedure TMainForm.FileNew1Execute(Sender: TObject);
var SList:TStringList;
    i,j:integer;
    inode:TTreeNode;
    FT:TFieldType;
begin
  AppConf_:=Newconfiguration;
  with TConfigDialog.Create(Application) do
  begin
    if Execute then
    begin
       AppConf_.Linkto:=LinkTo;
       AppConf_.AppName:=AppName;
       DM.OpenDB(AppConf_.Linkto);
       SList:=TStringList.Create;
       TreeView2.Items.Clear;
       DM.ADOConnection1.GetTableNames(SList);
       for i := 0 to SList.Count - 1 do
        begin
          inode:=TreeView2.Items.AddChild(nil,SList[i]);
          with inode do
          begin
            ImageIndex:=16;
            SelectedIndex:=16;
            DM.ADOTable1.Close;
            DM.ADOTable1.TableName:=SList[i];
            DM.ADOTable1.Open;
            for j := 0 to DM.ADOTable1.FieldCount - 1 do
            begin
              FT:=DM.ADOTable1.FieldDefList.FieldDefs[j].DataType;
              With TreeView2.Items.AddChildObject(inode,DM.ADOTable1.Fields[j].DisplayName+': '+GetEnumName(TypeInfo(TFieldType), Ord(FT)),
                                                  Pointer(Ord(DM.ADOTable1.FieldDefList.FieldDefs[j].DataType))) do
              begin
                ImageIndex:=15;
                SelectedIndex:=15;
              end;
            end;
          end;
        end;
    end;
    Free;
  end;
  MainForm.Caption:=AppConf_.AppName;
  UpdateTreeView;
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    Filter:='Файлы XML|*.xml|Все файлы|*.*';
    if Execute and (Filename<>'') then
    begin
       OpenConfFile(Filename);
    end;
    Free;
  end;
end;

procedure TMainForm.FileSave1Execute(Sender: TObject);
var ZStream: TCompressionStream;
    MStream: TMemoryStream;
    FStream: TFileStream;
    zFile:String;
begin
   CloseAllChild;
  if FFileName<>'' then
  begin
    AppConf_.OwnerDocument.SaveToFile(FFileName);
    zFile:=ExtractFilePath(FFileName)+'version';
    if not DirectoryExists(zFile) then CreateDir(zFile);
    zFile:=zFile+'\'+ExtractFileName(FFileName)+FormatDateTime('ddmmyyyyhhnnss',Now)+'.zpak';
    MStream := TMemoryStream.Create;
    AppConf_.OwnerDocument.SaveToStream(MStream);
    MStream.Position:=0;
    FStream:= TFileStream.Create(zFile,fmCreate);
    ZStream:= TCompressionStream.Create(clDefault, FStream);
    ZStream.CopyFrom(MStream,MStream.Size);
    ZStream.Free;
    MStream.Free;
    FStream.Free;
  end
  else
  with TSaveDialog.Create(Application) do
  begin
    Filter:='XML|*.xml|All files|*.*';
    if Execute and (FileName<>'') then
      AppConf_.OwnerDocument.SaveToFile(FileName);
      zFile:=ExtractFilePath(FileName)+'version';
      if not DirectoryExists(zFile) then CreateDir(zFile);
      zFile:=zFile+'\'+ExtractFileName(FileName)+FormatDateTime('ddmmyyyyhhnnss',Date)+'.zpak';
      MStream := TMemoryStream.Create;
      AppConf_.OwnerDocument.SaveToStream(MStream);
      MStream.Position:=0;
      FStream:= TFileStream.Create(zFile,fmCreate);
      ZStream:= TCompressionStream.Create(clDefault, FStream);
      ZStream.CopyFrom(MStream,MStream.Size);
      ZStream.Free;
      MStream.Free;
      FStream.Free;
    Free;
  end;
  FCanSave:=false;
end;

procedure TMainForm.FileSaveAs1Execute(Sender: TObject);
var ZStream: TCompressionStream;
    MStream: TMemoryStream;
    FStream: TFileStream;
begin
  CloseAllChild;
  with TSaveDialog.Create(Application) do
  begin
    FileName:=FFileName;
    Filter:='XML|*.xml|All files|*.*';
    if Execute and (FileName<>'') then
    begin
      AppConf_.OwnerDocument.SaveToFile(FileName);
      MStream := TMemoryStream.Create;
      AppConf_.OwnerDocument.SaveToStream(MStream);
      MStream.Position:=0;
      FStream:= TFileStream.Create(filename+'.zpak',fmCreate);
      ZStream:= TCompressionStream.Create(clDefault, FStream);
      ZStream.CopyFrom(MStream,MStream.Size);
      ZStream.Free;
      MStream.Free;
      FStream.Free;
      FFileName:=FileName;
      MainForm.Caption:='Конфигуратор ('+FileName+')';
    end;
      Free;
  end;
end;

function TMainForm.FindWindow(Value: string): boolean;
var i:integer;
begin
  Result:=false;
  for i := 0 to MainForm.MDIChildCount - 1 do
    if MainForm.MDIChildren[i].Caption = Value then Result:=true;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var MsgStatus:Integer;
begin
  Action := caNone;
  //MsgStatus:=mrCancel;
  if AppConf_=nil then Application.Terminate;
  ExecuteScript('Application','Close');
  if isEditing then
  begin
    if (FFileName<>'') and FCanSave then
    begin
      MsgStatus:=MessageDlg('Вы хотите сохранить файл: '+#10#13+FFileName+'?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
      if MsgStatus = mrYes then
      begin
        CloseAllChild;
        AppConf_.OwnerDocument.SaveToFile(FFileName);
      end;
    end else
    begin
      MsgStatus:=MessageDlg('Вы хотите закрыть приложение?',mtConfirmation,[mbYes,mbCancel],0);
    end;
    if MsgStatus<>mrCancel then Application.Terminate;
  end else Application.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFileName := '';
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  inherited;
  isEditing:=true;
  FCanSave:=false;
  if (ParamCount = 0) and FileExists('defaultconf.xml') then
  OpenConfFile('defaultconf.xml');
  
  if ParamCount>0 then  OpenConfFile(ParamStr(1));
  if ParamCount>1 then 
  begin
    isEditing:=false;
    StatusBar.Panels[2].Text:='Запрет изменения параметров'
  end else StatusBar.Panels[2].Text:='Режим изменения параметров';
  PageControl1.ActivePage:=TabSheet3;
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;



procedure TMainForm.Label1Click(Sender: TObject);
begin
 ShowTableWindow(IXMLTableType(TLabel(sender).Tag),'');
end;

procedure TMainForm.Label1MouseEnter(Sender: TObject);
begin
  TLabel(sender).Font.Style:=TLabel(sender).Font.Style + [fsUnderline];
end;

procedure TMainForm.Label1MouseLeave(Sender: TObject);
begin
 TLabel(sender).Font.Style:=TLabel(sender).Font.Style - [fsUnderline];
end;

procedure TMainForm.Label2Click(Sender: TObject);
begin
  DM.ExecuteScript(IXMLModuleType(Pointer(TLabel(Sender).tag)).Text);
end;


procedure TMainForm.OpenConfFile(Filename: String);
var SList:TStringList;
    i,j:integer;
    inode:TTreeNode;
    FT:TFieldType;
    MStream: TMemoryStream;
    FStream: TFileStream;
    tableItem: IXMLClassType;
    appitem: IXMLClassType;
    FormBuf1,FormBuf2:TStringList;
    dbFile: string;

Procedure DecompressStream(Const SrcStream,DstStream : TStream);
Var
    DecompressionStream : TDecompressionStream;
    Buffer              : Array[0..4095] Of Char;
    BytesProcessed      : LongInt;
Begin
    SrcStream.Seek(0,soFromBeginning);
    DstStream.Seek(0,soFromBeginning);
    DecompressionStream := TDecompressionStream.Create(SrcStream);
    Try
        Repeat
            BytesProcessed :=DecompressionStream.Read(Buffer,SizeOf(Buffer));
            If BytesProcessed <> 0 Then DstStream.Write(Buffer,BytesProcessed);
        Until BytesProcessed = 0;
    Finally
        DecompressionStream.Free;
    End;
End;

begin
       CloseAllChild;
       if AnsiUpperCase(ExtractFileExt(FileName))='.XML' then
          AppConf_:=LoadConfiguration(filename)
       else
       begin
         FStream:=TFileStream.Create(filename, fmOpenRead);
         FStream.Position:=0;
         MStream:=TMemoryStream.Create;
         DecompressStream(FStream, MStream);
         MStream.Position:=0;
         XMLDocument1.LoadFromStream(MStream);
         AppConf_:=Getconfiguration(XMLDocument1.DocumentElement.OwnerDocument);
         MStream.Free;
         FStream.Free;
       end;
       if AppConf_.AppName<>'' then
       MainForm.Caption:=AppConf_.AppName;
       if AppConf_.Linkto<>'' then
       begin
       dbFile := AppConf_.Linkto;
       if Pos('.\',dbFile)=1 then dbFile := AnsiReplaceStr(dbFile,'.\',ExtractFilePath(Paramstr(0)));
       Memo1.Lines.Add(dbFile);
       If FileExists(dbFile) then
       begin
         DM.OpenDB(dbFile);
       end
       else
       begin
         OpenDialog.Filter := 'Access files(*.mdb)|*.mdb';
         If OpenDialog.Execute and (OpenDialog.FileName<>'') then
         AppConf_.Linkto := OpenDialog.FileName;
         DM.OpenDB(AppConf_.Linkto);
       end;
       SList:=TStringList.Create;
       TreeView2.Items.Clear;
       DM.ADOConnection1.GetTableNames(SList);
       for i := 0 to SList.Count - 1 do
        begin
          inode:=TreeView2.Items.AddChild(nil,SList[i]);
          if Assigned(AppObjects_) then
          begin
            tableitem:=AppObjects_.Add;
            tableitem.Name:=SList[i];
            CopyXmlNode('DBTable',tableitem);
          end;
          with inode do
          begin
            ImageIndex:=16;
            SelectedIndex:=16;
            DM.ADOTable1.Close;
            DM.ADOTable1.TableName:=SList[i];
            DM.ADOTable1.Open;
            for j := 0 to DM.ADOTable1.FieldCount - 1 do
            begin
              FT:=DM.ADOTable1.FieldDefList.FieldDefs[j].DataType;
              With TreeView2.Items.AddChildObject(inode,DM.ADOTable1.Fields[j].DisplayName+': '+GetEnumName(TypeInfo(TFieldType), Ord(FT)),
                                                  Pointer(Ord(DM.ADOTable1.FieldDefList.FieldDefs[j].Size))) do
              begin
                ImageIndex:=15;
                SelectedIndex:=15;
              end;
              if Assigned(AppObjects_) then
              with tableitem.Add do
              begin
                Type_:='property';
                Name:=DM.ADOTable1.Fields[j].DisplayName;
                Returnvalue:=GetEnumName(TypeInfo(TFieldType), Ord(FT));
                Text:='Поле таблицы '+ tableitem.Name + ' название: ' + DM.ADOTable1.Fields[j].DisplayName+ ' тип поля: '+ Returnvalue +#13+ 'Назначение: '+DisplayLabel(Name);
              end;
            end;
          end;
        end;
       end;
       //MainForm.Caption:='Конфигуратор ('+FileName+')';
       StatusBar.Panels[1].Text:=FileName;
       FFileName:=FileName;
       UpdateTreeView;
       ExecuteScript('Application','Activate');
       if Assigned(AppObjects_) then
       begin
         for i := 0 to AppConf_.Tables.Count - 1 do
         begin
           tableitem:=AppObjects_.Add;
           tableitem.Name:='LinkTo("'+AppConf_.Tables.Table[i].Name+'")';
           CopyXmlNode('Table',tableitem);
           for j := 0 to AppConf_.Tables.Table[i].Fields.Count - 1 do
           begin
             with tableitem.Add do
             begin
               Type_:='property';
               Name:=AppConf_.Tables.Table[i].Fields.Field[j].Name;
               Returnvalue:='Variant';
               Text:=AppConf_.Tables.Table[i].Fields.Field[j].Display;
             end;
             with tableitem.Add do
             begin
               Type_:='property';
               Name:='['+AppConf_.Tables.Table[i].Fields.Field[j].Display+']';
               Returnvalue:='Variant';
               Text:=AppConf_.Tables.Table[i].Fields.Field[j].Display;
             end;
           end;
         end;
         for i := 0 to AppConf_.Forms.Count - 1 do
         begin
           tableitem:=AppObjects_.Add;
           tableitem.Name:='Form("'+AppConf_.Forms.Form[i].Name+'")';
           CopyXmlNode('Form',tableitem);
           FormBuf1 := TStringList.Create;
           FormBuf2 := TStringList.Create;
           FormBuf1.Text:=AppConf_.Forms.Form[i].Text;
           for j := 0 to FormBuf1.Count - 1 do
           begin
            if (pos('object',FormBuf1[j])<>0) and
               (pos('TForm',FormBuf1[j])=0)
               then
            begin
             FormBuf2.Add(
                 AnsiReplaceStr(
                   AnsiReplaceStr(
                      Trim(
                        AnsiReplaceStr(FormBuf1[j],'object ','')
                      ),':','=')
                   ,' ','')
                 );
            end;
           end;
           for j := 0 to FormBuf2.Count - 1 do
           with tableitem.Add do
           begin
             Type_:='property';
             Name:=FormBuf2.Names[j];
             ReturnValue:=FormBuf2.Values[FormBuf2.Names[j]];
             Text:='Компонент на форме '+FormBuf2.Names[j]+': '+FormBuf2.Values[FormBuf2.Names[j]];
           end;
           FormBuf1.Free;
           FormBuf2.Free;

         end;
         for i := 0 to AppObjects_.Count - 1 do
           if AppObjects_.Class_[i].Name='App' then appitem:=AppObjects_.Class_[i];
         for i := 0 to AppConf_.Variables.Count - 1 do
         with appitem.Add do
         begin
           Type_:='constant';
           Name:='['+AppConf_.Variables.Variable[i].Name+']';
           Returnvalue:='String';
           Text:='Объект переменная приложения';
         end;
         for i := 0 to AppConf_.Modules.Count - 1 do
         with appitem.Add do
         begin
           Type_:='constant';
           Name:='['+AppConf_.Modules.Modulegroup[i].Name+']';
           Returnvalue:='String';
           Text:='Объект группа модулей приложения';
         end;
         for i := 0 to AppConf_.Forms.Count - 1 do
         with appitem.Add do
         begin
           Type_:='property';
           Name:=AppConf_.Forms.Form[i].Name;
           Returnvalue:='FormObj';
           Text:='Объект форма, заголовок: '+AppConf_.Forms.Form[i].Caption;
         end;
         for i := 0 to AppConf_.Tables.Count - 1 do
         with appitem.Add do
         begin
           Type_:='property';
           Name:='['+AppConf_.Tables.Table[i].Name+']';
           Returnvalue:='TableObj';
           Text:='Объект таблица';
         end;
       end;
       
end;

procedure TMainForm.PageControl1Change(Sender: TObject);
begin
  if ((Sender as TPageControl).ActivePage=TabSheet1) then FCanSave:=true;
end;

procedure TMainForm.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if ((Sender as TPageControl).ActivePage=TabSheet3) and not isEditing then
  AllowChange:=false;
end;

procedure TMainForm.setNodeImage(node: TTreeNode; imageIndex: integer);
begin
  node.ImageIndex:=imageIndex;
  node.SelectedIndex:=imageIndex;
end;

function TMainForm.ShowTableWindow(tableNode: IXMLTableType; Filter:string):TTestDialog;
var i, fpos :integer;
    TMI:TMenuItem;
    TMB:TToolButton;
    TestDialog: TTestDialog;
    crit,Field_,Value_:string;
    FilterName, FilterValue: String;
begin
fpos := Pos('|', Filter);
if fpos<>0 then
begin
  FilterName := Copy(Filter,1,fpos-1);
  FilterValue := Copy(Filter,fpos+1,length(Filter)-fpos);
end;

if FindWindow(tablenode.Name) and (Filter<>'') Then
begin
  TTestDialog(WBF(tableNode.Name, Filter)).Close;
end;

if not FindWindow(tablenode.Name) then
 begin
 TestDialog := TTestDialog.Create(Application);
 TestDialog.IXMLTable:= tableNode;
 TestDialog.Caption:=tableNode.Name;
 TestDialog.Grid_Frame1.ADOQuery.Close;
 TestDialog.Grid_Frame1.ADOQuery.Connection:=DM.ADOConnection1;
 //TestDialog.Grid_Frame1.CellStyles.Clear;
 for i := 0 to tableNode.Fields.Count - 1 do
    TestDialog.Grid_Frame1.DbGrid.AddLabel(tableNode.Fields.Field[i].Name,
                                            tableNode.Fields.Field[i].Display,10);

 for i := 0 to tableNode.Markings.Count-1 do
 begin
    with TestDialog.Grid_Frame1.DBGrid.CellStyles.Add do
    begin
      Font.Color:=tableNode.Markings.Mark[i].Foreground;
      Color:=tableNode.Markings.Mark[i].Background;
      if Pos('Bold', tableNode.Markings.Mark[i].Style)<>0 then Font.Style := Font.Style+ [fsBold];
      if Pos('Italic', tableNode.Markings.Mark[i].Style)<>0 then Font.Style := Font.Style+ [fsItalic];
      if Pos('Underline', tableNode.Markings.Mark[i].Style)<>0 then Font.Style := Font.Style+ [fsUnderline];
      if Pos('StrikeOut', tableNode.Markings.Mark[i].Style)<>0 then Font.Style := Font.Style+ [fsStrikeOut];
      FieldValue:=tableNode.Markings.Mark[i].Text;
      if Pos('#',FieldValue)=1 then
      begin
        SingleCell := true;
        ImageOnly := false;
      end;
      FieldValue:=AnsiReplaceStr(tableNode.Markings.Mark[i].Text,'#','');
      crit:='';
      if Pos('<',FieldValue)<>0 then crit:=crit+'<';
      if Pos('>',FieldValue)<>0 then crit:=crit+'>';
      if Pos('=',FieldValue)<>0 then crit:=crit+'=';
      if crit='' then
      begin
        if Pos('is null', FieldValue)<>0 then
        begin
         crit:='=';
         Value_:='null';
        end;
        if Pos('not null', FieldValue)<>0 then
        begin
          crit:='<>';
          Value_:='null'
        end;
        if Pos('like',FieldValue)<>0 then crit:='like';
       end;
      Field_:=Copy(FieldValue,1,Pos(crit,FieldValue)-1);
      Value_:=Copy(FieldValue,Length(Field_)+Length(crit)+1,Length(FieldValue)-Length(Field_)-Length(crit));
      if Value_='now()' then Value_:=FormatDateTime('dd.mm.yyyy',Date());
      if crit='like' then Value_:=trim(Value_);
      Field_:=Trim(Field_);
      FieldName:=Field_;
      Operand:=crit;
      FieldValue:=Value_;
    end;
 end;
 if tableNode.Selections.Count = 0 then
 begin
   with tableNode.Selections.Add do
   begin
     Name := 'Все записи';
     Text := '(0=0)';
   end;
 end;



 TestDialog.Grid_Frame1.Query:=tableNode.Query + ' where (1=1)';
 TestDialog.Grid_Frame1.DBGrid.DefaultFilter:= tableNode.Selections.Selection[0].Text;

 for i := 0 to tableNode.Selections.Count - 1 do
 begin
   TestDialog.Grid_Frame1.TabSet1.Tabs.AddObject(tableNode.Selections.Selection[i].Name,Pointer(tableNode.Selections.Selection[i]))
 end;

 TestDialog.Grid_Frame1.TabSet1.TabIndex:=0;
 if fpos<>0 then TestDialog.Grid_Frame1.DBGrid.ColumnByFieldName(FilterName).Filter:=FilterValue;
 TestDialog.Grid_Frame1.DBGrid.SetFilter;

 TestDialog.PopupMenu1.Items.Clear;
 for i := TestDialog.ToolBar1.ButtonCount - 1 downto 0 do
   TestDialog.ToolBar1.Buttons[i].Free;
 for i := tableNode.Actions.Count - 1 downto 0  do
 begin
   if tableNode.Actions.Action[i].Popup<>'YES' then
   Begin
     TMB:=TToolButton.Create(TestDialog.ToolBar1);
     TMB.Parent:=TestDialog.ToolBar1;
     TMB.Caption:=tableNode.Actions.Action[i].Name;
     if TMB.Caption='Добавить' then TMB.ImageIndex:=0
     else
     if TMB.Caption='Изменить' then TMB.ImageIndex:=1
     else
     if TMB.Caption='Удалить' then TMB.ImageIndex:=2
     else
     begin
      TMB.ImageIndex:=tableNode.Actions.Action[i].Imageindex;
     end;
     TMB.Tag:=i;
     TMB.AutoSize:=true;
     TMB.OnClick:=TestDialog.MenuItemClick;
   End;
   if tableNode.Actions.Action[i].Popup<>'NO' then
   begin
     TMI:=TMenuItem.Create(TestDialog.PopupMenu1);
     TMI.Caption:=tableNode.Actions.Action[i].Name;
     TMI.Tag:=i;
     TMI.ImageIndex:=tableNode.Actions.Action[i].Imageindex;
     TMI.ShortCut:=tableNode.Actions.Action[i].ShortCut;
     TMI.OnClick:=TestDialog.MenuItemClick;
     TestDialog.PopUpMenu1.Items.Add(TMI);
   end;
 end;
 TestDialog.Grid_Frame1.DBPopUpMenu:=TestDialog.PopupMenu1;
 TestDialog.Show;
 Result:=TestDialog;
 end else
 begin
   TestDialog:=TTestDialog(WBF(tableNode.Name, Filter));
   if fpos<>0 then
   Begin
     TestDialog.Grid_Frame1.DBGrid.ColumnByFieldName(FilterName).Filter:=FilterValue;
     TestDialog.Grid_Frame1.DBGrid.SetFilter;
   End;
   Result:=TestDialog;
 end;
end;

procedure TMainForm.ToolButton14Click(Sender: TObject);
var WebForm:TBrowserForm;
begin
  WebForm:=TBrowserForm.Create(Application);
  WebForm.OnClose:=DM.FormClose;
  WebForm.Show;
end;

procedure TMainForm.ToolButton16Click(Sender: TObject);
begin
  Dm.TerminateScript;
end;

procedure TMainForm.TreeView1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  N8.Visible:=false;
  if (TTreeView(sender).Selected<>nil) and (TTreeView(sender).Selected.Parent<>nil) then
  begin
    if (TTreeView(sender).Selected.Text = 'Константы') or
       (TTreeView(sender).Selected.Text = 'Таблицы') or
       (TTreeView(sender).Selected.Text = 'Поля') or
       (TTreeView(sender).Selected.Text = 'Стили ячеек') or
       (TTreeView(sender).Selected.Text = 'Действия') or
       (TTreeView(sender).Selected.Text = 'Выборки') or
       (TTreeView(sender).Selected.Text = 'Формы') or
       (TTreeView(sender).Selected.Text = 'Модули') or
       (TTreeView(sender).Selected.Text = 'Отчеты(FR)') or
       (TTreeView(sender).Selected.Text = 'WEB ресурсы')
    then
      TTreeView(sender).PopupMenu:=PopUpMenu1
    else
      TTreeView(sender).PopupMenu:=PopUpMenu2;
    if (TTreeView(sender).Selected.Parent.Text <> 'Таблицы') and
       (TTreeView(sender).Selected.Parent.Text <> 'WEB ресурсы')
    then
      N5.Visible:=false
    else
      N5.Visible:=true;
    if TTreeView(sender).Selected.Parent.Text = 'Модули' then N8.Visible:=true;
    if (TTreeView(sender).Selected.Parent.Text <> 'Действия') and (TTreeView(sender).Selected.Parent.Text <> 'Модули')
    then
      N6.Visible:=false
    else
      N6.Visible:=true;
  end;
  if TTreeView(sender).Selected.Text = 'Конфигурация' then  TTreeView(sender).PopupMenu:=nil;
end;

procedure TMainForm.TreeView1DblClick(Sender: TObject);
begin
  if TTreeView(sender).Selected.Text = 'Конфигурация' then
  begin
    with TConfigDialog.Create(Application) do
    begin
      LinkTo:=AppConf_.Linkto;
      AppName:=AppConf_.AppName;
      if Execute then
      begin
        AppConf_.Linkto:=LinkTo;
        AppConf_.AppName:=AppName;
      end;
      Free;
    end;
    Exit;
  end;
  if TTreeView(sender).Selected.Parent.Text <> 'Таблицы' then
    Action2Execute(Sender)
  else Action4Execute(Sender);
end;

procedure TMainForm.TreeView2DblClick(Sender: TObject);
begin
  if MainForm.ActiveMDIChild is TCodeForm then
  begin
    if TreeView2.Selected<>nil then TCodeForm(MainForm.ActiveMDIChild).CodeMemo.SelText:=Copy(TreeView2.Selected.Text,1,Pos(':',TreeView2.Selected.Text)-1);
  end;
end;

procedure TMainForm.UpdateTreeView;
var confnode,
    constnode,
    tablenode,
    formnode,
    modulenode,
    reportnode,
    tnode1,
    tnode2,
    tnode3, WEBPagenode :TTreeNode;
    i,j:integer;
    SaveList:TStringList;
begin
  ///
  for i := WorkPanel.ControlCount - 1 downto 0 do
  begin
    if (WorkPanel.Controls[i] is TLabel) or (WorkPanel.Controls[i] is TPanel) then WorkPanel.Controls[i].Free;
  end;
  ///
  SaveList:=TStringList.Create;
  for i := 0 to TreeView1.Items.Count - 1 do
    if TreeView1.Items[i].Expanded then SaveList.AddObject(TreeView1.Items[i].Text,TreeView1.Items[i].Data);
  TreeView1.Items.Clear;
  confnode:=TreeView1.Items.AddChildObjectFirst(nil,'Конфигурация',Pointer(AppConf_));
  setNodeImage(confnode,1);
  constnode:=TreeView1.Items.AddChildObject(confnode, 'Константы', Pointer(AppConf_.Variables));
  setNodeImage(constnode,11);
  for i := 0 to AppConf_.Variables.Count-1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(constnode,AppConf_.Variables.Variable[i].Name,Pointer(AppConf_.Variables.Variable[i]));
    if Copy(AppConf_.Variables.Variable[i].Text,1,2)='Qk' then setNodeImage(tnode1,21)
    else setNodeImage(tnode1,12);
    if (AnsiUpperCase(Copy(AppConf_.Variables.Variable[i].Text,1,6))='SELECT') or
       (AnsiUpperCase(Copy(AppConf_.Variables.Variable[i].Text,1,6))='DELETE') or
       (AnsiUpperCase(Copy(AppConf_.Variables.Variable[i].Text,1,6))='UPDATE') then
    setNodeImage(tnode1,22);
    if Pos('<HTML>',AnsiUpperCase(AppConf_.Variables.Variable[i].Text))<>0 then setNodeImage(tnode1,24);

  end;
  formnode:=TreeView1.Items.AddChildObject(confnode, 'Формы', Pointer(AppConf_.Forms));
  setNodeImage(formnode,7);
  for i := 0 to AppConf_.Forms.Count-1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(formnode,AppConf_.Forms.Form[i].Name+'('+
                                           AppConf_.Forms.Form[i].Caption+')',Pointer(AppConf_.Forms.Form[i]));
    setNodeImage(tnode1,8);
  end;
  modulenode:=TreeView1.Items.AddChildObject(confnode, 'Модули', Pointer(AppConf_.Modules));
  setNodeImage(modulenode,3);
  for i := 0 to AppConf_.Modules.Count - 1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(modulenode,AppConf_.Modules.Modulegroup[i].Name,Pointer(AppConf_.Modules.Modulegroup[i]));
    setNodeImage(tnode1,13);
    for j := 0 to AppConf_.Modules.Modulegroup[i].Count - 1 do
    tnode2:=TreeView1.Items.AddChildObject(tnode1,AppConf_.Modules.Modulegroup[i].module[j].Name,Pointer(AppConf_.Modules.Modulegroup[i].Module[j]));
    setNodeImage(tnode2,0);
  end;
  reportnode:=TreeView1.Items.AddChildObject(confnode, 'Отчеты(FR)', Pointer(AppConf_.Reports));
  setNodeImage(reportnode,23);
   for i := 0 to AppConf_.Reports.Count - 1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(reportnode,AppConf_.Reports.Report[i].Name,Pointer(AppConf_.Reports.Report[i]));
    setNodeImage(tnode1,23);
  end;
  WEBPagenode:=TreeView1.Items.AddChildObject(confnode, 'WEB ресурсы', Pointer(AppConf_.WEBPages));
  setNodeImage(WEBPagenode,25);
   for i := 0 to AppConf_.WEBPages.Count - 1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(WEBPagenode,AppConf_.WEBPages.WEBPage[i].Name,Pointer(AppConf_.WEBPages.WEBPage[i]));
    setNodeImage(tnode1,24);
    if (AnsiUpperCase(ExtractFileExt(AppConf_.WEBPages.WEBPage[i].Name))='.JPG') or
       (AnsiUpperCase(ExtractFileExt(AppConf_.WEBPages.WEBPage[i].Name))='.PNG') or
       (AnsiUpperCase(ExtractFileExt(AppConf_.WEBPages.WEBPage[i].Name))='.GIF') or
       (AnsiUpperCase(ExtractFileExt(AppConf_.WEBPages.WEBPage[i].Name))='.BMP') then
    setNodeImage(tnode1,21);
  end; 
  tablenode:=TreeView1.Items.AddChildObject(confnode, 'Таблицы', Pointer(AppConf_.Tables));
  setNodeImage(tablenode,13);
  for i := 0 to AppConf_.Tables.Count-1 do
  begin
    tnode1:=TreeView1.Items.AddChildObject(tablenode,AppConf_.Tables.Table[i].Name,Pointer(AppConf_.Tables.Table[i]));
    setNodeImage(tnode1,16);
    tnode2:=TreeView1.Items.AddChildObject(tnode1,'Запрос',Pointer(AppConf_.Tables.Table[i]));
    setNodeImage(tnode2,18);
    tnode2:=TreeView1.Items.AddChildObject(tnode1,'Поля',Pointer(AppConf_.Tables.Table[i].Fields));
    setNodeImage(tnode2,14);
    for j := 0 to AppConf_.Tables.Table[i].Fields.Count - 1  do
    begin
      tnode3:= TreeView1.Items.AddChildObject(tnode2,AppConf_.Tables.Table[i].Fields.Field[j].Display+'('+AppConf_.Tables.Table[i].Fields.Field[j].Name+')',Pointer(AppConf_.Tables.Table[i].Fields.Field[j]));
      setNodeImage(tnode3,15);
    end;
    tnode2:=TreeView1.Items.AddChildObject(tnode1,'Выборки',Pointer(AppConf_.Tables.Table[i].Selections));
    setNodeImage(tnode2,6);
    for j := 0 to AppConf_.Tables.Table[i].Selections.Count - 1  do
    begin
      tnode3:= TreeView1.Items.AddChildObject(tnode2,AppConf_.Tables.Table[i].Selections.Selection[j].Name,Pointer(AppConf_.Tables.Table[i].Selections.Selection[j]));
      setNodeImage(tnode3,19);
    end;
    tnode2:=TreeView1.Items.AddChildObject(tnode1,'Стили ячеек',Pointer(AppConf_.Tables.Table[i].Markings));
    setNodeImage(tnode2,9);
    for j := 0 to AppConf_.Tables.Table[i].Markings.Count - 1  do
    begin
      tnode3:= TreeView1.Items.AddChildObject(tnode2,AppConf_.Tables.Table[i].Markings.Mark[j].Text,Pointer(AppConf_.Tables.Table[i].Markings.Mark[j]));
      setNodeImage(tnode3,10);
    end;
    tnode2:=TreeView1.Items.AddChildObject(tnode1,'Действия',Pointer(AppConf_.Tables.Table[i].Actions));
    setNodeImage(tnode2,1);
    for j := 0 to AppConf_.Tables.Table[i].Actions.Count - 1  do
    begin
      tnode3:= TreeView1.Items.AddChildObject(tnode2,AppConf_.Tables.Table[i].Actions.Action[j].Name,Pointer(AppConf_.Tables.Table[i].Actions.Action[j]));
      setNodeImage(tnode3,3);
    end;
  end;
  UpdateWorkPanel;
  //TreeView1.FullExpand;
  for i := TreeView1.Items.Count - 1 downto 0 do
    for j := 0 to SaveList.Count - 1 do
      begin
        if TreeView1.Items[i].Data=Pointer(SaveList.Objects[j]) then
           TreeView1.Items[i].Expand(false); 
      end;
   SaveList.Free; 
end;

procedure TMainForm.UpdateWorkPanel;
var i,j, k:integer;
    Lb1:TLabel;

procedure repHeader(top: integer; caption: string);
var Pb1: TPanel;
begin
    Pb1:=TPanel.Create(WorkPanel);
    Pb1.Parent:=WorkPanel;
    Pb1.Font.Color:=clWhite;
    Pb1.ParentBackground:=false;
    Pb1.height:=17;
    Pb1.Left:=0;
    Pb1.Width:=WorkPanel.Width;
    Pb1.Anchors:=[akLeft,akTop,akRight];
    Pb1.Color := clActiveCaption;
    Pb1.Font.Size:=10;
    Pb1.Font.Style:=[fsBold];
    Pb1.AutoSize:=false;
    Pb1.Left:=10;
    Pb1.Width:=WorkPanel.Width-20;
    Pb1.BevelOuter:=bvNone;
    Pb1.Top:=top;
    Pb1.Caption:=caption;

end;

begin
   repHeader(3,'Таблицы и справочники');
   for i := 0 to AppConf_.Tables.Count-1 do
   begin
    Lb1:=TLabel.Create(WorkPanel);
    Lb1.Parent:=WorkPanel;
    Lb1.Font.Color:=clNavy;
    Lb1.Font.Size:=9;
    Lb1.Left:=15;
    Lb1.Top:=20+i*15;
    Lb1.Caption:=AppConf_.Tables.Table[i].Name;
    Lb1.Tag:=Integer(Pointer(AppConf_.Tables.Table[i]));
    Lb1.OnMouseEnter:=Label1MouseEnter;
    Lb1.OnMouseLeave:=Label1MouseLeave;
    Lb1.OnClick:=Label1Click;
   end;
  j:=(AppConf_.Tables.Count+1)*15+10;
  For i:= 0  to AppConf_.Modules.Count - 1 do
  begin
    if Appconf_.Modules.Modulegroup[i].Visible=1 then
    begin
      repHeader(j,Appconf_.Modules.Modulegroup[i].Name);
      j:=j+20;
      for k := 0 to Appconf_.Modules.Modulegroup[i].Count-1 do
      begin
      Lb1:=TLabel.Create(WorkPanel);
      Lb1.Parent:=WorkPanel;
      Lb1.Font.Color:=clTeal;
      Lb1.Font.Size:=9;
      Lb1.Left:=15;
      Lb1.Top:=j;
      Lb1.Caption:=AppConf_.Modules.Modulegroup[i].Module[k].Name;
      Lb1.Tag:=Integer(Pointer(AppConf_.Modules.Modulegroup[i].Module[k]));
      Lb1.OnMouseEnter:=Label1MouseEnter;
      Lb1.OnMouseLeave:=Label1MouseLeave;
      Lb1.OnClick:=Label2Click;
      j:=j+15;
      end;
    end;
  end;
  WorkPanel.Height:=j+25;
  {for i := 0 to AppConf_.Modules.Count - 1 do
  begin
    if AppConf_.Modules.Module[i].MType = 'application' then
    begin
      Fldop:=true;
      Lb1:=TLabel.Create(WorkPanel);
      Lb1.Parent:=WorkPanel;
      Lb1.Font.Color:=clTeal;
      Lb1.Font.Size:=9;
      Lb1.Left:=15;
      Lb1.Top:=j;
      Lb1.Caption:=AppConf_.Modules.Module[i].Name;
      Lb1.Tag:=Integer(Pointer(AppConf_.Modules.Module[i]));
      Lb1.OnMouseEnter:=Label1MouseEnter;
      Lb1.OnMouseLeave:=Label1MouseLeave;
      Lb1.OnClick:=Label2Click;
      j:=j+15;
    end;
  end;
  if FlDop then
  begin
    Pb1:=TPanel.Create(WorkPanel);
    Pb1.Parent:=WorkPanel;
    Pb1.Font.Color:=clWhite;
    Pb1.ParentBackground:=false;
    Pb1.height:=17;
    Pb1.Left:=0;
    Pb1.Width:=WorkPanel.Width;
    Pb1.Anchors:=[akLeft,akTop,akRight];
    Pb1.Color := clTeal;
    Pb1.Font.Size:=10;
    Pb1.Font.Style:=[fsBold];
    Pb1.AutoSize:=false;
    Pb1.Left:=10;
    Pb1.Width:=WorkPanel.Width-20;
    Pb1.BevelOuter:=bvNone;
    Pb1.Top:=10+(AppConf_.Tables.Count+1)*15;
    Pb1.Caption:='Дополнительно';
  end;
  Flrep:=false;
  reppos:=j+5;
  j:= j + 25;
  for i := 0 to AppConf_.Modules.Count - 1 do
  begin
    if AppConf_.Modules.Module[i].MType = 'report' then
    begin
      Flrep:=true;
      Lb1:=TLabel.Create(WorkPanel);
      Lb1.Parent:=WorkPanel;
      Lb1.Font.Color:=clTeal;
      Lb1.Font.Size:=9;
      Lb1.Left:=15;
      Lb1.Top:=j;
      Lb1.Caption:=AppConf_.Modules.Module[i].Name;
      Lb1.Tag:=Integer(Pointer(AppConf_.Modules.Module[i]));
      Lb1.OnMouseEnter:=Label1MouseEnter;
      Lb1.OnMouseLeave:=Label1MouseLeave;
      Lb1.OnClick:=Label2Click;
      j:=j+15;
    end;
  end; 
  if Flrep then
  begin
    Pb1:=TPanel.Create(WorkPanel);
    Pb1.Parent:=WorkPanel;
    Pb1.Font.Color:=clWhite;
    Pb1.ParentBackground:=false;
    Pb1.Color := $00EFD3C6;
    Pb1.height:=17;
    Pb1.Font.Size:=10;
    Pb1.Font.Style:=[fsBold];
    Pb1.AutoSize:=false;
    Pb1.Left:=10;
    Pb1.Width:=WorkPanel.Width-20;
    Pb1.Anchors:=[akLeft,akTop,akRight];
    Pb1.BevelOuter:=bvNone;
    Pb1.Top:=reppos;
    Pb1.Caption:='Отчеты';
  end; }
end;

function TMainForm.WBF(Value: string; Filter:string):TForm;
var i:integer;
begin
  Result:=nil;
  for i := 0 to MainForm.MDIChildCount - 1 do
    if MainForm.MDIChildren[i].Caption = Value then
    begin
      MainForm.MDIChildren[i].BringToFront;
      Result:=MainForm.MDIChildren[i] as TForm;
    end;
end;

function TMainForm.WBFToolWin(Value: string): TForm;
var i:integer;
begin
  Result:=nil;
  for i := 0 to MainForm.MDIChildCount - 1 do
    if MainForm.MDIChildren[i].Caption = Value then
    begin
      MainForm.MDIChildren[i].BringToFront;
      Result:=TForm(MainForm.MDIChildren[i]);
    end;
end;


procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

end.
