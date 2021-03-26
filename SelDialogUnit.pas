unit SelDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TSelDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    Label2: TLabel;
  private
    function getSelName: string;
    function getSQL: string;
    procedure setSelName(const Value: string);
    procedure setSQL(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property SelName:string read getSelName write setSelName;
    property SQL:string read getSQL write setSQL;
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

{ TSelDialog }

function TSelDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TSelDialog.getSelName: string;
begin
  Result:=Edit1.Text;
end;

function TSelDialog.getSQL: string;
begin
  Result:=Memo1.Lines.Text;
end;

procedure TSelDialog.setSelName(const Value: string);
begin
  Edit1.Text:=Value;
end;

procedure TSelDialog.setSQL(const Value: string);
begin
  Memo1.Lines.Text:=Value;
end;

end.
