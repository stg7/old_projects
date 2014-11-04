//
// Name: 	    USpieler
// Datum:	    19.02.2008
// letzte Änderung: 19.02.2008
// Version:  	    0.1
// Zweck:           Objektmodel Supermario Figur
//
// Programmierer:   Steve Göring,Daniel Renner
// Kontakt:         stg7@gmx.de
// Copyright:       2008
// Änderungen:      ...
// todo:	    Eigenschaften des Spielers hinzufügen (Vorarbeit
// 		    von Daniel in der Klasse UMario!)
//
//

unit USpieler;

interface

uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,math,forms,

     UMuenze,
     UFunktionen,
     UListe,
     Ugegenstand,
     UMusikImSpiel,
     UFigur,
     UGegner,
     UTypenUndKonstanten;

type
     TPunkteerhoehen=procedure (Punkte:integer) of object;
     TExit=procedure of object;


     TSpieler=class(TFigur)
      private
       starty:real;
       fallen:boolean;
       sprung:boolean;

       kMusik:TMusikImSpiel;
       punkte:integer;

       unverwundbar:boolean;
       start_unverwundbar:integer;
       schritte:integer;
       Groesse : boolean;   //Tja Mario kann klein sein oder Normal oder groß bzw. könnte bei Groß so ne art special rauskommen oder so :-P Sonst könnten wir es auch weglassen


       FPunkteerhoehen: TPunkteerhoehen;
       FExit: TExit;


       procedure steuerung;override;
       procedure tastenauswerten;
       procedure springen;
       procedure texturenermitteln;
       procedure erhoehePunkte;

       procedure auswertenderKollision;
       procedure weiterschieben;

      protected
       procedure bewegen(richtung:TRichtung);override;
      public
       property onExit:TExit read FExit write FExit;
       property onpunkteerhoehen:TPunkteerhoehen read FPunkteerhoehen write Fpunkteerhoehen;
       constructor create(textur:string;Form:TForm; Musik : TMusikImSpiel);virtual;
       procedure render;override;

      end;

implementation

{ TSpieler }




procedure TSpieler.auswertenderKollision;
begin
// kollobj is .. Testet ob das Kollisionsobjet eine Instanz der angegebenen Klasse ist

 if (kollobj is TGegner) and not unverwundbar
  then
   if fallen
    then Begin
          KMusik.MusikAbspielen('GegnerSchlagen');
          (kollobj as Tgegner).toeten;
          bewegen(richtung);
         End
    else begin
          if not groesse
           then tod:=true;
          groesse:=false;
          unverwundbar:=true;
         end;

  if kollobj is TMuenze
   then
    begin
     KMusik.MusikAbspielen('muenze');
     (Kollobj as TMuenze).sammeln;
     erhoehePunkte;
     bewegen(richtung);
    end;

  if kollobj is TGegenstand
   then
    begin
     if (richtung=Rlinks)
      then bewegen( Rrechts );
     if richtung=Rrechts
      then bewegen( Rlinks );
    end;

end;

procedure TSpieler.bewegen(richtung: TRichtung);
begin
 if richtung=Rrechts
  then nachrechts(v);
 if richtung=Rlinks
  then nachlinks(v);
 if richtung=Roben
  then nachoben(v);
 if richtung=Runten
  then nachunten(v);

end;

constructor TSpieler.create(textur: string; Form: TForm; Musik : TMusikImSpiel);
begin
 inherited create(Textur,Form);
 kMusik:=Musik;
 groesse:=true;
 schritte:=0;
end;


procedure TSpieler.erhoehePunkte;
begin
 punkte:=punkte+1;
 if assigned(FPunkteerhoehen)
  then FPunkteerhoehen(Punkte);
end;

procedure TSpieler.render;
var links,oben:real;
begin
  // eventuelles Generieren der Textur, dies kann nur
  // geschehen wenn bereits OpengL Initialisiert wurde
  if not(generated) then
   begin
    mytex.GenTexture();
    generated:=true;
   end;

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  glTranslatef(x,y,10);
  if unverwundbar
   then glcolor4ub(random(55)+200,random(55)+200,random(55)+200,random(255))
   else glcolor4ub(255,255,255,255);


  glEnable(GL_TEXTURE_2D);

  mytex.bind();

  links:=texturnr.x * 1/12;
  oben:=texturnr.y*1/8 ;

  glBegin(GL_QUADS);
   glTexCoord2f( links      ,oben+ 1/8  );
     glVertex2f(-zbreite / 2, zhoehe / 2);
   glTexCoord2f(links       ,oben);
     glVertex2f(-zbreite / 2 , -zhoehe / 2);
   glTexCoord2f(links + 1/12,oben  );
     glVertex2f(zbreite / 2, -zhoehe / 2);
   glTexCoord2f(links + 1/12,oben+1/8   );
     glVertex2f(zbreite / 2,zhoehe / 2);

  glEnd;

  glDisable(GL_TEXTURE_2D);


  steuerung;
