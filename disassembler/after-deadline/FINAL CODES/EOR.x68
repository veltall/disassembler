ECODE_EOR  BRA     EOR_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

EOR_SRC_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     EOR_SIZE

EOR_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     EOR_MODE

EOR_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     EOR_REG

EOR_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     EOR_PROCESS

EOR_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- EOR supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     EOR_ARRANGE_OUTPUT
            
            
EOR_ARRANGE_OUTPUT            MOVE.B  #'E',(A3)+
            MOVE.B  #'O',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP