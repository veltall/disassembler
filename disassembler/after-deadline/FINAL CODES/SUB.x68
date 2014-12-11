DECODE_SUB  BRA     SUB_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUB 7

SUB_SRC_REG   MOVE.L  D6, D5
            SUB.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     SUB_SIZE

SUB_DIR     MOVE.L  D6, D5
            SUB.L   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     SUB_SIZE

SUB_SIZE    MOVE.L  D6, D5
            SUB.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUB_MODE

SUB_MODE    MOVE.L  D6, D5
            SUB.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     SUB_REG

SUB_REG     MOVE.L  D6, D5
            SUB.L   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     SUB_PROCESS

SUB_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- SUB supports byte, word, SUB long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     SUB_PROCESS

SUB_PROCESS      JSR         DECODE_EA_REG
                  JSR         DECODE_TWO_BIT_SIZE
                  JSR         DECODE_EA_MODE
                  BRA         SUB_ARRANGE_OUTPUT
            
            
SUB_ARRANGE_OUTPUT            MOVE.B  #'S',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'B',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BEQ     REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
          
            
REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.L  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END
            
       
 
