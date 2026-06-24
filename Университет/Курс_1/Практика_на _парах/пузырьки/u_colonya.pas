unit u_colonya;
interface
uses u_bug, graphABC;
type colonya = class
private
 c :color;
 max_kol, cur_kol : word;
 col_bug : array of bug;

public
constructor Create(cc :color; max : word);
procedure add(b :bug);
procedure draw;
procedure hide;
procedure move;

procedure life;
procedure war(c : colonya);

//procedure del(b :bug);
// function get_c :color;
//function get_max : word
//procedure set_c(cc:color);
//function get_cur :word;

end;
implementation 
constructor colonya.Create(cc :color; max : word);
begin
  c := cc;
  max_kol := max;
  cur_kol := 0;
  col_bug := new bug[max_kol];
end;

procedure colonya.add(b :bug);
begin
if cur_kol < max_kol then 
begin
  col_bug[cur_kol] := bug.create(b);
end;
end;

procedure war(c : colonya);
var
  i, j , k :integer;
  begin
    for i := 0 to cur_kol - 1 do
      for j := 0 to c.cur_col do 
      begin
        if  col_bug[i].meet(c.col_bug[j])
        then begin
          if col_bug[i].get_r > c.col_bug[j].get_r then
          begin
            if col_bug[i].set_r(col_bug[i].get_r +c.col_bug[i].get_r div 2) then
            for k := j + 1 to c.cur_kol - 1 do 
            c.col_bug[k-1] := c.col_bug[k];
            c.cur_kol := c.cur_count - 1;
          end
          else if col_bug[i].get_r < c.col_dug[j].get_r then
          begin
            c.col_bug[j].set_r(c.col_bug[j].get_r +col_bud[i].get_r div 2);
            for k := i + 1 to c.cur_kol - 1 do 
            c.col_bug[k-1] := c.col_bug[k];
            c.cur_kol := c.cur_count - 1;
          end;
        end;
      end;
  end;

procedure colonya.draw;
var i:integer;
begin
  for i := 0 to cur_kol - 1 do
    col_bug[i].draw;
end;

procedure colonya.hide;
var i:integer;
begin
  for i := 0 to cur_kol -1 do
    col_bug[i].hide;
end;

procedure colonya.move;
var i:integer;
begin
  for i := 0 to cur_kol -1 do
    col_bug[i].move;
end;

    procedure colonya.life;
    var i, j : integer;
    b : bug;
    begin
      move;
      for i := 0 to cur_kol - 2 do
        for j := i + 1 to cur_kol - 1 do
        if col_bug[i].meet(col_bug[j]) then
        begin
          b := bug.create(Random(100) + 20, random(100) + 20,( col_bug[i].get_r + col_bug[j].get_r) div 2, c);
           //b := set_dx_dy(5 - Random(20), 5 - Random(20));
          add(b);
        end;
    end;
end.