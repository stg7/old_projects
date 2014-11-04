unit UHaupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFAnagramme = class(TForm)
    MIN: TMemo;
    MOUT: TMemo;
    RadioGroup1: TRadioGroup;
    RGArt: TRadioGroup;
    LEingabe: TLabel;
    Label1: TLabel;
    Binfo: TButton;
    procedure MINChange(Sender: TObject);
    procedure BinfoClick(Sender: TObject);
    procedure RGArtClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FAnagramme: TFAnagramme;

implementation

{$R *.dfm}


function dreh(s:string):string;
begin   //rekursion
 if length(s)<=1
  then result:=s
  else result:= dreh( copy(s,2,length(s)-1)) +s[1] ; 
end;

function verschluesseln(s:string):string;
var gerade,ungerade:string;
  I: Integer;
begin
 gerade:='';
 ungerade:='';

 for I := 1 to length(s) do
  if i mod 2 =0
  then
   begin
    gerade:=gerade+s[i];
   end
  else
   begin
    ungerade:=ungerade+s[i];
   end;

 result:=gerade+ungerade;

end;



function entschluesseln(s:string):string;
var gerade,ungerade,h:string;
  I,g,u: Integer;
begin
 gerade:=copy(s,1,length(s) DIV 2);
 ungerade:=copy(s,length(s) DIV 2+1,length(s));
 h:='';
 g:=1;
 u:=1;

 for I := 1 to length(s) do
  if i mod 2 =0
  then
   begin
    h:=h+gerade[g];
    inc(g);
   end
  else
   begin
    h:=h+ungerade[u];
    inc(u);

   end;

 result:=h;

end;

procedure TFAnagramme.BinfoClick(Sender: TObject);
begin
 showmessage('Programm zum Erzeugen von Anagrammen mit dem "Steve-Verfahren" '+#13#13+'copyright 2008 stg7');
end;

procedure TFAnagramme.MINChange(Sender: TObject);
var
  i: Integer;
  tmp:string;
begin

 mout.Lines.Clear;

 for i := 0 to min.lines.Count - 1 do
  tmp:=tmp+ StringReplace(min.lines[i],' ','',[rfReplaceAll] );



  if rgart.itemindex=0
   then mout.lines.add( verschluesseln(tmp) )
   else mout.lines.add( entschluesseln(tmp) );
 
end;

procedure TFAnagramme.RGArtClick(Sender: TObject);
begin
 MINChange(nil);
end;

end.
