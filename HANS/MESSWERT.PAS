program Array_Demo;            {Daniel Christophis 20.08.99}
uses crt;                      {demonstriert den Datentyp: eindimensionales Feld}
var k: integer;               
    zahl: array[1..10] of real;
    summe: real;
    datei: text;          { Programmkopf: globale Variable }

procedure eingabe_von_messwerten;
var k : integer; { lokale Variable }
begin
   clrscr;
   writeln('Programm zur Erfassung von 10 reellen Zahlen');
   for k:=1 to 10 do begin
                        write('Zahl=');
                        readln(zahl[k]);
                     end;
 
end;   { eingabe_von_messwerten }

procedure auswertung;
begin
  summe:=0;
   for k:=1 to 10 do summe:=summe+zahl[k];
   writeln('Gesamte Summe:',summe:10:2);
end;   { auswertung }


procedure speichern;
begin
   assign(datei,'C:\tp\Tabelle.txt');
   rewrite(datei);
   for k:=1 to 10 do writeln(datei, zahl[k]);
   close(datei);
   writeln('Die Zahl wurde in der Datei "Tabelle.txt" auf dem Laufwerk gespeichert');
end; { speichern }

procedure programmende;
begin

end;

procedure menue;
var taste : char;
begin
   clrscr; write('Programm zum Erfassen, Auswerten  und Speichern von Meáwerten');

   gotoxy(10,5); write('Erfassen von Meáwerten ..... 1');

   gotoxy(10,10); write('Programmende............... 4');

   repeat taste := readkey until taste IN ['1';'2';'3';'4'];                                ;

   CASE taste OF
   '1' : eingabe_von_messwerten;
   '2':
   '3':
   '4': programmende;





end;

begin      { Main }
    menue;
end.