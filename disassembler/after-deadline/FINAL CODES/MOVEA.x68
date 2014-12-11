
DECODE_MOVEA  BRA     MOVEA_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
MOVEA_SIZE   MOVE.L  D6, D5
            AND.L   #%0001000000000000, D5 
            MOVE.B  #12, D1
            LSR.L   D1, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     MOVEA_DEST_REG

MOVEA_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     MOVEA_MODE                      

MOVEA_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     MOVEA_REG

MOVEA_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     MOVEA_PROCESS

MOVEA_PROCESS JSR     DECODE_ONE_BIT_SIZE     * -- MOVEA supports word and long so it needs
                                            * -- 1 bit for SIZE
            JSR     DECODE_EA_MODE
            BRA     MOVEA_ARRANGE_OUTPUT
            
MOVEA_ARRANGE_OUTPUT            MOVE.B  #'M',(A3)+
                                MOVE.B  #'O',(A3)+
             MOVE.B  #'V',(A3)+
            MOVE.B  #'E',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP
            
            
            
            
            
            

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
