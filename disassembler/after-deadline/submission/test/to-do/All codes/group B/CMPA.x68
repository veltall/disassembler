ECODE_CMPA  BRA     CMPA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

CMPA_SRC_REG   MOVE.L  D6, D5
            AND.L   %0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     CMPA_OPMODE

CMPA_OPMODE   MOVE.L  D6, D5
            AND.L   %0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     CMPA_MODE

CMPA_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     CMPA_REG

CMPA_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     CMPA_PROCESS

CMPA_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- CMPA supports word, and long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     CMPA_ARRANGE_OUTPUT