program array_demo; { 2rok - 20.08.99 }
uses crt;           { demonstriert den h”heren datentyp / eindimensionales feld }
var k: integer;
    zahl: array [1..10] of real;
    summe: real;
    datei: text;
begin
clrscr;
writeln ('prog zur erfassung von 10 reellen zahlen');
  for k:=1 to 10 do
   begin
   write ('gib ne zahl ein= ');
   readln (zahl[k]);
   end;

summe:=0;
  for k:=1 to 10 do summe:= summe+ zahl[k];

writeln ('alles zusammen gibt',summe:10:2);


{ speichern der daten in eine textdatei }
assign (datei, 'c:\windows1\desktop\tabelle.txt');
rewrite (datei);
  for k:=1 to 10 do writeln(datei, zahl[k]);

close (datei);
write ('die zahlen und das ergebnis wurden auf dem desktop unter -tabelle.txt- gespeichert');

readln;
end.

