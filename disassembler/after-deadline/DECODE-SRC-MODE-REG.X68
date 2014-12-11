
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
