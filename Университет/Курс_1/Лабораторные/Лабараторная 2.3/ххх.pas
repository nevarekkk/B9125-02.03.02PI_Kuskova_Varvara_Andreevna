program laba3;
type
  Dataa = record
    x, y: integer;
  end;
type
  Chain = ^Elem;
  Elem = record
    data: Dataa;
    next: Chain;
    prev: Chain;
  end;

procedure Init(var head: Chain);
begin
  head := nil;
end;

procedure AddFirst(var head: Chain; i: Dataa);
var
  cur: Chain;
begin
  new(cur);

  cur^.data := i;
  cur^.prev := nil;
  cur^.next := head;

  if head <> nil then
    head^.prev := cur;

  head := cur;
end;

{========== ПЕЧАТЬ СЛЕВА НАПРАВО ==========}

procedure write_(head: Chain);
var
  cur: Chain;
begin
  cur := head;

  while cur <> nil do
  begin
    write('(', cur^.data.x, ',', cur^.data.y, ') ');
    cur := cur^.next;
  end;

  writeln;
end;

{========== ПЕЧАТЬ СПРАВА НАЛЕВО ==========}

procedure write_back(head: Chain);
var
  cur: Chain;
begin
  cur := head;

  if cur <> nil then
  begin
    while cur^.next <> nil do
      cur := cur^.next;

    while cur <> nil do
    begin
      write('(', cur^.data.x, ',', cur^.data.y, ') ');
      cur := cur^.prev;
    end;

    writeln;
  end;
end;

{========== ПОИСК ==========}

function detectiv(head: Chain; i: Dataa): boolean;
var
  cur: Chain;
begin
  detectiv := false;

  cur := head;

  while cur <> nil do
  begin
    if (cur^.data.x = i.x) and
       (cur^.data.y = i.y) then
      detectiv := true;

    cur := cur^.next;
  end;
end;

{========== УДАЛЕНИЕ ==========}

procedure delete(var head: Chain; i: Dataa);
var
  cur: Chain;
begin
  cur := head;

  while cur <> nil do
  begin
    if (cur^.data.x = i.x) and
       (cur^.data.y = i.y) then
    begin
      if cur^.prev <> nil then
        cur^.prev^.next := cur^.next
      else
        head := cur^.next;

      if cur^.next <> nil then
        cur^.next^.prev := cur^.prev;

      dispose(cur);
    end
    else
      cur := cur^.next;
  end;
end;

{========== МОЩНОСТЬ МНОЖЕСТВА ==========}

function card(head: Chain): integer;
var
  cur: Chain;
  k: integer;
begin
  k := 0;
  cur := head;

  while cur <> nil do
  begin
    k := k + 1;
    cur := cur^.next;
  end;

  card := k;
end;

{========== ОЧИСТКА ==========}

procedure yborka(var head: Chain);
var
  cur: Chain;
begin
  while head <> nil do
  begin
    cur := head;
    head := head^.next;
    dispose(cur);
  end;
end;

{========== СИММЕТРИЧЕСКАЯ РАЗНОСТЬ ==========}

procedure sim_razn(s1, s2: Chain; var s3: Chain);
var
  cur: Chain;
begin
  Init(s3);

  cur := s1;

  while cur <> nil do
  begin
    if not detectiv(s2, cur^.data) then
      AddFirst(s3, cur^.data);

    cur := cur^.next;
  end;

  cur := s2;

  while cur <> nil do
  begin
    if not detectiv(s1, cur^.data) then
      AddFirst(s3, cur^.data);

    cur := cur^.next;
  end;
end;

{========== ГЛАВНАЯ ПРОГРАММА ==========}

var
  s1, s2, s3: Chain;
  n1, n2, i: integer;
  p: Dataa;

begin
  Init(s1);
  Init(s2);
  Init(s3);

  writeln('S1');
  readln(n1);

  for i := 1 to n1 do
  begin
    readln(p.x, p.y);
    AddFirst(s1, p);
  end;

  writeln('S2');
  readln(n2);

  for i := 1 to n2 do
  begin
    readln(p.x, p.y);
    AddFirst(s2, p);
  end;

  writeln('S1:');
  write_(s1);

  writeln('S1 reverse:');
  write_back(s1);

  writeln('S2:');
  write_(s2);

  writeln('S2 reverse:');
  write_back(s2);

  writeln('Card S1 = ', card(s1));
  writeln('Card S2 = ', card(s2));

  sim_razn(s1, s2, s3);

  writeln('Symmetric difference:');
  write_(s3);

  yborka(s1);
  yborka(s2);
  yborka(s3);

end.