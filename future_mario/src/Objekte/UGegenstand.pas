//
// Name: 	    UGegenstand
// Datum:	    19.03.2008
// letzte Änderung: 19.03.2008
// Version:  	    0.1
// Zweck:           ein Gegenstand im Spiel
//
// Programmieren:   Daniel Renner ,Steve Göring
// Kontakt:         daniel26289@yahoo.de,stg7@gmx.de
// Copyright:       2008
//
//

unit UGegenstand;

interface

uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,math,forms,

     UGLObject;

type TGegenstand=class(TGLObject)
      private
       zcrazy:boolean;
       procedure setcrazy(const Value: boolean);
      protected
       Tex : TGLBMP;
       ztexx,ztexy:integer;
       kForm:TForm;
       generated:boolean;
       StartZeit:Word;
       procedure rueckeweiter;
      public
       property breite:integer read zbreite;
       property hoehe:integer read zhoehe;
       property crazy:boolean read zcrazy write setcrazy;
       constructor create(textur:TGLBMP;Form:TForm;x_,y_,texx,texy:integer);virtual;
       procedure render;virtual;
       procedure weiter;virtual;
       procedure bind;
       function Imbildschirm: boolean;
     end;

implementation

{ TGegenstand }




procedure TGegenstand.bind;
begin
  if not(generated) then
   begin
    tex.GenTexture();
    generated:=true;
   end;
 tex.Bind;
end;

constructor TGegenstand.create;
begin
 inherited create;

 tex:= textur;
 tex.ColorKey(255,0,255,0);
 kForm:=Form;
 generated:=false;
 zx:=x_;
 zy:=y_;
 ztexx:=texx;
 ztexy:=(31-texy);
 zbreite:=40;
 zhoehe:=40;
 StartZeit:=MilliSecondOf(Time);

end;

function TGegenstand.Imbildschirm: boolean;
begin
 result:= (x>=- zbreite / 2) and  ( x<= 640+ zbreite /2 );
end;

procedure TGegenstand.render;
Var links,oben:real;
begin
  If zx>-zbreite div 2 
   Then
    Begin

     if kform.active
      then rueckeweiter;

     glMatrixMode(GL_MODELVIEW);
     glLoadIdentity;

     glTranslatef(zx,zy,10);

     if zcrazy
      then glcolor4ub(random(255),random(255),random(255),random(255))
      else glcolor4ub(255,255,255,255);

     glenable(GL_TEXTURE_2D);


     links:=ztexx * 1/32;
     oben:=ztexy*1/32 ;

     glBegin(GL_QUADS);
      glTexCoord2f( links      ,oben+ 1/32  );
      glVertex2f(-zbreite / 2 ,  zhoehe / 2);
      glTexCoord2f(links       ,oben);
      glVertex2f(-zbreite / 2 , -zhoehe / 2);
      glTexCoord2f(links + 1/32,oben  );
      glVertex2f( zbreite / 2  ,-zhoehe / 2);
      glTexCoord2f(links + 1/32,oben+1/32   );
      glVertex2f( zbreite / 2  , zhoehe / 2);
     glEnd;
     glDisable(GL_TEXTURE_2D);
    End;
end;

procedure TGegenstand.rueckeweiter;
begin
 if (abs(startzeit-millisecondof(time) )>200)
  Then weiter;
end;
procedure TGegenstand.setcrazy(const Value: boolean);
begin
 zcrazy:=value;
end;

procedure TGegenstand.weiter;
begin
 zx:=zx-1;
 Startzeit:=MillisecondOf(time);
end;


end.
