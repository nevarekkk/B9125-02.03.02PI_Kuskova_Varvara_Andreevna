type chain=^elem;
elem=record
  data:integer;
  next:chain;
end;

procedure union_list(var l1,l2:chain);
var cur1,cur2,next1,next2:chain;
begin
if l1=nil then l1:=l2
else if l2=nil then l2:=l1
else begin
  cur1:=l1;cur2:=l2;
  while (cur1^.next<>nil)and(cur2^.next<>nil) do begin
    next1:=cur1^.next; next2:=cur2^.next;
    cur1^.next:=cur2; cur2^.next:=next1;
    cur1:=next1;cur2:=next2;
  end;
  if (cur2^.next<>nil)then cur1^.next:=cur2
  else if (cur1^.next<>nil)then begin
    next1:=cur1^.next;
    cur1^.next:=cur2;
    cur2^.next:=next1;
  end;

procedure un_list(var l1,l2:chain);
var cur1,cur2,next1,next2:chain;
begin 
  
  
  cur^.next
end;
end;

procedure init_list(var head:chain);
begin
  head:=nil;
end;

procedure print_list(head:chain);
var cur:chain;
begin
  cur:=head;
  while cur<>nil do begin
    write(cur^.data,' ');
    cur:=cur^.next;
  end;
end;

procedure add_list(var head:chain;a:integer);
var cur:chain;
begin
  new(cur);
  cur^.data:=a;
  cur^.next:=head;
  head:=cur;
end;

var l1,l2:chain;
i:integer;
begin
  init_list(l1);init_list(l2);
  for i:=1 to 5 do add_list(l1,2*i);
  for i:=1 to 5 do add_list(l2,2*i+1);
  print_list(l1);writeln();print_list(l2);writeln();
  union_list(l1,l2);print_list(l1);writeln();print_list(l2)
end.