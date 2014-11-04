//
// Name: 	    UHaupt
// Datum:	    01.02.2008
// letzte Änderung: 26.01.2008
// Version:  	    0.8
// Zweck:           Hauptfenster
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


unit UHaupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls, ImgList, ExtCtrls, Buttons, Menus,

  USpezOp,
  UHilfe,
  UInfo,
  UIntro,
  UImageButton,
  UFunktionen,
  UTypenUndKonstanten,
  UFOptionen;

type
  TFSuperM = class(TForm)
    PStart: TPanel; // dient zur Ausrichtung des Menüs
    IHintergrund: TImage;
    IMario: TImage;
    Hauptmenue: TMainMenu;
    MSpiel: TMenuItem;
    MOptionen: TMenuItem;
    MHilfe: TMenuItem;
    MInfos: TMenuItem;
    MStarten: TMenuItem;
    MBeenden: TMenuItem;
    MSound: TMenuItem;
    MGrafik: TMenuItem;
    MIntro: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure MBeendenClick(Sender: TObject);
    procedure MHilfeClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure MSoundClick(Sender: TObject);
    procedure MIntroClick(Sender: TObject);
    procedure MGrafikClick(Sender: TObject);

  private
    { Private-Deklarationen }
    x,y:integer; 

    IStart:TIButton;
    IInfo:TIButton;
    IHilfe:TIButton;
    IBeenden:TIButton;

    OpenglWindow:TSpezOp;
    FInfo :TFInfo;
    FHilfe:TFHilfe;
    FIntro:TFintro;

    FOptionen:TFOptionen;

    procedure verstecken;
    procedure zeigen;
    procedure introende(Sender: TObject; var Action: TCloseAction);
 

  public
    { Public-Deklarationen }
  end;

var
  FSuperM: TFSuperM;

implementation

{$R *.dfm}

procedure TFSuperM.MBeendenClick(Sender: TObject);
begin
 Close;
end;

procedure TFSuperM.MGrafikClick(Sender: TObject);
begin
 FOptionen.showGrafik;
end;

procedure TFSuperM.MHilfeClick(Sender: TObject);
begin
 if not assigned(FHilfe)
  then FHilfe:=TFHilfe.Create(self);
 FHilfe.Show;
end;

procedure TFSuperM.InfoClick(Sender: TObject);
begin
 if not assigned(FInfo)
  then FInfo:=TFInfo.Create(self);
 FInfo.Show;
end;

procedure TFSuperM.MIntroClick(Sender: TObject);
begin
 FIntro.reset;
 FIntro.Show;
end;

procedure TFSuperM.introende(Sender: TObject; var Action: TCloseAction);
begin
 zeigen;
end;

procedure TFSuperM.MSoundClick(Sender: TObject);
begin
 FOptionen.showSound;
end;

procedure TFSuperM.StartClick(Sender: TObject);
begin
 if assigned(OpenGlWindow)
  then OpenGlWindow.free;
 OpenGlWindow:=TSpezOp.create(self,FOptionen);
 OpenGlWindow.show;
end;

procedure TFSuperM.verstecken;
begin
 x:=left;
 y:=top;
 hide;
 left:=-width;
 top:=-height;
end;

procedure TFSuperM.zeigen;
begin
 show;
 left:=x;
 top:=x;

end;

procedure TFSuperM.FormCreate(Sender: TObject);
begin

 with ihintergrund do
 begin
  Left:=0;
  top:=0;
  Picture.LoadFromFile(Kmenu+'\Hintergrund.bmp');
  Width:=Picture.Width;
  height:=Picture.Height;
  self.Width:=width;
  self.height:=height;
 end;

 IStart:=TIButton.create(self,Kmenu+'\start.bmp',Kmenu+'\start_aktiv.bmp');
 with IStart do
 begin
  OnClick:=StartClick;
  Left:=PStart.Left;
  Top:=PStart.Top;
 end;

 IInfo:=TIButton.create(self,Kmenu+'\info.bmp',Kmenu+'\info_aktiv.bmp');;
 with IInfo do
 begin
  OnClick:=InfoClick;
  Left:=Istart.left-100;
  Top:=Istart.Top+100;
 end;

 with imario do
 begin
  Left:=IInfo.left+IInfo.Width+30;
  top:=IInfo.top-20;
  Picture.LoadFromFile(Kmenu+'\mario.bmp');
  picture.Bitmap.TransparentColor:=rgb(255,255,255);
  Width:=Picture.Width;
  height:=Picture.Height;
 end;

 IHilfe:=TIButton.create(self,Kmenu+'\hilfe.bmp',Kmenu+'\hilfe_aktiv.bmp');;
 with IHilfe do
 begin
  OnClick:=MHilfeClick;
  Left:=Istart.left-100;
  Top:=Istart.Top+200;
 end;

 IBeenden:=TIButton.create(self,Kmenu+'\beenden.bmp',Kmenu+'\beenden_aktiv.bmp');
 with IBeenden do
 begin
  OnClick:=MBeendenClick;
  Left:=Istart.left;
  Top:=Istart.Top+300;
 end;
 zentriereFormular(self);
 verstecken;

 FIntro:=TFIntro.create(self);

 Fintro.OnClose:=introende;
 FIntro.Show;

 FOptionen:=TFOptionen.create(self,koptionen);
 
end;

end.
