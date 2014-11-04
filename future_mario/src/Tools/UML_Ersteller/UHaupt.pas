unit UHaupt;
//
// Name: 	    UHaupt
// Datum:	     26.03.2008
// letzte Änderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Hauptfenster für Uml Ersteller
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,UUml;

type
  TFUMLErsteller = class(TForm)
    MQuell: TMemo;
    Berstellen: TButton;
    BReset: TButton;
    procedure BerstellenClick(Sender: TObject);
    procedure BResetClick(Sender: TObject);
  private
   UML:TFUML;
  end;

var
  FUMLErsteller: TFUMLErsteller;

implementation

{$R *.dfm}

procedure TFUMLErsteller.BerstellenClick(Sender: TObject);
var liste:TStrings;
begin
 UML:=TFUML.create(self,TStringlist(mquell.lines));
 UML.Show;
end;

procedure TFUMLErsteller.BResetClick(Sender: TObject);
begin
 mquell.Lines.Clear;
end;

end.
