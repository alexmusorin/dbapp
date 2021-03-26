
{************************************************************}
{                                                            }
{                      XML Data Binding                      }
{                                                            }
{         Generated on: 21.08.2020 10:36:02                  }
{       Generated from: C:\Delphi2006\newxml\Terminals.xml   }
{   Settings stored in: C:\Delphi2006\newxml\Terminals.xdb   }
{                                                            }
{************************************************************}

unit configapp;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLConfigurationType = interface;
  IXMLVariablesType = interface;
  IXMLVariableType = interface;
  IXMLFormsType = interface;
  IXMLFormType = interface;
  IXMLModulesType = interface;
  IXMLModulegroupType = interface;
  IXMLModuleType = interface;
  IXMLReportsType = interface;
  IXMLReportType = interface;
  IXMLWebpagesType = interface;
  IXMLWebpageType = interface;
  IXMLTablesType = interface;
  IXMLTableType = interface;
  IXMLFieldsType = interface;
  IXMLFieldType = interface;
  IXMLSelectionsType = interface;
  IXMLSelectionType = interface;
  IXMLMarkingsType = interface;
  IXMLMarkType = interface;
  IXMLActionsType = interface;
  IXMLActionType = interface;

{ IXMLConfigurationType }

  IXMLConfigurationType = interface(IXMLNode)
    ['{F1E1F791-D5B1-4EA2-A293-3D5421DE1659}']
    { Property Accessors }
    function Get_Linkto: WideString;
    function Get_Appname: WideString;
    function Get_Variables: IXMLVariablesType;
    function Get_Forms: IXMLFormsType;
    function Get_Modules: IXMLModulesType;
    function Get_Reports: IXMLReportsType;
    function Get_Webpages: IXMLWebpagesType;
    function Get_Tables: IXMLTablesType;
    procedure Set_Linkto(Value: WideString);
    procedure Set_Appname(Value: WideString);
    { Methods & Properties }
    property Linkto: WideString read Get_Linkto write Set_Linkto;
    property Appname: WideString read Get_Appname write Set_Appname;
    property Variables: IXMLVariablesType read Get_Variables;
    property Forms: IXMLFormsType read Get_Forms;
    property Modules: IXMLModulesType read Get_Modules;
    property Reports: IXMLReportsType read Get_Reports;
    property Webpages: IXMLWebpagesType read Get_Webpages;
    property Tables: IXMLTablesType read Get_Tables;
  end;

{ IXMLVariablesType }

  IXMLVariablesType = interface(IXMLNodeCollection)
    ['{67A77DBF-20B3-4862-A299-C95566F586C1}']
    { Property Accessors }
    function Get_Variable(Index: Integer): IXMLVariableType;
    { Methods & Properties }
    function Add: IXMLVariableType;
    function Insert(const Index: Integer): IXMLVariableType;
    property Variable[Index: Integer]: IXMLVariableType read Get_Variable; default;
  end;

