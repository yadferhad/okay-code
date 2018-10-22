.data
bar: 	.asciiz " | "
colon: 	.asciiz ":"
newline: .asciiz "\n"
letter: .asciiz "A"
space: .asciiz " "
.text

li	$t0,65
li	$s6,91

li	$s7,97
li	$t1,122



loop:
	add	$a0,$zero,$t0
	li	$v0,1
	syscall
	addi	$t0,$t0,1
	la	$a0,colon
	li	$v0,4
	syscall
	
	la	$a0,letter
	li	$v0,4
	syscall
	lb	$t2,($a0)
	addi	$t2,$t2,32
	sb	$t2,letter
	
	la	$a0,space
	syscall 
	la	$a0,bar
	syscall 
	la	$a0,space
	syscall
	add	$a0,$zero,$s7
	li	$v0,1
	syscall
	addi	$s7,$s7,1
	la	$a0,colon
	li	$v0,4
	syscall
	
	la	$a0,letter
	li	$v0,4
	syscall
	lb	$t2,($a0)
	subi	$t2,$t2,31
	sb	$t2,letter
	
	la	$a0,newline
	li	$v0,4
	syscall
	blt	$t0,$s6,loop
