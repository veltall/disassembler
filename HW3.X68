*-----------------------------------------------------------
* Title      : HW3-Q5 Program
* Written by : Wooyoung Kim
* Date       : n/a
* Description: This program is given to the students to analyze
*-----------------------------------------------------------

*-------------------------------------
* Definition of "variables"
*-------------------------------------

addr1   EQU $4000
addr2   EQU $4001
data2   EQU $A7FF
data3   EQU $5555
data4   EQU $0000
data5   EQU 4678
data6   EQU %01001111
data7   EQU %00010111



*-------------------------------------
* Program logic
*-------------------------------------

        ORG     $400
        
start   MOVE.W  #data2,D0
        MOVE.B  #data6,D1
        MOVE.B  #data7,D2
        MOVE.W  #data3,D3
        
        MOVEA.W #addr1,A0
        MOVE.B  D1,(A0)+
        MOVE.B  D2,(A0)+
        
        MOVEA.W #addr1,A1
        AND.W   D3,(A1)
        
        JMP     start
        END     $400
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
