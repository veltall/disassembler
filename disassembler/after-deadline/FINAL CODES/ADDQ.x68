
DECODE_ADDQ  BRA     ADDQ_DATA
            
 
ADDQ_DATA   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                   * -- D5 contains the ss info
            MOVE.B  D5, DATA
            BRA     ADDQ_SIZE


ADDQ_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADDQ_MODE

ADDQ_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ADDQ_REG

ADDQ_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     ADDQ_PROCESS

ADDQ_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- ADDQ supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADDQ_PROCESS

ADDQ_PROCESS      
                  JSR         DECODE_EA_MODE
                  BRA         ADDQ_ARRANGE_OUTPUT            
            
                        
ADDQ_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'Q',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            MOVE.B  #'#',(A3)+
            MOVE.B  #'$',(A3)+
            JSR     READ_AND_PRINT_WORD
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP