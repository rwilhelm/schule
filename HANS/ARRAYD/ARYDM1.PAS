program array_demo;       {hans@lugg.de 27.08.99}
uses crt;
var k: integer;
    zahl: array [1..10] of real;
    summe: real;
    datei:text;

begin
     clrscr;
     writeln ('Programm zur Erfassung von 10 reelen Zahlen');
     for k:=1 to 10 do begin
                       writeln('N„chste Zahl=');
                       readln(zahl[K]);
                       end;
     summe:=0;
     for k:=1 to 10 do summe:=summe+zahl[k];
     writeln('Summe:',Summe:10:2);
     assign (datei,'c:\tp-dos\hans\array_demp\array_demo_tabelle.txt');
     rewrite (datei);
     for k:= 1 to 10 do writeln (datei,zahl[k]);
     close (datei);
     repeat until keypressed;
end.

