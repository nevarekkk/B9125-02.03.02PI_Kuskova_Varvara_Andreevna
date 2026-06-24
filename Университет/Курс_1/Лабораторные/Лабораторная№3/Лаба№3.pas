program matrix;

const
  epsilon = 0.000001;
  n = 3 ;
  up = 0;
  down = 1;

function ExpSinx(x: real): real;
var
  x_kpi, sin_val, exp_val, t_sin, t_exp: real;
  n_sin, n_exp: integer;
begin
  // от пи до пи 
  x_kpi := x;
  while x_kpi > pi do
    x_kpi := x_kpi - 2 * pi;
  while x_kpi < -pi do
    x_kpi := x_kpi + 2 * pi;

  // синус
  n_sin := 0;
  t_sin := x_kpi;
  sin_val := t_sin;
  while abs(t_sin) > epsilon do
  begin
    n_sin := n_sin + 1;
    t_sin := -t_sin * x_kpi * x_kpi / ((2 * n_sin) * (2 * n_sin + 1));
    sin_val := sin_val + t_sin;
  end;

  // ешка
  n_exp := 0;
  t_exp := 1.0;
  exp_val := t_exp;
  while abs(t_exp) > epsilon do
  begin
    n_exp := n_exp + 1;
    t_exp := t_exp * sin_val / n_exp;
    exp_val := exp_val + t_exp;
  end;

  Result := exp_val;
end;

var
  arr: array[1..n, 1..n] of real;
  i, j, row, col, cnt, kuda_idem: integer;
  idx, minCol, maxCol: integer;
  a, b, h, x_i, minVal, maxVal, t: real;

begin
  writeln('Введите a, b:');
  readln(a, b);

  if (a >= b) then
    writeln('Некорректный ввод данных: a должно быть < b')
  else
  begin
    a:=pi; b:=(n*n)*pi;
    h := (b - a) / (n * n - 1);

    row := n;
    col := n;
    cnt := 1;
    kuda_idem := up;

    while cnt <= n * n do
    begin
      idx := cnt - 1;
      x_i := a + idx * h;
      arr[row, col] := ExpSinx(x_i);
      cnt := cnt + 1;

      if kuda_idem = up then
      begin
        if row > 1 then
          row := row - 1
        else
        begin
          col := col - 1;
          kuda_idem := down;
        end;
      end
      else
      begin
        if row < n then
          row := row + 1
        else
        begin
          col := col - 1;
          kuda_idem := up;
        end;
      end;
    end;

    writeln('Исходная матрица ', n, 'x', n, ':');
    for i := 1 to n do
    begin
      for j := 1 to n do
        write(arr[i, j]:8:5, ' ');
      writeln;
    end;

    for i := 1 to n do
    begin
      minVal := arr[i, 1];
      maxVal := arr[i, 1];
      minCol := 1;
      maxCol := 1;

      for j := 2 to n do
      begin
        if arr[i, j] < minVal then
        begin
          minVal := arr[i, j];
          minCol := j;
        end;

        if arr[i, j] > maxVal then
        begin
          maxVal := arr[i, j];
          maxCol := j;
        end;
      end;
      t := arr[i, minCol];
      arr[i, minCol] := arr[i, maxCol];
      arr[i, maxCol] := t;
    end;

    writeln;
    writeln('Поменяная матрица:');
    for i := 1 to n do
    begin
      for j := 1 to n do
        write(arr[i, j]:8:15, ' ');
      writeln;
    end;
  end;
end.
