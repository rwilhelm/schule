program cdrecord; {written by 2rok}
uses crt;
const maxzahl= 5;
     type tcd= record
           nr: integer;
        titel: string[80];
    interpret: string;
musikrichtung: string[20];
  beurteilung: byte;
  ausgeliehen: boolean;
    ausleiher: string[40];
          end; {record}

var        cd: tcd;
        datei: file of tcd; {typisierte datei}


procedure cds_record;
var taste: char;
BEGIN
  with cd do
    begin
      write ('cd-nr.:        '); readln (nr);
      write ('cd-titel:      '); readln (titel);
      write ('interpret:     '); readln (interpret);
      write ('musikrichtung: '); readln (musikrichtung);
      write ('beurteilung:   '); readln (beurteilung);

      writeln ('ausgeliehen? (j/n) ');
      taste := readkey;

      if taste = 'j' then ausgeliehen := true
                     else ausgeliehen := false;
      if taste = 'j' then begin
                            write ('ausleiher: ');
                            readln (ausleiher);
                          end
                     else ausleiher := 'k.a.';

    end; {with}
END; {cds_record}

procedure cds_save;
BEGIN
  assign  (datei, 'a:\cds.dat');
  rewrite (datei);
  write   (datei, cd);
  close   (datei);
END; {cd_save}

BEGIN {main}
  clrscr;
    writeln ('cd-informationen eingeben...');
      cds_record;
      cds_save;
END. {main}