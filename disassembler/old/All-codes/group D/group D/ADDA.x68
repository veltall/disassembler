DECODE_ADDA  BRA     ADDA_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ADDA_REG   MOVE.L  D6, D5
            AND.L   %0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, REG               *THIS IS USED FOR THE Dn 
            BRA     ADDA_OPMODE              *Dn CAN BE DESTINATION OR SOURCE

ADDA_OPMODE   MOVE.L  D6, D5
            AND.L   %0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADDA_MODE            

ADDA_MODE    MOVE.L  D6, D5
            AND.L   %0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     ADDA_REG

ADDA_REG     MOVE.L  D6, D5
            AND.L   %0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ADDA_PROCESS

ADDA_PROCESS JSR     DECODE_ONE_BIT_SIZE     * -- ADDA supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADDA_ARRANGE_OUTPUT