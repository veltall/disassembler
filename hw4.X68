*-----------------------------------------------------------
* Title      : Homework 4
* Written by : Vu Dinh
* Date       : October 31 2014
* Description: I'm late I'm late I'm lateeeee
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    MOVE.B #$9D, D2     * test conversion
    MOVE.B #$D9, $6000  * specified address for result       

    ADD.B   D2, $6000   * Addition  

    BVS     OVERFLOW    
    BVC     NOOVERFLOW  
    
OVERFLOW    LEA BADMSG, A1 
            MOVE.B  #14, D0
            TRAP    #15
            BRA     PRINTRESULT 


NOOVERFLOW  LEA GOODMSG, A1
            MOVE.B  #14, D0
            TRAP    #15
            BRA     PRINTRESULT

PRINTRESULT     MOVE.B  $6000, D1   * prime for output    
                MOVE.B  #3, D0      * load trap task #3 
                TRAP    #15 


    SIMHALT             ; halt simulator

* Put variables and constants here
   
GOODMSG         DC.B    'There were no overflows, the sum is: ',0

BADMSG          DC.B    'Overflow happened, the sum is not reliable: ',0    

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
