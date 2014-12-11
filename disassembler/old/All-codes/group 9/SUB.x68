DECODE_SUB  BRA     SUB_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUB 7

SUB_SRC_REG   MOVE.L  D6, D5
            SUB.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     SUB_OPMODE

SUB_DIR     MOVE.L  D6, D5
            SUB.L   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUB_SIZE

SUB_SIZE    MOVE.L  D6, D5
            SUB.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUB_MODE

SUB_MODE    MOVE.L  D6, D5
            SUB.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     SUB_REG

SUB_REG     MOVE.L  D6, D5
            SUB.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     SUB_PROCESS

SUB_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- SUB supports byte, word, SUB long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     SUB_ARRANGE_OUTPUT