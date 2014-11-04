unit UMap;

interface
uses DGLOpenGL,glBMP,SysUtils,DateUtils,Classes,windows,dialogs,math,forms,

     UGLObject;

type TMap=class(TGLObject)
      private
       kform:Tform;
       MapTex:TGLBMP;
       generated:boolean;

      public
       constructor create(Dateiname:string;form:Tform);virtual;
       procedure render;override;
     end;

implementation

{ TMap }

constructor TMap.create(Dateiname:string;form:Tform);
begin
 kform:=form;
 maptex:= TGLBMP.Create(Dateiname);
end;

procedure TMap.render;
begin

  glMatrixMode(GL_MODELVIEW);

  if not(generated) then
   begin
    maptex.GenTexture();
    generated:=true;
   end;

     glLoadIdentity;
     glEnable(GL_TEXTURE_2D);
     glTranslatef(0,0,0);
     maptex.Bind;

     glBegin(GL_QUADS);
      glTexCoord2f( 0,1  );
       glVertex2f(0, 480);
      glTexCoord2f(0       ,0);
       glVertex2f(0 , 0);
      glTexCoord2f(1,0  );
       glVertex2f(640, 0);
      glTexCoord2f(1,1);
       glVertex2f(640,480);
     glEnd;

 glDisable(GL_TEXTURE_2D);


end;
end.
