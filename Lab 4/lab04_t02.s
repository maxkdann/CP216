/*
-------------------------------------------------------
read_string.s
Reads a string from the UART
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-11-03
-------------------------------------------------------
*/
//constants
.equ UART_BASE, 0xff201000 
.equ SIZE, 80
.equ VALID, 0x8000
.equ ENTER, 0x0a
.org 0x1000


.global _start
_start:

LDR R1, =UART_BASE
LDR R4, =READ_STRING
ADD R5, R4, #SIZE

LOOP:
LDRB R0, [R1]
CMP R0, #ENTER
BEQ _stop
STRB R0, [R4]
ADD R4,R4, #1
CMP R4, R5
BEQ _stop
B LOOP

_stop:
B 	_stop

.data

READ_STRING:
.space	SIZE

.end 