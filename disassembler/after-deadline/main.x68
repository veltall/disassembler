*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here


PROGRAMLOOP BSR     CLEAR_ALL   * ---- clear registers

            * -- read string of starting address
            BSR     CONVERT_START_LOCATION
            * -- post-condition: the address as specified by the user input is stored in D4

            SUBA.W  #4, A3
            BRA     MAINLOOP_PRIME

CLEAR_ALL   CLR     D0
            CLR     D1
            CLR     D2
            CLR     D3
            CLR     D4
            CLR     D5
            CLR     D6
            CLR     D7
            RTS

CONVERT_START_LOCATION  CLR     D1
                        MOVEA.L #$7000,A1
                        MOVE.B  #2,D0   * --- read NULL-terminated string
                        TRAP    #15     * --- read string into (A1)
                        MOVEA.L A1,A3   * --- make a copy to preserve original input
END_CONVERT_START_LOCATION  BSR     CONVERT_LOOP
                        RTS

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

* ---------------- load starting hex into A6
MAINLOOP_PRIME          MOVEA.L D4,A6     * -- address cannot be longer than LONG-size
                        BRA     MAIN_LOOP

* ---------------- read one word and decode
MAIN_LOOP    CMP.W      #$FFFF, D6
             BEQ        AFTER_MAIN_LOOP
             JSR        FLUSH_OUTPUT_BUFFER

    * ----- read data from (A6)+ into D6
    CLR         D6
    MOVEA.W     A3, A1
    MOVE.W      (A6)+, D6
    
    * ----- process data in D6
    BRA     DECODE_OPCODE

MAIN_LOOP_END   MOVE.B  #0, (A3)+
                MOVE.B  #13, D0
                TRAP    #15    
       
                BRA MAIN_LOOP

* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ------------------------------------------------------- OP CODE ------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------


* -- Preconditions: The instruction as read from memory is stored in D6


* -- Preconditions: The instruction as read from memory is stored in D6

DECODE_OPCODE       MOVE.W      D6, D5                  * -- make copy
                    AND.W       #$F000, D5              * -- mask opcode
                    MOVE.B      #12, D1
                    LSR.L       D1, D5 

IDENT_OPCODE        CMP.B       #%0110, D5
                    BEQ         DECODE_GROUP_6
                    CMP.B       #%0100, D5
                    BEQ         DECODE_GROUP_4
                    CMP.B       #%1100, D5
                    BEQ         DECODE_GROUP_C
                    CMP.B       #%1101, D5
                    BEQ         DECODE_GROUP_D
                    CMP.B       #%1001, D5
                    BEQ         DECODE_GROUP_9
                    CMP.B       #%0101, D5
                    BEQ         DECODE_GROUP_5
                    CMP.B       #%1000, D5
                    BEQ         DECODE_GROUP_8
                    CMP.B       #%0001, D5
                    BEQ         DECODE_GROUP_MOVE
                    CMP.B       #%0010, D5
                    BEQ         DECODE_GROUP_MOVE
                    CMP.B       #%0011, D5
                    BEQ         DECODE_GROUP_MOVE
                    BRA         INVALID_OPCODE

INVALID_OPCODE      BRA         DECODE_OPCODE_DONE

DECODE_OPCODE_DONE  BRA         MAIN_LOOP_END

DECODE_GROUP_MOVE   MOVE.W      D6, D5
                    AND.W       #$01C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%001, D5
                    BEQ         DECODE_MOVEA
                    BRA         DECODE_MOVE

DECODE_GROUP_8      MOVE.W      D6, D5
                    AND.W       #$01C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%111, D5
                    BEQ         DECODE_DIVS
                    BRA         INVALID_OPCODE 

DECODE_GROUP_5      MOVE.W      D6, D5
                    AND.W       #$0100, D5
                    LSR.W       #8, D5
                    CMP.B       #0, D5
                    BEQ         DECODE_ADDQ
                    BRA         INVALID_OPCODE  

DECODE_GROUP_9      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_SUBA
                    BRA         DECODE_SUB                                                         

DECODE_GROUP_D      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_ADDA
                    BRA         DECODE_ADD

DECODE_GROUP_C      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_MULS
                    BRA         DECODE_AND

DECODE_GROUP_4      MOVE.W      D6, D5                  * -- recover the data
                    CMP.W       #$4E75, D5
                    BEQ         DECODE_RTS

                    AND.W       #$0FC0, D5              * -- mask #1
                    LSR.W       #6, D5

                    CMP.W       #%111010, D5
                    BEQ         DECODE_JSR

                    AND.W       #$07, D5                * -- mask #2

                    CMP.W       #%111, D5
                    *BEQ         DECODE_LEA

                    MOVE.W      D6, D5                  * -- recover data
                    AND.W       #$0800, D5              * -- mask #3
                    MOVE.B      #11, D1
                    LSR.W       D1, D5
                    CMP.B       #1, D5
                    *BEQ         DECODE_MOVEM

                    MOVE.W      D6, D5                  * -- recover data
                    AND.W       #$0E00, D5              * -- mask #4
                    MOVE.B      #9, D1
                    LSR.W       D1, D5
                    CMP.B       #%010, D5
                    BEQ         DECODE_NEG
                    CMP.B       #%011, D5
                    BEQ         DECODE_NOT
                    BRA         INVALID_OPCODE

DECODE_GROUP_6      MOVE.W      D6, D5
                    AND.W       #$0F00, D5
                    LSR.W       #8, D5
                    CMP.B       #0, D5
                    BNE         DECODE_Bcc
                    BRA         DECODE_BRA

* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------- END OP CODE ------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------





* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------- EFFECTIVE ADDRESS ------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------

DECODE_MOVEA    BRA INVALID_OPCODE

