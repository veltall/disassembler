
DECODE_ROd  BRA     ROd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
            
ROd_COUNT/REG    MOVE.L  D6, D5
                AND.L   #%0000111000000000, D5   
                MOVE.B  #9, D1
                LSR.L   D1, D5                   * -- D5 contains the ss info
                MOVE.B  D5, ROd_REG       * -- Specifies direction of shift
                BRA     ROd_DIRECTION         
            
ROd_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000000010000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ROd_DIRECTION       * -- Specifies direction of shift
            BRA     ROd_SIZE
            
ROd_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ROd_SIZE       * -- Specifies direction of shift
            BRA     ROd_MODE           

ROd_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000100000, D5   * -- bits 3, 4, 5
            ASR.L   #5, D5
            MOVE.W  D5, EA_MODE
            BRA     ROd_REG

ROd_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            ASR.L   #0, D5
            MOVE.W  D5, EA_REG
            BRA     ROd_ARRANGE_OUTPUT

ROd_ARRANGE_OUTPUT            MOVE.B  #'R',(A3)+
            MOVE.B  #'O',(A3)+
            CMP.B   #0, ROd_DIRECTION
            BEQ     SHIFT_RIGHT 
            MOVE.B  #'L',(A3)+
            BRA     NEXT_STEP
            
SHIFT_RIGHT MOVE.B  #'R',(A3)+
            
 
NEXT_STEP   MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            CMP.B   #0, ROd_MODE
            BEQ     IMMEDIATE_DATA
            MOVE.B  #'D',(A3)+      *REGISTER
            MOVE.L  ROd_REG, (A3)+
            BRA     LAST_STEP

IMMEDIATE_DATA  MOVE.B  #'#',(A3)+
                MOVE.B  #'$',(A3)+
                MOVE.W  ROd_REG,D7
                JSR     CONVERT_HEX_TO_STRING
                MOVE.W  D7,(A3)+
                

LAST_STEP   
            MOVE.L  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP