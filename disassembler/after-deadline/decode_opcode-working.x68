
* -- Preconditions: The instruction as read from memory is stored in D6

DECODE_OPCODE       MOVE.W      D6, D5                  * -- make copy
                    AND.W       #$F000, D5              * -- mask opcode
                    LSR.W       #12, D5

IDENT_OPCODE        CMP.B       #%0000, D5
                    BEQ         DECODE_GROUP_0
                    CMP.B       #%0100, D5
                    BEQ         DECODE_GROUP_4
                    CMP.B       #%0101, D5
                    BEQ         DECODE_GROUP_5
                    CMP.B       #%0110, D5
                    BEQ         DECODE_GROUP_6
                    CMP.B       #%1000, D5
                    BEQ         DECODE_GROUP_8
                    CMP.B       #%1001, D5
                    BEQ         DECODE_GROUP_9
                    CMP.B       #%1011, D5
                    BEQ         DECODE_GROUP_B
                    CMP.B       #%1100, D5
                    BEQ         DECODE_GROUP_C
                    CMP.B       #%1101, D5
                    BEQ         DECODE_GROUP_D
                    CMP.B       #%1110, D5
                    BEQ         DECODE_GROUP_E
                    CMP.B       #%0001, D5
                    BEQ         DECODE_GROUP_MOVE
                    CMP.B       #%0010, D5
                    BEQ         DECODE_GROUP_MOVE
                    CMP.B       #%0011, D5
                    BEQ         DECODE_GROUP_MOVE
                    BRA         INVALID_OPCODE

INVALID_OPCODE      BRA         DECODE_OPCODE_DONE

DECODE_OPCODE_DONE  BRA         MAIN_LOOP

DECODE_GROUP_0      MOVE.W      D6, D5                  * -- recover the data
                    AND.W       #$0E00, D5
                    LSR.W       #9, D5

                    CMP.B       #%000, D5
                    BEQ         DECODE_ORI
                    CMP.B       #%101, D5
                    BEQ         DECODE_EORI
                    CMP.B       #%010, D5
                    BEQ         DECODE_SUBI
                    CMP.B       #%110, D5
                    BEQ         DECODE_CMPI
                    CMP.B       #%100, D5
                    BEQ         DECODE_BTST
                    BRA         INVALID_OPCODE

DECODE_GROUP_4      MOVE.W      D6, D5                  * -- recover the data
                    CMP.W       #$4E75, D5
                    BEQ         DECODE_RTS

                    AND.W       #$0FC0, D5              * -- mask #1
                    LSR.W       #6, D5

                    CMP.W       #%111010, D5
                    BEQ         DECODE_JSR

                    AND.W       #$07, D5                * -- mask #2

                    CMP.W       #%111, D5
                    BEQ         DECODE_LEA

                    MOVE.W      D6, D5                  * -- recover data
                    AND.W       #$0800, D5              * -- mask #3
                    LSR.W       #11, D5
                    CMP.B       #1, D5
                    BEQ         DECODE_MOVEM

                    MOVE.W      D6, D5                  * -- recover data
                    AND.W       #$0E00, D5              * -- mask #4
                    LSR.W       #9, D5
                    CMP.B       #%010, D5
                    BEQ         DECODE_NEG
                    CMP.B       #%011, D5
                    BEQ         DECODE_NOT
                    BRA         INVALID_OPCODE

DECODE_GROUP_5      MOVE.W      D6, D5
                    AND.W       #$0100, D5
                    LSR.W       #8, D5
                    CMP.B       #0, D5
                    BEQ         DECODE_ADDQ
                    BRA         INVALID_OPCODE

DECODE_GROUP_6      MOVE.W      D6, D5
                    AND.W       #$0F00, D5
                    LSR.W       #8, D5
                    CMP.B       #0, D5
                    BEQ         DECODE_BRA
                    BRA         DECODE_BCC

DECODE_GROUP_8      MOVE.W      D6, D5
                    AND.W       #$01C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%111, D5
                    BEQ         DECODE_DIVS
                    BRA         INVALID_OPCODE

DECODE_GROUP_9      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_SUBA
                    BRA         DECODE_SUB

DECODE_GROUP_B      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_CMPA

                    MOVE.W      D6, D5
                    AND.W       #$0100, D5
                    LSR.W       #8, D5
                    CMP.B       #1, D5
                    BEQ         DECODE_EOR
                    BRA         DECODE_CMP

DECODE_GROUP_C      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_MULS
                    BRA         DECODE_AND

DECODE_GROUP_D      MOVE.W      D6, D5
                    AND.W       #$00C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%11, D5
                    BEQ         DECODE_ADDA
                    BRA         DECODE_ADD

DECODE_GROUP_E      MOVE.W      D6, D5
                    AND.W       #$0E00, D5
                    LSR.W       #9, D5
                    CMP.B       #%000, D5
                    BEQ         DECODE_ASd
                    CMP.B       #%001, D5
                    BEQ         DECODE_LSd
                    CMP.B       #%011, D5
                    BEQ         DECODE_ROd
                    BRA         INVALID_OPCODE

DECODE_GROUP_MOVE   MOVE.W      D6, D5
                    AND.W       #$01C0, D5
                    LSR.W       #6, D5
                    CMP.B       #%001, D5
                    BEQ         DECODE_MOVEA
                    BRA         DECODE_MOVE