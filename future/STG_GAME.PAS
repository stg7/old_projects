UNIT STG_GAME;
INTERFACE
 USES CRT,GRAPH,DOS,MOUSE;
 CONST HOCH=#72;
       RUNTER=#80;
       LINKS=#75;
       RECHTS=#77;
       ENTER=#13;
       ESC=#27;
       AN=TRUE;
       AUS=FALSE;
       CenterX=320;
       CenterY=240;

 PROCEDURE cursor(an_aus:boolean);
 {Cursor an aus schalten im Textmodus}
 PROCEDURE DEL_TASTATUR;
 {Lˆschte den Tastaturspeicehr}
 PROCEDURE WAIT(TASTE:CHAR);
 {Wartet auf eine bestimmte Taste}
 PROCEDURE LOAD_STG_GRAFIK(x,y:integer;datei_name:string);
 {STG GRAFIK LADEN}
 FUNCTION ToStr(Zahl: Longint): String;
 {Zahl in String umwandeln}
 FUNCTION INKEY:char;
 {Zeichen ohne Warten einlesen}
 PROCEDURE MOUSECHANGE;
 {Wartet auf das Bewegen der Maus}
 FUNCTION MOUSEOVER(x1,y1,x2,y2:word):boolean;
 {öberprÅft ob die Maus sich in einem bestimmten Rechteck(x1,y1,x2,y2)
  befindet}
 PROCEDURE BOX(zeile1,zeile2:string);
 {zeichnet eine MEssageBox}
 PROCEDURE WINDOWBOX(x,y,x1,y1:word;zeile_oben:string);
 {gro·es fenster mit öberschrift }
 FUNCTION TIME:longint;
 {Zeit in Sekunden}
 PROCEDURE INPUT(VAR text:string);
 {readln Ersatz fÅr GrafikModus (mit Outtext)}


