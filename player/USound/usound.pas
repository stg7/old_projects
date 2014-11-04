//
// Name: 	          USound
// Datum:			      13.01.2008
// letzte Änderung: 20.01.2008
// Version:  	      0.2
// Zweck:           Soundausgabe von Mp3 Files & Co  , für Supermario
//
// Programmieren:   Steve Göring
// Kontakt:         stg7@gmx.de
// Copyright:       2008
// Änderungen:
//              Kommentierung des Interfaces
//
//

unit USound;
// Sound Ausgabe mittels FMOD!
interface

uses
  fmod,
  fmodtypes,
  fmoderrors,
  Windows,SysUtils;

type TError = procedure of object; // Fehler ereignis
     Tchangestatus=procedure of object;// Statuswechselereignis
     
     // Klasse zur Soundausgabe
     // unterstüzt werden dabei mp3, ogg, und andere
     // für midi Ähnliche Formate bitte UMusic benutzen  
     TSound = class(TObject)
      private
       // Dateiname der abzuspielenden Sound Datei (mp3,ogg ...) 
       filename:string;
       // Fehlermeldung
       errorstr:string;
       // Statusmeldung
       status:string;
       // Stream der Sound Datei
       stream: PFSoundStream;
       // Kanal der Sound Datei (siehe FMOD)
       channel:integer;
       // Fehlerereignis
       doerror:TError;
       // Statusänderungsereignis
       changestatus:Tchangestatus;
       // True wenn die Initialierung bereits erfolgt ist      
       initialized:boolean;
       // lautstärke
       volume:integer;
       // initialisieren von der Sound Ausgabe
       procedure initialize;
       // Statusmeldung hinzufügen 
       // @param st: Status der hinzugefügt werden soll
       procedure addstatus(st:string);
       // Fehlermeldung erzeugen
       // @param e : Fehler
       procedure error(e:string);
      public
       // OnError Event 
       property OnError :TError write doerror;
       // OnChangestatus
       property Onchangestatus :Tchangestatus write changestatus;
       // ermittelt den Status
       function getstatus:string;
       // Kontruktor
       constructor Create;
       // Abspielen
       procedure play;
       // dauerhaftes Abspielen der Musik
       procedure dauerplay;
       // Soundausgabe stoppen
       procedure stop;
       // Soundausgabe pausieren
       procedure pause;
       // Laustärke setzen 
       // @param vol: Lautstärke
       procedure setVolume(vol:byte);
       // Datei Laden
       // @param Filename: Dateiname der Soun Datei
       procedure load(Filename:String);
       // Sound ausgabe beenden und Datei schließen
       procedure close;
       // CPU Auslastung ermitteln
       function getcpuusage:string;
       // momentane Position in s
       function getposition:string;
       // Länge der Sounddatei in s
       function getlength:string;
       // Errorstring zurückgeben
       function geterror:string;
       // Songposition setzen
       // @param posi: neue Position in s im lied
       procedure setPosition(pos:integer);

       class procedure SetMasterVol(vol:byte);


     end;
               

implementation




{ TSound }

procedure TSound.close;
begin
 FSOUND_Stream_Close(stream);
 FSOUND_Close();
end;

constructor TSound.Create;
begin
 errorstr:='';
 status:='';
 initialized:=false;
end;

procedure TSound.dauerplay;
begin
  stream := FSOUND_Stream_Open(PChar(Filename), FSOUND_LOOP_NORMAL, 0, 0);
  if not assigned(stream)
   then error('Fehler beim Laden der Song Datei')
   else addstatus('load '+Filename+' ok' );
end;

function TSound.getcpuusage: string;
begin
  result:=FloatTostr(FSOUND_GetCPUUsage());
end;

function TSound.geterror: string;
begin
   result:=errorstr;
end;

function TSound.getposition: string;
begin
 result:=inttostr(FSOUND_Stream_GetTime(stream) div 1000);
end;

procedure TSound.initialize;
begin
  FSOUND_SetOutput(FSOUND_OUTPUT_WINMM);
  FSOUND_SetDriver(0);  // Standart Soundkarte als Ausgabegerät

  if not FSOUND_Init(44100, 16, 0)
   then error('Fehler bei der Initialisierung')
   else
    begin
     initialized:=true;
     addstatus('initialized') ;
    end;
end;

procedure TSound.load(Filename: String);
begin
  self.filename:=filename;
  if not initialized
   then initialize;

  stream := FSOUND_Stream_Open(PChar(Filename), FSOUND_LOOP_OFF, 0, 0);
  if not assigned(stream)
   then error('Fehler beim Laden der Song Datei')
   else addstatus('load '+Filename+' ok' );

end;

procedure TSound.pause;
begin
 FSOUND_SetPaused(channel, not FSOUND_GetPaused(channel));
 if FSOUND_GetPaused(channel)
  then addstatus('pause')
  else addstatus('start');

end;

procedure TSound.play;

begin

  channel := FSOUND_Stream_Play(FSOUND_FREE, stream);

  if channel < 0
   then error('Fehler beim Abspielen der Song Datei')
   else addstatus('play') ;
end;

procedure TSound.addstatus(st: string);
begin
 if not(status='')
  then status:=status+','+st
  else status:=st;
 if assigned(changestatus)
  then changestatus;
end;

procedure TSound.stop;
begin
 if FSOUND_Stream_Stop(stream)
  then addstatus('stop'); 
end;

function TSound.getstatus: string;
begin
 result:=status;
end;

procedure TSound.error(e: string);
begin
 errorstr:=e+' , '+FMOD_ErrorString(FSOUND_GetError()) ;
 FSOUND_Close();
 if Assigned(doError)
  then doError;
end;

procedure TSound.setPosition(pos: integer);
begin
 FSOUND_Stream_SetTime(stream,pos*1000);
end;

procedure TSound.setVolume(vol: byte);
begin
 FSOUND_SetVolume(channel,vol);// FSOUND_SetSFXMasterVolume(vol);
end;

function TSound.getlength: string;
begin
 result:=inttostr(FSOUND_Stream_GetLengthMs(stream)DIV 1000)
end;

class procedure TSound.SetMasterVol(vol:byte);
begin
 FSOUND_SetSFXMasterVolume(vol);
end;


end.
