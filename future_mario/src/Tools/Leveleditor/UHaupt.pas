unit UHaupt;
//
// Name: 	    UHaupt
// Datum:	     20.03.2008
// letzte Änderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Hauptfenster des Editors
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,UTileMap,UTypen, Grids;



type
  TFLevelEditorFutureMario = class(TForm)
    BSpeichern: TButton;
    BTilemap: TButton;
    Efeld: TEdit;
    oeffnen: TOpenDialog;
    speichern: TSaveDialog;
    RGAuswahl: TRadioGroup;
    DGMap: TDrawGrid;
    EspaltenPlus: TEdit;
    bweiterespalten: TButton;
    BOeffnen: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BSpeichernClick(Sender: TObject);
    procedure BTilemapClick(Sender: TObject);
    procedure RGAuswahlClick(Sender: TObject);
    procedure DGMapDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DGMapClick(Sender: TObject);
    procedure EspaltenPlusKeyPress(Sender: TObject; var Key: Char);
    procedure bweiterespaltenClick(Sender: TObject);
    procedure BOeffnenClick(Sender: TObject);
  private
    FTilemap:TFTileMap;
    xende:integer;
    yende:integer;
    map:TMap;

    procedure auslesen(Sender: TObject; var Action: TCloseAction);

  public
    { Public-Deklarationen }
  end;

var
  FLevelEditorFutureMario: TFLevelEditorFutureMario;

implementation


{$R *.dfm}

procedure TFLevelEditorFutureMario.FormCreate(Sender: TObject);
begin
 xende:=16*3;
 yende:=11;

 setlength(map,xende+1,yende+1);
 DGMap.rowcount:=yende;
 DGMap.colcount:=xende;

 FTilemap:=TFTilemap.create(self);
 FTilemap.onclose:=auslesen;

end;
procedure TFLevelEditorFutureMario.RGAuswahlClick(Sender: TObject);
begin
 BTilemap.Visible:=RGAuswahl.ItemIndex=3;
 case RGAuswahl.ItemIndex of
  0:Efeld.Text:='';
  1:Efeld.Text:='gegner';
  2:Efeld.Text:='münze';
  4:Efeld.Text:='map :'+inputbox('Map Wechsel','name der Map ','test.mp');
  3:BTilemap.Click;
 end;

end;







procedure TFLevelEditorFutureMario.auslesen(Sender: TObject; var Action: TCloseAction);
begin 
 Efeld.Text:=FTilemap.Caption;
end;

procedure TFLevelEditorFutureMario.BOeffnenClick(Sender: TObject);
var f:textfile;
    zeile,inhalt:string;
    x,y:integer;

begin
 oeffnen.Execute;
 if oeffnen.FileName<>'' then
 begin
  assignfile(f,oeffnen.FileName);
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
      inhalt:=zeile;
      if (x>xende)
       then
        begin
         xende:=x;                
         setlength(map,x+1,yende+1);
         DGMap.ColCount:=x;
        end;
      map[x,y]:=inhalt;
    end;
  end;

 end;
 DGMap.Repaint;
end;

procedure TFLevelEditorFutureMario.BSpeichernClick(Sender: TObject);
var f:textfile;
    z,i:integer;
begin
 speichern.Execute;
 if speichern.FileName<>'' then
  begin
   if pos('.mp',speichern.FileName)>0
    then assignfile(f,speichern.FileName)
    else assignfile(f,speichern.FileName+'.mp');
   rewrite(f);
   for i:=0 to xende do
    for z:=0 to yende do
     if not(map[i,z]='')
      then writeln(f,inttostr(i)+','+inttostr(z)+','+map[i,z]);
   closeFile(f);      
  end;
end;





procedure TFLevelEditorFutureMario.bweiterespaltenClick(Sender: TObject);
begin
 xende:=xende+strtoint(Espaltenplus.Text );
 SetLength(map,xende+1,yende+1 );

 DGMap.Colcount:=xende;
 caption:='spalten: '+inttostr(xende);

end;

procedure TFLevelEditorFutureMario.BTilemapClick(Sender: TObject);
begin
 FTilemap.show;
end;


procedure TFLevelEditorFutureMario.DGMapClick(Sender: TObject);
begin
 map[DGMap.col,DGMap.Row]:=Efeld.Text;
 DGMap.Repaint;
 
end;

procedure TFLevelEditorFutureMario.DGMapDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
 if acol in [0..xende] then
 
 if map[acol,arow] =''
  then DGMap.Canvas.Brush.Color := clwhite
  else
 if map[acol,arow] ='gegner'
  then DGMap.Canvas.Brush.Color := clRed
  else
 if map[acol,arow] ='münze'
  then DGMap.Canvas.Brush.Color := clyellow
  else
 if POS('map',map[acol,arow]) > 0 
  then DGMap.Canvas.Brush.Color := clblack
  else DGMap.Canvas.Brush.Color := clgreen;

 DGMap.Canvas.FillRect(Rect);

 DGMap.Canvas.Brush.Color := clwhite;

end;

procedure TFLevelEditorFutureMario.EspaltenPlusKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#8])
  then
   if key=#13
    then Bweiterespalten.click
    else key:=#0;
end;

end.
