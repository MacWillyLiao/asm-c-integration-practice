        .data
msg1:   .asciz "*****Input ID*****\n"
msg2:   .asciz "** Please Enter Member 1 ID: **\n"
msg3:   .asciz "** Please ENTER Member 2 ID: **\n"
msg4:   .asciz "** Please Enter Member 3 ID: **\n"
msg5:   .asciz "** Please Enter Command **\n"
msg6:   .asciz "*****Print Team Member ID and ID Summation*****\n"
msg7:   .asciz "ID Summation = %d\n"
msg8:   .asciz "*****End Print*****\n"
orderp: .asciz "p"
enter:  .asciz "\n"
intn:   .asciz "%d\n"
int:    .asciz "%d"
string: .asciz "%s"

id1:    .word   0		@ initialize the int variable
id2:    .word   0
id3:    .word   0
sum:    .word   0
order:  .space  4		@ allocates 4 byte without initialization

        .text
        .global id		@ function id
        .global id1
        .global id2
        .global id3
        .global sum
        .global order		@ the above five variable allow references of them from other files

id:     stmfd   sp!, {lr}
@-----------------------------------------------------------------------
        ldr     r0, =msg1	@ r0 = "*****Input ID*****\n"
        bl      printf
        ldr     r0, =msg2	@ r0 = "** Please Enter Member 1 ID: **\n"
        bl      printf
        adds    lr, pc, r0	@ the sixth line requested to be added
        ldr     r0, =int	@ r0 = "%d"
        ldr     r1, =id1	@ r1 = int variable
        bl      scanf
        ldr     r0, =msg3	@ r0 = "** Please ENTER Member 2 ID: **\n"
        bl      printf
        ldr     r0, =int
        ldr     r1, =id2
        bl      scanf
        ldr     r0, =msg4	@ r0 = "** Please Enter Member 3 ID: **\n"
        bl      printf
        ldr     r0, =int
        ldr     r1, =id3
        bl      scanf
@-----------------------------------------------------------------------add id1 id2 id3
        mov     r0, #0		@ initialize r0
        mov     r1, #0		@ initialize r1
        cmp     r0, r1		@ will set CPSR flags
        ldr     r0, =id1	@ r0 = address of 1st member's ID
        ldr     r0, [r0]	@ r0 = 1st member's ID
        ldr     r1, =id2
        ldr     r1, [r1]	@ r1 = 2nd member's ID
        addeq   r2, r0, r1	@ r2 is value
        ldr     r0, =id3
        ldr     r0, [r0]	@ r0 = 3rd member's ID
        addge   r2, r2, r0  @ r2 is value
@-----------------------------------------------------------------------operate r2 (sum)
        mov     r2, r2, lsl #1
        mov     r2, r2, lsr #1
        sub     r2, r2, #1
        addvc   r2, r2, #1
        ldrne   r2, [r3, #4]!
        ldrne   r2, [r2, r3]
@-----------------------------------------------------------------------
        ldr     r0, =sum	@ r0 = address of sum
        str     r2, [r0]	@ store r2(id1 + id2 + id3) in r0's value
@-----------------------------------------------------------------------compare r0 r1 (order)
        ldr     r0, =msg5	@ r0 = address of "** Please Enter Command **\n"
        bl      printf
        ldr     r0, =string	@ r0 = "%s"
        ldr     r1, =order	@ r1 = string variable
        bl      scanf
        ldr     r0, =orderp	@ r0 = address of "p"
        ldr     r0, [r0]	@ r0 = "p"
        ldr     r1, =order	@ r1 = address of order
        ldr     r1, [r1]	@ r1 = value of order
        cmp     r0, r1		@ will set CPSR flags
@-----------------------------------------------------------------------
        ldr     r0, =msg6	@ r0 = "*****Print Team Member ID and ID Summation*****\n"
        bl      printf
        ldr     r0, =intn	@ r0 = "%d\n"
        ldr     r1, =id1	@ r1 = address of 1st member's ID
        ldr     r1, [r1]	@ r1 = 1st member's ID
        bl      printf
        ldr     r0, =intn	@ r0 = "%d\n"
        ldr     r1, =id2
        ldr     r1, [r1]
        bl      printf
        ldr     r0, =intn	@ r0 = "%d\n"
        ldr     r1, =id3
        ldr     r1,[r1]
        bl      printf
        ldr     r0, =enter	@ r0 = "\n"
        bl      printf
@-----------------------------------------------------------------------
        ldr     r0, =msg7	@ r0 = "ID Summation = %d\n"
        ldr     r1, =sum	@ r1 = sum of all members' ID
        ldr     r1, [r1]
        bl      printf
        ldr 	r0, =msg8	@ r0 = "*****End Print*****\n"
        bl  	printf
@-----------------------------------------------------------------------
        ldmfd   sp!, {lr}
        mov     pc, lr
