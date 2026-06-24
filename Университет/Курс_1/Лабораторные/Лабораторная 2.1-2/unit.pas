program postyplenie;
uses l1_read, l1_type, l1_proc;

var
  f_in, f_out: text;
  f_skip, f_abnormal, f_incorrect, f_dublicat, f_conflict: text;
  array_f:  abiturients;
  n_c: integer;
  

begin
  assign(f_in, 'input_anom_4pole.txt');
  reset(f_in);

  assign(f_out, 'output.txt');
  rewrite(f_out);

  assign(f_skip, 'skip.txt');
  rewrite(f_skip);

  assign(f_abnormal, 'abnormal.txt');
  rewrite(f_abnormal);

  assign(f_incorrect, 'incorrect.txt');
  rewrite(f_incorrect);
  
  assign(f_dublicat, 'dublicat.txt');
  rewrite(f_dublicat);
  
  assign(f_conflict, 'conflict.txt');
  rewrite(f_conflict);
  
  n_c := 0;

  read_f(array_f, n_c, f_in, f_skip, f_abnormal, f_incorrect, f_conflict, f_dublicat);
  remove_dublicates(array_f, n_c, f_dublicat);
  remove_conflicts(array_f, n_c, f_conflict);
  sort(array_f, n_c);
  write_f(f_out, array_f, n_c);

  close(f_in);
  close(f_out);
  close(f_skip);
  close(f_abnormal);
  close(f_incorrect);
  close(f_dublicat);
  close(f_conflict);
end.