DECODE_BRA  BRA     BRA_DISPLACEMENT
            
           
BRA_DISPLACEMENT    MOVE.L  D6, D5
            AND.W   #%0000000011111111, D5   

            MOVE.W  D5, DISPLACEMENT
            BRA     BRA_MODE

BRA_PROCESS JSR     DECODE_DISPLACEMENT 
            BRA     BRA_ARRANGE_OUTPUT
            
            
                        
BRA_ARRANGE_OUTPUT            MOVE.B  #'B',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.B  #'A',(A3)+

            MOVE.L  DISPLACEMENT_OUT, PRINT_BUFFER
            CMP.B   #%00, PERSONAL_SIZE_CONVENTION
            BEQ     BRA_8_BITS
            MOVE.B  #16, PRINT_SIZE
            BRA     PRINT_BRA
BRA_8_BITS  MOVE.B  #8, PRINT_SIZE
PRINT_BRA   JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            
* ---- subroutine DECODE_DISPLACEMENT

DECODE_DISPLACEMENT MOVEM.L  D4-D6, -(sp)
            * -- default size assumption: Byte
            MOVE.B  #%00, PERSONAL_SIZE_CONVENTION

            MOVE.B  DISPLACEMENT, D4
            CMP.B   #$00, D4
            BNE     BRA_SKIP

            MOVE.W  (A6)+, D6
            MOVE.W  D6, D4
            MOVE.B  #01, PERSONAL_SIZE_CONVENTION

BRA_SKIP    MOVE.L  #0, D7      * -- clear D7
            MOVE.W  D4, D7
            JSR     CONVERT_HEX_TO_STRING
            MOVE.L  D7, DISPLACEMENT_OUT
            BRA     DECODE_DISPLACEMENT_DONE


DECODE_DISPLACEMENT_DONE MOVEM.L (sp)+, D4-D6
                         RTS