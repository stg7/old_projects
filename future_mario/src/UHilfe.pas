//
// Name: 	    UHilfe
// Datum:	    20.03.2008
// letzte Änderung: 20.03.2008
// Version:  	    0.8
// Zweck:           Hilfe-fenster
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

unit UHilfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  
  UTypenUndKonstanten,
  UFunktionen;
type
  TFHilfe = class(TForm)
    LBHilfe: TListBox;
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TFHilfe.FormCreate(Sender: TObject);
begin
 zentriereFormular(self);
 LBHilfe.Items.LoadFromFile(Hilfe);
end;

end.
