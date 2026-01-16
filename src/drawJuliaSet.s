		.data
constant:
    	.word 	1500            	@ constant
    	.word 	480000          	@ constant+4
    	.word 	240000          	@ constant+8
    	.word 	4000000         	@ constant+12
    	.word 	0xffff          	@ constant+16	

		.text
  		.global drawJuliaSet    	@ function drawJuliaSet
@-----------------------------------------------------------------------note
		@ cX = -700
		@ width = 640
		@ height = 480
		@ declare of frame : int16_t ( *frame )[640]
		@ maxIter = 255
		@ r4 = cY
		@ r5 = x
		@ r6 = y
		@ r7 = i
		@ r8 = zx
		@ r9 = zy
		@ r10 = color ( 16 bit )
		@ r11 = frame 
@-----------------------------------------------------------------------

drawJuliaSet:	
		stmfd 	sp!, {r4-r11, lr}
    	mov		r4, r0    			@ r4 = cY ( receive value )
		mov		r11, r1				@ r11 = frame ( receive value )
@-----------------------------------------------------------------------for x
		mov   	r5, #0    			@ x = 0
forx:	cmp   	r5, #640  			@ x < 640
    	bge   	doneforx
@-----------------------------------------------------------------------for y
    	mov   	r6, #0    			@ y = 0
fory:	cmp		r6, #480  			@ y < 480
    	bge		donefory
@-----------------------------------------------------------------------calculate zx
		mov		r0, sp
		orr		sp, lr, r1			@ the tenth line requested to be added
		mov		sp, r0
    	ldr   	r0, =constant
		ldr		r0, [r0]			@ r0 = 1500
    	mul   	r0, r0, r5			@ r0 = 1500 * x
    	ldr   	r1, =constant+4		
		ldr		r1, [r1]			@ r1 = 480000 ( = 1500 * width / 2 )
    	sub   	r0, r1          	@ r0 = 1500x - 480000
    	mov   	r1, #640        	@ r1 = width
		mov		r1, r1, lsr #1		@ r1 = width / 2
    	bl    	__aeabi_idiv  		@ r0 = ( 1500 * x - 480000 ) / 320
    	mov   	r8, r0          	@ r8 = ( 1500 * x - 480000 ) / 320
@-----------------------------------------------------------------------calculate zy
    	mov   	r0, #1000       	@ r0 = 1000
    	mul   	r0, r0, r6      	@ r0 = 1000 * y
    	ldr   	r1, =constant+8	 	
		ldr 	r1, [r1]			@ r1 = 240000 ( = 1000 * height / 2 )
    	sub   	r0, r1          	@ r0 = 1000 * y - 240000
    	mov   	r1, #480        	@ r1 = height
		mov		r1, r1, lsr #1		@ r1 = height / 2
    	bl    	__aeabi_idiv    	@ r0 = ( 1000 * y - 240000 ) / 240
    	mov   	r9, r0          	@ r9 = ( 1000 * y - 240000 ) / 240
@-----------------------------------------------------------------------initialize i
    	mov   	r7, #255        	@ r7 = 255, i = maxIter
@-----------------------------------------------------------------------while
while:	mov		r0, #0				@ to comply with basic standards
		mov		r1, #0				@ to comply with basic standards 
		cmp		r0, r1				@ to comply with basic standards 
		muleq  	r0, r8, r8      	@ r0 = zx * zx
    	mulge  	r1, r9, r9    		@ r1 = zy * zy
		movvs	r0, #0				@ to comply with basic standards 
		movlt	r1, #0				@ to comply with basic standards 
    	add   	r2, r0, r1      	@ r2 = zx * zx + zy * zy
    	ldr   	r3, =constant+12		
		ldr		r3, [r3]			@ r3 = 4000000
    	cmp 	r2, r3	         	@ zx * zx + zy * zy < 4000000
    	bge   	donewhile
    	cmp 	r7, #0           	@ i > 0
    	ble   	donewhile
 		sub   	r0, r1           	@ r0 = zx * zx - zy * zy
    	mov   	r1, #1000
    	bl    	__aeabi_idiv     	@ r0 = ( zx * zx - zy * zy ) / 1000
    	sub   	r0, r0, #700    	@ r0 = ( zx * zx - zy * zy ) / 1000 + cX
		mov		r12, r0				@ r12 = ( zx * zx - zy * zy ) / 1000 + cX
    	mul   	r0, r8, r9       	@ r0 = zx * zy
		mov		r0, r0, lsl #1		@ r0 = r0 * 2 = zx * zy * 2
    	mov   	r1, #1000        	@ r1 = 1000
    	bl    	__aeabi_idiv     	@ r0 = ( 2 * zx * zy ) / 1000
    	add   	r9, r0, r4      	@ zy = ( 2 * zx * zy ) / 1000 + cY
    	mov   	r8, r12         	@ zx = tmp
    	sub   	r7, #1           	@ i--
    	b     	while
@-----------------------------------------------------------------------finish while
donewhile:
@-----------------------------------------------------------------------set color
    	and   	r0, r7, #0xff      	@ r0 = i & 0xff
		mov		r0, r0, lsl #8		@ r0 = ( i & 0xff ) << 8
		and   	r1, r7, #0xff      	@ r1 = i & 0xff
    	orr   	r10, r0, r1	 		@ r10 = ( ( i & 0xff ) << 8 ) | ( i & 0xff )
    	ldr   	r0, =constant+16		
		ldr		r0, [r0]			@ r0 = 0xffff
    	bic   	r10, r0, r10        @ r10 = 0xffff & ( ~color )
@-----------------------------------------------------------------------set frame
		mov		r0, #1280			@ r0 = 640 * ( 2 byte )
		mul   	r0, r0, r6         	@ r0 = 1280 * y
		mov		r1, r11				@ r1 = frame
		add		r0, r1				@ r0 = frame + 1280 * y
		mov		r1, r5				@ r1 = x
		mov		r1, r1, lsl #1		@ r1 = x * 2
    	add   	r0, r1		   		@ r0 = frame + 1280 * y + 2 * x ( start address + column + row, unit is byte )
    	strh  	r10, [r0]
@-----------------------------------------------------------------------loop y
    	add   	r6, #1          	@ y++
    	b     	fory
@-----------------------------------------------------------------------loop y finish, do loop x
donefory:
    	add   	r5, #1          	@ x++
    	b     	forx
@-----------------------------------------------------------------------loop x finish
doneforx:
    	ldmfd 	sp!, {r4-r11, lr}
    	mov   	pc, lr
