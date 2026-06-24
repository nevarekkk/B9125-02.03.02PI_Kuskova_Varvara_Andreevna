program postyplenie;
type 
  date = record
    dd: word;
    mm: word;
    yy: word;
  end;
type 
  abiturient = record
    snils: string;
    data_bir: date;
    prikaz: string;
    data_prikaz: date;
    cod_post: string;
    sum_ege: word;
  end;
const n = 10;
type 
  abiturients = array[1..n] of abiturient;

procedure check_snils(str: string; var snils_ch: string; var error: byte);
var
  i: integer;
begin
  error := 0;
  snils_ch := '';
  if length(str) <> 14 then
    error := 1
  else if str[1] = '0' then
    error := 1
  else if not ((str[4] = '-') and (str[8] = '-') and (str[12] = ' ')) then
    error := 1
  else
  begin
    for i := 1 to 14 do
    begin
      if not ((i = 4) or (i = 8) or (i = 12)) then
        if not (str[i] in ['0'..'9']) then
          error := 1;
    end;
    if error = 0 then
      snils_ch := str;
  end;
end;

procedure check_prikaz(str: string; var prikaz_ch: string; var error: byte);
var
  i: integer;
begin
  error := 0;
  prikaz_ch := '';
  if length(str) <> 4 then
    error := 1
  else
  begin
    for i := 1 to 3 do
      if not (str[i] in ['0'..'9']) then
        error := 1;
    if not (str[4] in ['a'..'z']) then
      error := 1;
    if error = 0 then
      prikaz_ch := str;
  end;
end;

procedure check_cod_post(str: string; var cod_post_ch: string; var error: byte);
var
  i: integer;
begin
  error := 0;
  cod_post_ch := '';
  if length(str) <> 8 then
    error := 1;
  for i := 1 to length(str) do
  begin
    if i mod 3 = 0 then
    begin
      if str[i] <> '.' then
        error := 1;
    end
    else
    begin
      if not (str[i] in ['0'..'9']) then
        error := 1;
    end;
  end;
  if error = 0 then
    cod_post_ch := str;
end;

procedure check_sum_ege(str: string; var sum_ege_ch: word; var error: byte);
var
  valuer, code: integer;
begin
  error := 0;
  sum_ege_ch := 0;
  val(str, valuer, code);
  if code = 0 then
  begin
    if (valuer < 120) or (valuer > 310) then
      error := 2
    else
      sum_ege_ch := valuer;
  end
  else
    error := 2;
end;

procedure check_date_prikaz(str: string; var error: byte; var data_prikaz_ch: date);
var
  code_d, code_m, code_y, i: integer;
  dotpos1, dotpos2: integer;
  maxdays: integer;
  day, month, year: integer;
begin
  error := 0;
  dotpos1 := 0;
  dotpos2 := 0;
  day := 0;
  month := 0;
  year := 0;

  data_prikaz_ch.dd := 0;
  data_prikaz_ch.mm := 0;
  data_prikaz_ch.yy := 0;

  if length(str) <> 10 then
    error := 2
  else
  begin
    for i := 1 to 10 do
    begin
      if str[i] = '.' then
      begin
        if dotpos1 = 0 then
        begin
          dotpos1 := i;
          if dotpos1 = 1 then
            error := 2
          else
          begin
            val(copy(str, 1, dotpos1 - 1), day, code_d);
            if code_d <> 0 then
              error := 2;
          end;
        end
        else if dotpos2 = 0 then
        begin
          dotpos2 := i;

          val(copy(str, dotpos1 + 1, dotpos2 - dotpos1 - 1), month, code_m);
          if code_m <> 0 then
            error := 2;

          val(copy(str, dotpos2 + 1, 4), year, code_y);
          if code_y <> 0 then
            error := 2;
        end
        else
          error := 2;
      end;
    end;

    if ((error= 0) and ((dotpos1 = 0) or (dotpos2 = 0))) then
      error := 2;

    if error = 0 then
    begin
      if ((year < 2000) or (year > 2025)) then
        error := 2;
      if ((month < 1) or (month > 12)) then
        error := 2;
      if ((day < 1) or (day > 31)) then
       error := 2;
    end;

    if error = 0 then
    begin
      case month of
        1, 3, 5, 7, 8, 10, 12: maxdays := 31;
        4, 6, 9, 11: maxdays := 30;
        2:
        begin
          if ((year mod 4 = 0) and (year mod 100 <> 0)) or (year mod 400 = 0) then
            maxdays := 29
          else
            maxdays := 28;
        end;
      else
        maxdays := 0;
      end;

      if day > maxdays then
       error := 2;
    end;

    if error = 0 then
    begin
      data_prikaz_ch.dd := day;
      data_prikaz_ch.mm := month;
      data_prikaz_ch.yy := year;
    end;
  end;
