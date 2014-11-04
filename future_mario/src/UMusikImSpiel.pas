//
// Name: 	    UMusikImSpiel
// Datum:	    20.01.2008
// letzte Änderung: 26.01.2008
// Version:  	    0.8
// Zweck:           Zum abspielen der Musik in diversen Situationen
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//




unit UMusikImSpiel;
   // Die unit dient später zum einbinden in das Spiel da das Formular nur zu testzwecken da ist
interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles,
  
  USound;



type
   // Datenstruktur zum aufnehmen der Sounddateien und deren Namen
  TMusikdateien = Array OF record
                            Sound     : TSound;
                            Soundname : string;
                           end;

  //Klasse mit  Methoden zum abspielen der Sounds
 TMusikImSpiel = class(TObject)

  private
   // Musikdaten aufnehmen
   Musikdateien : TMusikdateien;
   // Lautstärke für alle Sound Daten festlegen
   Lautstaerke  : byte;
   // KonfigurationsIni Datei , Pfad und Name
   CFG:String;

   // initialisierung
   procedure MusikLaden;
  public
   // lädt alle musikdateien in das  array musikdateien
   // @param cfg: Pfad+Name Cfg Datei für Sound 
   Constructor create(cfg:String);virtual;

   // spielt die sounds abspielen einzeln ab
   procedure MusikAbspielen(Name : string);
   // stopt die einzlnen Sounds
   Procedure MusikStop(Name : string);
   //pausiert die einzelnen Sounds
   Procedure MusikPause(Name : string);
   //stoppen aller Sound
   Procedure AlleStopp;
   //pausiert alle Sounds
   Procedure AllePause;
   //ermitteln der Lautstärke
   function getLautstaerke:byte;
   // lautstärke für alle lieder festlegen
   Procedure LautstaerkeRegeln(Volume:byte);overload;
   // dauerPlay eines Musikstückes
   procedure dauerhaftAbspielen(name:string);
   // lautstärke eines einzelnen Liedes ändern
   procedure lautstaerkeregeln(name:string;Volume:byte);overload;
   // lautstärke aller
   procedure lautstaerkeMaster(vol:byte);


end;

implementation

{ TMusikImSpiel }

procedure TMusikImSpiel.AllePause;
Var i : integer;
begin
 // durhsucht das array und paussiert dann die lieder nacheinander einzeln,
 //hier muss lenght-1 da die Letzte "Zelle" nicht belegt ist und der pause befehl darauf ein fehler verusachen würde
 For i:=0 To length(Musikdateien)-1 DO
  Musikdateien[i].sound.pause;
end;

procedure TMusikImSpiel.AlleStopp;
VAR i : integer;
begin
 // durhsucht das array und stoppt dann die lieder nacheinander einzeln,
 //hier muss lenght-1 da die Letzte "Zelle" nicht belegt ist und der stopp befehl darauf ein fehler verusachen würde
 For i:=0 To length(Musikdateien)-1 DO
  Musikdateien[i].sound.stop;
end;


constructor TMusikImSpiel.create;
begin
 inherited Create();    //Construktor der SuperKlasse
   
 lautstaerke:=255;    // aus ner Ini Lesen!
 self.CFG:=Cfg;

 MusikLaden;
 
end;

function TMusikImSpiel.getLautstaerke: byte;
begin
 result:=Lautstaerke;
end;

procedure TMusikImSpiel.LautstaerkeRegeln(Volume:byte);
VAR i : integer;
begin
 Lautstaerke:=volume;

 For i:=0 To length(Musikdateien)-1 DO
  Musikdateien[i].sound.setVolume(volume);

end;
procedure TMusikImSpiel.lautstaerkeregeln(name:string;Volume:byte);
var i : integer;
begin
 For i:=0 To length(Musikdateien)-1 DO
  if Musikdateien[i].Soundname=name
   then Musikdateien[i].sound.setVolume(Volume);
end;


procedure TMusikImSpiel.MusikAbspielen(Name: string);
 var i:integer;
begin
// Hier wird unsere Ini datei durchgegangen und sobald er den Soundnamen findet spielt er ihn ab.
 for i:=0 to length(Musikdateien)-1 do
  if Musikdateien[i].Soundname=name
   then Musikdateien[i].sound.play;
end;

procedure TMusikImSpiel.MusikLaden;

var i : integer;
    Ini: TIniFile;
    Musikliste:TStringList;
    Dateiname:string;
begin
  Musikliste:=TStringlist.create();
  ini:=nil;
  try
    Ini:=TIniFile.Create(CFG);
    Ini.ReadSection('Soundfiles',Musikliste);  // Hier wird eine Sektion in der Ini datei ausgelesen und in der Liste aabgelegt

    SetLength(Musikdateien,Musikliste.count); //Hier legen wir die Länge des Array fest , da unser dynamisches Array am Anfang die Länge 0 hatte


    for i:=0 to Musikliste.Count-1 do
    begin         // Diese Schleife kreiiert die einzelnen Instanzen des array's
     Musikdateien[i].sound := TSound.Create;
     Musikdateien[i].Soundname:=Musikliste[i];  //Nun wird jeder "Zelle" unseres Array's ein Name zugeweisen (im record sound name werden die Soundnamen zugewiesen)

     Dateiname:=Ini.ReadString('Soundfiles',Musikliste[i],'');//Nun setzten wir den Dateiname indem wir die Musikliste auslesen  damit später die Sound über den Dateinamen gelsen werden können
     Musikdateien[i].sound.load('Soundfiles\'+Dateiname); //Letztendlich müssen wir noch die eigentlichen sounds in unseren Array mit dem record aufnhemen
    end;


  finally    // im Finally part werden anweisungen ausgeführt die bei jeder try anweisung ausgeführt werden, egal was die try anweisung ergibt
    Ini.Free;    // freigeben des Speichers des Zeigers auf die Ini - Datei
    Musikliste.Free;  // Nun muss noch der Speiher der Musikliste freigegebenem werden
  end;

end;

procedure TMusikImSpiel.MusikPause(Name: string);
VAR i : integer;
begin
 //hier durchsuchen wir nun unsere Array nach dem übergebenen namen um dann auch die musik anhalten zu können um sie später weiterlaufen zu lassen
 For i:=0 To length(Musikdateien)-1 Do
  if Musikdateien[i].Soundname=name
   then Musikdateien[i].sound.pause;
end;

procedure TMusikImSpiel.MusikStop(Name: string);
Var i : integer;
begin
 // Druchgehe des Array zum finden des Dateinamen und stoppen des Sounds
 For i:=0 To length(Musikdateien) Do
  if Musikdateien[i].Soundname=name
   then Musikdateien[i].sound.stop;
end;


procedure TmusikImSpiel.dauerhaftAbspielen;
VAR i : integer;
begin
 //hier durchsuchen wir nun unsere Array nach dem übergebenen namen um dann auch die musik anhalten zu können um sie später weiterlaufen zu lassen
 For i:=0 To length(Musikdateien)-1 Do
  if Musikdateien[i].Soundname=name
   then Musikdateien[i].sound.dauerplay;

end;
procedure TmusikImSpiel.lautstaerkeMaster(vol:byte);
begin
 TSound.SetMasterVol(vol);
end;


end.
 