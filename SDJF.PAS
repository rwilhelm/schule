program beeper;
uses crt;
var k: longint;
begin
clrscr;
repeat
for k := 1 to 1000 do sound (k);
until keypressed;
nosound;
end.