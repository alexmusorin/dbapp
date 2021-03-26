
{***********************************************************}
{                                                           }
{                     XML Data Binding                      }
{                                                           }
{         Generated on: 22.03.2016 10:29:07                 }
{       Generated from: C:\NewTerminalBase\appobjects.xml   }
{   Settings stored in: C:\NewTerminalBase\appobjects.xdb   }
{                                                           }
{***********************************************************}

unit appobjects;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLObjectsType = interface;
  IXMLObjectType = interface;
  IXMLObjectTypeList = interface;
  IXMLPropertysType = interface;
  IXMLPropertyType = interface;
  IXMLFunctionsType = interface;
  IXMLFunctionType = interface;
  IXMLFunctionTypeList = interface;
  IXMLProceduresType = interface;
  IXMLProcedureType = interface;
  IXMLProcedureTypeList = interface;

{ IXMLObjectsType }

  IXMLObjectsType = interface(IXMLNodeCollection)
    ['{E9172972-4208-4411-9098-C16B4CA7244E}']
    { Property Accessors }
    function Get_Object_(Index: Integer): IXMLObjectType;
    { Methods & Properties }
    function Add: IXMLObjectType;
    function Insert(const Index: Integer): IXMLObjectType;
    property Object_[Index: Integer]: IXMLObjectType read Get_Object_; default;
  end;

