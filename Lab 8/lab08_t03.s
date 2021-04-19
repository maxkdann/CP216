/*
-------------------------------------------------------
find_common.s
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

// push parameters onto the stack
LDR R0, =first
LDR R1, =second
LDR R2, =common
LDR R3, =SIZE
STMFD SP!,{R3} //push max size of common onto stack
STMFD SP!,{R2} //push address of common onto stack
STMFD SP!, {R1} //push address of second onto stack
STMFD SP!, {R0} //push address of first onto stack
BL     FindCommon
// clean up the stack
ADD SP, SP, #12




_stop:
B      _stop

//-------------------------------------------------------
FindCommon:
/*
-------------------------------------------------------
Equivalent of: FindCommon(*first, *second, *common, size)
Finds the common parts of two null-terminated strings from the beginning of the
strings. Example:
first: "pandemic"
second: "pandemonium"
common: "pandem", length 6
-------------------------------------------------------
Parameters:
  first - pointer to start of first string
  second - pointer to start of second string
  common - pointer to storage of common string
  size - maximum size of common
Returns:
	R2 - address of common string
Uses:
  R0 - address of first
  R1 - address of second
  R2 - address of common
  R3 - value of max length of common
  R4 - character in first
  R5 - character in second
-------------------------------------------------------
*/
// set up stack
STMFD  SP!, {FP, LR}  // push frame pointer and link register onto the stack
MOV    FP, SP         // Save current stack top to frame pointer
// allocate local storage (none)
STMFD  SP!, {R0-R1,R3-R5}   // preserve other registers

// extract parameters
LDR R0, [FP,#8] //get address of first
LDR R1, [FP,#12] //get address of second
LDR R2, [FP, #16] //get address of common
LDR R3, [FP,#20] //max size of common
//MOV R3, #SIZE

FCLoop:
CMP    R3, #1          // is there room left in common?
BEQ    _FindCommon     // no, leave subroutine
LDRB   R4, [R0], #1    // get next character in first
LDRB   R5, [R1], #1    // get next character in second
CMP    R4, R5
BNE    _FindCommon     // if characters don't match, leave subroutine
CMP    R5, #0          // reached end of first/second?
BEQ    _FindCommon
STRB   R4, [R2], #1    // copy character to common
SUB    R3, R3, #1      // decrement space left in common
B      FCLoop

_FindCommon:
MOV    R4, #0
STRB   R4, [R2]       // terminate common with null character
//store results to address parameters
//LDR R0, [FP, #16]
//STR R2, [R0]
//LDR R0, [FP,#20]
//RSC R0,  R3,#80
//MUL R0, #-1
//STR R3,[R0]
// clean up stack
LDMFD SP!, {R0-R1,R3-R5} //pop preserved registers
LDMFD SP!, {FP, PC} //pop frame pointer and program counter

//-------------------------------------------------------
.data
.align
first:
.asciz "pandemic"
.align
second:
.asciz "pandemonium"
.align
common:
.space SIZE

.end