program demo_procedure;     {hans@lugg.de 30.08.99}
uses crt;
var x,y:real;

procedure wertetausch (var a,b:real);  {procedure wertetausch}
var speicher:real;                     {lokale variable}
begin
     speicher:=a;
     a:=b;
     b:=speicher;
end;

procedure eingabe;
begin
     clrscr;
            writeln('x=');             {user input}
            readln(x);
            writeln('y=');
            readln(y);
end;

procedure ausgabe;
begin
           writeln('x=',x:6:2);        {outout auf dem Bildschirm}
           writeln('y=',y:6:2);
           repeat until keypressed;
end;

begin                                  {hauptprogramm}
     wertetausch(x,y);                 {aufruf der procedure wertetausch}
     eingabe;
     ausgabe;

end.

