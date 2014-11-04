unit UPlaylist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFPlayliste = class(TForm)
    lbtitel: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
  private
   kliste:TStringlist;
    { Private-Deklarationen }
  public
   constructor create(aowner:Tcomponent;liste:TstringList);
    { Public-Deklarationen }
  end;

var
  FPlayliste: TFPlayliste;

implementation

{$R *.dfm}

{ TFPlayliste }

constructor TFPlayliste.create(aowner: Tcomponent; liste: TstringList);
begin
 inherited create(aowner);
 kliste:=liste;
end;

procedure TFPlayliste.FormShow(Sender: TObject);
var i:integer;
begin
 lbtitel.Items.Clear;
 for i := 0 to kListe.Count - 1 do
 begin
  lbtitel.Items.Add( ExtractFileName(kliste[i]) );
 end;
end;

end.
