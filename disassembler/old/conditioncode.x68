
* -- process EA field: 4-bit Condition Codes
* -- convention: Table 3-19 in M68K manual
* -- Supported opcodes: Bcc (BEQ, BNE, BLT, BHI)

* -- preconditions: Assume that the address CONDITION is loaded with correct data
* -- postcondition: The address CONDITION_OUT is loaded with the appropriate string

DECODE_CONDITION 	MOVEM.L		D5-D6/A5, -(sp)
					MOVE.B		CONDITION, D5
					MOVEA.L		CONDITION_OUT, A5
					
					CMP.B		#%0, D5
					BLT			INVALID_CONDITION
					CMP.B		#%1111, D5
					BGT			INVALID_CONDITION
					BRA			VALID_CONDITION

INVALID_CONDITION	MOVE.B		#'?', (A5)
					BRA			CONDITION_DONE

CONDITION_DONE		MOVE.B		#' ', (A3)+
					MOVEM.L		(sp)+, D5-D6/A5
					RTS

VALID_CONDITION 	CMP.B	 	#%0110, D5
					BEQ			CONDITION_NE
					CMP.B		#%0111, D5
					BEQ			CONDITION_EQ
					CMP.B		#%1101, D5
					BEQ			CONDITION_LT
					CMP.B		#%0100, D5
					BEQ			CONDITION_HI		* -- aka Carry Clear
					BRA			INVALID_CONDITION	* -- non-supported CCs

CONDITION_NE		MOVE.B		#'N', (A5)+
					MOVE.B		#'E', (A5)+
					BRA			CONDITION_DONE
CONDITION_EQ		MOVE.B		#'E', (A5)+
					MOVE.B		#'Q', (A5)+
					BRA			CONDITION_DONE
CONDITION_LT		MOVE.B		#'L', (A5)+
					MOVE.B		#'T', (A5)+
					BRA			CONDITION_DONE
CONDITION_HI		MOVE.B		#'H', (A5)+
					MOVE.B		#'I', (A5)+
					BRA			CONDITION_DONE
