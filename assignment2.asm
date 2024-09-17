;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ethan Lingad
; Email: eling007@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC ;GETS INPUT AND STORES IN R0
OUT  ;OUTPUTS R0
AND R1, R1, x0 ;LOAD IN R2
ADD R1, R0, #0 ;STORE VALUE FROM INPUT INTO R1
LEA R0, newline
PUTS

GETC
OUT
AND R2, R2, x0
ADD R2, R0, #0;STORE 2ND VALUE INTO R2
LEA R0, newline
PUTS

AND R0, R0, x0
ADD R0, R1, #0
OUT ;OUTPUTS ASCII IN R0

LEA R0, SUBTRACT
PUTS ;OUTPUTS SUBTRACT SYMBOL

AND R0, R0, x0
ADD R0, R2, #0
OUT

LEA R0, EQUALS
PUTS

;0 in ascii = 048 in binary so subtract by 12
;four times to convert to binary representation

ADD R1, R1, #-12
ADD R1, R1, #-12
ADD R1, R1, #-12
ADD R1, R1, #-12

ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12
ADD R2, R2, #-12

NOT R2, R2 ;TAKE TWO'S COMPLEMENT BY NEGATE THEN ADD 1
ADD R2, R2, #1
AND R3, R3, x0
ADD R3, R2, R1;EXECUTES A+(-B)

BRzp OUTPUT
LEA R0, NEGATIVE
PUTS
NOT R3, R3 ;TAKE TWO'S COMPLEMENT AGAIN
ADD R3, R3, #1
OUTPUT

ADD R0, R3, x0
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
ADD R0, R0, #12
OUT

LEA R0, newline
PUTS


HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
SUBTRACT .STRINGZ " - "
NEGATIVE .STRINGZ "-"
EQUALS .STRINGZ " = "
newline .FILL x0A	; newline character - use with LD followed by OUT


;---------------	
;END of PROGRAM
;---------------	
.END

