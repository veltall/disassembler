

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $5000
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

*	SUBA.W 		D5, A3
*	SUBA.W		$154, A3
*	SUBA.W		#123, A3

*	ADD.W 		D3,	D2
*	ADD.B 		D1,(A4)+

;	ADDA.W 		D5, A3
;	ADDA.W		$154, A3
;	ADDA.W		#123, A3

;	AND.W 		D3,	D2
;	AND.B 		D1,(A4)+

;	MULS.W 		D3,	D2
;	MULS.W 		(A4)+,D1
;	MULS.W		$124, D5

;   NOT.B       D5
;    NOT.W       -(A3)
;   NOT.L       $1435

;    NEG.B       D5
;    NEG.W       -(A3)
;    NEG.L       $1435

;    RTS

;    JSR         (A5)
;    JSR         $1234
;    JSR         $8859

    BEQ         $8000
    BNE         $5050
    BLT         $1234
    BHI         $5012

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
