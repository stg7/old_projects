program player;

uses
  Forms,
  UHaupt in 'UHaupt.pas' {Fplayer},
  usound in 'USound\usound.pas',
  fmod in 'USound\fmod.pas',
  fmoddyn in 'USound\fmoddyn.pas',
  fmoderrors in 'USound\fmoderrors.pas',
  fmodpresets in 'USound\fmodpresets.pas',
  fmodtypes in 'USound\fmodtypes.pas',
  spectrum in 'USound\spectrum.pas',
  UPlaylist in 'UPlaylist.pas' {FPlayliste},
  UPlayer in 'UPlayer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFplayer, Fplayer);
  Application.CreateForm(TFPlayliste, FPlayliste);
  Application.Run;
end.
