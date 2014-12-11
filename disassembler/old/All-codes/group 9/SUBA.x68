DECODE_SUBA  BRA     SUBA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUBA 7

SUBA_SRC_REG   MOVE.L  D6, D5
            SUBA.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     SUBA_OPMODE

SUBA_SIZE   MOVE.L  D6, D5
            SUBA.L   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUBA_MODE

SUBA_MODE    MOVE.L  D6, D5
            SUBA.L   #%0000000000111000, D5   * -- THis is the source!
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     SUBA_REG

SUBA_REG     MOVE.L  D6, D5
            SUBA.L   #%0000000000000111, D5      * -- Source!
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     SUBA_PROCESS

SUBA_PROCESS JSR     DECODE_ONE_BIT_SIZE     * -- SUBA supports byte, word, SUBA long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     SUBA_ARRANGE_OUTPUT