{ aufgabe: selbst definierte pascal-funktion soll prfen, ob eine          }
{          einzugebende zahl eine primzahl ist.                            }
{                                                                          }
{ primzahl: hat nur zwei teiler: sich selbst und die 1                     }
{                                                                          }
{ operator: mod  ->  liefert den ganzzahligen divisionsrest                }
{           div  ->  wie oft eine zahl ganzzahlig in eine andere reinpasst }
{                                                                          }
{           x := 29 mod 5                                                  }
{                                                                          }
{           sqrt (x)  ->  liefert die quadratwurzel von x                  }
{                                                                          }
{           x := trunc (y)                                                 }
{                                                                          }
{ by [cia] 2rok - freitag der 03.12.1999 - 08:03:43 mez                    }

program primzahl;
uses crt;
var zahl: integer;

   function primcheck(x: integer): boolean;
   var probeteiler, divisionsrest: integer;

   begin
         primcheck := true;

         if zahl = 1 then primcheck := false;

         if x <> 2 then
                        if x mod 2 = 0 then primcheck := false;

          probeteiler := 3;
          repeat
            divisionsrest := x mod probeteiler;
            if divisionsrest = 0 then primcheck := false;
            probeteiler := probeteiler + 2;
          until (divisionsrest = 0) or (probeteiler < x)
   end;

begin
  clrscr;
    write ('gib ne zahl ein, von der du wissen willst ob sie eine primzahl ist: ');
    readln (zahl);

    if primcheck (zahl) then write ('die zahl ist eine primzahl')
                        else write ('die zahl ist keine primzahl');

  repeat until keypressed;
end.