unit QueryDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ConfigApp, SynEdit, SynMemo, SynHighlighterSQL;

type
  TQueryDialog = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FXMLTableType: IXMLTableType;
    procedure SetXMLTableType(const Value: IXMLTableType);
    { Private declarations }
  public
    { Public declarations }
    CodeMemo:TSynMemo;
    sqlHighlighter:TSynSQLSyn;
    property XMLTableType:IXMLTableType read FXMLTableType write SetXMLTableType;
  end;



implementation

{$R *.dfm}
{ TQueryDialog }



procedure TQueryDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FXMLTableType.Query:=CodeMemo.Lines.Text;
  Action:=caFree;
end;

procedure TQueryDialog.FormCreate(Sender: TObject);
begin
  inherited;
  CodeMemo:=TSynMemo.Create(Application);
  CodeMemo.Parent:=TForm(Sender);
  CodeMemo.Align:=alClient;
  CodeMemo.Gutter.ShowLineNumbers:=true;
  SQLHighlighter:=TSynSQLSyn.Create(Application);
  SQLHighlighter.StringAttri.Foreground:=clMaroon;
  SQLHighlighter.IdentifierAttri.Foreground:=clNavy;
  SQLHighlighter.CommentAttribute.Foreground:=clGreen;
  SQLHighlighter.NumberAttri.Foreground:=clMaroon;
  CodeMemo.Highlighter:=SQLHighlighter;
end;

procedure TQueryDialog.SetXMLTableType(const Value: IXMLTableType);
begin
  FXMLTableType := Value;
end;

end.
