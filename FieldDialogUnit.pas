unit FieldDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFieldDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
  private
    function getFieldName: string;
    procedure setFieldName(const Value: string);
    function getBDField: string;
    procedure setBDField(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property FieldName:string read getFieldName write setFieldName;
    property BDField:string read getBDField write setBDField;
    function Execute: boolean;
  end;


implementation

{$R *.dfm}

{ TFieldDialog }

function TFieldDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOK);
end;

function TFieldDialog.getBDField: string;
begin
  Result:=ComboBox1.Text
end;

function TFieldDialog.getFieldName: string;
begin
  Result:=Edit1.Text;
end;

procedure TFieldDialog.setBDField(const Value: string);
begin
  ComboBox1.Text:=Value;
end;

procedure TFieldDialog.setFieldName(const Value: string);
begin
  Edit1.Text:=Value;
end;

end.
