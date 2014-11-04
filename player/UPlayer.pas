unit UPlayer;

interface

uses forms,Classes,Usound,SysUtils,Dialogs   ;

type TPlayer=class(TObject)
      private
       openDlg: TOpenDialog;

       kform:TForm;

       volume:integer;
       liste:TStringList;
       index:integer;
       song:TSound;
       spielen,pause_:boolean;
       procedure pause;
       
      public
       constructor create(form:TForm);
       destructor destroy;

       procedure open;
       procedure playPause;
       procedure stop;

       procedure next;
       procedure prev;

       procedure setVolume(vol:byte);

       function isPlaying:boolean;
       function SongLength: integer;
       function SongLengthS: String;
       function SongPosi: integer;
       procedure setSongPosi(pos:integer);

       function SongPosiS: String; 

       function getliste:TstringList;
       function getSongName:String;

     end;

implementation

{ TPlayer }

constructor TPlayer.create(form:TForm);
begin

 kform:=form;
 openDlg:=TopenDialog.Create(kform);

 opendlg.Filter:='Audio Dateien|*.mp3;*.wav;*.ogg;*.mp4';
 opendlg.Options:=[ofHideReadOnly,ofAllowMultiSelect,ofEnableSizing];


 liste:=TStringlist.create();
 if FileExists(ExtractFilePath(Paramstr(0))+'liste.li')
  then liste.loadfromfile(ExtractFilePath(Paramstr(0))+'liste.li');
 liste.Sorted:=true;


 song:=TSound.create();
 volume:=255;


end;

destructor TPlayer.destroy;
begin
  liste.savetofile(ExtractFilePath(Paramstr(0))+'liste.li');

end;

function TPlayer.getliste: TstringList;
begin
 result:=liste;
end;

function TPlayer.getSongName: String;
begin
 result:=ExtractFileName(liste[index]);
end;

function TPlayer.isPlaying: boolean;
begin
 result:= spielen and not pause_; 
end;

procedure TPlayer.next;
begin
 stop;

 if index+1<liste.Count
  then index:=index+1
  else index:=0;

 playpause;


end;

procedure TPlayer.open;
var i:integer;
begin
 if openDlg.Execute
  then
    for i := 0 to openDlg.Files.Count - 1 do
     if liste.IndexOf(openDlg.Files[i])=-1
      then liste.Add(openDlg.Files[i])
      else showmessage('Datei schon in der Liste') ;  
end;

procedure TPlayer.pause;
begin
  song.pause;
  pause_:=not pause_;
end;

procedure TPlayer.playPause;
begin
 if (not spielen )and (not pause_)
  then
   begin
    if spielen
     then song.stop;
    song.load(liste[index]);
    song.play ;
    spielen:=true;
    song.SetVolume(volume);
   end
  else pause;
end;

procedure TPlayer.prev;
begin
 stop;

 if index-1>0
  then index:=index-1
  else index:=liste.Count-1;

 playpause;
end;

procedure TPlayer.setSongPosi(pos: integer);
begin
 song.setPosition(pos);
end;

procedure TPlayer.setVolume(vol: byte);
begin
 volume:=vol;
 song.setVolume(volume);

end;

function TPlayer.SongLengthS: String;
begin
 result:=song.getlength;
end;

function TPlayer.SongPosi: integer;
begin
 result:=round(strtofloat(song.getposition));
end;

function TPlayer.SongPosiS: String;
begin
  result:=song.getposition;
end;

function TPlayer.SongLength: integer;
begin
 result:=round( strtofloat(song.getlength));
end;

procedure TPlayer.stop;
begin
 song.stop;
 spielen:=false;
 pause_:=false;
end;

end.
