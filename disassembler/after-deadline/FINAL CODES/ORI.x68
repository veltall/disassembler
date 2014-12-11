

DECODE_ORI  BRA     ORI_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ORI_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   * -- the 1 bits are preserved intact
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ORI_MODE

ORI_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ORI_REG

ORI_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     ORI_PROCESS

ORI_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- ORI supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ORI_ARRANGE_OUTPUT

            
            
ORI_ARRANGE_OUTPUT            MOVE.B  #'O',(A3)+
            MOVE.B  #'R',(A3)+
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
