DECODE_MOVEM  BRA     MOVEM_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

MOVEM_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000100000000000, D5   
            MOVE.B  #11, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION         *SPECIFIES DIRECTION OF TRANSFER
            BRA     MOVEM_SIZE

MOVEM_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000001000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     MOVEM_MODE

MOVEM_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE
            BRA     MOVEM_REG

MOVEM_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     MOVEM_PROCESS

MOVEM_PROCESS JSR     DECODE_ONE_BIT_SIZE     * -- MOVEM supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     MOVEM_ARRANGE_OUTPUT
            
MOVEM_ARRANGE_OUTPUT            MOVE.B  #'M',(A3)+
            MOVE.B  #'O',(A3)+
            MOVE.B  #'V',(A3)+
            MOVE.B  #'E',(A3)+
            MOVE.B  #'M',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BEQ     REG_TO_MEM
            BRA     MEM_TO_REG

REG_TO_MEM  *PRINT THE LIST HERE!!!!!
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE  
            BRA   MAIN_LOOP  

MEM_TO_REG  JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            *PRINT THE LIST HERE!!!!!!
            BRA     MAIN_LOOP
            
            
