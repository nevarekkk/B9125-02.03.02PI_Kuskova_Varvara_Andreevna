unit u_proc;
interface
uses u_type;
procedure serch(var f: friend; n, a, b: integer; ff: text);  
procedure print_f(f: friend; n : integer; ff: text);
procedure sort(var f:friend;n:integer);

implementation
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
begin
  
  

end.