DECODE_MOVE  BRA     MOVE_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
MOVE_SIZE   MOVE.L  D6, D5
            AND.L   #%0011000000000000, D5   
            MOVE.B  #12, D1
            LSR.L   D1, D5                  * -- D5 contains the ss info
            MOVE.B  D5, WEIRD_SIZE
            BRA     MOVE_DEST_REG

MOVE_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     MOVE_DEST_MODE    

MOVE_DEST_MODE  MOVE.L  D6, D5
            AND.L   #%0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DEST_MODE
            BRA     MOVE_MODE                      

MOVE_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     MOVE_REG

MOVE_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5
            MOVE.B  D5, EA_REG
            BRA     MOVE_PROCESS

MOVE_PROCESS JSR     DECODE_WEIRD_SIZE
            JSR     DECODE_EA_MODE
            JSR     DECODE_DEST_MODE
            BRA     MOVE_ARRANGE_OUTPUT

MOVE_ARRANGE_OUTPUT     MOVE.B            #'M', (A3)+
                        MOVE.B            #'O', (A3)+
                        MOVE.B            #'V', (A3)+
                        MOVE.B            #'E', (A3)+
                        MOVE.L            WEIRD_SIZE_OUT, PRINT_BUFFER
                        MOVE.B            #2, PRINT_SIZE
                        JSR               PRINT_STUFF

                        JSR               PRINT_EA_MODE
                        MOVE.B            #',', (A3)+
                        JSR               PRINT_DEST_MODE

                        BRA               MAIN_LOOP_END


********************************** DIVS

DECODE_DIVS  BRA     DIVS_DEST_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
DIVS_DEST_REG   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                   * -- D5 contains the ss info
            MOVE.B  D5, DEST_REG
            BRA     DIVS_MODE

DIVS_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     DIVS_REG

DIVS_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     DIVS_PROCESS

DIVS_PROCESS      JSR         DECODE_DEST_REG
                  JSR         DECODE_EA_MODE
                  BRA         DIVS_ARRANGE_OUTPUT

DIVS_ARRANGE_OUTPUT            MOVE.B  #'D',(A3)+
            MOVE.B  #'I',(A3)+
            MOVE.B  #'V',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'.',(A3)+
            MOVE.B  #'W',(A3)+
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
*            MOVE.L  DEST_REG_OUT, PRINT_BUFFER
*            MOVE.L  #1, PRINT_SIZE
*            JSR     PRINT_STUFF
            MOVE.B  DEST_REG_OUT, (A3)+
            BRA     MAIN_LOOP_END

***************************** END DIVS                      

******************************START ADDQ

DECODE_ADDQ  BRA     ADDQ_DATA
            
 
ADDQ_DATA   MOVE.L  D6, D5
            AND.L   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                   * -- D5 contains the ss info
            MOVE.B  D5, DATA
            BRA     ADDQ_SIZE


ADDQ_SIZE   MOVE.L  D6, D5
            AND.L   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADDQ_MODE

ADDQ_MODE    MOVE.L  D6, D5
            AND.L   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     ADDQ_REG

ADDQ_REG     MOVE.L  D6, D5
            AND.L   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     ADDQ_PROCESS

ADDQ_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- ADDQ supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
             JSR    DECODE_DATA
            JSR     DECODE_EA_MODE
            BRA     ADDQ_ARRANGE_OUTPUT            
            
                        
ADDQ_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'Q',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            MOVE.B  #'#',(A3)+
            MOVE.B  #'$',(A3)+
            MOVE.B  DATA_OUT, (A3)+
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END

************************* END ADDQ **************

************************** START SUB**************
DECODE_SUB  BRA     SUB_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUB 7

SUB_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     SUB_DIR

SUB_DIR     MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     SUB_SIZE

SUB_SIZE    MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUB_MODE

SUB_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     SUB_REG

SUB_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     SUB_PROCESS

SUB_PROCESS JSR         DECODE_SRC_REG
         JSR         DECODE_TWO_BIT_SIZE
            JSR         DECODE_EA_MODE
             BRA         SUB_ARRANGE_OUTPUT                       * -- 2 bits for SIZ
            
            
SUB_ARRANGE_OUTPUT            MOVE.B  #'S',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'B',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #1,DIRECTION
            BEQ     SUB_REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
          
            
SUB_REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END
            
***************************END SUB*******************       
 


************************************ START SUBA

DECODE_SUBA  BRA     SUBA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 SUBA 7

SUBA_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
           MOVE.B  #9, D1
            LSR.L   D1, D5                
            MOVE.B  D5, SRC_REG
            BRA     SUBA_SIZE

SUBA_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     SUBA_MODE

SUBA_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- THis is the source!
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     SUBA_REG

SUBA_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5      * -- Source!

            MOVE.B  D5, EA_REG
            BRA     SUBA_PROCESS

SUBA_PROCESS JSR        DECODE_SRC_REG 
            JSR     DECODE_ONE_BIT_SIZE     * -- SUBA supports byte, word, SUBA long so it needs
                                            * -- 3 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     SUBA_ARRANGE_OUTPUT
            
            
SUBA_ARRANGE_OUTPUT            MOVE.B  #'S',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'B',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF

            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END



************************************* END SUBA


***************************** START ADD 


DECODE_ADD  BRA     ADD_SRC_REG
            
      
ADD_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG               *THIS IS USED FOR THE Dn 
            BRA     ADD_DIR              *Dn CAN BE DESTINATION OR SOURCE

ADD_DIR     MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     ADD_SIZE

ADD_SIZE    MOVE.L  D6, D5
            AND.W   #%0000000111000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADD_MODE

ADD_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     ADD_REG

ADD_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
   
            MOVE.B  D5, EA_REG
            BRA     ADD_PROCESS

ADD_PROCESS JSR     DECODE_SRC_REG
            JSR     DECODE_TWO_BIT_SIZE     * -- ADD supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADD_ARRANGE_OUTPUT
            
            
                        
ADD_ARRANGE_OUTPUT  MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BNE     ADD_REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            
ADD_REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END



****************************** END ADD

********************************* START ADDA

DECODE_ADDA  BRA     ADDA_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
ADDA_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG               *THIS IS USED FOR THE Dn 
            BRA     ADDA_SIZE              *Dn CAN BE DESTINATION OR SOURCE

ADDA_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     ADDA_MODE            

ADDA_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     ADDA_REG

ADDA_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
 
            MOVE.B  D5, EA_REG
            BRA     ADDA_PROCESS

ADDA_PROCESS JSR    DECODE_SRC_REG 
            JSR     DECODE_ONE_BIT_SIZE     * -- ADDA supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     ADDA_ARRANGE_OUTPUT
            
            
ADDA_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            
            
************************** END ADDA


************************** START AND

DECODE_AND  BRA     AND_SRC_REG
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

AND_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
             MOVE.B  #9, D1
            LSR.L   D1, D5                * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     AND_SIZE

AND_DIR     MOVE.L  D6, D5
            AND.W   #%0000000100000000, D5   
            LSR.L   #8, D5                  * -- D5 contains the ss info
            MOVE.B  D5, DIRECTION
            BRA     AND_MODE

AND_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     AND_MODE

AND_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     AND_REG

AND_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
  
            MOVE.B  D5, EA_REG
            BRA     AND_PROCESS

AND_PROCESS JSR         DECODE_SRC_REG
         JSR         DECODE_TWO_BIT_SIZE
            JSR         DECODE_EA_MODE
             BRA         AND_ARRANGE_OUTPUT
            
            
AND_ARRANGE_OUTPUT            MOVE.B  #'A',(A3)+
            MOVE.B  #'N',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            
            CMP.B   #0,DIRECTION
            BNE     AND_REG_FIRST
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
                   
AND_REG_FIRST   MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            MOVE.B  #',',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END
            
*************************************** END AND

*********************************** START MULS


* ------------- SUPPORT ONLY WORD-SIZED DATA
DECODE_MULS  BRA     MULS_SRC_REG
            
            
MULS_SRC_REG   MOVE.L  D6, D5
            AND.W   #%0000111000000000, D5   
            MOVE.B  #9, D1
            LSR.L   D1, D5                 * -- D5 contains the ss info
            MOVE.B  D5, SRC_REG
            BRA     MULS_MODE

MULS_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     MULS_REG

MULS_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
       
            MOVE.B  D5, EA_REG
            BRA     MULS_PROCESS

MULS_PROCESS JSR        DECODE_SRC_REG
            JSR         DECODE_EA_MODE

            BRA   MULS_ARRANGE_OUTPUT


MULS_ARRANGE_OUTPUT            MOVE.B  #'M',(A3)+
            MOVE.B  #'U',(A3)+
            MOVE.B  #'L',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'.',(A3)+
            MOVE.B  #'W',(A3)+
            JSR     PRINT_EA_MODE
            MOVE.B  #',',(A3)+
            MOVE.B  #'D',(A3)+
            MOVE.L  SRC_REG_OUT, PRINT_BUFFER
            MOVE.B  #1, PRINT_SIZE
            JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END

******************************************* END MULS

*************************************** START NOT

DECODE_NOT  BRA     NOT_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
NOT_SIZE    MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     NOT_MODE

NOT_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     NOT_REG

NOT_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     NOT_PROCESS

NOT_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- NOT supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     NOT_ARRANGE_OUTPUT 
            
            
NOT_ARRANGE_OUTPUT                        
            MOVE.B  #'N',(A3)+
            MOVE.B  #'O',(A3)+
            MOVE.B  #'T',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END

**************************************** END NOT

**************************************** START NEG

DECODE_NEG  BRA     NEG_SIZE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7
NEG_SIZE   MOVE.L  D6, D5
            AND.W   #%0000000011000000, D5   
            LSR.L   #6, D5                  * -- D5 contains the ss info
            MOVE.B  D5, SIZE
            BRA     NEG_MODE

NEG_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE
            BRA     NEG_REG

NEG_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5

            MOVE.B  D5, EA_REG
            BRA     NEG_PROCESS

NEG_PROCESS JSR     DECODE_TWO_BIT_SIZE     * -- NEG supports byte, word, and long so it needs
                                            * -- 2 bits for SIZE
            JSR     DECODE_EA_MODE
            BRA     NEG_ARRANGE_OUTPUT
            
            
                        
NEG_ARRANGE_OUTPUT  MOVE.B  #'N',(A3)+
            MOVE.B  #'E',(A3)+
            MOVE.B  #'G',(A3)+
            MOVE.L  SIZE_OUT, PRINT_BUFFER
            MOVE.B  #2, PRINT_SIZE
            JSR     PRINT_STUFF
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END

**************************************** END NEG

*************************************** START RTS

DECODE_RTS  MOVE.B  #'R', (A3)+
            MOVE.B  #'T', (A3)+
            MOVE.B  #'S', (A3)+
            BRA     MAIN_LOOP_END

*************************************** END RTS

************************************** START JSR

DECODE_JSR  BRA     JSR_MODE
            
            * -- chop the bits
            * -- 1/ bits 6 and 7

JSR_MODE    MOVE.L  D6, D5
            AND.W   #%0000000000111000, D5   * -- bits 3, 4, 5
            LSR.L   #3, D5
            MOVE.B  D5, EA_MODE     *DESTINATION
            BRA     JSR_REG

JSR_REG     MOVE.L  D6, D5
            AND.W   #%0000000000000111, D5
               
            MOVE.B  D5, EA_REG       *DESTINATION
            BRA     JSR_PROCESS

JSR_PROCESS JSR      DECODE_EA_MODE
            BRA      JSR_ARRANGE_OUTPUT


