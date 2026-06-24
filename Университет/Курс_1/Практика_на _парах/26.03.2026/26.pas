program moves;
t
type move = record
  name : string;
  data_world:  string;
  data_rus :  string;
  budget : real;
  budget_cass : real;
end;

const n = 10000;
type mov = array[1..n] of move;
    procedure read_m(var m: mov; var n : integer; ff: text);
    var
      k : integer;
      s : string;
      begin
        n := 0;
        while not eof(ff) do begin
        readln(ff, s);
        k := pos(' ' , s);
        n := n + 1;
        m[n].name := copy(s, 1, k - 1);
        delete(s, 1, k);
        m[n].data_world := StrToInt(s);
        k := pos(' ' , s);
        n := n + 1;
      end;
    end;
    
procedure sort (var z:zoo; n:integer);
  var
    i,j:integer;
    boof:animals;
  begin
    for i:=1 to n do
    begin
      for j:=1 to n-i do
      begin
        if (z[j].weight>z[j+1].weight) then 
        begin
          boof:=z[j+1];
          z[j+1]:=z[j];
          z[j]:=boof;
        end;
      end;
    end;
  end;
  
procedure Search(var z : zoo; a, b, n : integer; ff : text);
VAR i : integer;
begin
  writeln(ff, '===============================================================');
  for i := 1 to N do begin
    if (z[i].weight >= a) and (z[i].weight <= b) then begin
      writeln(ff, z[i].name,' ' ,z[i].weight)
    end;
  end;
end;



procedure print_z(z : zoo; n : integer; ff : text);
VAR i : integer;
begin
  for i := 1 to N do
    writeln(ff, z[i].weight, ' ', z[i].name);
end;

var 
     f_in, f_out: text;
     array_z : zoo;
     count_z, a, b: integer;

begin
  a := 50 ; b := 5000;
  assign(f_in,'input_new.txt'); reset(f_in);
  assign(f_out,'output_new.txt'); rewrite(f_out);
   
  read_z(array_z, count_z, f_in);
  sort(array_z, count_z);
  
  print_z(array_z, count_z, f_out);
  search(array_z, a,b,count_z, f_out);
  
  close (f_in);
  close(f_out);
end.