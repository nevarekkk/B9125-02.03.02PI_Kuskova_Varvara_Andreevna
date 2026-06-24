unit u_bug;
interface
uses graphABC;
type
bug = class
  private
  x, y, r :word;
  dx, dy : integer;
  c :color;
  public
  constructor create(xx, yy, rr :word; cc :color);
  //constructor create(xx, yy, rr :word; cc :color);
  procedure draw;
  procedure hide;
  procedure move;
  procedure set_dx_dy(_dx, _dy :integer);
  
  procedure set_r(rr :word);
  {procedure set_color(_dx, _dy :integer);
  procedure set_y(_dx, _dy :integer);
  procedure set_x(_dx, _dy :integer);
  
  function get_z : word}
  implementation 
  constructor bug.create(xx, yy, rr : word: cc: color);
  begin
    x := xx;
    y := yy;
    r := rr;
    c := cc;
    dx := 0;
    dy := 0;
    if (rr > min(xx, yy)) or (rr > (windowHeight - rr)) or (rr > (windowWidth - rr)) or (rr < 2) or (rr > min(windowHeight, windowWidth) div 2) then
      x := windowWidth div 2; y := windowHeight div 2; r := 10;
    end;
    
  procedure bug : draw;
  begin 
    setPenColor(c);
    SetBrushColor(c);
    circle(x, y, r);
    end;
    procedure bug.Hide;
    begin
      SetPenColor(Clwhite);
      SetBrushColor(Clwhite);
      circle(x, y, r);
    end;
    
  end;
  procedure set_dx_dy(_dx, _dy :integer);
  begin
    if abs(_dx) > 20 then dx := 20
    else dx := _dx;
    
    if abs(_dy) > 20 then dy:= 20
    else dy := _dy;
  end;
  
  procedure bug.move;
  begin
    hide;
    x := x + dx;
    y := y + dy;
    if  (r > y) then y:= WindowHeght - r
    else if y + r > WindowHeght then y := r;
    
    if  (r > x) then x := WindowWidth - r
    else if x + r > Windowwidth then x := r;
    draw;
  end;
  
  