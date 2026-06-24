unit l1_proc;

interface
uses l1_type;

procedure write_f(var f: text; var arr: abiturients; n: integer); 
procedure check_date_bir(str: string; var error: byte; var data_bir_ch: date);
procedure check_date_prikaz(str: string; var error: byte; var data_prikaz_ch: date);
procedure check_date(str: string; min_y, max_y: integer; var error: byte; var data_ch: date);
procedure check_sum_ege(str: string; var sum_ege_ch: word; var error: byte);
procedure check_snils(str: string; var snils_ch: string; var error: byte);
procedure check_prikaz(str: string; var prikaz_ch: string; var error: byte);
procedure check_cod_post(str: string; var cod_post_ch: string; var error: byte);
procedure check_palka(str: string; var error: byte); 
procedure check_skip(s: string; var error: byte);
function is_empty(str: string): boolean;
function equal(a, b: abiturient): boolean;
procedure sort(var f: abiturients; n: integer);
procedure remove_conflicts(var arr: abiturients; var n: integer; var f_conflict: text);
function is_conflict(a, b: abiturient): boolean;
procedure remove_dublicates(var arr: abiturients; var n: integer; var f_dublicat: text);

implementation

procedure remove_dublicates(var arr: abiturients; var n: integer; var f_dublicat: text);
var
  i, j, new_n: integer;
  used: array[1..1000] of boolean;
begin
  for i := 1 to n do
    used[i] := false;

  for i := 1 to n - 1 do
    if not used[i] then
      for j := i + 1 to n do
        if not used[j] then
          if equal(arr[i], arr[j]) then
          begin
            used[j] := true;
            writeln(f_dublicat,
              arr[j].snils, '|',
              arr[j].data_bir.dd:2, '.', arr[j].data_bir.mm:2, '.', arr[j].data_bir.yy:4, '|',
              arr[j].prikaz, '|',
              arr[j].data_prikaz.dd:2, '.', arr[j].data_prikaz.mm:2, '.', arr[j].data_prikaz.yy:4, '|',
              arr[j].cod_post, '|',
              arr[j].sum_ege
            );
          end;

  new_n := 0;
  for i := 1 to n do
    if not used[i] then
    begin
      new_n := new_n + 1;
      arr[new_n] := arr[i];
    end;

  n := new_n;
end;

function is_conflict(a, b: abiturient): boolean; 
var
  conflict: boolean;
begin
  conflict := false;
   
   if a.prikaz = b.prikaz then
      conflict := true;

  if a.snils = b.snils then
  begin
    if (a.data_bir.dd <> b.data_bir.dd) or
       (a.data_bir.mm <> b.data_bir.mm) or
       (a.data_bir.yy <> b.data_bir.yy) then
      conflict := true;
     end;
      
       if a.snils = b.snils then
      begin
       if ((a.data_bir.dd = b.data_bir.dd) and
       (a.data_bir.mm = b.data_bir.mm) and
       (a.data_bir.yy = b.data_bir.yy)) and (((a.prikaz = b.prikaz) and (a.cod_post <> b.cod_post))) then
      conflict := true;
      end;
      
      if a.snils = b.snils then
      begin
       if ((a.data_bir.dd = b.data_bir.dd) and
       (a.data_bir.mm = b.data_bir.mm) and
       (a.data_bir.yy = b.data_bir.yy)) and (((a.prikaz = b.prikaz) and (a.sum_ege <> b.sum_ege))) then
      conflict := true;
       end;
      
      if a.snils = b.snils then
      begin
       if (a.prikaz <> b.prikaz) then
      conflict := true;
    end;
    
    if (a.prikaz = b.prikaz)then
      begin
       if (a.cod_post <> b.cod_post) then
      conflict := true;
    end;
   is_conflict := conflict;
end;

function is_empty(str: string): boolean;
var
  i: integer;
begin
  is_empty := true;
  for i := 1 to length(str) do
    if str[i] <> ' ' then
      is_empty := false;
