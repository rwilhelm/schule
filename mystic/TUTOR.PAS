{ mystic pascal  tutorial PROGRAM }

PROGRAM tutor;

CONST
lessoncount = 8;
pi = 3.14159;

TYPE
registers = RECORD
        al,ah,bl,bh,cl,ch,dl,dh : char;
        bp,si,di,ds,es,flags : integer
        END;

VAR
i, j, lesson : integer;
a, b, c : real;
regs : registers;
seconds : integer;
f : text;



PROCEDURE cls;
BEGIN
write( chr(4) )
END;

PROCEDURE ten;
VAR
i : integer;
BEGIN
FOR i := 1 TO 10 DO
        write(i);
writeln
END;

PROCEDURE bar ( count : integer );
VAR
i : integer;
BEGIN
WHILE count >= 10 DO
        BEGIN
        write('----------');
        count := count - 10
        END;
FOR i := 1 TO count DO
        write('-');
writeln;
END;

FUNCTION area ( radius : real ): real;
BEGIN
area := pi * sqr(radius)
END;

PROCEDURE break;
BEGIN
regs.cl := chr(0);
intr(226,regs)
END;

PROCEDURE timer;
LABEL 10, 99;
VAR
lastvalue : char;
BEGIN
lastvalue := chr(255);
10:
break;
IF (seconds <= 0) OR (seconds >= 60) THEN
        BEGIN
        writeln;
        writeln('Timer is terminating.');
        write('\ ');
        GOTO 99
        END;
regs.ah := chr(44);
intr(33,regs);
WITH regs DO
   IF ((ord(dh) MOD seconds) = 0) AND (dh <> lastvalue) THEN
        BEGIN
        lastvalue := dh;
        ah := chr(2);
        dl := chr(7);      {sound a tone}
        intr(33,regs)
        END;
GOTO 10;
99:
END;

PROCEDURE squares;
VAR
i : integer;
BEGIN
rewrite(f);
writeln(f,'SQUARES TABLE  1 TO 50');
writeln(f);
FOR i := 1 TO 50 DO
        BEGIN
        write(f,i:3,sqr(i),'    ');
        IF (i MOD 5) = 0 THEN writeln(f)
        END;
close(f)
END;


PROCEDURE menu;
BEGIN
writeln('------------------------ Lessons -------------------------');
writeln('1  Introduction               5  Procedure Calls');
writeln('2  Direct Mode                6  Floating Point ',
        'Arithmetic');
writeln('3  Assignments & Writeln      7  Multi-tasking');
writeln('4  Dot Write Command          8  Printer & Disk Output');
writeln;
writeln('--------- Commands ----------');
writeln('L(x)   select a lesson number');
writeln('NEXT   go to the next lesson');
writeln('AGAIN  redisplay last lesson');
writeln('CLS    clear the screen');
writeln
END;

PROCEDURE l1;
BEGIN
writeln('Lesson 1  Introduction');
writeln;
writeln('Mystic Pascal is a complete programming system with a full');
writeln('screen editor, incremental compiler and multi-tasking');
writeln('operating system which runs on top of DOS.');
writeln;
writeln('This tutorial program will introduce you to the operation');
writeln('of Mystic Pascal.  It will not teach you the Pascal');
writeln('language.');
writeln;
writeln('Mystic Pascal Advanced Features');
writeln('------ ------ -------- --------');
writeln('1. Ultra-fast new compiler design');
writeln('2. Supports full 640K of storage');
writeln('3. Interactive Direct Mode');
writeln('4. Multi-tasking support');
writeln('5. Full screen editor talks to compiler');
writeln('6. Help windows - F7, F9, F10');
writeln;
END;

PROCEDURE l2;
BEGIN
writeln('Lesson 2  Direct Mode');
writeln;
writeln('In the Direct Mode screen you can key in any Pascal');
writeln('statement to be instantly executed.  The statement is');
writeln('compiled by the incremental compiler and then it is');
writeln('executed.  If it produced any output, this is displayed');
writeln('on the screen.');
writeln;
writeln('The Direct Mode of Mystic Pascal works like a Basic');
writeln('interpreter, but it is a TRUE COMPILER.');
writeln;
writeln('In Direct Mode you have access to all global variables,');
writeln('procedures and functions.  Objects which are declared');
writeln('locally within a procedure or function are not accessible.');
END;

PROCEDURE l3;
BEGIN
writeln('Lesson 3  Assignments & Writeln');
writeln;
writeln('Note that I, J are global Integer variables.');
writeln;
writeln('Key in the following statements, following the \ prompt:');
writeln;
writeln('I := 75; WRITELN(I)');
writeln;
writeln('J := 100; WRITELN( I, J, I * J )');
END;

