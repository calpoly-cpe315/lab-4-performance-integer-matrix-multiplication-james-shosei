.arch armv8-a
.text

    .global myadd
myadd: 
  //x0 and x1 both hold the numbers to be added
  //Returns in x0
  stp   x29, x30, [sp, -16]!
for:
	cmp	  x1, #0
	b.eq	end_add
	and 	x9, x0, x1
	eor	  x0, x0, x1
	lsl	  x1, x9, #1
	b		  for
	
end_add: 
  ldp   x29, x30, [sp], 16
	ret
  