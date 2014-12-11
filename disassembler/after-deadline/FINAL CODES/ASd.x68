
DECODE_ASd  BRA     ASd_DIRECTION
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
            
ASd_COUNT/REG    MOVE.L  D6, D5
                AND.L   #%0000111000000000, D5   
                MOVE.B  #9, D1
                LSR.L   D1, D5                   * -- D5 contains the ss info
                MOVE.B  D5, ASd_REG       * -- Specifies direction of shift
                BRA     ASd_DIRECTION         
            
ASd_DIRECTION   MOVE.L  D6, D5
            AND.L   #%0000000010000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ASd_DIRECTION       * -- Specifies direction of shift
            BRA     ASd_SIZE
            
ASd_SIZE    MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            ASR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, ASd_SIZE       * -- Specifies direction of shift
            BRA     ASd_MODE           

ASd_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000100000, D5   * -- bits 3, 4, 5
            ASR.L   #5, D5
            MOVE.W  D5, EA_MODE
            BRA     ASd_REG

ASd_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
 
            MOVE.W  D5, EA_REG
            BRA     ASd_ARRANGE_OUTPUT

ASd_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'S',(A3)+
            CMP.B   #0, ASd_DIRECTION
            BEQ     SHIFT_RIGHT 
            MOVE.B  #'L',(A3)+
            BRA     NEXT_STEP
            
SHIFT_RIGHT MOVE.B  #'R',(A3)+
            
 
NEXT_STEP   MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            CMP.B   #0, ASd_MODE
            BEQ     IMMEDIATE_DATA
            MOVE.B  #'D',(A3)+      *REGISTER
            MOVE.L  ASd_REG, (A3)+
            BRA     LAST_STEP

IMMEDIATE_DATA  MOVE.B  #'#',(A3)+
                MOVE.B  #'$',(A3)+
                MOVE.W  ASd_REG,D7
                JSR     CONVERT_HEX_TO_STRING
                MOVE.W  D7,(A3)+
                

LAST_STEP   
            MOVE.L  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
            MOVE.L  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MAIN_LOOP
            
           
* -- precondition: requires the length of the stuff to be printed stored in PRINT_SIZE
* --               the content (at the front of the storage buffer) is appended to (A3)+ 
PRINT_STUFF     MOVEM.L     D0/A4, -(sp)
                MOVE.B      PRINT_SIZE, D0
                MOVEA.L     PRINT_BUFFER, A4
PRINT_LOOP      CMP.B       #0, D0
                BEQ         PRINT_DONE
                MOVE.B      (A4)+, (A3)+
                SUB.B       #1, D0
                BRA         PRINT_LOOP

PRINT_DONE      MOVEM.L     (sp)+, D0/A4
                RTS
          
            
            
            
            


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
