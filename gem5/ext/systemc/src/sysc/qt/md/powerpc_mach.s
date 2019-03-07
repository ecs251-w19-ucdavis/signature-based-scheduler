/* powerpc_mach.s -- assembly support. */

/*
 * QuickThreads -- Threads-building toolkit.
 * Copyright (c) 1993 by David Keppel
 *
 * Permission to use, copy, modify and distribute this software and
 * its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice and this notice
 * appear in all copies.  This software is provided as a
 * proof-of-concept and for demonstration purposes; there is no
 * representation about the suitability of this software for any
 * purpose.


 * PowerPC-Mach thread switching module.
 * Darwin (MacOS X) assembly
 *
 * NOTICE: Syntax for register names is not the GNU one. Register are
 * named "rx" and "fx", not "%rx" and "%fx" as usual for the GNU "as" tool.
 * Darwin "as" tool is based on GNU "as" but follows the "official" PowerPC
 * syntax.
 *
 *
 * This software is largely based on the original PowerPC-Linux porting
 * developed by Ken Aaker <kenaaker@silverbacksystems.com>
 *
 * Marco Bucci <marco.bucci@inwind.it>
 * December 2002
 *
 */


/*
 *
 * PowerPC Register convections:
 *
 *  r0			volatile
 *  r1			SP
 *  r2			system reserved
 *  r3-r4		volatile for parameter passing and function return
 *  r5-r10		volatile for parameter passing
 *  r11-r12		volatile
 *  r13-r14		non volatile registers
 *  f0			volatile
 *  f1			volatile for parameter passing and function return
 *  f2-f13		volatile for parameter passing
 *  f14-f31		non volatile
 *
 *  cr2-cr4		non volatile
 *
 *
 * See on the heather file for more documentation.
 *
 *
 *
 * IMPLEMENTATION NOTES
 *
 *
 * 1) Condition register saving
 * On most machines, the condition code register is caller-save.
 * On the PPC, the condition code register is callee-save, so the
 * thread context switch must preserve it.
 *
 *
 * 2) Floating point registers saving
 * On resuming a thread, floating point registers are or not restored just
 * depending on which block routine suspended the thread (i.e. regardless
 * whether "qt_block", "qt_blocki" or "qt_abort" is used to resume it).
 * This behaviour is obtained by implementing "qt_block" by means af a nested
 * call to "qt_blocki". As a result, the blocking of a thread always goes
 * and returns through "qt_blocki and, if a thread was blocked by "qt_block",
 * its execution resumes from the floating point restoring code on exit
 * of "qt_block".
 *
 * Thanks to David Keppel that explained me this "simple" trick.
 *
 *
 * 3) C languace code debugging
 * This software was developed and debugged using the Metrowerks
 * Code Warrior PPC integrated assembler. It can be still used with the
 * Code Warrior compiler by means of the file "powerpc_mach_asm_debug.c"
 * that include it.
 * In order to avoid "copy and paste" bugs, and make easyer the maintaining,
 * I made the minimal changes, so you can find some strange code as:
 *
 *   #if 0
 *   .if 0
 *      C code here
 *   .endif
 *   #endif
 *
 * This is just to embed some C code that is needed by the Code Warrior
 * integrated assembler.
 *
 *
 * 4) Assembly constants generation
 * Constants used in the assembly code are generated by running
 * the C code in the sequel (commented). It uses the C macros declared in
 * the C heather in order to guarantee that the C interface and the assebly
 * code are "aligned". I avoided the use of an assebler preprocessor since
 * they are not so standard and moreover using macro espressions makes the
 * assembly debugging more difficult.
 *
 *


#include <iostream>
#include "powerpc_mach.h"

int main()
{
	using namespace std;

	int i;

	cout << ".set LR_SAVE, " << PPC_LR_SAVE << endl;
	cout << ".set CR_SAVE, " << PPC_CR_SAVE << endl;
	cout << ".set BLOCKI_FSIZE, " << QUICKTHREADS_BLOCKI_FRAME_SIZE << endl;
	cout << ".set BLOCK_FSIZE, " << QUICKTHREADS_BLOCK_FRAME_SIZE << endl;

	cout << endl;
	for(i=0; i<12; i++)
		cout << ".set PAR_" << i << ", " << PPC_PAR(i) << endl;

	cout << endl;
	i = 13;
	cout << ".set GPR_SAVE_" << i << ", " << QUICKTHREADS_BLOCKI_GPR_SAVE(i) << endl;

	cout << endl;
	for(i=31; i>13; i--)
		cout << ".set FPR_SAVE_" << i << ", " << QUICKTHREADS_BLOCK_FPR_SAVE(i) << endl;

	cout << endl;
	cout << ".set VARGS_BKOFF, " << QUICKTHREADS_VARGS_BKOFF << endl;


	cout << endl << endl << endl;

	for(i=31; i>13; i--)
		cout << "\tstfd\tf" << i << ",FPR_SAVE_" << i << "(r1)" << endl;

	cout << endl;
	for(i=31; i>13; i--)
		cout << "\tlfd \tf" << i << ",FPR_SAVE_" << i << "(r1)" << endl;

	cout << endl << endl << endl;


	return 0;
}


 *
 *
 *
 */


