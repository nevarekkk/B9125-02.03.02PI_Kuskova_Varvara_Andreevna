unit u_read;
interface
uses u_type;
procedure read_f(var f: friend; var n : integer; ff: text);

implementation
    procedure read_f(var f: friend; var n : integer; ff: text);
    var
      k : integer;
      s : string;
      begin
        n := 0;
        while not eof(ff) do begin
        readln(ff, s);
        k := pos(' ' , s);
        n := n + 1;
        f[n].name := copy(s, 1, k - 1);
        delete(s, 1, k);
        f[n].age := StrToInt(s);
      end;
    end;
    begin
      
    end.
    