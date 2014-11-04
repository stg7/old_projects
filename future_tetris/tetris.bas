' TETRIS TEST GAME
' Programmierer: Steve Göring
' 2006-2007
' letzte Änderung:10.02.07
' Grafikinterface: OPENGL
#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "createtex.bi"
#include once "text.inc"

TYPE KOORDINATE
  x AS BYTE
  y AS BYTE
END TYPE

CONST ESC=chr$(27)
CONST Links=200,Oben=30,Feldx=16,Feldy=16,Startx=7,Starty=1
CONST scrnX = 640,scrnY = 480,depth = 32
CONST fullscreen = &h0' Vollbildmodus ( &h0 = aus, &h1 = an )
    
DIM FELD(1 TO 15,1 TO 23) AS BYTE
DIM STEIN(1 TO 4) AS KOORDINATE
DIM POSITION AS KOORDINATE
DIM esc_taste AS BYTE
DIM Punkte AS ULONGINT
 'Stein 1   ###  Stein 2   ####  Stein 3   ##
 '            #                            ##
 
 'Stein 4    #   Stein 5   ##    Stein 6   ### 
 '          ###             ##             #
 
 'Stein 7    ##
 '          ##
'Steine_x Speichert alle X Werte der Steine
DIM Steine_x(1 TO 7,1 TO 4) AS BYTE=>_
{ {1,2,3,3},_'Stein 1
  {1,2,3,4},_'Stein 2
  {1,1,2,2},_'Stein 3
  {1,2,2,3},_'Stein 4
  {1,2,2,3},_'Stein 5
  {1,1,2,3},_'Stein 6
  {1,2,2,3} _'Stein 7
  }
'Steine_y Speichert alle y Werte der Steine
DIM Steine_y(1 TO 7,1 TO 4) AS BYTE=>_
{{1,1,1,2},_'Stein 1
 {1,1,1,1},_'Stein 2
 {1,2,1,2},_'Stein 3
 {2,1,2,2},_'Stein 4
 {1,1,2,2},_'Stein 5
 {1,2,1,1},_'Stein 6
 {1,1,2,2} _'Stein 7
 }

DECLARE SUB DREH(byref koor AS KOORDINATE)
DECLARE SUB neuer_Stein(STEIN() AS KOORDINATE,Steine_x()AS BYTE,Steine_y()AS BYTE)
DECLARE FUNCTION max_x(stein()AS KOORDINATE)AS BYTE
DECLARE FUNCTION max_y(stein()AS KOORDINATE)AS BYTE
DECLARE FUNCTION min_x(stein()AS KOORDINATE)AS BYTE
DECLARE FUNCTION feld_frei(feld() AS BYTE,STEIN() AS KOORDINATE ,x AS BYTE ,y AS BYTE)AS BYTE
DECLARE SUB LOESCHE_ZEILE(feld()AS BYTE ,zeile AS INTEGER)
DECLARE SUB OpenGl_Initialisierung()
DECLARE SUB glPrint(x%,y%,hoehe%,Text AS STRING)
'Hauptfuntkionen
DECLARE FUNCTION Steuerung(Stein()AS KOORDINATE,POSITION AS Koordinate,feld()AS BYTE)AS BYTE
DECLARE SUB Ausgabe(Stein()AS KOORDINATE,POSITION AS Koordinate,feld()AS BYTE,tex AS Uinteger,Punkte AS ULONGINT)
DECLARE SUB Auswertung(Stein()AS KOORDINATE,Steine_x()AS BYTE,Steine_y()AS BYTE,POSITION AS Koordinate,feld()AS BYTE,Punkte AS ULONGINT)


screenres scrnX,scrnY,depth,,&h2 OR fullscreen

OpenGl_Initialisierung

'Laden der Textur
dim as uinteger tex
dim buffer(128*128*4+4) as ubyte   
bload "stein.bmp", @buffer(0)     ''Textur laden und in Buffer zwischenspeichern
tex=CreateTexture(@buffer(0))
if tex = 0 then end 1

'Initialisierung
RANDOMIZE TIMER
POSITION.X=Startx
POSITION.Y=Starty
Punkte=0
neuer_Stein(STEIN(),Steine_x(),Steine_y())
zaehler%=1
DIM SHARED Frames AS double 'muss noch anders gelöst werden, denn Zugriff auf globale Variablen soll man meiden
DIM StartZeit AS DOUBLE
StartZeit=TIMER

