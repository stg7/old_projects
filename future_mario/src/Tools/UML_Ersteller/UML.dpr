program UML;
//
// Name: 	    UML
// Datum:	     20.03.2008
// letzte Änderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Programm zum einfachen erstellen von UML Diagrammen
//                  aus Delphi Klassendeklarationen
//                  - da das Mario Projekt recht umfangreich geworden ist
//                    beschlossen wir ein Programm zu schreiben
//                    welches uns die Erstellung von UML Diagrammen
//                    erleichtert
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//
uses
  Forms,
  UHaupt in 'UHaupt.pas' {FUMLErsteller},
  UUml in 'UUml.pas' {FUML};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFUMLErsteller, FUMLErsteller);
  Application.Run;
end.
