const n = 15;
type people = record
  name: string;
  age: byte;
end;

type friend = array[1..N] of people;

procedure sort(var f:friend;n:integer);
var
  i,j: integer;
  boof: people;
  begin
    for  i := 1 to n do 
    begin
      for j := 1 to (n - j) do begin
        if ((f[j].age > f[j + 1].age) or (f[j].age = f[j + 1].age )) and (f[j].name > f[j + 1].name) 
        then begin
          boof := f[j + 1];
          f[j + 1] := f[i];
          f[i] := boof;
        end;
      end;
    end;
  end;
  procedure serch(var f: friend; n, a, b: integer; ff: text);
var
  i : integer;
  begin
   for i := 1 to n do 
    begin
    if (a <= f[i].age) and (f[i].age <= b) then
      writeln(ff, f[i].name, '' , f[i].age, 'ddd') 
   end;
  end;
  
    procedure print_f(f: friend; n : integer; ff: text);
    var
      i : integer;
      begin
        for i := 1 to n do
          writeln(ff, f[i].age, ' ', f[i].name);
      end;
      
    procedure read_f(var f: friend; var n : integer; ff: text);
    var
      k : integer;
      s : string;
      begin
        n := 0;
        while not eof(ff) do begin
        readln(ff, s);
        k := pos(' ' , s);
        n := n + 1;
        f[n].name := copy(s, 1, k - 1);
        delete(s, 1, k);
        f[n].age := StrToInt(s);
      end;
    end;
    var 
    
     f_in, f_out: text;
     array_f : friend;
     count_f, a, b: integer;
     begin
      assign(f_in,'input.txt'); reset(f_in);
      assign(f_out,'output.txt'); rewrite(f_out);
      read_f(array_f, count_f, f_in);
      sort(array_f, count_f);
      print_f(array_f, count_f, f_out);
      a := 15; b := 21;
      serch(array_f, count_f, a, b, f_out);
      close (f_in);
      close(f_out);
      
    end.


