program MaxIfElseThen;

var
  fput, fout: text;
  ch: char;
  wordd: string;
  curText, bestText: string;
  curElse, bestElse: integer;

  started, inWord: boolean;

function IsIdentChar(c: char): boolean;
begin
  IsIdentChar := ((c >= 'A') and (c <= 'Z')) or ((c >= 'a') and (c <= 'z')) or ((c >= '0') and (c <= '9')) or (c = '_');
end;

function IsProgramWord(s: string): boolean;
begin
  if length(s) <> 7 then
    IsProgramWord := false
  else
    IsProgramWord := ((s[1]='p') or (s[1]='P')) and ((s[2]='r') or (s[2]='R')) and ((s[3]='o') or (s[3]='O')) and ((s[4]='g') or (s[4]='G')) and ((s[5]='r') or (s[5]='R')) and ((s[6]='a') or (s[6]='A')) and ((s[7]='m') or (s[7]='M'));
end;

function IsElseWord(s: string): boolean;
begin
  if length(s) <> 4 then
    IsElseWord := false
  else
    IsElseWord := ((s[1]='e') or (s[1]='E')) and ((s[2]='l') or (s[2]='L')) and ((s[3]='s') or (s[3]='S')) and ((s[4]='e') or (s[4]='E'));
end;

procedure SaveBest;
begin
  if curElse > bestElse then
  begin
    bestElse := curElse;
    bestText := curText;
  end;
end;

procedure FinishWord;
begin
  if length(wordd) = 0 then

  if IsProgramWord(wordd) then
  begin
    if started then
    begin
      SaveBest;
      curText := '';
      curElse := 0;
    end
    else
      started := true;

    curText := curText + wordd;
  end
  else
  begin
    if started then
    begin
      curText := curText + wordd;
      if IsElseWord(wordd) then
        curElse := curElse + 1;
    end;
  end;

  wordd := '';
end;

begin
  assign(fput, 'input.txt');
  reset(fput);

  assign(fout, 'otput.txt');
  rewrite(fout);

  wordd := '';
  curText := '';
  bestText := '';

  curElse := 0;
  bestElse := -1;

  started := false;
  inWord := false;

  while not eof(fput) do
  begin
    read(fput, ch);

    if IsIdentChar(ch) then
    begin
      inWord := true;
      wordd := wordd + ch;
    end
    else
    begin
      if inWord then
      begin
        FinishWord;
        inWord := false;
      end;

      if started then
        curText := curText + ch;
    end;
  end;

  if inWord then
    FinishWord;

  if started then
    SaveBest;

  write(fout, bestText);

  close(fput);
  close(fout);
end.
