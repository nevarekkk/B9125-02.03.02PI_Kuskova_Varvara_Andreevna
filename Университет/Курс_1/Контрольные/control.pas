type
  complec = class
  private
    a: integer;
    b: integer;
    i: string;

    constructor Create(aa, bb: integer; ii: string);
    procedure Print;
    function sum(c: complec): complec;
    function mnogit(c: complec): complec;
    function raznoct(c: complec): complec;
  end;


constructor complec.create(aa, bb: integer; ii: string);
begin
  a := aa;
  b := bb;
  i := ii;
end;

function complec.sum(c: complec): complec;
var
  aa, bb: integer;
begin
  aa := a + c.a;
  bb := b + c.b;
  Result := complec.create(aa, bb, i);
end;

function complec.mnogit(c: complec): complec;
var
  aa, bb: integer;
begin
  aa := a * c.a - b * c.b;
  bb := a * c.b + b * c.a;
  Result := complec.Create(aa, bb, i);
end;

procedure complec.Print;
begin
  if (a = 0) and (b = 0) then
    Writeln('0')
  else
  if a = 0 then
  begin
    if b > 0 then
      Writeln(b, i)
    else
      Writeln('-', -b, i);
  end
  else
  if b = 0 then
    Writeln(a)
  else
  begin
    if b > 0 then
      Writeln(a, ' + ', b, i)
    else
      Writeln(a, ' - ', -b, i);
  end;
  end;
  
var
  A, B, C: array[1..5] of complec;
  k: integer;
begin
  for k := 1 to 5 do
  begin
    A[k] := complec.Create(Random(10), Random(10), 'i');
    B[k] := complec.Create(Random(10), Random(10), 'i');
  end;
  for k := 1 to 5 do
  begin
    if k mod 2 = 0 then
      C[k] := A[k].sum(B[k])
    else
      C[k] := A[k].raznoct(B[k]);
  end;
end.