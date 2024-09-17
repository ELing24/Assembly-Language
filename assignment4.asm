;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ethan Lingad
; Email: eling007@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 024
; TA: Daniel Tan & Adil Mirza
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------
ld r6, top_stack_addr
br intro_prompt
error_prompt
    ld r0, errorMessagePtr
    puts
; output intro prompt
intro_prompt
    ld r0, introPromptPtr
    puts
; Set up flags, counters, accumulators as needed
and r0, r0, x0
and r4, r4, x0
and r2, r2, x0
and r3, r3, x0
and r1, r1, x0
add r1, r1, #-1

char_loop
    getc
    out
    ld r5, validate_input
    jsrr r5
    add r3, r3, #0
    brn end_char_input
    brz error_prompt
    add r2, r2, #1
    and r5, r5, x0
    add r5, r2, #-5
    brzp loop_sign
    br char_loop
    loop_sign
        add r1, r1, #0
        brn end_char_loop
        
        add r5, r2, #-6
        brn char_loop
end_char_loop
ld r0, newline
out
end_char_input
neg_check
    add r1, r1, #0
    brnz end_neg_check
    not r4, r4
    add r4, r4, #1
end_neg_check
add r5, r2, #-5

; Get first character, test for '\n', '+', '-', digit/non-digit 	
					
; is very first character = '\n'? if so, just quit (no message)!

; is it = '+'? if so, ignore it, go get digits

; is it = '-'? if so, set neg flag, go get digits
					
; is it < '0'? if so, it is not a digit	- o/p error message, start over

; is it > '9'? if so, it is not a digit	- o/p error message, start over
				
; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator

; remember to end with a newline!
					
HALT

;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
newline .fill x0a
validate_input .fill x3200
top_stack_addr .fill xFE00
.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.END					
					
.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END
;---------------------------------------
;subroutine: validate_input
;parameter: r0 - character to validate
;r4, current value writing to
;r2, number of chars 
;r1, sign flag -1 or 0
;postcondition: checks if input is valid and will return if it was
;valid or not
;return: r4 - the new value to append
;r3 - -1 if program should end, 0 if program should start again,
;1 if program should continue
;r1 sign flag - only for first loop
;
;---------------------------------------
.orig x3200
add r6, r6, #-1
str r2, r6, #0

add r6, r6, #-1
str r5, r6, #0

add r6, r6, #-1
str r7, r6, #0

add r6, r6, #-1
str r0, r6, #0

;subroutine
add r2, r2,x0
brnp end_first_validation
first_check
    and r1, r1, x0
    first_enter
        ld r5, newline_3200
        not r5, r5
        add r5, r5, #1
        add r5, r0, r5
        brnp first_neg
        and r3, r3, x0
        add r3, r3, #-1
        br end_validation
    first_neg
        ld r5, neg_sign_3200
        not r5, r5
        add r5, r5, #1
        add r5, r0, r5
        brnp first_pos_check
        add r1, r1, #1
        and r3, r3, x0
        add r3, r3, #1
        br end_validation
    first_pos_check
        ld r5, pos_sign_3200
        not r5, r5
        add r5, r5, #1
        add r5, r0, r5
        brnp end_check_3200
        and r3, r3, x0
        add r3, r3, #1
        br end_validation
        
    end_check_3200
    add r1, r1, #-1
end_first_validation
enter_check_3200
    ld r5, newline_3200
    not r5, r5
    add r5, r5, #1
    add r5, r0, r5
    brnp number_check_3200
    add r2, r2, #-1
    brnp valid_input
    add r1, r1, #0
    brn valid_input
    and r3, r3, x0
    br end_validation
    valid_input
    and r3, r3, x0
    add r3, r3, #-1
    br end_validation
number_check_3200
    ld r5, char_0_3200
    not r5, r5
    add r5, r5, #1
    add r5, r0, r5
    brn number_check_error
    ld r5, char_9_3200
    not r5, r5
    add r5, r5, #1
    add r5, r0, r5
    brp number_check_error
    and r2, r2, x0
    add r2, r0, #0
    add r2, r4, #0
    ld r5, dec_9_3200
    multiply_10
        add r4, r2, r4
        add r5, r5, #-1
        brp multiply_10
    add r0, r0, #-12
    add r0, r0, #-12
    add r0, r0, #-12
    add r0, r0, #-12
    add r4, r0, r4
    and r3, r3, x0
    add r3, r3, #1
    br end_validation
    
    number_check_error
        ld r0, newline_3200
        out
        and r3, r3, x0
end_validation
;subroutine
ldr r0, r6, #0
add r6, r6, #1

ldr r7, r6, #0
add r6, r6, #1

ldr r5, r6, #0
add r6, r6, #1

ldr r2, r6, #0
add r6, r6, #1

;ldr r0, r6, #0
;add r6, r6, #1

ret

char_0_3200 .fill #48
newline_3200 .fill x0a
neg_sign_3200 .fill #45
pos_sign_3200 .fill #43
dec_9_3200 .fill #9
char_9_3200 .fill #57
.end


;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by  the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
