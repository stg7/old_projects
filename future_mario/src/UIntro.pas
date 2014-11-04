//
// Name: 	    UIntro
// Datum:	    22.03.2008
// letzte Änderung: 25.03.2008
// Version:  	    0.8
// Zweck:           SpielIntro
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


unit UIntro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ImgList,

  UFunktionen,
  UTypenUndKonstanten;

type
  TFIntro = class(TForm)
    Timer: TTimer;
    LTitel: TLabel;
    PAusgabe: TPanel;
    LCopy: TLabel;
    IIcon: TImage;
    ILAnimation: TImageList;
    PAbbrechen: TPanel;
    procedure TimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PAbbrechenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PAbbrechenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
   lauf:integer;
  public
   procedure reset; 
  end;



implementation

{$R *.dfm}

procedure TFIntro.FormCreate(Sender: TObject);
begin
 zentriereFormular(self);
 LTitel.Caption:=Ktitel;
 LCopy.caption:=KCopy;
 reset;
end;

procedure TFIntro.PAbbrechenMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 (sender as Tpanel).Bevelouter:=bvlowered;
 (sender as Tpanel).color:=clMenuHighlight;
end;

procedure TFIntro.PAbbrechenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 (sender as Tpanel).Bevelouter:=bvraised;
 (sender as Tpanel).color:=clGradientActiveCaption;
 timer.Enabled:=false;
 close;
end;

procedure TFIntro.reset;
begin
 lauf:=0;
 timer.Enabled:=true;
end;

procedure TFIntro.TimerTimer(Sender: TObject);
var Icon:TIcon;
begin
  Icon:=TIcon.Create();
  ILAnimation.GetIcon(lauf,Icon);
  IIcon.Picture:=TPicture(Icon);
  Icon.free;
  inc(lauf);
  if lauf=ILAnimation.Count
   then
    begin
      close;
      timer.Enabled:=false;
    end;
end;

end.
