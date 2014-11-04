//
// Name: 	    UMenu
// Datum:	    26.03.2008
// letzte Änderung: 26.03.2008
// Version:  	    0.1
// Zweck:           Spielmenü
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,

  UFOptionen;

type
  TFMenu = class(TForm)
    BSound: TButton;
    BGrafik: TButton;
    BBeenden: TButton;
    GBEinstellungen: TGroupBox;
    Bweiter: TButton;
    procedure BBeendenClick(Sender: TObject);
    procedure BSoundClick(Sender: TObject);
    procedure BweiterClick(Sender: TObject);
    procedure BGrafikClick(Sender: TObject);
   private
    kfoptionen:TFoptionen;
    kform:TForm;
    beenden:boolean;
   public
    function getbeenden:boolean;
    constructor create(aowner:Tcomponent;foptionen:TFoptionen);
  end;


implementation

{$R *.dfm}

{ TFMenu }

procedure TFMenu.BBeendenClick(Sender: TObject);
begin
 beenden:=true;
 kform.close;
 close;
end;

procedure TFMenu.BGrafikClick(Sender: TObject);
begin
 kfoptionen.showGrafik;
end;

procedure TFMenu.BSoundClick(Sender: TObject);
begin
 kfoptionen.showSound;
end;

procedure TFMenu.BweiterClick(Sender: TObject);
begin
 close;
end;

constructor TFMenu.create(aowner: Tcomponent; foptionen: TFoptionen);
begin
 inherited create(aowner);
 kform:=TForm(aowner);
 kfoptionen:=foptionen;   
end;

function TFMenu.getbeenden: boolean;
begin
 result:=beenden;
end;

end.
