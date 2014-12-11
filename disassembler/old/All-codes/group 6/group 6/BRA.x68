DECODE_BRA  BRA     BRA_DISPLACEMENT
            
           
BRA_DISPLACEMENT   MOVE.L  D6, D5
            AND.L   #%0000000011111111, D5   
            LSR.L   #0, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DISPLACEMENT
            BRA     BRA_MODE

BRA_PROCESS JSR     DECODE_DISPLACEMENT     * -- BRA supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            BRA     BRA_ARRANGE_OUTPUT