{---programm zur verwaltung von kontakten---}
program kontaktliste;
uses crt;

{informationen die fÅr einen kontakt gespeichert werden kînnen}
type db_kontakt= record
     id:          longint;
     vorname:     string[50];
     nachname:    string[50];
     strasse:     string[80];
     ort:         string[80];
     plz:         integer;
     tel_privat:  string[30];
     tel_privat2: string[30];
     tel_work:    string[30];
     tel_work2:   string[30];
     tel_mobil:   string[30];
     fax_privat:  string[30];
     fax_work:    string[30];
     msc_email:   string[30];
     msc_uin:     longint;
     msc_www:     string[100];
     msc_msc:     string[100];
end;
     db_datei= file of db_kontakt;
     db_datname= string[12];
{/informationen die fÅr einen kontakt gespeichert werden kînnen}

{globale variablen}
var person, person1: db_kontakt;
    dateiname: db_datname;
    datei_g: db_datei;
{/globale variablen}

{layout}
procedure layout;
var x, y: integer;
begin
  textcolor(white);
  for x:= 1 to 80 do
  begin
    gotoxy(x,01); write (chr(205));
    gotoxy(x,03); write (chr(205));
    gotoxy(x,22); write (chr(205));
    gotoxy(x,24); write (chr(205));
  end;

  for y:= 1 to 24 do
  begin
    gotoxy(01,y); write (chr(186));
    gotoxy(59,y); write (chr(186));
    gotoxy(80,y); write (chr(186));
  end;

  gotoxy(01,01); write (chr(201));
  gotoxy(01,03); write (chr(204));
  gotoxy(01,22); write (chr(204));
  gotoxy(01,24); write (chr(200));
  gotoxy(59,01); write (chr(203));
  gotoxy(59,03); write (chr(206));
  gotoxy(59,22); write (chr(206));
  gotoxy(59,24); write (chr(202));
  gotoxy(80,01); write (chr(187));
  gotoxy(80,03); write (chr(185));
  gotoxy(80,22); write (chr(185));
  gotoxy(80,24); write (chr(188));
end;
{/layout}

{standardtexte}
procedure standardtexte;
begin
  textcolor(lightgreen);
  gotoxy(03,02); write('contact list  -  version 0.2              (by 2rok)');
  gotoxy(61,02); write('contactcounter: ');
  gotoxy(02,23); write('>');
end;
{/standardtexte}

{"zeiger" verschieben}
procedure datei_minimum(var datei: db_datei; j, n: integer);
var k: integer;
    person1, tmp: db_kontakt;
begin
  seek(datei, j-1);
  read(datei, person);
  person1:= person;
  for k:= j+ 1 to n do
    begin
      read(datei, person);
      if person1.nachname > person.nachname then
      begin
        tmp:= person1; person1:= person; person:= tmp;
        seek(datei, j- 1);
        write(datei, person1);
        seek(datei, k- 1);
        write(datei, person);
      end;
    end;
end;
{/zeiger verschieben}

{sortieren}
procedure kontakt_sortieren(var datei: db_datei; var datname: db_datname);
var a, b: integer;
begin
  assign(datei, datname);
  reset(datei);
  b:= filesize(datei);
  for b:= 1 to a- 1 do
  datei_minimum(datei, a, b);
  close(datei);
end;
{/sortieren}

{neue kontaktdatenbank anlegen}
procedure kontakt_neu(var person: db_kontakt);
var taste: char;
begin
  textbackground(blue);
  gotoxy(05,05); write('vorname:        ');
  gotoxy(34,05); write('nachname:       ');
  gotoxy(05,07); write('tel privat (1): ');
  gotoxy(34,07); write('tel privat (2): ');
  gotoxy(05,09); write('tel mobil:      ');
  gotoxy(05,11); write('tel work (1):   ');
  gotoxy(34,11); write('tel work (2):   ');
  gotoxy(05,13); write('strasse:        ');
  gotoxy(05,15); write('plz:            ');
  gotoxy(34,15); write('ort:            ');
  gotoxy(05,17); write('fax privat:     ');
  gotoxy(34,17); write('fax work:       ');
  gotoxy(05,19); write('email:          ');
  gotoxy(34,19); write('uin:            ');
  gotoxy(05,21); write('www:            ');
  gotoxy(34,21); write('bemerkung:      ');
  with person do
    begin
    textbackground(black);
    gotoxy(20,05); readln(vorname);
    gotoxy(52,05); readln(nachname);
    gotoxy(20,07); readln(tel_privat);
    gotoxy(52,07); readln(tel_privat2);
    gotoxy(20,09); readln(tel_mobil);
    gotoxy(20,11); readln(tel_work);
    gotoxy(52,11); readln(tel_work2);
    gotoxy(20,13); readln(strasse);
    gotoxy(20,15); readln(plz);
    gotoxy(52,15); readln(ort);
    gotoxy(20,17); readln(fax_privat);
    gotoxy(52,17); readln(fax_work);
    gotoxy(20,19); readln(msc_email);
    gotoxy(52,19); readln(msc_uin);
    gotoxy(20,21); readln(msc_www);
    gotoxy(52,21); readln(msc_msc);
    end;
end;
{/neue kontaktdatenbank anlegen}

