unit UHaupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Usound, ComCtrls, ExtCtrls,UPlaylist,UPlayer,Spectrum, Menus;

type
  TFplayer = class(TForm)
    bplaypause: TButton;
    bnext: TButton;
    bprev: TButton;
    bopen: TButton;
    bstop: TButton;
    posi: TScrollBar;
    Zeit: TTimer;
    ls: TScrollBar;
    Bplayliste: TButton;
    Lzeit: TLabel;
    Pspectrum: TPanel;
    TiSpectrum: TTimer;
    PopupMenu1: TPopupMenu;
    ransparenz1: TMenuItem;
    Playlist1: TMenuItem;
    Info1: TMenuItem;
    Beenden1: TMenuItem;
    procedure bopenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure bplaypauseClick(Sender: TObject);
    procedure bstopClick(Sender: TObject);
    procedure bnextClick(Sender: TObject);
    procedure bprevClick(Sender: TObject);
    procedure ZeitTimer(Sender: TObject);
    procedure lsChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BplaylisteClick(Sender: TObject);
    procedure posiScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure TiSpectrumTimer(Sender: TObject);
    procedure Info1Click(Sender: TObject);
    procedure ransparenz1Click(Sender: TObject);
  private
   player:TPlayer;
   Spectrum:TMiniSpectrum;
   Playlist:TFPlayliste;
   count:integer;

   procedure aktualisiereButton;
   procedure aktualisiereZeit;

   procedure aktualisieretitel;



    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Fplayer: TFplayer;

implementation

{$R *.dfm}

function fuehrendeNull(zahl:integer):string;
begin
  if zahl<10
   then result:='0';
  result:=result+inttostr(zahl);
end;

function ZeitFormatiert(zeit:integer):string;
var min,sek,std:integer;
begin
 min:= zeit div 60;
 sek:= zeit mod 60;
 std:= min div 60;
 min:= min - 60 *std;

 if std=0
  then result:=fuehrendeNull(min)+':'+fuehrendeNull(sek)
  else result:=fuehrendeNull(std)+':'+fuehrendeNull(min)+':'+fuehrendeNull(sek);
end;




procedure TFplayer.aktualisiereButton;
begin
 if player.isPlaying
  then bplaypause.Caption:='||'
  else bplaypause.Caption:='>';
end;



procedure TFplayer.aktualisieretitel;
begin
 caption:=player.getSongName;
end;

procedure TFplayer.aktualisiereZeit;
begin
 lZeit.caption:=ZeitFormatiert(Player.SongPosi)+' '+ZeitFormatiert(Player.SongLength);
end;

procedure TFplayer.bnextClick(Sender: TObject);
begin
 player.next;
 aktualisiereZeit;
 aktualisieretitel;
end;

procedure TFplayer.bopenClick(Sender: TObject);
begin
 player.open;
 aktualisieretitel;
end;

procedure TFplayer.BplaylisteClick(Sender: TObject);
begin
 playlist.show;
end;

procedure TFplayer.bplaypauseClick(Sender: TObject);
begin

 player.playPause;


 posi.Min:=0;
 posi.Max:=player.SongLength;
 aktualisiereZeit;
 aktualisieretitel;
 aktualisiereButton;

 zeit.enabled:=true;
 Spectrum.Enabled := true;
 TiSpectrum.enabled:=true;


end;

procedure TFplayer.bprevClick(Sender: TObject);
begin
 player.next;
 aktualisiereZeit;
 aktualisieretitel;
end;

procedure TFplayer.bstopClick(Sender: TObject);
begin
 player.stop;
 
 bplaypause.Caption:='>';

 posi.Position:=0;

 zeit.Enabled:=false;
 Spectrum.Enabled := false;
 TiSpectrum.enabled:=false;

 lZeit.caption:=ZeitFormatiert(0)+' '+ZeitFormatiert(Player.SongLength);
 aktualisieretitel;



end;

procedure TFplayer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 player.destroy;
 canclose:=true;
end;

procedure TFplayer.FormCreate(Sender: TObject);
begin
 player:=TPlayer.create(self);
 Playlist:=TFPlayliste.Create(self,player.getliste);

  
 Spectrum:=TMiniSpectrum.Create(self);


 Spectrum.Style :=ssBlock;
 Spectrum.Parent :=Pspectrum;



end;

procedure TFplayer.Info1Click(Sender: TObject);
begin
 showmessage('Copyrigth 2008- stg7@gmx.de ');
end;

procedure TFplayer.lsChange(Sender: TObject);
begin
 player.setVolume(255-ls.Position);
 BPlaypause.SetFocus;
end;

procedure TFplayer.posiScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
 player.setSongPosi(ScrollPos);
 BPlaypause.SetFocus;
end;



procedure TFplayer.ransparenz1Click(Sender: TObject);
begin
 AlphaBlendValue:= StrtoIntDef( inputbox ('Alpha Wert','','255'),255); 
end;

procedure TFplayer.TiSpectrumTimer(Sender: TObject);
begin
 spectrum.draw;
end;

procedure TFplayer.ZeitTimer(Sender: TObject);
begin                          
 posi.Position:=player.songposi;
 aktualisiereZeit;
 if (player.songposi =player.songLength ) and   (player.songLengthS<>'0')
  then player.next;
end;

end.
