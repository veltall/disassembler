DECODE_ADD  BRA     ADD_REG
            
      
ADD_REG   MOVE.L  D6, D5
            AND.L   %0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, REG               *THIS IS USED FOR THE Dn 
            BRA     ADD_DIR              *Dn CAN BE DESTINATION OR SOURCE

ADD_DIR     MOVE.L  D6, D5
            AND.L   %0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     ADD_MODE

ADD_SIZE    MOVE.L  D6, D5
            AND.L   %0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADD_MODE

ADD_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ADD_REG

ADD_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ADD_PROCESS

ADD_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- ADD supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADD_ARRANGE_OUTPUT