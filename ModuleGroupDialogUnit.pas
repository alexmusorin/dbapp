unit ModuleGroupDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TModulegroupDialog = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    function getExecGroup: boolean;
    function getGroupName: string;
    procedure setExecGroup(const Value: boolean);
    procedure setGroupName(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property GroupName: string read getGroupName write setGroupName;
    property ExecGroup: boolean read getExecGroup write setExecGroup;
    function Execute:boolean;
  end;

var
  ModulegroupDialog: TModulegroupDialog;

implementation

{$R *.dfm}

{ TModulegroupDialog }

function TModulegroupDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TModulegroupDialog.getExecGroup: boolean;
begin
  Result:=CheckBox1.Checked;
end;

function TModulegroupDialog.getGroupName: string;
begin
  Result:=Edit1.Text;
end;

procedure TModulegroupDialog.setExecGroup(const Value: boolean);
begin
  CheckBox1.Checked:=Value;
end;

procedure TModulegroupDialog.setGroupName(const Value: string);
begin
  Edit1.Text:=Value;
end;

end.
