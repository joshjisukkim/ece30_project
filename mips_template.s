######################
#                    #
# Project Submission #
#                    #
######################

# Partner1: Ji Suk Kim, A12067496
# Partner2: Moulik Solanki, A12193762



.data 
array:	.word 5, 8, 1, 9, 3, 4, 2, 6

init:	.asciiz "The initial array is: "
final:	.asciiz "The sorted array is: "
comma:	.asciiz ", "
newline:.asciiz "\n"

.text
.globl main

########################
#        main          #
########################

main:	
	# Print the array
	la $a0,array
	la $a1,init
	li $a2,8
	jal printList

	# Quicksort
	la $a0,array
	li $a1,0
	li $a2,7
	li $a3, 6
	sll $a1, $a1, 2 	# multiplying the index by 4
	sll $a2, $a2, 2 	# multiplying the index by 4
	jal quickSort

	# Print the sorted array
	la $a0,array
	la $a1,final
	li $a2,8
	jal printList


exit:	li $v0,10
	syscall


########################
#        swap          #
########################
swap:
	# a0: base address
	# a1: index 1
	# a2: index 2
	# Swap the elements at the given indices in the list

	### INSERT YOUR CODE HERE
	add $t0, $a0, $a1	# add index to base address
	add $t1, $a0, $a2	# add index to base address
	
	lw $t2, 0($t0)		# load array element into register
	lw $t3, 0($t1)		# load array element into register
	sw $t2, 0($t1)		# saving array element
	sw $t3, 0($t0)		# saving array element
	
	# return to caller
	jr $ra


########################
#   medianOfThree      #
########################
medianOfThree:
	# a0: base address
	# a1: left
	# a2: right
	# Find the median of the first, last and the middle values of the given list
	# Make this the first element of the list by swapping

	### INSERT YOUR CODE HERE
	move $k1, $ra		# save return address
	add $t0, $a0, $a1	# add index to base address (lo)
	add $t1, $a0, $a2	# add index to base address (hi)
	add $t2, $a1, $a2 	# t2 = lo + hi
	div $t7, $t2, 8		# mid = (lo + hi) / 2
	sll $t7, $t7, 2 	# multiplying the index by 4
	add $t3, $a0, $t7	# add index to base address (mid)

	lw $t4, 0($t0)		# loading lo into register for comparison
	lw $t5, 0($t1)		# loading hi into register for comparison
	slt $t6, $t5, $t4	# if hi < lo, t6 = 1, if hi > lo then t6 = 0
	beq $t6, $zero, skip0	# if hi < lo, goes to swap, otherwise skip
	jal swap

skip0:	move $t8, $a1	# temp store lo index
	move $a1, $t7		# set a1 to mid index in case of swap
	move $t7, $t8		# save lo index into t7 for later
	lw $t4, 0($t3)		# loading mid into register for comparison
	lw $t5, 0($t1)		# loading hi into register for comparison
	slt $t6, $t5, $t4	# if hi < mid, t6 = 1, if hi > mid then t6 = 0
	beq $t6, $zero, skip1	# if hi < mid, goes to swap, otherwise skip
	jal swap
	
skip1:	move $t8, $a2	# temp store hi index
	move $a2, $t7		# set a2 to low index in case of swap
	move $t7, $t8		# save hi index into t7 for later
	lw $t4, 0($t0)		# loading low into register for comparison
	lw $t5, 0($t3)		# loading mid into register for comparison
	slt $t6, $t5, $t4	# if mid < lo, t6 = 1, if mid > lo then t6 = 0
	beq $t6, $zero, skip2	# if mid < lo, goes to swap, otherwise skip
	jal swap

skip2:	jal swap		# swap lo, mid
	
	move $t8, $a2		# temp store hi index
	move $a2, $t7		# set a2 to low index in case of swap
	move $t7, $t8		# save hi index into t7 for later
	# return to caller
	move $ra, $k1		# set ra back to the linked register
	jr $ra


########################
#      partition       #
########################
partition:
 
	# a0: base address
	# a1: left  = first index to be partitioned
	# a2: right = last index to be partitioned
	# a3: pivot value
	# Return:
	# v0: The final index for the pivot element
	# Separate the list into two sections based on the pivot value


	### INSERT YOUR CODE HERE
	move $k0, $ra			# saving return address in case swap is called
	
partition1:
	slt $t0, $a1, $a2 		# checking if left value is less than right value
	beq $t0, $zero, donep 	# if left is greater than or equal to right, leave partition
	beq $a1, $a2, donep 	# if left is greater than or equal to right, leave partition
	add $t0, $a0, $a1		# add left index to base address
	lw $t1, 0($t0)			# loading left most number to register
	slt $t0, $a3, $t1		# checking if pivot is less than left number, if true t0 = 1, otherwise t0 = 0
	beq $t0, $zero, else	# if pivot is greater jump to else
	addi $a2, $a2, -4		# subtract 4 from right index to get right-1
	jal swap				# swap
	j partition1			# run partition on left to right-1 index
	
else:	
	addi $a1, $a1, 4		# add 4 to left index to get left+1
	j partition1			# run partition on left+1 to right index
	
	# return to caller

donep:	move $v0, $a1		# return pivot index by setting v0 = left
	move $ra, $k0
	jr $ra


########################
#      quickSort       #
########################
quickSort:
	# a0: base address
	# a1: left  = first index to be sorted
	# a2: right = last index to be sorted
	# Sort the list using recursive quick sort using the above functions

	### INSERT YOUR CODE HERE

	# return to caller
	jr $ra


########################
#      printList       #
########################
printList:	
	# a0: base address
	# a1: message to be printed
	# a2: length of the array
	add $t0,$a0,$0
	add $t1,$a2,$0

	li $v0,4
	add $a0,$a1,$0
	syscall			#Print message
	
	
next:
	lw $a0,0($t0)
	li $v0,1
	syscall			#Print int

	addi $t1,$t1,-1
	bgt $t1,$0,pnext	
	li $v0,4		# if end of list
	la $a0,newline		# Print newline
	syscall
	jr $ra
pnext:	addi $t0,$t0,4
	li $v0,4
	la $a0,comma
	syscall			# Print comma
	j next
