unit UOptionenSound;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,

  UFunktionen,
  UOptionen;

type
  TFOptionenSound = class(TForm)
    TBHintergrund: TTrackBar;
    TBGesamt: TTrackBar;
    LGesamt: TLabel;
    LHintergrund: TLabel;
    BUebernehmen: TButton;
    BAbbrechen: TButton;
    LHWert: TLabel;
    LGWert: TLabel;
    BReset: TButton;
    procedure TBHintergrundChange(Sender: TObject);
    procedure TBGesamtChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BResetClick(Sender: TObject);
    procedure BAbbrechenClick(Sender: TObject);
    procedure BUebernehmenClick(Sender: TObject);
   private
    kOptionen:TOptionen;
   public
    constructor create(aowner:TComponent;Optionen:TOptionen);virtual;
  end;


implementation

{$R *.dfm}

procedure TFOptionenSound.BAbbrechenClick(Sender: TObject);
begin
 close;
end;

procedure TFOptionenSound.BResetClick(Sender: TObject);
begin

 TBGesamt.Position:=koptionen.GesamtVolume;
 TBHintergrund.Position:=koptionen.HintergrundVolume;
 TBGesamtChange(nil);
 TBHintergrundChange(nil);
end;

procedure TFOptionenSound.BUebernehmenClick(Sender: TObject);
begin
 koptionen.GesamtVolume:=TBGesamt.Position;
 koptionen.HintergrundVolume:=TBHintergrund.Position;
 koptionen.save;
 close;
end;

constructor TFOptionenSound.create(aowner: TComponent; Optionen: TOptionen);
begin
 inherited create(aowner);
 kOptionen:=Optionen;
 TBGesamt.Position:=koptionen.GesamtVolume;
 TBHintergrund.Position:=koptionen.HintergrundVolume;

end;

procedure TFOptionenSound.FormCreate(Sender: TObject);
begin
 zentriereFormular(self);   
end;


procedure TFOptionenSound.TBGesamtChange(Sender: TObject);
begin
 LGwert.caption:= InttoStr( TBGesamt.Position );
end;

procedure TFOptionenSound.TBHintergrundChange(Sender: TObject);
begin
 LHwert.caption:= InttoStr( TBHintergrund.Position );
end;

end.