end;

procedure pr_date_bir(str: string; var data_bir_ch: date);
begin
  
end;

procedure check_date_bir(str: string; var error: byte; var data_bir_ch: date);
var
  code_d, code_m, code_y, i: integer;
  dotpos1, dotpos2: integer;
  maxdays : integer;
  day, month, year: integer;
begin
  error := 0;
  dotpos1 := 0;
  dotpos2 := 0;
  day := 0;
  month := 0;
  year := 0;

  data_bir_ch.dd := 0;
  data_bir_ch.mm := 0;
  data_bir_ch.yy := 0;

  if length(str) <> 10 then
    error := 2
  else
  begin
    for i := 1 to 10 do
    begin
      if str[i] = '.' then
      begin
        if dotpos1 = 0 then
        begin
          dotpos1 := i;
          if dotpos1 = 1 then
            error := 2
          else
          begin
            val(copy(str, 1, dotpos1 - 1), day, code_d);
            if code_d <> 0 then
              error := 2;
          end;
        end
        else if dotpos2 = 0 then
        begin
          dotpos2 := i;
          val(copy(str, dotpos1 + 1, dotpos2 - dotpos1 - 1), month, code_m);
          if code_m <> 0 then
            error := 2;

          val(copy(str, dotpos2 + 1, 4), year, code_y);
          if code_y <> 0 then
            error := 2;
        end
        else
          error := 2;
      end;
    end;

    if ((error = 0) and ((dotpos1 = 0) or (dotpos2 = 0))) then
      error:= 2;

    if error = 0 then
    begin
      if ((year < 1920) or(year > 2011)) then
        error := 2;
      if ((month < 1) or (month > 12)) then
        error := 2;
      if ((day < 1) or (day > 31)) then
        error := 2;
    end;

    if error = 0 then
    begin
      case month of
        1, 3, 5, 7, 8, 10, 12: maxdays := 31;
        4, 6, 9, 11: maxdays := 30;
        2:
        begin
          if ((year mod 4 = 0) and (year mod 100 <> 0)) or (year mod 400 = 0) then
            maxdays := 29
          else
            maxdays := 28;
        end;
      else
        maxdays := 0;
      end;
      if day > maxdays then
        error:= 2;
    end;
    if error = 0 then
    begin
      data_bir_ch.dd := day;
      data_bir_ch.mm := month;
      data_bir_ch.yy := year;
    end;
  end;
end;

procedure read_f(var arr: abiturients; var n: integer; ff: text);
var
  s, sub: string;
  error: byte;
  abit: abiturient;
begin
  n := 0;
  while not eof(ff) do
  begin
    readln(ff, s);
    n := n + 1;

    sub := copy(s, 1, 14);
    check_snils(sub, abit.snils, error);

    sub := copy(s, 16, 10);
    check_date_bir(sub, error, abit.data_bir);

    sub := copy(s, 27, 4);
    check_prikaz(sub, abit.prikaz, error);

    sub := copy(s, 32, 10);
    check_date_prikaz(sub, error, abit.data_prikaz);

    sub := copy(s, 43, 8);
    check_cod_post(sub, abit.cod_post, error);

    sub := copy(s, 52, 3);
    check_sum_ege(sub, abit.sum_ege, error);

    arr[n] := abit;
  end;
end;
procedure write_f(var f: text; var arr: abiturients; n: integer);
var
   i: integer;
begin
  for i := 1 to n do
    writeln(f, arr[i].snils, '|',
               arr[i].data_bir.dd:2, '.', arr[i].data_bir.mm:2, '.', arr[i].data_bir.yy:4, '|',
               arr[i].prikaz, '|',
               arr[i].data_prikaz.dd:2, '.', arr[i].data_prikaz.mm:2, '.', arr[i].data_prikaz.yy:4, '|',
               arr[i].cod_post, '|',
               arr[i].sum_ege);
end;

var
  f_in, f_out: text;
  array_f: abiturients;
  n_c: integer;
begin
  assign(f_in, 'ninput.txt'); 
  reset(f_in);

  assign(f_out, 'ninout.txt'); 
  rewrite(f_out);

  n_c := 0;
  read_f(array_f, n_c, f_in);

  write_f(f_out, array_f, n_c);

  close(f_in);
  close(f_out);
end.