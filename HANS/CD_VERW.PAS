program record_demo1;	 { 17.09.99 Daniel Christophis }
uses crt;
const maxzahl =5;
type       tcd = record
		  nr: integer;
		  titel: string[80];
		  interpret: string;
		  musikrichtung: string[20];
		  beurteilung: byte;
		  ausgeliehen: boolean;
                  ausleiher: string[40];
	        end;   { record }

 var  CD : tcd;
      datei:file of tcd; {typisierte datei}


procedure cds_aufnehmen;
var taste : char;
begin
        clrscr;
        WITH CD DO
             BEGIN
	          write('CD Nr.: ');	  readln(nr);
	          write('CD-Titel: ');	  readln(titel);
                  write('Interpret: ');    readln(interpret);
                  write('Musikrichtung: '); readln(musikrichtung);
                  write('Beurteilung: ');  readln(beurteilung);

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


end;  { procedure }



procedure erste_cd_speichern;
begin
	assign(datei, 'a:cds.dat');
	rewrite(Datei);
	write(datei,cd);
	close(datei);	
end;

begin   { main }
	cds_aufnehmen;
	erste_Cd_speichern;
end.