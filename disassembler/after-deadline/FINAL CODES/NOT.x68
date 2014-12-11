DECODE_NOT  BRA     NOT_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
NOT_SIZE    MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     NOT_MODE

NOT_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     NOT_REG

NOT_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     NOT_PROCESS

NOT_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- NOT supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     NOT_ARRANGE_OUTPUT 
            
            
NOT_ARRANGE_OUTPUT  MOVE.B  #'N',(A3)+
            MOVE.B  #'O',(A3)+
            MOVE.B  #'T',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END