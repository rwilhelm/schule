program cdstore;

uses crt;
const maxzahl=   5;
type  tcd=       record
      nr:        integer;
      titel:     string[80];
      interpret: string[80];
      genre:     string[20];
      wertung:   byte;
      verliehen: boolean;
      ausleiher: string[40];
      end;

var cd:    tcd;
    datei: file of tcd; {typisierte datei}

{----------screen-------------------------------------------------------------}
procedure screen;
var h: byte;
var v: byte;
begin

 textcolor (lightgreen);

 for h:= 02 to 79 do
  begin
  gotoxy (h,01); write (chr (0205)); {Í}
  end;

 for h:= 02 to 79 do
  begin
  gotoxy (h,03); write (chr (0205)); {Í}
  end;

 for h:= 02 to 79 do
  begin
  gotoxy (h,24); write (chr (0205)); {Í}
  end;

 for h:= 66 to 79 do
  begin
  gotoxy (h,25); write (chr (0205)); {Í}
  end;

 for v:= 02 to 22 do
  begin
  gotoxy (01,v); write (chr (0186)); {º}
  end;

 for v:= 02 to 24 do
  begin
  gotoxy (65,v); write (chr (0186)); {º}
  end;

 for v:= 02 to 25 do
  begin
  gotoxy (80,v); write (chr (0186)); {º}
  end;

 gotoxy (01,01); write (chr (0201)); {É}
 gotoxy (65,01); write (chr (0203)); {Ë}
 gotoxy (80,01); write (chr (0187)); {»}

 gotoxy (01,03); write (chr (0204)); {Ì}
 gotoxy (65,03); write (chr (0206)); {Î}
 gotoxy (80,03); write (chr (0185)); {¹}

 gotoxy (01,23); write (chr (0200)); {È}
 gotoxy (65,23); write (chr (0206)); {Î}
 gotoxy (80,23); write (chr (0185)); {¹}

 gotoxy (65,25); write (chr (0202)); {Ê}
 gotoxy (80,25); write (chr (0188)); {¼}

end;
{----------main--------------------------------------------------------------}
begin
  clrscr;
  screen;
  repeat until keypressed;
end.
