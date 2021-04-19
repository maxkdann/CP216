/*
-------------------------------------------------------
list_demo.s
A simple list demo program. Traverses all elements of an integer list.
R0: temp storage of value in list
R2: address of start of list
R3: address of end of list
-------------------------------------------------------
Author:  Maxwell Dann
ID:      190274440
Email:   dann4440@mylaurier.ca
Date:    2021-02-26
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:
LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list
LDR R6,[R2] //minimum value
LDR R7, [R2] //maximum value


Loop:
LDR    R0, [R2], #4	// Read address with post-increment (R0 = *R2, R2 += 4)
CMP R0,R6 //compare current value with minimum
MOVLT R6, R0 //update minimum if smaller
CMP R0, R7 //compare current value with maximum
MOVGT R7, R0 //update value if bigger
CMP    R3, R2       // Compare current address with end of list
BNE    Loop         // If not at end, continue

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	// End of list address

.end