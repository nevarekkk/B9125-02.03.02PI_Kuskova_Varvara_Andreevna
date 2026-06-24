program moves;
type 
  move = record
    name : string;
    data_world: string;
    data_rus : string;
    budget : real;
    budget_cass : real;
  end;
const n = 10000;
type mov = array[1..n] of move;

procedure read_m(var m: mov; var n : integer; ff: text);
var
  s : string;
  k : integer;
  tmp_budget, tmp_cass: real;
begin
  n := 0;
  while not eof(ff) do 
  begin
    readln(ff, s);

    k := pos(' ', s);
    n := n + 1;
    m[n].name := copy(s, 1, k - 1);
    delete(s, 1, k);

    k := pos(' ', s);
    m[n].data_world := copy(s, 1, k - 1);
    delete(s, 1, k);

    k := pos(' ', s);
    m[n].data_rus := copy(s, 1, k - 1);
    delete(s, 1, k);

    k := pos(' ', s);
    val(copy(s, 1, k - 1), tmp_budget);
    m[n].budget := tmp_budget;
    delete(s, 1, k);

    val(s, tmp_cass);
    m[n].budget_cass := tmp_cass;

    if m[n].data_world <> m[n].data_rus then
      n := n - 1;
  end;
end;

procedure sort (var m:mov; n:integer);
var
  i,j:integer;
  boof:move;
begin
  for i:=1 to n do
    for j:=1 to n-i do
      if (m[j].budget > m[j+1].budget) then 
      begin
        boof:=m[j+1];
        m[j+1]:=m[j];
        m[j]:=boof;
      end;
end;

procedure print_m(m : mov; n : integer; ff : text);
var 
  i : integer;
begin
  for i := 1 to n do
    writeln(ff, m[i].budget, ' ', m[i].name);
end;

var 
  f_in, f_out: text;
  array_m : mov;
  count_m: integer;

begin
  assign(f_in,'in.txt'); reset(f_in);
  assign(f_out,'out.txt'); rewrite(f_out);
   
  read_m(array_m, count_m, f_in);
  sort(array_m, count_m);
  print_m(array_m, count_m, f_out);
  
  close(f_in);
  close(f_out);
end.