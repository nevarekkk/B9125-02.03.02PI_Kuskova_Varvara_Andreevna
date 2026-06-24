unit l1_read;
interface
uses l1_type,l1_proc;
procedure read_f(var arr: abiturients; var n: integer; var ff: text;
                 var f_skip, f_abnormal, f_incorrect, f_dublicat, f_conflict: text);

implementation


procedure read_f(var arr: abiturients; var n: integer; var ff: text;
                 var f_skip, f_abnormal, f_incorrect, f_dublicat, f_conflict: text);
var
  s, sub: string;
  error, row_error: byte;
  abit: abiturient;
begin
  n := 0;

  while not eof(ff) do
  begin
    readln(ff, s);
    row_error := 0;

    check_palka(s, error);
    if error <> 0 then
      row_error := 1;

    if row_error = 0 then
    begin
      check_skip(s, error);
      if error <> 0 then
        row_error := 3;
    end;

    if row_error = 0 then
    begin
      sub := copy(s, 1, 14);
      check_snils(sub, abit.snils, error);
      if error <> 0 then
        row_error := 1;

      sub := copy(s, 16, 10);
      check_date_bir(sub, error, abit.data_bir);
      if (error <> 0) and (row_error = 0) then
        row_error := 2;

      sub := copy(s, 27, 4);
      check_prikaz(sub, abit.prikaz, error);
      if error <> 0 then
        row_error := 1;

      sub := copy(s, 32, 10);
      check_date_prikaz(sub, error, abit.data_prikaz);
      if (error <> 0) and (row_error = 0) then
        row_error := 2;

      sub := copy(s, 43, 8);
      check_cod_post(sub, abit.cod_post, error);
      if error <> 0 then
        row_error := 1;

      sub := copy(s, 52, 3);
      check_sum_ege(sub, abit.sum_ege, error);
      if (error <> 0) and (row_error = 0) then
        row_error := 2;
    end;

    case row_error of
      0:
      begin
        n := n + 1;
        arr[n] := abit;
      end;
      1: writeln(f_incorrect, s);
      2: writeln(f_abnormal, s);
      3: writeln(f_skip, s);
    end;
  end;
end;
    begin
      
    end.