#if 0

	.text
	.align 4

	.globl qt_block
	.globl _qt_block
	.globl qt_blocki
	.globl _qt_blocki
	.globl qt_abort
	.globl _qt_abort
	.globl qt_start
	.globl _qt_start
	.globl qt_vstart
	.globl _qt_vstart


.set LR_SAVE, 8
.set CR_SAVE, 4
.set BLOCKI_FSIZE, 128
.set BLOCK_FSIZE, 192

.set PAR_0, 24
.set PAR_1, 28
.set PAR_2, 32
.set PAR_3, 36
.set PAR_4, 40
.set PAR_5, 44
.set PAR_6, 48
.set PAR_7, 52
.set PAR_8, 56
.set PAR_9, 60
.set PAR_10, 64
.set PAR_11, 68

.set GPR_SAVE_13, 52

.set FPR_SAVE_31, 184
.set FPR_SAVE_30, 176
.set FPR_SAVE_29, 168
.set FPR_SAVE_28, 160
.set FPR_SAVE_27, 152
.set FPR_SAVE_26, 144
.set FPR_SAVE_25, 136
.set FPR_SAVE_24, 128
.set FPR_SAVE_23, 120
.set FPR_SAVE_22, 112
.set FPR_SAVE_21, 104
.set FPR_SAVE_20, 96
.set FPR_SAVE_19, 88
.set FPR_SAVE_18, 80
.set FPR_SAVE_17, 72
.set FPR_SAVE_16, 64
.set FPR_SAVE_15, 56
.set FPR_SAVE_14, 48


/* various offsets used by "qt_varg" */
.set P_T, PAR_0
.set P_STARTUP, PAR_1
.set P_USERF, PAR_2
.set P_CLEANUP, PAR_3
		/* the offset used to move back the linkage area to be adiacent to
		 * the variant argument list  before  calling "userf(...) */
.set VARGS_BKOFF, 16		/* skip "t", "startup", "userf" and "cleanup" */

		/* location where "t" and "cleanup" are saved (with respect of
		 * the stack frame base) */
.set P_T_SAVE, -4
.set P_CLEANUP_SAVE, -8

#endif



/* Block the current thread saving all integer non volatile registers and
 * start a new thread.
 */
