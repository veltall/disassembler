
DECODE_CMPI  BRA     CMPI_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
CMPI_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     CMPI_MODE

CMPI_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     CMPI_REG

CMPI_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     CMPI_PROCESS

CMPI_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- CMPI supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     CMPI_ARRANGE_OUTPUT