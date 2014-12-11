
* -- process EA field: 3-bit mode
* -- convention: see ea mode table
* -- Supported opcodes: All opcodes

* -- preconditions: Assume that the address EA_MODE is loaded with correct data
                    Assume that the address EA_REG is loaded with correct data
* -- postcondition: The address EA_MODE_OUT is loaded with the appropriate string

DECODE_EA_MODE  MOVEM.L     D5-D6/A5, -(sp)
                MOVE.B      EA_MODE, D5
                MOVEA.L     EA_MODE_OUT, A5
                
                CMP.B       #%000, D5
                BLT         INVALID_EA_MODE
                CMP.B       #%111, D5
                BGT         INVALID_EA_MODE
                BRA         VALID_EA_REG

INVALID_EA_REG  MOVE.B      #'?', (A5)
                BRA         EA_REG_DONE

EA_REG_DONE     MOVEM.L     (sp)+, D5-D6/A5
                RTS

* --- WARNING: make sure that EA_REG_OUT holds enough space for at least one LONG data piece
VALID_EA_REG    CMP.B           #%000, D5
                BEQ             EA_MODE_D
                CMP.B           #%001, D5
                BEQ             EA_MODE_A
                CMP.B           #%010, D5
                BEQ             EA_MODE_(A)
                CMP.B           #%011, D5
                BEQ             EA_MODE_(A)_DEC
                CMP.B           #%100, D5
                BEQ             EA_MODE_(A)_INC
                CMP.B           #%111, D5
                BEQ             EA_MODE_SPECIAL

                BRA             EA_REG_DONE