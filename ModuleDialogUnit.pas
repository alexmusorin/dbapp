unit ModuleDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TModuleDialog = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    function getModuleName: String;
    function getMType: string;
    procedure SetModuleName(const Value: String);
    procedure setMType(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property ModuleName:String read getModuleName write SetModuleName;
    property MType:string read getMType write setMType;
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

{ TModuleDialog }

function TModuleDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TModuleDialog.getModuleName: String;
begin
  Result:=Edit1.Text;
end;

function TModuleDialog.getMType: string;
begin
  Result:=ComboBox1.Text;
end;

procedure TModuleDialog.SetModuleName(const Value: String);
begin
  Edit1.Text:=Value;
end;

procedure TModuleDialog.setMType(const Value: string);
begin
  ComboBox1.Text:=Value;
end;

end.
