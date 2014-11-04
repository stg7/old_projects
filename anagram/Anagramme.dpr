program Anagramme;

uses
  Forms,
  UHaupt in 'UHaupt.pas' {FAnagramme};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFAnagramme, FAnagramme);
  Application.Run;
end.
