program Array_Demo; {demonstriert den Datentyp: eindimensionales Feld}

   {hans@lugg.de 01.09.99
              nach einer Idee von Daniel Christophis am 20.08.99
              und Hilfe von Herrn Nissel }
   { hans@lugg.de druckerausgabe prodcedure eingebaut 06.09.99,
     10.09.99 letzte énderungen inkl. minimalwert}

uses crt,printer;
var k: integer;
    zahl: array[1..10] of real;
    summe, minimum,maximum: real;
    datei: text;          { Programmkopf: globale Variable }

procedure weiter; {keypressed}
   begin;
     writeln('Bitte eine beliebige Taste drÅcken um fortzufahren');
     repeat until keypressed;
   end;              {keypressed}

procedure eingabe_von_messwerten;
var k : integer; { lokale Variable }
   begin
     clrscr;
     writeln('Programm zur Erfassung von 10 reellen Zahlen');
     for k:=1 to 10 do begin
                        write('Zahl=');
                        readln(zahl[k]);
                       end;
     weiter;
   end;   { eingabe_von_messwerten }

procedure auswertung;
   begin
     summe:=0;
     for k:=1 to 10 do summe:=summe+zahl[k];
     writeln('Gesamte Summe:',summe:10:2);
     weiter;
   end;   { auswertung }

procedure speichern;
   begin
     assign(datei,'C:\tp-dos\hans\tabelle.txt');
     rewrite(datei);
     for k:=1 to 10 do writeln(datei, zahl[k]);
     close(datei);
     writeln('Die Zahl wurde in der Datei "Tabelle.txt" auf dem Laufwerk gespeichert');
     weiter;
  end; { speichern }

procedure druckausgabe; {nachtrÑglich eingebaut am 06.09.99}
  var k:integer;
  begin
     assign(datei,'C:\tp-dos\hans\tabelle.txt');
     rewrite(datei);
     for k:= 1 to 10 do writeln(lst,zahl[k]);
     close(datei);
     writeln;
     writeln('Die Zahlen wurden gedruckt.');
     weiter;
  end;

procedure minimalwert;
var k:integer;
begin
   minimum := zahl[1];
   for k:=2 to 10 do begin
                        if zahl[k] < minimum then minimum := zahl[k];
                     end;
   writeln('Minimalwert:',minimum:10:2);
   weiter;
end;

procedure maximalwert;
var k:integer;
begin
   maximum := zahl[1];
   for k:=2 to 10 do begin
                      if zahl[k] > maximum then maximum := zahl[k]
                     end;
   writeln('Maximalwert:',maximum:10:2);
   weiter;
end;


procedure programmende;
  begin
     weiter;
  end;


procedure menue;
  var taste : char;
  begin
     repeat {aÅ·ere Schleife}
     clrscr; write('Programm zum Erfassen, Auswerten und Speichern von Me·werten');

   gotoxy(10,5);  write ('Erfassen von Me·werten ..... 1');
   gotoxy(10,6);  write ('Auswertung von Messwerten....2');
   gotoxy(10,7);  write ('Speichern von Messwerten.....3');
   gotoxy(10,8);  write ('Minimalwert Ausgabe..........4');
   gotoxy(10,9);  write ('Maximalwert Ausgabe..........5');
   gotoxy(10,10); write ('Drucken......................6');
   gotoxy(10,11); write ('Programmende................ 7');

   gotoxy(10,13); write ('Ihre Wahl ..................');

   repeat taste := readkey until taste IN ['1','2','3','4','5','6','7']; {innere Schleife}
                                  ;
      clrscr;
      CASE taste OF
         '1': eingabe_von_messwerten;
         '2': auswertung;
         '3': speichern;
         '4': minimalwert;
         '5': maximalwert;
         '6': druckausgabe;
         '7': programmende;
      end; {case}
   until taste = '7'; {Ñu·ere schleife ende}

  end; {menue}

begin      { Main }
    menue;
end.