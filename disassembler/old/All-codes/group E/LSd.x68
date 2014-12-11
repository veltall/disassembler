
DECODE_LSd  BRA     LSd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
LSd_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000000010000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, LSd_DIRECTION       * -- Specifies direction of shift
            BRA     LSd_MODE

LSd_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     LSd_REG

LSd_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     LSd_PROCESS

