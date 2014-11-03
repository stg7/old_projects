DIM SHARED a(1 TO 30,1 TO 30) AS BYTE
LOCATE , , 0

SUB feld_setzen(eingabe AS string,dd%,feld()AS BYTE)
  h%=LEN$(eingabe)
  FOR i%=1 TO h%
      feld(dd%,i%)=VAL(MID$(eingabe,i%,1))
  NEXT i%    
END SUB    

SUB LOAD_level(DATEI AS STRING)
    REM   0: farbe:=0;    {.. Schwarz  ..}
    REM   1: farbe:=14;   {..  Gelb    ..}
    REM   2: farbe:=9;    {.. hellblau ..}
    REM   3: farbe:=6 ;   {..  braun   ..}
    REM   4: farbe:=2 ;   {..   grn   ..}
    REM   5: farbe:=1 ;   {..  blau    ..}
    REM   6: farbe:=7;    {.. hellgrau ..}
    REM   7: farbe:=8;    {..dunkelgrau..}
    REM   8: farbe:=15;   {..  weiß    ..}
    REM   9: farbe:=4     {..   rot    ..}
    hh=FREEFILE
    'PRINT DATEI
    REM Grafik-Datei wird Zeilenweise eingelesen und in FELD a geschrieben
    OPEN DATEI FOR INPUT AS hh
    i%=0
    DO UNTIL EOF(1)
     i%=i%+1
     LINE INPUT #hh, inhalt$
     'PRINT inhalt$
     feld_setzen(inhalt$,i%,a())
    LOOP 
    CLOSE hh
END SUB           


ende%=18
SCREEN 0



SUB feld_zeichnen
 LOCATE 1,1
 ?
 ?
 LOCATE CSRLIN,9 
 FOR i%=1 TO 32 
  COLOR 10,0
  PRINT chr$(219);
 NEXT i%    
 ?
 FOR i%=1 TO 30   
  LOCATE CSRLIN,9    'Für Spielfeldverschiebung
  COLOR 10,0
  PRINT chr$(219);
  FOR m%=1 TO 30 
    IF a(i%,m%)=0 THEN COLOR 0,0
    IF a(i%,m%)=1 THEN COLOR 14,0 
    IF a(i%,m%)=2 THEN COLOR 9,0
    IF a(i%,m%)=3 THEN COLOR 6,0
    IF a(i%,m%)=4 THEN COLOR 2,0
    IF a(i%,m%)=5 THEN COLOR 1,0
    IF a(i%,m%)=6 THEN COLOR 7,0
    IF a(i%,m%)=7 THEN COLOR 8,0
    IF a(i%,m%)=8 THEN COLOR 15,0
    IF a(i%,m%)=9 THEN COLOR 4,0
    PRINT CHR$(219);  
  NEXT m%
  COLOR 10,0
  PRINT CHR$(219)
 NEXT i%
 LOCATE CSRLIN,9 
 FOR i%=1 TO 32 
  COLOR 10,0
  PRINT chr$(219);
 NEXT i% 
END SUB   
wert%=0
cls
SCREEN 18
WIDTH 80, 60
Color 10,0
INPUT "Eine bereits vorhandene Grafik laden?(j/n)",frage$
IF Ucase$(frage$)="J" THEN 
    INPUT "Grafikname: (mit .dat) ",namee$
    LOAD_LEVEL(namee$)
END IF    
LOCATE 59,2:PRINT "GRAFIK-EDITOR fuer STG-GAME"
    REM   0: farbe:=0;    {.. Schwarz  ..}
    REM   1: farbe:=14;   {..  Gelb    ..}
    REM   2: farbe:=9;    {.. hellblau ..}
    REM   3: farbe:=6 ;   {..  braun   ..}
    REM   4: farbe:=2 ;   {..   grn   ..}
    REM   5: farbe:=1 ;   {..  blau    ..}
    REM   6: farbe:=7;    {.. hellgrau ..}
    REM   7: farbe:=8;    {..dunkelgrau..}
    REM   8: farbe:=15;   {..  weiß    ..}
    REM   9: farbe:=4     {..   rot    ..}

LOCATE 3,43:COLOR 10,0:PRINT "MIT (ESC) beenden"

COLOR 10,0
LOCATE 5,43:PRINT "(0) {.. Schwarz  ..}  ";
COLOR 0,0:PRINT chr$(219)

COLOR 14,0 
LOCATE 6,43:PRINT "(1) {..  Gelb    ..}";
PRINT chr$(219)

COLOR 9,0:
LOCATE 7,43:PRINT "(2) {.. hellblau ..}";
PRINT chr$(219)

COLOR 6,0
LOCATE 8,43:PRINT "(3) {..  braun   ..}";
PRINT chr$(219)

COLOR 2,0
LOCATE 9,43:PRINT "(4) {..   grn   ..}";
PRINT chr$(219)

COLOR 1,0
LOCATE 10,43:PRINT"(5) {..  blau    ..}";
PRINT chr$(219)

COLOR 7,0
LOCATE 11,43:PRINT"(6) {.. hellgrau ..}";
PRINT chr$(219)

COLOR 8,0
LOCATE 12,43:PRINT"(7) {..dunkelgrau..}";
PRINT chr$(219)

COLOR 15,0
LOCATE 13,43:PRINT"(8) {..  weiss   ..}";
PRINT chr$(219)

COLOR 4,0
LOCATE 14,43:PRINT"(9) {..   rot    ..}";
PRINT chr$(219)

DO UNTIL eingabe$=chr$(27)
 eingabe$=inkey$ 
 feld_zeichnen
 IF eingabe$="0" then wert%=0
 IF eingabe$="1" then wert%=1
 IF eingabe$="2" then wert%=2
 IF eingabe$="3" then wert%=3
 IF eingabe$="4" then wert%=4
 IF eingabe$="5" then wert%=5
 IF eingabe$="6" then wert%=6
 IF eingabe$="7" then wert%=7
 IF eingabe$="8" then wert%=8
 IF eingabe$="9" then wert%=9
 GETMOUSE x%,y%,,button%
 COLOR 10,0
 LOCATE 2,50:PRINT USING "####,####"; x%,y%
 IF NOT ((x%=-1) OR (y%=-1)) THEN 
  IF button% AND 1 THEN 
     IF x%>72 AND y%>24 THEN 
      i%=x%\8 
      u%=y%\8 
      a(u%-2,i%-8)=wert%
     END IF
  END IF    
 END IF 
 LOCATE 4,43: PRINT wert%;" = momentane Auswahl"
 Sleep 10
LOOP   
LOCATE 50,2
COLOR 10,0
IF NOT(UCASE$(FRAGE$)="J") THEN
 INPUT "Levelname eingeben (kein Name fuer nicht speichern)(+.dat) ";level_name$
ELSE 
    level_name$=namee$
END IF    
IF NOT level_name$="" THEN
 hh=FREEFILE
 OPEN level_name$ FOR OUTPUT AS hh
 FOR i%=1 TO 30
  FOR k%=1 TO 30
      PRINT #hh,USING "#"; a(i%,k%);
  NEXT k%
  PRINT #hh,
 NEXT i%  
 CLOSE hh
ENDIF 

