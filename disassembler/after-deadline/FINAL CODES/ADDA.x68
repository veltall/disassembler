DECODE_ADDA  BRA     ADDA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ADDA_SRC_REG   MOVE.L  D6, D5
            AND.W   %0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG               *THIS IS USED FOR THE Dn 
            BRA     ADDA_SIZE              *Dn CAN BE DESTINATION OR SOURCE

ADDA_SIZE   MOVE.L  D6, D5
            AND.W   %0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADDA_MODE            

ADDA_MODE    MOVE.L  D6, D5
            AND.W   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     ADDA_REG

ADDA_REG     MOVE.L  D6, D5
            AND.W   %0000000000000111, D5
 
            MOVE.B  D5, EA_REG
            BRA     ADDA_PROCESS

ADDA_PROCESS JSR    DECODE_SRC_REG 
            JSR     DECODE_ONE_BIT_SIZE     * -- ADDA supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADDA_ARRANGE_OUTPUT
            
            
ADDA_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            
            