JSR_ARRANGE_OUTPUT            MOVE.B  #'J',(A3)+
            MOVE.B  #'S',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.B  #' ',(A3)+
            JSR     PRINT_EA_MODE
            BRA     MAIN_LOOP_END

************************************** END JSR

************************************* START BRA

DECODE_BRA  BRA     BRA_DISPLACEMENT
            
           
BRA_DISPLACEMENT    MOVE.L  D6, D5
            AND.W   #%0000000011111111, D5   

            MOVE.W  D5, DISPLACEMENT
            BRA     BRA_PROCESS

BRA_PROCESS JSR     DECODE_DISPLACEMENT 
            BRA     BRA_ARRANGE_OUTPUT
            
BRA_ARRANGE_OUTPUT            MOVE.B  #'B',(A3)+
            MOVE.B  #'R',(A3)+
            MOVE.B  #'A',(A3)+
            MOVE.B  #' ',(A3)+
            MOVE.B  #'$',(A3)+

            MOVE.L  DISPLACEMENT_OUT, PRINT_BUFFER
            CMP.B   #%00, PERSONAL_SIZE_CONVENTION
            BEQ     BRA_8_BITS
            MOVE.B  #16, PRINT_SIZE
            BRA     PRINT_BRA
BRA_8_BITS  MOVE.B  #8, PRINT_SIZE
PRINT_BRA   JSR     PRINT_STUFF
            BRA     MAIN_LOOP_END
            

**************************************** END BRA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; START Bcc

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
            MOVE.B  #' ', (A3)+
            MOVE.B  #'$', (A3)+

            MOVE.L  DISPLACEMENT_OUT, PRINT_BUFFER
            CMP.B   #%00, PERSONAL_SIZE_CONVENTION
            BEQ     Bcc_8_BITS
            MOVE.B  #16, PRINT_SIZE
            BRA     PRINT_Bcc
Bcc_8_BITS  MOVE.B  #8, PRINT_SIZE
PRINT_Bcc   JSR     PRINT_STUFF
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END Bcc

* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------- END EFFECTIVE ADDRESS ------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------




* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------- OUTPUT PROCESSING ------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------


* -- pre-conditions: Address SIZE loaded with correct input

* -- Purpose: Decode a typical 2-bit SIZE field (byte, word, long)

* -- 1. process data
DECODE_WEIRD_SIZE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #WEIRD_SIZE_OUT, A5
                MOVE.B      WEIRD_SIZE, D5
                
                CMP.B       #%01, D5
                BEQ         WEIRD_SIZE_BYTE
                CMP.B       #%11, D5
                BEQ         WEIRD_SIZE_WORD
                CMP.B       #%10, D5
                BEQ         WEIRD_SIZE_LONG
                BRA         WEIRD_SIZE_INVALID
                
* -- 2. Respond to data

WEIRD_SIZE_INVALID     BRA     DECODE_WEIRD_SIZE_DONE

DECODE_WEIRD_SIZE_DONE    MOVEM.L (sp)+, D4-D5/A5
                    RTS

WEIRD_SIZE_BYTE        MOVE.B      #'.', (A5)+
                    MOVE.B      #'B', (A5)+
                    MOVE.B      #0, PERSONAL_SIZE_CONVENTION
                    BRA         DECODE_WEIRD_SIZE_DONE

WEIRD_SIZE_WORD        MOVE.B      #'.', (A5)+
                    MOVE.B      #'W', (A5)+
                    MOVE.B      #1, PERSONAL_SIZE_CONVENTION
                    BRA         DECODE_WEIRD_SIZE_DONE

WEIRD_SIZE_LONG        MOVE.B      #'.', (A5)+
                    MOVE.B      #'L', (A5)+
                    MOVE.B      #2, PERSONAL_SIZE_CONVENTION
                    BRA         DECODE_WEIRD_SIZE_DONE

* -------------------------------------------------------


* -- pre-conditions: Address DEST_MODE loaded with correct input
* --                 Address DEST_REG  loaded with correct input
* --                 If mode is Immediate Data, need data size
* --                 stored in PERSONAL_SIZE_CONVENTION (0 = byte, 1 = word, anything else = long)

* -- Purpose: Decode a typical deSt_mode (Data register, Address register, etc.)

* -- 1. process data
DECODE_DEST_MODE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #DEST_MODE_OUT, A5
                MOVE.B      DEST_MODE, D5
                
                CMP.B       #%000, D5
                BEQ         DEST_MODE_DREG
                CMP.B       #%001, D5
                BEQ         DEST_MODE_AREG_DIR
                CMP.B       #%010, D5
                BEQ         DEST_MODE_AREG_INDIR
                CMP.B       #%011, D5
                BEQ         DEST_MODE_AREG_INDIR_INC
                CMP.B       #%100, D5
                BEQ         DEST_MODE_AREG_INDIR_DEC
                CMP.B       #%111, D5
                BEQ         DEST_MODE_SPECIAL
                BRA         DEST_MODE_INVALID
                
* -- 2. Respond to data

DEST_MODE_INVALID     BRA     DECODE_DEST_DONE

DECODE_DEST_DONE      MOVEM.L (sp)+, D4-D5/A5
                    RTS

DEST_MODE_DREG        MOVE.B      #'D', (A5)+
                    JSR         DECODE_DEST_REG
                    BRA         DECODE_DEST_DONE

DEST_MODE_AREG_DIR    MOVE.B      #'A', (A5)+
                    JSR         DECODE_DEST_REG
                    BRA         DECODE_DEST_DONE

DEST_MODE_AREG_INDIR  MOVE.B      #'(', (A5)+
                    MOVE.B      #'A', (A5)+
                    JSR         DECODE_DEST_REG
                    MOVE.B      #')', (A5)+
                    BRA         DECODE_DEST_DONE

DEST_MODE_AREG_INDIR_INC  MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_DEST_REG
                        MOVE.B      #')', (A5)+
                        MOVE.B      #'+', (A5)+
                        BRA         DECODE_DEST_DONE

