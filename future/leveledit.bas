DIM SHARED a(1 TO 9,1 TO 18) AS BYTE
LOCATE , , 0
SUB feld_setzen(eingabe AS string,dd%,feld()AS BYTE)
  h%=LEN$(eingabe)
  FOR i%=1 TO h%
      feld(dd%,i%)=VAL(MID$(eingabe,i%,1))
  NEXT i%    
END SUB    

SUB LOAD_level(DATEI AS STRING)
    REM 1 = Mauer
    REM 0 = Leer
    REM 2 = Spielfigur
    REM 3 = Punktefeld
    REM 4 = EXIT- TOR {im level.dat fiele}
    REM 5 = Kugel
    hh=FREEFILE
    PRINT DATEI
    REM Level-Datei wird Zeilenweise eingelesen und in FELD a geschrieben
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
feld_setzen("111111111111111111",1,a())
feld_setzen("100000000000000001",2,a())
feld_setzen("100000000000000001",3,a())
feld_setzen("100000000000000001",4,a())
feld_setzen("100000000000000001",5,a())
feld_setzen("100000000000000001",6,a())
feld_setzen("100000000000000001",7,a())
feld_setzen("100000000000000001",8,a())
feld_setzen("111111111111111111",9,a())


SUB feld_zeichnen
 LOCATE 1,1
 ?'Für Spielfeldverschiebung
 ?
 ?
 FOR i%=1 TO 9 
  PRINT "         ";   'Für Spielfeldverschiebung
  FOR m%=1 TO 18 
    IF a(i%,m%)=1 THEN COLOR 2,0 :PRINT chr$(219);
    IF a(i%,m%)=0 THEN COLOR 15,0:PRINT chr$(32);
    IF a(i%,m%)=3 THEN COLOR 14,0:PRINT chr$(206);
    IF a(i%,m%)=4 THEN COLOR 12,0:PRINT chr$(158);
    IF a(i%,m%)=5 THEN COLOR 8,0:PRINT "O";
    IF a(i%,m%)=2 THEN COLOR 10,0:PRINT chr$(2);
      
  NEXT m%
  PRINT
 NEXT i%
END SUB   
wert%=0
cls
INPUT "Ein bereits vorhandenes Level laden?(j/n)",frage$
IF Ucase$(frage$)="J" THEN 
    INPUT "Levelname: (mit .dat) ",namee$
    LOAD_LEVEL(namee$)
END IF    
PRINT "LEVEL-EDITOR fuer STG-GAME"
LOCATE 3,40:COLOR 10,0:PRINT "MIT (ESC) beenden"
LOCATE 5,40:PRINT "leeres Feld (0) ";
 COLOR 15,0:PRINT chr$(32)
LOCATE 6,40:PRINT "Mauer       (1) ";
 COLOR 2,0 :PRINT chr$(219)
LOCATE 7,40:PRINT "Spielfigur  (2) ";
 COLOR 10,0:PRINT chr$(2)
LOCATE 8,40:PRINT "Punktefeld  (3) ";
 COLOR 14,0:PRINT chr$(206)
LOCATE 9,40:PRINT "Exit Tor    (4) ";
 COLOR 12,0:PRINT chr$(158)
LOCATE 10,40:PRINT "Kugel       (5) ";
 COLOR 8,0:PRINT "O"
DO UNTIL eingabe$=chr$(27)
 eingabe$=inkey$ 
 feld_zeichnen
 REM 0 = Leer
 REM 1 = Mauer
 REM 2 = Spielfigur
 REM 3 = Punktefeld
 REM 4 = EXIT- TOR {im level.dat fiele}
 REM 5 = Kugel
 IF eingabe$="0" then wert%=0
 IF eingabe$="1" then wert%=1
 IF eingabe$="2" then wert%=2
 IF eingabe$="3" then wert%=3
 IF eingabe$="4" then wert%=4
 IF eingabe$="5" then wert%=5
 GETMOUSE x%,y%,,button%
 IF button% AND 1 THEN 
     IF wert%=2 OR wert%=4 THEN
       FOR i%=1 TO ende%/2
        FOR u%=1 TO ende% 
          IF wert%=2 AND a(i%,u%)=2 THEN a(i%,u%)=0
          IF wert%=4 AND a(i%,u%)=4 THEN a(i%,u%)=0
        NEXT u%
       NEXT i%   
     END IF
     a(y%-2,x%-8)=wert%
 END IF    
 Color 10,0
 SELECT CASE wert% 
  CASE 0: 
   LOCATE 22,10:PRINT "leeres Feld (0) ";
   COLOR 15,0:PRINT chr$(32)
  CASE 1: 
   LOCATE 22,10:PRINT "Mauer       (1) ";
   COLOR 2,0 :PRINT chr$(219)
  CASE 2: 
   LOCATE 22,10:PRINT "Spielfigur  (2) ";
   COLOR 10,0:PRINT chr$(2)
  CASE 3: 
   LOCATE 22,10:PRINT "Punktefeld  (3) ";
   COLOR 14,0:PRINT chr$(206)
  CASE 4: 
   LOCATE 22,10:PRINT "Exit Tor    (4) ";
   COLOR 12,0:PRINT chr$(158)
  CASE 5: 
   LOCATE 22,10:PRINT "Kugel       (5) ";
   COLOR 8,0:PRINT "O"
 END SELECT 
LOOP   
COLOR 10,0
IF NOT(UCASE$(FRAGE$)="J") THEN
 INPUT "Levelname eingeben (kein Name fuer nicht speichern)(+.dat) ";level_name$
ELSE 
    level_name$=namee$
END IF    
IF NOT level_name$="" THEN
 hh=FREEFILE
 OPEN level_name$ FOR OUTPUT AS hh
 FOR i%=1 TO 9
  FOR k%=1 TO 18
      PRINT #hh,USING "#"; a(i%,k%);
  NEXT k%
  PRINT #hh,
 NEXT i%  
 CLOSE hh
ENDIF 

