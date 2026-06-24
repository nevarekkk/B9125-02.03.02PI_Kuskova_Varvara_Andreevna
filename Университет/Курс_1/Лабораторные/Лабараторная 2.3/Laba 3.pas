type
  Chain = ^Elem;
  Elem = record
    x, y : Integer;
    prev : Chain;
    next : Chain;
  end;
  
procedure init(var head, tail : Chain; var size : Integer);
begin
  head := nil;
  tail := nil;
  size := 0;
end;

procedure Add(var head, tail : Chain; var size : Integer; px, py : Integer);
var
  cur, new_elem : Chain;
  found : Boolean;
begin
  found := False;
  cur := head;
  while cur <> nil do
  begin
    if (cur^.x = px) and (cur^.y = py) then
      found := True;
    cur := cur^.next;
  end;
  if not found then
  begin
    New(new_elem);
    new_elem^.x:= px;
    new_elem^.y:= py;
    new_elem^.prev := nil;
    new_elem^.next := head;
    if head <> nil then
      head^.prev := new_elem
    else
    tail := new_elem;
    head := new_elem;
    size := size + 1;
  end;
end;

procedure Remove(var head, tail : Chain; var size, px, py : Integer);
var
  cur : Chain;
  found : Boolean;
begin
  found := False;
  cur := head;
  while (cur <> nil) and (not found) do
  begin
    if (cur^.x = px) and (cur^.y = py) then
    begin
      found := True;
      if cur^.prev <> nil then
        cur^.prev^.next := cur^.next
      else
        head := cur^.next;
      if cur^.next <> nil then
        cur^.next^.prev := cur^.prev
      else
        tail := cur^.prev;
      Dispose(cur);
      size := size - 1;
    end
    else
      cur := cur^.next;
  end;
end;

function Search(head : Chain; px, py : Integer) : Boolean;
var
  cur : Chain;
  found : Boolean;
begin
  found := False;
  cur := head;
  while cur <> nil do
  begin
    if (cur^.x = px) and (cur^.y = py) then
      found := True;
    cur := cur^.next;
  end;
  Search := found;
end;

function Card(size : Integer) : Integer;
begin
  Card := size;
end;

procedure Clear(var head, tail : Chain; var size : Integer);
var
  cur, ellem : Chain;
begin
  cur := head;
  while cur <> nil do
  begin
    ellem := cur^.next;
    Dispose(cur);
    cur := ellem;
  end;
  head := nil;
  tail := nil;
  size := 0;
end;

procedure PrintL(head : Chain);
var
  cur : Chain;
begin
  cur := head;
  if cur = nil then
    Write('пустоe множество')
  else
    while cur <> nil do
    begin
      Write('(', cur^.x, ',', cur^.y, ')');
      if cur^.next <> nil then
        Write(' ');
      cur := cur^.next;
    end;
end;

procedure PrintR(tail : Chain);
var
  cur : Chain;
begin
  cur := tail;
  if cur = nil then
    Write('пустоe множество')
  else
    while cur <> nil do
    begin
      Write('(', cur^.x, ';', cur^.y, ')');
      if cur^.prev <> nil then
        Write(' ');
      cur := cur^.prev;
    end;
end;

procedure Sumraz(head1, tail1 : Chain; size1 : Integer; head2, tail2 : Chain; size2 : Integer; var headR, tailR : Chain; var sizeR : Integer);
var
  cur : Chain;
begin
  Init(headR, tailR, sizeR);
  cur := head1;
  while cur <> nil do
  begin
    if not Search(head2, cur^.x, cur^.y) then
      Add(headR, tailR, sizeR, cur^.x, cur^.y);
    cur := cur^.next;
  end;
  cur := head2;
  while cur <> nil do
  begin
    if not Search(head1, cur^.x, cur^.y) then
      Add(headR, tailR, sizeR, cur^.x, cur^.y);
    cur := cur^.next;
  end;
end;

procedure printe(var head, tail : Chain; var size : Integer; name : String);
var
  n, i, px, py : Integer;
begin
  Write('Введите количество элементов для ', name, ': ');
  ReadLn(n);
  for i := 1 to n do
  begin
    Write('  Элемент ', i, ' (x y): ');
    ReadLn(px, py);
    Add(head, tail, size, px, py);
  end;
end;

var
  head1, tail1, head2, tail2, headR, tailR : Chain;
  size1, size2, sizeR,i : Integer;
begin
  init(head1, tail1, size1);
  init(head2, tail2, size2);
  init(headR, tailR, sizeR);
  
  for i:=1 to 10 do
    add(head1,tail1, size1, i mod 3, i mod 3);
 // printe(head1, tail1, size1, 'S1'); WriteLn;
 // printe(head2, tail2, size2, 'S2'); WriteLn;
  Write('S1 слева направо = '); PrintL(head1); WriteLn;
  Write('S1 справа налево = '); PrintR(tail1); WriteLn;
  WriteLn('Мощность S1 = ', Card(size1));
  WriteLn;
  Write('S2 слева направо = '); PrintL(head2); WriteLn;
  Write('S2 справа налево = '); PrintR(tail2); WriteLn;
  WriteLn('Мощность S2 = ', Card(size2));
  WriteLn;
  Sumraz(head1, tail1, size1, head2, tail2, size2, headR, tailR, sizeR);
  Write('Симметрическая разность слева направо = '); PrintL(headR); WriteLn;
  Write('Симметрическая разность справа налево = '); PrintR(tailR); WriteLn;
  WriteLn('Мощность итогового = ', Card(sizeR));
  Clear(head1, tail1, size1);
  Clear(head2, tail2, size2);
  Clear(headR, tailR, sizeR);
end.