DEST_MODE_AREG_INDIR_DEC  MOVE.B      #'-', (A5)+
                        MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_DEST_REG
                        MOVE.B      #')', (A5)+
                        BRA         DECODE_DEST_DONE

* -- relies on the address DEST_REG to be loaded with good data

DEST_MODE_SPECIAL     MOVE.B      DEST_REG, D5
                    CMP.B       #%000, D5
                    BEQ         DEST_MODE_DIR_W
                    CMP.B       #%001, D5
                    BEQ         DEST_MODE_DIR_L
                    CMP.B       #%100, D5
                    BEQ         DEST_MODE_IMME_DATA
                    BRA         DEST_MODE_INVALID

* -- direct addressing mode, word-sized address
DEST_MODE_DIR_W     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_DEST_DONE

DEST_MODE_DIR_L     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_DEST_DONE

DEST_MODE_IMME_DATA MOVE.B      PERSONAL_SIZE_CONVENTION, D0
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B      #'#', (A5)+
                    MOVE.B      #'$', (A5)+
                    CMP.B       #%00, D0
                    BEQ         DEST_IMME_DATA_BYTE
                    CMP.B       #%01, D0
                    BEQ         DEST_IMME_DATA_WORD
                    BRA         DEST_IMME_DATA_LONG

DEST_IMME_DATA_BYTE      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_DEST_DONE

DEST_IMME_DATA_WORD      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_DEST_DONE

DEST_IMME_DATA_LONG      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_DEST_DONE

* ---------------------------------------------------------

* -- pre-conditions: Address EA_MODE loaded with correct input
* --                 Address EA_REG  loaded with correct input
* --                 If mode is Immediate Data, need data size
* --                 stored in PERSONAL_SIZE_CONVENTION (0 = byte, 1 = word, anything else = long)

* -- Purpose: Decode a typical ea_mode (Data register, Address register, etc.)

* -- 1. process data
DECODE_EA_MODE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #EA_MODE_OUT, A5
                MOVE.B      EA_MODE, D5
                
                CMP.B       #%000, D5
                BEQ         EA_MODE_DREG
                CMP.B       #%001, D5
                BEQ         EA_MODE_AREG_DIR
                CMP.B       #%010, D5
                BEQ         EA_MODE_AREG_INDIR
                CMP.B       #%011, D5
                BEQ         EA_MODE_AREG_INDIR_INC
                CMP.B       #%100, D5
                BEQ         EA_MODE_AREG_INDIR_DEC
                CMP.B       #%111, D5
                BEQ         EA_MODE_SPECIAL
                BRA         EA_MODE_INVALID
                
* -- 2. Respond to data

EA_MODE_INVALID     BRA     DECODE_EA_DONE

DECODE_EA_DONE      MOVEM.L (sp)+, D4-D5/A5
                    RTS

EA_MODE_DREG        MOVE.B      #'D', (A5)+
                    JSR         DECODE_EA_REG
                    BRA         DECODE_EA_DONE

EA_MODE_AREG_DIR    MOVE.B      #'A', (A5)+
                    JSR         DECODE_EA_REG
                    BRA         DECODE_EA_DONE

EA_MODE_AREG_INDIR  MOVE.B      #'(', (A5)+
                    MOVE.B      #'A', (A5)+
                    JSR         DECODE_EA_REG
                    MOVE.B      #')', (A5)+
                    BRA         DECODE_EA_DONE

EA_MODE_AREG_INDIR_INC  MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_EA_REG
                        MOVE.B      #')', (A5)+
                        MOVE.B      #'+', (A5)+
                        BRA         DECODE_EA_DONE

EA_MODE_AREG_INDIR_DEC  MOVE.B      #'-', (A5)+
                        MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_EA_REG
                        MOVE.B      #')', (A5)+
                        BRA         DECODE_EA_DONE

* -- relies on the address EA_REG to be loaded with good data

EA_MODE_SPECIAL     MOVE.B      EA_REG, D5
                    CMP.B       #%000, D5
                    BEQ         EA_MODE_DIR_W
                    CMP.B       #%001, D5
                    BEQ         EA_MODE_DIR_L
                    CMP.B       #%100, D5
                    BEQ         EA_MODE_IMME_DATA
                    BRA         EA_MODE_INVALID

* -- direct addressing mode, word-sized address
EA_MODE_DIR_W     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_EA_DONE

EA_MODE_DIR_L     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_EA_DONE

EA_MODE_IMME_DATA MOVE.B      PERSONAL_SIZE_CONVENTION, D0
                    MOVE.B      #' ', (A5)+
                    MOVE.B      #' ', (A5)+
                    MOVE.B      #'#', (A5)+
                    MOVE.B      #'$', (A5)+
                    CMP.B       #%00, D0
                    BEQ         EA_IMME_DATA_BYTE
                    CMP.B       #%01, D0
                    BEQ         EA_IMME_DATA_WORD
                    BRA         EA_IMME_DATA_LONG

EA_IMME_DATA_BYTE      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_EA_DONE

EA_IMME_DATA_WORD      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_EA_DONE

EA_IMME_DATA_LONG      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_EA_DONE
* ----------------------
* EA_REG AND DEST_REG


* -- process EA field: 3-bit REGISTER
* -- convention: Binary --> alphanumerical string
* -- Supported opcodes: All opcodes

* -- preconditions: Assume that the address EA_REG is loaded with correct data
* -- postcondition: The address EA_REG_OUT is loaded with the appropriate string

DECODE_EA_REG   MOVEM.L     D5-D6, -(sp)
                MOVE.L      #0, D5
                MOVE.B      EA_REG, D5
                
                CMP.B       #%000, D5
                BLT         INVALID_EA_REG
                CMP.B       #%111, D5
                BGT         INVALID_EA_REG
                BRA         VALID_EA_REG

