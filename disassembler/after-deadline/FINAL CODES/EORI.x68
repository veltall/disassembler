

DECODE_EORI  BRA     EORI_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
EORI_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5     
            MOVE.B  D5, SIZE
            BRA     EORI_MODE

EORI_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     EORI_REG

EORI_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
            MOVE.B  D5, EA_REG
            BRA     EORI_PROCESS

EORI_PROCESS JSR     DECODE_TWO_BIT_SIZE 
             JSR     DECODE_EA_MODE
             JSR     DECODE_IMMEDIATE_DATA    
             BRA     EORI_ARRANGE_OUTPUT
             
                        
EORI_ARRANGE_OUTPUT            MOVE.B  #'E',(A3)+
            MOVE.B  #'O',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.B  #'I',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            MOVE.B  #'#',(A3)+
            MOVE.B  #'$',(A3)+

            JSR     PRINT_IMMEDIATE_DATA

            BRA     MAIN_LOOP_END            

            CMP.B   #%10, PERSONAL_SIZE_CONVENTION
            BEQ     EORI_LONG_DATA
            CMP.B   #%00, PERSONAL_SIZE_CONVENTION
            BEQ     EORI_BYTE_DATA

            MOVE.W  (A6)+, D6       * IMMEDIATE DATA
            CMP.B   #%00, PERSONAL_SIZE_CONVENTION
            MOVE.W  D6, D7

EORI_CONT   JSR     CONVERT_HEX_TO_STRING 
            MOVE.L  D7,PRINT_BUFFER
            MOVE.B  #8,PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END

EORI_LONG_DATA    MOVE.L      (A6)+, D7
                  BRA         EORI_CONT
EORI_BYTE_DATA        
