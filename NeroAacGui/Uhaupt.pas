unit Uhaupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellApi,UConsolApp, ExtCtrls;

type
  TFNeroAacGui = class(TForm)
    LBFiles: TListBox;
    BAdd: TButton;
    bstart: TButton;
    Boptionen: TButton;
    oeffnen: TOpenDialog;
    Memo1: TMemo;
    Timer1: TTimer;
    bstop: TButton;
    binfo: TButton;
    procedure BAddClick(Sender: TObject);
    procedure LBFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure bstartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure bstopClick(Sender: TObject);
    procedure binfoClick(Sender: TObject);
  private
   liste:TStringList;
   ConsolApp:TConsolApp;
   zaehler:longint;
   stop:boolean;
   index:integer;
   programpfad:string;
   programmzeile:string;
   procedure aktualisiereFileListe();
   procedure aktualisiereListe();
   procedure wandelUm(datei:string;befehl:string);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FNeroAacGui: TFNeroAacGui;

implementation

{$R *.dfm}

procedure TFNeroAacGui.aktualisiereFileListe;
var  i: Integer;
begin
 lbfiles.Items.Clear;
 for i := 0 to Liste.Count - 1 do
 begin
  lbfiles.Items.Add( ExtractFileName(liste[i]) );
 end;

end;

procedure TFNeroAacGui.aktualisiereListe;
var i: Integer;
begin
 i:=0;
 while i< liste.Count do
 begin
  if lbfiles.Items.IndexOf(ExtractFileName(liste[i])) =-1
   then liste.Delete(i);
  inc(i);
 end;

end;

procedure TFNeroAacGui.BAddClick(Sender: TObject);
var i: Integer;
begin
 if oeffnen.Execute
  then
    for i := 0 to oeffnen.Files.Count - 1 do
     if liste.IndexOf(oeffnen.Files[i])=-1
      then liste.Add(oeffnen.Files[i])
      else showmessage('Datei schon in der Liste') ;
  aktualisiereFileListe();
end;

procedure TFNeroAacGui.binfoClick(Sender: TObject);
begin
 showmessage('GUI für den Nero Acc Encoder, stg7 2008')
end;

procedure TFNeroAacGui.bstartClick(Sender: TObject);
var
    f:textfile;
  i: Integer;
begin

 stop:=false;
 zaehler:=0;
 index:=0;
 programpfad:=ExtractFilePath(Paramstr(0));

 assignfile(f,programpfad+'convert.cfg');
 reset(f);
 readln(f,programmzeile);
 closefile(f);

 wandelUm(liste[index],programmzeile);

end;

procedure TFNeroAacGui.bstopClick(Sender: TObject);
begin
 if assigned(consolapp)
  then
   begin
    stop:=true;
    consolapp.stop;
   end;

end;

procedure TFNeroAacGui.FormCreate(Sender: TObject);
begin
 liste:=TStringlist.create();

end;

procedure TFNeroAacGui.LBFilesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;  
begin
 if (lbfiles.ItemIndex<>-1)and (key = VK_DELETE)
   then
    begin
     i:=0;
     while i< lbfiles.items.Count  do
     begin
       if lbfiles.Selected[i]
        then lbfiles.Items.Delete(i);
       inc(i);
     end;
     aktualisiereListe();
    end;                 
end;

procedure TFNeroAacGui.Timer1Timer(Sender: TObject);
var h:string;
begin
 //Memo1.lines.clear;

 inc(zaehler);
 str(zaehler:5,h);
 Memo1.lines[1]:=h+' sekunden';

 if ConsolApp.getende
  then
   begin
    if (index< liste.count -1) and (stop=false)
     then
      begin
       inc(index);
       zaehler:=0;
       wandelUm(liste[index],programmzeile);
      end
     else
      begin
       Memo1.lines[2]:='->fertig';
       timer1.Enabled:=false;
       bstop.enabled:=false;
      end;     
   end;

end;

procedure TFNeroAacGui.wandelUm(datei:string;befehl:string);
begin
 
 memo1.Lines[0]:='->start '+extractfilename(datei);


 befehl:=stringreplace(befehl,'%1',datei, [ rfReplaceAll ]);

 if assigned(ConsolApp)
  then ConsolApp.free;
 
 ConsolApp:=TConsolapp.create(programpfad+befehl, Memo1.Lines);
 timer1.Enabled:=true;
 bstop.enabled:=true;
end;

end.
