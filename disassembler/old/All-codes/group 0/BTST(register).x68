
DECODE_BTST  BRA     BTST_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
BTST_SRC_REG   MOVE.L  D6, D5
            AND.L   #%0000011100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REGISTER       * --- SOURCE REGISTER   
            BRA     BTST_MODE

BTST_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     BTST_REG

BTST_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     BTST_PROCESS

BTST_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- BTST supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     BTST_ARRANGE_OUTPUT
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
