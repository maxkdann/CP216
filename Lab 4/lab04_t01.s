/*
-------------------------------------------------------
lan04_t01.s
-------------------------------------------------------
Author:  Maxwell Dann
ID:      190274440
Email:   dann4440@mylaurier.ca
Date:    2021-02-11
-------------------------------------------------------
*/
// Constants            
.equ UART_BASE, 0xff201000
.equ SIZE, 80
.equ VALID, 0x8000
.equ ENTER, 0x0a
.org 0x1000
//.txt
.global _start
_start:

LDR R1,=UART_BASE
LDR R4, =READ_STRING

LOOP:
LDRB R0, [R1]

CMP R0, #ENTER
STRB R0, [R1]      
BEQ _stop
STRB R0, [R4]
ADD R4,R4,#1
BEQ _stop
B	LOOP

_stop:
B	_stop

.data

READ_STRING:
.space	SIZE

.end