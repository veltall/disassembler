*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

	MOVE.L 	#$C1A8D372, D0
	ASL.B 	#2, D0

	MOVE.L 	#$C1A8D372, D0
	ASL.L 	#5, D0

	MOVE.L 	#$C1A8D372, D0
	LSR.B 	#4, D0

	MOVE.L 	#$C1A8D372, D0
	ROR.W 	#2, D0

	MOVE.L 	#$C1A8D372, D0
	ROL.L 	#7, D0



    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
