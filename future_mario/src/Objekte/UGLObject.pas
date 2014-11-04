unit UGLObject;

interface

type TGLObject=class(TObject)
     private

       procedure setx(const Value: real);
       procedure sety(const Value: real);
       procedure setbreite(const Value: integer);
       procedure sethoehe(const Value: integer);


      protected
       zx:real;
       zy:real;
       zbreite,zhoehe:integer;
      public
       procedure render;virtual;abstract;
       property x:real read zx write setx;
       property y:real read zy write sety;
       property breite:integer read zbreite write setbreite;
       property hoehe:integer read zhoehe write sethoehe;

     end;
implementation

{ TGLObject }

procedure TGLObject.setbreite(const Value: integer);
begin
 zbreite:=value;
end;

procedure TGLObject.sethoehe(const Value: integer);
begin
 zhoehe:=value;
end;

procedure TGLObject.setx(const Value: real);
begin
 zx:=value;
end;

procedure TGLObject.sety(const Value: real);
begin
 zy:=value;
end;

end.
