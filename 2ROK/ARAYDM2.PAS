program array_dm2;
uses crt, printer;
var k: integer;
    zahl: array[1..10] of real;
    summe: real;
    datei: text;

procedure messwerteingabe;
var k: integer;
 begin
 clrscr;
  textcolor (blue); writeln ('gib zehn reellen zahlen ein');
  textcolor (white); for k:=1 to 10 do
   begin
    write ('zahl eingeben: ');
    readln (k);
   end;
 end; {messwerteingabe}

procedure auswertung;
 begin
  summe:=0;
  for k:=1 to 10 do summe:=summe+zahl[k];
 textcolor (yellow); writeln ('alles zusammen: ',summe:10:2);
 end; {auswertung}

procedure speichern;
 begin
  assign (datei, 'c:\tp\2rok\tabelle.txt');
  rewrite (datei);
  for k:=1 to 10 do write (datei, zahl[k]);
  close (datei);
  writeln ('die zahlen wurden in in tabelle.txt unter -c:\tp\2rok\- gespeichert');
  end; {speichern}

procedure drucken;
 begin
  assign (datei, 'c:\tp\2rok\tabelle.txt');
  rewrite (datei);
  for k:=1 to 10 do write (lst, zahl[k]);
  close (datei);
  writeln ('wird gedruckt');
  end; {drucken}

procedure programmende;
 begin
 end;

procedure menue;
var taste: char;
 begin
 clrscr;
  textcolor (blue); writeln ('prog zum erfassen, auswerten und speichern von messwerten');

   gotoxy (10,5);  textcolor (white); write ('messwerte erfassen .............. -1-');
   gotoxy (10,6);  write ('auswerten ....................... -2-');
   gotoxy (10,7);  write ('speichern ....................... -3-');
   gotoxy (10,8);  write ('drucken ......................... -4-');
   gotoxy (10,9);  textcolor (red);   write ('programm beenden ................ -5-');
   gotoxy (10,11); textcolor (green); write ('mach schon ...................... = =');
   gotoxy (45,11); textcolor (white);

    repeat taste:=readkey until taste in ['1','2','3','4'];
     case taste of
     '1': messwerteingabe;
     '2': auswertung;
     '3': speichern;
     '4': drucken;
     '5': programmende;
     end; {case}
 end; {menu}

BEGIN
 menue;
END.