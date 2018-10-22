##################################################################################################################
# Assembly program to convert input to Morse code								 #
# @author: yadferhad												 #
# @version: 1.0.1												 #
# date: 10/23/18												 #
# license: MIT License												 #
##################################################################################################################
#----------------------------------Memory allocation for morse array & input-------------------------------------#
	.data 
input:	.asciiz "Hello World 255 times"			#Input string to be converted to morse code
size:	.word	21 					#Length of given input

Zero:	.asciiz "-----"					#Morse representations for numbers
One:	.asciiz ".----"
Two:	.asciiz	"..---"
Three:	.asciiz "...--"
Four:	.asciiz	"....-"
Five:	.asciiz	"....."
Six:	.asciiz	"-...."
Seven:	.asciiz	"--..."
Eight:	.asciiz	"---.."
Nine:	.asciiz	"----."

A: 	.asciiz ".-\0\0"				#Morse representations for alphabet letters
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

##################################################################################################################

table: 		.word	A, Bella, C, D, E, F, G, H, I, Jello, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
tableNumbers: 	.word	Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine

linebr: .asciiz "\n"					#New line to be printed after each word
space: 	.asciiz "  "					#Space to be printed after each letter
result: .asciiz	"Result:\n"				#Result indicator printed on run

##################################################################################################################
#----------------------------------Assembly instructions start here----------------------------------------------#
	.text
main:
	la 	$a0, result				#Load $a0 with result string
	li 	$v0, 4					#Load $v0 with char printing instruction 4
	syscall

##################################################################################################################
#----------------------------------Load variables from memory into registers-------------------------------------#
varLoad:
	la	$s0, input				#Load input from memory
	lw	$t5, size				#Load input size from memory
	li	$t0, 0					#Iterator
	li	$t4, 32					#New Line character
	li	$t6, 58					#Jump to numbers
	li	$t7, 97					#Jump to lowercase

##################################################################################################################
#----------------------------------Main morse code conversion subroutine-----------------------------------------#
morseLoop:	
	lb 	$s1, ($s0)				#Load one character from input
	beq	$s1, $t4, spacer			#Branch to spacer if char==32
	blt	$s1, $t6, numbers			#Branch to numbers if char < 58
	bge 	$s1, $t7, lower				#Branch to lower if char >= 97
	addi	$s2, $s1, -65				#Get morse array index of char
	mul 	$s2, $s2, 4				#Multiply index by 4, access at word boundaries
	lw	$a0, table($s2)				#Load word from table array into $a0
	li	$v0, 4					#Load $v0 with char printing instruction 4
	syscall
	la 	$a0, space				#Load $a0 with a space char
	syscall
	addi	$t0, $t0, 1				#Increment iterator
	addi	$s0, $s0, 1				#Increment input char selector
	blt	$t0, $t5, morseLoop			#If iterator < size, loop again
	j	morseExit				#Go to morseExit
	
##################################################################################################################
#----------------------------------------New Line printer subroutine---------------------------------------------#
spacer:
	la	$a0, linebr				#Load $a0 with a new line char
	li	$v0, 4					#Load $v0 with char printing instruction 4
	syscall
	addi	$t0, $t0, 1				#Increment iterator
	addi	$s0, $s0, 1				#Increment input char selector
	j 	morseLoop				#Go to morseLoop
	
##################################################################################################################
#----------------------------------------Numbers conversion subroutine-------------------------------------------#	
numbers:
	addi	$s2, $s1, -48				#Get morse array index of char
	mul	$s2, $s2, 4				#Multiply index by 4, access at word boundaries
	lw	$a0, tableNumbers($s2)			#Load word from tableNumbers array into $a0
	li	$v0, 4					#Load $v0 with char printing instruction 4
	syscall
	la 	$a0, space				#Load $a0 with a space char
	syscall
	addi	$t0, $t0, 1				#Increment iterator
	addi	$s0, $s0, 1				#Increment input char selector
	j 	morseLoop				#Go to morseLoop
	
##################################################################################################################
#----------------------------------------Lowercase conversion subroutine-----------------------------------------#
lower:
	addi	$s2, $s1, -97				#Get morse array index of char
	mul 	$s2, $s2, 4				#Multiply index by 4, access at word boundaries
	lw	$a0, table($s2)				#Load word from table array into $a0
	li	$v0, 4					#Load $v0 with char printing instruction 4
	syscall
	la 	$a0, space				#Load $a0 with a space char
	syscall
	addi	$t0, $t0, 1				#Increment iterator
	addi	$s0, $s0, 1				#Increment input char selector
	blt	$t0, $t5, morseLoop			#Go to morseLoop
	
##################################################################################################################
#-----------------------------------------------Program termination----------------------------------------------#
morseExit:
