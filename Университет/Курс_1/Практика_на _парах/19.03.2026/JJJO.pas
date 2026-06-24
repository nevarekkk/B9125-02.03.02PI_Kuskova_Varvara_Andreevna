program Hello;
var
  a, b: integer;
  stat_a, stat_b: ^integer;
  din_a, din_b: ^integer;

function fact(n: integer): integer;
var
  a: integer;
  stat_a: ^integer;
  stat_n: ^integer;
  din_a: ^integer;

begin
  writeln(char(10), '----- Область "СТЕК" -----');
  writeln('--- занесли в стек FACT(', n, ') ---', char(10));

  a := n;
  stat_n := @n;
  stat_a := @a;

  writeln(' var n = ', n, ' -> ', stat_n);
  writeln(' var a = ', a, ' -> ', stat_a);

  writeln(char(10), '----- Область "КУЧИ" -----', char(10));
  new(din_a);
  din_a^ := n;
  writeln(' din_a^ = ', din_a^, ' -> ', din_a);

  if n = 1 then
    fact := 1
  else
    fact := n * fact(n - 1);

  writeln('-- Удалили из стека FACT(', n, ')', char(10));
end;

begin
  writeln('--- Область "ПРОГРАММЫ" ---', char(10));

  a := 1;
  b := 3;
  stat_a := @a;
  stat_b := @b;

  writeln(' var a = ', a, ' -> ', stat_a);
  writeln(' var b = ', b, ' -> ', stat_b);

  writeln('----- Область "КУЧИ" -----', char(10));
  new(din_a);
  new(din_b);

  din_a^ := 3;
  din_b^ := 4;

  writeln(' din_a^ = ', din_a^, ' -> ', din_a);
  writeln(' din_b^ = ', din_b^, ' -> ', din_b);

  a := fact(b);
end.
