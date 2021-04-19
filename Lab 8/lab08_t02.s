/*
-------------------------------------------------------
min_max.s
Working with stack frames.
-------------------------------------------------------
Author:
ID:
Email:
Date:    2020-12-14
-------------------------------------------------------
*/
.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

// your code here
LDR R0, =_Data //address of end of list
LDR R1, =Data //address of start of list
STMFD SP!, {R0} //push end of list onto stack
STMFD SP!, {R1}//push start of list onto stack
BL MinMax
ADD SP, SP, #8 //release the parameter memory from the stack
STR R2, [R0, #4] //store the minimum value in memory
STR R3, [R0,#8] //store the maximum value in memory

_stop:
B    _stop

//-------------------------------------------------------
MinMax:
/*
-------------------------------------------------------
Finds the minimum and maximum values in a list.
Equivalent of: MinMax(*start, *end, *min, *max)
Passes addresses of list, end of list, max, and min as parameters.
-------------------------------------------------------
Parameters:
  start - start address of list
  end - end address of list
  min - address of minimum result
  max - address of maximum result
Uses:
  R0 - address of start of list
  R1 - address of end of list
  R2 - minimum value so far
  R3 - maximum value so far
  R4 - address of value to process
-------------------------------------------------------
*/
STMFD  SP!, {FP, LR}  // push frame pointer and link register onto the stack
MOV    FP, SP         // Save current stack top to frame pointer
// allocate local storage (none)
STMFD  SP!, {R0-R4}   // preserve other registers

LDR    R0, [FP, #8]   // Get address of start of list
LDR    R2, [R0]       // store first value as minimum
LDR    R3, [R0], #4   // store first value as maximum
LDR    R1, [FP, #12]  // get address of end of list

MinMaxLoop:
CMP    R0, R1   // Compare addresses
BEQ    _MinMax
LDR    R4, [R0], #4 //add next element of the list to R4
CMP    R4, R2 //compare current element with minimum
MOVLT  R2, R4 //if the value is less than keep it as new min
CMP    R4, R3 //compare current value with max
MOVGT  R3, R4 //
B      MinMaxLoop

_MinMax:
// Store results to address parameters
LDR    R0, [FP, #16]
STR    R3, [R0]
LDR    R0, [FP, #20]
STR    R2, [R0]

LDMFD  SP!, {R0-R4}   // pop preserved registers
// deallocate local storage (none was allocated)
LDMFD  SP!, {FP, PC}  // pop frame pointer and program counter

//-------------------------------------------------------
.data  // Data section
.align
Data:
.word    4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:    // End of list address
Min:
.space 4
Max:
.space 4

.end