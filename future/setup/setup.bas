
DECLARE SUB ausgabe_menu(menu$(),auswahl%)
DECLARE SUB Installation( Verzeichnis AS STRING,  STANDARD_VERZ AS STRING, name_ AS STRING)
DECLARE SUB Verzeichnis_(byref Verzeichnis AS STRING)
DECLARE SUB Info()
DECLARE SUB EINLESEN(NAME_ AS STRING, STANDARD_VERZ AS STRING, COPY AS STRING)

' Lokale Subs
SUB EINLESEN( NAME_ AS STRING, STANDARD_VERZ AS STRING, COPY AS STRING)
 hh=FREEFILE   
 OPEN "SETUP.INI" FOR INPUT AS hh
 DO UNTIL EOF(1)
  LINE INPUT #hh, inhalt$
  IF LEFT$(inhalt$, INSTR (inhalt$,"="))="[NAME]     =" THEN 
    NAME_ = MID$(inhalt$, INSTR (inhalt$,"=")+1)  
  END IF    
  IF LEFT$(inhalt$, INSTR (inhalt$,"="))="[DIR2SETUP]=" THEN 
    StandarD_VERZ = MID$(inhalt$, INSTR (inhalt$,"=")+2)  
  END IF   
  IF LEFT$(inhalt$, INSTR (inhalt$,"="))="[COPYRIGHT]=" THEN 
    COPY = MID$(inhalt$, INSTR (inhalt$,"=")+1)  
  END IF 
 LOOP    
END SUB    
SUB INSTALL(STANDARD_VERZ AS STRING ,NAME_ AS STRING)
 DIM auswahl AS integer
 DIM eingabe AS string
 CLS
 LOCATE 10,0
 auswahl=1
 PRINT "   Soll ";NAME_;" nach ";Standard_verz;" installiert werden ?"
 DO
  LOCATE 12,20   
  eingabe=inkey$
  IF eingabe=chr$(255)+chr$(75) THEN auswahl=1
  IF eingabe=chr$(255)+chr$(77) THEN auswahl=2
  IF auswahl=1 THEN COLOR 0,10 ELSE COLOR 10,0
  PRINT "  JA   ";
  IF auswahl=2 THEN COLOR 0,10 ELSE COLOR 10,0
  PRINT "  NEIN "
 LOOP UNTIL eingabe=chr$(13)  
 COLOR 10,0
 IF auswahl=2 THEN
  INPUT "   Verzeichnis eingeben:(z.b C:\TEST\) "; VERZEICHNIS$
  STANDARD_verz=VERZEICHNIS$
 END IF
 CLS
 LOCATE 10,0
 PRINT "   Installation wird durchgefuehrt"
 PRINT
 PRINT "   ";NAME_;" wird nach ";STANDARD_VERZ;" installiert."
 PRINT
 SHELL "7za x -o"+STANDARD_VERZ+" setup.dat>NUL" 
 PRINT "   READY"
 PRINT
 PRINT "   weiter mit ENTER"
 SLEEP

END SUB

DIM eingabe AS STRING
DIM auswahl AS INTEGER
DIM VERZeichnis AS STRING

DIM Name_ AS STRING
DIM STANDARD_VERZ AS STRING
DIM COPY AS STRING

SCREEN 0
CLS
LOCATE , , 0 'Cursor ausschalten
COLOR 10,0
EINLESEN(NAME_ , STANDARD_VERZ, COPY)
PRINT
PRINT "       Willkommen beim Installationsprogramm von ";NAME_
PRINT
PRINT "       COPYRIGHT ";COPY
PRINT
LOCATE 10,1
PRINT "       Moechten Sie ";NAME_; " installieren ?"
auswahl=1
DO
 LOCATE 12,20   
 eingabe=inkey$
 IF eingabe=chr$(255)+chr$(75) THEN auswahl=1
 IF eingabe=chr$(255)+chr$(77) THEN auswahl=2
 IF auswahl=1 THEN COLOR 0,10 ELSE COLOR 10,0
 PRINT "  JA   ";
 IF auswahl=2 THEN COLOR 0,10 ELSE COLOR 10,0
 PRINT "  NEIN ";
LOOP UNTIL eingabe=chr$(13)
IF auswahl=1 THEN INSTALL(STANDARD_VERZ,NAME_) 
