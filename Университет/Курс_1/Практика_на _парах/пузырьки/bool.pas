uses u_bug, u_colonya, GraphABC;
var
  c_red, c_green: colonya;
  i : integer;
  b : bug;
  begin
    c_red := colonya.create(clred, 5);
    c_green := colonya.create(clgreen, 5);
    for i := 1 to 5 do begin
      b := bug.create(random(100) + 20, random(100) + 20, random(10) + 5, clred);
      b.set_dx_dy(5 - random(10), 5 - random(10));
      c_red.add(b);
    end;
    for i := 1 to 7 do begin
      b := bug.create(random(100) + 20, random(100) + 20, random(10) + 5, clgreen);
      b.set_dx_dy(5 - random(10), 5 - random(10));
      c_green.add(b);
    end;
    
    while true do begin
      c_red.move;
      c_green.move;
    end;
  end.
  