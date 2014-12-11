
DECODE_CMPI  BRA     CMPI_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
CMPI_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     CMPI_MODE

CMPI_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     CMPI_REG

CMPI_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     CMPI_PROCESS

CMPI_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- CMPI supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     CMPI_ARRANGE_OUTPUT
            

            
CMPI_ARRANGE_OUTPUT            MOVE.B  #'C',(A3)+
            MOVE.B  #'M',(A3)+
            MOVE.B  #'P',(A3)+
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
            
            
            
