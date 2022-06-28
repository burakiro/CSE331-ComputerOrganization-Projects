.data
givenArray: .word 8, 5, 11, 6, 13,2
subSequenceArray: .space 400
longestIncArr: .space 400
openBracket: .asciiz "["
comma: .asciiz ","
newLine: .asciiz "\n"
size: .asciiz "] Size = "
maxSizeArray: .asciiz "Longest Increasing Subsequence: "

.text
.globl main
main:
jal finderFunc

la $a0, newLine
li $v0, 4
syscall

la $a0, maxSizeArray
li $v0, 4
syscall

la $a0, openBracket
li $v0,4
syscall

printResultArr:

lw $s6, longestIncArr($s5)
move $a0, $s6
li $v0, 1
syscall

la $a0, comma
li $v0, 4
syscall

addi $s5, $s5, 4 #z'yi arttýrýr
slt  $t5, $s5, $s0 # I10 $t5 = 1 if $s5 < $s0,
bne $t5, $zero, printResultArr # Go to printResultArr if $s5 < $s0 ///// printArrLoop END!
move $s5, $zero
add $s5, $zero, 0 # q is initalized as q=0 for printArr

la $a0, size
li $v0, 4
syscall

div $s0, $s0, 4
la $a0, ($s0)
li $v0, 1
syscall

la $a0, newLine
li $v0, 4
syscall


li $v0,10
syscall

finderFunc:

add $t1, $zero, 0 # i is initalized as 0 in $t1
add $t4, $t1 , 4 # j is initalized as j = i+1
add $t7, $t4, 4 # k is initalized as k = j+1
add $s1, $zero, 0 # z is initalized as z=0
add $s5, $zero, 0 # q is initalized as q=0 for printArr
li $s0, 0 #sizeOfLongestSeq=0 in s0

Loop1:
Loop2:

move $t6, $zero #sizeOfSequence=0
lw $t8, givenArray($t1)
sw $t8, subSequenceArray($t6)#subSequenceArray[sizeOfSequence]=givenArray[i]
add $t6, $t6, 4 #sizeOfSequence++

lw $t2, givenArray($t4) # givenArray[j]
add $t5, $t6, -4 #sizeOfSequence-1
lw $t3 , subSequenceArray($t5) #subSequenceArray[sizeOfSequence-1] 
blt $t2 , $t3, Loop2End #else statement is Loop2End


sw $t2, subSequenceArray($t6) #subSequenceArray[sizeOfSequence] = givenArray[j]
add $t6, $t6, 4 #sizeOfSequence++

Loop3:
bgt $t7, 28, Loop3End 
add $t5, $t6, -4 #sizeOfSequence-1
lw $t3 , subSequenceArray($t5) #subSequenceArray[sizeOfSequence-1] 
lw $t9, givenArray($t7)#givenArray[k]
blt $t9, $t3, Loop3End
sw $t9, subSequenceArray($t6) # if givenArray[k]>=subSequenceArray[sizeOfSequence-1] , subSequenceArray[sizeOfSequence]=givenArray[k];
add $t6, $t6, 4 #sizeOfSequence++



Loop3End:
addi $t7, $t7, 4 #  k = k + 1, $t7= k
slti $t0, $t7, 24 # $t0 = 1 if $t7 < 24
bne $t0, $zero, Loop3 # go to Loop if $t7 < 24 ///// LOOP 3 END!


la $a0, openBracket
li $v0,4
syscall
printArrLoop:

lw $s6, subSequenceArray($s5)
move $a0, $s6
li $v0, 1
syscall

la $a0, comma
li $v0, 4
syscall


addi $s5, $s5, 4 #z'yi arttýrýr
slt  $t5, $s5, $t6 # I10 $t5 = 1 if $t1 < 32, i.e. i < 8
bne $t5, $zero, printArrLoop # Go to printArrLoop if $t4 < 28 ///// printArrLoop END!
move $s5, $zero
add $s5, $zero, 0 # q is initalized as q=0 for printArr for the if you come again printArrLoop 

la $a0, size
li $v0, 4
syscall

div $t5, $t6 ,4
la $a0, ($t5)
li $v0, 1
syscall

la $a0, newLine
li $v0, 4
syscall


blt $t6, $s0, Loop2End
move $s0, $t6 #sizeOfLongestSeq=sizeOfSequence;

Loop4:

lw $s2, subSequenceArray($s1) #subSequenceArray[z]
sw $s2, longestIncArr($s1) #longestIncArr[z]=subSequenceArray[z];


Loop4End:
addi $s1, $s1, 4 #z'yi arttýrýr
slt  $t5, $s1, $t6 # I10 $t5 = 1 if $t1 < 32, i.e. i < 8
bne $t5, $zero, Loop4 # I11 go to Loop if $t4 < 28 ///// LOOP 4 END!
move $s1 , $zero
add $s1, $zero, 0 # z is initalized as z=0

Loop2End:
addi $t4, $t4, 4 #  j = J + 1, $t4 = j
slti $t0, $t4, 24 # $t0 = 1 if $t4 < 24
add $t7, $t4, 4 # k is initalized as k = j+1 end of loop2
bne $t0, $zero, Loop2 # go to Loop if $t4 < 28 ///// LOOP 2 END!


Loop1End:
addi $t1, $t1, 4 #i'yi arttýrýr
slti $t5, $t1, 20 # $t5 = 1 if $t1 < 20, i.e. i < 8
add $t4 , $t1 , 4 # j is initalized as j = i+1
add $t7, $t4, 4 # k is initalized as k = j+1
bne $t5, $zero, Loop1 # go to Loop if $t4 < 20 ///// LOOP 1 END!
jr $ra
