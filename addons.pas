
{*******************************************************}
{                                                       }
{                   XML Data Binding                    }
{                                                       }
{         Generated on: 09.10.2015 14:27:07             }
{       Generated from: C:\NewTerminalBase\addons.xml   }
{   Settings stored in: C:\NewTerminalBase\addons.xdb   }
{                                                       }
{*******************************************************}

unit addons;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLAddonsType = interface;
  IXMLToolbarType = interface;
  IXMLToolitemType = interface;
  IXMLMenuType = interface;
  IXMLMenuitemType = interface;

{ IXMLAddonsType }

  IXMLAddonsType = interface(IXMLNode)
    ['{1425BCF0-7D50-4F80-A0CC-701BDF417822}']
    { Property Accessors }
    function Get_Toolbar: IXMLToolbarType;
    function Get_Menu: IXMLMenuType;
    { Methods & Properties }
    property Toolbar: IXMLToolbarType read Get_Toolbar;
    property Menu: IXMLMenuType read Get_Menu;
  end;

{ IXMLToolbarType }

  IXMLToolbarType = interface(IXMLNodeCollection)
    ['{684B3C4D-E606-4FB1-9195-9796BB5EB88E}']
    { Property Accessors }
    function Get_Toolitem(Index: Integer): IXMLToolitemType;
    { Methods & Properties }
    function Add: IXMLToolitemType;
    function Insert(const Index: Integer): IXMLToolitemType;
    property Toolitem[Index: Integer]: IXMLToolitemType read Get_Toolitem; default;
  end;

{ IXMLToolitemType }

  IXMLToolitemType = interface(IXMLNode)
    ['{E2C6AD9A-56ED-4E4F-A6C7-87C8DF983B16}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_Image: WideString;
    function Get_Code: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Image(Value: WideString);
    procedure Set_Code(Value: WideString);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property Image: WideString read Get_Image write Set_Image;
    property Code: WideString read Get_Code write Set_Code;
  end;

{ IXMLMenuType }

  IXMLMenuType = interface(IXMLNodeCollection)
    ['{26A327AE-14B3-4E13-9B26-120B65559D13}']
    { Property Accessors }
    function Get_Menuitem(Index: Integer): IXMLMenuitemType;
    { Methods & Properties }
    function Add: IXMLMenuitemType;
    function Insert(const Index: Integer): IXMLMenuitemType;
    property Menuitem[Index: Integer]: IXMLMenuitemType read Get_Menuitem; default;
  end;

{ IXMLMenuitemType }

  IXMLMenuitemType = interface(IXMLNode)
    ['{07A40D71-C5C9-4190-8996-40666D726C07}']
    { Property Accessors }
    function Get_Name: WideString;
    function Get_ShortCut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_ShortCut(Value: Integer);
    { Methods & Properties }
    property Name: WideString read Get_Name write Set_Name;
    property ShortCut: Integer read Get_ShortCut write Set_ShortCut;
  end;

{ Forward Decls }

  TXMLAddonsType = class;
  TXMLToolbarType = class;
  TXMLToolitemType = class;
  TXMLMenuType = class;
  TXMLMenuitemType = class;

{ TXMLAddonsType }

  TXMLAddonsType = class(TXMLNode, IXMLAddonsType)
  protected
    { IXMLAddonsType }
    function Get_Toolbar: IXMLToolbarType;
    function Get_Menu: IXMLMenuType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLToolbarType }

  TXMLToolbarType = class(TXMLNodeCollection, IXMLToolbarType)
  protected
    { IXMLToolbarType }
    function Get_Toolitem(Index: Integer): IXMLToolitemType;
    function Add: IXMLToolitemType;
    function Insert(const Index: Integer): IXMLToolitemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLToolitemType }

  TXMLToolitemType = class(TXMLNode, IXMLToolitemType)
  protected
    { IXMLToolitemType }
    function Get_Name: WideString;
    function Get_Image: WideString;
    function Get_Code: WideString;
    procedure Set_Name(Value: WideString);
    procedure Set_Image(Value: WideString);
    procedure Set_Code(Value: WideString);
  end;

