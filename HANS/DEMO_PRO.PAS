program Demo_Procedure;    {Daniel Christophis 30.08.99}
uses crt;
var x,y:real;
procedure Wertetausch(var a,b:real);
var speicher:real;
begin
   speicher:=a;
   a:=b;
   b:=speicher;
end;

begin
   clrscr;
   write('Ersten Wert eingeben:');
   readln(x);
   write('Zweiten Wert eingeben:');
   readln(y);
   Wertetausch(x,y);
   writeln('Die beiden Werte wurden vertauscht, der erste Wert betr„gt:',x:10:2);
   writeln('Der zweite Wert betr„gt:',y:10:2);
   readln;
end.