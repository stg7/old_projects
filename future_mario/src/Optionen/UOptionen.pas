unit UOptionen;

interface

uses IniFiles,SysUtils ;
// Informationen zu INI Files: http://www.delphi-treff.de/no_cache/tutorials/datenspeicherung/win32/ini-dateien/page/3/


type TOptionen=class(TObject)
      private
       zHintergrundlautstaerke:integer;
       zGesamtlautstaerke:integer;
       zVollbild:boolean;
       zcrazymodus:boolean;
       zMappack:string;
       filename:string;
       procedure setHintergrundlautstaerke(const Value: integer);
       procedure setGesamtlautstaerke(const Value: integer);
       procedure setvollbild(const Value: boolean);
       procedure setcrazymodus(const Value: boolean);
       procedure setmappack(const Value: string);
      public
       property HintergrundVolume:integer read zHintergrundlautstaerke write setHintergrundlautstaerke;
       property GesamtVolume:integer read zGesamtlautstaerke write setGesamtlautstaerke;
       property Vollbild:boolean read zVollbild write setvollbild;
       property crazymodus:boolean read zcrazymodus write setcrazymodus;
       property Mappack:string read zmappack write setmappack;
       procedure loadfromfile(filename:string);
       procedure savetofile(filename:string);
       procedure save;
       procedure load;
       constructor create(filename:string);virtual;
     end;


implementation

{ TOptionen }

constructor TOptionen.create(filename: string);
begin
 self.filename:=filename;
 load;
end;

procedure TOptionen.load;
begin
 loadfromfile(filename);
end;

procedure TOptionen.loadfromfile(filename: string);
var ini: TIniFile;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+filename);

  zHintergrundlautstaerke:=ini.ReadInteger('Sound','Hintergrundlaustärke',0);
  zGesamtlautstaerke:=ini.ReadInteger('Sound','Gesamtlaustärke',0);
  zVollbild:=ini.ReadBool('Grafik','Vollbild',false);
  zCrazyModus:=ini.ReadBool('Grafik','CrazyModus',false);
  zMapPack:=ini.ReadString('Map','MapPack','');
  ini.free;
end;

procedure TOptionen.save;
begin
 savetofile(filename);
end;

procedure TOptionen.savetofile(filename: string);
var ini: TIniFile;
begin
  ini:=TIniFile.create(ExtractFilePath(ParamStr(0))+filename);

  ini.WriteInteger('Sound','Hintergrundlaustärke',zHintergrundlautstaerke);
  ini.WriteInteger('Sound','Gesamtlaustärke',zGesamtlautstaerke);
  ini.WriteBool('Grafik','Vollbild',zVollbild);
  ini.WriteBool('Grafik','CrazyModus',zCrazyModus);
  ini.WriteString('Map','MapPack',zMappack);
  ini.Free;
end;

procedure TOptionen.setcrazymodus(const Value: boolean);
begin
 zcrazymodus:=value;
end;

procedure TOptionen.setGesamtlautstaerke(const Value: integer);
begin
 zGesamtlautstaerke:=value;
end;

procedure TOptionen.setHintergrundlautstaerke(const Value: integer);
begin
 zHintergrundlautstaerke:=value;
end;

procedure TOptionen.setmappack(const Value: string);
begin
 zmappack:=value;
end;

procedure TOptionen.setvollbild(const Value: boolean);
begin
 zvollbild:=value;
end;

end.
