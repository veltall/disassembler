
DECODE_ROd  BRA     ROd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ROd_DIRECTION   MOVE.L  D6, D5
            AND.L   %0000000010000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ROd_DIRECTION       * -- Specifies direction of shift
            BRA     ROd_MODE

ROd_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            ASR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ROd_REG

ROd_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            ASR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ROd_PROCESS