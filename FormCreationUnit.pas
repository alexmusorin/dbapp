unit FormCreationUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ComCtrls, Buttons, ExtCtrls, DataUnit, DB,
  Menus, ImgList, ConfigApp, XMLIntf;

type
  TFormCreationDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    TreeView2: TTreeView;
    Panel3: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    BitBtn3: TBitBtn;
    Label7: TLabel;
    Edit5: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    FCodeOfForm: string;
    DataLink: TStringList;
    procedure SetCodeOfForm(const Value: string);
    function getFormCaption: string;
    function getFormName: string;
    procedure setFormCaption(const Value: string);
    procedure setFormName(const Value: string);
    procedure MoveNode(TargetNode, SourceNode:TTreeNode);
    procedure ControlEnabled(Mode:boolean);
    { Private declarations }
  public
    { Public declarations }
    property CodeOfForm:string read FCodeOfForm write SetCodeOfForm;
    property FormName:string read getFormName write setFormName;
    property FormCaption:string read getFormCaption write setFormCaption;
    function Execute:boolean;
    function GetFieldDisplay(Page:string; FieldName:string):string;
    function GetModuleConnectPoint(Page:string):IXMLActionsType;
    function GetOrCreateAppForm: IXMLModulegroupType;
  end;



implementation



var node,node1:TTreeNode;

{$R *.dfm}

{ TFormCreationDialog }

procedure TFormCreationDialog.BitBtn1Click(Sender: TObject);
var FormCode:TStringList;
    i, j, top_, CNum: integer;
    HSize,MaxHSize:integer;
