//
// Name: 	    UOptionen
// Datum:	    20.03.2008
// letzte Änderung: 26.03.2008
// Version:  	    0.8
// Zweck:           OptionsFormular
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

unit UFOptionen;

interface

uses Classes,dialogs,

    UOptionen,
    UOptionenSound,
    UOptionenGrafik;

type TFOptionen=class(TObject)

      private
       Optionen:TOptionen;
       FSound:TFOptionenSound;
       FGrafik:TFOptionenGrafik;

       function getcrazymodus: boolean;
       function getGesamtlautstaerke: integer;
       function getHintergrundlautstaerke: integer;
       function getsetmappack: string;
       function getvollbild: boolean;

      public
       constructor create(aowner:Tcomponent;filename:string);virtual;
       procedure showSound;
       procedure showGrafik;

       property HintergrundVolume:integer read getHintergrundlautstaerke;
       property GesamtVolume:integer read getGesamtlautstaerke;
       property Vollbild:boolean read getvollbild;
       property crazymodus:boolean read getcrazymodus;
       property Mappack:string read getsetmappack;
     end;

implementation

{ TFOptionen }

constructor TFOptionen.create;
begin
 inherited create;
 Optionen:=TOptionen.create(filename);

 FSound:=TFOptionenSound.create(aowner,Optionen);
 FGrafik:=TFOptionenGrafik.create(aowner,Optionen);
 
end;

function TFOptionen.getcrazymodus: boolean;
begin
 result:=optionen.crazymodus;
end;

function TFOptionen.getGesamtlautstaerke: integer;
begin
 result:=optionen.GesamtVolume;
end;

function TFOptionen.getHintergrundlautstaerke: integer;
begin
 result:=optionen.HintergrundVolume;
end;

function TFOptionen.getsetmappack: string;
begin
 result:=optionen.Mappack;
end;

function TFOptionen.getvollbild: boolean;
begin
 result:=optionen.Vollbild;
end;

procedure TFOptionen.showGrafik;
begin         
 FGrafik.showmodal;
end;

procedure TFOptionen.showSound;
begin
 Fsound.showmodal;
end;

end.
