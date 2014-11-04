'$include: 'text.inc'


#include once "GL/gl.bi"
#include once "GL/glu.bi"
CONST scrnX = 640,scrnY = 480,depth = 32
CONST fullscreen = &h0' Vollbildmodus ( &h0 = aus, &h1 = an )
screenres scrnX,scrnY,depth,,&h2 OR fullscreen

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
SUB Quadrat()    
 glBegin GL_QUADS 
    	glVertex2i   0,1
		
     	glVertex2i   1,1
        
     	glVertex2i   1,0
        
     	glVertex2i   0,0
 glEnd 
END SUB

SUB glPrint(x%,y%,hoehe%,Text AS STRING)
 DIM zeichen,zeile AS ubyte 
 hoehe%=hoehe%\8      
 FOR i%=0 TO len(text)-1 
  zeichen=ASC(MID(text,i%+1,1))
  FOR z%=0 TO 7 
      zeile=SCHRIFT(zeichen,z%)
      FOR k%=7 TO 0 STEP -1 
          IF zeile MOD 2 =1 THEN 
              glLoadIdentity 
              glTranslatef (x%+k%*hoehe%+i%*8*hoehe%,y%+z%*hoehe%,2)
              glScalef hoehe%,hoehe%,1
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

k%=0
do
 glClear  GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT
 
 glLoadIdentity 
    
 glColor3ub 255,255,255
 glTranslatef (100,100,2)
 glScalef 16,16,1
 'Quadrat    
 
 glLoadIdentity 
 glColor3ub 255,0,0
 glPRINT(100+k%,100,16,"HALLO")
 glBindTexture GL_TEXTURE_2D, 0

 'SCREENSYNC
 'SCREENCOPY' aktive Seite auf sichtbare kopieren
 glFlush ' Verarbeitung der Befehle
 flip
 screensync
 k%+=1   
loop until INKEY$=chr(27)