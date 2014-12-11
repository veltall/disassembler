ECODE_EOR  BRA     EOR_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

EOR_SRC_REG   MOVE.L  D6, D5
            AND.L   %0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     EOR_OPMODE

EOR_OPMODE   MOVE.L  D6, D5
            AND.L   %0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     EOR_MODE

EOR_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     EOR_REG

EOR_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     EOR_PROCESS

EOR_PROCESS JSR     DECODE_THREE_BIT_SIZE     * -- EOR supports byte, word, and long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     EOR_ARRANGE_OUTPUT