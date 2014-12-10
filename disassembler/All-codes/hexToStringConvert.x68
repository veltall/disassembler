
CONVERT_HEX_TO_STRING   MOVEM.L     D0-D6, -(sp)
    
    * --- support only word-sized hex data in D7
    * --  D6 is designated as the container for the masked values
    * --  D5 is designated as the container for the summands
    * --  D4 is the container of the sum
    * --  D3 is the container of the length of the string
    * --  D0 is designated for on-the-fly arithmetic
    
    MOVE.B      #4, D3
    
CONVERT_HEX_TO_STRING_LOOP  CMP.B   #0, D3
    BEQ         HEX2STR_DONE
    
    MOVE.B      D3, D0
    SUB.B       #1, D0          * -- D3 - 1
    ASL.W       #2, D0          * -- (D3 - 1) * 4
    
    MOVE.W      D7, D6
    LSR.W       D0, D6          * -- shift 4*(n-1) bits to get the most
                                * -- significant digit at this time
    
    JSR         CONVERT_ONE_HEX
    
    * ------------------------------ D5 now contains the STR equivalent of
    *                                D6, shift this char into position and loop
    
    ASL.W       #1, D0          * (D3 - 1) * 8
    LSL.L       D0, D5
    ADD.L       D5, D4
    SUB.B       #1, D3
    BRA         CONVERT_HEX_TO_STRING_LOOP
    
HEX2STR_DONE    MOVE.L      D4, D7          * -- write result over input
                MOVEM.L     (sp)+, D0-D6
                RTS
                
CONVERT_ONE_HEX CMP.B   #$0, D5
                BLT     INVALID_HEX_CONVERT
                CMP.B   #$9, D5
                BGT     CONVERT_ONE_HEX_NAN
                ADD.B   #$30, D5            * -- D5 has number chars, add $30
                BRA     DONE_CONVERT
                
INVALID_HEX_CONVERT     BRA     DONE_CONVERT

CONVERT_ONE_HEX_NAN     CMP.B   #$A, D5
                        BLT     INVALID_HEX_CONVERT
                        CMP.B   #$F, D5
                        BGT     INVALID_HEX_CONVERT
                        ADD.B   #$37, D5    * -- D5 is a "letter" hex value
                                            * -- add 0x37
                        BRA     DONE_CONVERT
                        
DONE_CONVERT    RTS