program array_demo; { 2rok - 20.08.99 }
uses crt;           { demonstriert den h”heren datentyp / eindimensionales feld }
var k: integer;
    summe: real;
    datei: text;
    zahl: string;

BEGIN
clrscr;
writeln ('prog zum auslesen von -tabelle.txt-');

assign (datei, 'c:\windows1\desktop\tabelle.txt');
reset (datei);
  repeat
   readln (datei, zahl);
   writeln (zahl);
   until eof (datei);
close (datei);

repeat until keypressed;

END.