INVALID_EA_REG  MOVE.B      #'?', (A5)+
                BRA         EA_REG_DONE

EA_REG_DONE     MOVEM.L     (sp)+, D5-D6
                RTS

* --- WARNING: make sure that EA_REG_OUT holds enough space for at least one LONG data piece
VALID_EA_REG    ADD.B       #$30, D5    * -- convert hex into string
                MOVE.B      D5, (A5)+    * -- ensured to be one char (1byte)
                BRA         EA_REG_DONE

* ====================

* -- process DEST field: 3-bit REGISTER
* -- convention: Binary --> alphanumerical string
* -- Supported opcodes: All opcodes

* -- preconditions: Assume that the address DEST_REG is loaded with correct data
* -- postcondition: The address DEST_REG_OUT is loaded with the appropriate string

DECODE_DEST_REG MOVEM.L     D5-D6, -(sp)
                MOVE.L      #0, D5
                MOVE.B      DEST_REG, D5
                MOVE.L      #DEST_REG_OUT, A5
                
                CMP.B       #%000, D5
                BLT         INVALID_DEST_REG
                CMP.B       #%111, D5
                BGT         INVALID_DEST_REG
                BRA         VALID_DEST_REG

INVALID_DEST_REG  MOVE.B      #'?', (A5)+
                BRA         DEST_REG_DONE

DEST_REG_DONE     MOVEM.L     (sp)+, D5-D6
                RTS

* --- WARNING: make sure that DEST_REG_OUT holds enough space for at ldestst one LONG data piece
VALID_DEST_REG    ADD.B       #$30, D5    * -- convert hex into string
                MOVE.B      D5, (A5)+    * -- ensured to be one char (1byte)
                BRA         DEST_REG_DONE



* ==================== SRC


* -- pre-conditions: Address SRC_MODE loaded with correct input
* --                 Address SRC_REG  loaded with correct input
* --                 If mode is Immediate Data, need data size
* --                 stored in PERSONAL_SIZE_CONVENTION (0 = byte, 1 = word, anything else = long)

* -- Purpose: Decode a typical SRC_mode (Data register, Address register, etc.)

* -- 1. process data
DECODE_SRC_MODE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #SRC_MODE_OUT, A5
                MOVE.B      SRC_MODE, D5
                
                CMP.B       #%000, D5
                BEQ         SRC_MODE_DREG
                CMP.B       #%001, D5
                BEQ         SRC_MODE_AREG_DIR
                CMP.B       #%010, D5
                BEQ         SRC_MODE_AREG_INDIR
                CMP.B       #%011, D5
                BEQ         SRC_MODE_AREG_INDIR_INC
                CMP.B       #%100, D5
                BEQ         SRC_MODE_AREG_INDIR_DEC
                CMP.B       #%111, D5
                BEQ         SRC_MODE_SPECIAL
                BRA         SRC_MODE_INVALID
                
* -- 2. Respond to data

SRC_MODE_INVALID     BRA     DECODE_SRC_DONE

DECODE_SRC_DONE      MOVEM.L (sp)+, D4-D5/A5
                    RTS

SRC_MODE_DREG        MOVE.B      #'D', (A5)+
                    JSR         DECODE_SRC_REG
                    BRA         DECODE_SRC_DONE

SRC_MODE_AREG_DIR    MOVE.B      #'A', (A5)+
                    JSR         DECODE_SRC_REG
                    BRA         DECODE_SRC_DONE

SRC_MODE_AREG_INDIR  MOVE.B      #'(', (A5)+
                    MOVE.B      #'A', (A5)+
                    JSR         DECODE_SRC_REG
                    MOVE.B      #')', (A5)+
                    BRA         DECODE_SRC_DONE

SRC_MODE_AREG_INDIR_INC  MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_SRC_REG
                        MOVE.B      #')', (A5)+
                        MOVE.B      #'+', (A5)+
                        BRA         DECODE_SRC_DONE

SRC_MODE_AREG_INDIR_DEC  MOVE.B      #'-', (A5)+
                        MOVE.B      #'(', (A5)+
                        MOVE.B      #'A', (A5)+
                        JSR         DECODE_SRC_REG
                        MOVE.B      #')', (A5)+
                        BRA         DECODE_SRC_DONE

* -- relies on the address SRC_REG to be loaded with good data

SRC_MODE_SPECIAL     MOVE.B      SRC_REG, D5
                    CMP.B       #%000, D5
                    BEQ         SRC_MODE_DIR_W
                    CMP.B       #%001, D5
                    BEQ         SRC_MODE_DIR_L
                    CMP.B       #%100, D5
                    BEQ         SRC_MODE_IMME_DATA
                    BRA         SRC_MODE_INVALID

* -- direct addressing mode, word-sized address
SRC_MODE_DIR_W     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_SRC_DONE

SRC_MODE_DIR_L     MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #'$', (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR       READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA       DECODE_SRC_DONE

SRC_MODE_IMME_DATA MOVE.B      PERSONAL_SIZE_CONVENTION, D0
                    MOVE.B    #' ', (A5)+
                    MOVE.B    #' ', (A5)+
                    MOVE.B      #'#', (A5)+
                    MOVE.B      #'$', (A5)+
                    CMP.B       #%00, D0
                    BEQ         SRC_IMME_DATA_BYTE
                    CMP.B       #%01, D0
                    BEQ         SRC_IMME_DATA_WORD
                    BRA         SRC_IMME_DATA_LONG

SRC_IMME_DATA_BYTE      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_SRC_DONE

SRC_IMME_DATA_WORD      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_SRC_DONE

SRC_IMME_DATA_LONG      JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    JSR         READ_AND_PRINT_WORD
                    MOVE.L    EXTRA_STUFF, (A5)+
                    BRA         DECODE_SRC_DONE



* -- process SRC field: 3-bit REGISTER
* -- convention: Binary --> alphanumerical string
* -- Supported opcodes: All opcodes