{ IXMLVariableType }

  IXMLVariableType = interface(IXMLNode)
    ['{C749F4A4-99CF-45DE-B895-8D0D3BE8ED8F}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLFormsType }

  IXMLFormsType = interface(IXMLNodeCollection)
    ['{238CB43F-661B-4C5D-9DCE-2400246750F0}']
    { Property Accessors }
    function Get_Form(Index: Integer): IXMLFormType;
    { Methods & Properties }
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
    property Form[Index: Integer]: IXMLFormType read Get_Form; default;
  end;

{ IXMLFormType }

  IXMLFormType = interface(IXMLNode)
    ['{074C58D4-C9AA-4C70-91F4-4515940B3262}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Caption: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Caption(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

{ IXMLModulesType }

  IXMLModulesType = interface(IXMLNodeCollection)
    ['{1DC20BBB-8F98-4FFF-BAA2-2C7C8054C8BF}']
    { Property Accessors }
    function Get_Modulegroup(Index: Integer): IXMLModulegroupType;
    { Methods & Properties }
    function Add: IXMLModulegroupType;
    function Insert(const Index: Integer): IXMLModulegroupType;
    property Modulegroup[Index: Integer]: IXMLModulegroupType read Get_Modulegroup; default;
  end;

{ IXMLModulegroupType }

  IXMLModulegroupType = interface(IXMLNodeCollection)
    ['{BF10AC34-52FE-4088-ACA1-6013586F0C88}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Visible: Integer;
    function Get_Module(Index: Integer): IXMLModuleType;
    procedure Set_Name(Value: WideString);
    procedure Set_Visible(Value: Integer);
    { Methods & Properties }
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
    property Name: WideString read Get_Name write Set_Name;
    property Visible: Integer read Get_Visible write Set_Visible;
    property Module[Index: Integer]: IXMLModuleType read Get_Module; default;
  end;

{ IXMLModuleType }

  IXMLModuleType = interface(IXMLNode)
    ['{A867F98F-0916-470B-8155-5A9AF4875D4B}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Mtype: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Mtype(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Mtype: WideString read Get_Mtype write Set_Mtype;
  end;

{ IXMLReportsType }

  IXMLReportsType = interface(IXMLNodeCollection)
    ['{D1A7D8F1-CC81-4165-8B0D-6F19E2B289A9}']
    { Property Accessors }
    function Get_Report(Index: Integer): IXMLReportType;
    { Methods & Properties }
    function Add: IXMLReportType;
    function Insert(const Index: Integer): IXMLReportType;
    property Report[Index: Integer]: IXMLReportType read Get_Report; default;
  end;

{ IXMLReportType }

  IXMLReportType = interface(IXMLNode)
    ['{EC2BD2CF-B8A8-4A21-AEAE-EF32C6D96C94}']
    { Property Accessors }
    function Get_Sql: WideString;
    function Get_Name: WideString;
    procedure Set_Sql(Value: WideString);
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Sql: WideString read Get_Sql write Set_Sql;
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLWebpagesType }

  IXMLWebpagesType = interface(IXMLNodeCollection)
    ['{58D84BE0-59D9-4504-8381-85A5E5657F8D}']
    { Property Accessors }
    function Get_Webpage(Index: Integer): IXMLWebpageType;
    { Methods & Properties }
    function Add: IXMLWebpageType;
    function Insert(const Index: Integer): IXMLWebpageType;
    property Webpage[Index: Integer]: IXMLWebpageType read Get_Webpage; default;
  end;

{ IXMLWebpageType }

  IXMLWebpageType = interface(IXMLNode)
    ['{38F79E59-63D2-42A9-A235-62B19258D0AC}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLTablesType }

  IXMLTablesType = interface(IXMLNodeCollection)
    ['{A50FCFB6-5B1A-4ECC-98A3-0AFC59754B70}']
    { Property Accessors }
    function Get_Table(Index: Integer): IXMLTableType;
    { Methods & Properties }
    function Add: IXMLTableType;
    function Insert(const Index: Integer): IXMLTableType;
    property Table[Index: Integer]: IXMLTableType read Get_Table; default;
  end;

{ IXMLTableType }

  IXMLTableType = interface(IXMLNode)
    ['{B89667B2-A56A-4C71-9092-107FE6D665E4}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Linkto: WideString;
    function Get_Query: WideString;
    function Get_Fields: IXMLFieldsType;
    function Get_Selections: IXMLSelectionsType;
    function Get_Markings: IXMLMarkingsType;
    function Get_Actions: IXMLActionsType;
    procedure Set_Name(Value: WideString);
    procedure Set_Linkto(Value: WideString);
    procedure Set_Query(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Linkto: WideString read Get_Linkto write Set_Linkto;
    property Query: WideString read Get_Query write Set_Query;
    property Fields: IXMLFieldsType read Get_Fields;
    property Selections: IXMLSelectionsType read Get_Selections;
    property Markings: IXMLMarkingsType read Get_Markings;
    property Actions: IXMLActionsType read Get_Actions;
  end;

{ IXMLFieldsType }

  IXMLFieldsType = interface(IXMLNodeCollection)
    ['{003F1108-20A6-47F0-A15F-823B2135494D}']
    { Property Accessors }
    function Get_Field(Index: Integer): IXMLFieldType;
    { Methods & Properties }
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
    property Field[Index: Integer]: IXMLFieldType read Get_Field; default;
  end;

{ IXMLFieldType }

  IXMLFieldType = interface(IXMLNode)
    ['{7FBA187A-9689-4703-8A98-53156B19B410}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Display: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Display(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Display: WideString read Get_Display write Set_Display;
  end;

{ IXMLSelectionsType }

  IXMLSelectionsType = interface(IXMLNodeCollection)
    ['{39C6DE68-D05B-4881-811E-7A733C71D691}']
    { Property Accessors }
    function Get_Selection(Index: Integer): IXMLSelectionType;
    { Methods & Properties }
    function Add: IXMLSelectionType;
    function Insert(const Index: Integer): IXMLSelectionType;
    property Selection[Index: Integer]: IXMLSelectionType read Get_Selection; default;
  end;

{ IXMLSelectionType }

  IXMLSelectionType = interface(IXMLNode)
    ['{3E33E2E9-0345-4F66-B306-B2DF8CF69962}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLMarkingsType }

  IXMLMarkingsType = interface(IXMLNodeCollection)
    ['{DF1B89BF-9355-4AF4-85D9-BECC53F25C70}']
    { Property Accessors }
    function Get_Mark(Index: Integer): IXMLMarkType;
    { Methods & Properties }
    function Add: IXMLMarkType;
    function Insert(const Index: Integer): IXMLMarkType;
    property Mark[Index: Integer]: IXMLMarkType read Get_Mark; default;
  end;

{ IXMLMarkType }

  IXMLMarkType = interface(IXMLNode)
    ['{EAE6B541-27F6-4A62-AD19-16F0D9D36B6D}']
    { Property Accessors }
    function Get_Foreground: Integer;
    function Get_Background: Integer;
    function Get_Style: WideString;
    procedure Set_Foreground(Value: Integer);
    procedure Set_Background(Value: Integer);
    procedure Set_Style(Value: WideString);
    { Methods & Properties }
    property Foreground: Integer read Get_Foreground write Set_Foreground;
    property Background: Integer read Get_Background write Set_Background;
    property Style: WideString read Get_Style write Set_Style;
  end;

{ IXMLActionsType }

  IXMLActionsType = interface(IXMLNodeCollection)
    ['{B44BA33A-C67E-4220-9040-31D476EB85AC}']
    { Property Accessors }
    function Get_Action(Index: Integer): IXMLActionType;
    { Methods & Properties }
    function Add: IXMLActionType;
    function Insert(const Index: Integer): IXMLActionType;
    property Action[Index: Integer]: IXMLActionType read Get_Action; default;
  end;

{ IXMLActionType }

  IXMLActionType = interface(IXMLNode)
    ['{F3AA1856-FA95-483A-8F54-A948998E78D4}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Popup: WideString;
    function Get_Imageindex: Integer;
    function Get_Shortcut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Popup(Value: WideString);
    procedure Set_Imageindex(Value: Integer);
    procedure Set_Shortcut(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Popup: WideString read Get_Popup write Set_Popup;
    property Imageindex: Integer read Get_Imageindex write Set_Imageindex;
    property Shortcut: Integer read Get_Shortcut write Set_Shortcut;
  end;

{ Forward Decls }

  TXMLConfigurationType = class;
  TXMLVariablesType = class;
  TXMLVariableType = class;
  TXMLFormsType = class;
  TXMLFormType = class;
  TXMLModulesType = class;
  TXMLModulegroupType = class;
  TXMLModuleType = class;
  TXMLReportsType = class;
  TXMLReportType = class;
  TXMLWebpagesType = class;
  TXMLWebpageType = class;
  TXMLTablesType = class;
  TXMLTableType = class;
  TXMLFieldsType = class;
  TXMLFieldType = class;
  TXMLSelectionsType = class;
  TXMLSelectionType = class;
  TXMLMarkingsType = class;
  TXMLMarkType = class;
  TXMLActionsType = class;
  TXMLActionType = class;

{ TXMLConfigurationType }

  TXMLConfigurationType = class(TXMLNode, IXMLConfigurationType)
  protected
    { IXMLConfigurationType }
    function Get_Linkto: WideString;
    function Get_Appname: WideString;
    function Get_Variables: IXMLVariablesType;
    function Get_Forms: IXMLFormsType;
    function Get_Modules: IXMLModulesType;
    function Get_Reports: IXMLReportsType;
    function Get_Webpages: IXMLWebpagesType;
    function Get_Tables: IXMLTablesType;
    procedure Set_Linkto(Value: WideString);
    procedure Set_Appname(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVariablesType }

  TXMLVariablesType = class(TXMLNodeCollection, IXMLVariablesType)
  protected
    { IXMLVariablesType }
    function Get_Variable(Index: Integer): IXMLVariableType;
    function Add: IXMLVariableType;
    function Insert(const Index: Integer): IXMLVariableType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLVariableType }

  TXMLVariableType = class(TXMLNode, IXMLVariableType)
  protected
    { IXMLVariableType }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
  end;

{ TXMLFormsType }

  TXMLFormsType = class(TXMLNodeCollection, IXMLFormsType)
  protected
    { IXMLFormsType }
    function Get_Form(Index: Integer): IXMLFormType;
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFormType }

  TXMLFormType = class(TXMLNode, IXMLFormType)
  protected
    { IXMLFormType }
    function Get_Name: WideString;
    function Get_Caption: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Caption(Value: WideString);
  end;

{ TXMLModulesType }

  TXMLModulesType = class(TXMLNodeCollection, IXMLModulesType)
  protected
    { IXMLModulesType }
    function Get_Modulegroup(Index: Integer): IXMLModulegroupType;
    function Add: IXMLModulegroupType;
    function Insert(const Index: Integer): IXMLModulegroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLModulegroupType }

  TXMLModulegroupType = class(TXMLNodeCollection, IXMLModulegroupType)
  protected
    { IXMLModulegroupType }
    function Get_Name: WideString;
    function Get_Visible: Integer;
    function Get_Module(Index: Integer): IXMLModuleType;
    procedure Set_Name(Value: WideString);
    procedure Set_Visible(Value: Integer);
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLModuleType }

  TXMLModuleType = class(TXMLNode, IXMLModuleType)
  protected
    { IXMLModuleType }
    function Get_Name: WideString;
    function Get_Mtype: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Mtype(Value: WideString);
  end;

{ TXMLReportsType }

  TXMLReportsType = class(TXMLNodeCollection, IXMLReportsType)
  protected
    { IXMLReportsType }
    function Get_Report(Index: Integer): IXMLReportType;
    function Add: IXMLReportType;
    function Insert(const Index: Integer): IXMLReportType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLReportType }

  TXMLReportType = class(TXMLNode, IXMLReportType)
  protected
    { IXMLReportType }
    function Get_Sql: WideString;
    function Get_Name: WideString;
    procedure Set_Sql(Value: WideString);
    procedure Set_Name(Value: WideString);
  end;

{ TXMLWebpagesType }

  TXMLWebpagesType = class(TXMLNodeCollection, IXMLWebpagesType)
  protected
    { IXMLWebpagesType }
    function Get_Webpage(Index: Integer): IXMLWebpageType;
    function Add: IXMLWebpageType;
    function Insert(const Index: Integer): IXMLWebpageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLWebpageType }

  TXMLWebpageType = class(TXMLNode, IXMLWebpageType)
  protected
    { IXMLWebpageType }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
  end;

{ TXMLTablesType }

  TXMLTablesType = class(TXMLNodeCollection, IXMLTablesType)
  protected
    { IXMLTablesType }
    function Get_Table(Index: Integer): IXMLTableType;
    function Add: IXMLTableType;
    function Insert(const Index: Integer): IXMLTableType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTableType }

  TXMLTableType = class(TXMLNode, IXMLTableType)
  protected
    { IXMLTableType }
    function Get_Name: WideString;
    function Get_Linkto: WideString;
    function Get_Query: WideString;
    function Get_Fields: IXMLFieldsType;
    function Get_Selections: IXMLSelectionsType;
    function Get_Markings: IXMLMarkingsType;
    function Get_Actions: IXMLActionsType;
    procedure Set_Name(Value: WideString);
    procedure Set_Linkto(Value: WideString);
    procedure Set_Query(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFieldsType }

  TXMLFieldsType = class(TXMLNodeCollection, IXMLFieldsType)
  protected
    { IXMLFieldsType }
    function Get_Field(Index: Integer): IXMLFieldType;
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFieldType }

  TXMLFieldType = class(TXMLNode, IXMLFieldType)
  protected
    { IXMLFieldType }
    function Get_Name: WideString;
    function Get_Display: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Display(Value: WideString);
  end;

{ TXMLSelectionsType }

  TXMLSelectionsType = class(TXMLNodeCollection, IXMLSelectionsType)
  protected
    { IXMLSelectionsType }
    function Get_Selection(Index: Integer): IXMLSelectionType;
    function Add: IXMLSelectionType;
    function Insert(const Index: Integer): IXMLSelectionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSelectionType }

  TXMLSelectionType = class(TXMLNode, IXMLSelectionType)
  protected
    { IXMLSelectionType }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
  end;

{ TXMLMarkingsType }

  TXMLMarkingsType = class(TXMLNodeCollection, IXMLMarkingsType)
  protected
    { IXMLMarkingsType }
    function Get_Mark(Index: Integer): IXMLMarkType;
    function Add: IXMLMarkType;
    function Insert(const Index: Integer): IXMLMarkType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMarkType }

  TXMLMarkType = class(TXMLNode, IXMLMarkType)
  protected
    { IXMLMarkType }
    function Get_Foreground: Integer;
    function Get_Background: Integer;
    function Get_Style: WideString;
    procedure Set_Foreground(Value: Integer);
    procedure Set_Background(Value: Integer);
    procedure Set_Style(Value: WideString);
  end;

