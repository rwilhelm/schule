program record_dm1;
uses crt;
const maxzahl= 1;
type tcd= record
          id: integer;
          titel: string[80];
          interpret: string[80];
          genre: string[20];
          wertung: byte;
          ausgeliehen: string[1];
          an: string[80];
          end; {record}

var    cd: tcd;
    datei: file of tcd; {typisierte datei}

procedure cdaufnehmen;
begin
     with cd do
       begin
        textcolor(red);
        writeln('gib jetz die informationen zu deiner cd ein..');
        textcolor(yellow);
        writeln('und leg ne diskette ein! sonst setzts was!');
        repeat until keypressed;
        textcolor(blue);
          write('id:          ');          readln(id);
          write('titel:       ');       readln(titel);
          write('interpret:   ');   readln(interpret);
          write('genre:       ');       readln(genre);
          write('wertung:     ');     readln(wertung);
          write('ausgeliehen: '); readln(ausgeliehen);
        repeat until keypressed;
        textcolor(green);
        write('DANKE FšR FšR DIE MšHE!');
       end; {with}
end;

procedure cdspeichern;
begin
     assign(datei, 'a:\cds.dat');
     rewrite(datei);
     write(datei, cd);
     close(datei);
end;

begin
  clrscr;
   textbackground(white);
   textcolor(black); writeln('DAS ULTIMATIVE CD-INFORMATIONS-SPEICHER-PROGRAMM!');
     cdaufnehmen;
     cdspeichern;
end.
