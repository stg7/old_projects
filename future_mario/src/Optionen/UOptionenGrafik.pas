unit UOptionenGrafik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls,

  UFunktionen,
  UOptionen ;

type
  TFOptionenGrafik = class(TForm)
    CBVollbild: TCheckBox;
    CBCrazymodus: TCheckBox;
    BUebernehmen: TButton;
    BAbbrechen: TButton;
    BReset: TButton;
    procedure BUebernehmenClick(Sender: TObject);
    procedure BResetClick(Sender: TObject);
    procedure BAbbrechenClick(Sender: TObject);
   private
    kOptionen:TOptionen;
   public
    constructor create(aowner:TComponent;Optionen:TOptionen);virtual;
  end;


implementation

{$R *.dfm}

{ TFOptionenGrafik }

procedure TFOptionenGrafik.BAbbrechenClick(Sender: TObject);
begin
 close;
end;

procedure TFOptionenGrafik.BResetClick(Sender: TObject);
begin
 CBcrazymodus.Checked:=koptionen.crazymodus;
 CBVollbild.Checked:=koptionen.vollbild;
end;

procedure TFOptionenGrafik.BUebernehmenClick(Sender: TObject);
begin
 koptionen.crazymodus:=CBcrazymodus.Checked;
 koptionen.vollbild:=CBVollbild.Checked;
 koptionen.save;
 close;
end;

constructor TFOptionenGrafik.create(aowner: TComponent; Optionen: TOptionen);
begin
 inherited create(aowner);
 koptionen:=optionen;
 zentriereFormular(self);

 CBcrazymodus.Checked:=koptionen.crazymodus;
 CBVollbild.Checked:=koptionen.vollbild;

end;

end.
