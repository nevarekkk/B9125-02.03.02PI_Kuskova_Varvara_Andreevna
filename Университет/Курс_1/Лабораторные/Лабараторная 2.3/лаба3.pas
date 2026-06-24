program laba3;
type
  Dataa = record
    x, y: integer;
  end;

type
Chain = ^Elem;
elem = record 
  data: dataa;
  next: chain;
  prev: chain;
end;

procedure appendEnd(var head: chain; i: integer);
var 
  cur, tail: chain;
begin
  new(cur);
  cur := head;
  cur^.data := i;
  cur^.next := nil;
  if head = nil then begin
     cur^.next := head;
     cur^.prev := nil
     end
  else
    tail := head;

  while tail^.next <> nil do
    tail := tail^.next;
    tail^.next := cur;
    cur^.prev := tail;
  end;

procedure AddFirst(var head: chain; i: integer); 
var 
  cur: chain;
begin
  new(cur);
  cur^.data := i;
  cur^.prev := nil;
  cur^.next := head;
  
  if cur^.prev <> nil then
    head^.prev := cur;
    head := cur;
end;


procedure delete(var head: chain);
var 
  cur, tail: chain;
begin
  cur := head;
  if head <> nil then begin
    head := head^.next;
    if head <> nil then
    head^.pred := nil;
    dispose(cur);
  end;
end;

procedure detectiv(var head: chain; i: integer); 
var 
  cur: chain;
  begin
    println(i);
    cur := head;
    while cur <> nil do begin
      if cur^.data = i then 
        writeln(cur^.data); 
    cur := cur^.next;
      end;
  end;


function card(var head: chain): integer;
var
  curd_: integer;
  cur : chain;
  begin
    cur := head;
    curd_ := 0;
    while cur <> nil do begin
      curd_ := curd_ + 1;
      cur := cur^.next;
    end;
    curd := curd_;
  end;

procedure yborka(var head: chain);
var 
  cur: chain;
begin
  while head <> nil do begin
    cur := head;
    head := head^.next;
    if head <> nil then
    head^.prev := nil;
    dispose(cur);
  end;
end;

procedure Init(var head: chain);
begin
  head := nil;
end;

procedure write_(head: chain);
var
  cur: chain;
begin
  cur := head;
  while cur <> nil do
  begin
    write(cur^.data, ' ');
    cur := cur^.next;
  end;
  writeln;
end;


  