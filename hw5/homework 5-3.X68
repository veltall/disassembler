*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $400
START:                  ; first instruction of program

PROMPT      LEA     MESSAGE1, A1
            MOVE.B  #14,D0
            TRAP    #15


CONVERT_START_LOCATION  CLR     D1
                        MOVEA.L #$7000,A1
                        MOVE.B  #2,D0   * --- read NULL-terminated string
                        TRAP    #15     * --- read string into (A1)
                        MOVEA.L A1,A3   * --- make a copy to preserve original input
END_CONVERT_START_LOCATION  BSR     CONVERT_LOOP
                            bra afterconvert

* ---------------- convert string into hex
* -- pre-condition:     (A3) points to the top of the STR stack

CONVERT_LOOP            CMP.W   #0,D1
                        BEQ     END_CONVERT_LOOP        * -- done converting whole string
                        BSR     CONVERT_STR_TO_HEX
                        SUB.B   #1,D1
                        BRA     CONVERT_LOOP
END_CONVERT_LOOP        RTS     * -- return to main flow

* -------------------------------------------------------------------------
* ------- SUBROUTINE Convert ONE Character into ONE HEX value -------------

CONVERT_STR_TO_HEX      MOVE.B  (A3)+,D3    * -- pop one character
                        CMP.B   #$30,D3     * -- #$30 is the character '0'
                        BEQ     STR_TO_HEX_ZERO

                        CMP.B   #$31,D3
                        BEQ     STR_TO_HEX_ONE
                        
                        CMP.B   #$32,D3
                        BEQ     STR_TO_HEX_TWO
                        
                        CMP.B   #$33,D3
                        BEQ     STR_TO_HEX_THREE
                        
                        CMP.B   #$34,D3
                        BEQ     STR_TO_HEX_FOUR
                        
                        CMP.B   #$35,D3
                        BEQ     STR_TO_HEX_FIVE
                        
                        CMP.B   #$36,D3
                        BEQ     STR_TO_HEX_SIX
                        
                        CMP.B   #$37,D3
                        BEQ     STR_TO_HEX_SEVEN
                        
                        CMP.B   #$38,D3
                        BEQ     STR_TO_HEX_EIGHT
                        
                        CMP.B   #$39,D3             * -- #$39 is the character '9'
                        BEQ     STR_TO_HEX_NINE
                        
                        CMP.B   #$41,D3             * -- #$41 is the character 'A'
                        BEQ     STR_TO_HEX_A
                        CMP.B   #$61,D3             * -- #$61 is the character 'a'
                        BEQ     STR_TO_HEX_A

                        CMP.B   #$42,D3
                        BEQ     STR_TO_HEX_B
                        CMP.B   #$62,D3
                        BEQ     STR_TO_HEX_B
                        
                        CMP.B   #$43,D3
                        BEQ     STR_TO_HEX_C
                        CMP.B   #$63,D3
                        BEQ     STR_TO_HEX_C

                        CMP.B   #$44,D3
                        BEQ     STR_TO_HEX_D
                        CMP.B   #$64,D3
                        BEQ     STR_TO_HEX_D
                        
                        CMP.B   #$45,D3
                        BEQ     STR_TO_HEX_E
                        CMP.B   #$65,D3
                        BEQ     STR_TO_HEX_E
                        
                        CMP.B   #$46,D3
                        BEQ     STR_TO_HEX_F
                        CMP.B   #$66,D3
                        BEQ     STR_TO_HEX_F

                        BRA     INVALID_CHARACTER

* --------------- Conversion definitions ------------

INVALID_CHARACTER       NOP              * -- skip invalid character
                        RTS
STR_TO_HEX_ZERO         MOVE.L  #$0,D3   * -- push HEX 0 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_ONE          MOVE.L  #$1,D3   * -- push HEX 1 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_TWO          MOVE.L  #$2,D3   * -- push HEX 2 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_THREE        MOVE.L  #$3,D3   * -- push HEX 3 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_FOUR         MOVE.L  #$4,D3   * -- push HEX 4 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_FIVE         MOVE.L  #$5,D3   * -- push HEX 5 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_SIX          MOVE.L  #$6,D3   * -- push HEX 6 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_SEVEN        MOVE.L  #$7,D3   * -- push HEX 7 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_EIGHT        MOVE.L  #$8,D3   * -- push HEX 8 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_NINE         MOVE.L  #$9,D3   * -- push HEX 9 into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_A            MOVE.L  #$A,D3   * -- push HEX A into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_B            MOVE.L  #$B,D3   * -- push HEX B into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_C            MOVE.L  #$C,D3   * -- push HEX C into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_D            MOVE.L  #$D,D3   * -- push HEX D into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_E            MOVE.L  #$E,D3   * -- push HEX E into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS
STR_TO_HEX_F            MOVE.L  #$F,D3   * -- push HEX F into HEX stack
                        BSR     SHIFT_START_ADDR
                        ADD.L   D3,D4
                        RTS

SHIFT_START_ADDR        CLR     D7
                        MOVE.W  D1,D7
                        SUB.W   #1,D7
                        ASL     #2,D7   * -- D7 = (D1 - 1) * 4
                        ASL.L   D7,D3
END_SHIFT_START_ADDR    RTS


afterconvert    MOVE.L  D4, USERNUMBER

        CMP.L   #$0, D4
        BLT     NEGATIVE
CONT    MOVE.B  #23, D0
        ASR.L   D0, D4
        MOVE.L  D4, D6      *EXPONENT NUMBER FOR OUTPUT AT D6
        MOVE.L  D5, D7
        ASL.L   D0, D4
        SUB.L   D4, D7 
        CLR     D1       

LOOP    CMP.B   #0, D0
        BEQ     ROTATE_DONE
        ROR.L   #1, D7
        BCS     INCREMENT
CONT2   SUB.B   #1, D0
        BRA     LOOP
        
INCREMENT   ADD.B   #1, D1  *MANTISSA NUMBER 1 COUNT
            BRA     CONT2
            
ROTATE_DONE BRA     END_PROGRAM
               
        
        
        
        
NEGATIVE    MOVE.L  D4, D5
            MOVE.B  #1, D3          *SIGN BIT! AT D3
            SUB.L   #$80000000, D4
            BRA     CONT
            
            
END_PROGRAM  CLR    D2       
         
        
    SIMHALT        
        
    

* Put variables and constants here

MESSAGE1    DC.B        'Please enter IEEE 32-bit floating point number in hexadecimal: ',0
USERNUMBER  DS.B        8   * -- 8 bytes for a complete longword hex value

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
