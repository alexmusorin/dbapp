program Mdiapp;

uses
  Forms,
  main in 'main.pas' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  about in 'about.pas' {AboutBox},
  configapp in 'configapp.pas',
  DataUnit in 'DataUnit.pas' {DM: TDataModule},
  FormCHILDUnit in 'FormCHILDUnit.pas' {FormDialog},
  CodeFOrmUnit in 'CodeFOrmUnit.pas' {CodeForm},
  FormCreationUnit in 'FormCreationUnit.pas' {FormCreationDialog},
  TableObj in 'TableObj.pas',
  dbgobj in 'dbgobj.pas',
  AddActionUnit in 'AddActionUnit.pas' {AddActionDialog},
  QueryUnit in 'QueryUnit.pas',
  TestFormUnit in 'TestFormUnit.pas' {TestDialog},
  GridFrame in 'GridFrame.pas' {Grid_Frame: TFrame},
  LinkTableUnit in 'LinkTableUnit.pas',
  dlgConfirmReplace in 'dlgConfirmReplace.pas' {ConfirmReplaceDialog},
  dlgReplaceText in 'dlgReplaceText.pas',
  dlgSearchText in 'dlgSearchText.pas' {TextSearchDialog},
  DialogDB in 'DialogDB.pas' {DialogDBForm},
  SQLDialogUnit in 'SQLDialogUnit.pas' {SQLDialog},
  ConfigDialogUnit in 'ConfigDialogUnit.pas' {ConfigDialog},
  ModuleDialogUnit in 'ModuleDialogUnit.pas' {ModuleDialog},
  JoinDialogUnit in 'JoinDialogUnit.pas' {JoinDialog},
  ReportDialogUnit in 'ReportDialogUnit.pas' {ReportDialog},
  ReportFormUnit in 'ReportFormUnit.pas' {ReportForm},
  ReportObj in 'ReportObj.pas',
  BrowserFormUnit in 'BrowserFormUnit.pas' {BrowserForm},
  ConfIEProtocol in 'ConfIEProtocol.pas',
  WEBDialogUnit in 'WEBDialogUnit.pas' {WEBDialog},
  HTMLEditUnit in 'HTMLEditUnit.pas' {HTMLEdit},
  CollectionUnit in 'CollectionUnit.pas',
  AppObjectsUnit in 'AppObjectsUnit.pas',
  addons in 'addons.pas',
  CodeObj in 'CodeObj.pas',
  addonseditunit in 'addonseditunit.pas' {AddOnsEditor},
  UnitMyForm in 'UnitMyForm.pas' {MyForm},
  TreeItemsDialogUnit in 'TreeItemsDialogUnit.pas' {TreeItemsDialog},
  ObjectBrowserUnit in 'ObjectBrowserUnit.pas' {OjBrowForm},
  xmlbrowserdata in 'xmlbrowserdata.pas',
  ModuleGroupDialogUnit in 'ModuleGroupDialogUnit.pas' {ModulegroupDialog};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Данные 0.1';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TAboutBox, AboutBox);
 // Application.CreateForm(TModulegroupDialog, ModulegroupDialog);
  //Application.CreateForm(TOjBrowForm, OjBrowForm);
  //Application.CreateForm(TTreeItemsDialog, TreeItemsDialog);
  //Application.CreateForm(TMyForm, MyForm);
  //Application.CreateForm(TAddOnsEditor, AddOnsEditor);
  Application.Run;
end.
