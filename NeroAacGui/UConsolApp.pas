unit UConsolApp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellAPi, ExtCtrls, Menus;
  
const
 MaxBufSize = 1024;

type
  TCharBuffer = array[0..MaxInt - 1] of Char;


  TConsolApp=class(TObject)
    private
       I: Longword;
       SI: TStartupInfo;
       PI: TProcessInformation;
       SA: PSecurityAttributes;
       SD: PSECURITY_DESCRIPTOR;
       NewStdIn: THandle;
       NewStdOut: THandle;
       ReadStdOut: THandle;
       WriteStdIn: THandle;
       Buffer: ^TCharBuffer;
       BufferSize: Cardinal;
       Last: WideString;
       Str: WideString;
       ExitCode: DWORD;
       Bread: DWORD;
       Avail: DWORD;
       zstop:boolean;
       Timer:TTimer;
       kstrings:TStrings;
       zeile:integer;
       start:boolean;
       ende:boolean;
     procedure add(str:widestring;astrings:TStrings);
     procedure aktualisiere(sender:TObject);
    public
     constructor create();overload;
     constructor create(const CommandLine: string; AStrings: TStrings);overload;
     procedure RunConsoleApp(const CommandLine: string; AStrings: TStrings);
     procedure stop;
     function getende:boolean;
  end; 

implementation

{ TConsolApp }

constructor TConsolApp.create;
begin
  inherited;
  Timer:=TTimer.create(nil);
  Timer.Interval:=500;
  Timer.Enabled:=false;
  Timer.OnTimer:=aktualisiere;
end;

procedure TConsolApp.add;
begin
 inc(zeile);
 //if zeile<16 then
//  astrings.add(str);
end;

procedure TConsolApp.aktualisiere(sender: TObject);

begin


 SysUtils.Win32Check(GetExitCodeProcess(PI.hProcess, ExitCode));
 PeekNamedPipe(ReadStdOut, Buffer, BufferSize, @Bread, @Avail, nil);

// kstrings.Clear; 
 zeile:=0;
 str:='';

 if (Bread <> 0) then
  begin

   if (BufferSize < Avail) then
    begin
     BufferSize := Avail;
     ReallocMem(Buffer, BufferSize);
    end; {end if}
   FillChar(Buffer^, BufferSize, #0);
   ReadFile(ReadStdOut, Buffer^, BufferSize, Bread, nil);
   Str := Last;

   I := 0;
   while (I < Bread) do
    begin
     case Buffer^[I] of
      #0: inc(I);
      #13,#10:begin
           inc(I);
           if (I < Bread) and (Buffer^[I] = #10) then
            inc(I);
           add(str,kStrings);
           Str := '';
          end;
      else
          begin
           Str := Str + Buffer^[I];
           inc(I);
          end;
     end;
    end;
   Last := Str;
  end;


 Sleep(1);
 Application.ProcessMessages;

 if ExitCode <> STILL_ACTIVE then
  stop;
end;

constructor TConsolApp.create(const CommandLine: string; AStrings: TStrings);
begin
 create;
 RunConsoleApp(CommandLine,AStrings);
end;

function TConsolApp.getende: boolean;
begin
 result:=ende;
end;

procedure TConsolApp.RunConsoleApp(const CommandLine: string;
  AStrings: TStrings);
begin
  start:=true;
  Timer.Enabled:=true;
  kstrings:=astrings;
  GetMem(SA, SizeOf(TSecurityAttributes));
  case Win32Platform of
    VER_PLATFORM_WIN32_NT:
      begin
        GetMem(SD, SizeOf(SECURITY_DESCRIPTOR));
        SysUtils.Win32Check(InitializeSecurityDescriptor(SD, SECURITY_DESCRIPTOR_REVISION));
        SysUtils.Win32Check(SetSecurityDescriptorDacl(SD, True, nil, False));
        SA.lpSecurityDescriptor := SD;
      end; {end VER_PLATFORM_WIN32_NT}
  else
    SA.lpSecurityDescriptor := nil;
  end; {end case}
  SA.nLength := SizeOf(SECURITY_ATTRIBUTES);
  SA.bInheritHandle := True;
  SysUtils.Win32Check(CreatePipe(NewStdIn, WriteStdIn, SA, 0));
  if not CreatePipe(ReadStdOut, NewStdOut, SA, 0) then
  begin
    CloseHandle(NewStdIn);
    CloseHandle(WriteStdIn);
    SysUtils.RaiseLastWin32Error;
  end; {end if}
  GetStartupInfo(SI);
  SI.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
  SI.wShowWindow := {SW_SHOWNORMAL} SW_HIDE;
  SI.hStdOutput := NewStdOut;
  SI.hStdError := NewStdOut;
  SI.hStdInput := NewStdIn;

  if not CreateProcess(nil, PChar(CommandLine), nil, nil, True,
    CREATE_NEW_CONSOLE, nil, nil, SI, PI)
  then
  begin
    CloseHandle(NewStdIn);
    CloseHandle(NewStdOut);
    CloseHandle(ReadStdOut);
    CloseHandle(WriteStdIn);
    SysUtils.RaiseLastWin32Error;
  end; {end if}
  Last := '';
  BufferSize := MaxBufSize;
  Buffer := AllocMem(BufferSize);

end;

procedure TConsolApp.stop;
var hProcess: THandle;




begin
 if start
  then
   begin
    //if last<>'' then
    // kstrings.Add(last);
   // kstrings.Add('->ende');
    timer.enabled:=false;

    if ExitCode = STILL_ACTIVE
     then
      begin
       // handle des Prozesses ermitteln
       hProcess := OpenProcess(PROCESS_TERMINATE, False, pi.dwProcessId);
       // anschlieﬂendes Schlieﬂen des Prozesses
       TerminateProcess(hProcess, 0);
      end;
    ende:=True;
    CloseHandle(PI.hThread);
    CloseHandle(PI.hProcess);
    CloseHandle(NewStdIn);
    CloseHandle(NewStdOut);
    CloseHandle(ReadStdOut);
    CloseHandle(WriteStdIn);
    FreeMem(Buffer);
   end;
end;

end.
