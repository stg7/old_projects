program NeroAacGui;

uses
  Forms,
  Uhaupt in 'Uhaupt.pas' {FNeroAacGui};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFNeroAacGui, FNeroAacGui);
  Application.Run;
end.
