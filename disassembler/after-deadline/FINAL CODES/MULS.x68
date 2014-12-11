
* ------------- SUPPORT ONLY WORD-SIZED DATA
DECODE_MULS  BRA     MULS_SRC_REG
            
            
MULS_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     MULS_MODE

MULS_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     MULS_REG

MULS_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
       
            MOVE.B  D5, EA_REG
            BRA     MULS_PROCESS

MULS_PROCESS JSR        DECODE_SRC_REG
            JSR         DECODE_EA_MODE

            BRA   MULS_ARRANGE_OUTPUT


MULS_ARRANGE_OUTPUT            MOVE.B  #'M',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'L',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'.',(A3)+
            MOVE.B  #'W',(A3)+
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END