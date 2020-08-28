;
; rose_ben_assignment1.asm.asm
;
; Created: 10/22/2018 9:45:53 PM
; Author : Ben Rose
; I pledge my honor that I have abided by the Stevens Honor System. -Ben Rose

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~~~USAGE~~~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;~ Call test values: can be modified	 ~;
;~ to fit any values that the user		 ~;
;~ wishes. Feel free to edit in grading. ~;
;~ The line will not be commented, but	 ~;
;~ feel free to do so. The program		 ~;
;~ isn't very useful or exciting		 ~;
;~ without test values. Refer to		 ~;
;~ CS 383's assignment 1 for memory		 ~;
;~ locations and desired results		 ~;
;~ if needed.							 ~;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~END USAGE~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;

.include "m328pdef.inc"

call test_values ;initializes test values

start:
	lds r1,$0100 ;load from memory location: 0x0100
	lds r2,$0101 ;load from memory location: 0x0101
	lds r3,$0102 ;load from memory location: 0x0102
	lds r4,$0103 ;load from memory location: 0x0103
	call question1

question1: ;finding the max of the four numbers and store the result in 0x0105
	cp r0, r1
	brlo r1_current_max ;if r0 is less than r1, then r1 is new max

	cp r0, r2
	brlo r2_current_max ;if r0 is less than r2, then r2 is new max

	cp r0, r3
	brlo r3_current_max ;if r0 is less than r3, then r3 is new max

	cp r0, r4
	brlo r4_current_max ;if r0 is less than r4, then r4 is new max

	sts 0x0105, r0 ;r0 is now max, store in 0x0105
	clr r0 ;clear r0
	call question2

question2: ;find first even number and store in 0x0106
	ldi r16, 1 ;priming r16 for comparisons

	and r16, r1 ;If r1 is even, "and"ing 1 and an even number will give us 0, else r16 will remain as 1
	cp r16, r0 ;compare the value of r16 with that of r0, which is currently zero. Otherwise, r16 will remain as 1, primed for the next comparison.
	breq r1_is_even ;If r16 == r0, then that means that r1 is an even number, so call the function to set 0x0106 to r1's value.

	and r16, r2 ;If r2 is even, "and"ing 1 and an even number will give us 0, else r16 will remain as 1
	cp r16, r0 ;compare the value of r16 with that of r0, which is currently zero. Otherwise, r16 will remain as 1, primed for the next comparison.
	breq r2_is_even ;If r16 == r0, then that means that r2 is an even number, so call the function to set 0x0106 to r2's value.

	and r16, r3 ;If r3 is even, "and"ing 1 and an even number will give us 0, else r16 will remain as 1
	cp r16, r0 ;compare the value of r16 with that of r0, which is currently zero. Otherwise, r16 will remain as 1, primed for the next comparison.
	breq r3_is_even ;If r16 == r0, then that means that r3 is an even number, so call the function to set 0x0106 to r3's value.

	and r16, r4 ;If r4 is even, "and"ing 1 and an even number will give us 0, else r16 will remain as 1
	cp r16, r0 ;compare the value of r16 with that of r0, which is currently zero. Otherwise, r16 will remain as 1, primed for the next comparison.
	breq r4_is_even ;If r16 == r0, then that means that r4 is an even number, so call the function to set 0x0106 to r4's value.

	call question3 ;else, just leave 0x0106 as 0, because none of the numbers are even.

question3: ;find the sum of the four numbers, store in 0x0107
	mov r16, r1 ;move r1's value to r16
	add r16, r2 ;r1 + r2
	mov r17, r3 ;move r3's value to r17
	add r17, r4 ;r3 + r4
	mov r0, r16 ;move r1 + r2 into r0
	add r0, r17 ;(r1 + r2) + (r3 + r4)
	sts 0x0107, r0 ;store the sum, which is in r0, in 0x0107, as requested
	clr r16 ;clear r16
	clr r17 ;clear r17
	call question4 ; Move on to question 4

question4: ;find the average of the four numbers, store in 0x0108
	asr r0 ;bitshift right, equivalent to dividing by 2
	asr r0 ;bitshift right, equivalent to dividing by 2
	sts 0x0108, r0 ;store the average of the four numbers,
				   ;which is the sum of the numbers (in r0) 
				   ;divided by the number of numbers (4),
				   ;and store it in 0x0108
	clr r0 ;clear r0
	call question5 ; Move on to question 5

question5: ;store elements in reverse order
	sts 0x0110, r4 ;fourth
	sts 0x0111, r3 ;third
	sts 0x0112, r2 ;second
	sts 0x0113, r1 ;first

call exit ;We have finished all operations, go to the function that exits the program.

;~~~~~~~~~~~~~~~~~~~~~~
;question 1 helpers

r1_current_max: ;set r1 as max if r1 > r0
	mov r0, r1 ;r0 is replaced by r1
	call question1 ;return to question 1
	
r2_current_max: ;set r2 as max if r2 > r0
	mov r0, r2 ;r0 is replaced by r1
	call question1 ;return to question 1

r3_current_max: ;set r3 as max if r3 > r0
	mov r0, r3 ;r0 is replaced by r1
	call question1 ;return to question 1

r4_current_max: ;set r4 as max if r4 > r0
	mov r0, r4 ;r0 is replaced by r4
	call question1 ;return to question 1

;end question 1 helpers
;~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~
;question 2 helpers

r1_is_even:
	sts 0x0106, r1
	clr r16
	clr r0
	call question3

r2_is_even:
	sts 0x0106, r2
	clr r16
	clr r0
	call question3

r3_is_even:
	sts 0x0106, r3
	clr r16
	clr r0
	call question3

r4_is_even:
	sts 0x0106, r4
	clr r16
	clr r0
	call question3

;end question 2 helpers
;~~~~~~~~~~~~~~~~~~~~~~

;~~~~~~~~~~~~~~~~~~~~~~
;test values, set from assignment document. 0x0100 = 10, 0x0101 = 13, 0x0102 = 23, 0x0103 = 26
;or rather the list {10, 13, 23, 26}
test_values:
	ldi r16,10
	ldi r17,13
	ldi r18,23
	ldi r19,26
	sts 0x0100, r16
	sts 0x0101, r17
	sts 0x0102, r18
	sts 0x0103, r19
	clr r16
	clr r17
	clr r18
	clr r19
	call start ;Move back to the start of the program

;end test values
;~~~~~~~~~~~~~~~~~~~~~~


exit: 
	break ;we're done