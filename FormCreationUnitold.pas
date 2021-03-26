unit FormCreationUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ComCtrls, Buttons, ExtCtrls, DataUnit, DB,
  Menus;

type
  TFormCreationDialog = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Label3: TLabel;
    ValueListEditor1: TValueListEditor;
    ComboBox2: TComboBox;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    FCodeOfForm: string;
    procedure SetCodeOfForm(const Value: string);
    function getFormCaption: string;
    function getFormName: string;
    procedure setFormCaption(const Value: string);
    procedure setFormName(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property CodeOfForm:string read FCodeOfForm write SetCodeOfForm;
    property FormName:string read getFormName write setFormName;
    property FormCaption:string read getFormCaption write setFormCaption;
    function Execute:boolean;
    function GetFieldDisplay(Page:string; FieldName:string):string;
  end;



implementation

uses ConfigApp;

{$R *.dfm}

{ TFormCreationDialog }

procedure TFormCreationDialog.BitBtn1Click(Sender: TObject);
var FormCode:TStringList;
    i, top_: integer;
    FName:string;
    HSize:integer;
begin
  if (Edit1.Text<>'') and (edit2.Text<>'')  then
  begin
    FormCode:=TStringList.Create;
    with FormCode do
    begin
      Add('object '+Edit1.Text+':TForm');
      Add('  Width = 340');
      HSize:=0;
      for i := 1 to ValueListEditor1.RowCount - 1 do
        if ValueListEditor1.Values[ValueListEditor1.Keys[i]]<>'Не отображать' then
           HSize:=HSize + 22;
      Add('  Height = '+IntToStr(HSize+90));
      Add('  Caption = '''+Edit2.Text+'''');
      ///////////////////////////////////////////
      top_:=1;
      for i := 1 to ValueListEditor1.RowCount - 1 do
      begin
        if ValueListEditor1.Values[ValueListEditor1.Keys[i]]='Текст' then
        begin
          Add('object '+Edit1.Text+'_Edit'+IntToStr(i+1)+':TEdit');
          Add('  Top = '+IntToStr(22*top_-15));
          Add('  Left = 140');
          Add('  Width = 170');
          Add('  Text = ''''');
          Add('  Tag = '+IntToStr(i-1));
          //Add('  Anchors = [akLeft, akTop, akRight]');
          Add('end');
        end;
        if ValueListEditor1.Values[ValueListEditor1.Keys[i]]='Список' then
        begin
          Add('object '+Edit1.Text+'_ComboBox'+IntToStr(i+1)+':TComboBox');
          Add('  Top = '+IntToStr(22*top_-15));
          Add('  Left = 140');
          Add('  Width = 170');
          Add('  Text = ''''');
          Add('  Tag = '+IntToStr(i-1));
          //Add('  Anchors = [akLeft, akTop, akRight]');
          Add('end');
        end;
        if ValueListEditor1.Values[ValueListEditor1.Keys[i]]='Дата' then
        begin
          Add('object '+Edit1.Text+'_DateTimePicker'+IntToStr(i+1)+':TDateTimePicker');
          Add('  Top = '+IntToStr(22*top_-15));
          Add('  Left = 140');
          Add('  Width = 170');
          Add('  Tag = '+IntToStr(i-1));
         // Add('  Anchors = [akLeft, akTop, akRight]');
          Add('end');
        end;
        if (ValueListEditor1.Values[ValueListEditor1.Keys[i]]<>'Не отображать') and
        (ValueListEditor1.Values[ValueListEditor1.Keys[i]]<>'') then
        begin
          Add('object '+Edit1.Text+'_Label'+IntToStr(i+1)+':TLabel');
          Add('  Top = '+IntToStr(22*top_-10));
          Add('  Left = 10');
          Add('  Width = 170');
          FName:=GetFieldDisplay(ComboBox2.Text,ValueListEditor1.Keys[i]);
          if FName='' then FName:=ValueListEditor1.Keys[i];
          Add('  Caption = '''+FName+'''');
          Add('  Tag = '+IntToStr(i-1));
          Add('end');
          Top_:=Top_+1;
        end;
      end;
      ///////////////////////////////////////////
      Add('  object '+Edit1.Text+'_Panel1: TPanel');
      Add('       Left = 0');
      Add('       Height = 41');
      Add('	   Width = 320');
      Add('       Align = alBottom');
      Add('       TabOrder = 0');
      Add('       object '+Edit1.Text+'_Button2: TBitBtn');
      Add('         Left = 138');
      Add('         Top = 8');
      Add('         Width = 75');
      Add('         Height = 25');
      Add('         Anchors = [akTop, akRight]');
      Add('         Kind = bkOk');
      Add('         Caption = ''Записать''');
      Add('         TabOrder = 0');
      Add('     end');
      Add('       object '+Edit1.Text+'_Button3: TBitBtn');
      Add('         Left = 226');
      Add('         Top = 8');
      Add('         Width = 75');
      Add('         Height = 25');
      Add('         Anchors = [akTop, akRight]');
      Add('         Kind = bkCancel');
      Add('         Caption = ''Отмена''');
      Add('         TabOrder = 1');
      Add('     end');
      Add('   end');
      Add('end');
      FCodeOfForm:=FormCode.Text;
    end;
    ModalResult:=mrOk;
  end;
end;

procedure TFormCreationDialog.ComboBox1Change(Sender: TObject);
var Buf:TStringList;
  i: Integer;
begin
  Buf:=TStringList.Create;
  ValueListEditor1.Strings.Clear;
  if ComboBox1.Text<>'' then
  begin
    DM.ADOQuery1.SQL.Text:='select * from '+ComboBox1.Text;
    DM.ADOQuery1.Open;
    DM.ADOQuery1.GetFieldNames(Buf);
    for i := 0 to Buf.Count - 1 do
    begin
      if DM.ADOQuery1.Fields[i].DataType=ftDateTime then
         ValueListEditor1.InsertRow(Buf[i],'Дата',true)
      else ValueListEditor1.InsertRow(Buf[i],'Текст',true);
      with ValueListEditor1.ItemProps[i] do
      begin
        EditStyle:=esPickList;
        PickList.Add('Текст');
        PickList.Add('Дата');
        PickList.Add('Список');
        PickList.Add('Не отображать');
        ReadOnly:=True;
      end;
    end;
  end;
  Buf.Free
end;

function TFormCreationDialog.Execute: boolean;
begin
  Result:=(ShowModal=mrOk);
end;

procedure TFormCreationDialog.FormCreate(Sender: TObject);
begin
  inherited;
  DM.ADOConnection1.GetTableNames(ComboBox1.Items);
  DM.GetPageNames(ComboBox2.Items);
end;

function TFormCreationDialog.GetFieldDisplay(Page, FieldName: string): string;
var i,j:integer;
begin
  Result:='';
  for i := 0 to AppConf_.Tables.Count - 1 do
  begin
    if AppConf_.Tables.Table[i].Name=Page then
    for j := 0 to AppConf_.Tables.Table[i].Fields.Count - 1 do
      if AnsiUpperCase(AppConf_.Tables.Table[i].Fields.Field[j].Name)=AnsiUpperCase(FieldName) then
        Result:=AppConf_.Tables.Table[i].Fields.Field[j].Display;
  end;
    
end;

function TFormCreationDialog.getFormCaption: string;
begin
  Result:=Edit2.Text
end;

function TFormCreationDialog.getFormName: string;
begin
  Result:=Edit1.Text;
end;

procedure TFormCreationDialog.N1Click(Sender: TObject);
var i:integer;
begin
  for i := 1 to ValueListEditor1.Strings.Count do
    ValueListEditor1.Values[ValueListEditor1.Keys[i]]:='Не отображать';
end;

procedure TFormCreationDialog.SetCodeOfForm(const Value: string);
begin
  FCodeOfForm := Value;
end;

procedure TFormCreationDialog.setFormCaption(const Value: string);
begin
  Edit2.Text:=Value;
end;

procedure TFormCreationDialog.setFormName(const Value: string);
begin
  Edit1.Text:=value;
end;

end.
