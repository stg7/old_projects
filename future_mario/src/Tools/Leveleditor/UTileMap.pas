unit UTileMap;
//
// Name: 	    UTileMap
// Datum:	     20.03.2008
// letzte Änderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Fenster zur Auswahl eines Tiles..
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFTileMap = class(TForm)
    ITile: TImage;
    procedure ITileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


implementation

{$R *.dfm}

procedure TFTileMap.ITileMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 caption:=inttostr(x div 32)+' '+inttostr(y div 32);
 close;
end;

end.
