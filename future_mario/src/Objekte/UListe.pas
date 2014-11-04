unit UListe;

interface

type TListe=class(TObject)
      private
       elemente:array of TObject;
      public
       procedure fuegehinzu(obj:TObject);
       function getelement(i:integer):TObject;
       function getLaenge : integer;
       procedure free;
      end;

implementation
procedure TListe.free;
var
  i: Integer;
begin
  for i := 0 to length(elemente) - 1 do
   elemente[i].Free;
  inherited;    
end;

procedure TListe.fuegehinzu;
var neueLaenge:integer;
begin
 neueLaenge:=length(elemente)+1;
 setlength(elemente,neuelaenge);
 elemente[neueLaenge-1]:=obj;
End;

function tliste.getelement(i:integer):TObject;
begin
 if length(elemente)>0
  then result:=elemente[i]
  else result:=nil;
end;

function tliste.getLaenge : integer;
begin
 result:=length(elemente);
end;


end.

