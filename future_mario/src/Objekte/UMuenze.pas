unit UMuenze;

interface

uses GLBMP,Forms,DGLOpenGL,

     Ugegenstand;

type TMuenze= class(Tgegenstand)

      private
       sichtbar:boolean;
      public
       constructor create(textur:TGLBMP;Form:TForm;x_,y_:integer);virtual;
       procedure render;override;
       procedure weiter;override;
       procedure sammeln;
     end;


implementation

{ TMuenze }



constructor TMuenze.create(textur: TGLBMP; Form: TForm; x_, y_: integer);
begin
  inherited create(textur,Form,x_,y_,0,0);
  tex.ColorKey(0,255,0,0);
  sichtbar:=true;
end;

procedure TMuenze.render;
Var links : real;
begin
 
  If sichtbar and ( zx>-zbreite div 2)
   Then
    Begin

     rueckeweiter;

     glMatrixMode(GL_MODELVIEW);
     glLoadIdentity;

     glTranslatef(zx,zy,10);
     glcolor4ub(255,255,255,255);

     glenable(GL_TEXTURE_2D);

     links:=ztexx * 1/4;

     glBegin(GL_QUADS);
      glTexCoord2f( links      ,1  );
      glVertex2f(-zbreite / 2 ,  zhoehe / 2);
      glTexCoord2f(links       ,0);
      glVertex2f(-zbreite / 2 , -zhoehe / 2);
      glTexCoord2f(links + 1/4,0  );
      glVertex2f( zbreite / 2  ,-zhoehe / 2);
      glTexCoord2f(links + 1/4,1   );
      glVertex2f( zbreite / 2  , zhoehe / 2);
     glEnd;
     glDisable(GL_TEXTURE_2D);

    End;

end;

procedure TMuenze.sammeln;
begin
 sichtbar:=false;
 zx:=-90;
 zy:=-90;
end;

procedure TMuenze.weiter;
begin
  inherited weiter;
  ztexx:=Ztexx+1;
  if ztexx>3
   then ztexx:=0;

end;

end.
