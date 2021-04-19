/*
-------------------------------------------------------
l03_t02.s
Copies contents of one vector to another.
-------------------------------------------------------
Author:  Max Dann
ID:      190274440
Email:   dann4440@mylaurier.ca
Date:    2021-01-27
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

.text	// code section
// Copy contents of first element of Vec1 to Vec2
LDR	R0, =Vec1
LDR	R1, =Vec2
LDR	R2, [R0]
STR	R2, [R1]
// Copy contents of second element of Vec1 to Vec2
ADD	R0, R0, #4 //changed from 2, size of a byte is 4
ADD	R1, R1, #4
LDR	R2, [R0]
STR	R2, [R1]
// Copy contents of second element of Vec1 to Vec2
ADD	R0, R0, #4 //changed from R1
ADD	R1, R1, #4
LDR	R2, [R0]
STR	R2, [R1] //changed destination address from R0 to R1
// End program
_stop:
B _stop

.data	// Initialized data section
Vec1:
.word	1, 2, 3	
.bss // Uninitialized data section (moved this)
Vec2:
.space 12 //changed this from word

.end