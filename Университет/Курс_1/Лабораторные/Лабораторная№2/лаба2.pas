
program MaclaurinSeries;

uses Math; // Для функции Exp (e^x)

// Функция для вычисления факториала
function Factorial(n: Integer): Real;
var
  i: Integer;
  res: Real;
begin
  res := 1.0;
  for i := 1 to n do
    res := res * i;
  Factorial := res;
end;

// Главная программа
var
  x: Real;
  n: Integer; // Количество членов ряда
  sum: Real;
  term: Real; // Текущий член ряда
  i: Integer;
  f_x: Real; // Значение функции e^x (для сравнения)
begin
  Write('Введите x (для e^x): ');
  ReadLn(x);

  Write('Введите количество членов ряда (n, например 10): ');
  ReadLn(n);

  sum := 0.0;
  // Ряд Маклорена для e^x: 1 + x/1! + x^2/2! + x^3/3! + ...
  for i := 0 to n-1 do
  begin
    // Вычисляем i-й член: x^i / i!
    term := Power(x, i) / Factorial(i);
    sum := sum + term;
  end;

  f_x := Exp(x); // Истинное значение e^x

  WriteLn('Аппроксимация e^x = ', sum:10:8);
  WriteLn('Истинное значение e^x = ', f_x:10:8);
  WriteLn('Разница = ', Abs(sum - f_x):10:8);
end.
