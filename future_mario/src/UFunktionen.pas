//
// Name: 	    UFunktionen
// Datum:	    20.03.2008
// letzte Änderung: 26.03.2008
// Version:  	    0.8
// Zweck:           eine Hilfsfunktionen in einer Unit
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

unit UFunktionen;

interface
 uses Windows,Forms;

 function key_pressed(k1,k2:integer):boolean;overload;
 function key_pressed(k1:integer):boolean;overload;
 procedure zentriereFormular(Form:TForm);
implementation

function key_pressed(k1: integer): boolean;
begin
  result:=(GetKeyState(k1)<0) ;
end;

function key_pressed(k1, k2: integer): boolean;
begin
 result:=key_pressed(k1) or key_pressed(k2);
end;

procedure zentriereFormular(Form:TForm);
begin
 form.left:=(screen.Width - form.width) DIV 2;
 form.top:=(screen.height - form.height) DIV 2;
end;



end.
