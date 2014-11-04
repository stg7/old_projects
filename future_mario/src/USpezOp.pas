//
// Name: 	    USpezOp
// Datum:	    01.02.2008
// letzte Änderung: 27.03.2008
// Version:  	    0.9
// Zweck:           Spezialisiertes OpenGl Fenster zur Ausgabe des Spieles
//
// Programmierer:   Steve Göring, Daniel Renner
// Kontakt:         stg7@gmx.de, daniel26289@yahoo.de
// 
// Copyright:       2008
//

unit USpezOp;      


interface
uses Classes,DGLOpenGL,GLBMP,SysUtils,dialogs,Forms,UFigur,

     UFunktionen,
     UGegner ,
     UopenGlWindow,
     USpieler,
     Umap,
     UGegenstand,
     UListe,
     UMusikImSpiel,
     UMuenze,
     UFOptionen,
     UMenu,
     UAnzeige;

type TSpezOp=class(TFOpenGlwindow)
      private
       musik:TMusikImSpiel;
       Spieler:TSpieler;
       Liste:TListe;
       FigListe:Tliste;
       MuenzenListe:Tliste;
       TempMuenze : TMuenze;
       Map:Tmap;
       GOmap:Tmap;
       Anzeige:TAnzeige;
       kFOptionen:TFOptionen;
       FMenu:TFMenu;
       zvollbild:boolean;
      protected
       procedure Render;override;
       procedure ladeMap(liste,figuren,muenzen:Tliste;name:string);
       procedure MenuOeffnen;
       procedure schliessen(Sender: TObject; var Action: TCloseAction);
       procedure schliessanfrage(Sender: TObject; var CanClose: Boolean);
       procedure vollbild;
       procedure FensterModus;
       procedure einstellungenaktualisieren;
       procedure nachFormCreate;override;
      public
       constructor create(Aowner:TComponent;Foptionen:TFOptionen);virtual;
     end;

implementation

{ TSpezOp }




constructor TSpezOp.create(Aowner: TComponent; Foptionen: TFoptionen);

begin
  inherited create(aowner);

  Anzeige:=TAnzeige.create('pics\zahlen.png');

  onclose:=schliessen;
  onCloseQuery:=schliessanfrage;

  musik:=TMusikImSpiel.create('cfg\config.ini');
  musik.dauerhaftAbspielen('Hintergrund');
  musik.MusikAbspielen('Hintergrund');

  Spieler:=TSpieler.create( 'pics\sm2.png',self,Musik);

  Spieler.onpunkteerhoehen:=Anzeige.setze;
  spieler.onExit:=MenuOeffnen;

  Map:=TMap.create('pics\Background.png',self);


  Liste:=Tliste.create;
  FigListe:=TListe.Create;

  MuenzenListe:=Tliste.Create;



  // Laden der Map
  ladeMap(liste,FigListe,MuenzenListe,FOptionen.Mappack);

  Spieler.kennt(liste);
  //Gegner.kennt(liste);
  Spieler.kenneMuenzen(MuenzenListe);

  Spieler.kenntFiguren(FigListe);

  kFOptionen:=FOptionen;

  zentriereFormular(self);

  FMenu:=TFMenu.create(self,FOptionen);

  zentriereFormular(Fmenu);
end;

procedure TSpezOp.einstellungenaktualisieren;
begin
 musik.lautstaerkeMaster(round(kFoptionen.GesamtVolume*2.55));
 musik.lautstaerkeregeln('Hintergrund',round(kfoptionen.HintergrundVolume*2.55));

 if kFoptionen.Vollbild
  then vollbild
  else
   if zvollbild
    then FensterModus;
end;

procedure TSpezOp.FensterModus;
begin
 width:=651;
 height:=400;
 borderstyle:=bsSizeable;
 zentriereFormular(self);

end;

procedure TSpezOp.ladeMap(liste,figuren,muenzen:Tliste;name:string);
var Gegenstand:TGegenstand;
    Muenze:TMuenze;
    Gegner:TGegner;
    f:textfile;
    zeile:string;
    x,y,texx,texy:integer;
    textur,texturMuenzen:TGLBMP;