DO
 'IF zaehler% mod 3 =0 THEN _ 
 Frames=zaehler%/(TIMER-StartZeit)
  esc_taste=Steuerung(Stein(),POSITION,feld())
 
 Auswertung(Stein(),Steine_x(),Steine_y(),POSITION,feld(),Punkte)  
 
 zaehler%+=1  ' zaehler% zählt die Durchläufe der Schleife
 IF zaehler% MOD 10=0 THEN POSITION.y+=1 ' wenn die Anzahl der Durchläufe durch 10 Teilbar ist dann wird die y Position des Steines erhöht 

 Ausgabe(Stein(),POSITION,feld(),tex,Punkte)

LOOP UNTIL esc_taste


'Hauptprogramm ENDE
'es folgen die Unterprogrammes des Hauptprogrammes

'deht eine übergebene Koordinate eines Steines
SUB DREH(byref koor AS KOORDINATE)
 hilf%=koor.x
 koor.x=4-koor.y
 koor.y=hilf%
END SUB    

'Neuen Stein zuweisen
SUB neuer_Stein(STEIN() AS KOORDINATE,Steine_x()AS BYTE,Steine_y()AS BYTE)
 zufall%=INT(RND*7+1) 
 FOR i%=1 TO 4
  Stein(i%).x=Steine_x(zufall%,i%)  
  Stein(i%).y=Steine_y(zufall%,i%)  
 NEXT i% 
END SUB

'ermittelt größten X wert des übergebenen Steines
FUNCTION max_x(stein()AS KOORDINATE)AS BYTE
 DIM HILF AS BYTE
 HILF=1
 FOR i%=1 TO 4 
   IF stein(i%).x>hilf THEN HILF=stein(i%).x
 NEXT i%    
 max_x=hilf
END FUNCTION

'ermittelt größten y wert des übergebenen Steines
FUNCTION max_y(stein()AS KOORDINATE)AS BYTE
 DIM HILF AS BYTE
 HILF=1
 FOR i%=1 TO 4 
    IF stein(i%).y>HILF THEN HILF=stein(i%).y
 NEXT i%    
 max_y=hilf    
END FUNCTION 

'ermittelt kleinsten x wert des übergebenen Steines
FUNCTION min_x(stein()AS KOORDINATE)AS BYTE
 DIM HILF AS BYTE
 HILF=10 'hauptsache größer als der größt mögliche X Wert
 FOR i%=1 TO 4 
   IF stein(i%).x<hilf THEN HILF=stein(i%).x
 NEXT i%    
 min_x=hilf
END FUNCTION 


FUNCTION feld_frei(feld() AS BYTE,STEIN() AS KOORDINATE ,x AS BYTE ,y AS BYTE)AS BYTE
 FOR i%= 1 TO 4
   test%=test% OR FELD(x+STEIN(i%).x,y+STEIN(i%).y-1)=1
 NEXT
 feld_frei=not(test%)
END FUNCTION 

'Löscht eine übergebene Zeile und schiebt alle Felder darüber eine Zeile
'herunter
SUB LOESCHE_ZEILE(feld()AS BYTE ,zeile AS INTEGER)
 FOR l%=1 TO 15 
  feld(l%,zeile)=0   
 NEXT l%  
 FOR t%= zeile TO 2 STEP -1
  FOR u%=1 TO 15
   hilf%=feld(u%,t%)
   feld(u%,t%)=feld(u%,t%-1)
   feld(u%,t%-1)=hilf%
  NEXT u%     
 NEXT t% 
END SUB   

'Hauptfunktionen/Subs
FUNCTION Steuerung(Stein()AS KOORDINATE,POSITION AS Koordinate,feld()AS BYTE)AS BYTE
 return_%=0   
 DIM Eingabe AS STRING
 eingabe=inkey$
 IF len(eingabe)<1 THEN eingabe=LCASE$(inkey$) 

 'GETMOUSE x%, y%,,button%


 'IF button%=1 THEN eingabe=" "
 'IF button%=2 THEN eingabe="S"
 'POSITION.x=(x%-Links ) \ Feldx
 SELECT CASE eingabe
  CASE " ":
   FOR i%=1 TO 4 
    DREH(STEIN(i%))
   NEXT i% 
  CASE "s",chr(255)+chr(80):
   IF not(POSITION.y+max_y(stein()) >23) THEN POSITION.y+=1   
  CASE "d",chr(255)+chr(77):
   IF feld_frei(feld(),stein(),POSITION.x+1,POSITION.y)THEN _
    IF POSITION.x+max_x(stein())>=15 THEN _
     POSITION.x=15-max_x(stein())_
    ELSE POSITION.x+=1
  CASE "a",chr(255)+chr(75):
   IF feld_frei(feld(),stein(),POSITION.x-1,POSITION.y)THEN _
    IF POSITION.x+min_x(stein())<=1 THEN _
     POSITION.x=1-min_x(stein())_
    ELSE POSITION.x-=1 
  CASE ESC:
   return_%=-1   
 END SELECT 

 return return_%   
 '-1 bedeutet TRUE , 0 FALSE
END FUNCTION
'Prototyp einer neuen Steuernung , aber zu schnell -> dadurch Steuerung schwammig
FUNCTION Steuerung_alt(Stein()AS KOORDINATE,POSITION AS Koordinate,feld()AS BYTE)AS BYTE
 return_%=0   
 IF Multikey(&h39) THEN  '&h39= " " (SPACE) 
   FOR i%=1 TO 4 
    DREH(STEIN(i%))
   NEXT i%
   'SLEEP 10
 END IF  
 IF Multikey(&h50) THEN _ 'Pfeil nach unten
  IF not(POSITION.y+max_y(stein()) >23)and feld_frei(feld(),stein(),POSITION.x,POSITION.y+1) THEN POSITION.y+=1   
 IF Multikey(&h4D) THEN _ 'Pfeil rechts oder "D":
   IF feld_frei(feld(),stein(),POSITION.x+1,POSITION.y)THEN _
    IF POSITION.x+max_x(stein())>=15 THEN _
     POSITION.x=15-max_x(stein())_
    ELSE POSITION.x+=1
 IF Multikey(&h4B) THEN _ 'Pfeil links oder "A":
   IF feld_frei(feld(),stein(),POSITION.x-1,POSITION.y)THEN _
    IF POSITION.x+min_x(stein())<=1 THEN _
     POSITION.x=1-min_x(stein())_
    ELSE POSITION.x-=1 
 IF Multikey(&h01) THEN _ 'ESC:
   return_%=-1   
 ' Tastaturpuffer leeren
 WHILE INKEY$ <> "": WEND
 return return_%   
 '-1 bedeutet TRUE , 0 FALSE
END FUNCTION

SUB Quadrat()
 glBegin GL_QUADS 
        glTexCoord2f 0.0, 0.0 
		glVertex2i   0,1
		
        glTexCoord2f 1.0, 0.0 
		glVertex2i   1,1
        
        glTexCoord2f 1.0, 1.0 
		glVertex2i   1,0
        
        glTexCoord2f 0.0, 1.0 
		glVertex2i   0,0
 glEnd 
END SUB  

SUB Ausgabe(Stein()AS KOORDINATE,POSITION AS Koordinate,feld()AS BYTE,tex as uinteger,Punkte AS ULONGINT)

 glClear  GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT
 glColor3ub 0,255,0 
 glPrint(460,10,8,"Punkte : "+STR(Punkte))
 glPrint(10,60,8,"mit den Pfeiltasten ")
 glPrint(10,75,8,"       oder W A S D ")
 glPrint(10,90,8,"wird gesteuert ")
 glPrint(10,105,8,"Space zum drehen ")
 
 glPrint(216,420,16,"FUTURE TETRIS")
 glPrint(244,440,8,"Copyright Stg7 2007")
 
 
 glPrint(460,40,8,"Frames : "+STR(FIX(Frames*100)/100 ))
 
 glLoadIdentity  
 glColor3ub 200,10,10 
 glTranslatef Links-5,Oben,-2
 glScalef Feldx*15+10,Feldy*23+5,1
 Quadrat
 
 glLoadIdentity  
 glColor3ub 0,0,0 
 glTranslatef Links,Oben,-1
 glScalef Feldx*15,Feldy*23,1
 Quadrat
  
    
 
 
 'Ausgabe des Feldes
 FOR j%=1 TO 15     
  FOR i%=1 TO 23 
    glLoadIdentity    
    glTranslatef (j%-1)*Feldx+Links,(i%-1)*Feldy+Oben,0
    glScalef Feldx-1,Feldy-1,1
    
    IF feld(j%,i%) THEN 
        glBindTexture GL_TEXTURE_2D, tex ' Texture binden
        glColor3ub 200,10,10 
        Quadrat
        glBindTexture GL_TEXTURE_2D, 0
 
     ELSE 
        glColor3ub 0,0,255
        Quadrat 
    END IF     
    
    'LINE ((j%-1)*Feldx+Links,(i%-1)*Feldy+Oben)-(j%*Feldx+Links,i%*Feldy+Oben), 1+farbe%*3, BF
  NEXT i%
 NEXT j% 
 'Ausgabe des Steines
 glBindTexture GL_TEXTURE_2D, tex ' Texture binden
 
 FOR i%=1 TO 4
  IF not(STEIN(i%).y+POSITION.Y>23) THEN 
    glLoadIdentity 
   ' glColor3ub 255,255,255
    SELECT CASE i%
     CASE 1:glColor3ub 255,0,0
     CASE 2:glColor3ub 0,255,0
     CASE 3:glColor3ub 255,255,0
     CASE 4:glColor3ub 255,0,255
    END SELECT 
    
    glTranslatef (Stein(i%).x+POSITION.X-1)*Feldx+Links,(STEIN(i%).y+POSITION.Y-1)*Feldy+Oben,2
    glScalef Feldx,Feldy,1
    Quadrat   
  END IF    
   'LINE ((Stein(i%).x+POSITION.X-1)*Feldx+Links,(STEIN(i%).y+POSITION.Y-1)*Feldy+Oben)-((Stein(i%).x+POSITION.X)*Feldx+Links,(STEIN(i%).y+POSITION.Y)*Feldy+Oben), 11+i%, BF
 NEXT i%    
 glBindTexture GL_TEXTURE_2D, 0

 'SCREENSYNC
 'SCREENCOPY' aktive Seite auf sichtbare kopieren
 glFlush ' Verarbeitung der Befehle
 flip
 if command$="sync" then screensync 'mit Sync sind es 32 Frames/s ohne 64 Frames/s
