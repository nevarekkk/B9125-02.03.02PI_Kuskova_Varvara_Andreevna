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
  s := LowerCase(s);
  IsProgramWord := (s = 'program');
end;

function IsElseWord(s: string): boolean;
begin
  s := LowerCase(s);
  IsElseWord := (s = 'else');
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
  if wordd <> '' then
  begin
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
