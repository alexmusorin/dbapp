unit ConstUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, EncdDecd, jpeg;

type
  TConstDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Panel3: TPanel;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    function GetConstName: string;
    function GetConstValue: string;
    procedure SetConstrName(const Value: string);
    procedure SetConstValue(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property ConstName: string read GetConstName write SetConstrName;
    property ConstValue: string read GetConstValue write SetConstValue;
    function Execute:boolean; 
  end;



implementation

{$R *.dfm}

{ TForm1 }

procedure TConstDialog.Button1Click(Sender: TObject);
begin
  with TopenDialog.Create(Application) do
  begin
    Filter:='*.bmp|*.bmp|*.jpg|*.jpg|*.*|*.*';
    if Execute and (FileName<>'') then
      Image1.Picture.LoadFromFile(FileName);

      
    Free;
  end;
end;

function TConstDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TConstDialog.GetConstName: string;
begin
  Result:=Edit1.Text;
end;

function TConstDialog.GetConstValue: string;
begin
  Result:=Memo1.Lines.Text;
end;

procedure TConstDialog.PageControl1Change(Sender: TObject);
Var Ms:TMemoryStream;
    SS:TStringStream;
begin
  if PageControl1.ActivePage=TabSheet1 then
  begin
    Ms:=TMemoryStream.Create;
    SS:=TStringStream.Create('');
    Image1.Picture.Bitmap.SaveToStream(Ms);
    Ms.Position:=0;
    EncodeStream(Ms,Ss);
    Memo1.Lines.Text:=SS.DataString;
  end;
  if PageControl1.ActivePage=TabSheet2 then
  begin
    Ms:=TMemoryStream.Create;
    SS:=TStringStream.Create(Memo1.Lines.Text);
    Ss.Position:=0;
    DecodeStream(Ss,Ms);
    Ms.Position:=0;
    Image1.Picture.Bitmap.LoadFromStream(Ms);
  end;
end;

procedure TConstDialog.SetConstrName(const Value: string);
begin
  Edit1.Text:=Value;
end;

procedure TConstDialog.SetConstValue(const Value: string);
begin
  Memo1.Lines.Text:=Value;
end;

end.
