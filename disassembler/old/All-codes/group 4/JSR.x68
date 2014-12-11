DECODE_JSR  BRA     JSR_MODE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

JSR_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.W  D5, EA_MODE     *DESTINATION
            BRA     JSR_REG

JSR_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            LSR.L   #0, D5                
            MOVE.W  D5, EA_REG       *DESTINATION
            BRA     JSR_ARRANGE_OUTPUT