{ IXMLObjectType }

  IXMLObjectType = interface(IXMLNode)
    ['{37B367F6-C5F0-46A3-B67A-0A3EEC174ACC}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Objclass: WideString;
    function Get_Propertys: IXMLPropertysType;
    function Get_Functions: IXMLFunctionsType;
    function Get_Procedures: IXMLProceduresType;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Objclass(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Objclass: WideString read Get_Objclass write Set_Objclass;
    property Propertys: IXMLPropertysType read Get_Propertys;
    property Functions: IXMLFunctionsType read Get_Functions;
    property Procedures: IXMLProceduresType read Get_Procedures;
  end;

{ IXMLObjectTypeList }

  IXMLObjectTypeList = interface(IXMLNodeCollection)
    ['{103488D3-42A3-4A3D-8F8F-D78EE1BD0264}']
    { Methods & Properties }
    function Add: IXMLObjectType;
    function Insert(const Index: Integer): IXMLObjectType;
    function Get_Item(Index: Integer): IXMLObjectType;
    property Items[Index: Integer]: IXMLObjectType read Get_Item; default;
  end;

{ IXMLPropertysType }

  IXMLPropertysType = interface(IXMLNodeCollection)
    ['{E0CB0DCA-0211-4FE5-92F0-3E6D644B861B}']
    { Property Accessors }
    function Get_Property_(Index: Integer): IXMLPropertyType;
    { Methods & Properties }
    function Add: IXMLPropertyType;
    function Insert(const Index: Integer): IXMLPropertyType;
    property Property_[Index: Integer]: IXMLPropertyType read Get_Property_; default;
  end;

{ IXMLPropertyType }

  IXMLPropertyType = interface(IXMLNode)
    ['{6F8B3506-05E6-451C-A65E-BA250D988949}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Desc: WideString read Get_Desc write Set_Desc;
    property Sample: WideString read Get_Sample write Set_Sample;
  end;

{ IXMLFunctionsType }

  IXMLFunctionsType = interface(IXMLNodeCollection)
    ['{765CDC89-1495-4EA8-9DEA-7FF97C36D979}']
    { Property Accessors }
    function Get_Function_(Index: Integer): IXMLFunctionType;
    { Methods & Properties }
    function Add: IXMLFunctionType;
    function Insert(const Index: Integer): IXMLFunctionType;
    property Function_[Index: Integer]: IXMLFunctionType read Get_Function_; default;
  end;

{ IXMLFunctionType }

  IXMLFunctionType = interface(IXMLNode)
    ['{30BFBCFB-495F-4DBB-9676-AB21087ED17A}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Parameters: WideString;
    function Get_Type_: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Parameters(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Parameters: WideString read Get_Parameters write Set_Parameters;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Desc: WideString read Get_Desc write Set_Desc;
    property Sample: WideString read Get_Sample write Set_Sample;
  end;

{ IXMLFunctionTypeList }

  IXMLFunctionTypeList = interface(IXMLNodeCollection)
    ['{4B4DB3FE-0B1D-4251-97D9-E049882C7993}']
    { Methods & Properties }
    function Add: IXMLFunctionType;
    function Insert(const Index: Integer): IXMLFunctionType;
    function Get_Item(Index: Integer): IXMLFunctionType;
    property Items[Index: Integer]: IXMLFunctionType read Get_Item; default;
  end;

{ IXMLProceduresType }

  IXMLProceduresType = interface(IXMLNodeCollection)
    ['{F777D49B-12A4-40C8-A257-88AF4D866C2C}']
    { Property Accessors }
    function Get_Procedure_(Index: Integer): IXMLProcedureType;
    { Methods & Properties }
    function Add: IXMLProcedureType;
    function Insert(const Index: Integer): IXMLProcedureType;
    property Procedure_[Index: Integer]: IXMLProcedureType read Get_Procedure_; default;
  end;

{ IXMLProcedureType }

  IXMLProcedureType = interface(IXMLNode)
    ['{C70E0EF4-D98C-45D1-A9D6-8D9FFB85D13C}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Parameters: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Parameters(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Parameters: WideString read Get_Parameters write Set_Parameters;
    property Desc: WideString read Get_Desc write Set_Desc;
    property Sample: WideString read Get_Sample write Set_Sample;
  end;

{ IXMLProcedureTypeList }

  IXMLProcedureTypeList = interface(IXMLNodeCollection)
    ['{8E4B1163-6736-477A-9E4D-53B915C156EF}']
    { Methods & Properties }
    function Add: IXMLProcedureType;
    function Insert(const Index: Integer): IXMLProcedureType;
    function Get_Item(Index: Integer): IXMLProcedureType;
    property Items[Index: Integer]: IXMLProcedureType read Get_Item; default;
  end;

{ Forward Decls }

  TXMLObjectsType = class;
  TXMLObjectType = class;
  TXMLObjectTypeList = class;
  TXMLPropertysType = class;
  TXMLPropertyType = class;
  TXMLFunctionsType = class;
  TXMLFunctionType = class;
  TXMLFunctionTypeList = class;
  TXMLProceduresType = class;
  TXMLProcedureType = class;
  TXMLProcedureTypeList = class;

{ TXMLObjectsType }

  TXMLObjectsType = class(TXMLNodeCollection, IXMLObjectsType)
  protected
    { IXMLObjectsType }
    function Get_Object_(Index: Integer): IXMLObjectType;
    function Add: IXMLObjectType;
    function Insert(const Index: Integer): IXMLObjectType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLObjectType }

  TXMLObjectType = class(TXMLNode, IXMLObjectType)
  protected
    { IXMLObjectType }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Objclass: WideString;
    function Get_Propertys: IXMLPropertysType;
    function Get_Functions: IXMLFunctionsType;
    function Get_Procedures: IXMLProceduresType;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Objclass(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLObjectTypeList }

  TXMLObjectTypeList = class(TXMLNodeCollection, IXMLObjectTypeList)
  protected
    { IXMLObjectTypeList }
    function Add: IXMLObjectType;
    function Insert(const Index: Integer): IXMLObjectType;
    function Get_Item(Index: Integer): IXMLObjectType;
  end;

{ TXMLPropertysType }

  TXMLPropertysType = class(TXMLNodeCollection, IXMLPropertysType)
  protected
    { IXMLPropertysType }
    function Get_Property_(Index: Integer): IXMLPropertyType;
    function Add: IXMLPropertyType;
    function Insert(const Index: Integer): IXMLPropertyType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPropertyType }

  TXMLPropertyType = class(TXMLNode, IXMLPropertyType)
  protected
    { IXMLPropertyType }
    function Get_Name: WideString;
    function Get_Type_: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
  end;

{ TXMLFunctionsType }

  TXMLFunctionsType = class(TXMLNodeCollection, IXMLFunctionsType)
  protected
    { IXMLFunctionsType }
    function Get_Function_(Index: Integer): IXMLFunctionType;
    function Add: IXMLFunctionType;
    function Insert(const Index: Integer): IXMLFunctionType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFunctionType }

  TXMLFunctionType = class(TXMLNode, IXMLFunctionType)
  protected
    { IXMLFunctionType }
    function Get_Name: WideString;
    function Get_Parameters: WideString;
    function Get_Type_: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Parameters(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
  end;

{ TXMLFunctionTypeList }

  TXMLFunctionTypeList = class(TXMLNodeCollection, IXMLFunctionTypeList)
  protected
    { IXMLFunctionTypeList }
    function Add: IXMLFunctionType;
    function Insert(const Index: Integer): IXMLFunctionType;
    function Get_Item(Index: Integer): IXMLFunctionType;
  end;

{ TXMLProceduresType }

  TXMLProceduresType = class(TXMLNodeCollection, IXMLProceduresType)
  protected
    { IXMLProceduresType }
    function Get_Procedure_(Index: Integer): IXMLProcedureType;
    function Add: IXMLProcedureType;
    function Insert(const Index: Integer): IXMLProcedureType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLProcedureType }

  TXMLProcedureType = class(TXMLNode, IXMLProcedureType)
  protected
    { IXMLProcedureType }
    function Get_Name: WideString;
    function Get_Parameters: WideString;
    function Get_Desc: WideString;
    function Get_Sample: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Parameters(Value: WideString);
    procedure Set_Desc(Value: WideString);
    procedure Set_Sample(Value: WideString);
  end;

{ TXMLProcedureTypeList }

  TXMLProcedureTypeList = class(TXMLNodeCollection, IXMLProcedureTypeList)
  protected
    { IXMLProcedureTypeList }
    function Add: IXMLProcedureType;
    function Insert(const Index: Integer): IXMLProcedureType;
    function Get_Item(Index: Integer): IXMLProcedureType;
  end;

{ Global Functions }

function Getobjects(Doc: IXMLDocument): IXMLObjectsType;
function Loadobjects(const FileName: WideString): IXMLObjectsType;
function Newobjects: IXMLObjectsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getobjects(Doc: IXMLDocument): IXMLObjectsType;
begin
  Result := Doc.GetDocBinding('objects', TXMLObjectsType, TargetNamespace) as IXMLObjectsType;
end;

function Loadobjects(const FileName: WideString): IXMLObjectsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('objects', TXMLObjectsType, TargetNamespace) as IXMLObjectsType;
end;

function Newobjects: IXMLObjectsType;
begin
  Result := NewXMLDocument.GetDocBinding('objects', TXMLObjectsType, TargetNamespace) as IXMLObjectsType;
end;

{ TXMLObjectsType }

procedure TXMLObjectsType.AfterConstruction;
begin
  RegisterChildNode('object', TXMLObjectType);
  ItemTag := 'object';
  ItemInterface := IXMLObjectType;
  inherited;
end;

function TXMLObjectsType.Get_Object_(Index: Integer): IXMLObjectType;
begin
  Result := List[Index] as IXMLObjectType;
end;

function TXMLObjectsType.Add: IXMLObjectType;
begin
  Result := AddItem(-1) as IXMLObjectType;
end;

function TXMLObjectsType.Insert(const Index: Integer): IXMLObjectType;
begin
  Result := AddItem(Index) as IXMLObjectType;
end;

{ TXMLObjectType }

procedure TXMLObjectType.AfterConstruction;
begin
  RegisterChildNode('propertys', TXMLPropertysType);
  RegisterChildNode('functions', TXMLFunctionsType);
  RegisterChildNode('procedures', TXMLProceduresType);
  inherited;
end;

function TXMLObjectType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLObjectType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLObjectType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLObjectType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLObjectType.Get_Objclass: WideString;
begin
  Result := AttributeNodes['objclass'].Text;
end;

procedure TXMLObjectType.Set_Objclass(Value: WideString);
begin
  SetAttribute('objclass', Value);
end;

function TXMLObjectType.Get_Propertys: IXMLPropertysType;
begin
  Result := ChildNodes['propertys'] as IXMLPropertysType;
end;

function TXMLObjectType.Get_Functions: IXMLFunctionsType;
begin
  Result := ChildNodes['functions'] as IXMLFunctionsType;
end;

function TXMLObjectType.Get_Procedures: IXMLProceduresType;
begin
  Result := ChildNodes['procedures'] as IXMLProceduresType;
end;

{ TXMLObjectTypeList }

function TXMLObjectTypeList.Add: IXMLObjectType;
begin
  Result := AddItem(-1) as IXMLObjectType;
end;

function TXMLObjectTypeList.Insert(const Index: Integer): IXMLObjectType;
begin
  Result := AddItem(Index) as IXMLObjectType;
end;
function TXMLObjectTypeList.Get_Item(Index: Integer): IXMLObjectType;
begin
  Result := List[Index] as IXMLObjectType;
end;

{ TXMLPropertysType }

procedure TXMLPropertysType.AfterConstruction;
begin
  RegisterChildNode('property', TXMLPropertyType);
  ItemTag := 'property';
  ItemInterface := IXMLPropertyType;
  inherited;
end;

function TXMLPropertysType.Get_Property_(Index: Integer): IXMLPropertyType;
begin
  Result := List[Index] as IXMLPropertyType;
end;

function TXMLPropertysType.Add: IXMLPropertyType;
begin
  Result := AddItem(-1) as IXMLPropertyType;
end;

function TXMLPropertysType.Insert(const Index: Integer): IXMLPropertyType;
begin
  Result := AddItem(Index) as IXMLPropertyType;
end;

{ TXMLPropertyType }

function TXMLPropertyType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLPropertyType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLPropertyType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLPropertyType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLPropertyType.Get_Desc: WideString;
begin
  Result := ChildNodes['desc'].Text;
end;

procedure TXMLPropertyType.Set_Desc(Value: WideString);
begin
  ChildNodes['desc'].NodeValue := Value;
end;

function TXMLPropertyType.Get_Sample: WideString;
begin
  Result := ChildNodes['sample'].Text;
end;

procedure TXMLPropertyType.Set_Sample(Value: WideString);
begin
  ChildNodes['sample'].NodeValue := Value;
end;

{ TXMLFunctionsType }

procedure TXMLFunctionsType.AfterConstruction;
begin
  RegisterChildNode('function', TXMLFunctionType);
  ItemTag := 'function';
  ItemInterface := IXMLFunctionType;
  inherited;
end;

function TXMLFunctionsType.Get_Function_(Index: Integer): IXMLFunctionType;
begin
  Result := List[Index] as IXMLFunctionType;
end;

function TXMLFunctionsType.Add: IXMLFunctionType;
begin
  Result := AddItem(-1) as IXMLFunctionType;
end;

function TXMLFunctionsType.Insert(const Index: Integer): IXMLFunctionType;
begin
  Result := AddItem(Index) as IXMLFunctionType;
end;

{ TXMLFunctionType }

function TXMLFunctionType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLFunctionType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLFunctionType.Get_Parameters: WideString;
begin
  Result := AttributeNodes['parameters'].Text;
end;

procedure TXMLFunctionType.Set_Parameters(Value: WideString);
begin
  SetAttribute('parameters', Value);
end;

function TXMLFunctionType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLFunctionType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLFunctionType.Get_Desc: WideString;
begin
  Result := ChildNodes['desc'].Text;
end;

procedure TXMLFunctionType.Set_Desc(Value: WideString);
begin
  ChildNodes['desc'].NodeValue := Value;
end;

function TXMLFunctionType.Get_Sample: WideString;
begin
  Result := ChildNodes['sample'].Text;
end;

procedure TXMLFunctionType.Set_Sample(Value: WideString);
begin
  ChildNodes['sample'].NodeValue := Value;
end;

{ TXMLFunctionTypeList }

function TXMLFunctionTypeList.Add: IXMLFunctionType;
begin
  Result := AddItem(-1) as IXMLFunctionType;
end;

function TXMLFunctionTypeList.Insert(const Index: Integer): IXMLFunctionType;
begin
  Result := AddItem(Index) as IXMLFunctionType;
end;
function TXMLFunctionTypeList.Get_Item(Index: Integer): IXMLFunctionType;
begin
  Result := List[Index] as IXMLFunctionType;
end;

{ TXMLProceduresType }

procedure TXMLProceduresType.AfterConstruction;
begin
  RegisterChildNode('procedure', TXMLProcedureType);
  ItemTag := 'procedure';
  ItemInterface := IXMLProcedureType;
  inherited;
end;

function TXMLProceduresType.Get_Procedure_(Index: Integer): IXMLProcedureType;
begin
  Result := List[Index] as IXMLProcedureType;
end;

function TXMLProceduresType.Add: IXMLProcedureType;
begin
  Result := AddItem(-1) as IXMLProcedureType;
end;

function TXMLProceduresType.Insert(const Index: Integer): IXMLProcedureType;
begin
  Result := AddItem(Index) as IXMLProcedureType;
end;

{ TXMLProcedureType }

function TXMLProcedureType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLProcedureType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLProcedureType.Get_Parameters: WideString;
begin
  Result := AttributeNodes['parameters'].Text;
end;

procedure TXMLProcedureType.Set_Parameters(Value: WideString);
begin
  SetAttribute('parameters', Value);
end;

function TXMLProcedureType.Get_Desc: WideString;
begin
  Result := ChildNodes['desc'].Text;
end;

procedure TXMLProcedureType.Set_Desc(Value: WideString);
begin
  ChildNodes['desc'].NodeValue := Value;
end;

function TXMLProcedureType.Get_Sample: WideString;
begin
  Result := ChildNodes['sample'].Text;
end;

procedure TXMLProcedureType.Set_Sample(Value: WideString);
begin
  ChildNodes['sample'].NodeValue := Value;
end;

{ TXMLProcedureTypeList }

function TXMLProcedureTypeList.Add: IXMLProcedureType;
begin
  Result := AddItem(-1) as IXMLProcedureType;
end;

function TXMLProcedureTypeList.Insert(const Index: Integer): IXMLProcedureType;
begin
  Result := AddItem(Index) as IXMLProcedureType;
end;
function TXMLProcedureTypeList.Get_Item(Index: Integer): IXMLProcedureType;
begin
  Result := List[Index] as IXMLProcedureType;
end;

end.