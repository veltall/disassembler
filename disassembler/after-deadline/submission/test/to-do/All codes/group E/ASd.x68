
DECODE_ASd  BRA     ASd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ASd_DIRECTION   MOVE.L  D6, D5
            AND.L   %0000000010000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ASd_DIRECTION       * -- Specifies direction of shift
            BRA     ASd_MODE

ASd_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            ASR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ASd_REG

ASd_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            ASR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ASd_PROCESS
