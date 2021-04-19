/*
-------------------------------------------------------
sub_read.s
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20    	// Size of string buffer storage (bytes)
.text  // Code section
.org	0x1000	// Start at memory location 1000
.global _start
_start:

MOV    R5, #SIZE
//load the first register with space for first
LDR    R4, =First
BL	   ReadString
//allocate space for second
LDR    R4, =Second
BL	   ReadString
//allocate space for third
LDR    R4, =Third
BL     ReadString
//allocate space for fourth
LDR    R4, =Last
BL     ReadString
    
_stop:
B	_stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address
.equ VALID, 0x8000	// Valid data in UART mask
.equ DATA, 0x00FF	// Actual data in UART mask
.equ ENTER, 0x0A	// End of line character

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  R4 - address of string buffer
  R5 - size of string buffer
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/
//store the register contents in system stack
STMFD  SP!, {R0-R1, R4,R5, LR}
// read a string from the UART
LDR  R1, =UART_BASE
ADD  R5, R4, #SIZE // store address of end of buffer

LOOP:
LDRB  R0, [R1]  // read the UART data register

CMP R0, #ENTER //compare against enter (added this)
BEQ _ReadString //return if enter found
STRB R0, [R4]	//write character to memory
STRB R0, [R1]      // copy the character to the UART DATA field
ADD  R4, R4, #1    // move to next byte in storage buffer

CMP  R4, R5        // end program if buffer full
BEQ  _ReadString
B    LOOP
//end of subroutine
_ReadString:
LDR R0,=ENTER //add an enter after the string is processed
STR R0, [R1]
LDMFD  SP!, {R0-R1, R4,R5, PC} //restore registers to original values in stack

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space	SIZE
Third:
.space	SIZE
Last:
.space	SIZE
_Last:    // End of list address

.end