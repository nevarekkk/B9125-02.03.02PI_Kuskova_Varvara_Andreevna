type chain=^elem;
elem=record
  data:integer;
  next:chain;
end;

procedure oo(var head : chain; i : integer);
var
  cur: chain;
  begin
    new(cur);
    cur^.data := i;
    cur^.next := head;
    head := cur;
  end;
procedure print(var head : chain)
  var
  cur: chain;
  begin
    
    while head <> nil
  end;




procedure init_list(var head:chain);
begin
  head:=nil;
end;
begin
  
end.