program FutureMario;
//
// Name: 	          FutureMario
// Datum:	          20.01.2008
// letzte Änderung: 29.03.2008
// Version:  	      0.8
// Zweck:           SuperMario Clone
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

uses
  Forms,
  dglOpenGL in 'OpenGl\dglOpenGL.pas',
  glBMP in 'OpenGl\glBMP.pas',
  libPNG in 'OpenGl\libPNG.pas',
  fmod in 'USound\fmod.pas',
  fmoddyn in 'USound\fmoddyn.pas',
  fmoderrors in 'USound\fmoderrors.pas',
  fmodpresets in 'USound\fmodpresets.pas',
  fmodtypes in 'USound\fmodtypes.pas',

  // eigene Units
  usound in 'USound\usound.pas',
  UMusic in 'USound\UMusic.pas',
  UOpenGlWindow in 'OpenGl\UOpenGlWindow.pas' {FOpenGlWindow},
  USpieler in 'Objekte\USpieler.pas',
  UMap in 'Objekte\UMap.pas',
  UGLObject in 'Objekte\UGLObject.pas',
  UGegenstand in 'Objekte\UGegenstand.pas',
  UListe in 'Objekte\UListe.pas',
  UGegner in 'Objekte\UGegner.pas',
  UFunktionen in 'UFunktionen.pas',
  UMusikImSpiel in 'UMusikImSpiel.pas',
  UHaupt in 'UHaupt.pas',
  USpezOp in 'USpezOp.pas',
  UFigur in 'Objekte\UFigur.pas',
  UHilfe in 'UHilfe.pas' {FHilfe},
  UInfo in 'UInfo.pas' {FInfo},
  UMuenze in 'Objekte\UMuenze.pas',
  UTypenUndKonstanten in 'UTypenUndKonstanten.pas',
  UImageButton in 'UImageButton.pas',
  UIntro in 'UIntro.pas' {FIntro},
  UOptionenSound in 'Optionen\UOptionenSound.pas' {FOptionenSound},
  UOptionen in 'Optionen\UOptionen.pas',
  UOptionenGrafik in 'Optionen\UOptionenGrafik.pas' {FOptionenGrafik},
  UFOptionen in 'UFOptionen.pas',
  UMenu in 'UMenu.pas' {FMenu},
  UAnzeige in 'Objekte\UAnzeige.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TFSuperM, FSuperM);
  Application.Run;
end.
