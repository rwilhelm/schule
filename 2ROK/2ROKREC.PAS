PROGRAM record_demo;  {ripped by 2rok}
uses crt;
const maxzahl= 5;
type      tcd= record
           nr: integer;
        titel: string[80];
    interpret: string;
        genre: string[20];
      wertung: byte;
  ausgeliehen: boolean;
    ausleiher: string[40];
          end; {type}

var cd: tcd;
 datei: file of tcd; {typisierte datei}

PROCEDURE linie (code: byte);
var k : byte;
BEGIN
  for k:= 1 to 80 do write (chr (code));
END;

PROCEDURE bildschirm;
BEGIN
  textcolor (yellow); textbackground (lightblue); clrscr;
    gotoxy(01,01); writeln ('code blau');
    gotoxy(01,02); linie (176);
    gotoxy(01,23); linie (176);
    gotoxy(01,24);
END;

procedure weiter; {keypressed}
var k:integer;
begin
     gotoxy(1,24);
     writeln('Bitte eine beliebige Taste drÅcken, um fortzufahren');
     repeat until keypressed;
end; {keypressed}



procedure cds_aufnehmen;
var taste : char;
begin
        assign(datei,'a:cds.dat');
        rewrite(datei);

        repeat bildschirm;
                gotoxy(10,2);   write('0 als CD-Nummer beendet die Eingabe');


        with cd do
             begin
                  gotoxy(1,10);
                  write('CD Nr.:');	  readln(nr);

                  if nr<>0 then begin


	          write('CD-Titel: ');	         readln(titel);
                  write('Interpret:');           readln(interpret);
                  write('Musikrichtung:');       readln(musikrichtung);
                  write('Beurteilung(1 - 6):');  readln(beurteilung);
                  write('Ausgeliehen (J/N) ');
                  taste := readkey;


                  taste :=  upcase(taste);
                  if taste = 'J' then ausgeliehen := true
                                 else ausgeliehen := false;
                  if taste = 'J' then begin
                                        writeln('Ausleiher:');
                                        readln(ausleiher);
                                      end
                                 else ausleiher := '______';

                 end; {with}
                write(datei,cd);
                end; {if}
           until cd.nr=0;
           close(datei);

end;  { procedure cdsaufnehmen}

procedure CD_Ausgabe;
begin
          with cd do
             begin
              gotoxy(10,10);    write('CD Nr.:               ', nr);
              gotoxy(10,12);    write('CD-Titel:             ', titel);
              gotoxy(10,14);    write('Interpret:            ', interpret);
              gotoxy(10,16);    write('Musikrichtung:        ', musikrichtung);
              gotoxy(10,18);    write('Beurteilung:          ', beurteilung);
              gotoxy(10,20);    write('Ausleiher:            ', ausleiher);
                  weiter;
                  repeat until keypressed;

    end; {with}
end;


procedure CDs_anzeigen;
begin
     assign(datei,'a:cds.dat');
     reset(datei);   { ôffnen zum Lesen }
     repeat
      clrscr;
      read(datei, cd);      { Lesen eines kompletten Records }
      CD_Ausgabe;
    until eof(datei);

           close(datei);



end;
{ ---------------------- Such- Routinen ---------------------------------}

procedure suche_Titel;
var gesuchter_titel : string[80];
begin
    write('Geben Sie bitte den gesuchten Titel an:  '); readln(gesuchter_titel);
    Assign(datei, 'A:cds.dat');
    reset(datei); { ôffnen zum Lesen }
    repeat
         read(datei, cd)
    until  ( EOF(datei) )  OR  ( CD.TITEL = gesuchter_titel );
    if CD.Titel = gesuchter_titel Then  CD_Ausgabe
                                  Else  write('Gesuchter Titel nicht vorhanden');
    close(datei);
    weiter;
end;

procedure suche_interpret;
var gesuchter_interpret: string[80];
begin
    write('Geben Sie bitte den gesuchten Interpreten an:  '); readln(gesuchter_interpret);
    Assign(datei, 'A:cds.dat');
    reset(datei); { ôffnen zum Lesen }
    repeat
         read(datei, cd)
    until  ( EOF(datei) )  OR  ( CD.INTERPRET = gesuchter_interpret );
    if CD.INTERPRET = gesuchter_INTERPRET Then  CD_Ausgabe
                                  Else  write('Gesuchter INTERPRET nicht vorhanden');
    close(datei);
    weiter;
end;


procedure CD_suchen;
begin
    { MenÅ, waas gesucht werden soll }
    { Auswahl}
    { Unterprozedur aufrufen }
    { RÅcksprung ins Menue }
    suche_Titel;

end;


procedure programmende;
begin
     weiter;
end;

procedure menue;
var taste:char;
begin
           repeat {Ñu·ere schleige}
           bildschirm;
           gotoxy(1,3); write('Programm zum Anlegen und Verwalten einer CD-Sammlung');

           gotoxy(10,5);  write('Neue CDÔs aufnehmen.......1');
           gotoxy(10,7);  write('CDÔs anzeigen.............2');
           gotoxy(10,9);  write('CDÔs lîschen..............3');
           gotoxy(10,11);  write('CDÔs korrigieren..........4');
           gotoxy(10,13);  write('CDÔs suchen...............5');
           gotoxy(10,15); write('CD-Sammlung importieren...6');
           gotoxy(10,17); write('Programm beenden..........7');
           gotoxy(10,24); write('Ihre Wahl ...............  ');
           repeat
           taste:=readkey until taste in ['1','2','3','4','5','6','7'];

           bildschirm;
           case taste of
                '1':cds_aufnehmen;
                '2':cds_anzeigen;
               { '3':
                '4':}
                '5':  CD_suchen;
            {   '6':}
                '7':programmende;
            end; {case}
            until taste = '7';   {Ñu·ere schleife}

end;

begin   { main }

        menue;
end.