end;

procedure TSpieler.springen;
begin
 if (key_pressed(ord(' '))) and (sprung=false)and (fallen=false)
  then
   begin
    kMusik.MusikAbspielen('Springen');
    starty:=y;
    sprung:=true;
   end;

 if ( abs(y-starty)>=sprunghoehe)
  then
   begin
    fallen:=true;
    sprung:=false;
   end
  else
   if sprung
    then nachoben(10);

 if not(kollobj is Tgegenstand)
  then
   Begin
    If (not sprung or fallen )
     then nachunten(10) ;
   end
  Else fallen:=false;
end;

procedure TSpieler.steuerung;
var
  i,k: Integer;
  tmp:TGegenstand;
begin
 if kform.Active
  then
   begin

    texturnr.y:=6;
    V:=5;
    richtung:=Rstop;

    nachunten(anziehung);

    tastenauswerten;

    springen;


    if (y<0) or (x<0)
     then Tod:=true;

    bewegen(Richtung);


    auswertenderKollision ;

    weiterschieben;


    nachlinks(1);



    if unverwundbar
     then
      begin
       start_unverwundbar:=start_unverwundbar+1;
       if start_unverwundbar =80
        then
         begin
           start_unverwundbar:=0;
           unverwundbar:=false;
         end;
      end;

     texturenermitteln;

   end;
end;

procedure TSpieler.tastenauswerten;
var Canclose:boolean;
begin
 if key_pressed(VK_LEFT,ord('A'))
  then richtung:=Rlinks;

 if key_pressed(VK_RIGHT,ord('D'))
  then richtung:=Rrechts;

 if key_pressed(VK_DOWN,ord('S'))
  then texturnr.y:=5;

 if key_pressed(VK_UP,ord('W'))
  then texturnr.y:=7;

 if key_pressed(VK_CONTROL)
  then V:=v*2;

 if key_pressed(27)// ESC
  then if assigned(onexit)
        then onexit; // Exit Event auslösen
end;

procedure TSpieler.texturenermitteln;
begin
 if richtung=Rlinks
  then texturnr.y:=4;
 if richtung=Rrechts
  then texturnr.y:=6;
 if richtung=Rstop
  then texturnr.x:=7;

 If not(groesse)
   Then Texturnr.x:=1
   else Texturnr.x:=7;

 inc(schritte);
 if schritte mod 4 = 0
  then
   begin
    if ord(richtung)mod 2=1
     then texturnr.x:=texturnr.x+1;
    schritte:=1;
    if groesse
     then
      begin
       if texturnr.x>=8
        then texturnr.x:=6
      end
     else
      begin
       if texturnr.x>=3
       then texturnr.x:=1;
      end;
  end;

 if sprung
  then
   begin
    Texturnr.y:=8;
    If (Richtung=Rlinks)
     then
      Begin
       Texturnr.y:=8;
       Texturnr.x:=Texturnr.x + 3;
      End;
   end;
end;

procedure TSpieler.weiterschieben;
var i:integer;
    tmp:Tgegenstand;
begin
 for i := 0 to kgegenstaende.getLaenge- 1 do
    begin
      tmp:=Tgegenstand(kgegenstaende.getelement(i));
      tmp.weiter;
      kollision_mit_Objekten(round(x),round(y),kgegenstaende);
      if kollobj is TGegenstand
       then
        begin
         if (richtung=Rlinks)
          then bewegen( Rrechts );
         if (richtung=Rrechts)  or (richtung=Rstop)
          then bewegen( Rlinks );
        end;
     end;
   for i := 0 to kMuenzen.getLaenge- 1 do
    begin
      tmp:=TMuenze(kMuenzen.getelement(i));
      tmp.weiter;
      auswertenderKollision ;
    end;
end;

end.
