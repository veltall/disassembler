DECODE_JSR  BRA     JSR_MODE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

JSR_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE     *DESTINATION
            BRA     JSR_REG

JSR_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
               
            MOVE.B  D5, EA_REG       *DESTINATION
            BRA     JSR_PROCESS

JSR_PROCESS JSR      DECODE_EA_MODE
            BRA      JSR_ARRANGE_OUTPUT


JSR_ARRANGE_OUTPUT            MOVE.B  #'J',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.B  #' ',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END