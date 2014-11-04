unit UUml;
//
// Name: 	    UUML
// Datum:	     20.03.2008
// letzte Änderung: 29.03.2008
// Version:  	    0.8
// Zweck:           Uml Diagramm / Fenster
//
// Programmierer:   Daniel Renner, Steve Göring
// Kontakt:         daniel26289@yahoo.de, stg7@gmx.de
// Copyright:       2008
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFUML = class(TForm)
    LBMethoden: TListBox;
    LBAttribute: TListBox;
  private
    zcode:TStringList;
  public
    constructor create(aowner: tcomponent; code: TStringList);virtual;
  end;


implementation

{$R *.dfm}

{ TFUML }

function entferneleerzeichen(s:string):string;
begin
 result:=stringreplace(s,' ','',[rfReplaceAll] );
end;

function loescheSemikolon(s:string):string;
begin
 s:=stringreplace(s,'virtual;','{virtual}',[rfReplaceAll] );
 s:=stringreplace(s,'override;','{override}',[rfReplaceAll] );
 s:=stringreplace(s,';','',[rfReplaceAll] );
 s:=stringreplace(s,'procedure','',[rfReplaceAll] );
 s:=stringreplace(s,'function','',[rfReplaceAll] );
 s:=stringreplace(s,'constructor','',[rfReplaceAll] );
 s:=stringreplace(s,'destructor','',[rfReplaceAll] );
result:=s;

end;
constructor TFUML.create(aowner: tcomponent; code: TStringList);
var i,max:integer;
    schutzklasse,sklasse:char;
    liste:TStrings;
    item:string;
begin
 inherited create(aowner);
 zcode:=TStringList.create;

 for i:=0 to code.Count-1 do
  zcode.add(entferneLeerzeichen(code[i]));

 schutzklasse:='+';

 for i:=0 to zcode.Count-1 do
 begin
  if POS('=',zcode[i])>0
   then caption:= Copy(zcode[i],0,POS('=',zcode[i])-1)
   else
   begin
    sklasse:=' ';
    if POS('private',zcode[i]) >0
     then sklasse:='-';
    if POS('public',zcode[i]) >0
     then sklasse:='+';
    if POS('protected',zcode[i]) >0
     then sklasse:='#';

    if (sklasse=' ') and not(pos('end;',zcode[i])>0)
     then
      begin
       if (POS('procedure',zcode[i]) >0) or (POS('function',zcode[i])>0) or
          (POS('constructor',zcode[i]) >0) or (POS('destructor',zcode[i]) >0)
        then liste:=LBMethoden.Items
        else liste:=LBAttribute.Items;
       if zcode[i]<>''
        then
         begin
          item:=schutzklasse+' '+loescheSemikolon(zcode[i]);
          if length(item)>max
           then max:=length(item);

          liste.Add(item);
         end;
      end
     else schutzklasse:=sklasse;

   end;
 end;
 LBAttribute.left:=0;
 LBAttribute.top:=0;
 LBAttribute.width:=max*6;

 LBMEthoden.width:=LBAttribute.width;
 LBAttribute.height:=LBAttribute.ItemHeight*(LBAttribute.items.Count+1);
 LBMethoden.Top:=LBAttribute.top+ LBAttribute.height;
 LBMethoden.left:=0;
 LBMethoden.Height:=(LBMethoden.Items.count+1)*LBMethoden.Itemheight;

 clientHeight:=LBMethoden.Height+LBAttribute.height;
 clientwidth:=LBAttribute.width;

 if clientHeight=0
  then Height:=100;
 if clientwidth=0
  then width:=100;
end;

end.
