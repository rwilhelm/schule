Program Primzahlsieb;
Uses crt;
Const Max = 31582;
Var Sieb: Array[1..Max] of Boolean;
    y,z,k:Integer;

Function Pruefung(Zahl:Integer):Boolean;
  Begin
    y := trunc (sqrt(Zahl));
    Pruefung := true;
    Repeat z := Zahl mod y;
           If z = 0 then Pruefung := false;
           y := y - 1;
    until (z = 0) or (y = 1);
  End;

Procedure Sieb_fuellen;
  Begin
    For K := 1 to Max do Sieb[K] := false;
    For K := 1 to Max do if Pruefung(K) = true then Sieb[K] := true;
  End;

Procedure Sieb_anzeigen;
  Begin
    textbackground (black); textcolor (red);
    Sieb_fuellen;
    For K := 1 to Max do If Sieb[K] = true then begin writeln(K,' frags'); delay(0); sound (k); end;
    nosound;
  End;

Begin
  clrscr;
  Sieb_anzeigen;
  Repeat until keypressed;
End.