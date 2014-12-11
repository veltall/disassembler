ECODE_CMPA  BRA     CMPA_DEST_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

CMPA_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     CMPA_SIZE

CMPA_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     CMPA_MODE

CMPA_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     CMPA_REG

CMPA_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     CMPA_PROCESS

CMPA_PROCESS JSR     DECODE_ONE_BIT_SIZE     * -- CMPA supports word, and long so it needs
                                            * -- 1 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     CMPA_ARRANGE_OUTPUT