type time = record
  hh, mm : byte;
  end;
type diap_time = record
  _begin, _end: time;
end;
type doctor = record
  F, I, O : string;
  spec : string;
  Num : word;
  Price : real;
  Time : array[1..7] of diap_time;
end;
const n = 10;
type hospital = array[1..n] of doctor;

procedure read_hospital(f:text; var h:hospital);
var
  d: doctor;
  s, s1, s2 : string;
  i, j, k : word;
begin
  for i:= 1 to n do
  begin
    readln(f, s);
    s := s + ' ';
    k := pos(' ', s);
    d.F:=copy(s, 1, k - 1);
    delete(s, 1 , k);
    
    k := pos(' ', s);
    d.I:=copy(s, 1, k - 1);
    delete(s, 1 , k);
    
    k := pos(' ', s);
    d.O:=copy(s, 1, k - 1);
    delete(s, 1 , k);
    
    k := pos(' ', s);
    d.spec:=copy(s, 1, k - 1);
    delete(s, 1 , k);
    
    k:= pos(' ', s);
    d.num:= StrToInt(copy(s, 1, k - 1));
    delete(s, 1 , k);
    
    k := pos(' ', s);
    d.price:=StrToReal(copy(s, 1, k - 1));
    delete(s, 1 , k);
    
    for j := 1 to length(s) div 15 do
    begin
      s1:=copy(s, 1 + (j - 1)*15, 15);
      s2:= copy(s1, 1, 2);
      case s2 of
        'пн': k := 1;
        'вт': k := 2;
        'ср': k := 3;
        'чт': k := 4;
        'пт': k := 5;
        'сб': k := 6;
        'вс': k := 7;
      end;
      d.time[k]._begin.hh:= StrToInt(copy(s1, 4, 2));
      d.time[k]._begin.mm:= StrToInt(copy(s1, 7, 2));
      d.time[k]._end.hh:= StrToInt(copy(s1, 10, 2));
      d.time[k]._end.mm:= StrToInt(copy(s1, 13, 2));
    end;
    h[i]:=d
  end;
end;
function dig(x : integer):string;
begin
  if x < 10 then
    dig:= '0' + IntToStr(x)
  else
    dig := IntToStr(x)
end;

procedure print_hospital(h: hospital);
var
  i, j: integer;
  day: string;
begin
  writeln('__________________________________________________________________________________________________________________________|');
  writeln('| Фамилия   | Имя    | Отчество | Специальность | Кабинет | Цена   | Расписание                                           |');
  writeln('__________________________________________________________________________________________________________________________|');

  for i := 1 to n do
  begin
    write('| ', h[i].F:10);
    write('| ', h[i].I:7);
    write('| ', h[i].O:9);
    write('| ', h[i].spec:14);
    write('| ', h[i].Num:8);
    write('| ', h[i].Price:7);
    write('|  ');

    for j := 1 to 7 do
    begin
      case j of
        1: day := 'пн';
        2: day := 'вт';
        3: day := 'ср';
        4: day := 'чт';
        5: day := 'пт';
        6: day := 'сб';
        7: day := 'вс';
      end;

      if (h[i].Time[j]._begin.hh <> 0) or (h[i].Time[j]._begin.mm <> 0) or
         (h[i].Time[j]._end.hh <> 0) or (h[i].Time[j]._end.mm <> 0) then
      begin
        write(day, ' : ',
              dig(h[i].Time[j]._begin.hh), ':', dig(h[i].Time[j]._begin.mm),
              '-',
              dig(h[i].Time[j]._end.hh), ':', dig(h[i].Time[j]._end.mm), '| ');
      end;
    end;
    writeln();
  end;

  writeln('__________________________________________________________________________________________________________________________|');
end;

procedure printккк_hospital(h:hospital);
var i:integer;
begin
  for i := 1 to n do
    writeln(h[i])
end;
var H : hospital;
f1, f: text;
j, i : integer;
s, slovo :string;
begin
 assign(f,'doctor.txt'); reset(f); assign(f1,'hospital.txt'); rewrite(f1);
 read_hospital(f, h);
 print_hospital(h);
 close(f);
 close(f1);
end.
