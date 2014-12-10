
DECODE_ROd  BRA     ROd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ROd_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000000100000000, D5   
            ASR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION           * -- Specifies direction of shift
            BRA     ROd_SIZE

ROd_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   * -- bits 3, 4, 5
            ASR.L   #6, D5
            MOVE.W  D5, SIZE
            BRA     ROd_IR

ROd_IR      MOVE.L  D6, D5
            AND.L   #%0000000000100000, D5
            ASR.L   #0, D5
            MOVE.W  D5, ROTATE_IR
            BRA     ROd_CR

ROd_CR      MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5
            ASR.L   #9, D5
            MOVE.W  D5, ROTATE_CR
            BRA     ROd_EA_REG

ROd_EA_REG  MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ROd_PROCESS