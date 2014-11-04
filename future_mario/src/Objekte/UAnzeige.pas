unit UAnzeige;

interface

uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,

     UGLObject;

type TAnzeige=class(TGLObject)
      private
       generated:boolean;
       Tex:TGLBMP;
       punkte:integer;

      public
       constructor create(Dateiname:string);virtual;
       procedure render;override;
       procedure setze(punkte:integer);
     end;
implementation

{ TMap }

constructor TAnzeige.create;
begin
  tex:= TGLBMP.Create(Dateiname);
  tex.ColorKey(0,0,0,0);
  hoehe:=40;
  breite:=40;
  x:=640 div 2;
  y:=480 - hoehe div 2 ;
end;

procedure TAnzeige.render;
var links:real;
    ziffer:integer;
begin

  glMatrixMode(GL_MODELVIEW);

  if not(generated) then
   begin
    tex.GenTexture();
    generated:=true;
   end;

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;

  glTranslatef(x,y,10);
  glcolor4ub(255,255,255,255);

  glEnable(GL_TEXTURE_2D);

  tex.bind();

  ziffer:=punkte div 10;
  links:=ziffer*1/10;

  glBegin(GL_QUADS);
   glTexCoord2f( links      ,1  );

     glVertex2f(-zbreite/2 , zhoehe / 2);

   glTexCoord2f(links       ,0);

     glVertex2f(-zbreite/2  , -zhoehe / 2);

   glTexCoord2f(links + 1/10,0  );

     glVertex2f(0 , -zhoehe / 2);

   glTexCoord2f(links + 1/10,1   );

     glVertex2f(0 ,zhoehe / 2);

  glEnd;

  ziffer:=punkte mod 10;
  links:=ziffer*1/10;

  glBegin(GL_QUADS);
   glTexCoord2f( links      ,1  );

     glVertex2f(0 , zhoehe / 2);

   glTexCoord2f(links       ,0);

     glVertex2f(0  , -zhoehe / 2);

   glTexCoord2f(links + 1/12,0  );

     glVertex2f(zbreite/2 , -zhoehe / 2);

   glTexCoord2f(links + 1/12,1   );

     glVertex2f(zbreite/2 ,zhoehe / 2);

  glEnd;



  glDisable(GL_TEXTURE_2D);


end;
procedure TAnzeige.setze(punkte: integer);
begin
 self.punkte:=punkte;
end;

end.
