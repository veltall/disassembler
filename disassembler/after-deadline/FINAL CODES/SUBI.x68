
DECODE_SUBI  BRA     SUBI_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
SUBI_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUBI_MODE

SUBI_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     SUBI_REG

SUBI_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     SUBI_PROCESS

SUBI_PROCESS JSR     DECODE_TWO_BIT_SIZE 
            JSR     DECODE_EA_MODE
            BRA     SUBI_ARRANGE_OUTPUT
  


SUBI_ARRANGE_OUTPUT            MOVE.B  #'S',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'B',(A3)+
            MOVE.B  #'I',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #'#',(A3)+
            MOVE.B  #'$',(A3)+
            MOVE.L  (A6)+, D7       *IMMEDIATE DATA
            JSR     CONVERT_HEX_TO_STRING 
            MOVE.L  D7,PRINT_BUFFER
            MOVE.B  #8,PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP
