unit TreeItemsDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TTreeItemsDialog = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    TreeView1: TTreeView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    z: TLabel;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
  private

    procedure SetTreeNodes(const Value: TTreeNodes);
    function GetTreeNodes: TTreeNodes;
    { Private declarations }
  public
    { Public declarations }
    function Execute: boolean;
    property TreeNodes:TTreeNodes read GetTreeNodes write SetTreeNodes;
  end;



implementation

var CurrentNode:TTreeNode;

{$R *.dfm}

{ TTreeItemsDialog }

procedure TTreeItemsDialog.Button1Click(Sender: TObject);
begin
  CurrentNode:=TreeView1.Items.Add(nil,'');
  CurrentNode.ImageIndex:=0;
  CurrentNode.SelectedIndex:=0;
  CurrentNode.StateIndex:=-1;
  CurrentNode.Selected:=true;
  TreeView1.FullExpand;
end;

procedure TTreeItemsDialog.Button2Click(Sender: TObject);
begin
  if Assigned(CurrentNode) then
  begin
    CurrentNode:=TreeView1.Items.AddChild(CurrentNode,'');
    CurrentNode.ImageIndex:=0;
    CurrentNode.SelectedIndex:=0;
    CurrentNode.StateIndex:=-1;
    CurrentNode.Selected:=true;
  end;
  TreeView1.FullExpand;
end;

procedure TTreeItemsDialog.Button3Click(Sender: TObject);
begin
 if Assigned(CurrentNode) then
  begin
    CurrentNode.Delete;
  end;
end;

procedure TTreeItemsDialog.Button4Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TTreeItemsDialog.Button5Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TTreeItemsDialog.Edit1Change(Sender: TObject);
begin
  if Assigned(CurrentNode) then
     CurrentNode.Text:=Edit1.Text;
end;

procedure TTreeItemsDialog.Edit2Change(Sender: TObject);
begin
  if Assigned(CurrentNode) then
     CurrentNode.ImageIndex:=StrToInt(Edit2.Text);
end;

procedure TTreeItemsDialog.Edit3Change(Sender: TObject);
begin
  if Assigned(CurrentNode) then
     CurrentNode.SelectedIndex:=StrToInt(Edit3.Text);
end;

procedure TTreeItemsDialog.Edit4Change(Sender: TObject);
begin
  if Assigned(CurrentNode) then
     CurrentNode.StateIndex:=StrToInt(Edit4.Text);
end;

function TTreeItemsDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TTreeItemsDialog.GetTreeNodes: TTreeNodes;
begin
  Result:=TreeView1.Items;
end;

procedure TTreeItemsDialog.SetTreeNodes(const Value: TTreeNodes);
begin
  //Value;
  TreeView1.Items.Assign(Value);
end;

procedure TTreeItemsDialog.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  CurrentNode:=TreeView1.Selected;
  if Assigned(CurrentNode) then
  begin
    Edit1.Text:=CurrentNode.Text;
    Edit2.Text:=IntToStr(CurrentNode.ImageIndex);
    Edit3.Text:=IntToStr(CurrentNode.SelectedIndex);
    Edit4.Text:=IntToStr(CurrentNode.StateIndex);
  end;
end;

end.
