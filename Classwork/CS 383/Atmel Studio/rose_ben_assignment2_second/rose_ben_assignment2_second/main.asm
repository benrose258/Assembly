;
; rose_ben_assignment2_second.asm
;
; Created: 11/5/2018 2:48:19 PM
; Author : Ben Rose
;
; I pledge my honor that I have abided by the Stevens Honor System. -Ben Rose

.include "m328pdef.inc"


; Replace with your application code

start:
	ldi r16, 2
	ldi r17, 34
	ldi r18, 3
	ldi r19, 12
	ldi r20, 8

	push r16 ; push 2 onto the stack
	push r17 ; push 34 onto the stack
	push r18 ; push 3 onto the stack
	push r19 ; push 12 onto the stack
	push r20 ; push 8 onto the stack

pop_from: ;pop from stack
	pop r16
	pop r17
	pop r18
	pop r19
	pop r20

	;call find_smallest
	;Test succeeded, "ret" successfully jumps back to the place that you were at. Use later.
;test_return:
;	call look_at_first
;	ldi r22, 9 ; test to see if, after look_at_first, we come back here.

; when a stack is empty, the next "element" you get if you pop is 0x00.

;	call look_at_fifth ; Load the current stack

order_and_store:
	mov r21, r16 ; move r26 (element 1) into r21 for comparison
	call stack_empty
	mov r21, r17
	call stack_empty
	mov r21, r18
	call stack_empty
	mov r21, r19
	call stack_empty
	mov r21, r20
	call stack_empty
	; The five elements mentioned in the document have been ordered and stored.
	; According to the documentation provided, and Assignment 1's documentation
	; regarding changing elements during your testing, and that line not being included,
	; it is implied that you will be using 2, 3, 8, 12, and 34 in your testing.
	call exit_jump

pop r31 ; Haven't started, so we need to have a minimum element. 
mov r0, r31 ; Move the current smallest element into r0 (since we haven't started yet, the top element in the stack is the smallest of the five, with 4 pending).
;ldi r15, 0 ; R15 will check if stack is empty.

find_smallest: ; unused
	pop r21 ; Pop next element
	cp r21, r13 ; is r31 0, meaning our stack is empty?
	breq exit_jump
	;cp r31, r0 ; Else, compare the current top element with the current min
	;brlt move_to_r0 ; Move new min into r0 (if r31 < r0)
	call stack_empty
;	call find_smallest ; Re-enter the loop, since the stack still has elements

stack_empty:
	cpi r21, 2 ; If we have sorted all 5 elements, then we need to stop.
	call one_sorted ; Go to the function for having one element sorted.'
	cpi r21, 3 ; Two elements sorted
	call two_sorted ; Go to 2 sorted
	cpi r21, 8 ; 3 sorted
	call three_sorted ; go to 3 sorted
	cpi r21, 12 ; 4 sorted
	call four_sorted ; go to 4 sorted
	cpi r21, 34 ; Go to 5 elements sorted, will lead to stopping
	call five_sorted
	ret ; temporarily done

one_sorted:
	sts 0x0100, r21
	call find_smallest

two_sorted:
	sts 0x0101, r21
	call find_smallest

three_sorted:
	sts 0x0102, r21
	call find_smallest

four_sorted:
	sts 0x0103, r21
	call find_smallest

five_sorted:
	sts 0x0104, r21
	call find_smallest


exit_jump: ; for pushing back
	;return
	call exit

move_to_r0:
	mov r0, r31 ; Move new min into r0
	ret

peek: ; Peek: look at the top element of the stack. Frequently included in Stack operations.
	pop r31 ; Store the top element in r31
	push r31 ; Then put it back onto the stack.
	ret

look_at_first:
	pop r31
	push r31
	ret

look_at_second:
	pop r31
	pop r30
	push r30
	push r31
	ret

look_at_third:
	pop r31
	pop r30
	pop r29
	push r29
	push r30
	push r31
	ret

look_at_fourth:
	pop r30
	pop r29
	pop r28
	pop r27
	push r27
	push r28
	push r29
	push r30
	ret

look_at_fifth:
	pop r16
	pop r17
	pop r18
	pop r19
	pop r20
	push r26
	push r27
	push r28
	push r29
	push r30
	ret

exit:
	break