unit TestFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridFrame, Menus, ComCtrls, ToolWin,DataUnit, ConfigApp, ImgList,
  SQLDialogUnit, StdCtrls;

type
  TTestDialog = class(TForm)
    ToolBar1: TToolBar;
    PopupMenu1: TPopupMenu;
    Grid_Frame1: TGrid_Frame;
    N1: TMenuItem;
    ImageList1: TImageList;
    procedure MenuItemClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure TableDblClick(Sender: TObject);
    procedure EnterClick;
    procedure GetSQLEvent(SQL: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FIXMLTable: IXMLTableType;
    procedure SetIXMLTable(const Value: IXMLTableType);
    function getGridFilter: String;
    { Private declarations }
  public
    { Public declarations }
    property IXMLTable:IXMLTableType read FIXMLTable write SetIXMLTable;
  end;



implementation

uses XMLIntf, main;

{$R *.dfm}

procedure TTestDialog.EnterClick;
var i:integer;
begin
  for i := 0 to FIXMLTable.Actions.Count - 1 do
  begin
    if AnsiUpperCase(FIXMLTable.Actions.Action[i].Name)='»«Ã≈Õ»“‹' then
    begin
      DM.ExecuteScript(FIXMLTable.Actions.Action[i].Text);
      Grid_Frame1.Refresh;
    end;
  end;
end;

procedure TTestDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
    for i := 0 to MainForm.WorkPanel.ControlCount - 1 do
  begin
    if (MainForm.WorkPanel.Controls[i] is TLabel) then
       if (MainForm.WorkPanel.Controls[i] as TLabel).Caption=FIXMLTable.Name then
          (MainForm.WorkPanel.Controls[i] as TLabel).Font.Style := (MainForm.WorkPanel.Controls[i] as TLabel).Font.Style - [fsBold];

  end;
  Action:=caFree;
end;

procedure TTestDialog.FormCreate(Sender: TObject);
begin
  inherited;
  Grid_Frame1.DBGrid.onDblClick:=TableDblClick;
  Grid_Frame1.DBGrid.OnEnterClickEvent:=EnterClick;
  Grid_Frame1.DBGrid.OnGetSQLEvent:= GetSQLEvent;
end;

function TTestDialog.getGridFilter: String;
begin
//
end;

procedure TTestDialog.GetSQLEvent(SQL: String);
var SQLDialog: TSQLDialog;
begin
  SQLDialog := TSQLDialog.Create(Application);
  SQLDialog.SQL:=SQL;
  SQLDialog.Show;
end;

procedure TTestDialog.MenuItem2Click(Sender: TObject);
begin
 if TMenuItem(sender).Checked then TMenuItem(sender).Checked:=false
 Else TMenuItem(sender).Checked:=true;
end;

procedure TTestDialog.MenuItemClick(Sender: TObject);
begin
  DM.ExecuteScript(FIXMLTable.Actions.Action[TWinControl(sender).Tag].Text);
  //Grid_Frame1.Refresh;
end;



procedure TTestDialog.SetIXMLTable(const Value: IXMLTableType);
var i:integer;
begin
  FIXMLTable := Value;
  for i := 0 to MainForm.WorkPanel.ControlCount - 1 do
  begin
    if (MainForm.WorkPanel.Controls[i] is TLabel) then
       if (MainForm.WorkPanel.Controls[i] as TLabel).Caption=FIXMLTable.Name then
          (MainForm.WorkPanel.Controls[i] as TLabel).Font.Style := [fsBold];

  end;
end;

procedure TTestDialog.TableDblClick(Sender: TObject);
var i:integer;
begin
  for i := 0 to FIXMLTable.Actions.Count - 1 do
  begin
    if AnsiUpperCase(FIXMLTable.Actions.Action[i].Name)='»«Ã≈Õ»“‹' then
    begin
      DM.ExecuteScript(FIXMLTable.Actions.Action[i].Text);
      //Grid_Frame1.Refresh;
    end;
  end;
end;

end.
