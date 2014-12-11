DECODE_DIVS  BRA     DIVS_DEST_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
DIVS_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     DIVS_MODE

DIVS_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     DIVS_REG

DIVS_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     DIVS_ARRANGE_OUTPUT

