program Config;

uses
  Forms,
  //Main in 'Main.pas' {Form2},
  //ConfigApp in 'ConfigApp.pas',
  //AddTableForm in 'AddTableForm.pas' {AddTableDialog},
  //ConstUnit in 'ConstUnit.pas' {ConstDialog},
  DataUnit in 'DataUnit.pas' {DM: TDataModule};//,
  //FieldDialogUnit in 'FieldDialogUnit.pas' {FieldDialog},
  //StyleDialogUnit in 'StyleDialogUnit.pas' {StyleDialog},
  //SelDialogUnit in 'SelDialogUnit.pas' {SelDialog},
  //QueryDialogUnit in 'QueryDialogUnit.pas' {QueryDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