{ TXMLActionsType }

  TXMLActionsType = class(TXMLNodeCollection, IXMLActionsType)
  protected
    { IXMLActionsType }
    function Get_Action(Index: Integer): IXMLActionType;
    function Add: IXMLActionType;
    function Insert(const Index: Integer): IXMLActionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLActionType }

  TXMLActionType = class(TXMLNode, IXMLActionType)
  protected
    { IXMLActionType }
    function Get_Name: WideString;
    function Get_Popup: WideString;
    function Get_Imageindex: Integer;
    function Get_Shortcut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Popup(Value: WideString);
    procedure Set_Imageindex(Value: Integer);
    procedure Set_Shortcut(Value: Integer);
  end;

function Getconfiguration(Doc: IXMLDocument): IXMLConfigurationType;
function Loadconfiguration(const FileName: WideString): IXMLConfigurationType;
function Newconfiguration: IXMLConfigurationType;

const
  TargetNamespace = '';

implementation

function Getconfiguration(Doc: IXMLDocument): IXMLConfigurationType;
begin
  Result := Doc.GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

function Loadconfiguration(const FileName: WideString): IXMLConfigurationType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

function Newconfiguration: IXMLConfigurationType;
begin
  Result := NewXMLDocument.GetDocBinding('configuration', TXMLConfigurationType, TargetNamespace) as IXMLConfigurationType;
