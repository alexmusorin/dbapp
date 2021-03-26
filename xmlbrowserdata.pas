
{******************************************}
{                                          }
{             XML Data Binding             }
{                                          }
{         Generated on: 05.04.2016 12:35:58 }
{       Generated from: C:\Temp\Test.xml   }
{   Settings stored in: C:\Temp\Test.xdb   }
{                                          }
{******************************************}

unit xmlbrowserdata;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLClassesType = interface;
  IXMLClassType = interface;
  IXMLClassitemType = interface;

{ IXMLClassesType }

  IXMLClassesType = interface(IXMLNodeCollection)
    ['{FD1019FF-BE3B-4B8D-8052-6A495D6ACC73}']
    { Property Accessors }
    function Get_Class_(Index: Integer): IXMLClassType;
    { Methods & Properties }
    function Add: IXMLClassType;
    function Insert(const Index: Integer): IXMLClassType;
    property Class_[Index: Integer]: IXMLClassType read Get_Class_; default;
  end;

{ IXMLClassType }

  IXMLClassType = interface(IXMLNodeCollection)
    ['{BD3C8545-37F1-4A73-9206-2445D18FA77A}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Classitem(Index: Integer): IXMLClassitemType;
    procedure Set_Name(Value: WideString);
    { Methods & Properties }
    function Add: IXMLClassitemType;
    function Insert(const Index: Integer): IXMLClassitemType;
    property Name: WideString read Get_Name write Set_Name;
    property Classitem[Index: Integer]: IXMLClassitemType read Get_Classitem; default;
  end;

{ IXMLClassitemType }

  IXMLClassitemType = interface(IXMLNode)
    ['{A26223D1-E38D-4507-948C-E3D2ED47DFF9}']
    { Property Accessors }
    function Get_Type_: WideString;
    function Get_Name: WideString;
    function Get_Param: WideString;
    function Get_Returnvalue: WideString;
    procedure Set_Type_(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_Param(Value: WideString);
    procedure Set_Returnvalue(Value: WideString);
    { Methods & Properties }
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Name: WideString read Get_Name write Set_Name;
    property Param: WideString read Get_Param write Set_Param;
    property Returnvalue: WideString read Get_Returnvalue write Set_Returnvalue;
  end;

{ Forward Decls }

  TXMLClassesType = class;
  TXMLClassType = class;
  TXMLClassitemType = class;

{ TXMLClassesType }

  TXMLClassesType = class(TXMLNodeCollection, IXMLClassesType)
  protected
    { IXMLClassesType }
    function Get_Class_(Index: Integer): IXMLClassType;
    function Add: IXMLClassType;
    function Insert(const Index: Integer): IXMLClassType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLClassType }

  TXMLClassType = class(TXMLNodeCollection, IXMLClassType)
  protected
    { IXMLClassType }
    function Get_Name: WideString;
    function Get_Classitem(Index: Integer): IXMLClassitemType;
    procedure Set_Name(Value: WideString);
    function Add: IXMLClassitemType;
    function Insert(const Index: Integer): IXMLClassitemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLClassitemType }

  TXMLClassitemType = class(TXMLNode, IXMLClassitemType)
  protected
    { IXMLClassitemType }
    function Get_Type_: WideString;
    function Get_Name: WideString;
    function Get_Param: WideString;
    function Get_Returnvalue: WideString;
    procedure Set_Type_(Value: WideString);
    procedure Set_Name(Value: WideString);
    procedure Set_Param(Value: WideString);
    procedure Set_Returnvalue(Value: WideString);
  end;

{ Global Functions }

function Getclasses(Doc: IXMLDocument): IXMLClassesType;
function Loadclasses(const FileName: WideString): IXMLClassesType;
function Newclasses: IXMLClassesType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getclasses(Doc: IXMLDocument): IXMLClassesType;
begin
  Result := Doc.GetDocBinding('classes', TXMLClassesType, TargetNamespace) as IXMLClassesType;
end;

function Loadclasses(const FileName: WideString): IXMLClassesType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('classes', TXMLClassesType, TargetNamespace) as IXMLClassesType;
end;

function Newclasses: IXMLClassesType;
begin
  Result := NewXMLDocument.GetDocBinding('classes', TXMLClassesType, TargetNamespace) as IXMLClassesType;
end;

{ TXMLClassesType }

procedure TXMLClassesType.AfterConstruction;
begin
  RegisterChildNode('class', TXMLClassType);
  ItemTag := 'class';
  ItemInterface := IXMLClassType;
  inherited;
end;

function TXMLClassesType.Get_Class_(Index: Integer): IXMLClassType;
begin
  Result := List[Index] as IXMLClassType;
end;

function TXMLClassesType.Add: IXMLClassType;
begin
  Result := AddItem(-1) as IXMLClassType;
end;

function TXMLClassesType.Insert(const Index: Integer): IXMLClassType;
begin
  Result := AddItem(Index) as IXMLClassType;
end;

{ TXMLClassType }

procedure TXMLClassType.AfterConstruction;
begin
  RegisterChildNode('classitem', TXMLClassitemType);
  ItemTag := 'classitem';
  ItemInterface := IXMLClassitemType;
  inherited;
end;

function TXMLClassType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLClassType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLClassType.Get_Classitem(Index: Integer): IXMLClassitemType;
begin
  Result := List[Index] as IXMLClassitemType;
end;

function TXMLClassType.Add: IXMLClassitemType;
begin
  Result := AddItem(-1) as IXMLClassitemType;
end;

function TXMLClassType.Insert(const Index: Integer): IXMLClassitemType;
begin
  Result := AddItem(Index) as IXMLClassitemType;
end;

{ TXMLClassitemType }

function TXMLClassitemType.Get_Type_: WideString;
begin
  Result := AttributeNodes['type'].Text;
end;

procedure TXMLClassitemType.Set_Type_(Value: WideString);
begin
  SetAttribute('type', Value);
end;

function TXMLClassitemType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLClassitemType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLClassitemType.Get_Param: WideString;
begin
  Result := AttributeNodes['param'].Text;
end;

procedure TXMLClassitemType.Set_Param(Value: WideString);
begin
  SetAttribute('param', Value);
end;

function TXMLClassitemType.Get_Returnvalue: WideString;
begin
  Result := AttributeNodes['returnvalue'].Text;
end;

procedure TXMLClassitemType.Set_Returnvalue(Value: WideString);
begin
  SetAttribute('returnvalue', Value);
end;

end.