#if 0
.if 0
#endif
void *qt_blocki (void *helper, void *a0, void *a1, void *newthread);
asm void *qt_blocki (void *helper, void *a0, void *a1, void *newthread)
{
#if 0
.endif
#endif

#if 0
qt_blocki:
_qt_blocki:
#endif
/* prolog code */
	stwu	r1,-BLOCKI_FSIZE(r1)		/* allocate the stack frame */
	mflr	r0							/* return addr in r0 */
	mfcr	r11							/* CR in r11 */
	stw		r0,LR_SAVE+BLOCKI_FSIZE(r1)	/* save return addr in the stack */
	stw		r11,CR_SAVE+BLOCKI_FSIZE(r1)	/* save CR in the stack */
	stmw	r13,GPR_SAVE_13(r1)	 		/* save non-volatile reg */

/* call helper(qt_t *old, void *a0, void *a1) */
	mtlr	r3				/* "helper" addr in the link reg */
	mr		r3,r1			/* current thread (i.e. the SP) in arg "old" */
	mr		r1,r6         	/* swap to the new thread (i.e. to its SP) */
	blrl								/* jump to "helper" */
/* the "helper" return value is returned (since r3 is not changed) */

/* epilog code: return to the new thread's "qt_blocki" caller */
	lmw     r13,GPR_SAVE_13(r1)			/* restore non-volatile reg */
	lwz		r0,LR_SAVE+BLOCKI_FSIZE(r1)	/* recover return addr */
	lwz		r11,CR_SAVE+BLOCKI_FSIZE(r1)	/* recover CR */
	mtlr	r0							/* return address in the link reg */
	mtcr	r11							/* restore CR */
	addi    r1,r1,BLOCKI_FSIZE			/* free the stack frame */
	blr									/* return */

#if 0
.if 0
#endif
}
#if 0
.endif
#endif



/* Abort the current thread and start a new thread.
 */
#if 0
.if 0
#endif
void qt_abort (void *helper, void *a0, void *a1, void *newthread);
asm void qt_abort (void *helper, void *a0, void *a1, void *newthread)
{
#if 0
.endif
#endif

#if 0
qt_abort:
_qt_abort:
#endif
/* prolog code */
/* there is no prolog. It will never come back */

/* call helper(qt_t *old, void *a0, void *a1) */
	mtlr	r3					/* "helper" addr in the link reg */
	mr		r1,r6         		/* swap to the new thread (i.e. to its SP) */
/* we don't need to set "old", we can pass just garbage. Actually, since r3
 is not changed, "old" is set to "helper" (don't care) */
	blrl								/* call "helper" */
/* the "helper" return value is returned (since r3 is not changed) */

/* epilog code: return to the new thread's "qt_blocki" caller */
	lmw     r13,GPR_SAVE_13(r1)			/* restore non-volatile reg */
	lwz		r0,LR_SAVE+BLOCKI_FSIZE(r1)	/* recover return addr */
	lwz		r11,CR_SAVE+BLOCKI_FSIZE(r1)	/* recover CR */
	mtlr	r0							/* return address in the link reg */
	mtcr	r11							/* restore CR */
	addi    r1,r1,BLOCKI_FSIZE			/* free the stack frame */
	blr									/* return */

#if 0
.if 0
#endif
}
#if 0
.endif
#endif



/* Block the current thread saving all non volatile registers and start
 * a new thread.
 */
