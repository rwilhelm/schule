program partialsummenrekursiv;   {22.11.1999 - by 2rok}
uses crt;                        {rekursion: wiederholung durch schachtelung}
var x, y: longint;

function gauss (n: longint): longint;
begin

    if n > 1 then      gauss := n + gauss (n-1) {selbstaufruf} {rekursiver abstieg}
             else      gauss := 1; {rekursionsende}

end;

begin
  clrscr;

  write ('bitte x eingeben: ');
  readln (x);

  write (gauss (x));

  repeat until keypressed;

end.