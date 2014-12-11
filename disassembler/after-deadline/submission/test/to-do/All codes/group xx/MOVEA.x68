
DECODE_MOVEA  BRA     MOVEA_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
MOVEA_SIZE   MOVEA.L  D6, D5
            AND.L   %0011000000000000, D5   
            LSR.L   #12, D5                  * -- D5 contains the ss info
            MOVEA.B  D5, SIZE
            BRA     MOVEA_DEST_REG

MOVEA_DEST_REG   MOVEA.L  D6, D5
            AND.L   %0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVEA.B  D5, DEST_REG
            BRA     MOVEA_DEST_MODE    

MOVEA_DEST_MODE  MOVEA.L  D6, D5
            AND.L   %0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVEA.B  D5, DEST_MODE
            BRA     MOVEA_MODE                      

MOVEA_MODE    MOVEA.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVEA.W  D5, EA_MODE
            BRA     MOVEA_REG

MOVEA_REG     MOVEA.L  D6, D5
            AND.L   %0000000000000111, D5
            LSR.L   #0, D5
            MOVEA.W  D5, EA_REG
            BRA     MOVEA_PROCESS

MOVEA_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- MOVEA supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     MOVEA_ARRANGE_OUTPUT