PROGRAM cdstore;        {24. oktober 1999}

uses crt;
CONST   maxzahl   = 5;
TYPE    tcd       = RECORD       {BEGIN: RECORD}
        nr        : integer;
        titel     : string[80];
        interpret : string[80];
        genre     : string[20];
        wertung   : byte;
        verliehen : boolean;
        ausleiher : string[40];
        END;                     {END: RECORD}

VAR     cd        : tcd;
        datei     : FILE OF tcd; {typisierte datei}


{----------------------------------------------------------------------------}

PROCEDURE balken (code: byte);   {BEGIN: balken}
VAR k : byte;
BEGIN
  FOR k := 1 TO 80 DO write (chr(code));
END;                             {END: balken}

{----------------------------------------------------------------------------}

PROCEDURE taste;                 {BEGIN: taste}
VAR k : integer;
BEGIN
  gotoxy (1,24);
  writeln ('irgendeine taste drueken um weiterzumachen...');
  REPEAT UNTIL keypressed;
END;                             {END: taste}

{----------------------------------------------------------------------------}

PROCEDURE mainscreen;            {BEGIN: mainscreen}
BEGIN
  textcolor      (lightgreen);
  textbackground (black);
  clrscr;
  gotoxy (1,1);  writeln ('AUDIO-CD-ARCHIVIERUNGS-PROG by [cia] 2rok');
  gotoxy (1,2);  balken (176);
  gotoxy (1,23); balken (176);
  gotoxy (1,24);
END;                             {END: mainscreen}

{----------------------------------------------------------------------------}

PROCEDURE cd_ausgabe (VAR eintrag : tcd); {BEGIN: cd_ausgabe}
BEGIN
  WITH eintrag DO
    BEGIN
      gotoxy (10,10); write ('cd #     :              ', nr);
      gotoxy (10,12); write ('titel    :              ', titel);
      gotoxy (10,14); write ('interpret:              ', interpret);
      gotoxy (10,16); write ('genre    :              ', genre);
      gotoxy (10,18); write ('wertung  :              ', wertung);
      gotoxy (10,20); write ('ausleiher:              ', ausleiher);
    END;  {WITH}
END;                                     {END: cd_ausgabe}
{----------------------------------------------------------------------------}

PROCEDURE cd_eingabe;                    {BEGIN: cd_eingabe}
var taste: char;
begin
  assign (datei, 'a:\cdstore.dat');
  rewrite (datei);

    repeat mainscreen;
    gotoxy (10,2);   write ('0 als cd-nummer beendet die eingabe');

  with cd do
    begin
      gotoxy (1,10);
      write ('cd nr.:'); readln (nr);

      if nr<>0 then
        begin
          write ('titel: ');          readln(titel);
          write ('interpret: ');      readln(interpret);
          write ('genre: ');          readln(genre);
          write ('wertung: ');        readln(wertung);
          write ('verliehen (j/n) ');
          taste:= readkey;

          taste:=  upcase(taste);
          if taste= 'j' then verliehen:= true
                        else verliehen:= false;
          if taste= 'j' then
            begin
              writeln ('ausleiher:');
              readln (ausleiher);
            end
          else ausleiher:= 'n/a';

        end; {with}

        write (datei, cd);

    end; {if}

  until cd.nr=0;
  close(datei);

end;                                       {procedure cd_eingabe}

{----------------------------------------------------------------------------}

PROCEDURE cds_anzeigen;
begin
  assign (datei, 'a:cds.dat');
  reset(datei); { ”ffnen zum lesen }
  repeat
    clrscr;
    read (datei, cd); { lesen eines kompletten records }
    with cd do
      begin
        gotoxy(10,10);    write('cd nr.:                ', nr);
        gotoxy(10,12);    write('cd-titel:              ', titel);
        gotoxy(10,14);    write('interpret:             ', interpret);
        gotoxy(10,16);    write('genre:                 ', genre);
        gotoxy(10,18);    write('wertung (1 bis 6):     ', wertung);
        gotoxy(10,20);    write('ausleiher:             ', ausleiher);
        taste;
        repeat until keypressed;
      end; {with}
  until eof (datei);
  close (datei);
end;

{----------------------------------------------------------------------------}

PROCEDURE suche_titel;
var ges_titel: string[80];
begin
  mainscreen;
  gotoxy (20,02);  writeln ('suche nach einer CD, deren Titel angegeben ist..');
  gotoxy (10,10); write ('geben Sie den gesuchten Titel ein (max. 8 Zeichen): ');
                  readln (ges_titel);
  assign (datei, 'a:\cds.dat');
  reset (datei);
  repeat
    read (datei, cd);
  until (ges_titel=cd.titel) or (eof (datei));

  if eof (datei) then begin
    gotoxy (10,10); write ('cd-titel in der sammlung nicht enthalten oder der');
    gotoxy (10,12); write ('cd-titel wurde falsch eingetippt!');
  end


  else begin
     gotoxy (10,10); write ('                                              ');
     gotoxy (10,12); write ('                                              ');
    cd_ausgabe (cd);
       end;
  close (datei);
 taste;

end; {titelsuche}

{----------------------------------------------------------------------------}

PROCEDURE programmende;
begin
  taste;
end;

{----------------------------------------------------------------------------}

PROCEDURE menue;
var taste: char;
begin
  repeat { „uáere schleife }
  mainscreen;
    gotoxy(01,03); write('programm zum anlegen und verwalten einer cd-sammlung');
    gotoxy(10,05); write('cd´s hinzufuegen..........1');
    gotoxy(10,07); write('cd´s anzeigen.............2');
    gotoxy(10,09); write('cd´s loeschen.............3');
    gotoxy(10,11); write('cd´s korrigieren..........4');
    gotoxy(10,13); write('cd´s suchen...............5');
    gotoxy(10,15); write('cd-sammlung importieren...6');
    gotoxy(10,17); write('programm beenden..........7');
    gotoxy(10,24); write('.......................... ');
  repeat taste:= readkey until taste in ['1','2','3','4','5','6','7'];

  mainscreen;
  case taste of
                '1':cd_eingabe;
                '2':cd_ausgabe;
              { '3':
                '4': }
                '5':suchen_titel;
              { '6':}
                '7':programmende;
            end; {case}
            until taste = '7';   {„uáere schleife}

end;

{----------------------------------------------------------------------------}

begin   { main }

        menue;
end.
