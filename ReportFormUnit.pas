unit ReportFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, FR_Desgn,
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
  FR_Class, FR_View;

type
  TReportForm = class(TForm)
    ToolBar1: TToolBar;
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
    ImageList1: TImageList;
    ToolButton12: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
  private
    { Private declarations }
    frPreview1: TfrPreview;
    frCompositeReport : TfrCompositeReport;
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
  public
    { Public declarations }
    frReport : TfrReport;
    frDBDataSet : TfrDBDataSet;
  end;



implementation

{$R *.dfm}

procedure TReportForm.CreateFreeReportObject;
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
  frPreview1 := TfrPreview.Create(Self);
  frPreview1.Parent:=Self;
  frPreview1.Align:=alClient;
  frReport.Preview:= frPreview1;
end;

procedure TReportForm.FormCreate(Sender: TObject);
begin
  inherited;
  CreateFreeReportObject;
end;

procedure TReportForm.FormDestroy(Sender: TObject);
begin
  frReport.Free;
  frCompositeReport.Free;
  frDBDataSet.Free;
  frUserDataset.Free;
  frOLEObject.Free;
  frRichObject.Free;
  frCheckBoxObject.Free;
  frShapeObject.Free;
  frBarCodeObject.Free;
  frChartObject.Free;
  frRoundRectObject.Free;
  frTextExport.Free;
  frRTFExport.Free;
  frCSVExport.Free;
  frHTMExport.Free;
  frDesigner.Free;
  inherited;
end;

procedure TReportForm.ToolButton10Click(Sender: TObject);
begin
  frPreview1.SaveToFile;
end;

procedure TReportForm.ToolButton11Click(Sender: TObject);
begin
  frPreview1.LoadFromFile;
end;

procedure TReportForm.ToolButton12Click(Sender: TObject);
begin
  frPreview1.Print;
end;

procedure TReportForm.ToolButton1Click(Sender: TObject);
begin
  frPreview1.Zoom := 100;
end;

procedure TReportForm.ToolButton2Click(Sender: TObject);
begin
  frPreview1.OnePage;
end;

procedure TReportForm.ToolButton3Click(Sender: TObject);
begin
  frPreview1.PageWidth;
end;

procedure TReportForm.ToolButton5Click(Sender: TObject);
begin
  frPreview1.First;
end;

procedure TReportForm.ToolButton6Click(Sender: TObject);
begin
  frPreview1.Prev;
end;

procedure TReportForm.ToolButton7Click(Sender: TObject);
begin
  frPreview1.Next;
end;

procedure TReportForm.ToolButton8Click(Sender: TObject);
begin
  frPreview1.Last;
end;

end.
