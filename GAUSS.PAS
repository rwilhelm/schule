program rekursion2;
uses crt;
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