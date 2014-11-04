unit UGegner;

interface
Uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,math,forms,

     UFigur,
     UFunktionen,
     UTypenUndKonstanten;

 Type
  TGegner=class(TFigur)
   protected
    fallen:boolean;
    procedure steuerung;override;                  
    procedure bewegen(richtung:Trichtung);override;
   public
    constructor create(textur:string;Form: TForm;x_,y_:integer);virtual;
    procedure render;override;
    procedure toeten;

 end;
implementation

{ TGegner }

procedure TGegner.bewegen(richtung: Trichtung);
begin
 if richtung=Rrechts
  then nachrechts(v)
  else nachlinks(v+1);
end;

constructor TGegner.create(textur: string; Form: TForm;x_,y_:integer);
begin
  inherited create(Textur,Form);

  y:=y_;
  x:=x_;
  zbreite:=40;
  zhoehe:=40;
  richtung:=Rlinks;
  v:=1;
  fallen:=true;

end;

procedure TGegner.render;
var links:real;
begin

 if not(tod) then
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
  glcolor4ub(255,255,255,255);
  glEnable(GL_TEXTURE_2D);

  mytex.bind();

  links:= texturnr.x*1/6;

  glBegin(GL_QUADS);
   glTexCoord2f(links,1 );

     glVertex2f(-zbreite / 2, zhoehe / 2);

   glTexCoord2f(links,0);

     glVertex2f(-zbreite / 2, -zhoehe / 2);

   glTexCoord2f(links+1/6,0);

     glVertex2f(zbreite / 2, -zhoehe / 2);

   glTexCoord2f(links+1/6,1);

     glVertex2f(zbreite / 2,zhoehe / 2);

  glEnd;
  glDisable(GL_TEXTURE_2D);

  if kform.Active
  then steuerung;
 end;

end;

procedure TGegner.steuerung;
begin
 nachunten(anziehung*2);

  bewegen(richtung);

 if not(kollobj=nil)
  then
   begin
    If Richtung=Rrechts
     Then Richtung:=Rlinks
     Else Richtung:=Rrechts;
    bewegen(Richtung);
   end;

 tod:=y<0;
 if tod
  then y:=-40;

 texturnr.y:=1;
 if richtung=Rlinks
  then texturnr.x:=3
  else texturnr.x:=5;

 If x<0
  Then Richtung:=Rrechts;

End;
procedure TGegner.toeten;
begin
 tod:=true;
 y:=-hoehe;
 x:=-breite;
end;

end.
