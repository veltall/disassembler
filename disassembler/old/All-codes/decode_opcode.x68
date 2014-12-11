

    ORG     $400
    
START:




* --- assume that the retrieved instruction is stored in D4
* --- if not, move it to D4 before using

        MOVE.W  D4,D5           * --- make a backup
MASK    AND.W   #$F000, D4      * -- extract first 4 bits
        
        CMP.W   #$8000, D4
        BEQ     DECODE_DIVS     * -- DIVS is the only supported opcode here
        
        CMP.W   #$5000, D4
        BEQ     DECODE_ADDQ     * -- ADDQ is the only supported opcode here
        
        CMP.W   #$C0000, D4
        BEQ     DECODE_GROUP_C  * -- MULS and AND
        
        CMP.W   #$9000, D4
        BEQ     DECODE_GROUP_9  * -- SUB and SUBA
        
        CMP.W   #$6000, D4
        BEQ     DECODE_GROUP_6  * -- BRA and Bcc
        
        CMP.W   #$E000, D4
        BEQ     DECODE_GROUP_E  * -- LSd, ASd, ROd
        
        CMP.W   #$B000, D4
        BEQ     DECODE_GROUP_B  * -- EOR, CMP, CMPA
        
        CMP.W   #$4000, D4
        BEQ     DECODE_GROUP_4  * -- NEG, NOT, LEA, JSR, RTS, MOVEM
        
        CMP.W   #$0000, D4
        BEQ     DECODE_GROUP_0  * -- ORI, EORI, SUBI, BTST, CMPI
        
        CMP.W   #$1000, D4
        BEQ     DECODE_GROUP_M  * -- MOVE and MOVEA
        CMP.W   #$2000, D4
        BEQ     DECODE_GROUP_M
        CMP.W   #$3000, D4
        BEQ     DECODE_GROUP_M
        
        BRA     INVALID_OPCODE
        
        
DECODE_GROUP_0  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_0_1        AND.W       #%0000111000000000, D4  * -- extract bits 9, A, B
                CMP.W       #$0, D4
                BEQ         DECODE_ORI
                
                CMP.W       #%0000010000000000, D4
                BEQ         DECODE_SUBI
                
                CMP.W       #%0000100000000000, D4
                BEQ         DECODE_BTST
                
                CMP.W       #%0000101000000000, D4
                BEQ         DECODE_EORI
                
                CMP.W       #%0000110000000000, D4
                BEQ         DECODE_CMPI
                
                BRA         INVALID_OPCODE
* ------------------------------------------------

DECODE_GROUP_4  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
TMP_STORE       MOVEM.W     D3, -(sp)
                CMP.W       #$4E75, D4
                BEQ         DECODE_RTS

MASK_4_1        AND.W       #%0000111111000000, D4  * -- extract 6 bits
                MOVE.W      D4, D3                  * -- second copy
                CMP.W       #%0000111010000000, D4
                BEQ         DECODE_RTS
                
MASK_4_2        AND.W       #%0000000111000000, D4  * -- extract second 3 bits
                CMP.W       #%0000000111000000, D4
                BEQ         DECODE_LEA
                
MASK_4_3        AND.W       #%0000111000000000, D3  * -- extract first 3 bits
                CMP.W       #%0000011000000000, D3
                BEQ         DECODE_NOT
                CMP.W       #%0000010000000000, D3
                BEQ         DECODE_NEG
                
                MOVEM.W     (sp)+, D3               * -- has those 6 bits
MASK_4_4        AND.W       #%0000100000000000, D4  * -- extract only 1 bit
                CMP.W       #%0000100000000000, D4
                BEQ         DECODE_MOVEM
                BRA         INVALID_OPCODE
* ------------------------------------------------

DECODE_GROUP_6  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_6_1        AND.W       #%0000111100000000, D4  * -- extract bits 8, 9, A, B
                CMP.W       #$0, D4
                BEQ         DECODE_BRA
                BRA         DECODE_Bcc              * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

DECODE_GROUP_9  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_9_1        AND.W       #%0000000011000000, D4  * -- extract bits 6 and 7
                CMP.W       #%11000000, D4
                BEQ         DECODE_SUBA
                BRA         DECODE_SUB              * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

DECODE_GROUP_B  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_B_1        AND.W       #%0000000011000000, D4  * -- extract bits 6 and 7
                CMP.W       #%11000000, D4
                BEQ         DECODE_CMPA
                
                MOVEM.W     (sp)+, D4
                MOVEM.W     D4, -(sp)
MASK_B_2        AND.W       #%0000000100000000, D4  * -- extract bit 8
                CMP.W       #$0, D4
                BEQ         DECODE_CMP
                BRA         DECODE_EOR              * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

DECODE_GROUP_C  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_C_1        AND.W       #%0000000011000000, D4  * -- extract bits 6 and 7
                CMP.W       #%11000000, D4
                BEQ         DECODE_MULS
                BRA         DECODE_AND              * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

DECODE_GROUP_E  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_E_1        AND.W       #%0000111000000000, D4  * -- extract bits 9, A, B
                CMP.W       #$0, D4
                BEQ         DECODE_ASd
                CMP.W       #$200, D4
                BEQ         DECODE_LSd
                BRA         DECODE_ROd              * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

DECODE_GROUP_M  MOVE.W      D5, D4                  * -- restore data
                MOVEM.W     D4, -(sp)               * -- make a backupbackup
MASK_M_1        AND.W       #%0000000111000000, D4  * -- extract bits 6, 7, 8
                CMP.W       #%001000000, D4
                BEQ         DECODE_MOVEA
                BRA         DECODE_MOVE             * -- assume no other opcodes
                                                    * -- will be requested
* ------------------------------------------------

        
        

INVALID_OPCODE  BRA     MAINLOOP        * -- just ignore






PROGRAM_END    SIMHALT


    END     START