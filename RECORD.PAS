program record_demo;  	              { R2D2 }
uses crt;
const maxzahl =5;
type       tcd = record
		  nr:integer;
		  titel: string[80];
		  interpret:string;
		  musikrichtung:string[20];
		  beurteilung:byte;
		  ausgeliehen: boolean;
                  ausleiher: string[40];
	          end; { record }

 var  CD : tcd;
      datei:file of tcd; {typisierte datei}
      anzahl: longint;

procedure graphiklinie( code: longint);
var K : byte;
begin  for K:= 1 to 80 do   write( chr(code) );  end;

procedure dateigroesse_anzeigen;
begin
    assign(datei,'a:cds.dat');
    reset(datei); anzahl := filesize(datei); close(datei);
    gotoxy(56,2); write(' cdÔs in der sammlung: ', anzahl:2);
end;

procedure bildschirm;
begin
    textcolor(lightgreen);textbackground(black); clrscr;
    gotoxy(1,1);  writeln('');
    gotoxy(1,2);  graphiklinie(987);
    gotoxy(1,23); graphiklinie(987);
    gotoxy(1,24);
end;

procedure weiter; {keypressed}
var k:integer;
begin
     gotoxy(1,24);
     writeln('taste drÅcken um fortzufahren...');
     repeat until keypressed;
end; {keypressed}

procedure programmende;
begin
     weiter;
end;

procedure cds_aufnehmen;
var taste : char;
begin
        clrscr;
        writeln('cd-sammlung neu anlegen ......................1');
        writeln('neue cdÔs in bestehende Sammlung aufnehmen.....2');
        write('deine wahl'); taste := readkey;
        if taste = '1' then begin


        assign(datei,'a:cds.dat');
        rewrite(datei);

        repeat bildschirm;
                gotoxy(10,2);   write('0 als cd-nummer beendet die eingabe');


        with cd do
             begin
                  gotoxy(1,10);
                  write('cd nr.: ');	          readln(nr);

                  if nr<>0 then begin

	          write('cd-Titel: ');	          readln(titel);
                  write('interpret: ');           readln(interpret);
                  write('musikrichtung: ');       readln(musikrichtung);
                  write('beurteilung(1 - 6): ');  readln(beurteilung);
                  write('ausgeliehen (J/N): ');
                  taste := readkey;

                  taste :=  upcase(taste);
                  if taste = 'J' then ausgeliehen := true
                                 else ausgeliehen := false;
                  if taste = 'J' then begin
                                        writeln('ausleiher:');
                                        readln(ausleiher);
                                      end
                                 else ausleiher := '______';
        end; {with}

                  write(datei,cd);
                  end; {if}
           until cd.nr=0;
           close(datei);
     end { Sammlung neu erzeugen }

   else { CDs anfÅgen }
   begin
        assign(datei,'a:cds.dat');
        reset(datei);
        while NOT ( EOF(datei) ) do read(datei, cd);

        repeat bildschirm;
                gotoxy(10,2);   write('0 als cd-nummer beendet die eingabe');


        with cd do
             begin
                  gotoxy(1,10);
                  write('CD Nr.: ');	          readln(nr);

                  if nr<>0 then begin

	          write('cd-titel: ');	          readln(titel);
                  write('interpret: ');           readln(interpret);
                  write('musikrichtung: ');       readln(musikrichtung);
                  write('beurteilung(1 - 6): ');  readln(beurteilung);
                  write('ausgeliehen (j/n): ');
                  taste := readkey;

                  taste :=  (taste);
                  if taste = 'J' then ausgeliehen := true
                                 else ausgeliehen := false;
                  if taste = 'J' then begin
                                        writeln('ausleiher:');
                                        readln(ausleiher);
                                      end
                                 else ausleiher := '______';
        end; {with}

                  write(datei,cd);
                  end; {if}
           until cd.nr=0;
           close(datei);


   end;


end;  { procedure cdsaufnehmen}

