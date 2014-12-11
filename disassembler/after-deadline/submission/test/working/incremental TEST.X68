

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $2000
START:                  ; first instruction of program

* Put program code here

*	MOVE.L		#$3A3C1234, (A6)+
*	MOVE.B		D3, (A6)
*	MOVE.L		D2, -(A5)
*	MOVE.W		#1276, (A3)+
*	MOVE.W		#354, $1765

*	DIVS.W      D0, D5
*	DIVS.W 		(A3)+,D2
*	DIVS.W  	-(A2), D3

*	ADDQ.W  	#1, D3
*	ADDQ.B 	    #5, D5

*	SUB.W 		D3,	D2
*	SUB.B 		D1,(A4)+

	SUBA.W 		D5, A3
	SUBA.W		$154, A3
	SUBA.W		#123, A3


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

