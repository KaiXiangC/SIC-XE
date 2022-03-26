        LDA   #32
        WD    OUTDEV
        WD    OUTDEV
        WD    OUTDEV
HEADLOP LDA   ZERO
        LDL   #48    //L
        ADDR  L,A
        WD    OUTDEV
        LDA   #32
        WD    OUTDEV
        WD    OUTDEV
        LDX   #1
        LDA   ZERO
        ADDR  X,A
        COMP  NIN
        STA   ZERO
        JEQ   HEADLOP
        JLT   HEADLOP
        LDT   #1     //T
        LDA   #10
        WD    OUTDEV
        WD    OUTDEV
OUTLOP  LDS   OUT    //S
        LDA   OUT
        LDL   #48    //L
        ADDR  L,A
        WD    OUTDEV
        LDA   #32
        WD    OUTDEV
        WD    OUTDEV
        LDB   #1
        STB   IN
INLOP   LDA   IN     //A
        MULR  S,A
        COMP  TEN
        JGT   DEC
        JEQ   DEC
        LDB   #32    //B
        LDL   #48    //L
        ADDR  L,A
        STA   ALPHA
        STB   BETA
OUTLP   TD    OUTDEV
        JEQ   OUTLP
        LDA   ALPHA
        WD    OUTDEV
        LDA   BETA
        WD    OUTDEV
BCK     LDX   #1     //X
        LDA   IN     //T
        ADDR  X, A
        COMP  NIN
        STA   IN
        LDA   #32
        WD    OUTDEV
        JEQ   INLOP
        JLT   INLOP
        LDT   #1     //T
        LDA   #10
        WD    OUTDEV
        WD    OUTDEV
        LDA   OUT
        ADDR  T, A
        COMP  NIN
        STA   OUT
        JEQ   OUTLOP
        JLT   OUTLOP
        J     QUIT
  .
DEC     LDT   #10
        STA   CHG
        DIVR  T,A
        LDL   #48
        ADDR  L,A
        STA   ALPHA
        LDA   CHG
        LDB   ALPHA
        SUBR  L,B
        MULR  T,B
        SUBR  B,A
        ADDR  L,A
        STA   BETA
OUTA    TD    OUTDEV       // 測試輸入裝置
        JEQ   OUTA         // 迴圈直到輸入裝置準備好
        LDA   ALPHA
        WD    OUTDEV
        LDA   BETA
        WD    OUTDEV
        J     BCK
  .
QUIT    ADD   ZERO
  .
OUTDEV  BYTE  X'F2'
  .
OUT     WORD  1
IN      WORD  1
BETA    RESW  1
ALPHA   RESW  1
CHG     RESW  1
TEN     WORD  10
NIN     WORD  9
ZERO    WORD  1