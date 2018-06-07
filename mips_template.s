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
	add $t4, $a0, $a1	# add index to base address (lo)
	add $t5, $a0, $a2	# add index to base address (hi)
	add $t6, $t4, $t5 	# t6 = lo + hi
	div $t7, $t6, 2		# mid = (lo + hi) / 2
	slt $t8, $t5, $t4	# if hi < lo, t8 = 1, if hi > lo then t8 = 0
	bne $t8, $zero, swap	# if hi < lo, goes to swap
	slt $t8, $t5, $t7		# if hi < mid, t8 = 1, if hi > mid then t8 = 0
	bne $t8, $zero, swap	# if hi < lo, goes to swap
	slt $t8, $t7, $t4		# if mid < lo, t8 = 1, if mid > lo then t8 = 0
	bne $t8, $zero, swap	# if hi < lo, goes to swap
	j swap	# swap lo, mid
	
	# return to caller
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
	slt $t0, $a1 , $a2 	#checking if left value is less than right value
	beq $t0, $zero, done 	#if left is greater than or equal to right, leave partition
	add $t1, $a0, $a1	#get address of left index
	lw $t2, 0($t1)		#loading left number to register
	slt $t0, $a3, $t2	#checking if pivot is less than left number
	beq $t0, $zero, else	#if pivot is greater jump to 

else:
	
	# return to caller

done:	jr $ra


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