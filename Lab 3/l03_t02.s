/*
-------------------------------------------------------
l03_t02.s
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

// Store data in registers
LDR	R3, =COUNTER		// Initialize a countdown value from memory

TOP:
SUB	R3, R3, #1	// Decrement the countdown value
CMP	R3, #0		// Compare the countdown value to 0
BGE	TOP			// Branch to top under certain conditions
	
_stop:
B	_stop

.data
COUNTER: //address is 00001018 in hex
.word 5



.end