IMPLEMENTATION

 PROCEDURE cursor(an_aus:boolean);{Quelle www.webplain.de}
 VAR regs:registers;
 BEGIN
 IF an_aus
  THEN
   BEGIN
    regs.ax := $0100;
    regs.cx := $0607;
    intr($10, regs);
   END
  ELSE
   BEGIN
    regs.ax := $0100;
    regs.cx := $2607;
    intr($10, regs);
   END;
 END;

 PROCEDURE DEL_TASTATUR;{Quelle www.webplain.de}
 BEGIN
  inline($FA);
  memw[$40 : $1A] := memw[$40 : $1C];
  inline($FB);
 END;

 PROCEDURE WAIT (TASTE:CHAR);
 VAR EINGABE:CHAR;
 BEGIN
  REPEAT
   EINGABE:=READKEY;
  UNTIL EINGABE=TASTE;
 END;

 PROCEDURE LOAD_STG_GRAFIK(x,y:integer;datei_name:string);
 VAR Datei:Text;
     zeile:string;
     zeilen_nr:byte;
     i:integer;
     farbe,zeichen,fehler:integer;
 BEGIN
  Assign(Datei, datei_name);
  ReSET(Datei);
  zeilen_nr:=1;
  WHILE NOT(EOF(Datei)) DO
   BEGIN
    READLN(DATEI,zeile);
    FOR i:=1 TO LENGTH(zeile) DO
     BEGIN
      VAL(copy(zeile,i,1),zeichen,fehler);
      CASE zeichen OF
        0: farbe:=0;    {.. Schwarz  ..}
        1: farbe:=14;   {..  Gelb    ..}
        2: farbe:=9;    {.. hellblau ..}
        3: farbe:=6 ;   {..  braun   ..}
        4: farbe:=2 ;   {..   grÅn   ..}
        5: farbe:=1 ;   {..  blau    ..}
        6: farbe:=7;    {.. hellgrau ..}
        7: farbe:=8;    {..dunkelgrau..}
        8: farbe:=15;   {..  weiﬂ    ..}
        9: farbe:=4     {..   rot    ..}
      END;
      PUTPIXEL(x+i,y+zeilen_nr,farbe);
     END;
    zeilen_nr:=zeilen_nr+1;
   END;
  Close(Datei);
 END;

 FUNCTION ToStr(Zahl: Longint): String;
 {Zahl in String umwandeln }
 VAR
  s: string[11];
 BEGIN
  Str(Zahl, S);
  ToStr := S;
 END;

 FUNCTION INKEY;
 BEGIN
  IF KEYPRESSED
   THEN inkey:=readkey
   ELSE inkey:=' ';
 END;
 PROCEDURE MOUSECHANGE;
 VAR taste,x,y:word;
     taste1,x1,y1:word;

     CHANGE:boolean;
 BEGIN
  REPEAT
   MouseEVENT(taste,x,y);
   delay(5);
   MouseEVENT(taste1,x1,y1);
   CHANGE:=(X<>X1) AND
           (y<>y1) OR
           (TASTE<>TASTE1);
  UNTIL (CHANGE) OR (INKEY=ESC);
 END;

 FUNCTION MOUSEOVER(x1,y1,x2,y2:word):boolean;
 VAR x,y:word;
 BEGIN
  MOUSEGETPOS(x,y);
  MOUSEOVER:= (x>x1) AND (x<x2) AND (y>y1) AND (y<y2)
 END;
 PROCEDURE BOX;
 VAR Text_Settings: TextSettingsType;
     Fill_settings: FillSettingsType;
     alte_farbe:word;
 BEGIN
  GETFILLSETTINGS(FILL_SETTINGS);
  alte_farbe:=GETCOLOR;
  GETTEXTSETTINGS(Text_Settings);

  SETFILLSTYLE(1,1);
  SETTEXTSTYLE(DefaultFont,HORIZDIR,1);

  SETFILLSTYLE(1,15);
  BAR(198,198,422,252);

  SETFILLSTYLE(1,1);
  BAR(200,200,420,250);

  SETCOLOR(15);
  OUTTEXTXY(210,210,zeile1);
  OUTTEXTXY(210,230,zeile2);


  {Alten Zustand wiederherstellen}
  WITH TEXT_SETTINGS DO
  BEGIN
   SetTextJustify(Horiz, Vert);
   SetTextStyle(Font, Direction, CharSize);
  END;
  WITH Fill_SETTINGS DO
   SetFillStyle(Pattern, Color);

  SETCOLOR(alte_farbe);
 END;
 PROCEDURE WINDOWBOX;
 VAR Text_Settings: TextSettingsType;
     Fill_settings: FillSettingsType;
     alte_farbe:word;
 BEGIN
  GETFILLSETTINGS(FILL_SETTINGS);
  alte_farbe:=GETCOLOR;
  GETTEXTSETTINGS(Text_Settings);

  SETFILLSTYLE(1,1);
  SETTEXTSTYLE(DefaultFont,HORIZDIR,1);

  SETFILLSTYLE(1,15);
  BAR(x,y,x1,y1);

  SETFILLSTYLE(1,1);
  BAR(x+2,y+2,x1-2,y1-1);

  SETCOLOR(15);
  OUTTEXTXY(x+5,y+5,zeile_oben);

  {Alten Zustand wiederherstellen}
  WITH TEXT_SETTINGS DO
  BEGIN
   SetTextJustify(Horiz, Vert);
   SetTextStyle(Font, Direction, CharSize);
  END;
  WITH Fill_SETTINGS DO
   SetFillStyle(Pattern, Color);
  SETCOLOR(alte_farbe);
 END;
 FUNCTION TIME:longint;
 VAR std,min,sec,hsec:word;
 BEGIN
  GETTIME(std,min,sec,hsec);
  TIME:=std*60*60+min*60+sec;
 END;
 PROCEDURE INPUT(VAR text:string);
 VAR taste:char;
 BEGIN
  text:='';
  WHILE NOT(TASTE=ENTER) DO
  BEGIN
   taste:=readkey;
   IF NOT(TASTE=ENTER)
    THEN
     BEGIN
      text:=text+taste;
      OUTTEXT(taste);
     END;
  END;
 END;



BEGIN
END.