PROCEDURE l4;
BEGIN
writeln('Lesson 4  Dot Write Command');
writeln;
writeln('Very often when working in Direct Mode, you will need');
writeln('to display the value of some variables.  You may do this');
writeln('with a Write or Writeln.  Mystic Pascal also provides a');
writeln('short-cut.  The Dot Write Command allows you to display');
writeln('one or more expressions, by just preceding them with a');
writeln('period.');
writeln;
writeln('.I    is equivalent to    WRITE(I)');
writeln('.5 * 20, 30 div 3     will display    100    10');
writeln;
writeln('The period must be the first character on the line and no');
writeln('other Pascal statements may follow on that line.');
writeln;
writeln('Try this command now by displaying variables I and J.');
END;

PROCEDURE l5;
BEGIN
writeln('Lesson 5  Procedure Calls');
writeln;
writeln('All Pascal programs are subdivided into subprograms');
writeln('called procedures.  Each procedure performs some logical');
writeln('purpose and should have a meaningful name.  To activate');
writeln('a procedure, you just give its name.  This Tutor program');
writeln('includes a procedure named TEN which simply displays the');
writeln('numbers 1 through 10.  Type TEN now to activate it.');
writeln;
writeln('Procedures may also have parameter values passed to them.');
writeln('The sample procedure BAR displays a line of dashes.  It');
writeln('needs one parameter to indicate the number of dashes to');
writeln('display.  Try it now by typing  BAR(25).');
END;

PROCEDURE l6;
BEGIN
writeln('Lesson 6  Floating Point Arithmetic');
writeln;
writeln('The Tutor program has 3 global Real variables A, B, C.');
writeln('You may experiment with floating point arithmetic using');
writeln('these variables.');
writeln;
writeln('A := 45.3;  B := 2E-2');
writeln('.A, B, A * B');
writeln('.A + B:20:4      fixed-point output');
writeln('.A >= B          comparison');
writeln;
writeln('There is also a Real function named AREA which computes');
writeln('the area of a circle given its radius.  The parameter');
writeln('must be a real number.');
writeln;
writeln('.AREA( 10.0 )');
writeln('A := 50.0;   WRITELN( AREA(A) )');
END;

PROCEDURE l7;
BEGIN
writeln('Lesson 7  Multi-tasking');
writeln;
writeln('The Mystic Pascal system is based on multi-tasking.');
writeln('Your Pascal programs may have up to 100 procedures running');
writeln('at the same time - Concurrent Procedures.  This capability');
writeln('is useful for doing simulations and for real-time');
writeln('programming, such as controlling an assembly line.');
writeln;
writeln('The Timer procedure in this Tutor program illustrates the');
writeln('multi-tasking feature.  Timer constantly watches the PC');
writeln('system clock and sounds a tone every few seconds.');
writeln('You can determine the time interval between tones by');
writeln('setting the integer variable SECONDS.');
writeln;
writeln('To start up Timer enter:');
writeln;
writeln('SECONDS := 10;  START( TIMER, ''TIMER'', 10)');
writeln;
writeln('Examine the System Display screen to see the Timer process');
writeln('in the PCB table.  To change the interval, just store a new');
writeln('number in SECONDS.  To stop Timer, set SECONDS to 0.');
END;

PROCEDURE l8;
BEGIN
writeln('Lesson 8  Printer & Disk Output');
writeln;
writeln('The Assign procedure lets you fully control the routing');
writeln('of output to the console, printer or a disk file.  The');
writeln('Tutor program contains a procedure named SQUARES which');
writeln('prints the squares of the numbers 1 to 50.  This report may');
writeln('be routed to the console, printer or disk by Assign.');
writeln('SQUARES sends its output to the text file variable F.');
writeln;
writeln('To route the report to the printer, type:');
writeln('    ASSIGN( F, PRN );  SQUARES');
writeln;
writeln('To route it to a disk file, type:');
writeln('    ASSIGN( F, ''SQ.TAB'' );  SQUARES');
writeln;
writeln('To route it to the console:');
writeln('    ASSIGN( F, CON );  SQUARES');
END;


PROCEDURE l ( les : integer );
BEGIN
IF (les < 1) OR (les > lessoncount) THEN les := 1;
lesson := les;
cls;
CASE les OF
1 : l1;
2 : l2;
3 : l3;
4 : l4;
5 : l5;
6 : l6;
7 : l7;
8 : l8
END
END;    {l}

PROCEDURE next;
BEGIN
lesson := lesson + 1;
l(lesson)
END;

PROCEDURE again;
BEGIN
l(lesson)
END;

BEGIN           {main PROGRAM - tutor}
lesson := 0;
a := 0;
b := 0;
c := 0;
assign(f,con);
cls;
writeln('Mystic Pascal Tutor Program');
writeln;
writeln('This is an introduction to the operation of Mystic Pascal.');
writeln('This program contains',lessoncount:3,' lessons.');
writeln;
writeln('For a list of Lessons and Commands, type MENU.');
writeln;
menu;
END.            {main PROGRAM}
