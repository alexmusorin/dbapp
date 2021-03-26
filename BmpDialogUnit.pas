unit BmpDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TBmpDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Image1: TImage;
    procedure BitBtn1Click(Sender: TObject);
  private
    function getBitmat: TBitmap;
    procedure setBitmap(const Value: TBitmap);
    function getPicture: TPicture;
    procedure setPicture(const Value: TPicture);
    { Private declarations }
  public
    { Public declarations }
    property Bitmap: TBitmap read getBitmat write setBitmap;
    property Picture: TPicture read getPicture write setPicture;
    function Execute:boolean;
  end;


implementation

{$R *.dfm}

procedure TBmpDialog.BitBtn1Click(Sender: TObject);
begin
  With TOpenDialog.Create(Application) do
  begin
    Filter:='Рисунки *.bmp|*.bmp|Все файлы *.*|*.*';
    if Execute and (FileName<>'') then
      Image1.Picture.LoadFromFile(FileName);
    Free;
  end;

end;

function TBmpDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

function TBmpDialog.getBitmat: TBitmap;
begin
  Result:=Image1.Picture.Bitmap;
end;

function TBmpDialog.getPicture: TPicture;
begin
  Result:=Image1.Picture;
end;

procedure TBmpDialog.setBitmap(const Value: TBitmap);
begin
  Image1.Picture.Assign(Value);
end;

procedure TBmpDialog.setPicture(const Value: TPicture);
begin
  Image1.Picture.Assign(Value);
end;

end.
