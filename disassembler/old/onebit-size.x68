
* -- process EA field: 1-bit SIZE
* -- convention: 0-WORD, 1-LONG
* -- Supported opcodes: All the -A variants except for MOVEA, whose convention is similar to MOVE's

* -- preconditions: Assume that the address ONEBIT_SIZE is loaded with correct data
* -- postcondition: The address ONEBIT_SIZE_OUT is loaded with the appropriate string

DECODE_ONEBIT_SIZE 	MOVEM.L		D5-D6/A5, -(sp)
					MOVE.B		ONEBIT_SIZE, D5
					MOVEA.L		ONEBIT_SIZE_OUT, A5

					CMP.B		#%0, D5
					BEQ			SIZE_WORD
					CMP.B		#%1, D5
					BEQ			SIZE_LONG
					BRA			INVALID_SIZE

INVALID_SIZE		MOVE.B		#'?', (A5)
					BRA			ONEBIT_SIZE_DONE

ONEBIT_SIZE_DONE	MOVEM.L		(sp)+, D5-D6/A5
					RTS

SIZE_WORD			MOVE.B		#'.', (A5)+
					MOVE.B		#'W', (A5)+
					BRA 		ONEBIT_SIZE_DONE

SIZE_LONG			MOVE.B		#'.', (A5)+
					MOVE.B		#'L', (A5)+
					BRA			ONEBIT_SIZE_DONE