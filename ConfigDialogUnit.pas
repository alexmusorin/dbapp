unit ConfigDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TConfigDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure SetLinkTo(const Value: string);
    function getLinkTo: string;
    function getAppName: String;
    procedure SetAppName(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property LinkTo: string read getLinkTo write SetLinkTo;
    property AppName: String read getAppName write SetAppName;
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

procedure TConfigDialog.Button1Click(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    Filter:='*.mdb|*.mdb|*.*|*.*';
    if Execute and (FileName<>'') then
      Edit1.Text:=FileName;
  end;
end;

function TConfigDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TConfigDialog.getAppName: String;
begin
  Result:=Edit2.Text;
end;

function TConfigDialog.getLinkTo: string;
begin
  Result:=Edit1.Text;
end;

procedure TConfigDialog.SetAppName(const Value: String);
begin
  Edit2.Text:=Value;
end;

procedure TConfigDialog.SetLinkTo(const Value: string);
begin
  Edit1.Text := Value;
end;

end.
