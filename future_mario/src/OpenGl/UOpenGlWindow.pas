unit UOpenGlWindow;
// Stg7

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DateUtils, DGLOpenGL,

  UTypenUndKonstanten;



type
  TFOpenGlWindow = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IdleHandler(Sender: TObject; var Done: Boolean)  ;
  private
    { Private-Deklarationen }
    start_zeit:integer;

    procedure SetupOpenGL;

    procedure ErrorHandler;
  protected

    procedure Render;virtual;abstract;
    procedure nachFormCreate;virtual;abstract;

  public
    { Public-Deklarationen }
    DC                                : HDC;  //Handle auf Zeichenfläche
    RC                                : HGLRC;//Rendering Context

  end;

var
  FOpenGlWindow: TFOpenGlWindow;

implementation

{$R *.dfm}

procedure TFOpenGlWindow.FormCreate(Sender: TObject);
begin
  DC:= GetDC(Handle);
  if not InitOpenGL then Application.Terminate;
  RC:= CreateRenderingContext( DC,
                               [opDoubleBuffered],
                               32,
                               24,
                               0,0,0,
                               0);
  ActivateRenderingContext(DC, RC);
  SetupOpenGL;
  Application.OnIdle := IdleHandler;

  start_zeit:=millisecondof(time);
  nachFormCreate;
end;

procedure TFOpenGlWindow.SetupOpenGL;
begin
  glEnable(GL_DEPTH_TEST);          //Tiefentest aktivieren
  glEnable(GL_CULL_FACE);           //Backface Culling aktivieren
  glEnable(GL_TEXTURE_2D); // Texturen aktiviren!


  glEnable(GL_ALPHA_TEST);
  glAlphaFunc(GL_GREATER, 0.1);


  glClearColor( 0.0, 0.0, 0.0, 0.0 );

end;

procedure TFOpenGlWindow.FormResize(Sender: TObject);
var tmpBool : Boolean;
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;

  glOrtho(0,640,0,480,-128,128);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  IdleHandler(Sender, tmpBool);
end;




procedure TFOpenGlWindow.FormDestroy(Sender: TObject);
begin
  DeactivateRenderingContext;
  DestroyRenderingContext(RC);
  ReleaseDC(Handle, DC);
end;


procedure TFOpenGlWindow.ErrorHandler;
begin
 self.Caption := self.Caption+' '+gluErrorString(glGetError);

end;
procedure TFOpenGlWindow.IdleHandler(Sender: TObject; var Done: Boolean);
begin

  if (abs(start_zeit-millisecondof(time) )>=25) then
   begin
    start_zeit:=millisecondof(time);

    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity;
    glViewport(0,0,ClientWidth,ClientHeight);
    glOrtho(0,640,0,480,-128,128); // orthogonale Projektion

    Render;

    SwapBuffers(DC);
  
  end;


  Done:= false;
end;


end.