end;

{ TXMLConfigurationType }

procedure TXMLConfigurationType.AfterConstruction;
begin
  RegisterChildNode('variables', TXMLVariablesType);
  RegisterChildNode('forms', TXMLFormsType);
  RegisterChildNode('modules', TXMLModulesType);
  RegisterChildNode('reports', TXMLReportsType);
  RegisterChildNode('webpages', TXMLWebpagesType);
  RegisterChildNode('tables', TXMLTablesType);
  inherited;
end;

function TXMLConfigurationType.Get_Linkto: WideString;
begin
  Result := AttributeNodes['linkto'].Text;
end;

procedure TXMLConfigurationType.Set_Linkto(Value: WideString);
begin
  SetAttribute('linkto', Value);
end;

function TXMLConfigurationType.Get_Appname: WideString;
begin
  Result := AttributeNodes['appname'].Text;
end;

procedure TXMLConfigurationType.Set_Appname(Value: WideString);
begin
  SetAttribute('appname', Value);
end;

function TXMLConfigurationType.Get_Variables: IXMLVariablesType;
begin
  Result := ChildNodes['variables'] as IXMLVariablesType;
end;

function TXMLConfigurationType.Get_Forms: IXMLFormsType;
begin
  Result := ChildNodes['forms'] as IXMLFormsType;