begin

 textur:=TGLBMP.Create('pics\tileset2.png');
 textur.ColorKey(255,0,255,0);
 texturMuenzen:=TGLBMP.Create('pics\Coin.png');


 assignFile(f,name);
 reset(f);

 while not eof(f) do
 begin
  readln(f,zeile);
  if not(zeile='')
   then
    begin
     x:=strtoint(copy(zeile,1,POS(',',zeile)-1));
     DELETE(zeile,1,POS(',',zeile));
     y:=strtoint(copy(zeile,1,POS(',',zeile)-1));
     DELETE(zeile,1,POS(',',zeile));

     if zeile='gegner'
      then
       begin
         Gegner:=TGegner.create('pics\BusterBeetle.png',self,x*40,(11-y)*40-20);
         gegner.kennt(liste);
         figuren.fuegehinzu(Gegner);
       end
      else
       if zeile='münze'
        then
         begin
          Muenze:=TMuenze.create(texturMuenzen,self,x*40,(11-y)*40-20);
          muenzen.fuegehinzu(muenze);            
         end
         else
          if POS('map',zeile) > 0
           then   // Objekt für Mapwechsel.. noch nicht vorhanden
           else
            begin
             texx:=strtoint(copy(zeile,1,POS(' ',zeile)-1));
             DELETE(zeile,1,POS(' ',zeile));
             texy:=strtoint(zeile);
             Gegenstand:=TGegenstand.create(textur,self,x*40,(11-y)*40-20,texx,texy);
             Liste.fuegehinzu(Gegenstand);
            end;
    end;
 end;
closefile(f);


end;

procedure TSpezOp.render;
var Gegenstand:TGegenstand;
    i:integer;
    Figur:TFigur;
begin

 if spieler.nichtlebend
  then
   begin

    if not assigned(GoMap)
     then
      begin
       GoMap:=TMap.create('pics\gameover.png',self);
       musik.allestopp;
       musik.dauerhaftAbspielen('GameOver');
       musik.MusikAbspielen('GameOver');
      end;
    GoMap.render;
    if key_pressed(ord(27))
     then close;
   end
  else
   begin

    Anzeige.render; 
    Spieler.render;
    TempMuenze:=TMuenze(MuenzenListe.getelement(0));
    if assigned(tempmuenze)
     then Tempmuenze.bind;

    for i:=0  to MuenzenListe.getLaenge-1 do
    begin
     TempMuenze:=TMuenze(MuenzenListe.getelement(i));
     if assigned(TempMuenze)
      then Tempmuenze.render;
    end;


    for i:= 0 to Figliste.getLaenge-1 do
    begin
     Figur:=TFigur(FigListe.getelement(i));
     if assigned(figur) 
      then Figur.render;
    end;

    Gegenstand:=TGegenstand(Liste.getelement(0));
    if assigned(gegenstand)
     then gegenstand.bind;

    for i:= 0 to liste.getLaenge-1 do
    begin
     Gegenstand:=TGegenstand(Liste.getelement(i));
     if assigned(gegenstand) and gegenstand.imbildschirm 
      then
       begin
        gegenstand.crazy:=kfoptionen.crazymodus;
        Gegenstand.render;
       end;
    end;

    if not kfoptionen.crazymodus
     then map.render;

   end;
end;


procedure TSpezOp.schliessanfrage(Sender: TObject; var CanClose: Boolean);
begin
 if not Fmenu.Visible
  then Fmenu.ShowModal;  
 canclose:=Fmenu.getbeenden;
end;

procedure TSpezOp.schliessen(Sender: TObject; var Action: TCloseAction);
begin
 musik.AlleStopp;           
end;

procedure TSpezOp.vollbild;
begin
 borderstyle:=bsnone;
 left:=0;
 top:=0;
 width:=screen.Width;
 height:=screen.Height;
 zvollbild:=true;
end;

procedure TSpezOp.MenuOeffnen;
begin
 if not Fmenu.Visible
  then Fmenu.ShowModal;      
 einstellungenAktualisieren;
end;

procedure TSpezOp.nachFormCreate;
begin
 einstellungenaktualisieren;
end;

end.
