//
// Name: 	    UFigur
// Datum:	    24.02.2008
// letzte Änderung: 21.03.2008
// Version:  	    0.1
// Zweck:           Objektmodel Supermario Figur
//
// Programmieren:   Daniel Renner,Steve Göring
// Kontakt:         daniel26289@yahoo.de,stg7@gmx.de 
// Copyright:       2008
// Änderungen:
//
//

unit UFigur;

interface
uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,math,forms,

     UGLObject,
     uliste,
     UGegenstand,
     UMuenze,
     UTypenUndKonstanten;

type
     TFigur=class(TGLObject)
      protected
       Tod     : boolean;

       dy:real;


       MyTex : TGLBMP;
       texturnr:TPos;
       richtung:Trichtung;
       v:integer;


       generated:boolean;
       kForm:TForm;

       kgegenstaende,kFiguren,KMuenzen:TListe;
       kollobj:TGLObject;
       obj:TGlObject;

       procedure setTod(const Value: boolean);

       function kollision2erObjekte(obj1,obj2:TGLObject):boolean;
       function kollision_mit_Objekten(x,y:integer;Liste:TListe):boolean;overload;
       function kollision_mit_Objekten(x,y:integer):boolean;overload;
       
       procedure steuerung;virtual;abstract;
       procedure nachrechts(n:integer); //n schritte nach rechts,links,oben,unten
       procedure nachlinks(n:integer);
       procedure nachoben(n:integer);
       procedure nachunten(n:integer);
       procedure bewegen(richtung:Trichtung);virtual;abstract;

      public
       constructor create(textur:string;Form:TForm);virtual;
       
       procedure kennt(Liste:Tliste);
       procedure kenntFiguren(Liste:Tliste);
       procedure kenneMuenzen(Muenzen:TListe);
       property nichtlebend:boolean read Tod write setTod;
       destructor destroy;
     end;




implementation

{ TSpieler }


constructor TFigur.create;
begin

 zbreite:=60;
 zhoehe:=90;

 mytex:= TGLBMP.Create(textur);
 mytex.ColorKey(0,0,255, 0);

 kForm:=Form;

 zx:=50;
 zy:=100;
 dy:=0;

 obj:=TGLObject.Create;
 obj.breite:=zbreite;
 obj.hoehe:=zhoehe;


 texturnr.x:=6;
 texturnr.y:=6;
 richtung:=Rstop;
 V:=5;



end;





procedure TFigur.setTod(const Value: boolean);
begin
 tod:=value;

end;

destructor TFigur.destroy;
begin
 obj.Free;
end;



procedure TFigur.kenneMuenzen(Muenzen: TListe);
begin
 kMuenzen:=Muenzen;
end;

procedure TFigur.kennt(liste:Tliste);
begin
 kgegenstaende:=liste;
end;
procedure TFigur.kenntFiguren(Liste: Tliste);
begin
 kFiguren:=liste;
end;





function TFigur.kollision_mit_Objekten(x, y: integer; Liste: TListe): boolean;
var i:integer;
    kollision:boolean;
begin
 kollision:=false;
 obj.x:=x;
 obj.y:=y;
 obj.hoehe:=hoehe;
 obj.breite:=breite;

 if assigned(liste)
  then
   begin
     i:=0;
     while (i<liste.getlaenge)and not kollision  do
     begin
      kollobj:=liste.getelement(i) as TGLObject;
      kollision:=kollision or kollision2erObjekte(obj,kollobj);
      inc(i);
     end;
   end;

 if not kollision
  then kollobj:=nil;

 result:=kollision;
end;

function TFigur.kollision_mit_Objekten(x, y: integer): boolean;
begin
 // zuerst wird die Kollision mit meunzen getestet
 // anschließend die mit gegnern und dann die mit gegenständen
 // da bei einer or verknüpfung bei einem true direkt abgebrochen wird
 // und der rest des ausdruckes nicht ausgeführt wird
 result:= kollision_mit_Objekten(x, y,kmuenzen) or
          kollision_mit_Objekten(x, y,kfiguren) or
          kollision_mit_Objekten(x, y,kgegenstaende)  and
          not (kollobj is TMuenze);

end;

procedure TFigur.nachlinks;
var startx:real;
begin
 startx:=zx;
 while not (kollision_mit_Objekten(round(zx-1), round(zy))) and
       (abs(zx-startx)<n) do
  zx:=zx-1;
end;

procedure TFigur.nachoben;
var starty:real;
begin
 starty:=zy;
 while not (kollision_mit_Objekten(round(zx), round(zy+1))) and
       (abs(zy-starty)<n) do
  zy:=zy+1;
end;

procedure TFigur.nachrechts;
var startx:real;
begin
 startx:=zx;
 while not (kollision_mit_Objekten(round(zx+1), round(zy))) and
       (abs(zx-startx)<n) do
  zx:=zx+1;
end;

procedure TFigur.nachunten;
var starty:real;
begin
 starty:=zy;
 while not (kollision_mit_Objekten(round(zx), round(zy-1))) and
       (abs(zy-starty)<n) do
  zy:=zy-1;
end;

function TFigur.kollision2erObjekte(obj1, obj2: TGLObject): boolean;
var dx,dy:real;
    Shb,Shh:real;
begin
 dx:=abs( obj1.x - obj2.x);
 dy:=abs(obj1.y - obj2.y);
 Shb:=(obj1.breite + obj2.breite) / 2; // Summe halber breiten;
 Shh:=(obj1.hoehe + obj2.hoehe) / 2; // Summe halber hoehen;
 result:= (dx+xtoleranz<= (shb) ) and (dy <=(shh));
end;

end.
