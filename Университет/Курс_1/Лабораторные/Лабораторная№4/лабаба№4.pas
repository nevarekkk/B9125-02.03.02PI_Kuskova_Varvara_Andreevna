var
  s, scc1, scc2, scc3, sc, wordd: string;
  cp, if1, if2, if3, el1, el2, el3, mx, r1, r2, r3: integer;
  start, finish: text;
  i: integer;
begin
  assign(start, 'input.txt');
  reset(start);
  cp := 0;
  if1 := 0; if2 := 0; if3 := 0;
  el1 := 0; el2 := 0; el3 := 0;
  r1 := 0; r2 := 0; r3 := 0;
  sc := '';
  wordd := '';
  while not eof(start) do
  begin
    readln(start, s);
    s := lowercase(s);
    for i := 1 to length(s) do
    begin
      if cp > 0 then
        sc := sc + s[i];

      if (s[i] >= 'a') and (s[i] <= 'z') then
        wordd := wordd + s[i]
      else
      begin
        if wordd = 'program' then
        begin
          if cp = 1 then scc1 := sc
          else if cp = 2 then scc2 := sc
          else if cp = 3 then scc3 := sc;
          if cp < 3 then cp := cp + 1;
          sc := '';
          wordd := '';
        end
        else if cp > 0 then
        begin
          if wordd = 'if' then
            case cp of
              1: r1 := r1 + 1;
              2: r2 := r2 + 1;
              3: r3 := r3 + 1;
            end;

          if wordd = 'else' then
            case cp of
              1: if r1 > 0 then begin r1 := r1 - 1; if1 := if1 + 1; el1 := el1 + 1; end;
              2: if r2 > 0 then begin r2 := r2 - 1; if2 := if2 + 1; el2 := el2 + 1; end;
              3: if r3 > 0 then begin r3 := r3 - 1; if3 := if3 + 1; el3 := el3 + 1; end;
            end;
          wordd := '';
        end
        else
          wordd := '';
      end;
    end;
    if wordd = 'program' then
   
  close(start);
  if cp = 1 then scc1 := sc
  else if cp = 2 then scc2 := sc
  else if cp = 3 then scc3 := sc;
  r1 := if1;  r2 := if2;  r3 := if3;

  mx := r1;
  if r2 > mx then mx := r2;
  if r3 > mx then mx := r3;

  assign(finish, 'otput.txt');
  rewrite(finish);

  if mx = r1 then writeln(finish, scc1)
  else if mx = r2 then writeln(finish, scc2)
  else writeln(finish, scc3);
  close(finish);