begin

  if RadioButton1.Checked and ((Edit1.Text<>'') and (Edit2.Text<>'')) then
  begin
    FormCode:=TStringList.Create;
    with FormCode do
    begin
      Add('object '+Edit1.Text+':TForm');
      Add('  Width = 340');
      Add('  Height = 340');
      Add('  Caption = '''+Edit2.Text+'''');
      Add('end');
    end;
  end;
  DataLink:= TStringList.Create;
  DataLink.Add('''Модуль формы '+Edit1.Text);
  DataLink.Add('Execute App.Data.[Data Provider]');
  DataLink.Add('');
  DataLink.Add('''Связывание данных');
  DataLink.Add('Set FormData = (new DataProvider)("'+ComboBox1.text+'", "'+Edit5.Text+'")');
  DataLink.Add('With FormData');
  if RadioButton2.Checked and ((Edit1.Text<>'') and (Edit2.Text<>'')) then
  begin
    FormCode:=TStringList.Create;
    with FormCode do
    begin
      Add('object '+Edit1.Text+':TForm');
      Add('  Width = '+IntToStr(50+StrToInt(Edit3.Text)+StrToInt(Edit4.Text)));
      HSize:=0;
      for i := 0 to TreeView2.Items.Count - 1 do
        if (TreeView2.Items[i].ImageIndex>0) and (TreeView2.Items[i].ImageIndex<4) then
          HSize:=HSize+22;
      Add('  Height = '+IntToStr(HSize+90));
      Add('  Caption = '''+Edit2.Text+'''');
      top_:=1;
      for i := 1 to TreeView2.Items.Count - 1 do
      begin
        if TreeView2.Items[i].ImageIndex=1 then
        begin
          Add('  object '+Edit1.Text+'_Edit'+IntToStr(i+1)+':TEdit');
          Add('    Top = '+IntToStr(22*top_-15));
          Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
          Add('    Width = '+Edit4.Text);
          Add('    Text = ''''');
          Add('    Tag = '+IntToStr(Integer(TreeView2.Items[i].Data)));
          Add('  end');
          DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[i].Data)].FieldName+'") = '+ Edit1.Text+'_Edit'+IntToStr(i+1));
        end;
        if TreeView2.Items[i].ImageIndex=2 then
        begin
          Add('  object '+Edit1.Text+'_ComboBox'+IntToStr(i+1)+':TComboBox');
          Add('    Top = '+IntToStr(22*top_-15));
          Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
          Add('    Width = '+Edit4.Text);
          Add('    Text = ''''');
          Add('    Tag = '+IntToStr(Integer(TreeView2.Items[i].Data)));
          Add('  end');
          DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[i].Data)].FieldName+'") = '+ Edit1.Text+'_ComboBox'+IntToStr(i+1));
        end;
        if TreeView2.Items[i].ImageIndex=3 then
        begin
          Add('  object '+Edit1.Text+'_DateTimePicker'+IntToStr(i+1)+':TDateTimePicker');
          Add('    Top = '+IntToStr(22*top_-15));
          Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
          Add('    Width = '+Edit4.Text);
          Add('    Tag = '+IntToStr(Integer(TreeView2.Items[i].Data)));
          Add('  end');
          DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[i].Data)].FieldName+'") = '+ Edit1.Text+'_DateTimePicker'+IntToStr(i+1));
        end;
        if TreeView2.Items[i].ImageIndex in [1,2,3] then
        begin
          Add('  object '+Edit1.Text+'_Label'+IntToStr(i+1)+':TLabel');
          Add('    Top = '+IntToStr(22*top_-10));
          Add('    Left = 10');
          Add('    Width = '+Edit3.Text);
          Add('    Caption = ''' + TreeView2.Items[i].Text+'''');
          Add('  end');
        end;
        Top_:=Top_+1;
      end;
      Add('  object '+Edit1.Text+'_Panel1: TPanel');
      Add('       Left = 0');
      Add('       Height = 41');
      Add('	   Width = 320');
      Add('       Align = alBottom');
      Add('       TabOrder = 0');
      Add('       object '+Edit1.Text+'_Button2: TBitBtn');
      Add('         Left = 138');
      Add('         Top = 8');
      Add('         Width = 75');
      Add('         Height = 25');
      Add('         Anchors = [akTop, akRight]');
      Add('         Kind = bkOk');
      Add('         Caption = ''Записать''');
      Add('         TabOrder = 0');
      Add('     end');
      Add('       object '+Edit1.Text+'_Button3: TBitBtn');
      Add('         Left = 226');
      Add('         Top = 8');
      Add('         Width = 75');
      Add('         Height = 25');
      Add('         Anchors = [akTop, akRight]');
      Add('         Kind = bkCancel');
      Add('         Caption = ''Отмена''');
      Add('         TabOrder = 1');
      Add('     end');
      Add('   end');
      Add('end');
    end;
  end;
  if RadioButton3.Checked and ((Edit1.Text<>'') and (Edit2.Text<>'')) then
  begin
    FormCode:=TStringList.Create;
    with FormCode do
    begin
      Add('object '+Edit1.Text+' :TForm');
      Add('  Width = '+IntToStr(50+StrToInt(Edit3.Text)+StrToInt(Edit4.Text)));
      MaxHSize:=0;
      for i := 0 to TreeView2.Items[0].Count - 1 do
      begin
        HSize:=0;
        for j := 0 to TreeView2.Items[0].Item[i].Count- 1 do
          HSize:=HSize+22;
        if HSize>=MaxHSize then MaxHSize:=HSize;
      end;
      Add('  Height = '+IntToStr(MaxHSize+120));
      Add('  Caption = '''+Edit2.Text+'''');
      Add('  object '+Edit1.Text+'_PageControl1 :TPageControl');
      Add('    Left = 0');
      Add('    Top = 0');
      Add('    Align= alClient');
      Add('    ActivePage = '+Edit1.Text+'_TebSheet1');
      CNum:=1;
      for i := 0 to TreeView2.Items[0].Count - 1 do
      begin
        Add('    object '+Edit1.Text+'_TabSheet'+IntToStr(i+1)+' :TTabSheet');
        Add('      Caption = '''+TreeView2.Items[0].Item[i].Text+'''');
        top_:=1;
        for j := 0 to TreeView2.Items[0].Item[i].Count- 1 do
        begin
          if TreeView2.Items[0].Item[i].Item[j].ImageIndex=1 then
          begin
            Add('  object '+Edit1.Text+'_Edit'+IntToStr(CNum)+':TEdit');
            Add('    Top = '+IntToStr(22*top_-15));
            Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
            Add('    Width = '+Edit4.Text);
            Add('    Text = ''''');
            Add('    Tag = '+IntToStr(Integer(TreeView2.Items[0].Item[i].Item[j].data)));
            Add('  end');
            DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[0].Item[i].Item[j].data)].FieldName+'") = '+ Edit1.Text+'_Edit'+IntToStr(CNum));
          end;
          if TreeView2.Items[0].Item[i].Item[j].ImageIndex=2 then
          begin
            Add('  object '+Edit1.Text+'_ComboBox'+IntToStr(CNum)+':TComboBox');
            Add('    Top = '+IntToStr(22*top_-15));
            Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
            Add('    Width = '+Edit4.Text);
            Add('    Text = ''''');
            Add('    Tag = '+IntToStr(Integer(TreeView2.Items[0].Item[i].Item[j].data)));;
            Add('  end');
            DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[0].Item[i].Item[j].data)].FieldName+'") = '+ Edit1.Text+'_ComboBox'+IntToStr(CNum));
          end;
          if TreeView2.Items[0].Item[i].Item[j].ImageIndex=3 then
          begin
            Add('  object '+Edit1.Text+'_DateTimePicker'+IntToStr(CNum)+':TDateTimePicker');
            Add('    Top = '+IntToStr(22*top_-15));
            Add('    Left = '+IntToStr(20+StrToInt(Edit3.Text)));
            Add('    Width = '+Edit4.Text);
            Add('    Tag = '+IntToStr(Integer(TreeView2.Items[0].Item[i].Item[j].data)));
            Add('  end');
            DataLink.Add('  .Field("'+DM.ADOQuery1.Fields.Fields[Integer(TreeView2.Items[0].Item[i].Item[j].data)].FieldName+'") = '+ Edit1.Text+'_DateTimePicker'+IntToStr(CNum));
          end;
          if TreeView2.Items[0].Item[i].Item[j].ImageIndex in [1,2,3] then
          begin
            Add('  object '+Edit1.Text+'_Label'+IntToStr(CNum)+':TLabel');
            Add('    Top = '+IntToStr(22*top_-10));
            Add('    Left = 10');
            Add('    Width = '+Edit3.Text);
            Add('    Caption = ''' + TreeView2.Items[0].Item[i].Item[j].Text+'''');
            Add('  end');
          end;
          Top_:=Top_+1;
          CNum:=CNum+1;
        end;
        Add('  end');
    end;
     Add('  end');
     Add('  object '+Edit1.Text+'_Panel1: TPanel');
     Add('       Left = 0');
     Add('       Height = 41');
     Add('	   Width = 320');
     Add('       Align = alBottom');
     Add('       TabOrder = 0');
     Add('       object '+Edit1.Text+'_Button2: TBitBtn');
     Add('         Left = 138');
     Add('         Top = 8');
     Add('         Width = 75');
     Add('         Height = 25');
     Add('         Anchors = [akTop, akRight]');
     Add('         Kind = bkOk');
     Add('         Caption = ''Записать''');
     Add('         TabOrder = 0');
     Add('     end');
     Add('       object '+Edit1.Text+'_Button3: TBitBtn');
     Add('         Left = 226');
     Add('         Top = 8');
     Add('         Width = 75');
     Add('         Height = 25');
     Add('         Anchors = [akTop, akRight]');
     Add('         Kind = bkCancel');
     Add('         Caption = ''Отмена''');
     Add('         TabOrder = 1');
     Add('     end');
     Add('   end');
     Add('end');
  end;