#if 0
.if 0
#endif
void *qt_block (void *helper, void *a0, void *a1, void *newthread);
asm void *qt_block (void *helper, void *a0, void *a1, void *newthread)
{
#if 0
.endif
#endif

# if 0
qt_block:
_qt_block:
#endif
/* prolog code */
	stwu	r1,-BLOCK_FSIZE(r1)			/* allocate the stack frame */
	mflr	r0							/* return addr in r0 */
	stw		r0,LR_SAVE+BLOCK_FSIZE(r1)	/* save return addr in the stack */

/* save non-volatile fp reg */
    stfd    f31,FPR_SAVE_31(r1)
    stfd    f30,FPR_SAVE_30(r1)
    stfd    f29,FPR_SAVE_29(r1)
    stfd    f28,FPR_SAVE_28(r1)
    stfd    f27,FPR_SAVE_27(r1)
    stfd    f26,FPR_SAVE_26(r1)
    stfd    f25,FPR_SAVE_25(r1)
    stfd    f24,FPR_SAVE_24(r1)
    stfd    f23,FPR_SAVE_23(r1)
    stfd    f22,FPR_SAVE_22(r1)
    stfd    f21,FPR_SAVE_21(r1)
    stfd    f20,FPR_SAVE_20(r1)
    stfd    f19,FPR_SAVE_19(r1)
    stfd    f18,FPR_SAVE_18(r1)
    stfd    f17,FPR_SAVE_17(r1)
    stfd    f16,FPR_SAVE_16(r1)
    stfd    f15,FPR_SAVE_15(r1)
    stfd    f14,FPR_SAVE_14(r1)
/* block the thread */
	bl		qt_blocki
/* the thread is going to be resumed */
/* restore non-volatile fp reg */
    lfd     f31,FPR_SAVE_31(r1)
    lfd     f30,FPR_SAVE_30(r1)
    lfd     f29,FPR_SAVE_29(r1)
    lfd     f28,FPR_SAVE_28(r1)
    lfd     f27,FPR_SAVE_27(r1)
    lfd     f26,FPR_SAVE_26(r1)
    lfd     f25,FPR_SAVE_25(r1)
    lfd     f24,FPR_SAVE_24(r1)
    lfd     f23,FPR_SAVE_23(r1)
    lfd     f22,FPR_SAVE_22(r1)
    lfd     f21,FPR_SAVE_21(r1)
    lfd     f20,FPR_SAVE_20(r1)
    lfd     f19,FPR_SAVE_19(r1)
    lfd     f18,FPR_SAVE_18(r1)
    lfd     f17,FPR_SAVE_17(r1)
    lfd     f16,FPR_SAVE_16(r1)
    lfd     f15,FPR_SAVE_15(r1)
    lfd     f14,FPR_SAVE_14(r1)

	lwz		r0,LR_SAVE+BLOCK_FSIZE(r1)	/* recover return addr */
	mtlr	r0							/* return address in the link reg */
	addi    r1,r1,BLOCK_FSIZE			/* free the stack frame */
	blr									/* return */

#if 0
.if 0
#endif
}
#if 0
.endif
#endif



/* Start a single argument thread using parameters preloaded in the stack
 * during thread initialization (see comments on stack initialization in the
 * heather file).
 *
 * Executes:
 *
 *    only(u, t, userf);
 */
#if 0
.if 0
#endif
void qt_start(void);
asm void qt_start(void)
{
#if 0
.endif
#endif

#if 0
qt_start:
_qt_start:
#endif
        lwz     r3,PAR_0(r1)	     	/* "u" in r3 */
        lwz     r4,PAR_1(r1)	     	/* "t" in r4 */
        lwz     r5,PAR_2(r1)	     	/* "userf" in r5 */
        lwz     r6,PAR_3(r1)	     	/* "only" in r6 */
        mtlr    r6						/* "only" address in the link reg */
/*  call only(u, t, userf) */
        blrl                    		/* jump to "only" */
/* error if it returns */
        b       _qt_error
/* dead code (some inline asm "wants" the epilog, or they genetare it) */
        blr

#if 0
.if 0
#endif
}
#if 0
.endif
#endif



