DECODE_ADD  BRA     ADD_SRC_REG
            
      
ADD_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG               *THIS IS USED FOR THE Dn 
            BRA     ADD_DIR              *Dn CAN BE DESTINATION OR SOURCE

ADD_DIR     MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     ADD_SIZE

ADD_SIZE    MOVE.L  D6, D5
            AND.W   #%0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADD_MODE

ADD_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     ADD_REG

ADD_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
   
            MOVE.B  D5, EA_REG
            BRA     ADD_PROCESS

ADD_PROCESS JSR     DECODE_SRC_REG
            JSR     DECODE_TWO_BIT_SIZE     * -- ADD supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADD_ARRANGE_OUTPUT
            
            
                        
ADD_ARRANGE_OUTPUT  MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BNE     REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            
REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP