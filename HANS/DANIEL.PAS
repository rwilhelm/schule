program Messwerte;            {Daniel Christophis 03.09.99}
uses crt, printer;             {demonstriert den Datentyp: eindimensionales Feld}
var k: integer;
    zahl: array[1..10] of real;
    summe: real;
    datei: text;    { Programmkopf: globale Variable }

procedure weiter;
begin
     writeln('Weiter: Beliebige Taste drÅcken');
     repeat until keypressed;
end;

procedure eingabe;
var k : integer; { lokale Variable }
begin
   clrscr;
   writeln('Programm zur Erfassung von 10 reellen Zahlen');
   for k:=1 to 10 do begin
                        write('Zahl=');
                        readln(zahl[k]);
                     end;    { for }
   weiter;
end;   { eingabe }

procedure minimalwert;
var k:integer
begin
   minimum := zahl[1];
   for k:=2 to 10 do begin
                        if zahl[k] < minimum then minimum := zahl[k];
                     end;
   writeln('Minimalwert:',minimum:10:2);
   weiter;
end;

procedure auswertung;
begin
  summe:=0;
   for k:=1 to 10 do summe:=summe+zahl[k];
   writeln('Gesamte Summe:',summe:10:2);
   weiter;
end;   { auswertung }


procedure speicherung;
begin
   writeln('Bitte eine Diskette in Laufwerk A: eingeben');
   weiter;
   assign(datei,'A:\Tabelle.txt');
   rewrite(datei);
   for k:=1 to 10 do writeln(datei, zahl[k]);
   close(datei);
   writeln('Die Zahl wurde in der Datei "Tabelle.txt" auf dem Laufwerk gespeichert');
   weiter;
end;   { speichern }

procedure drucken;
begin
   assign(datei,'A:\Tabelle.txt');
   rewrite(datei);
   for k:=1 to 10 do writeln(LST, zahl[k]:10:2);
   close(datei);
   writeln('Die Messwerte werden jetzt ausgedruckt');
   weiter;
end;   { drucken }

procedure programmende;
begin
   writeln('Ich danke Ihnen fÅr die Benutzung dieses Programms');
   weiter;
end;

procedure menue;
var taste : char;
begin
   repeat
     clrscr; write('Programm zum Erfassen, Auswerten, Speichern und Drucken von Me·werten');

     gotoxy(10,4);  write('Erfassen von Me·werten ........ 1');
     gotoxy(10,6);  write('Auswertung von Messwerten...... 2');
     gotoxy(10,8);  write('Minimalwert vo
     gotoxy(10,8);  write('Speicherung von Messwerten..... 3');
     gotoxy(10,10); write('Drucken von Messwerten......... 4');
     gotoxy(10,12); write('Programmende................... 5');
     gotoxy(10,14); write('Ihre Wahl ..................... ');

     repeat taste := readkey until taste IN ['1','2','3','4','5'];                                ;
     clrscr;

     CASE taste OF
      '1' : eingabe;
      '2' : auswertung;
      '3' : speicherung;
      '4' : drucken;
      '5' : programmende;
     end;  { case }

   until taste = '5';

end;   { menue }


begin  { main }
   menue;
end.

