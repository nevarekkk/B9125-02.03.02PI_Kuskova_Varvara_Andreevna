program ExpSinx;

const
  pi = 3.14159265358979323846;
  epsilon = 0.0000001;

var
  a, b, h, x_i, x_kpi, sin_val, exp_val, t_sin, t_exp: real; 
  m, i, n_sin, n_exp: integer; 

begin
  writeln('Введите a, b: ');
  readln(a, b);
  writeln('Введите количество отрезков m: ');
  readln(m);
  
  if m <= 0 then
    writeln('Некорректный ввод данных: m должно быть > 0')
  else if a >= b then
    writeln('Некорректный ввод данных: a должно быть < b')
  else
  begin
    h := (b - a) / m;
    for i := 0 to m do
    begin
      x_i := a + i * h;
      x_kpi := x_i;
      while x_kpi > pi do
        x_kpi := x_kpi - 2*pi;
      while x_kpi < -pi do
        x_kpi := x_kpi + 2*pi;
      n_sin := 0;
      t_sin := x_kpi;
      sin_val := t_sin;
      while abs(t_sin) > epsilon do
      begin
        n_sin := n_sin + 1;
        t_sin := -t_sin * x_kpi * x_kpi / ((2 * n_sin) * (2 * n_sin + 1));
        sin_val := sin_val + t_sin;
      end;
      n_exp := 0;
      t_exp := 1.0; 
      exp_val := t_exp;
      while abs(t_exp) > epsilon do
      begin
        n_exp := n_exp + 1;
        t_exp := t_exp * sin_val / n_exp;
        exp_val := exp_val + t_exp;
      end;
      writeln('Точка ', x_i:0:8, ' Значение в точке по разложению ряда ', exp_val:14:10, 
              ' Значение в точке по встроенной функции ', exp(sin(x_i)):14:10);
    end;
  end;
end.