/*
-------------------------------------------------------
l03_t01.s
A simple count down program (BGT)
-------------------------------------------------------
Author:  Maxwell Dann
ID:      190274440
Email:   dann4440@mylaurier.ca
Date:    2021-02-03
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

.text	// code section
// Store data in registers
MOV	R3, #5		// Initialize a countdown value
	
TOP:
SUB	R3, R3, #1	// Decrement the countdown value
CMP	R3, #0		// Compare the countdown value to 0
BGE	TOP	        //changes to ffffffff or -1

_stop:
B	_stop

.end