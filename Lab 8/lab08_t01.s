/*
-------------------------------------------------------
strncmp.s
Working with stack frames.
-------------------------------------------------------
Author:
ID:
Email:
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

MOV    R3, #SIZE   // Set the maximum comparison length
STMFD  SP!, {R3}         // Push the maximum length
LDR    R3, =second
STMFD  SP!, {R3}         // Push the second string address
LDR    R3, =first
STMFD  SP!, {R3}         // Push the first string address
BL     strncmp
ADD    SP, SP, #12       // Release the parameter memory from stack

// Result in R0
_stop:
B    _stop

//-------------------------------------------------------
strncmp:
/*
-------------------------------------------------------
Determines if two strings are equal up to a max length (iterative)
Equivalent of: strncmp(*str1, *str2, max_buffer_size)
-------------------------------------------------------
Parameters:
  str1 - address of first string
  str2 - address of second buffer
  max_buffer_size - maximum size of str1 and str2
Returns:
  R0 - less than 0 if first string comes first,
       greater than 0 if first string comes second,
       0 if two strings are equal up to maximum length
Uses:
  R1 - address of first string
  R2 - address of second string
  R3 - current maximum length
  R4 - character from first string
  R5 - character from second string
-------------------------------------------------------
*/

// get parameters from stack and save registers
STMFD SP!, {FP, LR} //push frame pointer and linke register onto the stack
MOV FP, SP //save current stack top to frame pointer
STMFD SP!, {R1-R5} // preserve other registers

LDR R1, [FP, #8] //get paramaters
LDR R2, [FP,#12]
MOV     R0, #0          // Initialize result to strings equal

strncmpLoop:
CMP     R3, #0
BEQ     _strncmp        // Max length met - finish comparison
LDRB    R4, [R1], #1    // Get character from first string
LDRB    R5, [R2], #1    // Get character from second string
CMP     R4, R5
SUBNE   R0, R4, R5      // Calculate difference between two characters if not the same
BNE     _strncmp        // Return difference if not the same
CMP     R4, #0          // look for end of first string
BEQ     _strncmp        // return if at end of string
CMP     R5, #0          // look for end of second string
BEQ     _strncmp        // return if at end of string
SUB     R3, R3, #1      // decrement max length count
B       strncmpLoop

_strncmp:
// pop stack
LDMFD SP!, {R1-R5} //pop preserved registers
LDMFD SP!, {FP, PC} //pop frame pointer and program counter

//-------------------------------------------------------
.data
first:
.asciz "aaab"
second:
.asciz "aaaa"

.end