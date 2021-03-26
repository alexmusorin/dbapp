unit DialogDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridFrame, ADODB, StdCtrls, Buttons, ExtCtrls;

type
  TDialogDBForm = class(TForm)
    Grid_Frame1: TGrid_Frame;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
  private

    FFieldName: string;
    FDescrField: string;
    FDefaultFilter: string;
    function getQuery: string;
    procedure setQuery(const Value: string);
    function getConnection: TADOConnection;
    procedure setConnection(const Value: TADOConnection);
    procedure SetFieldName(const Value: string);
    procedure SetDescrField(const Value: string);
    procedure SetDefaultFilter(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    ResField:string;
    Description:String;
    property Query:string read getQuery write setQuery;
    property Connection:TADOConnection read getConnection write setConnection;
    property FieldName:string read FFieldName write SetFieldName;
    property DescrField:string read FDescrField write SetDescrField;
    property DefaultFilter: string read FDefaultFilter write SetDefaultFilter;
    procedure AddLabel(FieldName,DisplayName:string; FieldSize:integer);
    procedure Clear;
  end;



implementation

{$R *.dfm}

{ TDialogDBForm }

procedure TDialogDBForm.AddLabel(FieldName,DisplayName:string; FieldSize:integer);
begin
  Grid_Frame1.DBGrid.AddLabel(FieldName,DisplayName,FieldSize);
end;

procedure TDialogDBForm.BitBtn1Click(Sender: TObject);
begin
  ResField:=Grid_Frame1.ADOQuery.FieldByName(FFieldName).AsString;
  if FDescrField <> '' then
    Description:=Grid_Frame1.ADOQuery.FieldByName(FDescrField).AsString
  Else  Description:='';
  
  ModalResult:=mrOk;
end;



procedure TDialogDBForm.Clear;
begin
  Grid_Frame1.DBGrid.ClearLabels;
end;

procedure TDialogDBForm.FormShow(Sender: TObject);
begin
  Grid_Frame1.TabSet1.Tabs.Clear;
  Grid_Frame1.TabSet1.OnChange:=TabSet1Change;
  if FDefaultFilter<>'' then
  begin
    Grid_Frame1.TabSet1.Tabs.Add('Выбраные записи');
    Grid_Frame1.TabSet1.Tabs.Add('Все записи');
    Grid_Frame1.TabSet1.TabIndex:=0;
  end;
end;

function TDialogDBForm.getConnection: TADOConnection;
begin
  Result:=Grid_Frame1.ADOQuery.Connection;
end;

function TDialogDBForm.getQuery: string;
begin
  Result:=Grid_Frame1.Query;
end;


procedure TDialogDBForm.setConnection(const Value: TADOConnection);
begin
 Grid_Frame1.ADOQuery.Connection:=Value;
end;

procedure TDialogDBForm.SetDefaultFilter(const Value: string);
begin
  FDefaultFilter := Value;
  Grid_Frame1.DBGrid.DefaultFilter:= FDefaultFilter;
end;

procedure TDialogDBForm.SetDescrField(const Value: string);
begin
  FDescrField := Value;
end;

procedure TDialogDBForm.SetFieldName(const Value: string);
begin
  FFieldName := Value;
end;

procedure TDialogDBForm.setQuery(const Value: string);
begin
  Grid_Frame1.Query:=value + ' where (1=1)';
end;

procedure TDialogDBForm.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  if NewTab=0 then 
    Grid_Frame1.DBGrid.DefaultFilter:= FDefaultFilter
  else
    Grid_Frame1.DBGrid.DefaultFilter:= '(0=0)';
  Grid_Frame1.DBGrid.SetFilter;
end;

end.
