unit UHaupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellAPi, ExtCtrls, Menus,UConsolApp;

type



  TFLameGui = class(TForm)

    BOeffnen: TButton;
    EPfad: TEdit;
    DOeffnen: TOpenDialog;
    CBBitrate: TComboBox;
    LBitrate: TLabel;
    BStart: TButton;
    Memo1: TMemo;
    LAusgabe: TLabel;
    Bstop: TButton;
    LKonvertierung: TLabel;
    MainMenu1: TMainMenu;
    datei1: TMenuItem;
    Mstart: TMenuItem;
    beenden1: TMenuItem;
    beenden2: TMenuItem;
    Mstop: TMenuItem;
    info2: TMenuItem;

    procedure BOeffnenClick(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BstopClick(Sender: TObject);
    procedure info2Click(Sender: TObject);
    procedure MstartClick(Sender: TObject);
    procedure MstopClick(Sender: TObject);
    procedure beenden1Click(Sender: TObject);
    procedure beenden2Click(Sender: TObject);
  private
   lame:string;
   programpfad:string;
   ConsolApp:TConsolapp;

    { Private-Deklarationen }
  public
  
    { Public-Deklarationen }
  end;

var
  FLameGui: TFLameGui;

implementation

{$R *.dfm}


procedure TFLameGui.beenden1Click(Sender: TObject);
begin
 BOeffnenClick(sender);
end;

procedure TFLameGui.beenden2Click(Sender: TObject);
begin
 close;
end;

procedure TFLameGui.BOeffnenClick(Sender: TObject);
begin
 DOeffnen.Execute;
 EPfad.Text:=Doeffnen.FileName;
end;

procedure TFLameGui.BStartClick(Sender: TObject);
var param:string;

begin
 if not(EPfad.Text='')
  then
   begin
    param:='--preset cbr '+CBBitrate.Text+ ' "'+EPfad.text+'"';
    Memo1.Clear;
    if assigned(ConsolApp)
     then ConsolApp.free;

    ConsolApp:=TConsolapp.create(programpfad+lame+' '+param, Memo1.Lines);
  
    // ShellExecute(Handle, nil, PChar(programpfad+lame),PChar(param), '', SW_SHOWNORMAL);
    Bstop.enabled:=true;
   end
  else
   Memo1.Lines.Add('Fehler : zuerst muss eine Datei ausgewählt werden!');
end;

procedure TFLameGui.BstopClick(Sender: TObject);
begin
 if assigned(ConsolApp)
  then ConsolApp.stop;
end;

procedure TFLameGui.FormCreate(Sender: TObject);
begin
 lame:='lame\lame.exe';
 programpfad:=ExtractFilePath(Paramstr(0));
 CBbitrate.Items.LoadFromFile('bitraten.cfg');

end;

procedure TFLameGui.info2Click(Sender: TObject);
begin
 showmessage('Lame GUI '+chr(13)+chr(13)+'Grafische Oberfläche für Lame '+chr(13)+'nur konstante Bitraten möglich!'+chr(13)+chr(13)+'Copyright 2008'+chr(13)+'stg7@gmx.de ');
end;

procedure TFLameGui.MstartClick(Sender: TObject);
begin
 BStartClick(sender);
end;

procedure TFLameGui.MstopClick(Sender: TObject);
begin
 BStopClick(sender);
end;



end.
