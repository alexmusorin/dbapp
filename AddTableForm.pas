unit AddTableForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, DATAunit, StrUtils;

type
  TAddTableDialog = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Panel3: TPanel;
    CheckListBox1: TCheckListBox;
    Memo1: TMemo;
    Label3: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    FFields:TStringList;
    function getFields: TStrings;
    function getSQL: string;
    function getTableLinkTo: string;
    function getTableName: string;
    procedure setSQL(const Value: string);
    procedure SetTableLinkTo(const Value: string);
    procedure setTableName(const Value: string);
  public
    { Public declarations }
    property TableName:string read getTableName write setTableName;
    property TableLinkTo:string read getTableLinkTo write SetTableLinkTo;
    property SQL:string read getSQL write setSQL;
    property Fields:TStrings read getFields;
    function Execute:boolean;
  end;


implementation

{$R *.dfm}

procedure TAddTableDialog.Button1Click(Sender: TObject);
begin
  if Button1.Caption = 'Готово' then
  ModalResult:=mrOk
  else
  begin
    Button1.Caption:='Готово';
    Button2.Enabled:=true;
    //
    DM.ADOQuery1.SQL.Text:=Memo1.Lines.Text;
    DM.ADOQuery1.Open;
    DM.ADOQuery1.GetFieldNames(CheckListBox1.Items);
    Panel3.BringToFront;
  end;
  
end;

procedure TAddTableDialog.Button2Click(Sender: TObject);
begin
  Button1.Caption:='>>';
  Button2.Enabled:=false;
  Panel2.BringToFront;
end;

procedure TAddTableDialog.Button3Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TAddTableDialog.Button4Click(Sender: TObject);
var i:integer;
begin
  for i := 0 to CheckListBox1.Items.Count -1 do
   CheckListBox1.Checked[i]:=true;
    
end;

procedure TAddTableDialog.Button5Click(Sender: TObject);
var i:integer;
begin
  for i := 0 to CheckListBox1.Items.Count -1 do
   CheckListBox1.Checked[i]:=false;

end;

procedure TAddTableDialog.ComboBox1Change(Sender: TObject);
begin
  Memo1.Lines.Text := 'select * from '+ComboBox1.Text+' ';
end;

function TAddTableDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

procedure TAddTableDialog.FormCreate(Sender: TObject);
begin
  inherited;
  Panel2.Align:=alClient;
  Panel3.Align:=alClient;
  Panel2.BringToFront;
  Button2.Enabled:=false;
  FFields:=TStringList.Create;
  DM.ADOConnection1.GetTableNames(ComboBox1.Items);
end;

function TAddTableDialog.getFields: TStrings;
var i:integer;
begin
  FFields.Clear;
  for i := 0 to CheckListBox1.Items.Count - 1 do
  if CheckListBox1.Checked[i] then FFields.Add(CheckListBox1.Items[i]);
  Result:=FFields;
end;

function TAddTableDialog.getSQL: string;
var i:integer;
    flag:boolean;
    fstr:string;
begin
   fstr:='';
   flag:=true;
   for I := 0 to CheckListBox1.Items.Count - 1 do
   begin
     if CheckListBox1.Checked[i] then fstr:=fstr+', '+CheckListBox1.Items[i];
     flag:=flag and CheckListBox1.Checked[i];
   end;
   if flag then Result:=Memo1.Lines.Text
   else
     Result:=ReplaceStr(Memo1.Lines.Text,
                                     '*',
                                     RightStr(fstr,length(fstr)-2));
end;

function TAddTableDialog.getTableLinkTo: string;
begin
  Result:=ComboBox1.Text;
end;

function TAddTableDialog.getTableName: string;
begin
  Result:=Edit1.Text;
end;

procedure TAddTableDialog.setSQL(const Value: string);
begin
  Memo1.Lines.Text:=Value;
end;

procedure TAddTableDialog.SetTableLinkTo(const Value: string);
begin
  ComboBox1.Text:=Value;
end;

procedure TAddTableDialog.setTableName(const Value: string);
begin
  Edit1.Text:=Value;
end;

end.