end;

function TXMLConfigurationType.Get_Modules: IXMLModulesType;
begin
  Result := ChildNodes['modules'] as IXMLModulesType;
end;

function TXMLConfigurationType.Get_Reports: IXMLReportsType;
begin
  Result := ChildNodes['reports'] as IXMLReportsType;
end;

function TXMLConfigurationType.Get_Webpages: IXMLWebpagesType;
begin
  Result := ChildNodes['webpages'] as IXMLWebpagesType;
end;

function TXMLConfigurationType.Get_Tables: IXMLTablesType;
begin
  Result := ChildNodes['tables'] as IXMLTablesType;
end;

{ TXMLVariablesType }

procedure TXMLVariablesType.AfterConstruction;
begin
  RegisterChildNode('variable', TXMLVariableType);
  ItemTag := 'variable';
  ItemInterface := IXMLVariableType;
  inherited;
end;

function TXMLVariablesType.Get_Variable(Index: Integer): IXMLVariableType;
begin
  Result := List[Index] as IXMLVariableType;
end;

function TXMLVariablesType.Add: IXMLVariableType;
begin
  Result := AddItem(-1) as IXMLVariableType;
end;

function TXMLVariablesType.Insert(const Index: Integer): IXMLVariableType;
begin
  Result := AddItem(Index) as IXMLVariableType;
