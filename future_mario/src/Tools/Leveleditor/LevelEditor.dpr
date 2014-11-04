program LevelEditor;
//
// Name: 	    LevelEditor f�r Future Mario
// Datum:	     20.03.2008
// letzte �nderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Erstellung der Mario Levels
//
// Programmierer:   Daniel Renner, Steve G�ring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//
uses
  Forms,
  UHaupt in 'UHaupt.pas' {FLevelEditorFutureMario},
  UTileMap in 'UTileMap.pas' {FTileMap},
  Utypen in 'Utypen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFLevelEditorFutureMario, FLevelEditorFutureMario);
  Application.Run;
end.
