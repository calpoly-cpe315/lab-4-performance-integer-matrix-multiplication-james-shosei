.arch armv8-a
.text
.globl mymul
mymul: 
  stp    x29, x30, [sp, -64]!
  stp    x19, x20, [sp, 16]
  stp    x21, x22, [sp, 48]
	mov    x19, x1   //x19 holds our iterative counter (i.e. the second operand)
  mov    x20, x0   //x20 holds the number be repeteadly added
  mov    x21, #0   //x21 keeps track of the total
  mov    x22, #0   //x22 holds whether return val should be neg

  cmp x19, 0
  B.lt negative
start_loop:
  cmp	   x19, #0
	b.eq	 end_loop
	
  mov    x0, x21     //The total + first operand is for our add subroutine
	mov    x1, x20 		//Add onto itself
	bl	   myadd //Run addition
  mov    x21, x0     //Update the total
  mov    x0, x19     //Load the counter to be subtracted
  mov    x1, -1
  bl     myadd //Subtract 1 from counter
  mov    x19, x0     //Update the new counter value
	b	     start_loop
	
end_loop: 
  mov    x0, x21
  cmp    x22, #1
  B.eq   neg_val
  ldp    x19, x20, [sp, 16]
  ldp    x21, x22, [sp, 48]
  ldp    x29, x30, [sp], 64
  ret

neg_val:
  eor x1, x0, 0xFFFFFFFF
  mov x0, #1
  bl myadd
  ldp    x19, x20, [sp, 16]
  ldp    x21, x22, [sp, 48]
  ldp    x29, x30, [sp], 64
  ret

negative:
  mov x0, #-1
  mov x1, x19
  bl myadd
  eor x0, x0, 0xFFFFFFFF
  mov x19, x0   //The iterator is now postive
  cmp x20, 0
  B.lt both_negative
  mov x0, #1
  mov x1, x22
  bl myadd
  mov x22, x0   //The neg flag is now set
  b   start_loop


both_negative:
  mov x0, #-1
  mov x1, x20
  bl myadd
  eor x0, x0, 0xFFFFFFFF
  mov x20, x0   //The multplier is now postive
  b start_loop
