	.data 
input:	.asciiz "Next in CMPS255 we will learn how to design a CPU"
size:	.word	49 #length of input

Zero:	.asciiz "-----"
One:	.asciiz ".----"
Two:	.asciiz	"..---"
Three:	.asciiz "...--"
Four:	.asciiz	"....-"
Five:	.asciiz	"....."
Six:	.asciiz	"-...."
Seven:	.asciiz	"--..."
Eight:	.asciiz	"---.."
Nine:	.asciiz	"----."

A: 	.asciiz ".-\0\0"
Bella: 	.asciiz	"-..."
C:	.asciiz	"-.-."
D:	.asciiz	"-..\0"
E:	.asciiz	".\0\0\0"
F:	.asciiz	"..-."
G:	.asciiz	"--.\0"
H:	.asciiz	"...."
I:	.asciiz	"..\0\0"
Jello:	.asciiz	".---"
K:	.asciiz	"-.-\0"
L:	.asciiz	".-.."
M:	.asciiz	"--\0\0"
N:	.asciiz	"-.\0\0"
O:	.asciiz	"---\0"
P:	.asciiz	".--."
Q:	.asciiz	"--.-"
R:	.asciiz	".-.\0"
S:	.asciiz	"...\0"
T:	.asciiz	"-\0\0\0"
U:	.asciiz	"..-\0"
V:	.asciiz	"...-"
W:	.asciiz	".--\0"
X:	.asciiz	"-..-"
Y:	.asciiz	"-.--"
Z:	.asciiz	"--.."

table: 		.word	A, Bella, C, D, E, F, G, H, I, Jello, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
tableNumbers: 	.word	Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine

linebr: .asciiz "\n"
space: 	.asciiz "  "
result: .asciiz	"Result:\n"

	.text
main:
	la 	$a0, result
	li 	$v0, 4
	syscall


convertToMorse:
	la	$s0, input
	lw	$t5, size
	la	$s3, table
	li	$t0, 0		#Iterator
	li	$t4, 32		#spacer
	li	$t6, 58		#numbers
	li	$t7, 97		#lowercase

morseLoop:	
	lb 	$s1, ($s0)
	beq	$s1, $t4, spacer
	blt	$s1, $t6, numbers
	bge 	$s1, $t7, lower
	addi	$s2, $s1, -65
	mul 	$s2, $s2, 4
	lw	$a0, table($s2)
	li	$v0, 4
	syscall
	la 	$a0, space
	syscall
	addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	blt	$t0, $t5, morseLoop
	j	morseExit
	
spacer:
	la	$a0, linebr
	li	$v0, 4
	syscall
	addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	morseLoop
	
		
numbers:
	addi	$s2, $s1, -48
	mul	$s2, $s2, 4
	lw	$a0, tableNumbers($s2)
	li	$v0, 4
	syscall
	la 	$a0, space
	syscall
	addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	j 	morseLoop
	
lower:
	addi	$s2, $s1, -97
	mul 	$s2, $s2, 4
	lw	$a0, table($s2)
	li	$v0, 4
	syscall
	la 	$a0, space
	syscall
	addi	$t0, $t0, 1
	addi	$s0, $s0, 1
	blt	$t0, $t5, morseLoop
	

morseExit: