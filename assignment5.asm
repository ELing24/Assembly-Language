; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ethan Lingad
; Email: eling007@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 024
; TA: Daniel Tan and Adil Mirza
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
; * put your code here
lea r1, user_prompt
lea r2, user_string
ld r5, get_user_string_addr
jsrr r5
; find size of input string
; * put your code here
and r0, r0, x0
lea r1, user_string
ld r5, strlen_addr
jsrr r5

; call palindrome method
; * put your code here
and r2, r2, x0
add r2, r1, r0
add r2, r2, #-1
and r0, r0, x0
ld r5, palindrome_addr
jsrr r5
; determine of stirng is a palindrome
; * put your code here
add r0, r0, x0
brz isNot
lea r0, result_string
puts
lea r0, final_string
puts
br end_main
isNot
lea r0, result_string
puts
lea r0, not_string
puts
lea r0, final_string
puts
end_main
; print the result to the screen
; * put your code here

; decide whether or not to print "not"
; * put your code here


HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400


; Reserve memory for strings in the progrtam
user_prompt          .STRINGZ "Enter a string: "
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ	"a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  #100

.END

;---------------------------------------------------------------------------------
; get_user_string - gets string from user
; parameter - R1 - sub_string to print
; R2 - addr of user string
;---------------------------------------------------------------------------------
.ORIG x3200
get_user_string
; Backup all used registers, R7 first, using proper stack discipline
add r6, r6, #-1
str r0, r6, #0

add r6, r6, #-1
str r1, r6, #0

add r6, r6, #-1
str r2, r6, #0

add r6, r6, #-1
str r3, r6, #0

add r6, r6, #-1
str r4, r6, #0

add r6, r6, #-1
str r5, r6, #0

add r6, r6, #-1
str r7, r6, #0

add r0, r1, x0
puts
and r1, r1, x0
ld r3, newline_3200
not r3, r3
add r3, r3, #1

char_loop_3200
    getc 
    out
    
    str r0, r2, #0
    add r0, r0, r3
    brz end_char_loop_3200
    add r2, r2, #1
    br char_loop_3200
end_char_loop_3200
and r0, r0, x0
str r0, r2, #0


; Restore all used registers, R7 last, using proper stack discipline
ldr r7, r6, #0
add r6, r6, #1

ldr r5, r6, #0
add r6, r6, #1

ldr r4, r6, #0
add r6, r6, #1

ldr r3, r6, #0
add r6, r6, #1

ldr r2, r6, #0
add r6, r6, #1

ldr r1, r6, #0
add r6, r6, #1

ldr r0, r6, #0
add r6, r6, #1
ret
newline_3200 .fill x0a
.END

;---------------------------------------------------------------------------------
; strlen - copmpute the length of a zero temrinated string
; parameter: R1 - addr of a zero terminated string
; returns: The length of the string (R0)
;---------------------------------------------------------------------------------
.ORIG x3300
strlen
; Backup all used registers, R7 first, using proper stack discipline

add r6, r6, #-1
str r1, r6, #0

add r6, r6, #-1
str r2, r6, #0

add r6, r6, #-1
str r3, r6, #0

add r6, r6, #-1
str r4, r6, #0

add r6, r6, #-1
str r5, r6, #0

add r6, r6, #-1
str r7, r6, #0

char_loop_3300
    and r2, r2, x0
    ldr r3, r1, #0
    add r2, r3, #0
    brz end_char_loop_3300
    add r0, r0, #1
    add r1, r1, #1
    br char_loop_3300
end_char_loop_3300

; Resture all used registers, R7 last, using proper stack discipline
ldr r7, r6, #0
add r6, r6, #1

ldr r5, r6, #0
add r6, r6, #1

ldr r4, r6, #0
add r6, r6, #1

ldr r3, r6, #0
add r6, r6, #1

ldr r2, r6, #0
add r6, r6, #1

ldr r1, r6, #0
add r6, r6, #1

ret
.END

;---------------------------------------------------------------------------------
; palindrome - Check to see if string is palindrome
; parameter: R1 - addr of first letter of string
; R2 - addr of the last letter of string
;returns: value stored in R0 (1 if isPalin, 0 if isNotPalin)
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
palindrome_start
add r6, r6, #-1
str r1, r6, #0

add r6, r6, #-1
str r2, r6, #0

add r6, r6, #-1
str r3, r6, #0

add r6, r6, #-1
str r4, r6, #0

add r6, r6, #-1
str r5, r6, #0

add r6, r6, #-1
str r7, r6, #0
;r1 and r2
ld r0, dec_1
add r3, r1, x0
not r3, r3
add r3, r3, #1
add r4, r2, x0
add r4, r4, r3
brnz end_3400
ldr r3, r1, #0
not r3, r3
add r3,r3, #1
ldr r4, r2, #0
add r4, r4, r3
brnp end_palindrome
add r1, r1,  #1
add r2, r2, #-1
br palin
end_palindrome
and r0, r0, x0
br end_3400
palin
jsr palindrome_start
end_3400


; Resture all used registers, R7 last, using proper stack discipline
ldr r7, r6, #0
add r6, r6, #1

ldr r5, r6, #0
add r6, r6, #1

ldr r4, r6, #0
add r6, r6, #1

ldr r3, r6, #0
add r6, r6, #1

ldr r2, r6, #0
add r6, r6, #1

ldr r1, r6, #0
add r6, r6, #1

ret
dec_1 .fill #1
.END