{neuen kontakt hinzufuegen}
procedure kontakt_hinzufuegen(var datei: db_datei; var datname: db_datname);
var ende: integer;
begin
  {$i-} {compilerbefehl, der eine automatische prÅfung von ein/ausgaben veranlasst}
  reset(datei); {in diesem fall ob der "reset"-befehl korrekt ausgefÅhrt werden konnte}
  {$i+}
  if ioresult<>0 then rewrite(datei); {wenn reset nich korrekt ausgefÅhrt werden konnte, ist ioresult=1}
  seek(datei, ende);
  kontakt_neu(person);
  write(datei, person);
  close(datei);
  kontakt_sortieren(datei, dateiname);
end;
{/neuen kontakt hinzufuegen}

{suchen}
procedure kontakt_suchen(datname: db_datname; var datei: db_datei; var person, person1: db_kontakt);
var a, b, c, tmp: integer;
begin
  assign(datei, dateiname);
  reset(datei);
  tmp:= filesize(datei);
  gotoxy(05,23); write('gesuchter nachname: '); readln(person1.nachname);
  a:= 1; b:= tmp;
  repeat
    c:= (a+b) div 2;
    seek(datei, c-1);
    read(datei, person);
    if person1.nachname > person.nachname then a:= c+ 1
                                          else b:= c- 1;
    until (person1.nachname = person.nachname) or (a>b);
end;
{/suchen}

{kontakte anzeigen}
procedure kontakt_anzeigen(person: db_kontakt);
begin
clrscr;
  with person do
  begin
  gotoxy(03,02); write('TASTE drÅcken um den nÑchsten kontakt zu sehen');
  gotoxy(05,05); write('vorname:        ');
  gotoxy(36,05); write('nachname:       ');
  gotoxy(05,07); write('tel privat (1): ');
  gotoxy(36,07); write('tel privat (2): ');
  gotoxy(05,09); write('tel mobil:      ');
  gotoxy(05,11); write('tel work (1):   ');
  gotoxy(36,11); write('tel work (2):   ');
  gotoxy(05,13); write('strasse:        ');
  gotoxy(05,15); write('plz:            ');
  gotoxy(36,15); write('ort:            ');
  gotoxy(05,17); write('fax privat:     ');
  gotoxy(36,17); write('fax work:       ');
  gotoxy(05,19); write('email:          ');
  gotoxy(36,19); write('uin:            ');
  gotoxy(05,21); write('www:            ');
  gotoxy(36,21); write('bemerkung:      ');
  end;
  repeat until keypressed;
end;
{/kontakte anzeigen}

{/komplette datenbank anzeigen}
procedure datenbank_anzeigen(datname: db_datname; var datei: db_datei);
  begin
    assign(datei, dateiname);
    reset(datei);
    while not eof(datei) do
      begin
        read(datei, person);
        kontakt_anzeigen(person);
      end;
    close(datei);
  end;
{/komplette datenbank anzeigen}

{kontakt lîschen}
procedure kontakt_loeschen(datname: db_datname; var datei: db_datei);
var person3: db_kontakt;
    tmp_datei: db_datei;
begin
  gotoxy(05,23); write('geben sie den nachnamen ein: '); readln(person3.nachname);
  assign(datei, dateiname);
  reset(datei);
  assign(tmp_datei, 'c:\contacts.tmp');
  rewrite(tmp_datei);
  while not eof(datei) do
    begin
      read(datei, person);
      if person.nachname<> person3.nachname then write(tmp_datei, person);
    end;
  close(datei);
  close(tmp_datei);
  erase(datei);
  rename(tmp_datei, datname);
end;
{/kontakt lîschen}

{kontakt suchen und bearbeiten}
procedure kontakt_bearbeiten(var datei: db_datei);
var c: integer;
begin
  kontakt_suchen(dateiname, datei, person, person1);
  c:= filepos(datei);
  reset(datei);
  seek(datei, c- 1);
  read(datei, person);
  kontakt_anzeigen(person);
  writeln('Ñndern sie die daten!');
  kontakt_neu(person);
  seek(datei, c- 1);
  write(datei, person);
end;
{/kontakt suchen und anzeigen}

{programm beenden}
procedure ende;
begin
clrscr;
layout;
standardtexte;
textcolor(lightred);
gotoxy(05,23); write('das programm wird beendet.');
repeat until keypressed;
end;
{/programm beenden}

{steuerungsmenÅ}
procedure menue(var datei: db_datei);
var taste: char;
begin
repeat
gotoxy(60,04); write('[1] datenbank zeigen');
gotoxy(60,06); write('[2] kontakt: neu');
gotoxy(60,08); write('[3] kontakt: edit');
gotoxy(60,10); write('[4] kontakt: suchen');
gotoxy(60,12); write('[5] kontakt: lîschen');
gotoxy(60,15); write('[7] datenbank: neu');
gotoxy(60,23); write('[0] programm beenden');

  repeat taste:= readkey until taste in ['1', '2', '3', '4', '5', '7', '0'];
    case taste of
    '1': datenbank_anzeigen(dateiname, datei);
    '2': kontakt_hinzufuegen(datei, dateiname);
    '3': kontakt_bearbeiten(datei);
    '4': kontakt_suchen(dateiname, datei, person, person1);
    '5': kontakt_loeschen(dateiname, datei);
    '7': kontakt_neu(person);
    '0': ende;
    end;
  until taste= '0';
end;
{/programmsteuerung}

{hauptprogramm}
begin
  dateiname:= 'contacts.dat';
  clrscr;
  textbackground(black);
  layout;
  standardtexte;
  menue(datei_g);
  repeat until keypressed;
end.
{/hauptprogramm}