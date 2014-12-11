DECODE_AND  BRA     AND_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

AND_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
             MOVE.B  #9, D1
            LSR.L   D1, D5                * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     AND_SIZE

AND_DIR     MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     AND_MODE

AND_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     AND_MODE

AND_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     AND_REG

AND_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
  
            MOVE.B  D5, EA_REG
            BRA     AND_PROCESS

AND_PROCESS JSR         DECODE_SRC_REG
         JSR         DECODE_TWO_BIT_SIZE
            JSR         DECODE_EA_MODE
             BRA         AND_ARRANGE_OUTPUT
            
            
AND_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'N',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BNE     AND_REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
                   
AND_REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END
            