END SUB


SUB Auswertung(Stein()AS KOORDINATE,Steine_x()AS BYTE,Steine_y()AS BYTE,POSITION AS Koordinate,feld()AS BYTE,Punkte AS ULONGINT)
 DIM PRUEF AS INTEGER
 FOR i%=1 TO 23 
  PRUEF=-1
  FOR j%=1 TO 15
   PRUEF=PRUEF*feld(j%,i%)
  NEXT J%
  IF PRUEF THEN 
      LOESCHE_ZEILE(feld(),i%)  'eventuell Zeile löschen
      Punkte+=1                 'und dann die Punkte erhöhen
  END IF    
 NEXT i%
 neuer_Stein_%=(POSITION.y+max_y(stein()) >23 )OR not(feld_frei(feld(),stein(),POSITION.x,POSITION.y+1)) 
 IF neuer_Stein_%  THEN  
     FELD(POSITION.x+STEIN(1).x,POSITION.y+STEIN(1).y-1)=1
     FELD(POSITION.x+STEIN(2).x,POSITION.y+STEIN(2).y-1)=1
     FELD(POSITION.x+STEIN(3).x,POSITION.y+STEIN(3).y-1)=1
     FELD(POSITION.x+STEIN(4).x,POSITION.y+STEIN(4).y-1)=1
     POSITION.X=Startx
     POSITION.Y=Starty
     neuer_Stein(STEIN(),Steine_x(),Steine_y())'neuer Stein
 END IF  
END SUB 
SUB OpenGl_Initialisierung()
    
 ' Konfiguration von OpenGL
 glMatrixMode(GL_PROJECTION)      ' Matrix definieren
 glLoadIdentity
 glViewport(0,0,scrnX,scrnY)      ' Achse festlegen
 '           
 glOrtho(0,640,480,0,-128,128)
 '       mimx,maxx,miny,maxy,minz,maxz 

 glMatrixMode(GL_MODELVIEW)       ' Deaktivierung des Rendern der Rückseiten
 glEnable(GL_CULL_FACE)
 glCullFace(GL_BACK)
 glEnable GL_TEXTURE_2D           ' Texturen aktivieren
 'glLoadIdentity
 glEnable(GL_DEPTH_TEST)          ' Tiefentest
 glDepthFunc(GL_LESS)
 glEnable(GL_ALPHA_TEST)          ' Alphatest
 glAlphaFunc(GL_GREATER, 0.1)
 glClearColor( 0.0, 0.0, 0.0, 0.0 )
END SUB
SUB glPrint(x%,y%,hoehe%,Text AS STRING)
 DIM zeichen,zeile AS ubyte 
 DIM hilf_hoehe AS Single
 hilf_hoehe=hoehe%/8      
 FOR i%=0 TO len(text)-1 
  zeichen=ASC(MID(text,i%+1,1))
  FOR z%=0 TO 7 
      zeile=SCHRIFT(zeichen,z%)
      FOR k%=7 TO 0 STEP -1 
          IF zeile MOD 2 =1 THEN 
              glLoadIdentity 
              glTranslatef (x%+k%*hilf_hoehe+i%*8*hilf_hoehe,y%+z%*hilf_hoehe,2)
              glScalef hilf_hoehe,hilf_hoehe,1
              glBegin GL_QUADS 
                glVertex2i   0,1
		        glVertex2i   1,1
             	glVertex2i   1,0
             	glVertex2i   0,0
              glEnd 
          END IF    
          zeile=zeile\2          
      NEXT k%    
  NEXT z%    
 NEXT i%    
END SUB