end;
 if not RadioButton1.Checked then
 begin
   Datalink.Add('End With');
   DataLink.Add('');
   DataLink.Add('''Обработчики формы');
   with GetOrCreateAppForm.Add do
   begin
     Name := Edit1.Text;
     Text := DataLink.Text;
   end;
 end;
 FCodeOfForm:=FormCode.Text;
 ModalResult:=mrOk;
 FormCode.Free;
end;

procedure TFormCreationDialog.BitBtn3Click(Sender: TObject);
var i:integer;
    ModuleCode:TStringList;
    CPAction:IXMLActionsType;
    actionnode:IXMLActionType;
begin
  ModuleCode:=TStringList.Create;
  CPAction:=GetModuleConnectPoint(ComboBox2.Text);
  if not RadioButton1.Checked then
  begin
    with ModuleCode do
    begin
      Add('''Действие Добавить');
      Add('');
      Add('Set F = Form("'+Edit1.Text+'")');
      Add('F.KeyPreview = True');
      Add('');
      Add('Execute App.AppForms.'+Edit1.Text);
      Add('');
      Add('If F.ShowModal = vbOk Then');
      Add('  FormData.NewRecord');
      Add('  App.['+ComboBox2.Text+'].Refresh');
      Add('End If');
    end;
    if CPAction<>nil then
    begin
      actionnode:=CPAction.Add;
      actionnode.Name:='Добавить';
      actionnode.Popup:='NO';
      actionnode.Imageindex:=0;
      actionnode.ShortCut:=0;
      ActionNode.ChildNodes.Add(actionnode.OwnerDocument.CreateNode(ModuleCode.Text,ntCData));
    end;
    ModuleCode.Clear;
    with ModuleCode do
    begin
      Add('''Действие Изменить');
      Add('');
      Add('Set F = Form("'+Edit1.Text+'")');
      Add('F.KeyPreview = True');
      Add('');
      Add('Execute App.AppForms.'+Edit1.Text);
      Add('');
      Add('FormData.LoadRecords(App.['+ComboBox2.Text+'].Table.'+Edit5.Text+')');
      Add('');
      Add('If F.ShowModal = vbOk Then');
      Add('  FormData.SaveRecord');
      Add('  App.['+ComboBox2.Text+'].Refresh');
      Add('End If');
    end;
    if CPAction<>nil then
    begin
      actionnode:=CPAction.Add;
      actionnode.Name:='Изменить';
      actionnode.Popup:='NO';
      actionnode.Imageindex:=1;
      actionnode.ShortCut:=0;
      ActionNode.ChildNodes.Add(actionnode.OwnerDocument.CreateNode(ModuleCode.Text,ntCData));
    end;
  end;
  ModuleCode.Free;
end;

procedure TFormCreationDialog.ComboBox1Change(Sender: TObject);
var Buf:TStringList;
  i: Integer;
begin
  Buf:=TStringList.Create;
  TreeView2.Items.Clear;
  if ComboBox1.Text<>'' then
  begin
    DM.ADOQuery1.SQL.Text:='select * from '+ComboBox1.Text;
    DM.ADOQuery1.Open;
    DM.ADOQuery1.GetFieldNames(Buf);
    node:=TreeView2.Items.AddChildObjectFirst(nil,'Форма',Pointer(-1));
    node.ImageIndex:=0;
    node.SelectedIndex:=0;
    for i := 0 to Buf.Count - 1 do
    begin
      node1:=TreeView2.Items.AddChildObject(node,Buf[i],Pointer(i));
      node1.ImageIndex:=1;
      node1.SelectedIndex:=1;
    end;
  end;
  Buf.Free
end;

procedure TFormCreationDialog.ComboBox2Change(Sender: TObject);
var i:integer;
begin
  For i:=0 to TreeView2.Items.Count - 1 do
  begin
    if GetFieldDisplay(ComboBox2.Text,TreeView2.Items[i].Text)<>'' then TreeView2.Items[i].Text:=GetFieldDisplay(ComboBox2.Text,TreeView2.Items[i].Text);
  end;
end;

procedure TFormCreationDialog.ControlEnabled(Mode: boolean);
begin
  Edit3.Enabled:=Mode;
  Edit4.Enabled:=Mode;
  ComboBox1.Enabled:=Mode;
  Combobox2.Enabled:=Mode;
end;

function TFormCreationDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

procedure TFormCreationDialog.FormCreate(Sender: TObject);
begin
  inherited;
  DM.ADOConnection1.GetTableNames(ComboBox1.Items);
  DM.GetPageNames(ComboBox2.Items);
  controlEnabled(false);
end;

function TFormCreationDialog.GetFieldDisplay(Page, FieldName: string): string;
var i,j:integer;
begin
  Result:='';
  for i := 0 to AppConf_.Tables.Count - 1 do
  begin
    if AppConf_.Tables.Table[i].Name=Page then
    for j := 0 to AppConf_.Tables.Table[i].Fields.Count - 1 do
      if AnsiUpperCase(AppConf_.Tables.Table[i].Fields.Field[j].Name)=AnsiUpperCase(FieldName) then
        Result:=AppConf_.Tables.Table[i].Fields.Field[j].Display;
  end;
    
end;

function TFormCreationDialog.getFormCaption: string;
begin
  Result:=Edit2.Text
end;

function TFormCreationDialog.getFormName: string;
begin
  Result:=Edit1.Text;
end;

function TFormCreationDialog.GetModuleConnectPoint(
  Page: string): IXMLActionsType;
var i:integer;
begin
  Result:=nil;
  for i := 0 to AppConf_.Tables.Count - 1 do
  begin
    if AppConf_.Tables.Table[i].Name=Page then
      Result:=AppConf_.Tables.Table[i].Actions;
  end;
end;

function TFormCreationDialog.GetOrCreateAppForm: IXMLModulegroupType;
var i: integer;
    res: IXMLModulegroupType;
begin
   res :=nil;
   for i := 0 to AppConf_.Modules.Count - 1  do
      if AppConf_.Modules.Modulegroup[i].Name = 'AppForms' then
        res := AppConf_.Modules.Modulegroup[i];
   if not Assigned(res) then
   begin
     res := AppConf_.Modules.Add;
     res.Name := 'AppForms';
     res.Visible := 0;
   end;
   Result := res;
end;

procedure TFormCreationDialog.MoveNode(TargetNode, SourceNode: TTreeNode);
var NodeTmp:TTreeNode;
begin
  with TreeView2 do
  begin
    nodeTmp:=Items.AddChild(TargetNode, SourceNode.Text);
    nodeTmp.ImageIndex:=SourceNode.ImageIndex;
    nodeTmp.SelectedIndex:=SourceNode.SelectedIndex;
    nodeTmp.Data:=SourceNode.Data;
  end;
  SourceNode.Free;
end;

procedure TFormCreationDialog.N1Click(Sender: TObject);
var i:integer;
begin
  for I := 0 to TreeView2.Items.Count - 1 do
    begin
      if (TreeView2.Items[i].Selected) and
       (TreeView2.Items[i].ImageIndex<4) and
       (TreeView2.Items[i].ImageIndex>0) then
      Begin
        TreeView2.Items[i].ImageIndex:=1;
        TreeView2.Items[i].SelectedIndex:=1;
      End;
    end;
end;

procedure TFormCreationDialog.N2Click(Sender: TObject);
var i:integer;
begin
  for I := 0 to TreeView2.Items.Count - 1 do
    begin
      if (TreeView2.Items[i].Selected) and
       (TreeView2.Items[i].ImageIndex<4) and
       (TreeView2.Items[i].ImageIndex>0) then
      Begin
        TreeView2.Items[i].ImageIndex:=2;
        TreeView2.Items[i].SelectedIndex:=2;
      End;
    end;
end;

procedure TFormCreationDialog.N3Click(Sender: TObject);
var i:integer;
begin
  for I := 0 to TreeView2.Items.Count - 1 do
    begin
      if (TreeView2.Items[i].Selected) and
       (TreeView2.Items[i].ImageIndex<4) and
       (TreeView2.Items[i].ImageIndex>0) then
      Begin
        TreeView2.Items[i].ImageIndex:=3;
        TreeView2.Items[i].SelectedIndex:=3;
      End;
    end;
end;

procedure TFormCreationDialog.N5Click(Sender: TObject);
var i:integer;
    gnode:TTreeNode;
    NodeList:TStringList;
begin
  NodeList:=TStringList.Create;
  for i := 0 to TreeView2.Items.Count - 1 do
    if (TreeView2.Items[i].Selected) and
       (TreeView2.Items[i].ImageIndex<4) and
       (TreeView2.Items[i].ImageIndex>0)
    then NodeList.AddObject(TreeView2.Items[i].Text,Pointer(TreeView2.Items[i]));
  if NodeList.Count>0 then
  begin
    gnode:=TreeView2.Items.AddChildObject(node,'Группа',nil);
    gnode.ImageIndex:=4;
    gnode.SelectedIndex:=4;
  end else gnode:=nil;
  for i := 0 to NodeList.Count-1 do
  begin
    node1:=TTreeNode(NodeList.Objects[i]);
    if gnode<>nil then moveNode(gnode,Node1);
  end;
  NodeList.Free;
end;

procedure TFormCreationDialog.N7Click(Sender: TObject);
begin
  if (TreeView2.Selected.ImageIndex>0) and (TreeView2.Selected.ImageIndex<4) then
    TreeView2.Selected.Free;
end;

procedure TFormCreationDialog.RadioButton1Click(Sender: TObject);
begin
  if Radiobutton1.Checked then ControlEnabled(false);
  TreeView2.Items.Clear;
end;

procedure TFormCreationDialog.RadioButton2Click(Sender: TObject);
begin
  if Radiobutton2.Checked then ControlEnabled(true);
end;

procedure TFormCreationDialog.RadioButton3Click(Sender: TObject);
begin
  if Radiobutton3.Checked then ControlEnabled(true);
end;

procedure TFormCreationDialog.SetCodeOfForm(const Value: string);
begin
  FCodeOfForm := Value;
end;

procedure TFormCreationDialog.setFormCaption(const Value: string);
begin
  Edit2.Text:=Value;
end;

procedure TFormCreationDialog.setFormName(const Value: string);
begin
  Edit1.Text:=value;
end;

end.
