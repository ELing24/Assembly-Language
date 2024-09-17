;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ethan Lingad
; Email: eling007@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 024
; TA: Adil Mirza & Daniel Tan
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, DEC_4
OUTER_LOOP
    LD R3, DEC_4
    INNER_LOOP
        LD R0, DEC_48 ;0 IN ASCII
        LD R5, LEADING 
        AND R5, R5, R1
        BRn PRINT_1
        
        PRINT_0
            OUT
            BR END_PRINT
        PRINT_1
            ADD R0,R0, #1
            OUT
        
        END_PRINT
        ADD R1, R1, R1
        ADD R3, R3, #-1
        BRp INNER_LOOP

    ADD R2,R2,#-1
    BRz END_PORTION
    
    LD R0, SPACE
    OUT
    BR OUTER_LOOP
END_PORTION

LD R0, NEWLINE
OUT
        

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
NEWLINE .FILL x0A
DEC_4 .FILL #4
DEC_48 .FILL #48 ;ASCII 0
LEADING .FILL #32768
SPACE .FILL #32
.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
