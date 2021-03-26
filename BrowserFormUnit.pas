unit BrowserFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ImgList, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  ActnList, StrUtils;

type
  TBrowserForm = class(TForm)
    WB: TWebBrowser;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ImageList1: TImageList;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Edit1: TEdit;
    procedure WBCommandStateChange(ASender: TObject; Command: Integer;
      Enable: WordBool);
    procedure FormResize(Sender: TObject);
    procedure WBDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function getUri: String;
    { Private declarations }
  public
    { Public declarations }
    property HTTPURI:String read getUri;
  end;



implementation

uses DataUnit;

{$R *.dfm}

procedure TBrowserForm.Action1Execute(Sender: TObject);
begin
  WB.GoBack;
end;

procedure TBrowserForm.Action2Execute(Sender: TObject);
begin
  WB.GoForward;
end;

procedure TBrowserForm.Action3Execute(Sender: TObject);
begin
  WB.Refresh;
end;

procedure TBrowserForm.Action4Execute(Sender: TObject);
begin
  WB.Navigate(Edit1.Text);
end;

procedure TBrowserForm.FormCreate(Sender: TObject);
begin
  inherited;
  Action1.Enabled:=false;
  Action2.Enabled:=false;
end;

procedure TBrowserForm.FormResize(Sender: TObject);
begin
  //Panel1.Width:=TForm(Sender).Width-119;
end;

function TBrowserForm.getUri: String;
begin
  Result:=WB.LocationURL
end;

procedure TBrowserForm.WBCommandStateChange(ASender: TObject; Command: Integer;
  Enable: WordBool);
begin
  Case Command of
    CSC_NAVIGATEBACK:Action1.Enabled:=Enable;
    CSC_NAVIGATEFORWARD:Action2.Enabled:=Enable;
  End;
end;

procedure TBrowserForm.WBDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var StrBuf:TStringList;
    VarText:String;
    i:integer;
    varindex:integer;
begin
  Edit1.Text:=WB.LocationURL;
  if (Pos('https://oauth.vk.com/blank.html',Edit1.Text)<>0) and (Pos('access_token',Edit1.Text)<>0) then
  begin
    VarText:='';
    VarIndex:=-1;
    StrBuf:=TStringList.Create;
    StrBuf.Text:=AnsiReplaceStr(AnsiReplaceStr(Edit1.Text,'https://oauth.vk.com/blank.html#',''),'&',#13);
    for i := 0 to StrBuf.Count - 1 do
    begin
      VarText:=VarText + StrBuf.Names[i]+'='+StrBuf.Values[StrBuf.Names[i]]+ #13#10
    end;  
    StrBuf.Free;
    for i := 0 to AppConf_.Variables.Count - 1 do
    begin
      if AppConf_.Variables.Variable[i].Name='VK.OAUTH' then
      begin
        VarIndex:=i;
        AppConf_.Variables.Variable[i].Text:=VarText;
      end
    end;
    if VarIndex=-1 then
    begin
      with AppConf_.Variables.Add do
      begin
        Name:='VK.OAUTH';
        Text:=VarText;
      end;
    end;
  end;
end;

end.
