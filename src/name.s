		.data
msg1:   .asciz  "*****Print Name*****\n"
msg2:   .asciz  "*****End Print*****\n"
team:   .asciz  "Team 05\n"
name1:  .asciz  "Kao, Hung Chun\n"
name2:  .asciz  "Liao, Yi Wei\n"
name3:  .asciz  "Liao, Yi Wei\n"

        .text
        .global name	    @ Function name
		.global name1	
		.global name2
		.global name3

name:   stmfd   sp!, {lr}
@-----------------------------------------------------------------------
        ldr     r0, =msg1		@ r0 = "*****Print Name*****\n"
        bl      printf
        ldr     r0, =team		@ r0 = "Team 05\n"
        bl      printf
        ldr     r0, =name1		@ r0 = "Kao, Hung Chun\n"
        bl      printf
        ldr     r0, =name2		@ r0 = "Liao, Yi Wei\n"
        bl      printf
        ldr     r0, =name3		@ r0 = "Liao, Yi Wei\n"
        bl      printf
        ldr     r0, =msg2		@ r0 = "*****End Print*****\n"
        bl      printf
@-----------------------------------------------------------------------
        ldmfd   sp!, {lr}
        mov     pc, lr
