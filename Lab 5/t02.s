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
MOV R4, #0 //initialize R4 as a count var
MOV R5, #0 //byte counter
LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list
SUB R5, R3, R2 //store the difference between the start and end of the list in mem
MOV R5, R5, LSR #2 //divide by 4 to get the number of bytes


Loop:
LDR    R0, [R2], #4	// Read address with post-increment (R0 = *R2, R2 += 4)
ADD R4, R4, #1 //increment R4 by one
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