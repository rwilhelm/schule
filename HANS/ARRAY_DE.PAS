program Array_Demo;            {Daniel Christophis 20.08.99}
uses crt;                      {demonstriert den Datentyp: eindimensionales Feld}
var k: integer;               
    zahl: array[1..10] of real;
    summe: real;
    datei: text;
begin
   clrscr;
   writeln('Programm zur Erfassung von 10 reellen Zahlen');
   for k:=1 to 10 do begin
                        write('Zahl=');
                        readln(zahl[k]);
                     end;
   summe:=0;
   for k:=1 to 10 do summe:=summe+zahl[k];
   writeln('Gesamte Summe:',summe:10:2);
   readln;
   assign(datei,'C:\tp\Tabelle.txt');
   rewrite(datei);
   for k:=1 to 10 do writeln(datei, zahl[k]);
   close(datei);
   writeln('Die Zahl wurde in der Datei "Tabelle.txt" auf dem Laufwerk gespeichert');
   readln;
end.