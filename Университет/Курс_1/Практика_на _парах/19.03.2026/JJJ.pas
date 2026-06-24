
var p, j, x, z, c : chain;
begin
  new(c); c^.data := 5; c^.next := nil;
  new(z); z^.data := 4; z^.next := c;
  new(x); x^.data := 3; x^.next := z;
  new(j); j^.data := 2; j^.next := x;
  new(p); p^.data := 1; p^.next := j;
  j := p;
while  j <> nil do begin
  write(j^.data);
  j := j^.next;
end;
end.