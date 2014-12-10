
* ------------- SUPPORT ONLY WORD-SIZED DATA
DECODE_MULS  BRA     MULS_DEST_REG
            
            
MULS_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     MULS_MODE

MULS_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     MULS_REG

MULS_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     MULS_ARRANGE_OUTPUT