procedure CD_Ausgabe;
begin
          with cd do
             begin
              gotoxy(10,10);    write('cd # .:               ', nr);
              gotoxy(10,12);    write('cd-titel:             ', titel);
              gotoxy(10,14);    write('interpret:            ', interpret);
              gotoxy(10,16);    write('musikrichtung:        ', musikrichtung);
              gotoxy(10,18);    write('beurteilung:          ', beurteilung);
              gotoxy(10,20);    write('ausleiher:            ', ausleiher);
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
        repeat until keypressed;
    until eof(datei);
    write('Ausgabe beendet');
    weiter;
    close(datei);
end;

{-------------------------- Such - Routinen --------------------------------}

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

procedure suche_Interpret;
var gesuchter_Interpret : string[80];
begin
    write('Geben Sie bitte den gesuchten Interpret an:  '); readln(gesuchter_Interpret);
    Assign(datei, 'A:cds.dat');
    reset(datei); { ôffnen zum Lesen }
    repeat
         read(datei, cd)
    until  ( EOF(datei) )  OR  ( CD. interpret = gesuchter_interpret );
    if CD.interpret = gesuchter_interpret Then  CD_Ausgabe
                                  Else  write('Gesuchter Interpret nicht vorhanden');
    close(datei);
    weiter;
end;

procedure suche_Musikrichtung;
var gesuchte_musikrichtung : string[80];
begin
    write('Geben Sie bitte die gesuchte Musikrichtung an:  '); readln(gesuchte_musikrichtung);
    Assign(datei, 'A:cds.dat');
    reset(datei); { ôffnen zum Lesen }
    repeat
         read(datei, cd)
    until  ( EOF(datei) )  OR  ( CD. musikrichtung = gesuchte_musikrichtung );
    if CD.musikrichtung = gesuchte_musikrichtung Then  CD_Ausgabe
                                  Else  write('gesuchte musikrichtung nicht vorhanden');
    close(datei);
    weiter;
end;

procedure cds_suchen;
var taste:char;
begin
     repeat
     bildschirm;
     gotoxy(1,3); write('Unterprogramm zum suchen einzelner Kategorien');

     gotoxy(10,5); write('Titel....................1');
     gotoxy(10,7); write('Interpret................2');
     gotoxy(10,9); write('Musikrichtung............3');
{    gotoxy(10,11);write('Beurteilung..............4');
     gotoxy(10,13);write('Ausleiher................5'); }
     gotoxy(10,15);write('Hauptverzeichniss........6');
     gotoxy(10,24);write('Ihre Wahl................');
     repeat
     taste:=readkey until taste in ['1','2','3','4','5','6'];

     bildschirm;
     case taste of
          '1':suche_Titel;
        {  '2':suche_Interpret;
          '3':suche_Musikrichtung;
          '4':suche_Beurteilung;
          '5':suche_Ausleiher;    }
          '6':programmende;
     end;
     until taste = '6';
    { MenÅ, was gesucht werden soll }
    { Auswahl}
    { Unterprozedur aufrufen }
    { RÅcksprung ins Menue }
end;

procedure menue;
var taste:char;
begin
           repeat {Ñu·ere schleige}
           bildschirm; dateigroesse_anzeigen;
           gotoxy(1,3); write('programm zum anlegen und verwalten einer cd-sammlung');
           gotoxy(10,5);  write('neue cdÔs aufnehmen.......1');
           gotoxy(10,7);  write('cdÔs anzeigen.............2');
           gotoxy(10,9);  write('cdÔs lîschen..............3');
           gotoxy(10,11); write('cdÔs korrigieren..........4');
           gotoxy(10,13); write('cdÔs suchen...............5');
           gotoxy(10,15); write('cd-sammlung importieren...6');
           gotoxy(10,17); write('programm beenden..........7');
           gotoxy(10,24); write('deine Wahl ................');
           repeat
           taste:=readkey until taste in ['1','2','3','4','5','6','7'];

           bildschirm;
           case taste of
                '1':cds_aufnehmen;
                '2':cds_anzeigen;
               {'3':
                '4':}
                '5':cds_suchen;
               {'6':}
                '7':programmende;
            end; {case}
            until taste = '7';   {Ñu·ere schleife}

end;

begin   { main }

        menue;
end.