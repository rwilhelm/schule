program partialsummeniterativ; {29.11.1999 - by 2rok}
uses crt;                      {iteration: wiederholung durch aneinanderreihung}
var x: longint;

function summe(n: longint): longint;
var k, teilsumme: longint;
begin
  teilsumme := 0;
  for k := 1 to n do teilsumme := teilsumme + k;
  summe := teilsumme;
end;

5begin
clrscr;
  write ('gib ne zahl ein: '); readln (x);
  write (summe(x));
  repeat until keypressed;
end.