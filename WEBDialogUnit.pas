unit WEBDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, EncdDecd;

type
  TWEBDialog = class(TForm)
    Panel1: TPanel;
    ObjNameLabel: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FBASE64RES: WideString;
    Stream1: TMemoryStream;
    Stream2: TStringStream;
    function GetObjName: WideString;
    procedure SetObjName(const Value: WideString);
    { Private declarations }
  public
    { Public declarations }
    property ObjName: WideString read GetObjName write SetObjName;
    property BASE64RES: WideString read FBASE64RES;
    function Execute:boolean;
  end;

var
  WEBDialog: TWEBDialog;

implementation

{$R *.dfm}

procedure TWEBDialog.BitBtn1Click(Sender: TObject);
begin
  with TOpenDialog.Create(Application) do
  begin
    if Execute and (FileName<>'') then
    begin
      Stream1 := TMemoryStream.Create;
      Stream1.LoadFromFile(FileName);
      Stream2 := TStringStream.Create('');
      Stream1.Position:=0;
      EncodeStream(Stream1, Stream2);
      FBASE64RES:=Stream2.DataString;
      Edit1.Text:=ExtractFileName(FileName);
    end;
  end;
end;

function TWEBDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

procedure TWEBDialog.FormCreate(Sender: TObject);
begin
  FBASE64RES:='';
end;

function TWEBDialog.GetObjName: WideString;
begin
  Result:=Edit1.Text;
end;

procedure TWEBDialog.SetObjName(const Value: WideString);
begin
  Edit1.Text:=Value;
end;

end.
