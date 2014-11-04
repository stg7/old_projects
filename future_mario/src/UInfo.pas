//
// Name: 	    UInfo
// Datum:	    19.03.2008
// letzte Änderung: 19.03.2008
// Version:  	    0.8
// Zweck:           Informationsfenster
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


unit UInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,

  UTypenUndKonstanten,
  UFunktionen ;
type
  TFInfo = class(TForm)
    LBInfo: TListBox;
    procedure FormCreate(Sender: TObject);
  end;


implementation

{$R *.dfm}

procedure TFInfo.FormCreate(Sender: TObject);
begin
 zentriereFormular(self);
 LBInfo.Items.LoadFromFile(Info);
end;

end.
