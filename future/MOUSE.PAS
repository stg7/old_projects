UNIT Mouse;

INTERFACE

PROCEDURE MouseInit(VAR Exists : Boolean; VAR Button : Word);
PROCEDURE MouseShow;
PROCEDURE MouseHide;
PROCEDURE MouseGetPos(VAR x,y : Word);
PROCEDURE MouseSetPos(x,y : Word);
PROCEDURE MouseEvent(VAR Button,x,y : Word);

IMPLEMENTATION

PROCEDURE MouseInit;
VAR vorh, Tasten : Word;
BEGIN
  Button := 0;
  Exists := False;
  vorh := 1;
  ASM
    mov ax,0
    int 33h
    cmp ax,0FFFFh
    je  @Maus
    mov vorh,0
    @Maus:
      mov Tasten,bx
  END;
  IF vorh = 1 THEN
  BEGIN
    Button := Tasten;
    Exists := TRUE;
  END;
END;

PROCEDURE MouseShow; ASSEMBLER;
ASM
  mov ax,1
  int 33h
END;

PROCEDURE MouseHide; ASSEMBLER;
ASM
  mov ax,2
  int 33h;
END;

PROCEDURE MouseGetPos;
VAR PosX,PosY : Word;
BEGIN
  ASM
    mov ax,3
    int 33h
    mov PosX,cx
    mov PosY,dx
  END;
  x := PosX;
  y := PosY;
END;

PROCEDURE MouseSetPos; ASSEMBLER;
ASM
  mov ax,4
  mov cx,x
  mov dx,y
  int 33h
END;

PROCEDURE MouseEvent;
VAR PosX,PosY,Taste : Word;
BEGIN
  ASM
    mov ax,3
    int 33h
    mov Taste,bx
    mov PosX,cx
    mov PosY,dx
  END;
  Button := Taste;
  x := PosX;
  y := PosY;
END;

BEGIN
END.