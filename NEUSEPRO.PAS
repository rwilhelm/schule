PROGRAM RAY;
uses crt;
var K:INTEGER;                { GLOBALE VARIABLE }
    zAHL:ARRAY[1..10]of real;
    summe:real;
    datei:text;

PROCEDURE BALKEN ( LAENGE: byte);  { CALL BY VALUE }
VAR I : BYTE;
BEGIN
    FOR I := 1 TO LAENGE DO WRITE('¯');
END;


PROCEDURE EINGABE;

BEGIN
    clrscr;
    BALKEN(80);
    for k:=1 to 10 do begin
                      write ('ZAHL= ');
                      READLN (zahl [K]);
                      end;
   summe:=0;
   for k:=1 to 10 do summe:=summe+zahl[k];
   writeln ('Summe= ',summe:10:2);

END; { EINGABE }

PROCEDURE SPEICHERN;
VAR k : INTEGER;  { LOKALE VARIABLE}
BEGIN
   BALKEN(160);
   assign (datei,'C:\tabelle.text');
   rewrite (datei);
   for k:= 1 to 10 do writeln (DATEI,ZAHL [K]);
   CLOSE (DATEI);
   WRITELN ('Die Zahlen wurden in der Datei tabelle auf der Festplatte gespeichert');
   readln;
END;

begin { MAIN }

    EINGABE;
    SPEICHERN;

end.