/* Start a variant argument thread using parameters preloaded in the stack
 * during thread initialization (see comments on stack initialization in the
 * heather file).
 *
 * Executes:
 *
 *    startup(t);
 *    userf_return = userf(...);
 *    cleanup(pt, userf_return);
 *


 ***** Stack layout on start *****


 backchain ->           STACK BOTTOM (higher address)
                        +==========================+
 backchain - 4 ->       |                          |
                        +   LOCAL VARIABLES AREA   +
                               ..............
                        +                          +
                        |                          |
                        +--------------------------+
                        |                          |
                        +      ALIGNMEBNT PAD      +
                               ..............
                        +       (if needed)        +
                        |                          |
                        +--------------------------+
                        |                          | arg(n)
                        +                          +
                        |                          |
                        +  VARIABLE ARGUMENT LIST  +
                               ..............
                        +      for userf call      +
 SP + PAR(5) ->         |                          | arg(1)
                        +                          +
 SP + PAR(4) ->         |                          | arg(0)
                        +--------------------------+
 SP + PAR(3) ->         |                          | cleanup par
                        +                          +
 SP + PAR(2) ->         |                          | userf par
                        +      PARAMETER AREA      +
 SP + PAR(1) ->         |                          | startup par
                        +                          +
 SP + PAR(0) ->         |                          | t par
                        +--------------------------+
                        |                          |
                        +       LINKAGE AREA       +
 SP ->                  |                          |
                        +==========================+
                         STACK TOP (lower address)

                             Stack grows down
                                     |
                                     V



 ***** Stack layout before call userf *****


 backchain ->           STACK BOTTOM (higher address)
                        +==========================+
 backchain - 4 ->       |                          |
                        +   LOCAL VARIABLES AREA   +
                               ..............
                        +                          +
                        |                          |
                        +--------------------------+
                        |                          |
                        +      ALIGNMEBNT PAD      +
                               ..............
                        +       (if needed)        +
                        |                          |
                        +--------------------------+
                        |                          | arg(n)
                        +                          +
                        |                          |
                        +  VARIABLE ARGUMENT LIST  +
                               ..............
                        +      for userf call      +
 SP + PAR(1) ->         |                          | arg(1)
                        +                          +
 SP + PAR(0) ->         |                          | arg(0)
                        +--------------------------+
                        |                          |
                        +       LINKAGE AREA       +
 SP ->                  |                          |
                        +==========================+
                         STACK TOP (lower address)

                             Stack grows down
                                     |
                                     V


 * To call "userf(...)", the argument list must be adiacent to the linkage
 * area. Instead of copy the argument list, we move back the linkage area
 * (actually, we just increase the SP and copy the backchain). "t" and
 * "cleanup" are saved in a local variable area in order to call
 * cleanup(pt, userf_return).

*/


#if 0
.if 0
#endif
void qt_vstart(void);
asm void qt_vstart(void)
{
#if 0
.endif
#endif

#if 0
qt_vstart:
_qt_vstart:
#endif
/* NOTICE: the callee routines could save parameter registers in the caller's
 * stack parameter area. We put "t" in PAR(0) in such a way, if startup(t)
 * will save "t", it will be saved on the same location thus not delething
 * any other parameter.
 */

/* since we will move back the linckage area (to make it adiacent to the
 * parameter list), we need to save "t" and "cleanup". We have made room for
 * this on the bottom of the stack frame. */

/* save parameters in the local variable area */
	lwz		r11,0(r1)				/* get the backchain */
	lwz     r3,P_T(r1)
	lwz     r4,P_CLEANUP(r1)
	stw		r3,P_T_SAVE(r11)		/* save "pt" */
	stw		r4,P_CLEANUP_SAVE(r11)	/* save "cleanup" */

/* call startup(t) */
    lwz     r5,P_STARTUP(r1)
	mtlr    r5
    blrl                    		/* call "startup" */

/* call userf(...) */
	lwz		r11,0(r1)				/* reload backchain (r11 is volatile) */
	lwz		r4,P_USERF(r1)			/* load "userf"  */
    mtlr    r4

	/* first eight parameter of the variant list must be copyed in
	 * GPR3-GPR10. There is a four places offset due to "t", "startup",
	 * userf" and "cleanup" */

	lwz		r3,PAR_4(r1)
	lwz		r4,PAR_5(r1)
	lwz		r5,PAR_6(r1)
	lwz		r6,PAR_7(r1)
	lwz		r7,PAR_8(r1)
	lwz		r8,PAR_9(r1)
	lwz		r9,PAR_10(r1)
	lwz		r10,PAR_11(r1)


	/* move the linkage area to be adiacent to the argument list */
	stw		r11,VARGS_BKOFF(r1)		/* copy backchain */
	addi	r1,r1,VARGS_BKOFF			/* move back the stack */

	blrl							/* call "userf" */

/* call qt_cleanup(void *pt, void *vuserf_return) */
	lwz		r11,0(r1)				/* reload backchain (r11 is volatile) */

	mr		r4,r3					/* push "userf" return as 2nd parameter */
	lwz		r3,P_T_SAVE(r11)		/* reload "pt" */
	lwz		r5,P_CLEANUP_SAVE(r11)	/* reload "cleanup" */
	mtlr	r5
	blrl
	b       _qt_error
/* dead code (some inline asm "wanst" the epilog, or they genetare it) */
	blr

#if 0
.if 0
#endif
}
#if 0
.endif
#endif
