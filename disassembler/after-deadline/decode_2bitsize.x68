
* -- pre-conditions: Address SIZE loaded with correct input

* -- Purpose: Decode a typical 2-bit SIZE field (byte, word, long)

* -- 1. process data
DECODE_TWO_BIT_SIZE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #SIZE_OUT, A5
                MOVE.B      SIZE, D5
                
                CMP.B       #%000, D5
                BEQ         SIZE_BYTE
                CMP.B       #%001
                BEQ         SIZE_WORD
                CMP.B       #%010, D5
                BEQ         SIZE_LONG
                BRA         SIZE_INVALID
                
* -- 2. Respond to data

SIZE_INVALID     BRA     DECODE_TWO_BIT_SIZE_DONE

DECODE_TWO_BIT_SIZE_DONE    MOVEM.L (sp)+, D4-D5/A5
                    RTS

SIZE_BYTE        MOVE.B      #'.', (A5)+
                    MOVE.B      #'B', (A5)+
                    BRA         DECODE_EA_DONE

SIZE_WORD        MOVE.B      #'.', (A5)+
                    MOVE.B      #'W', (A5)+
                    BRA         DECODE_EA_DONE

SIZE_LONG        MOVE.B      #'.', (A5)+
                    MOVE.B      #'L', (A5)+
                    BRA         DECODE_EA_DONE

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
