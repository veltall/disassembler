DECODE_DIVS  BRA     DIVS_DEST_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
DIVS_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                   * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     DIVS_MODE

DIVS_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     DIVS_REG

DIVS_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     DIVS_PROCESS

DIVS_PROCESS      JSR         DECODE_DEST_REG
                  JSR         DECODE_EA_MODE
                  BRA         DIVS_ARRANGE_OUTPUT

DIVS_ARRANGE_OUTPUT            MOVE.B  #'D',(A3)+
            MOVE.B  #'I',(A3)+
            MOVE.B  #'V',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'.',(A3)+
            MOVE.B  #'W',(A3)+
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP