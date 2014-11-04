//
// Name: 	    UImageButton
// Datum:	    22.03.2008
// letzte Änderung: 22.03.2008
// Version:  	    0.8
// Zweck:           BildTasten für Startbildschirm
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


unit UImageButton;

interface

uses ExtCtrls,forms,Controls,Classes;

type TIButton=class(TImage)
      private
       aktivBmp,unaktivBmp:string;
      protected
       procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);override;
       procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);override;
      public
       constructor create(parent: TForm;  nichtaktiv,aktiv: string);virtual;
     end;

implementation

{ TIButton }

constructor TIButton.create(parent: TForm;  nichtaktiv,aktiv: string);
begin
 inherited create(parent);
 self.parent:=parent;
 aktivBmp:=aktiv;
 unaktivBmp:=nichtaktiv;
 picture.LoadFromFile(unaktivBmp);
 width:=picture.Width;
 height:=picture.Height;
end;

procedure TIButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 picture.LoadFromFile(aktivBmp);
end;

procedure TIButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 picture.LoadFromFile(unaktivBmp);
end;

end.
