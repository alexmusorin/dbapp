
{**********************************************************************}
{                                                                      }
{                           XML Data Binding                           }
{                                                                      }
{         Generated on: 05.05.2014 12:02:41                            }
{       Generated from: C:\testscriptform\configurator\ConfigApp.xml   }
{   Settings stored in: C:\testscriptform\configurator\ConfigApp.xdb   }
{                                                                      }
{**********************************************************************}

unit ConfigApp;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLConfigurationType = interface;
  IXMLVariablesType = interface;
  IXMLVariableType = interface;
  IXMLFormsType = interface;
  IXMLFormType = interface;
  IXMLFormTypeList = interface;
  IXMLModulesType = interface;
  IXMLModuleType = interface;
  IXMLModuleTypeList = interface;
  IXMLTablesType = interface;
  IXMLTableType = interface;
  IXMLTableTypeList = interface;
  IXMLFieldsType = interface;
  IXMLFieldType = interface;
  IXMLFieldTypeList = interface;
  IXMLSelectionsType = interface;
  IXMLSelectionType = interface;
  IXMLMarkingsType = interface;
  IXMLMarkType = interface;
  IXMLMarkTypeList = interface;
  IXMLActionsType = interface;
  IXMLActionType = interface;
  IXMLActionTypeList = interface;
  IXMLReportsType = interface;
  IXMLReportType = interface;
  IXMLReportTypeList = interface;
  IXMLWEBPagesType = interface;
  IXMLWEBPageType = interface;
  IXMLWEBPageTypeList = interface;

{ IXMLConfigurationType }

  IXMLConfigurationType = interface(IXMLNode)
    ['{86645559-AE0D-4F51-B0DF-BD952188BAC8}']
    { Property Accessors }
    function Get_AppName: WideString;
    function Get_Linkto: WideString;
    function Get_Variables: IXMLVariablesType;
    function Get_Forms: IXMLFormsType;
    function Get_Modules: IXMLModulesType;
    function Get_Tables: IXMLTablesType;
    function Get_Reports: IXMLReportsType;
    function Get_WEBPages: IXMLWEBPagesType;
    procedure Set_AppName(Value: WideString);
    procedure Set_Linkto(Value: WideString);
    { Methods & Properties }
    property AppName: WideString read Get_AppName write Set_AppName;
    property Linkto: WideString read Get_Linkto write Set_Linkto;
    property Variables: IXMLVariablesType read Get_Variables;
    property Forms: IXMLFormsType read Get_Forms;
    property Modules: IXMLModulesType read Get_Modules;
    property Tables: IXMLTablesType read Get_Tables;
    property Reports: IXMLReportsType read Get_Reports;
    property WEBPages: IXMLWEBPagesType read Get_WEBPages;
  end;

{ IXMLVariablesType }

  IXMLVariablesType = interface(IXMLNodeCollection)
    ['{7FEA333F-C203-4EDD-8787-668E8CBF7060}']
    { Property Accessors }
    function Get_Variable(Index: Integer): IXMLVariableType;
    { Methods & Properties }
    function Add: IXMLVariableType;
    function Insert(const Index: Integer): IXMLVariableType;
    property Variable[Index: Integer]: IXMLVariableType read Get_Variable; default;
  end;