* -- preconditions: Assume that the address SRC_REG is loaded with correct data
* -- postcondition: The address SRC_REG_OUT is loaded with the appropriate string

DECODE_SRC_REG MOVEM.L     D5-D6, -(sp)
                MOVE.L      #0, D5
                MOVE.B      SRC_REG, D5
                MOVE.L      #SRC_REG_OUT, A5
                
                CMP.B       #%000, D5
                BLT         INVALID_SRC_REG
                CMP.B       #%111, D5
                BGT         INVALID_SRC_REG
                BRA         VALID_SRC_REG

INVALID_SRC_REG  MOVE.B      #'?', (A5)+
                BRA         SRC_REG_DONE

SRC_REG_DONE     MOVEM.L     (sp)+, D5-D6
                RTS

* --- WARNING: make sure that SRC_REG_OUT holds enough space for at lSRCst one LONG data piece
VALID_SRC_REG    ADD.B       #$30, D5    * -- convert hex into string
                MOVE.B      D5, (A5)+    * -- ensured to be one char (1byte)
                BRA         SRC_REG_DONE



* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------- END OUTPUT PROCESSING ------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------




* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------- SUBROUTINES ----------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------



* ----------------------
* Extra subroutines


* ---- subroutine DECODE_DISPLACEMENT

DECODE_DISPLACEMENT MOVEM.L  D4-D6, -(sp)
            * -- default size assumption: Byte
            MOVE.B  #%00, PERSONAL_SIZE_CONVENTION

            MOVE.W  DISPLACEMENT, D4
            MOVE.L  A6, D5
            CMP.B   #$00, D4
            BNE     BRA_SKIP

            MOVE.W  (A6)+, D6
            MOVE.L  D6, D4
            MOVE.B  #01, PERSONAL_SIZE_CONVENTION

BRA_SKIP    MOVE.L  D5, D7
            ADD.L   D4, D7
            JSR     CONVERT_HEX_TO_STRING
            MOVE.L  D7, DISPLACEMENT_OUT
            BRA     DECODE_DISPLACEMENT_DONE


DECODE_DISPLACEMENT_DONE MOVEM.L (sp)+, D4-D6
                         RTS


* -- process EA field: 1-bit SIZE
* -- convention: 0-WORD, 1-LONG
* -- Supported opcodes: All the -A variants except for MOVEA, whose convention is similar to MOVE's

* -- preconditions: Assume that the address ONEBIT_SIZE is loaded with correct data
* -- postcondition: The address ONEBIT_SIZE_OUT is loaded with the appropriate string

DECODE_ONE_BIT_SIZE MOVEM.L     D5-D6/A5, -(sp)
                    MOVE.B      SIZE, D5
                    MOVEA.L     #SIZE_OUT, A5

                    CMP.B       #%0, D5
                    BEQ         SIZE_WORD_ONE
                    CMP.B       #%1, D5
                    BEQ         SIZE_LONG_ONE
                    BRA         INVALID_SIZE

INVALID_SIZE        MOVE.B      #'?', (A5)
                    BRA         ONEBIT_SIZE_DONE

ONEBIT_SIZE_DONE    MOVEM.L     (sp)+, D5-D6/A5
                    RTS

SIZE_WORD_ONE           MOVE.B      #'.', (A5)+
                    MOVE.B      #'W', (A5)+
                    MOVE.B      #1, PERSONAL_SIZE_CONVENTION
                    BRA         ONEBIT_SIZE_DONE

SIZE_LONG_ONE           MOVE.B      #'.', (A5)+
                    MOVE.B      #'L', (A5)+
                    MOVE.B      #2, PERSONAL_SIZE_CONVENTION
                    BRA         ONEBIT_SIZE_DONE


DECODE_TWO_BIT_SIZE  MOVEM.L     D4-D5/A5, -(sp)
                MOVEA.L     #SIZE_OUT, A5
                MOVE.B      SIZE, D5
                
                CMP.B       #%000, D5
                BEQ         SIZE_BYTE
                CMP.B       #%001, D5
                BEQ         SIZE_WORD
                CMP.B       #%010, D5
                BEQ         SIZE_LONG
                BRA         SIZE_INVALID
                
* -- 2. Respond to data

SIZE_INVALID     BRA     DECODE_TWO_BIT_SIZE_DONE

DECODE_TWO_BIT_SIZE_DONE    MOVEM.L (sp)+, D4-D5/A5
                    RTS

SIZE_BYTE        MOVE.B      #'.', (A5)+
                    MOVE.B      #'B', (A5)+
                    BRA         DECODE_EA_DONE

SIZE_WORD        MOVE.B      #'.', (A5)+
                    MOVE.B      #'W', (A5)+
                    BRA         DECODE_EA_DONE

SIZE_LONG        MOVE.B      #'.', (A5)+
                    MOVE.B      #'L', (A5)+
                    BRA         DECODE_EA_DONE



DECODE_DATA       
                    MOVE.B      DATA, D7
                    CMP.B       #%000, D7
                    BEQ         TRANSLATE_TO_8
                    JSR         CONVERT_HEX_TO_STRING
                    MOVE.B      D7, DATA_OUT
             
TRANSLATE_TO_8      MOVE.B      #8, D7
                    RTS

READ_AND_PRINT_WORD MOVEM.L     D7, -(sp)
                    MOVE.W      (A6)+, D7
                    JSR         CONVERT_HEX_TO_STRING
                    MOVE.L      D7, EXTRA_STUFF
                    MOVEM.L     (sp)+, D7
                    RTS

PRINT_EA_MODE       MOVEM.L     A1-A2, -(sp)
                    MOVEA.L     #EA_MODE_OUT, A1
                    MOVEA.L     #PRINT_BUFFER, A2
                    MOVE.B      #12, PRINT_SIZE
                    MOVE.L      (A1)+, (A2)+
                    MOVE.L      (A1)+, (A2)+
                    MOVE.L      (A1)+, (A2)+
                    JSR         PRINT_STUFF
                    MOVEM.L     (sp)+, A1-A2
                    RTS

