unit StyleDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls, ToolWin,StrUtils;

type
  TStyleDialog = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ImageList1: TImageList;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ToolButton7: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    function getBackground: integer;
    function getFontColor: integer;
    function getFontStyle: string;
    procedure setBackground(const Value: integer);
    procedure setFontColor(const Value: integer);
    procedure setFontStyle(const Value: string);
    function getCondition: string;
    procedure setCondition(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property FontColor: integer read getFontColor write setFontColor;
    property Background: integer read getBackground write setBackground;
    property FontStyle:string read getFontStyle write setFontStyle;
    property Condition:string read getCondition write setCondition; 
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

function TStyleDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TStyleDialog.getBackground: integer;
begin
  Result:=Shape1.Brush.Color;
end;

function TStyleDialog.getCondition: string;
begin
  Result:=Edit1.Text;
end;

function TStyleDialog.getFontColor: integer;
begin
  Result:=Label2.Font.Color;
end;

function TStyleDialog.getFontStyle: string;
var bufstr:string;
begin
  if ToolButton4.Down then Bufstr:=Bufstr+', Bold';
  if ToolButton5.Down then Bufstr:=Bufstr+', Italic';
  if ToolButton6.Down then Bufstr:=Bufstr+', Underline';
  if ToolButton7.Down then Bufstr:=Bufstr+', StrikeOut';
  Result:='['+RightStr(Bufstr,length(Bufstr)-2)+']';
end;

procedure TStyleDialog.setBackground(const Value: integer);
begin
  Shape1.Brush.Color:=Value;
  Shape2.Brush.Color:=Value;
end;

procedure TStyleDialog.setCondition(const Value: string);
begin
  Edit1.Text:=Value;
end;

procedure TStyleDialog.setFontColor(const Value: integer);
begin
  Label2.Font.Color:=Value;
end;

procedure TStyleDialog.setFontStyle(const Value: string);
begin
  if Pos('BOLD',AnsiUpperCase(Value))<>0 then
  begin
    Label2.Font.Style:= Label2.Font.Style + [fsBold];
    ToolButton4.Down:=true;
  end;
  if Pos('ITALIC',AnsiUpperCase(Value))<>0 then
  begin
    Label2.Font.Style:= Label2.Font.Style + [fsItalic];
    ToolButton5.Down:=true;
  end;
  if Pos('UNDERLINE',AnsiUpperCase(Value))<>0 then
  begin
    Label2.Font.Style:= Label2.Font.Style + [fsUnderline];
    ToolButton6.Down:=true;
  end;
  if Pos('STRIKEOUT',AnsiUpperCase(Value))<>0 then
  begin
    Label2.Font.Style:= Label2.Font.Style + [fsStrikeOut];
    ToolButton7.Down:=true;
  end;
end;

procedure TStyleDialog.ToolButton1Click(Sender: TObject);
begin
  with TColorDialog.Create(Application) do
  if Execute then
  begin
    Shape1.Brush.Color:=Color;
    Shape2.Brush.Color:=Color;
  end;
end;

procedure TStyleDialog.ToolButton2Click(Sender: TObject);
begin
  with TColorDialog.Create(Application) do
  if Execute then
  begin
    Label2.Font.Color:=Color;
  end;
end;

procedure TStyleDialog.ToolButton4Click(Sender: TObject);
begin
  if ToolButton4.Down then
    Label2.Font.Style := Label2.Font.Style + [fsBold]
  else Label2.Font.Style := Label2.Font.Style - [fsBold];
end;

procedure TStyleDialog.ToolButton5Click(Sender: TObject);
begin
  if ToolButton5.Down then
    Label2.Font.Style := Label2.Font.Style + [fsItalic]
  else Label2.Font.Style := Label2.Font.Style - [fsItalic];
end;

procedure TStyleDialog.ToolButton6Click(Sender: TObject);
begin
  if ToolButton6.Down then
    Label2.Font.Style := Label2.Font.Style + [fsUnderline]
  else Label2.Font.Style := Label2.Font.Style - [fsUnderline];
end;

procedure TStyleDialog.ToolButton7Click(Sender: TObject);
begin
  if ToolButton7.Down then
    Label2.Font.Style := Label2.Font.Style + [fsStrikeOut]
  else Label2.Font.Style := Label2.Font.Style - [fsStrikeOut];
end;

end.
