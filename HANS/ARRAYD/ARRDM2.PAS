program array_demo; { hans@lugg.de , nach einer idee von 2rok 27.08.99 }
uses crt;           { demonstriert den h”heren datentyp /
                      eindimensionales feld }
var k: integer;
    summe: real;
    datei: text;
    zahl: string;

BEGIN
clrscr;
writeln ('Programm zum Auslesen der Array-Demo Tabelle');

assign (datei,'c:\tp-dos\hans\arrayd\array_dm.txt');
reset (datei);
  repeat
        readln (datei, zahl);
        writeln (zahl);
  until eof (datei);
close (datei);

repeat until keypressed;

END.