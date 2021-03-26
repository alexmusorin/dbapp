unit StrDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TStringsDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
  private
    function GetStrings: TStrings;
    procedure SetStrings(const Value: TStrings);
    { Private declarations }
  public
    { Public declarations }
    property Strings:TStrings read GetStrings write SetStrings;
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

{ TStringsDialog }

function TStringsDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TStringsDialog.GetStrings: TStrings;
begin
  Result:=Memo1.Lines;
end;

procedure TStringsDialog.SetStrings(const Value: TStrings);
begin
  Memo1.Lines:=Value;
end;

end.
