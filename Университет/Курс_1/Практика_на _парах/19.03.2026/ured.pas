program nnn;
uses u_read, u_type, u_proc;
      var 
     f_in, f_out: text;
     array_f : friend;
     count_f, a, b: integer;
     begin
      assign(f_in,'input.txt'); reset(f_in);
      assign(f_out,'output.txt'); rewrite(f_out);
      read_f(array_f, count_f, f_in);
      sort(array_f, count_f);
      print_f(array_f, count_f, f_out);
      a := 15; b := 21;
      serch(array_f, count_f, a, b, f_out);
      close (f_in);
      close(f_out);
    end.

