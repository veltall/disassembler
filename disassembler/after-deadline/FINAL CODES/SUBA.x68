DECODE_SUBA  BRA     SUBA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUBA 7

SUBA_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
           MOVE.B  #9, D1
            LSR.L   D1, D5                
            MOVE.B  D5, SRC_REG
            BRA     SUBA_OPMODE

SUBA_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUBA_MODE

SUBA_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- THis is the source!
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     SUBA_REG

SUBA_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5      * -- Source!

            MOVE.W  D5, EA_REG
            BRA     SUBA_PROCESS

SUBA_PROCESS JSR        DECODE_SRC_REG 
            JSR     DECODE_ONE_BIT_SIZE     * -- SUBA supports byte, word, SUBA long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     SUBA_ARRANGE_OUTPUT
            
            
SUBA_ARRANGE_OUTPUT            MOVE.B  #'S',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'B',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
