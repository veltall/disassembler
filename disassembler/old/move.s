*-----------------------------------------------------------
* Title      :		Disassembler MOVE opcode decoder
* Written by :		Vu Dinh
* Date       :		Nov 09 2014
* Description:		Trying to decode the MOVE command
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

* -------- Changing source registers
	MOVE.B 		D0,D0
	MOVE.B 		D1,D0
	MOVE.B 		D2,D0

* -------- Changing source modes
	MOVE.B 		A0,D0
	MOVE.B 		(A0),D0
	MOVE.B 		(A0)+,D0
	MOVE.B 		-(A0),D0

* -------- Changing destination modes
	MOVE.B 		D0,(A0)
	MOVE.B 		D0,(A0)+
	MOVE.B 		D0,-(A0)

* -------- Changing destination registers
	MOVE.B 		D0,D0
	MOVE.B 		D0,D1
	MOVE.B 		D0,D2

* -------- Changing data size

	MOVE.B 		D0,D0
	MOVE.L 		D0,D0
	MOVE.W		D0,D0


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
