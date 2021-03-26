unit nmitems;

interface

uses
  Classes, Contnrs, ComObj, ActiveX, Windows;

type
  IQueryPersistent = interface
  ['{26F5B6E1-9DA5-11D3-BCAD-00902759A497}']
    function GetPersistent: TPersistent;
  end;

  TNamedItemList = class(TObjectList)
  public
    constructor Create;
    procedure AddItem(const Name: string; Item: TInterfacedObject); overload;
    procedure AddItem(const Name: string; Item: TComObject); overload;
     procedure AddItem(const Name: string; Item: IDispatch); overload;
    function GetItemIUnknown(const Name: string): IUnknown;
    function GetItemIDispatch(const Name: string; AOwner: TPersistent): IDispatch;
    function GetItemITypeInfo(const Name: string): ITypeInfo;
    procedure DeleteItem(const Name:string);
  end;

implementation

uses
  SysUtils, activescp;

type
  TNamedItem = class
  protected
    FTypeInfo: ITypeInfo;
    FUnknown: IUnknown;
    FOwner: TPersistent;
    FName: string;
  end;

{ TNamedItemList }

procedure TNamedItemList.AddItem(const Name: string; Item: TInterfacedObject);
var
  I: TNamedItem;
begin
  I := TNamedItem.Create;
  I.FTypeInfo := nil;
  I.FUnknown := Item;
  I.FOwner := TPersistent(Item);
  I.FName := AnsiUpperCase(Name);
  Add(I);
end;

procedure TNamedItemList.AddItem(const Name: string; Item: TComObject);
var
  I: TNamedItem;
begin
  I := TNamedItem.Create;
  if Item is TTypedComObject
    then I.FTypeInfo := TTypedComObjectFactory(Item.Factory).ClassInfo
    else I.FTypeInfo := nil;
  I.FUnknown := Item;
  I.FName := AnsiUpperCase(Name);
  Add(I);
end;

procedure TNamedItemList.AddItem(const Name: string; Item: IDispatch);
var
  I: TNamedItem;
begin
  I := TNamedItem.Create;
  I.FTypeInfo := nil;
  I.FUnknown := Item;
  I.FOwner := TPersistent(Item);
  I.FName := AnsiUpperCase(Name);
  Add(I);
end;

constructor TNamedItemList.Create;
begin
  inherited Create(true);
end;

procedure TNamedItemList.DeleteItem(const Name: string);
var i: integer;
begin
  for i := count - 1  downto 0 do
   with TNamedItem(Items[i]) do
      if FName = AnsiUpperCase(Name) then Delete(i);
end;

function TNamedItemList.GetItemIDispatch(const Name: string; AOwner: TPersistent): IDispatch;
var
  i: integer;
  QP: IQueryPersistent;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    with TNamedItem(Items[i]) do
      if FName = AnsiUpperCase(Name) then
        begin
          if TObject(FOwner).GetInterface(IQueryPersistent, QP) and
           (QP.GetPersistent= AOwner)
           then
           begin
             Result := FUnknown as IDispatch;
             exit;
           end;
        end;
end;

function TNamedItemList.GetItemITypeInfo(const Name: string): ITypeInfo;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    with TNamedItem(Items[i]) do
      if FName = AnsiUpperCase(Name) then
        begin
          Result := FTypeInfo;
          exit;
        end;
end;

function TNamedItemList.GetItemIUnknown(const Name: string): IUnknown;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    with TNamedItem(Items[i]) do
      if FName = AnsiUpperCase(Name) then
        begin
          Result := FUnknown;
          exit;
        end;
end;

end.
