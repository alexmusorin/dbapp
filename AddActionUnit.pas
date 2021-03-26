unit AddActionUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ImgList, ToolWin, ComCtrls;

type
  TAddActionDialog = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    HotKey1: THotKey;
    Label3: TLabel;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    procedure BitBtn1Click(Sender: TObject);
  private
    FTempalte: string;
    function getActionName: string;
    function getActionType: string;
    procedure setActionName(const Value: string);
    procedure setActionType(const Value: string);
    function getImageIndex: integer;
    procedure setImageIndex(const Value: integer);
    function getShortCut: integer;
    procedure setShortCut(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    function Execute:boolean;
    property ActionName:string read getActionName write setActionName;
    property ActionType:string read getActionType write setActionType;
    property ImageIndex:integer read getImageIndex write setImageIndex;
    property ShortCut:integer read getShortCut write setShortCut;
  end;

  

implementation

{$R *.dfm}

{ TAddActionDialog }

procedure TAddActionDialog.BitBtn1Click(Sender: TObject);
begin
  if (Edit1.Text<>'') and (comboBox1.Text<>'') then
  Modalresult:=mrOk;
  
end;

function TAddActionDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TAddActionDialog.getActionName: string;
begin
 Result:=Edit1.Text;
end;

function TAddActionDialog.getActionType: string;
begin
  Result:=ComboBox1.Text;
end;



function TAddActionDialog.getImageIndex: integer;
var i:integer;
begin
  for i := 0 to ToolBar1.ButtonCount- 1 do
    if ToolBar1.Buttons[i].Down then Result:=i;
    
end;

function TAddActionDialog.getShortCut: integer;
begin
  Result:=HotKey1.HotKey;
end;

procedure TAddActionDialog.setActionName(const Value: string);
begin
   Edit1.Text:=Value;
end;

procedure TAddActionDialog.setActionType(const Value: string);
begin
  ComboBox1.Text:=Value;
end;


procedure TAddActionDialog.setImageIndex(const Value: integer);
begin
  ToolBar1.Buttons[Value].Down:=true;
end;

procedure TAddActionDialog.setShortCut(const Value: integer);
begin
  HotKey1.HotKey:=Value;
end;

end.
