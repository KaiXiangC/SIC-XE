				JSUB 	READ 		CALL READ SUBROUTINE
				ADD   NONE
				JSUB 	WRIT
				ADD   NONE
				J     QUIT
.
READ 		LDX 	ZERO 			INITAILIZE INDEX REGISTER TO 0
RLOOP 	TD 		INDEV 		TEST INPUT DEVICE
				JEQ 	RLOOP 		LOOP IF DEVICE IS BUSY
				RD 		INDEV 		READ ONE BYTE INTO REGISTER A
				STCH 	RECORD,X 	STORE DATA BYTE INTO RECORD
				COMP 	END
				JEQ   JMP
				TIX 	FITY 			ADD 1 TO INDEX AND COMPARE TO 50
				JLT 	RLOOP 		LOOP IF INDEX IS LESS THAN 50
JMP 		RSUB
.
WRIT    LDX   ZERO
OUTLP 	TD 		OUTDEV 		TEST OUTPUT DEVICE
				JEQ 	OUTLP 		LOOP UNTIL DEVICE IS READY
				LDCH 	RECORD,X 			LOAD DATA BYTE INTO REGISTER A
				COMP 	END
				JEQ   EDD
				COMP 	ZWD
				JGT		MINER
AFTER		WD 		OUTDEV 		WRITE ONE BYTE TO OUTPUT DEVICE
				TIX 	FITY 			ADD 1 TO INDEX AND COMPARE TO 50
				JLT 	OUTLP 		LOOP IF INDEX IS LESS THAN 50
EDD 		RSUB
.
MINER 	SUB 	M
				J     AFTER
.
QUIT    ADD   ZERO
.
INDEV 	BYTE 	X'F1'     INPUT DEVICE NUMBER
OUTDEV 	BYTE 	X'F2' 		OUTPOUT DEVICE NUMBER
RECORD 	RESB 	50        50-BYTE BUFFER FOR INPUT RECORD
.
ZERO    WORD  0
NONE    WORD  0
FITY    WORD  50
END 		WORD 	36
SIZ 		WORD 	50
ZWD 		WORD 	90
M 			WORD 	32