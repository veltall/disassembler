
* -- process EA field: 1-bit DIRECTION
* -- convention: 0-RIGHT, 1-LEFT
* -- Supported opcodes: ASd, LSd, and ROd, maybe more such as ADD/SUB

* -- preconditions: Assume that the address DIRECTION is loaded with correct data
* -- postcondition: The address DIRECTION_OUT is loaded with the appropriate string

DECODE_DIRECTION 	MOVEM.L		D5-D6/A5, -(sp)
					MOVE.B		DIRECTION, D5
					MOVEA.L		DIRECTION_OUT, A5
					
					CMP.B		#%0, D5
					BEQ			DIR_RIGHT
					CMP.B		#%1, D5
					BEQ			DIR_LEFT
					BRA			INVALID_DIRECTION

INVALID_DIRECTION	MOVE.B		#'?', (A5)
					BRA			DIRECTION_DONE

DIRECTION_DONE		MOVEM.L		(sp)+, D5-D6/A5
					RTS

DIR_LEFT			MOVE.B		#'L', (A5)+
					BRA 		DIRECTION_DONE

DIR_RIGHT			MOVE.B		#'R', (A5)+
					BRA			DIRECTION_DONE