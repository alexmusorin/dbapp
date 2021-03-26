unit GridFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, ADODB, FilterDBGrid, ExtCtrls, MyUtils, StrUtils, Grids, DBGrids,
  StdCtrls, Menus, ImgList, ComCtrls, ToolWin, CheckLst, Masks, Tabs, ConfigApp;

type
  TStyleType = record
     FontColor: TColor;
     FontName: TFontName;
     FontSize: integer;
     BrushColor: TColor;
     FontStyle: TFontStyles;
     ImageIndex: integer;
     Field: String;
     Condition: String;
  end;

  TDataChangeEvent = procedure(Sender: TObject; Field: TField) of object;
  TDataSetNotifyEvent = procedure(Sender: TObject; DataSet: TDataSet) of object;

  TGrid_Frame = class(TFrame)
    DataSource: TDataSource;
    ADOQuery: TADOQuery;
    FilterPanel: TPanel;
    ImageList1: TImageList;
    TabSet1: TTabSet;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure ADOQueryAfterScroll(DataSet: TDataSet);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
  private
    { Private declarations }
    FCellStyles:TStringList;
    FQuery:String;
    FOnDataChange: TDataChangeEvent;
    FAfterScroll:TDataSetNotifyEvent;
    FDBPopUpMenu: TPopupMenu;
    function GetQuery: string;
    procedure SetQuery(const Value: string);
    function GetCellstyles: TStringList;
    procedure setCellStyles(const Value: TStringList);
    procedure SetDBPopUpMenu(const Value: TPopupMenu);

  public
    DBGrid: TFilterDBGrid;
    property DBPopUpMenu:TPopupMenu read FDBPopUpMenu write SetDBPopUpMenu;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Refresh;
  published
    property Query: string read GetQuery write SetQuery;
    property OnDataChange: TDataChangeEvent read FOnDataChange write FOnDataChange;
    property AfterScroll: TDataSetNotifyEvent read FAfterScroll write FAfterScroll;
  end;

implementation

uses XMLIntf;



{$R *.dfm}

{ TFrame1 }





procedure TGrid_Frame.ADOQueryAfterScroll(DataSet: TDataSet);
begin
  if Assigned(FAfterScroll) then FAfterScroll(Self, DataSet);
end;

procedure TGrid_Frame.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  If Assigned(FOnDataChange) then FOnDataChange(Sender, Field);
end;

destructor TGrid_Frame.Destroy;
begin
  DBGrid.Free;
  inherited;
end;

type TCustomDBGridCr = class(TCustomDBGrid);






constructor TGrid_Frame.Create(AOwner: TComponent);
begin
  inherited;
  FCellStyles:=TStringList.Create;
  DBGrid:=TFilterDBGrid.Create(FilterPanel);
  //DBGrid.Name:='FilterDBGrid';
  DBGrid.Align:=alClient;
  DBGrid.DataSource:=DataSource;
  //DBGrid.OnDrawDataCell := DrawDataCell_;
  //DBGrid.PopupMenu:=PopUpMenu1;
  //DBGrid.Options := DBGrid.Options + [dgRowSelect];
  DbGrid.Parent:=FilterPanel;
  DbGrid.Font.Name:='Tahoma';
  //DBGrid.ImageList:=Imagelist1;
end;


function TGrid_Frame.GetQuery: string;
begin
  Result:= FQuery;
end;


procedure TGrid_Frame.Refresh;
begin
  DBGrid.Refresh;
end;



procedure TGrid_Frame.SetQuery(const Value: string);
var i:integer;
    NewCol:TColumn;
begin
  FQuery:=Value;
  ADOQuery.Close;
  ADOQuery.SQL.Text:=FQuery;
  ADOQuery.Open;
  DBGrid.Columns.Clear;
  for i := 0 to ADOQuery.FieldCount - 1 do
  begin
    NewCol:=DbGrid.Columns.Add;
    NewCol.FieldName:=ADOQuery.Fields.Fields[i].FieldName;
    NewCol.Title.Font.Style:=[fsBold];
  end;
  DBGrid.SetFieldLabels;
end;

procedure TGrid_Frame.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  //ShowMessage(IXMLSelectionType(Pointer(TTabSet(Sender).Tabs.Objects[newtab])).Text);
  DBGrid.DefaultFilter:=IXMLSelectionType(Pointer(TTabSet(Sender).Tabs.Objects[newtab])).Text;
  DBGrid.SetFilter;
end;

function TGrid_Frame.GetCellstyles: TStringList;
begin
  Result:=FCellStyles;
end;

procedure TGrid_Frame.setCellStyles(const Value: TStringList);
begin
  FCellStyles.Assign(Value);
end;

procedure TGrid_Frame.SetDBPopUpMenu(const Value: TPopupMenu);
begin
  FDBPopUpMenu := Value;
  DBGrid.PopupMenu:= FDBPopUpMenu;
end;

end.
