
* -- process EA field: 3-bit REGISTER
* -- convention: Binary --> alphanumerical string
* -- Supported opcodes: All opcodes

* -- preconditions: Assume that the address EA_REG is loaded with correct data
* -- postcondition: The address EA_REG_OUT is loaded with the appropriate string

DECODE_EA_REG	MOVEM.L		D5-D6/A5, -(sp)
				MOVE.B		EA_REG, D5
				MOVEA.L		EA_REG_OUT, A5
				
				CMP.B		#%000, D5
				BLT			INVALID_EA_REG
				CMP.B		#%111, D5
				BGT			INVALID_EA_REG
				BRA			VALID_EA_REG

INVALID_EA_REG	MOVE.B		#'?', (A5)
				BRA			EA_REG_DONE

EA_REG_DONE		MOVEM.L		(sp)+, D5-D6/A5
				RTS

* --- WARNING: make sure that EA_REG_OUT holds enough space for at least one LONG data piece
VALID_EA_REG	ADD.B		#$30, D5 	* -- convert hex into string
				MOVE.B		D5, (A5)	* -- ensured to be one char (1byte)
				BRA 		EA_REG_DONE