end;

{ TXMLVariableType }

function TXMLVariableType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLVariableType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLFormsType }

procedure TXMLFormsType.AfterConstruction;
begin
  RegisterChildNode('form', TXMLFormType);
  ItemTag := 'form';
  ItemInterface := IXMLFormType;
  inherited;
end;

function TXMLFormsType.Get_Form(Index: Integer): IXMLFormType;
begin
  Result := List[Index] as IXMLFormType;
end;

function TXMLFormsType.Add: IXMLFormType;
begin
  Result := AddItem(-1) as IXMLFormType;
end;

function TXMLFormsType.Insert(const Index: Integer): IXMLFormType;
begin
  Result := AddItem(Index) as IXMLFormType;
end;

{ TXMLFormType }

function TXMLFormType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLFormType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLFormType.Get_Caption: WideString;
begin
  Result := AttributeNodes['caption'].Text;
end;

procedure TXMLFormType.Set_Caption(Value: WideString);
begin
  SetAttribute('caption', Value);
end;

{ TXMLModulesType }

procedure TXMLModulesType.AfterConstruction;
begin
  RegisterChildNode('modulegroup', TXMLModulegroupType);
  ItemTag := 'modulegroup';
  ItemInterface := IXMLModulegroupType;
  inherited;
end;

function TXMLModulesType.Get_Modulegroup(Index: Integer): IXMLModulegroupType;
begin
  Result := List[Index] as IXMLModulegroupType;
end;

function TXMLModulesType.Add: IXMLModulegroupType;
begin
  Result := AddItem(-1) as IXMLModulegroupType;
end;

function TXMLModulesType.Insert(const Index: Integer): IXMLModulegroupType;
begin
  Result := AddItem(Index) as IXMLModulegroupType;
end;

{ TXMLModulegroupType }

procedure TXMLModulegroupType.AfterConstruction;
begin
  RegisterChildNode('module', TXMLModuleType);
  ItemTag := 'module';
  ItemInterface := IXMLModuleType;
  inherited;
end;

function TXMLModulegroupType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLModulegroupType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLModulegroupType.Get_Visible: Integer;
begin
  Result := AttributeNodes['visible'].NodeValue;
end;

procedure TXMLModulegroupType.Set_Visible(Value: Integer);
begin
  SetAttribute('visible', Value);
end;

function TXMLModulegroupType.Get_Module(Index: Integer): IXMLModuleType;
begin
  Result := List[Index] as IXMLModuleType;
end;

function TXMLModulegroupType.Add: IXMLModuleType;
begin
  Result := AddItem(-1) as IXMLModuleType;
end;

function TXMLModulegroupType.Insert(const Index: Integer): IXMLModuleType;
begin
  Result := AddItem(Index) as IXMLModuleType;
end;

{ TXMLModuleType }

function TXMLModuleType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLModuleType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLModuleType.Get_Mtype: WideString;
begin
  Result := AttributeNodes['mtype'].Text;
end;

procedure TXMLModuleType.Set_Mtype(Value: WideString);
begin
  SetAttribute('mtype', Value);
end;

{ TXMLReportsType }