end;

procedure check_skip(s: string; var error: byte);
begin
  error := 0;
  if is_empty(copy(s, 32, 10)) or
     is_empty(copy(s, 43, 8)) then
    error := 3;
end;

procedure check_palka(str: string; var error: byte); ///////////////
begin
  error := 0;

  if length(str) <> 54 then
    error := 1
  else if not ((str[15] = '|') and
               (str[26] = '|') and
               (str[31] = '|') and
               (str[42] = '|') and
               (str[51] = '|')) then
    error := 1;
end;

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
      if not ((i = 4) or (i = 8) or (i = 12)) then
        if not (str[i] in ['0'..'9']) then
          error := 1;

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

procedure check_cod_post(str: string; var cod_post_ch: string; var error: byte);
var
  i: integer;
begin
  error := 0;
  cod_post_ch := '';

  if length(str) <> 8 then
    error := 1
  else
  begin
    for i := 1 to 8 do
    begin
      if (i = 3) or (i = 6) then
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
end;

procedure check_date(str: string; min_y, max_y: integer; var error: byte; var data_ch: date);
var
  code_d, code_m, code_y: integer;
  dotpos1, dotpos2: integer;
  maxdays: integer;
  day, month, year: integer;
begin
  error := 0;
  data_ch.dd := 0;
  data_ch.mm := 0;
  data_ch.yy := 0;

  dotpos1 := pos('.', str);
  if dotpos1 = 0 then
    error := 2
  else
  begin
    dotpos2 := pos('.', copy(str, dotpos1 + 1, length(str)));
    if dotpos2 = 0 then
      error := 2
    else
    begin
      dotpos2 := dotpos2 + dotpos1;
      val(copy(str, 1, dotpos1 - 1), day, code_d);
      val(copy(str, dotpos1 + 1, dotpos2 - dotpos1 - 1), month, code_m);
      val(copy(str, dotpos2 + 1, length(str) - dotpos2), year, code_y);
      if (code_d <> 0) or (code_m <> 0) or (code_y <> 0) then
        error := 2;
    end;
  end;
  if error = 0 then
  begin
    if (year < min_y) or (year > max_y) then
      error := 2;
    if (month < 1) or (month > 12) then
      error := 2;
    if (day < 1) or (day > 31) then
      error := 2;
  end;
  if error = 0 then
  begin
    case month of
      1, 3, 5, 7, 8, 10, 12: maxdays := 31;
      4, 6, 9, 11: maxdays := 30;
      2:
        if ((year mod 4 = 0) and (year mod 100 <> 0)) or (year mod 400 = 0) then
          maxdays := 29
        else
          maxdays := 28;
    else
      maxdays := 0;
    end;

    if day > maxdays then
      error := 2;
  end;
  if error = 0 then
  begin
    data_ch.dd := day;
    data_ch.mm := month;
    data_ch.yy := year;
  end;
end;

procedure check_date_bir(str: string; var error: byte; var data_bir_ch: date);
begin
  check_date(str, 1920, 2011, error, data_bir_ch);
end;

procedure check_date_prikaz(str: string; var error: byte; var data_prikaz_ch: date);
begin
  check_date(str, 2000, 2025, error, data_prikaz_ch);
end;

procedure sort(var f: abiturients; n: integer);
var
  i, j: integer;
  boof: abiturient;
begin
  for i := 1 to n - 1 do
  begin
    for j := 1 to n - i do
    begin
      if (f[j].data_bir.yy > f[j + 1].data_bir.yy) or
         ((f[j].data_bir.yy = f[j + 1].data_bir.yy) and
          (f[j].data_bir.mm > f[j + 1].data_bir.mm)) or
         ((f[j].data_bir.yy = f[j + 1].data_bir.yy) and
          (f[j].data_bir.mm = f[j + 1].data_bir.mm) and
          (f[j].data_bir.dd > f[j + 1].data_bir.dd)) or
         ((f[j].data_bir.yy = f[j + 1].data_bir.yy) and
          (f[j].data_bir.mm = f[j + 1].data_bir.mm) and
          (f[j].data_bir.dd = f[j + 1].data_bir.dd) and
          (f[j].cod_post > f[j + 1].cod_post)) then
      begin
        boof := f[j];
        f[j] := f[j + 1];
        f[j + 1] := boof;
      end;
    end;
  end;
