*----------------------------------------------------------------------------
* Title      :      Homework 5 part 2 // Pattern finding and Cumulative sum
* Written by :      Vu Dinh
* Date       :      Nov 28 2014
* Comment    :      There are a lot of vague specifications of the program.
*                   I've created some test cases and stated expected results.
*----------------------------------------------------------------------------


    ORG    $400
START:                  ; first instruction of program

* ------------------------------------
* --------- PART 3: TESTING ----------
* ------------------------------------

TEST_CASE   MOVE.B  #$0, D7     * -- test case number
            CMP.B   #$1, D7
            BEQ     TEST_CASE_1
            CMP.B   #$2, D7
            BEQ     TEST_CASE_2
            CMP.B   #$3, D7
            BEQ     TEST_CASE_3
            CMP.B   #$4, D7
            BEQ     TEST_CASE_4
DEFAULT     BRA     NO_TEST



* ------------------------------------
* --- PART 1: PATTERN MATCHING -------
* ------------------------------------
* | Tested for the following cases:  |
* | >> Pattern found immediately at  |
* |    $A000                         |
* | >> Pattern not found             |
* | >> Pattern found between $A000   |
* |    and $B000                     |
* ------------------------------------


START_PART1 CLR     D1   
    
            MOVEA.L     #CMP_START_ADDR, A4         * -- starting search location
LOOP        CMPA.L      #CMP_END_ADDR, A4           * -- ending search location
            BEQ         NOT_FOUND
            MOVEA.L     A4, A5                      * -- keep a copy before incrementing A4
        
COMPARE     MOVE.B      (A4)+, D4                   * -- currently processed data
            CMP.B       CMP_ADDR, D4
            BEQ         FOUND
ENDLOOP     BRA         LOOP
        
FOUND       MOVE.L      A5, ADDR1                   * -- match is found addr1 = matched location
            BRA         CSUM
                
NOT_FOUND   MOVE.L      #NOTFOUND_ADDR, ADDR1        * -- match not found, addr1 = special value
            BRA         CSUM
        

* ------------------------------------
* --- PART 2: CUMULATIVE SUM ---------
* ------------------------------------
* | Tested for the following cases:  |
* | >> Change one summand to $00     |
* ------------------------------------

CSUM    CLR         D4
        MOVEA.L     #$0, A3                 * -- resetting A3
        MOVE.W      #ITER, D2               * -- D2 = loop counter
        MOVEA.L     ADDR1, A6
        
SUM_LOOP    CMP.L       #0, D2
            BEQ         SUM_FINISH
            MOVE.B      (A6)+, D5           * -- data is extracted as BYTE
            ADD.W       D5, D4              * -- but summed as WORD
            BCS         SET_CARRY           * -- if the carry bit is set, record it
LOOPBACK    SUB.L       #1, D2
            BRA         SUM_LOOP

SET_CARRY   MOVE.B      #1, D6              * -- record carry bit
            BRA         LOOPBACK            * -- going back into loop
        
SUM_FINISH  MOVE.W  D4, ADDSUM              * -- move the sum to requested location
            MOVE.B  D6, CARRYBIT            * -- move the carry bit to the requested location
            BRA     PRINTRESULT
  
PRINTRESULT LEA     ADDR1_OUTPUT, A1
            MOVE.B  #14, D0
            TRAP    #15
            MOVE.L  ADDR1, D1           * -- printing ADDR1
            MOVE.B  #16,D2
            MOVE.B  #15,D0
            TRAP    #15
           
            LEA     EMPTY_LINE, A1      * -- printing empty line
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     SUM_OUTPUT, A1
            MOVE.B  #14, D0
            TRAP    #15
            MOVE.L  D4, D1              * -- printing the sum (stored temporarily in D4)
            MOVE.B  #16,D2              * -- the sum is printed in hex format
            MOVE.B  #15,D0
            TRAP    #15
            
            LEA     EMPTY_LINE, A1      * -- empty line
            MOVE.B  #13,D0
            TRAP    #15
            
            LEA     CARRY_OUTPUT, A1
            MOVE.B  #14, D0
            TRAP    #15
            MOVE.L  D6, D1              * -- the carry bit information (overwrites D1)
            MOVE.B  #16,D2
            MOVE.B  #15,D0
            TRAP    #15


* ------------------------------------
* --------- PART 3: TESTING ----------
* ------------------------------------

    BRA         END_PROGRAM

* -- Test #1: Try a compare value that will never be found (ADDR1 = $A00000)
TEST_CASE_1     MOVE.L  #$AAAAAAAA, $7A50
                BRA     START_PART1

* -- Test #2: Make minor modification to the stream of data from $A000 (found immediately)
TEST_CASE_2     MOVE.B  #$00, $A001     * -- Sum = 0xFE00 - 0xFF = 0xFD01
                BRA     START_PART1

* -- Test #3: Make minor modification to the stream of data from $A0000 (not found)
TEST_CASE_3     MOVE.L  #$AAAAAAAA, $7A50
                MOVE.B  #$00, $A0001    * -- Sum = 0xFE00 - 0xFF = 0xFD01
                BRA     START_PART1

* -- Test #4: Try a compare value that will be found at the middle of the range $A000 to $B000
*             Expect to see the sum not overflowing.
TEST_CASE_4     MOVE.B  #$13, $7A50
                MOVE.B  #$13, $A051     * -- ADDR1 = A051
                BRA     START_PART1

NO_TEST         BRA     START_PART1

END_PROGRAM     SIMHALT

* Put variables and constants here


CMP_START_ADDR  EQU     $A000
CMP_END_ADDR    EQU     $B000
CMP_ADDR        EQU     $7A50
NOTFOUND_ADDR   EQU     $A0000
ITER            EQU     512


ADDR1_OUTPUT    DC.B    'ADDR1 = ', 0
SUM_OUTPUT      DC.B    'CUMULATIVE SUM = ', 0
CARRY_OUTPUT    DC.B    'CARRY BIT = ', 0
EMPTY_LINE      DC.B    '', 0

ADDR1           DS.L    $1
ADDSUM          DS.W    $1
CARRYBIT        DS.B    $1

    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