procedure TXMLReportsType.AfterConstruction;
begin
  RegisterChildNode('report', TXMLReportType);
  ItemTag := 'report';
  ItemInterface := IXMLReportType;
  inherited;
end;

function TXMLReportsType.Get_Report(Index: Integer): IXMLReportType;
begin
  Result := List[Index] as IXMLReportType;
end;

function TXMLReportsType.Add: IXMLReportType;
begin
  Result := AddItem(-1) as IXMLReportType;
end;

function TXMLReportsType.Insert(const Index: Integer): IXMLReportType;
begin
  Result := AddItem(Index) as IXMLReportType;
end;

{ TXMLReportType }

function TXMLReportType.Get_Sql: WideString;
begin
  Result := AttributeNodes['sql'].Text;
end;

procedure TXMLReportType.Set_Sql(Value: WideString);
begin
  SetAttribute('sql', Value);
end;

function TXMLReportType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLReportType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLWebpagesType }

procedure TXMLWebpagesType.AfterConstruction;
begin
  RegisterChildNode('webpage', TXMLWebpageType);
  ItemTag := 'webpage';
  ItemInterface := IXMLWebpageType;
  inherited;
end;

function TXMLWebpagesType.Get_Webpage(Index: Integer): IXMLWebpageType;
begin
  Result := List[Index] as IXMLWebpageType;
end;

function TXMLWebpagesType.Add: IXMLWebpageType;
begin
  Result := AddItem(-1) as IXMLWebpageType;
end;

function TXMLWebpagesType.Insert(const Index: Integer): IXMLWebpageType;
begin
  Result := AddItem(Index) as IXMLWebpageType;
end;

{ TXMLWebpageType }

function TXMLWebpageType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLWebpageType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLTablesType }

procedure TXMLTablesType.AfterConstruction;
begin
  RegisterChildNode('table', TXMLTableType);
  ItemTag := 'table';
  ItemInterface := IXMLTableType;
  inherited;
end;

function TXMLTablesType.Get_Table(Index: Integer): IXMLTableType;
begin
  Result := List[Index] as IXMLTableType;
end;

function TXMLTablesType.Add: IXMLTableType;
begin
  Result := AddItem(-1) as IXMLTableType;
end;

function TXMLTablesType.Insert(const Index: Integer): IXMLTableType;
begin
  Result := AddItem(Index) as IXMLTableType;
end;

{ TXMLTableType }

procedure TXMLTableType.AfterConstruction;
begin
  RegisterChildNode('fields', TXMLFieldsType);
  RegisterChildNode('selections', TXMLSelectionsType);
  RegisterChildNode('markings', TXMLMarkingsType);
  RegisterChildNode('actions', TXMLActionsType);
  inherited;
end;

function TXMLTableType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLTableType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLTableType.Get_Linkto: WideString;
begin
  Result := AttributeNodes['linkto'].Text;
end;

procedure TXMLTableType.Set_Linkto(Value: WideString);
begin
  SetAttribute('linkto', Value);
end;

function TXMLTableType.Get_Query: WideString;
begin
  Result := ChildNodes['query'].Text;
end;

procedure TXMLTableType.Set_Query(Value: WideString);
begin
  ChildNodes['query'].NodeValue := Value;
end;

function TXMLTableType.Get_Fields: IXMLFieldsType;
begin
  Result := ChildNodes['fields'] as IXMLFieldsType;
end;

function TXMLTableType.Get_Selections: IXMLSelectionsType;
begin
  Result := ChildNodes['selections'] as IXMLSelectionsType;
end;

function TXMLTableType.Get_Markings: IXMLMarkingsType;
begin
  Result := ChildNodes['markings'] as IXMLMarkingsType;
end;

function TXMLTableType.Get_Actions: IXMLActionsType;
begin
  Result := ChildNodes['actions'] as IXMLActionsType;
end;

{ TXMLFieldsType }

procedure TXMLFieldsType.AfterConstruction;
begin
  RegisterChildNode('field', TXMLFieldType);
  ItemTag := 'field';
  ItemInterface := IXMLFieldType;
  inherited;
end;

function TXMLFieldsType.Get_Field(Index: Integer): IXMLFieldType;
begin
  Result := List[Index] as IXMLFieldType;
end;

function TXMLFieldsType.Add: IXMLFieldType;
begin
  Result := AddItem(-1) as IXMLFieldType;
