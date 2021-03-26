unit JoinDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, Buttons, ExtCtrls;

type
  TJoinDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ValueListEditor1: TValueListEditor;
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute:boolean;
  end;



implementation

{$R *.dfm}

{ TJoinDialog }

function TJoinDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

end.
