

DECODE_MOVE  BRA     MOVE_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
MOVE_SIZE   MOVE.L  D6, D5
            AND.L   #%0011000000000000, D5   
            LSR.L   #12, D5                  * -- D5 contains the ss info
            MOVE.B  D5, WEIRD_SIZE
            BRA     MOVE_DEST_REG

MOVE_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            LSR.L   #9, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     MOVE_DEST_MODE    

MOVE_DEST_MODE  MOVE.L  D6, D5
            AND.L   #%0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_MODE
            BRA     MOVE_MODE                      

MOVE_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     MOVE_REG

MOVE_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     MOVE_PROCESS

MOVE_PROCESS JSR     DECODE_WEIRD_SIZE     * -- MOVE supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     MOVE_ARRANGE_OUTPUT

MOVE_ARRANGE_OUTPUT     MOVE.B            #'M', (A3)+
                        MOVE.B            #'O', (A3)+
                        MOVE.B            #'V', (A3)+
                        MOVE.B            #'E', (A3)+
                        MOVE.L            SIZE_OUT, (A3)+

                        JSR               PRINT_EA_MODE
                        MOVE.B            #' ', (A3)+
                        MOVE.B            #' ', (A3)+
                        MOVE.B            #' ', (A3)+
                        MOVE.B            #',', (A3)+
                        JSR               PRINT_DEST_MODE