{ IXMLVariableType }

  IXMLVariableType = interface(IXMLNode)
    ['{9E64EC2F-961E-4BAE-80E8-88ABDBB5766C}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLFormsType }

  IXMLFormsType = interface(IXMLNodeCollection)
    ['{8B44037A-4FAB-4633-AE7F-707D60D057E9}']
    { Property Accessors }
    function Get_Form(Index: Integer): IXMLFormType;
    { Methods & Properties }
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
    property Form[Index: Integer]: IXMLFormType read Get_Form; default;
  end;

{ IXMLFormType }

  IXMLFormType = interface(IXMLNode)
    ['{537B9248-347D-4CD2-B296-219AC0498C97}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Caption: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Caption(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Caption: WideString read Get_Caption write Set_Caption;
  end;

{ IXMLFormTypeList }

  IXMLFormTypeList = interface(IXMLNodeCollection)
    ['{219B288A-74D4-495A-A1AD-43FCB41D561A}']
    { Methods & Properties }
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
    function Get_Item(Index: Integer): IXMLFormType;
    property Items[Index: Integer]: IXMLFormType read Get_Item; default;
  end;

{ IXMLModulesType }

  IXMLModulesType = interface(IXMLNodeCollection)
    ['{321A610F-A7FF-4608-A7FD-9D3DE29B5C5E}']
    { Property Accessors }
    function Get_Module(Index: Integer): IXMLModuleType;
    { Methods & Properties }
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
    property Module[Index: Integer]: IXMLModuleType read Get_Module; default;
  end;

{ IXMLModuleType }

  IXMLModuleType = interface(IXMLNode)
    ['{10E197E6-06AD-4C4A-A9CA-E206845AA93D}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    function Get_MType: WideString;
    procedure Set_MType(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property MType: WideString read Get_MType write Set_MType;
  end;

{ IXMLModuleTypeList }

  IXMLModuleTypeList = interface(IXMLNodeCollection)
    ['{DC89390B-739E-4B71-A3A9-5ED8C9045A67}']
    { Methods & Properties }
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
    function Get_Item(Index: Integer): IXMLModuleType;
    property Items[Index: Integer]: IXMLModuleType read Get_Item; default;
  end;

{ IXMLTablesType }

  IXMLTablesType = interface(IXMLNodeCollection)
    ['{DCFC370D-55BF-463C-A939-5A28F024CDCF}']
    { Property Accessors }
    function Get_Table(Index: Integer): IXMLTableType;
    { Methods & Properties }
    function Add: IXMLTableType;
    function Insert(const Index: Integer): IXMLTableType;
    property Table[Index: Integer]: IXMLTableType read Get_Table; default;
  end;

{ IXMLTableType }

  IXMLTableType = interface(IXMLNode)
    ['{65B40F99-A472-4EDB-B6F2-E71EB121AADC}']
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

{ IXMLTableTypeList }

  IXMLTableTypeList = interface(IXMLNodeCollection)
    ['{94F5D19F-C046-4A5F-B83F-C5833AA063A5}']
    { Methods & Properties }
    function Add: IXMLTableType;
    function Insert(const Index: Integer): IXMLTableType;
    function Get_Item(Index: Integer): IXMLTableType;
    property Items[Index: Integer]: IXMLTableType read Get_Item; default;
  end;

{ IXMLFieldsType }

  IXMLFieldsType = interface(IXMLNodeCollection)
    ['{58A0E484-1A12-4330-B728-56321F0E7955}']
    { Property Accessors }
    function Get_Field(Index: Integer): IXMLFieldType;
    { Methods & Properties }
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
    property Field[Index: Integer]: IXMLFieldType read Get_Field; default;
  end;

{ IXMLFieldType }

  IXMLFieldType = interface(IXMLNode)
    ['{160FAF61-AEA3-4153-BDFE-925D3D8E7468}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Display: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Display(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Display: WideString read Get_Display write Set_Display;
  end;

{ IXMLFieldTypeList }

  IXMLFieldTypeList = interface(IXMLNodeCollection)
    ['{C8A17473-4E54-434A-B02E-FC480A377783}']
    { Methods & Properties }
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
    function Get_Item(Index: Integer): IXMLFieldType;
    property Items[Index: Integer]: IXMLFieldType read Get_Item; default;
  end;

{ IXMLSelectionsType }

  IXMLSelectionsType = interface(IXMLNodeCollection)
    ['{EB58A48A-AF25-4283-92A6-1E7DCF71CFC7}']
    { Property Accessors }
    function Get_Selection(Index: Integer): IXMLSelectionType;
    { Methods & Properties }
    function Add: IXMLSelectionType;
    function Insert(const Index: Integer): IXMLSelectionType;
    property Selection[Index: Integer]: IXMLSelectionType read Get_Selection; default;
  end;

{ IXMLSelectionType }

  IXMLSelectionType = interface(IXMLNode)
    ['{A55CB993-0D38-4B1B-925B-C5B97AE5BC0B}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLMarkingsType }

  IXMLMarkingsType = interface(IXMLNodeCollection)
    ['{C41FB982-1B64-4FCC-8F21-15581864E20C}']
    { Property Accessors }
    function Get_Mark(Index: Integer): IXMLMarkType;
    { Methods & Properties }
    function Add: IXMLMarkType;
    function Insert(const Index: Integer): IXMLMarkType;
    property Mark[Index: Integer]: IXMLMarkType read Get_Mark; default;
  end;

{ IXMLMarkType }

  IXMLMarkType = interface(IXMLNode)
    ['{100F1F67-2B22-4C27-8030-5466A6F5BC93}']
    { Property Accessors }
    function Get_Background: Integer;
    function Get_Foreground: Integer;
    function Get_Style: WideString;
    procedure Set_Background(Value: Integer);
    procedure Set_Foreground(Value: Integer);
    procedure Set_Style(Value: WideString);
    { Methods & Properties }
    property Background: Integer read Get_Background write Set_Background;
    property Foreground: Integer read Get_Foreground write Set_Foreground;
    property Style: WideString read Get_Style write Set_Style;
  end;

{ IXMLMarkTypeList }

  IXMLMarkTypeList = interface(IXMLNodeCollection)
    ['{14E860C3-50BB-47A4-BF68-381A86D9748A}']
    { Methods & Properties }
    function Add: IXMLMarkType;
    function Insert(const Index: Integer): IXMLMarkType;
    function Get_Item(Index: Integer): IXMLMarkType;
    property Items[Index: Integer]: IXMLMarkType read Get_Item; default;
  end;

{ IXMLActionsType }

  IXMLActionsType = interface(IXMLNodeCollection)
    ['{965C70F2-7258-49D5-BB75-4F3B7DF9D5A7}']
    { Property Accessors }
    function Get_Action(Index: Integer): IXMLActionType;
    { Methods & Properties }
    function Add: IXMLActionType;
    function Insert(const Index: Integer): IXMLActionType;
    property Action[Index: Integer]: IXMLActionType read Get_Action; default;
  end;

{ IXMLActionType }

  IXMLActionType = interface(IXMLNode)
    ['{D0B97D29-1D57-4C14-A6EB-891E03C06E49}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Imageindex: Integer;
    function Get_Popup: WideString;
    function Get_ShortCut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Imageindex(Value: Integer);
    procedure Set_Popup(Value: WideString);
    procedure Set_ShortCut(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Imageindex: Integer read Get_Imageindex write Set_Imageindex;
    property Popup: WideString read Get_Popup write Set_Popup;
    property ShortCut: Integer read Get_ShortCut write Set_ShortCut;
  end;

{ IXMLActionTypeList }

  IXMLActionTypeList = interface(IXMLNodeCollection)
    ['{EC982A06-3933-4AA2-AEB7-A2DED3A2968B}']
    { Methods & Properties }
    function Add: IXMLActionType;
    function Insert(const Index: Integer): IXMLActionType;
    function Get_Item(Index: Integer): IXMLActionType;
    property Items[Index: Integer]: IXMLActionType read Get_Item; default;
  end;

{ IXMLReportsType }

  IXMLReportsType = interface(IXMLNodeCollection)
    ['{D47ECF71-C52B-4781-9E81-2E52039DA596}']
    { Property Accessors }
    function Get_Report(Index: Integer): IXMLReportType;
    { Methods & Properties }
    function Add: IXMLReportType;
    function Insert(const Index: Integer): IXMLReportType;
    property Report[Index: Integer]: IXMLreportType read Get_Report; default;
  end;

{ IXMLReportType }

  IXMLReportType = interface(IXMLNode)
    ['{DFB0EA33-22D6-43B8-AAF0-0182756D11A2}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    function Get_SQL: WideString;
    procedure Set_SQL(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property SQL: WideString read Get_SQL write Set_SQL;
  end;

{ IXMLReportTypeList }

  IXMLReportTypeList = interface(IXMLNodeCollection)
    ['{ABCB309F-C2B8-441D-AA2B-7FF2AFCB13C0}']
    { Methods & Properties }
    function Add: IXMLReportType;
    function Insert(const Index: Integer): IXMLReportType;
    function Get_Item(Index: Integer): IXMLReportType;
    property Items[Index: Integer]: IXMLReportType read Get_Item; default;
  end;

  { IXMLWEBPagesType }

  IXMLWEBPagesType = interface(IXMLNodeCollection)
    ['{76E95282-0327-4205-B9A6-DF3CD22B7EE9}']
    { Property Accessors }
    function Get_WEBPage(Index: Integer): IXMLWEBPageType;
    { Methods & Properties }
    function Add: IXMLWEBPageType;
    function Insert(const Index: Integer): IXMLWEBPageType;
    property WEBPage[Index: Integer]: IXMLWEBPageType read Get_WEBPage; default;
  end;

{ IXMLWEBPageType }

  IXMLWEBPageType = interface(IXMLNode)
    ['{3C2257A8-6EB6-4C7D-8539-36097C1B2B1E}']
    { Property Accessors }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
  end;

{ IXMLWEBPageTypeList }

  IXMLWEBPageTypeList = interface(IXMLNodeCollection)
    ['{8207A9A0-9A87-4AB0-9265-DA0BB0CE033D}']
    { Methods & Properties }
    function Add: IXMLWEBPageType;
    function Insert(const Index: Integer): IXMLWEBPageType;
    function Get_Item(Index: Integer): IXMLWEBPageType;
    property Items[Index: Integer]: IXMLWEBPageType read Get_Item; default;
  end;


{ Forward Decls }

  TXMLConfigurationType = class;
  TXMLVariablesType = class;
  TXMLVariableType = class;
  TXMLFormsType = class;
  TXMLFormType = class;
  TXMLFormTypeList = class;
  TXMLModulesType = class;
  TXMLModuleType = class;
  TXMLModuleTypeList = class;
  TXMLTablesType = class;
  TXMLTableType = class;
  TXMLTableTypeList = class;
  TXMLFieldsType = class;
  TXMLFieldType = class;
  TXMLFieldTypeList = class;
  TXMLSelectionsType = class;
  TXMLSelectionType = class;
  TXMLMarkingsType = class;
  TXMLMarkType = class;
  TXMLMarkTypeList = class;
  TXMLActionsType = class;
  TXMLActionType = class;
  TXMLActionTypeList = class;
  TXMLReportsType = class;
  TXMLReportType = class;
  TXMLReportTypeList = class;
  TXMLWEBPagesType = class;
  TXMLWEBPageType = class;
  TXMLWEBPageTypeList = class;

{ TXMLConfigurationType }

  TXMLConfigurationType = class(TXMLNode, IXMLConfigurationType)
  protected
    { IXMLConfigurationType }
    function Get_AppName: WideString;
    function Get_Linkto: WideString;
    function Get_Variables: IXMLVariablesType;
    function Get_Forms: IXMLFormsType;
    function Get_Modules: IXMLModulesType;
    function Get_Tables: IXMLTablesType;
    function Get_Reports: IXMLReportsType;
    function Get_WEBPages: IXMLWEBPagesType;
    procedure Set_AppName(Value: WideString);
    procedure Set_Linkto(Value: WideString);
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

{ TXMLFormTypeList }

  TXMLFormTypeList = class(TXMLNodeCollection, IXMLFormTypeList)
  protected
    { IXMLFormTypeList }
    function Add: IXMLFormType;
    function Insert(const Index: Integer): IXMLFormType;
    function Get_Item(Index: Integer): IXMLFormType;
  end;

{ TXMLModulesType }

  TXMLModulesType = class(TXMLNodeCollection, IXMLModulesType)
  protected
    { IXMLModulesType }
    function Get_Module(Index: Integer): IXMLModuleType;
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
    procedure Set_Name(Value: WideString);
    function Get_MType: WideString;
    procedure Set_MType(Value: WideString);
  end;

{ TXMLModuleTypeList }

  TXMLModuleTypeList = class(TXMLNodeCollection, IXMLModuleTypeList)
  protected
    { IXMLModuleTypeList }
    function Add: IXMLModuleType;
    function Insert(const Index: Integer): IXMLModuleType;
    function Get_Item(Index: Integer): IXMLModuleType;
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

{ TXMLTableTypeList }

  TXMLTableTypeList = class(TXMLNodeCollection, IXMLTableTypeList)
  protected
    { IXMLTableTypeList }
    function Add: IXMLTableType;
    function Insert(const Index: Integer): IXMLTableType;
    function Get_Item(Index: Integer): IXMLTableType;
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

{ TXMLFieldTypeList }

  TXMLFieldTypeList = class(TXMLNodeCollection, IXMLFieldTypeList)
  protected
    { IXMLFieldTypeList }
    function Add: IXMLFieldType;
    function Insert(const Index: Integer): IXMLFieldType;
    function Get_Item(Index: Integer): IXMLFieldType;
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
    function Get_Background: Integer;
    function Get_Foreground: Integer;
    function Get_Style: WideString;
    procedure Set_Background(Value: Integer);
    procedure Set_Foreground(Value: Integer);
    procedure Set_Style(Value: WideString);
  end;

{ TXMLMarkTypeList }

  TXMLMarkTypeList = class(TXMLNodeCollection, IXMLMarkTypeList)
  protected
    { IXMLMarkTypeList }
    function Add: IXMLMarkType;
    function Insert(const Index: Integer): IXMLMarkType;
    function Get_Item(Index: Integer): IXMLMarkType;
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
    function Get_Imageindex: Integer;
    function Get_Popup: WideString;
    function Get_ShortCut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_Imageindex(Value: Integer);
    procedure Set_Popup(Value: WideString);
    procedure Set_ShortCut(Value: Integer);
  end;

{ TXMLActionTypeList }

  TXMLActionTypeList = class(TXMLNodeCollection, IXMLActionTypeList)
  protected
    { IXMLActionTypeList }
    function Add: IXMLActionType;
    function Insert(const Index: Integer): IXMLActionType;
    function Get_Item(Index: Integer): IXMLActionType;
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
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
    function Get_SQL: WideString;
    procedure Set_SQL(Value: WideString);
  end;

{ TXMLReportTypeList }

  TXMLReportTypeList = class(TXMLNodeCollection, IXMLReportTypeList)
  protected
    { IXMLReportTypeList }
    function Add: IXMLReportType;
    function Insert(const Index: Integer): IXMLReportType;
    function Get_Item(Index: Integer): IXMLReportType;
  end;

  { TXMLWEBPagesType }

  TXMLWEBPagesType = class(TXMLNodeCollection, IXMLWEBPagesType)
  protected
    { IXMLWEBPagesType }
    function Get_WEBPage(Index: Integer): IXMLWEBPageType;
    function Add: IXMLWEBPageType;
    function Insert(const Index: Integer): IXMLWEBPageType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLWEBPageType }

  TXMLWEBPageType = class(TXMLNode, IXMLWEBPageType)
  protected
    { IXMLWEBPageType }
    function Get_Name: WideString;
    procedure Set_Name(Value: WideString);
  end;

{ TXMLWEBPageTypeList }

  TXMLWEBPageTypeList = class(TXMLNodeCollection, IXMLWEBPageTypeList)
  protected
    { IXMLWEBPageTypeList }
    function Add: IXMLWEBPageType;
    function Insert(const Index: Integer): IXMLWEBPageType;
    function Get_Item(Index: Integer): IXMLWEBPageType;
  end;

{ Global Functions }

function Getconfiguration(Doc: IXMLDocument): IXMLConfigurationType;
function Loadconfiguration(const FileName: WideString): IXMLConfigurationType;
function Newconfiguration: IXMLConfigurationType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

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
  RegisterChildNode('tables', TXMLTablesType);
  RegisterChildNode('reports', TXMLReportsType);
  RegisterChildNode('webpages', TXMLWEBPagesType);
  inherited;
end;

function TXMLConfigurationType.Get_Linkto: WideString;
begin
  Result := AttributeNodes['linkto'].Text;
end;

procedure TXMLConfigurationType.Set_AppName(Value: WideString);
begin
  SetAttribute('appname', Value);
end;

procedure TXMLConfigurationType.Set_Linkto(Value: WideString);
begin
  SetAttribute('linkto', Value);
end;

function TXMLConfigurationType.Get_Variables: IXMLVariablesType;
begin
  Result := ChildNodes['variables'] as IXMLVariablesType;
end;

function TXMLConfigurationType.Get_WEBPages: IXMLWEBPagesType;
begin
  Result := ChildNodes['webpages'] as IXMLWEBPagesType;
end;

function TXMLConfigurationType.Get_AppName: WideString;
begin
  Result := AttributeNodes['appname'].Text;
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

{ TXMLFormTypeList }

function TXMLFormTypeList.Add: IXMLFormType;
begin
  Result := AddItem(-1) as IXMLFormType;
end;

function TXMLFormTypeList.Insert(const Index: Integer): IXMLFormType;
begin
  Result := AddItem(Index) as IXMLFormType;
end;
function TXMLFormTypeList.Get_Item(Index: Integer): IXMLFormType;
begin
  Result := List[Index] as IXMLFormType;
end;

{ TXMLModulesType }

procedure TXMLModulesType.AfterConstruction;
begin
  RegisterChildNode('module', TXMLModuleType);
  ItemTag := 'module';
  ItemInterface := IXMLModuleType;
  inherited;
end;

function TXMLModulesType.Get_Module(Index: Integer): IXMLModuleType;
begin
  Result := List[Index] as IXMLModuleType;
end;

function TXMLModulesType.Add: IXMLModuleType;
begin
  Result := AddItem(-1) as IXMLModuleType;
end;

function TXMLModulesType.Insert(const Index: Integer): IXMLModuleType;
begin
  Result := AddItem(Index) as IXMLModuleType;
end;

{ TXMLModuleType }

function TXMLModuleType.Get_MType: WideString;
begin
  Result := AttributeNodes['mtype'].Text;
end;

function TXMLModuleType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLModuleType.Set_MType(Value: WideString);
begin
  SetAttribute('mtype', Value);
end;

procedure TXMLModuleType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLModuleTypeList }

function TXMLModuleTypeList.Add: IXMLModuleType;
begin
  Result := AddItem(-1) as IXMLModuleType;
end;

function TXMLModuleTypeList.Insert(const Index: Integer): IXMLModuleType;
begin
  Result := AddItem(Index) as IXMLModuleType;
end;
function TXMLModuleTypeList.Get_Item(Index: Integer): IXMLModuleType;
begin
  Result := List[Index] as IXMLModuleType;
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

{ TXMLTableTypeList }

function TXMLTableTypeList.Add: IXMLTableType;
begin
  Result := AddItem(-1) as IXMLTableType;
end;

function TXMLTableTypeList.Insert(const Index: Integer): IXMLTableType;
begin
  Result := AddItem(Index) as IXMLTableType;
end;
function TXMLTableTypeList.Get_Item(Index: Integer): IXMLTableType;
begin
  Result := List[Index] as IXMLTableType;
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

{ TXMLFieldTypeList }

function TXMLFieldTypeList.Add: IXMLFieldType;
begin
  Result := AddItem(-1) as IXMLFieldType;
end;

function TXMLFieldTypeList.Insert(const Index: Integer): IXMLFieldType;
begin
  Result := AddItem(Index) as IXMLFieldType;
end;
function TXMLFieldTypeList.Get_Item(Index: Integer): IXMLFieldType;
begin
  Result := List[Index] as IXMLFieldType;
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

function TXMLMarkType.Get_Background: Integer;
begin
  Result := AttributeNodes['background'].NodeValue;
end;

procedure TXMLMarkType.Set_Background(Value: Integer);
begin
  SetAttribute('background', Value);
end;

function TXMLMarkType.Get_Foreground: Integer;
begin
  Result := AttributeNodes['foreground'].NodeValue;
end;

procedure TXMLMarkType.Set_Foreground(Value: Integer);
begin
  SetAttribute('foreground', Value);
end;

function TXMLMarkType.Get_Style: WideString;
begin
  Result := AttributeNodes['style'].Text;
end;

procedure TXMLMarkType.Set_Style(Value: WideString);
begin
  SetAttribute('style', Value);
end;

{ TXMLMarkTypeList }

function TXMLMarkTypeList.Add: IXMLMarkType;
begin
  Result := AddItem(-1) as IXMLMarkType;
end;

function TXMLMarkTypeList.Insert(const Index: Integer): IXMLMarkType;
begin
  Result := AddItem(Index) as IXMLMarkType;
end;
function TXMLMarkTypeList.Get_Item(Index: Integer): IXMLMarkType;
begin
  Result := List[Index] as IXMLMarkType;
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

function TXMLActionType.Get_Imageindex: Integer;
begin
  Result := AttributeNodes['imageindex'].NodeValue;
end;

procedure TXMLActionType.Set_Imageindex(Value: Integer);
begin
  SetAttribute('imageindex', Value);
end;

function TXMLActionType.Get_Popup: WideString;
begin
  Result := AttributeNodes['popup'].Text;
end;

function TXMLActionType.Get_ShortCut: Integer;
begin
  Result := AttributeNodes['shortcut'].NodeValue;
end;

procedure TXMLActionType.Set_Popup(Value: WideString);
begin
  SetAttribute('popup', Value);
end;

procedure TXMLActionType.Set_ShortCut(Value: Integer);
begin
  SetAttribute('shortcut', Value);
end;

{ TXMLActionTypeList }

function TXMLActionTypeList.Add: IXMLActionType;
begin
  Result := AddItem(-1) as IXMLActionType;
end;

function TXMLActionTypeList.Insert(const Index: Integer): IXMLActionType;
begin
  Result := AddItem(Index) as IXMLActionType;
end;
function TXMLActionTypeList.Get_Item(Index: Integer): IXMLActionType;
begin
  Result := List[Index] as IXMLActionType;
end;

{ TXMLReportType }

function TXMLReportType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

function TXMLReportType.Get_SQL: WideString;
begin
  Result := AttributeNodes['sql'].Text;
end;

procedure TXMLReportType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

procedure TXMLReportType.Set_SQL(Value: WideString);
begin
  SetAttribute('sql', Value);
end;

{ TXMLReportsType }

function TXMLReportsType.Add: IXMLReportType;
begin
  Result := AddItem(-1) as IXMLReportType;
end;

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

function TXMLReportsType.Insert(const Index: Integer): IXMLReportType;
begin
  Result := AddItem(Index) as IXMLreportType;
end;

{ TXMLReportTypeList }

function TXMLReportTypeList.Add: IXMLReportType;
begin
  Result := AddItem(-1) as IXMLReportType;
end;

function TXMLReportTypeList.Get_Item(Index: Integer): IXMLReportType;
begin
  Result := List[Index] as IXMLReportType;
end;

function TXMLReportTypeList.Insert(const Index: Integer): IXMLReportType;
begin
   Result := AddItem(Index) as IXMLReportType;
end;

{ TXMLWEBPageType }

function TXMLWEBPageType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLWEBPageType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

{ TXMLWEBPagesType }

function TXMLWEBPagesType.Add: IXMLWEBPageType;
begin
  Result := AddItem(-1) as IXMLWEBPageType;
end;

procedure TXMLWEBPagesType.AfterConstruction;
begin
  RegisterChildNode('webpage', TXMLWEBPageType);
  ItemTag := 'webpage';
  ItemInterface := IXMLWEBPageType;
  inherited;
end;

function TXMLWEBPagesType.Get_WEBPage(Index: Integer): IXMLWEBPageType;
begin
  Result := List[Index] as IXMLWEBPageType;
end;

function TXMLWEBPagesType.Insert(const Index: Integer): IXMLWEBPageType;
begin
  Result := AddItem(Index) as IXMLWEBPageType;
end;

{ TXMLWEBPageTypeList }

function TXMLWEBPageTypeList.Add: IXMLWEBPageType;
begin
  Result := AddItem(-1) as IXMLWEBPageType;
end;

function TXMLWEBPageTypeList.Get_Item(Index: Integer): IXMLWEBPageType;
begin
  Result := List[Index] as IXMLWEBPageType;
end;

function TXMLWEBPageTypeList.Insert(const Index: Integer): IXMLWEBPageType;
begin
   Result := AddItem(Index) as IXMLWEBPageType;
end;

end.