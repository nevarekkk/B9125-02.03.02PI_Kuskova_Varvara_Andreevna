uses u_list1;
var 
  l1, l2: chain;
  i:integer;
begin
  init_List1(L1);
  init_List1(L2);
  for i:=1 to 5 do begin 
    if i mod 2 = 0 then add_List1(L1,2*i)
  end;
  for i:=1 to 5 do 
  begin
    if i mod 2 = 0 then add_List1(L1,2*i + 1);
    begin
      delete(l1,i);
      delete(l2,i);
  print_list1(L1);
  print_list1(L2);
end;
end;
 begin

 end;