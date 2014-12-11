DECODE_Bcc  BRA     Bcc_CONDITION
            
            
Bcc_CONDITION   MOVE.L  D6, D5
            AND.L   #%0000111100000000, D5   
            LSR.L   #8, D5
            MOVE.B  D5, CONDITION
            BRA     Bcc_DISPLACEMENT

Bcc_DISPLACEMENT    MOVE.L  D6, D5
            AND.L   #%0000000011111111, D5   
            MOVE.W  D5, DISPLACEMENT
            BRA     Bcc_PROCESS

Bcc_PROCESS JSR     DECODE_DISPLACEMENT
            BRA     Bcc_ARRANGE_OUTPUT
            
                        
Bcc_ARRANGE_OUTPUT  MOVE.B  #'B',(A3)+
            JSR     DECODE_CONDITION
            BRA     MAIN_LOOP_END

* -- mini subroutine
DECODE_CONDITION  MOVEM.L     D5, -(sp)
                  MOVE.B      CONDITION, D5  
                  CMP.B       #%0111, CONDITION
                  BEQ         Bcc_EQ
                  CMP.B       #%0110, CONDITION
                  BEQ         Bcc_NE
                  CMP.B       #%1101, CONDITION
                  BEQ         Bcc_LT
                  CMP.B       #%0010, CONDITION
                  BEQ         Bcc_HI
                  BRA         Bcc_INVALID

Bcc_INVALID       MOVE.B      #'?', (A3)+
                  MOVE.B      #'?', (A3)+
Bcc_EQ            MOVE.B      #'E', (A3)+
                  MOVE.B      #'Q', (A3)+
                  BRA         Bcc_DONE
Bcc_NE            MOVE.B      #'N', (A3)+
                  MOVE.B      #'E', (A3)+
                  BRA         Bcc_DONE
Bcc_LT            MOVE.B      #'L', (A3)+
                  MOVE.B      #'T', (A3)+
                  BRA         Bcc_DONE
Bcc_HI            MOVE.B      #'H', (A3)+
                  MOVE.B      #'I', (A3)+
                  BRA         Bcc_DONE
Bcc_DONE          MOVEM.L     (sp)+, D5
                  RTS