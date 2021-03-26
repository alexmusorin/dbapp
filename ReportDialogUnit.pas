unit ReportDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SynEdit, SynMemo, SynHighlighterSQL, StdCtrls, Buttons, ExtCtrls,
  FR_Desgn,
  FR_E_HTM, 
  FR_E_CSV, 
  FR_E_RTF, 
  FR_E_TXT, 
  FR_RRect, 
  FR_Chart, 
  FR_BarC, 
  FR_Shape, 
  FR_ChBox, 
  FR_Rich, 
  FR_OLE, 
  FR_DSet, 
  FR_DBSet, 
  FR_Class, SQLDialogUnit, DataUnit, DB, ADODB;

type
  TReportDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel2: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    CodeMemo1:TSynMemo;
    sqlHighlighter:TSynSQLSyn;

    frCompositeReport : TfrCompositeReport;
    frDBDataSet : TfrDBDataSet; 
    frUserDataset : TfrUserDataset; 
    frOLEObject : TfrOLEObject; 
    frRichObject : TfrRichObject; 
    frCheckBoxObject : TfrCheckBoxObject; 
    frShapeObject : TfrShapeObject; 
    frBarCodeObject : TfrBarCodeObject; 
    frChartObject : TfrChartObject; 
    frRoundRectObject : TfrRoundRectObject; 
    frTextExport : TfrTextExport; 
    frRTFExport : TfrRTFExport; 
    frCSVExport : TfrCSVExport; 
    frHTMExport : TfrHTMExport; 
    frDesigner : TfrDesigner;
    procedure CreateFreeReportObject;
    function GetSQLText: WideString;
    procedure SetSQLText(const Value: WideString);
    function GetRepName: String;
    procedure SetRepName(const Value: String);
  public
    { Public declarations }
    frReport : TfrReport;
    function Execute:boolean;
    property SQLText: WideString read GetSQLText write SetSQLText;
    property RepName:String read GetRepName write SetRepName;
  end;



implementation

{$R *.dfm}

procedure TReportDialog.BitBtn3Click(Sender: TObject);
begin
  if CodeMemo1.Lines.Text<>'' then
  begin
    DM.ADOQuery1.SQL.Text:=CodeMemo1.Lines.Text;
    DM.ADOQuery1.Open;
    frDBDataSet.DataSet:=DM.ADOQuery1;
    frReport.Dataset:=frDBDataSet;
  end;
  frReport.DesignReport;
end;

procedure TReportDialog.BitBtn4Click(Sender: TObject);
begin
  With TSQLDialog.Create(Application) do
  begin
    if Execute then
      CodeMemo1.Lines.Text:=SQL;
    Free;
  end;
end;

procedure TReportDialog.CreateFreeReportObject;
begin
  frReport := TfrReport.Create(nil);
  frCompositeReport := TfrCompositeReport.Create(nil);
  frDBDataSet := TfrDBDataSet.Create(nil);
  frUserDataset := TfrUserDataset.Create(nil);
  frOLEObject := TfrOLEObject.Create(nil); 
  frRichObject := TfrRichObject.Create(nil); 
  frCheckBoxObject := TfrCheckBoxObject.Create(nil); 
  frShapeObject := TfrShapeObject.Create(nil); 
  frBarCodeObject := TfrBarCodeObject.Create(nil); 
  frChartObject := TfrChartObject.Create(nil); 
  frRoundRectObject := TfrRoundRectObject.Create(nil); 
  frTextExport := TfrTextExport.Create(nil); 
  frRTFExport := TfrRTFExport.Create(nil); 
  frCSVExport := TfrCSVExport.Create(nil); 
  frHTMExport := TfrHTMExport.Create(nil); 
  frDesigner := TfrDesigner.Create(nil);
end;

function TReportDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

procedure TReportDialog.FormCreate(Sender: TObject);
begin
  CodeMemo1:=TSynMemo.Create(Self);
  CodeMemo1.Parent:=Self;
  CodeMemo1.Align:=alClient;
  CodeMemo1.Gutter.ShowLineNumbers:=true;
  SQLHighlighter:=TSynSQLSyn.Create(Application);
  SQLHighlighter.StringAttri.Foreground:=clMaroon;
  SQLHighlighter.IdentifierAttri.Foreground:=clNavy;
  SQLHighlighter.CommentAttribute.Foreground:=clGreen;
  SQLHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo1.Highlighter:=SQLHighlighter;
  CreateFreeReportObject;
end;

function TReportDialog.GetRepName: String;
begin
  Result:=Edit1.Text;
end;

function TReportDialog.GetSQLText: WideString;
begin
  Result:= CodeMemo1.Lines.Text;
end;

procedure TReportDialog.SetRepName(const Value: String);
begin
  Edit1.Text:=Value;
end;

procedure TReportDialog.SetSQLText(const Value: WideString);
begin
  CodeMemo1.Lines.Text:=Value;
end;

end.
