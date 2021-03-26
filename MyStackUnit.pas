unit MyStackUnit;

interface

type
  TElement = String;
  TNodePointer = ^TNode;
  TNode = record
    value: TElement;
    next: TNodePointer;
  end;

TMyStack = class(TObject)
private
  fHead: TNodePointer;
public
  constructor Create;
  destructor Destroy;
  procedure Add(item: TElement);
  function Take: TElement;
  function Top: TElement;
  function isEmpty: boolean;
end;

implementation

{ TMyStack }

procedure TMyStack.Add(item: TElement);
var
  temp: TNodePointer;
begin
  New(temp);
  temp^.value:= item;
  temp^.next:= nil;
  if (isEmpty) then
    fHead:= temp
  else
    temp^.next:= fHead;
    fHead:= temp;
end;

constructor TMyStack.Create;
begin
   fHead:= nil;
end;

destructor TMyStack.Destroy;
begin
   while not isEmpty do
    Take;
  fHead:= nil;
end;

function TMyStack.isEmpty: boolean;
begin
  result:= fHead = nil;
end;

function TMyStack.Take: TElement;
var
  temp: TNodePointer;
begin
  if not isEmpty then
  begin
    temp:= fHead;
    fHead:= fHead^.next;
    result:= temp^.value;
    Dispose(temp);
  end
  else
    result:= '';
end;

function TMyStack.Top: TElement;
begin
  if not isEmpty then Result:=fHead^.value
  else Result :=  '';
end;

end.