PRINT_DEST_MODE     MOVEM.L     A1-A2, -(sp)
                    MOVEA.L     #DEST_MODE_OUT, A1
                    MOVEA.L     #PRINT_BUFFER, A2
                    MOVE.B      #12, PRINT_SIZE
                    MOVE.L      (A1)+, (A2)+
                    MOVE.L      (A1)+, (A2)+
                    MOVE.L      (A1)+, (A2)+
                    JSR         PRINT_STUFF
                    MOVEM.L     (sp)+, A1-A2
                    RTS


* -- put convert code here


CONVERT_HEX_TO_STRING   MOVEM.L     D0-D6, -(sp)
    
    CLR     D0
    CLR     D1
    CLR     D2
    CLR     D3
    CLR     D4
    CLR     D5
    CLR     D6

    
    * --- support only word-sized hex data in D7
    * --  D6 is designated as the container for the masked values
    * --  D5 is designated as the container for the summands
    * --  D4 is the container of the sum
    * --  D3 is the container of the length of the string
    * --  D0 is designated for on-the-fly arithmetic
    
    MOVE.B      #4, D3
    
CONVERT_HEX_TO_STRING_LOOP  CMP.B   #0, D3
    BEQ         HEX2STR_DONE

    MOVE.L      #0, D2
    MOVE.L      #0, D1
    
    MOVE.B      D3, D0
    SUB.B       #1, D0          * -- D3 - 1
    ASL.W       #2, D0          * -- (D3 - 1) * 4
    MOVE.B      #4, D2
    MOVE.B      D3, D1
    SUB.B       D1, D2          * -- 4 - n       
    ASL.W       #2, D2          * -- (4 - D3) * 4

    MOVE.W      D7, D6
    LSL.W       D2, D6          * -- shift 4*(4-n) bits to get rid of the more significant bits
    LSR.W       D2, D6          * -- undo the shift
    LSR.W       D0, D6          * -- shift 4*(n-1) bits to get the most
                                * -- significant digit at this time
    MOVE.L      D6, D5
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


FLUSH_OUTPUT_BUFFER MOVE.L  #$20202020, SIZE_OUT
                    MOVE.L  #$20202020, WEIRD_SIZE_OUT
                    MOVE.L  #$20202020, DIRECTION_OUT
                    MOVE.L  #$20202020, EA_REG_OUT
                    MOVE.L  #$20202020, DEST_REG_OUT
                    MOVE.L  #$20202020, SRC_REG_OUT
                    JSR     FLUSH_EA_MODES
                    JSR     FLUSH_PRINT_BUFFER
                    RTS

FLUSH_EA_MODES      MOVEM.L A4-A6, -(sp)
                    MOVEA.L #EA_MODE_OUT, A4
                    MOVEA.L #SRC_MODE_OUT, A5
                    MOVEA.L #DEST_MODE_OUT, A6

                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A5)+
                    MOVE.L  #$20202020, (A5)+
                    MOVE.L  #$20202020, (A5)+
                    MOVE.L  #$20202020, (A6)+
                    MOVE.L  #$20202020, (A6)+
                    MOVE.L  #$20202020, (A6)+

                    MOVEM.L (sp)+, A4-A6
                    RTS

FLUSH_PRINT_BUFFER  MOVEM.L A4, -(sp)
                    MOVEA.L #PRINT_BUFFER, A4

                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVE.L  #$20202020, (A4)+
                    MOVEM.L (sp)+, A4
                    RTS

PRINT_STUFF         MOVEM.L     A4/D0, -(sp)
                    MOVE.B      PRINT_SIZE, D0
                    MOVEA.L     #PRINT_BUFFER, A4
PRINT_LOOP          CMP.B       #0, D0
                    BEQ         PRINT_DONE
                    MOVE.B      (A4)+, (A3)+
                    SUB.B       #1, D0
                    BRA         PRINT_LOOP

PRINT_DONE          MOVEM.L     (sp)+, A4/D0
                    RTS

* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ------------------------------------------------- END SUBROUTINES ----------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------

AFTER_MAIN_LOOP BRA     PROGRAM_END

PROGRAM_END    SIMHALT             ; halt simulator

* Put variables and constants here


* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ------------------------------------------------ GLOBAL CONSTANTS ----------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------
* ----------------------------------------------------------------------------------------------------------------------------------


SIZE            DS.B    1
WEIRD_SIZE      DS.B    1
DIRECTION       DS.B    1
EA_MODE         DS.B    1
EA_REG          DS.B    1
SRC_MODE        DS.B    1
SRC_REG         DS.B    1
DEST_MODE       DS.B    1
DEST_REG        DS.B    1
ROTATE_IR       DS.B    1
ROTATE_CR       DS.B    1
DISPLACEMENT    DS.W    1
CONDITION       DS.B    1
DATA            DS.B    1

PERSONAL_SIZE_CONVENTION    DS.B    1

SIZE_OUT        DS.L    1
WEIRD_SIZE_OUT  DS.L    1
DIRECTION_OUT   DS.B    1
EA_MODE_OUT     DS.L    3
EA_REG_OUT      DS.B    1
SRC_MODE_OUT    DS.L    3
SRC_REG_OUT     DS.B    1
DEST_MODE_OUT   DS.L    3
DEST_REG_OUT    DS.B    1
ROTATE_IR_OUT   DS.L    1
ROTATE_CR_OUT   DS.L    1
EXTRA_STUFF     DS.L    1
DATA_OUT        DS.B    1
DISPLACEMENT_OUT DS.L   1

PRINT_BUFFER    DS.L    5
PRINT_SIZE      DS.B    1



 END     START        ; last line of source















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
