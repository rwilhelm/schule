program lesen; { Daniel Chrtistophis 27.08.99 }
uses crt;          
var k: integer;
    summe: real;
    datei: text;
    zahl: string;

BEGIN
clrscr;
writeln ('Program zum Auslesen der Datei -Tabelle.txt-');

assign (datei, 'c:\tp\tabelle.txt');
reset (datei);
   repeat
   readln (datei, zahl);
   writeln (zahl);
   until eof (datei);
close (datei);

repeat until keypressed;

END.