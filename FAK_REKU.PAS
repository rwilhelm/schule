{$n+}
program fakultaet_rekursiv;   {by 2rok}
uses crt;
var x, y: extended;

function fakultaet (n: extended): extended;
begin
  if n>1 then fakultaet := n * fakultaet (n-1)
         else fakultaet := 1;
end;

begin
  repeat

  clrscr;
  textcolor (red);
  gotoxy (10,10); write ('ษอออออออป');
  gotoxy (10,11); write ('บ       บ');
  gotoxy (10,12); write ('ศอออออออผ');
  gotoxy (14,11); readln (x);

  until (x>0) and (x=trunc(x));

  y := fakultaet (x);

  textcolor (green);
  gotoxy (30,10); write ('ษออออออออออออออออออออออออออป');
  gotoxy (30,11); write ('บ                          บ');
  gotoxy (30,12); write ('ศออออออออออออออออออออออออออผ');
  gotoxy (32,11); write (y);

  repeat until keypressed;
end.