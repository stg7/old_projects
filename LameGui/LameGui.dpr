program LameGui;

uses
  Forms,
  UHaupt in 'UHaupt.pas' {FLameGui},
  UConsolApp in 'UConsolApp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFLameGui, FLameGui);
  Application.Run;
end.