{ TXMLMenuType }

  TXMLMenuType = class(TXMLNodeCollection, IXMLMenuType)
  protected
    { IXMLMenuType }
    function Get_Menuitem(Index: Integer): IXMLMenuitemType;
    function Add: IXMLMenuitemType;
    function Insert(const Index: Integer): IXMLMenuitemType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLMenuitemType }

  TXMLMenuitemType = class(TXMLNode, IXMLMenuitemType)
  protected
    { IXMLMenuitemType }
    function Get_Name: WideString;
    function Get_ShortCut: Integer;
    procedure Set_Name(Value: WideString);
    procedure Set_ShortCut(Value: Integer);
  end;

{ Global Functions }

function Getaddons(Doc: IXMLDocument): IXMLAddonsType;
function Loadaddons(const FileName: WideString): IXMLAddonsType;
function Newaddons: IXMLAddonsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getaddons(Doc: IXMLDocument): IXMLAddonsType;
begin
  Result := Doc.GetDocBinding('addons', TXMLAddonsType, TargetNamespace) as IXMLAddonsType;
end;

function Loadaddons(const FileName: WideString): IXMLAddonsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('addons', TXMLAddonsType, TargetNamespace) as IXMLAddonsType;
end;

function Newaddons: IXMLAddonsType;
begin
  Result := NewXMLDocument.GetDocBinding('addons', TXMLAddonsType, TargetNamespace) as IXMLAddonsType;
end;

{ TXMLAddonsType }

procedure TXMLAddonsType.AfterConstruction;
begin
  RegisterChildNode('toolbar', TXMLToolbarType);
  RegisterChildNode('menu', TXMLMenuType);
  inherited;
end;

function TXMLAddonsType.Get_Toolbar: IXMLToolbarType;
begin
  Result := ChildNodes['toolbar'] as IXMLToolbarType;
end;

function TXMLAddonsType.Get_Menu: IXMLMenuType;
begin
  Result := ChildNodes['menu'] as IXMLMenuType;
end;

{ TXMLToolbarType }

procedure TXMLToolbarType.AfterConstruction;
begin
  RegisterChildNode('toolitem', TXMLToolitemType);
  ItemTag := 'toolitem';
  ItemInterface := IXMLToolitemType;
  inherited;
end;

function TXMLToolbarType.Get_Toolitem(Index: Integer): IXMLToolitemType;
begin
  Result := List[Index] as IXMLToolitemType;
end;

function TXMLToolbarType.Add: IXMLToolitemType;
begin
  Result := AddItem(-1) as IXMLToolitemType;
end;

function TXMLToolbarType.Insert(const Index: Integer): IXMLToolitemType;
begin
  Result := AddItem(Index) as IXMLToolitemType;
end;

{ TXMLToolitemType }

function TXMLToolitemType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

procedure TXMLToolitemType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

function TXMLToolitemType.Get_Image: WideString;
begin
  Result := ChildNodes['image'].Text;
end;

procedure TXMLToolitemType.Set_Image(Value: WideString);
begin
  ChildNodes['image'].NodeValue := Value;
end;

function TXMLToolitemType.Get_Code: WideString;
begin
  Result := ChildNodes['code'].Text;
end;

procedure TXMLToolitemType.Set_Code(Value: WideString);
begin
  ChildNodes['code'].NodeValue := Value;
end;

{ TXMLMenuType }

procedure TXMLMenuType.AfterConstruction;
begin
  RegisterChildNode('menuitem', TXMLMenuitemType);
  ItemTag := 'menuitem';
  ItemInterface := IXMLMenuitemType;
  inherited;
end;

function TXMLMenuType.Get_Menuitem(Index: Integer): IXMLMenuitemType;
begin
  Result := List[Index] as IXMLMenuitemType;
end;

function TXMLMenuType.Add: IXMLMenuitemType;
begin
  Result := AddItem(-1) as IXMLMenuitemType;
end;

function TXMLMenuType.Insert(const Index: Integer): IXMLMenuitemType;
begin
  Result := AddItem(Index) as IXMLMenuitemType;
end;

{ TXMLMenuitemType }

function TXMLMenuitemType.Get_Name: WideString;
begin
  Result := AttributeNodes['name'].Text;
end;

function TXMLMenuitemType.Get_ShortCut: Integer;
begin
  Result := AttributeNodes['shortcut'].NodeValue;
end;

procedure TXMLMenuitemType.Set_Name(Value: WideString);
begin
  SetAttribute('name', Value);
end;

procedure TXMLMenuitemType.Set_ShortCut(Value: Integer);
begin
  SetAttribute('shortcut', Value);
end;

end.