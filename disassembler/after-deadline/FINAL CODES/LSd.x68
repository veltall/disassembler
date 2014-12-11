
DECODE_LSd  BRA     LSd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
            
LSd_COUNT/REG    MOVE.L  D6, D5
                AND.L   #%0000111000000000, D5   
                MOVE.B  #9, D1
                LSR.L   D1, D5                  * -- D5 contains the ss info
                MOVE.B  D5, LSd_REG       * -- Specifies direction of shift
                BRA     LSd_DIRECTION         
            
LSd_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000000010000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, LSd_DIRECTION       * -- Specifies direction of shift
            BRA     LSd_SIZE
            
LSd_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, LSd_SIZE       * -- Specifies direction of shift
            BRA     LSd_MODE           

LSd_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000100000, D5   * -- bits 3, 4, 5
            ASR.L   #5, D5
            MOVE.W  D5, EA_MODE
            BRA     LSd_REG

LSd_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.W  D5, EA_REG
            BRA     LSd_ARRANGE_OUTPUT

LSd_ARRANGE_OUTPUT            MOVE.B  #'L',(A3)+
            MOVE.B  #'S',(A3)+
            CMP.B   #0, LSd_DIRECTION
            BEQ     SHIFT_RIGHT 
            MOVE.B  #'L',(A3)+
            BRA     NEXT_STEP
            
SHIFT_RIGHT MOVE.B  #'R',(A3)+
            
 
NEXT_STEP   MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            CMP.B   #0, LSd_MODE
            BEQ     IMMEDIATE_DATA
            MOVE.B  #'D',(A3)+      *REGISTER
            MOVE.L  LSd_REG, (A3)+
            BRA     LAST_STEP

IMMEDIATE_DATA  MOVE.B  #'#',(A3)+
                MOVE.B  #'$',(A3)+
                MOVE.W  LSd_REG,D7
                JSR     CONVERT_HEX_TO_STRING
                MOVE.W  D7,(A3)+
                

LAST_STEP   
            MOVE.L  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP