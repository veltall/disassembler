DECODE_Bcc  BRA     Bcc_CONDITION
            
            
Bcc_CONDITION   MOVE.L  D6, D5
            AND.L   #%0000111100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, CONDITION
            BRA     Bcc_DISPLACEMENT

Bcc_DISPLACEMENT   MOVE.L  D6, D5
            AND.L   #%0000000011111111, D5   
            LSR.L   #0, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DISPLACEMENT
            BRA     Bcc_PROCESS

Bcc_PROCESS JSR     DECODE_DISPLACEMENT     
            JSR     DECODE_EA_MODE
            BRA     Bcc_ARRANGE_OUTPUT