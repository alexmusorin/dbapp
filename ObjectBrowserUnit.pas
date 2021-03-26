unit ObjectBrowserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, ToolWin, StdCtrls, ImgList,SynMemo, SynEdit, SynHighlighterVBScript,
  ActnList, Menus, Buttons, xmlbrowserdata;

type
  TOjBrowForm = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    ListView1: TListView;
    Panel5: TPanel;
    Panel6: TPanel;
    ListView2: TListView;
    Panel7: TPanel;
    Memo1: TMemo;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ListView2Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateItems;
    procedure UpdeteSubItems(curClass: IXMLClassType);
  end;



implementation

Uses DataUnit;

{$R *.dfm}

procedure TOjBrowForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TOjBrowForm.FormShow(Sender: TObject);
begin
  inherited;
  UpdateItems;
end;

procedure TOjBrowForm.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if Assigned(Item.Data) then
  begin
    UpdeteSubItems(IXMLClassType(Item.Data));
    ListView2.ItemFocused:=ListView2.Items[0];
    ListView1.Selected :=ListView2.Items[0];
  end;
end;

procedure TOjBrowForm.ListView2Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if Assigned(item.Data) then
  begin
    Label1.Caption:='  '+IXMLClassitemType(item.Data).Type_+ ': '+ IXMLClassitemType(item.Data).Name;
    if IXMLClassitemType(item.Data).Type_='function' then
      Label1.Caption:=Label1.Caption+'('+IXMLClassitemType(item.Data).Param+') As '+IXMLClassitemType(item.Data).Returnvalue;
    if IXMLClassitemType(item.Data).Type_='sub' then
      Label1.Caption:=Label1.Caption+' '+IXMLClassitemType(item.Data).Param;
    if IXMLClassitemType(item.Data).Type_='constant' then
      Label1.Caption:=Label1.Caption+' = '+IXMLClassitemType(item.Data).Returnvalue;
    if IXMLClassitemType(item.Data).Type_='property' then
    begin
      if IXMLClassitemType(item.Data).Param<>'' then Label1.Caption:=Label1.Caption+'('+IXMLClassitemType(item.Data).Param+') As '+IXMLClassitemType(item.Data).Returnvalue
      else Label1.Caption:=Label1.Caption+' As '+IXMLClassitemType(item.Data).Returnvalue
    end;
    Memo1.Lines.Text:= IXMLClassitemType(item.Data).Text;
  end;
end;

procedure TOjBrowForm.SpeedButton1Click(Sender: TObject);
var FindItem:TListItem;
begin

  FindItem:=ListView1.FindCaption(0,Edit1.Text,true,false,true);
  if FindItem<>nil then
  begin
    ListView1.ItemFocused := FindItem;
    ListView1.Selected := FindItem;
    ListView1.SetFocus;
  end;
end;

procedure TOjBrowForm.UpdateItems;
var i:integer;
begin
  ListView1.Items.Clear;
  for i := 0 to AppObjects_.Count - 1 do
  begin
    with ListView1.Items.Add do
    begin
      Caption:= AppObjects_.Class_[i].Name;
      if Caption<>'globals' then
         ImageIndex:=1
      else ImageIndex:=0;
      Data:=Pointer(AppObjects_.Class_[i]);
    end;
  end;
    
end;

procedure TOjBrowForm.UpdeteSubItems(curClass: IXMLClassType);
var i:integer;
begin
  ListView2.Clear;
  for i := 0 to curClass.Count - 1 do
  begin
    with ListView2.Items.Add do
    begin
      Caption:=curClass.Classitem[i].Name;
      Data:=Pointer(curClass.Classitem[i]);
      if curClass.Classitem[i].Type_='property' then ImageIndex:=2;
      if curClass.Classitem[i].Type_='sub' then ImageIndex:=3;
      if curClass.Classitem[i].Type_='function' then ImageIndex:=3;
      if curClass.Classitem[i].Type_='constant' then ImageIndex:=4;
    end;
    Panel6.Caption:='  Member of '+curClass.Name;
  end;
end;

end.