end;

procedure write_f(var f: text; var arr: abiturients; n: integer);
var
  i: integer;
begin
  for i := 1 to n do 
  begin
    write(f, arr[i].snils, '|');
    
    if arr[i].data_bir.dd < 10 then 
      write(f, 0);
    write(f, arr[i].data_bir.dd, '.');
    
    if arr[i].data_bir.mm < 10 then 
      write(f, 0);
    write(f, arr[i].data_bir.mm, '.');
    
    write(f, arr[i].data_bir.yy:4, '|');
    write(f, arr[i].prikaz, '|');
    
    if arr[i].data_prikaz.dd < 10 then 
      write(f, 0);
    write(f, arr[i].data_prikaz.dd, '.');
    
    if arr[i].data_prikaz.mm < 10 then 
      write(f, 0);
    write(f, arr[i].data_prikaz.mm, '.');
    
    writeln(f, arr[i].data_prikaz.yy:4, '|', arr[i].cod_post, '|', arr[i].sum_ege);
  end;
end;

procedure remove_conflicts(var arr: abiturients; var n: integer; var f_conflict: text);
var
  i, j, new_n: integer;
  used_c: array[1..1000] of boolean;
begin
  for i := 1 to n do
    used_c[i] := false;

  for i := 1 to n - 1 do
  begin
    if not used_c[i] then
    begin
      for j := i + 1 to n do
      begin
        if not used_c[j] then
        begin
          if is_conflict(arr[i], arr[j]) then
          begin
            used_c[i] := true;
            used_c[j] := true;

            writeln(f_conflict,
              arr[i].snils, '|',
              arr[i].data_bir.dd:2, '.', arr[i].data_bir.mm:2, '.', arr[i].data_bir.yy:4, '|',
              arr[i].prikaz, '|',
              arr[i].data_prikaz.dd:2, '.', arr[i].data_prikaz.mm:2, '.', arr[i].data_prikaz.yy:4, '|',
              arr[i].cod_post, '|',
              arr[i].sum_ege
            );

            writeln(f_conflict,
              arr[j].snils, '|',
              arr[j].data_bir.dd:2, '.', arr[j].data_bir.mm:2, '.', arr[j].data_bir.yy:4, '|',
              arr[j].prikaz, '|',
              arr[j].data_prikaz.dd:2, '.', arr[j].data_prikaz.mm:2, '.', arr[j].data_prikaz.yy:4, '|',
              arr[j].cod_post, '|',
              arr[j].sum_ege
            );
          end;
        end;
      end;
    end;
  end;
  
  new_n := 0;
  for i := 1 to n do
  begin
    if not used_c[i] then
    begin
      new_n := new_n + 1;
      arr[new_n] := arr[i];
    end;
  end;
  
  n := new_n;
end;

function equal(a, b: abiturient): boolean;
begin
  equal :=
    (a.snils = b.snils) and
    (a.data_bir.dd = b.data_bir.dd) and
    (a.data_bir.mm = b.data_bir.mm) and
    (a.data_bir.yy = b.data_bir.yy) and
    (a.prikaz = b.prikaz) and
    (a.data_prikaz.dd = b.data_prikaz.dd) and
    (a.data_prikaz.mm = b.data_prikaz.mm) and
    (a.data_prikaz.yy = b.data_prikaz.yy) and
    (a.cod_post = b.cod_post) and
    (a.sum_ege = b.sum_ege);
end;
begin
 
end.