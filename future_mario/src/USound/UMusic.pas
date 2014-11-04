//
// Name: 	          ???
// Datum:			      13.01.2008
// letzte Änderung: 13.01.2008
// Version:  	      0.1
// Zweck:           ??
//
// Programmieren:   Steve Göring
// Kontakt:         ???
// Copyright:       ??
// Änderungen:
//
//

unit UMusic;

interface
uses
  fmod,
  fmodtypes,
  fmoderrors,
  Windows,SysUtils;

type TMusic = class(TObject)
      private
       error:string;
       mdl: PFMusicModule;
       procedure initialize;
      public
       constructor Create;
       procedure play;
       procedure stop;
       procedure pause;
       procedure load(Filename:String);
       procedure close;
       function getcpuusage:string;
       function getrow:string;
       function geterror:string;
     end;

implementation

{ TMusic }

procedure TMusic.close;
begin
  FMUSIC_FreeSong(mdl);
  FSOUND_Close();
end;



constructor TMusic.Create;
begin
 error:='';
end;

function TMusic.getcpuusage: string;
begin
 result:=FloatTostr(FSOUND_GetCPUUsage());
end;

function TMusic.geterror: string;
begin
 result:=error;
end;

function TMusic.getrow: string;
begin
 result:=inttostr(FMUSIC_GetRow(mdl));
end;

procedure TMusic.initialize;
begin
 if not FSOUND_Init(44100, 32, 0) then
  begin
    error:='Fehler bei der Initialisierung'+chr(13)+FMOD_ErrorString(FSOUND_GetError());
    FSOUND_Close();
  end;
end;

procedure TMusic.load(Filename: String);
begin
  if mdl=nil
   then initialize;

  mdl := FMUSIC_LoadSong(PCHAR(Filename)); {can be xm, s3m...}
  if mdl = nil then
  begin
    error:='Fehler beim Laden der Song Datei '+chr(13)+FMOD_ErrorString(FSOUND_GetError());
    FSOUND_Close();
  end;
end;




procedure TMusic.pause;
begin

end;

procedure TMusic.play;
begin
 FMUSIC_PlaySong(mdl);
end;

procedure TMusic.stop;
begin

end;


end.