end;

function TXMLFieldsType.Insert(const Index: Integer): IXMLFieldType;
begin
  Result := AddItem(Index) as IXMLFieldType;
end;

{ TXMLFieldType }

function TXMLFieldType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLFieldType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLFieldType.Get_Display: WideString;
begin
  Result := AttributeNodes['display'].Text;
end;

procedure TXMLFieldType.Set_Display(Value: WideString);
begin
  SetAttribute('display', Value);
end;

{ TXMLSelectionsType }

procedure TXMLSelectionsType.AfterConstruction;
begin
  RegisterChildNode('selection', TXMLSelectionType);
  ItemTag := 'selection';
  ItemInterface := IXMLSelectionType;
  inherited;
end;

function TXMLSelectionsType.Get_Selection(Index: Integer): IXMLSelectionType;
begin
  Result := List[Index] as IXMLSelectionType;
end;

function TXMLSelectionsType.Add: IXMLSelectionType;
begin
  Result := AddItem(-1) as IXMLSelectionType;
end;

function TXMLSelectionsType.Insert(const Index: Integer): IXMLSelectionType;
begin
  Result := AddItem(Index) as IXMLSelectionType;
end;

{ TXMLSelectionType }

function TXMLSelectionType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLSelectionType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLMarkingsType }

procedure TXMLMarkingsType.AfterConstruction;
begin
  RegisterChildNode('mark', TXMLMarkType);
  ItemTag := 'mark';
  ItemInterface := IXMLMarkType;
  inherited;
end;

function TXMLMarkingsType.Get_Mark(Index: Integer): IXMLMarkType;
begin
  Result := List[Index] as IXMLMarkType;
end;

function TXMLMarkingsType.Add: IXMLMarkType;
begin
  Result := AddItem(-1) as IXMLMarkType;
end;

function TXMLMarkingsType.Insert(const Index: Integer): IXMLMarkType;
begin
  Result := AddItem(Index) as IXMLMarkType;
end;

{ TXMLMarkType }

function TXMLMarkType.Get_Foreground: Integer;
begin
  Result := AttributeNodes['foreground'].NodeValue;
end;

procedure TXMLMarkType.Set_Foreground(Value: Integer);
begin
  SetAttribute('foreground', Value);
end;

function TXMLMarkType.Get_Background: Integer;
begin
  Result := AttributeNodes['background'].NodeValue;
end;

procedure TXMLMarkType.Set_Background(Value: Integer);
begin
  SetAttribute('background', Value);
end;

function TXMLMarkType.Get_Style: WideString;
begin
  Result := AttributeNodes['style'].Text;
end;

procedure TXMLMarkType.Set_Style(Value: WideString);
begin
  SetAttribute('style', Value);
end;

{ TXMLActionsType }

procedure TXMLActionsType.AfterConstruction;
begin
  RegisterChildNode('action', TXMLActionType);
  ItemTag := 'action';
  ItemInterface := IXMLActionType;
  inherited;
end;

function TXMLActionsType.Get_Action(Index: Integer): IXMLActionType;
begin
  Result := List[Index] as IXMLActionType;
end;

function TXMLActionsType.Add: IXMLActionType;
begin
  Result := AddItem(-1) as IXMLActionType;
end;

function TXMLActionsType.Insert(const Index: Integer): IXMLActionType;
begin
  Result := AddItem(Index) as IXMLActionType;
end;

{ TXMLActionType }

function TXMLActionType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLActionType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLActionType.Get_Popup: WideString;
begin
  Result := AttributeNodes['popup'].Text;
end;

procedure TXMLActionType.Set_Popup(Value: WideString);
begin
  SetAttribute('popup', Value);
end;

function TXMLActionType.Get_Imageindex: Integer;
begin
  Result := AttributeNodes['imageindex'].NodeValue;
end;

procedure TXMLActionType.Set_Imageindex(Value: Integer);
begin
  SetAttribute('imageindex', Value);
end;

function TXMLActionType.Get_Shortcut: Integer;
begin
  Result := AttributeNodes['shortcut'].NodeValue;
end;

procedure TXMLActionType.Set_Shortcut(Value: Integer);
begin
  SetAttribute('shortcut', Value);
end;

end.