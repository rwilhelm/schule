PROGRAM record_demo1;	{18.10.99 hans@lugg.de nach einer idee von w.nissel}
uses crt;               {         beaufsichtigt von 2rok                   }
const maxzahl= 5;
type      tcd= record
	   nr: integer;
        titel: string[80];
    interpret: string;
musikrichtung: string[20];
  beurteilung: byte;
  ausgeliehen: boolean;
    ausleiher: string[40];
          end; { record }

var    cd: tcd;
    datei: file of tcd; { typisierte datei }


PROCEDURE graphiklinie (code: byte);
var k: byte;
begin
  for k:= 1 to 80 do write (chr(code));
end;


PROCEDURE bildschirm;
begin
  textcolor (yellow);
  textbackground (blue);
  clrscr;
  gotoxy (1,1);  writeln ('blaupunkt');
  gotoxy (1,2);  graphiklinie (176);
  gotoxy (1,23); graphiklinie (176);
  gotoxy (1,24);
end;


PROCEDURE weiter; { keypressed }
var k:integer;
begin
  gotoxy (1,24);
  writeln ('beliebige taste drÅcken um fortzufahren...');
  repeat until keypressed;
end; { keypressed }

PROCEDURE cd_ausgabe (var eintrag: tcd);
begin
    with eintrag do
      begin
        gotoxy(10,10);    write('cd nr.:                ', nr);
        gotoxy(10,12);    write('cd-titel:              ', titel);
        gotoxy(10,14);    write('interpret:             ', interpret);
        gotoxy(10,16);    write('musikrichtung:         ', musikrichtung);
        gotoxy(10,18);    write('beurteilung (1 bis 6): ', beurteilung);
        gotoxy(10,20);    write('ausleiher:             ', ausleiher);
    end; {with}
end; {ausgabe eines records}


PROCEDURE cds_aufnehmen;
var taste: char;
begin
  assign (datei, 'a:cds.dat');
  rewrite (datei);

    repeat bildschirm;
    gotoxy (10,2);   write ('0 als cd-nummer beendet die eingabe');

  with cd do
    begin
      gotoxy (1,10);
      write ('cd nr.:'); readln (nr);

      if nr<>0 then
        begin
          write ('cd-titel: ');	        readln(titel);
          write ('interpret: ');        readln(interpret);
          write ('musikrichtung: ');    readln(musikrichtung);
          write ('beurteilung: ');      readln(beurteilung);
          write ('ausgeliehen (j/n) ');
          taste:= readkey;

          taste:=  upcase(taste);
          if taste= 'j' then ausgeliehen:= true
                        else ausgeliehen:= false;
          if taste= 'j' then
            begin
              writeln ('ausleiher:');
              readln (ausleiher);
            end
          else ausleiher:= '______';

        end; {with}

        write (datei,cd);

    end; {if}

  until cd.nr=0;
  close(datei);

end; {procedure cdsaufnehmen}

PROCEDURE cds_anzeigen;
begin
  assign (datei, 'a:cds.dat');
  reset(datei); { îffnen zum lesen }
  repeat
    clrscr;
    read (datei, cd); { lesen eines kompletten records }
    with cd do
      begin
        gotoxy(10,10);    write('cd nr.:                ', nr);
        gotoxy(10,12);    write('cd-titel:              ', titel);
        gotoxy(10,14);    write('interpret:             ', interpret);
        gotoxy(10,16);    write('musikrichtung:         ', musikrichtung);
        gotoxy(10,18);    write('beurteilung (1 bis 6): ', beurteilung);
        gotoxy(10,20);    write('ausleiher:             ', ausleiher);
        weiter;
        repeat until keypressed;
      end; {with}
  until eof (datei);
  close (datei);
end;

PROCEDURE suchen_titel;
var ges_titel: string[80];
begin
  bildschirm;
  gotoxy (20,2); writeln ('Suche nach einer CD, deren Titel angegeben ist..');
  gotoxy (10,10); write ('Geben Sie den gesuchten Titel ein (max. 8 Zeichen): ');
                  readln (ges_titel);
  assign (datei, 'a:cds.dat');
  reset (datei);
  repeat
    read (datei, cd);
  until (ges_titel=cd.titel) or (eof (datei));

  if eof (datei) then begin
    gotoxy (10,10); write ('CD-Titel in der Sammlung nicht enthalten oder der');
    gotoxy (10,12); write ('CD-Titel wurde falsch eingetippt!');
  end


  else begin
     gotoxy (10,10); write ('                                              ');
     gotoxy (10,12); write ('                                              ');
    cd_ausgabe (cd);
       end;
  close (datei);
 weiter;

end; {titelsuche}


PROCEDURE programmende;
begin
  weiter;
end;

PROCEDURE menue;
var taste: char;
begin
  repeat { Ñu·ere schleife }
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
  repeat taste:= readkey until taste in ['1','2','3','4','5','6','7'];

  bildschirm;
  case taste of
                '1':cds_aufnehmen;
                '2':cds_anzeigen;
              { '3':
                '4': }
                '5':suchen_titel;
              { '6':}
                '7':programmende;
            end; {case}
            until taste = '7';   {Ñu·ere schleife}

end;

begin   { main }

        menue;
end.