//
// Name: 	    UTypenUndKonstanten
// Datum:	    20.03.2008
// letzte Änderung: 27.03.2008
// Version:  	    0.2
// Zweck:           Sammlung alle Typen und Konstanten in einer separaten Unit 
// 		    zur zentralen Verwaltung	
//
// Programmierer:   Steve Göring, Daniel Renner
// Kontakt:         stg7@gmx.de, daniel26289@yahoo.de
// 
// Copyright:       2008
//

unit UTypenUndKonstanten;

interface

const xToleranz=10;
      yToleranz=6;
      sprunghoehe=100;
      NearClipping = 1;
      FarClipping  = 1000;
      
Const cfg='cfg';
      Info =cfg+'\Info.txt';
      Hilfe =cfg+'\Hilfe.txt';
      KOptionen=cfg+'\optionen.ini';
      
      KTitel='Future'+chr(13)+'    Mario';
      KCopy='von Steve Göring und Daniel Renner'+chr(13)+chr(13)+' Projektarbeit im Fach Angewandte Technik '+chr(13)+chr(13)+' stg7@gmx.de,Daniel26289@yahoo.de '+chr(169)+' 2008 ';
      KPics='pics' ;
      Kmenu=Kpics+'\menu';
      anziehung=2;

Type TPos=record
            x:integer;
            y:integer;
           end;
     TRichtung=(Rstop,Rrechts,Roben,Rlinks,Runten);

implementation

end.
