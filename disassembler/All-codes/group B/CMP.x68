ECODE_CMP  BRA     CMP_DEST_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

CMP_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     CMP_SIZE

CMP_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     CMP_MODE

CMP_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     CMP_REG

CMP_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     CMP_PROCESS

CMP_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- CMP supports byte, word, and long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     CMP_ARRANGE_OUTPUT