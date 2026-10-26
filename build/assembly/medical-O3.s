	.file	"medical.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"a"
.LC1:
	.string	"medical.log"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"Warning: unable to open medical.log\n"
	.section	.rodata.str1.1
.LC3:
	.string	"%d-%m-%Y %H:%M:%S"
.LC4:
	.string	"[%s] %s\n"
	.section	.rodata.str1.8
	.align 8
.LC5:
	.string	"Warning: unable to write medical.log\n"
	.align 8
.LC6:
	.string	"Warning: unable to close medical.log\n"
	.text
	.p2align 4
	.type	logEvent, @function
logEvent:
.LFB20:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC0(%rip), %rsi
	movq	%rdi, %r12
	leaq	.LC1(%rip), %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L16
	xorl	%edi, %edi
	movq	%rax, %rbx
	call	time@PLT
	leaq	8(%rsp), %rdi
	movq	%rax, 8(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L17
	leaq	16(%rsp), %rbp
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbp, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	je	.L18
.L5:
	xorl	%eax, %eax
	movq	%r12, %r8
	movq	%rbp, %rcx
	movl	$2, %esi
	leaq	.LC4(%rip), %rdx
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	testl	%eax, %eax
	js	.L19
.L7:
	movq	%rbx, %rdi
	call	fclose@PLT
	testl	%eax, %eax
	jne	.L20
.L1:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L14
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	.cfi_restore_state
	movb	$0, 16(%rsp)
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L20:
	movq	stderr(%rip), %rdi
	leaq	.LC6(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L17:
	movb	$0, 16(%rsp)
	leaq	16(%rsp), %rbp
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L19:
	movq	stderr(%rip), %rdi
	leaq	.LC5(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L7
.L16:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L14
	movq	stderr(%rip), %rdi
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	leaq	.LC2(%rip), %rdx
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	movl	$2, %esi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
.L14:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE20:
	.size	logEvent, .-logEvent
	.section	.rodata.str1.1
.LC7:
	.string	"%2d/%2d/%4d%c"
	.text
	.p2align 4
	.globl	validateDate
	.type	validateDate, @function
validateDate:
.LFB21:
	.cfi_startproc
	endbr64
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	pxor	%xmm0, %xmm0
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 16(%rsp)
	movq	$0, 64(%rsp)
	movaps	%xmm0, 32(%rsp)
	movaps	%xmm0, 48(%rsp)
	testq	%rdi, %rdi
	je	.L24
	xorl	%eax, %eax
	leaq	8(%rsp), %rcx
	leaq	4(%rsp), %rdx
	leaq	3(%rsp), %r9
	leaq	12(%rsp), %r8
	leaq	.LC7(%rip), %rsi
	call	__isoc99_sscanf@PLT
	cmpl	$3, %eax
	je	.L27
.L24:
	xorl	%eax, %eax
.L21:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L28
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	.cfi_restore_state
	movl	12(%rsp), %edx
	cmpl	$1899, %edx
	jle	.L24
	movl	8(%rsp), %eax
	subl	$1, %eax
	cmpl	$11, %eax
	ja	.L24
	movl	4(%rsp), %ecx
	leal	-1(%rcx), %esi
	cmpl	$30, %esi
	ja	.L24
	movd	%ecx, %xmm0
	movd	%eax, %xmm1
	subl	$1900, %edx
	movl	$-1, 48(%rsp)
	punpckldq	%xmm1, %xmm0
	leaq	16(%rsp), %rdi
	movl	%edx, 36(%rsp)
	movq	%xmm0, 28(%rsp)
	call	mktime@PLT
	movl	12(%rsp), %eax
	subl	$1900, %eax
	cmpl	%eax, 36(%rsp)
	jne	.L24
	movl	8(%rsp), %eax
	subl	$1, %eax
	cmpl	%eax, 32(%rsp)
	jne	.L24
	movl	4(%rsp), %eax
	cmpl	%eax, 28(%rsp)
	sete	%al
	movzbl	%al, %eax
	jmp	.L21
.L28:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
	.size	validateDate, .-validateDate
	.p2align 4
	.globl	discardInput
	.type	discardInput, @function
discardInput:
.LFB22:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L37:
	cmpl	$10, %eax
	je	.L29
.L30:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L37
.L29:
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	discardInput, .-discardInput
	.section	.rodata.str1.1
.LC8:
	.string	"%s"
.LC9:
	.string	"%d"
.LC10:
	.string	"Invalid number.\n"
	.text
	.p2align 4
	.globl	readInt
	.type	readInt, @function
readInt:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rdx
	movq	%rsi, %rbx
	movl	$2, %edi
	leaq	.LC8(%rip), %rsi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	%rbx, %rsi
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	jne	.L40
	movl	%eax, %ebx
	jmp	.L39
	.p2align 4,,10
	.p2align 3
.L57:
	cmpl	$-1, %eax
	je	.L38
.L39:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L57
.L38:
	movl	%ebx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L58:
	.cfi_restore_state
	cmpl	$10, %eax
	je	.L44
.L40:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L58
.L44:
	xorl	%ebx, %ebx
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	%ebx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	readInt, .-readInt
	.section	.rodata.str1.1
.LC11:
	.string	"Value cannot be empty.\n"
	.text
	.p2align 4
	.globl	readText
	.type	readText, @function
readText:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	xorl	%eax, %eax
	movl	%edx, %ebp
	movq	%rdi, %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	$2, %edi
	movq	%rsi, %rbx
	leaq	.LC8(%rip), %rsi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	__printf_chk@PLT
	movq	stdin(%rip), %rdx
	movl	%ebp, %esi
	movq	%rbx, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	je	.L60
	movq	%rbx, %rdi
	call	strlen@PLT
	testq	%rax, %rax
	je	.L63
	leaq	-1(%rbx,%rax), %rax
	cmpb	$10, (%rax)
	jne	.L63
	movb	$0, (%rax)
.L62:
	cmpb	$0, (%rbx)
	movl	$1, %eax
	je	.L79
.L59:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L80:
	.cfi_restore_state
	cmpl	$10, %eax
	je	.L62
.L63:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L80
	cmpb	$0, (%rbx)
	movl	$1, %eax
	jne	.L59
.L79:
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L60:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	readText, .-readText
	.p2align 4
	.globl	findItem
	.type	findItem, @function
findItem:
.LFB25:
	.cfi_startproc
	endbr64
	movl	itemCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L84
	leaq	inventory(%rip), %rdx
	xorl	%eax, %eax
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L86:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	je	.L84
.L83:
	cmpl	%edi, (%rdx)
	jne	.L86
	ret
	.p2align 4,,10
	.p2align 3
.L84:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	findItem, .-findItem
	.section	.rodata.str1.1
.LC12:
	.string	"Inventory Full!\n"
.LC13:
	.string	"Enter Item ID: "
.LC14:
	.string	"Enter Item Name: "
.LC15:
	.string	"Enter Category: "
.LC16:
	.string	"Enter Quantity: "
.LC17:
	.string	"Quantity cannot be negative!\n"
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"Enter Expiry Date (DD/MM/YYYY): "
	.align 8
.LC19:
	.string	"Invalid date. Use DD/MM/YYYY.\n"
	.section	.rodata.str1.1
.LC20:
	.string	"Inventory item added"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"Item Added Successfully at %s!\n"
	.section	.rodata.str1.1
.LC22:
	.string	"Item ID already exists!\n"
	.text
	.p2align 4
	.globl	addItem
	.type	addItem, @function
addItem:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movslq	itemCount(%rip), %rbx
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpl	$99, %ebx
	jg	.L149
	leaq	.LC8(%rip), %r12
	movl	$2, %edi
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC13(%rip), %rdx
	leaq	.LC9(%rip), %rbp
	call	__printf_chk@PLT
	leaq	(%rbx,%rbx,8), %rsi
	xorl	%eax, %eax
	movq	%rbp, %rdi
	salq	$4, %rsi
	leaq	inventory(%rip), %rbx
	addq	%rbx, %rsi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L90
	jmp	.L91
	.p2align 4,,10
	.p2align 3
.L150:
	cmpl	$-1, %eax
	je	.L104
.L91:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L150
.L104:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	leaq	.LC10(%rip), %rsi
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L151:
	cmpl	$-1, %eax
	je	.L116
.L90:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L151
.L116:
	movslq	itemCount(%rip), %rdi
	leaq	(%rdi,%rdi,8), %rax
	movq	%rdi, %rcx
	salq	$4, %rax
	movl	(%rbx,%rax), %esi
	testl	%edi, %edi
	jle	.L95
	leaq	inventory(%rip), %rax
	xorl	%edx, %edx
	jmp	.L97
	.p2align 4,,10
	.p2align 3
.L152:
	addl	$1, %edx
	addq	$144, %rax
	cmpl	%edx, %ecx
	je	.L95
.L97:
	cmpl	(%rax), %esi
	jne	.L152
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	leaq	.LC22(%rip), %rsi
.L147:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L149:
	.cfi_restore_state
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	leaq	.LC12(%rip), %rsi
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L95:
	leaq	(%rdi,%rdi,8), %rax
	movl	$50, %edx
	leaq	.LC14(%rip), %rdi
	salq	$4, %rax
	leaq	4(%rbx,%rax), %rsi
	call	readText
	testl	%eax, %eax
	jne	.L153
.L87:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L153:
	.cfi_restore_state
	movslq	itemCount(%rip), %rax
	movl	$30, %edx
	leaq	.LC15(%rip), %rdi
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	54(%rbx,%rax), %rsi
	call	readText
	testl	%eax, %eax
	je	.L87
	movslq	itemCount(%rip), %rax
	movq	%r12, %rsi
	movl	$2, %edi
	leaq	.LC16(%rip), %rdx
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	84(%rbx,%rax), %r13
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L101
	jmp	.L102
	.p2align 4,,10
	.p2align 3
.L154:
	cmpl	$10, %eax
	je	.L104
.L102:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L154
	jmp	.L104
	.p2align 4,,10
	.p2align 3
.L155:
	cmpl	$10, %eax
	je	.L117
.L101:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L155
.L117:
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	movl	84(%rbx,%rax), %edx
	testl	%edx, %edx
	js	.L156
	leaq	88(%rbx,%rax), %rsi
	movl	$15, %edx
	leaq	.LC18(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L87
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	88(%rbx,%rax), %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L157
	movslq	itemCount(%rip), %rax
	xorl	%edi, %edi
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	103(%rbx,%rax), %rbp
	call	time@PLT
	movq	%rsp, %rdi
	movq	%rax, (%rsp)
	call	localtime@PLT
	testq	%rax, %rax
	je	.L146
	movq	%rax, %rcx
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbp, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L111
.L146:
	movb	$0, 0(%rbp)
.L111:
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rcx
	movq	%rax, %rbp
	movl	$14400, %eax
	salq	$4, %rcx
	leaq	123(%rcx), %rdx
	leaq	103(%rbx,%rcx), %rsi
	cmpq	%rax, %rdx
	leaq	(%rbx,%rdx), %rdi
	cmovnb	%rdx, %rax
	movl	$20, %edx
	addl	$1, %ebp
	subq	%rcx, %rax
	subq	$123, %rax
	movq	%rax, %rcx
	call	__memcpy_chk@PLT
	leaq	.LC20(%rip), %rdi
	movl	%ebp, itemCount(%rip)
	call	logEvent
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	movl	itemCount(%rip), %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$2, %edi
	leaq	.LC21(%rip), %rsi
	subl	$1, %eax
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	103(%rbx,%rax), %rdx
	popq	%rbx
	.cfi_def_cfa_offset 32
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
.L156:
	.cfi_restore_state
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	leaq	.LC17(%rip), %rsi
	jmp	.L147
.L157:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	leaq	.LC19(%rip), %rsi
	jmp	.L147
.L148:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE26:
	.size	addItem, .-addItem
	.section	.rodata.str1.1
.LC23:
	.string	"No Inventory Records Found!\n"
.LC24:
	.string	"\n----- INVENTORY -----\n"
.LC25:
	.string	"\nID: %d"
.LC26:
	.string	"\nName: %s"
.LC27:
	.string	"\nCategory: %s"
.LC28:
	.string	"\nQuantity: %d"
.LC29:
	.string	"\nExpiry Date: %s"
.LC30:
	.string	"\nCreated Date: %s"
.LC31:
	.string	"\nUpdated Date: %s\n"
	.text
	.p2align 4
	.globl	viewInventory
	.type	viewInventory, @function
viewInventory:
.LFB27:
	.cfi_startproc
	endbr64
	movl	itemCount(%rip), %edx
	testl	%edx, %edx
	je	.L168
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC24(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.LC25(%rip), %r15
	leaq	.LC26(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	.LC27(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.LC28(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	4+inventory(%rip), %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	__printf_chk@PLT
	movl	itemCount(%rip), %eax
	testl	%eax, %eax
	jle	.L158
	.p2align 4,,10
	.p2align 3
.L162:
	movl	-4(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	50(%rbx), %rdx
	movq	%r13, %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
	movl	80(%rbx), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	84(%rbx), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	call	__printf_chk@PLT
	leaq	99(%rbx), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC30(%rip), %rsi
	call	__printf_chk@PLT
	leaq	119(%rbx), %rdx
	xorl	%eax, %eax
	movl	$2, %edi
	leaq	.LC31(%rip), %rsi
	addq	$144, %rbx
	call	__printf_chk@PLT
	cmpl	itemCount(%rip), %ebp
	jl	.L162
.L158:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L168:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	leaq	.LC23(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE27:
	.size	viewInventory, .-viewInventory
	.section	.rodata.str1.1
.LC32:
	.string	"Item Not Found!\n"
.LC33:
	.string	"\nExpiry Date: %s\n"
	.text
	.p2align 4
	.globl	searchItem
	.type	searchItem, @function
searchItem:
.LFB28:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	leaq	.LC13(%rip), %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L170
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L194:
	cmpl	$-1, %eax
	je	.L180
.L171:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L194
.L180:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L169
	.p2align 4,,10
	.p2align 3
.L195:
	cmpl	$-1, %eax
	je	.L181
.L170:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L195
.L181:
	movl	itemCount(%rip), %ecx
	movl	4(%rsp), %esi
	testl	%ecx, %ecx
	jle	.L175
	leaq	inventory(%rip), %rbp
	xorl	%eax, %eax
	movq	%rbp, %rdx
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L196:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%eax, %ecx
	je	.L175
.L177:
	cmpl	(%rdx), %esi
	jne	.L196
	cltq
	leaq	.LC25(%rip), %rsi
	movl	$2, %edi
	leaq	(%rax,%rax,8), %rbx
	xorl	%eax, %eax
	salq	$4, %rbx
	leaq	0(%rbp,%rbx), %r12
	movl	(%r12), %edx
	call	__printf_chk@PLT
	leaq	4(%rbp,%rbx), %rdx
	leaq	.LC26(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
	leaq	54(%rbp,%rbx), %rdx
	leaq	.LC27(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
	movl	84(%r12), %edx
	leaq	.LC28(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
	leaq	88(%rbp,%rbx), %rdx
	leaq	.LC33(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	__printf_chk@PLT
.L169:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L197
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L175:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L169
.L197:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE28:
	.size	searchItem, .-searchItem
	.section	.rodata.str1.1
.LC34:
	.string	"Enter New Expiry Date: "
.LC35:
	.string	"Inventory item updated"
.LC36:
	.string	"Item Updated Successfully!\n"
.LC37:
	.string	"Enter New Quantity: "
	.text
	.p2align 4
	.globl	updateItem
	.type	updateItem, @function
updateItem:
.LFB29:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$2, %edi
	leaq	.LC13(%rip), %rdx
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	.LC8(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%r12, %rsi
	leaq	.LC9(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L199
	jmp	.L200
	.p2align 4,,10
	.p2align 3
.L246:
	cmpl	$-1, %eax
	je	.L209
.L200:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L246
.L209:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L198:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L247
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L248:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L219
.L199:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L248
.L219:
	movl	itemCount(%rip), %edx
	movl	8(%rsp), %ecx
	testl	%edx, %edx
	jle	.L204
	leaq	inventory(%rip), %r13
	xorl	%ebx, %ebx
	movq	%r13, %rax
	jmp	.L206
	.p2align 4,,10
	.p2align 3
.L249:
	addl	$1, %ebx
	addq	$144, %rax
	cmpl	%edx, %ebx
	je	.L204
.L206:
	cmpl	(%rax), %ecx
	jne	.L249
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC37(%rip), %rdx
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	12(%rsp), %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	jne	.L207
	jmp	.L210
	.p2align 4,,10
	.p2align 3
.L250:
	cmpl	$10, %eax
	je	.L209
.L207:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L250
	jmp	.L209
	.p2align 4,,10
	.p2align 3
.L251:
	cmpl	$10, %eax
	je	.L220
.L210:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L251
.L220:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	js	.L252
	movslq	%ebx, %rbx
	movl	$15, %edx
	leaq	.LC34(%rip), %rdi
	leaq	(%rbx,%rbx,8), %rbx
	salq	$4, %rbx
	leaq	88(%r13,%rbx), %rbp
	movq	%rbp, %rsi
	call	readText
	testl	%eax, %eax
	je	.L198
	movq	%rbp, %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L253
	movl	12(%rsp), %eax
	xorl	%edi, %edi
	movl	%eax, 84(%r13,%rbx)
	leaq	123(%r13,%rbx), %rbx
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L245
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L215
.L245:
	movb	$0, (%rbx)
.L215:
	leaq	.LC35(%rip), %rdi
	call	logEvent
	leaq	.LC36(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L198
	.p2align 4,,10
	.p2align 3
.L204:
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L198
	.p2align 4,,10
	.p2align 3
.L252:
	leaq	.LC17(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L198
.L253:
	leaq	.LC19(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	jmp	.L198
.L247:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE29:
	.size	updateItem, .-updateItem
	.section	.rodata.str1.1
.LC38:
	.string	"Item Removed Successfully!\n"
	.text
	.p2align 4
	.globl	deleteItem
	.type	deleteItem, @function
deleteItem:
.LFB30:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	leaq	.LC13(%rip), %rdx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L255
	jmp	.L256
	.p2align 4,,10
	.p2align 3
.L281:
	cmpl	$-1, %eax
	je	.L267
.L256:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L281
.L267:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L254
	.p2align 4,,10
	.p2align 3
.L282:
	cmpl	$10, %eax
	je	.L268
.L255:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L282
.L268:
	movl	itemCount(%rip), %ecx
	movl	4(%rsp), %esi
	testl	%ecx, %ecx
	jle	.L260
	leaq	inventory(%rip), %rdi
	xorl	%eax, %eax
	movq	%rdi, %rdx
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L283:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	je	.L260
.L262:
	cmpl	(%rdx), %esi
	jne	.L283
	leal	-1(%rcx), %ebx
	cmpl	%eax, %ebx
	jle	.L265
	movslq	%eax, %rdx
	subl	$2, %ecx
	leaq	(%rdx,%rdx,8), %rsi
	subl	%eax, %ecx
	salq	$4, %rsi
	leaq	9(%rcx,%rcx,8), %rdx
	leaq	144(%rdi,%rsi), %rax
	salq	$4, %rdx
	addq	%rsi, %rdi
	movq	%rax, %rsi
	call	memmove@PLT
.L265:
	leaq	.LC38(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	movl	%ebx, itemCount(%rip)
	call	__printf_chk@PLT
.L254:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L284
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L260:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L254
.L284:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE30:
	.size	deleteItem, .-deleteItem
	.section	.rodata.str1.1
.LC39:
	.string	"Quantity must be positive!\n"
	.section	.rodata.str1.8
	.align 8
.LC40:
	.string	"Quantity exceeds the supported limit.\n"
	.section	.rodata.str1.1
.LC41:
	.string	"Inventory stock received"
.LC42:
	.string	"Stock Updated Successfully!\n"
.LC43:
	.string	"Enter Quantity Received: "
	.text
	.p2align 4
	.globl	receiveStock
	.type	receiveStock, @function
receiveStock:
.LFB31:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$2, %edi
	leaq	.LC13(%rip), %rdx
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	.LC8(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%r12, %rsi
	leaq	.LC9(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	8(%rsp), %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L286
	jmp	.L287
	.p2align 4,,10
	.p2align 3
.L330:
	cmpl	$-1, %eax
	je	.L296
.L287:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L330
.L296:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L285:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L331
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L332:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L306
.L286:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L332
.L306:
	movl	itemCount(%rip), %edx
	movl	8(%rsp), %ecx
	testl	%edx, %edx
	jle	.L291
	leaq	inventory(%rip), %r13
	xorl	%ebx, %ebx
	movq	%r13, %rax
	jmp	.L293
	.p2align 4,,10
	.p2align 3
.L333:
	addl	$1, %ebx
	addq	$144, %rax
	cmpl	%edx, %ebx
	je	.L291
.L293:
	cmpl	(%rax), %ecx
	jne	.L333
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC43(%rip), %rdx
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	12(%rsp), %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	jne	.L294
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L334:
	cmpl	$10, %eax
	je	.L296
.L294:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L334
	jmp	.L296
	.p2align 4,,10
	.p2align 3
.L335:
	cmpl	$10, %eax
	je	.L307
.L297:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L335
.L307:
	movl	12(%rsp), %eax
	testl	%eax, %eax
	jle	.L336
	movslq	%ebx, %rbx
	movl	$2147483647, %ecx
	leaq	(%rbx,%rbx,8), %rdx
	salq	$4, %rdx
	leaq	0(%r13,%rdx), %rsi
	movl	84(%rsi), %edi
	subl	%edi, %ecx
	cmpl	%ecx, %eax
	jg	.L337
	addl	%edi, %eax
	xorl	%edi, %edi
	leaq	123(%r13,%rdx), %rbx
	movl	%eax, 84(%rsi)
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L329
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L302
.L329:
	movb	$0, (%rbx)
.L302:
	leaq	.LC41(%rip), %rdi
	call	logEvent
	leaq	.LC42(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L285
	.p2align 4,,10
	.p2align 3
.L337:
	leaq	.LC40(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L285
	.p2align 4,,10
	.p2align 3
.L291:
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L285
.L336:
	leaq	.LC39(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L285
.L331:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	receiveStock, .-receiveStock
	.section	.rodata.str1.1
.LC44:
	.string	"\n----- LOW STOCK ITEMS -----\n"
.LC45:
	.string	"No Low Stock Items.\n"
.LC46:
	.string	"%d - %s (Qty: %d)\n"
	.text
	.p2align 4
	.globl	lowStockItems
	.type	lowStockItems, @function
lowStockItems:
.LFB32:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC44(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.LC46(%rip), %r12
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	leaq	4+inventory(%rip), %rbx
	call	__printf_chk@PLT
	movl	itemCount(%rip), %edx
	xorl	%ecx, %ecx
	testl	%edx, %edx
	jle	.L345
	.p2align 4,,10
	.p2align 3
.L344:
	movl	80(%rbx), %r8d
	leal	-1(%r8), %eax
	cmpl	$9, %eax
	jbe	.L352
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%edx, %ebp
	jl	.L344
	testl	%ecx, %ecx
	je	.L345
.L338:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L352:
	.cfi_restore_state
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	addq	$144, %rbx
	call	__printf_chk@PLT
	movl	itemCount(%rip), %edx
	cmpl	%edx, %ebp
	jge	.L338
	movl	$1, %ecx
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L345:
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	.LC45(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE32:
	.size	lowStockItems, .-lowStockItems
	.section	.rodata.str1.8
	.align 8
.LC47:
	.string	"\n----- OUT OF STOCK ITEMS -----\n"
	.section	.rodata.str1.1
.LC48:
	.string	"No Out Of Stock Items.\n"
.LC49:
	.string	"%d - %s\n"
	.text
	.p2align 4
	.globl	outOfStockItems
	.type	outOfStockItems, @function
outOfStockItems:
.LFB33:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC47(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.LC49(%rip), %r12
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	leaq	4+inventory(%rip), %rbx
	call	__printf_chk@PLT
	movl	itemCount(%rip), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	.L360
	.p2align 4,,10
	.p2align 3
.L359:
	movl	80(%rbx), %ecx
	testl	%ecx, %ecx
	je	.L367
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, %eax
	jg	.L359
	testl	%edx, %edx
	je	.L360
.L353:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L367:
	.cfi_restore_state
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	addq	$144, %rbx
	call	__printf_chk@PLT
	movl	itemCount(%rip), %eax
	cmpl	%eax, %ebp
	jge	.L353
	movl	$1, %edx
	jmp	.L359
	.p2align 4,,10
	.p2align 3
.L360:
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	.LC48(%rip), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE33:
	.size	outOfStockItems, .-outOfStockItems
	.section	.rodata.str1.1
.LC50:
	.string	"Request Storage Full!\n"
.LC51:
	.string	"Enter Request ID: "
.LC52:
	.string	"Request ID already exists!\n"
.LC53:
	.string	"Enter Quantity Required: "
.LC54:
	.string	"Enter Department: "
.LC55:
	.string	"Supply request created"
	.section	.rodata.str1.8
	.align 8
.LC56:
	.string	"Request Created Successfully!\n"
	.text
	.p2align 4
	.globl	createRequest
	.type	createRequest, @function
createRequest:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movslq	requestCount(%rip), %rbx
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpl	$99, %ebx
	jg	.L437
	leaq	.LC8(%rip), %r12
	movl	$2, %edi
	xorl	%eax, %eax
	movq	%r12, %rsi
	leaq	.LC51(%rip), %rdx
	leaq	.LC9(%rip), %rbp
	call	__printf_chk@PLT
	movq	%rbx, %rax
	movq	%rbp, %rdi
	salq	$5, %rax
	subq	%rbx, %rax
	leaq	requests(%rip), %rbx
	leaq	(%rbx,%rax,4), %rsi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L371
	jmp	.L372
	.p2align 4,,10
	.p2align 3
.L438:
	cmpl	$10, %eax
	je	.L383
.L372:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L438
.L383:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	leaq	.LC10(%rip), %rsi
.L435:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L439:
	.cfi_restore_state
	cmpl	$10, %eax
	je	.L397
.L371:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L439
.L397:
	movslq	requestCount(%rip), %r13
	testl	%r13d, %r13d
	jle	.L376
	movq	%r13, %rax
	salq	$5, %rax
	subq	%r13, %rax
	leaq	(%rbx,%rax,4), %rdx
	leaq	requests(%rip), %rbx
	movl	(%rdx), %ecx
	movq	%rbx, %rax
	jmp	.L379
	.p2align 4,,10
	.p2align 3
.L377:
	addq	$124, %rax
	cmpq	%rax, %rdx
	je	.L376
.L379:
	cmpl	%ecx, (%rax)
	jne	.L377
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	leaq	.LC52(%rip), %rsi
	jmp	.L435
	.p2align 4,,10
	.p2align 3
.L437:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	leaq	.LC50(%rip), %rsi
	jmp	.L435
	.p2align 4,,10
	.p2align 3
.L376:
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rdx
	call	__printf_chk@PLT
	movq	%r13, %rax
	movq	%rbp, %rdi
	salq	$5, %rax
	subq	%r13, %rax
	leaq	4(%rbx,%rax,4), %rsi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L380
	jmp	.L381
	.p2align 4,,10
	.p2align 3
.L440:
	cmpl	$10, %eax
	je	.L383
.L381:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L440
	jmp	.L383
	.p2align 4,,10
	.p2align 3
.L441:
	cmpl	$10, %eax
	je	.L398
.L380:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L441
.L398:
	movslq	requestCount(%rip), %rdx
	movq	%r12, %rsi
	movl	$2, %edi
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	.LC53(%rip), %rdx
	leaq	8(%rbx,%rax,4), %r13
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movq	%r13, %rsi
	movq	%rbp, %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L385
	jmp	.L386
	.p2align 4,,10
	.p2align 3
.L442:
	cmpl	$10, %eax
	je	.L383
.L386:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L442
	jmp	.L383
	.p2align 4,,10
	.p2align 3
.L443:
	cmpl	$-1, %eax
	je	.L399
.L385:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L443
.L399:
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movl	8(%rbx,%rax,4), %eax
	testl	%eax, %eax
	jle	.L444
	leaq	12(%rbx,%rdx), %rsi
	leaq	.LC54(%rip), %rdi
	movl	$50, %edx
	call	readText
	testl	%eax, %eax
	jne	.L445
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L445:
	.cfi_restore_state
	movslq	requestCount(%rip), %rdx
	xorl	%edi, %edi
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	82(%rbx,%rax,4), %rbp
	call	time@PLT
	movq	%rsp, %rdi
	movq	%rax, (%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L434
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbp, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L393
.L434:
	movb	$0, 0(%rbp)
.L393:
	movslq	requestCount(%rip), %rdx
	leaq	.LC55(%rip), %rdi
	movabsq	$29113321536775504, %rcx
	addl	$1, requestCount(%rip)
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	salq	$2, %rax
	movq	%rcx, 62(%rbx,%rax)
	movb	$0, 102(%rbx,%rax)
	call	logEvent
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	leaq	.LC56(%rip), %rsi
	jmp	.L435
.L444:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L436
	leaq	.LC39(%rip), %rsi
	jmp	.L435
.L436:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE34:
	.size	createRequest, .-createRequest
	.section	.rodata.str1.8
	.align 8
.LC57:
	.string	"Supply request rejected: item not found"
	.section	.rodata.str1.1
.LC58:
	.string	"Item Not Found.\n"
.LC59:
	.string	"Supply request approved"
.LC60:
	.string	"Request Approved.\n"
	.section	.rodata.str1.8
	.align 8
.LC61:
	.string	"Supply request rejected: insufficient stock"
	.align 8
.LC62:
	.string	"Insufficient Stock. Request Rejected.\n"
	.section	.rodata.str1.1
.LC63:
	.string	"Request Not Found.\n"
	.text
	.p2align 4
	.globl	processRequest
	.type	processRequest, @function
processRequest:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	leaq	.LC51(%rip), %rdx
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	12(%rsp), %rsi
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L447
	jmp	.L448
	.p2align 4,,10
	.p2align 3
.L490:
	cmpl	$10, %eax
	je	.L471
.L448:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L490
.L471:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L446:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L491
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L492:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L472
.L447:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L492
.L472:
	movl	requestCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L452
	leaq	requests(%rip), %r8
	movl	12(%rsp), %esi
	xorl	%eax, %eax
	movq	%r8, %rdx
	jmp	.L466
	.p2align 4,,10
	.p2align 3
.L453:
	addl	$1, %eax
	addq	$124, %rdx
	cmpl	%ecx, %eax
	je	.L452
.L466:
	cmpl	%esi, (%rdx)
	jne	.L453
	cltq
	movl	itemCount(%rip), %esi
	movq	%rax, %rdx
	salq	$5, %rdx
	subq	%rax, %rdx
	movl	4(%r8,%rdx,4), %edi
	testl	%esi, %esi
	jle	.L454
	leaq	inventory(%rip), %r9
	xorl	%edx, %edx
	movq	%r9, %rcx
	jmp	.L456
	.p2align 4,,10
	.p2align 3
.L493:
	addl	$1, %edx
	addq	$144, %rcx
	cmpl	%edx, %esi
	je	.L454
.L456:
	cmpl	(%rcx), %edi
	jne	.L493
	movq	%rax, %rcx
	movslq	%edx, %rdx
	salq	$5, %rcx
	leaq	(%rdx,%rdx,8), %rdx
	subq	%rax, %rcx
	salq	$4, %rdx
	leaq	0(,%rcx,4), %rax
	leaq	62(%r8,%rax), %rcx
	leaq	102(%r8,%rax), %rbx
	movl	8(%r8,%rax), %eax
	cmpl	%eax, 84(%r9,%rdx)
	jl	.L494
	movabsq	$7234318597473988673, %rax
	movb	$0, 8(%rcx)
	xorl	%edi, %edi
	movq	%rax, (%rcx)
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L488
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L461
.L488:
	movb	$0, (%rbx)
.L461:
	leaq	.LC59(%rip), %rdi
	call	logEvent
	leaq	.LC60(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L452:
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L494:
	movabsq	$7234316346692625746, %rax
	movb	$0, 8(%rcx)
	xorl	%edi, %edi
	movq	%rax, (%rcx)
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L489
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L464
.L489:
	movb	$0, (%rbx)
.L464:
	leaq	.LC61(%rip), %rdi
	call	logEvent
	leaq	.LC62(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L454:
	movabsq	$7234316346692625746, %rbx
	movq	%rax, %rdx
	xorl	%edi, %edi
	salq	$5, %rdx
	subq	%rax, %rdx
	leaq	0(,%rdx,4), %rax
	leaq	62(%r8,%rax), %rdx
	movq	%rbx, (%rdx)
	leaq	102(%r8,%rax), %rbx
	movb	$0, 8(%rdx)
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L487
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L458
.L487:
	movb	$0, (%rbx)
.L458:
	leaq	.LC57(%rip), %rdi
	call	logEvent
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L446
.L491:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE35:
	.size	processRequest, .-processRequest
	.section	.rodata.str1.1
.LC64:
	.string	"\n----- REQUESTS -----\n"
.LC65:
	.string	"\nRequest ID : %d"
.LC66:
	.string	"\nItem ID    : %d"
.LC67:
	.string	"\nQuantity   : %d"
.LC68:
	.string	"\nDepartment : %s"
.LC69:
	.string	"\nStatus     : %s"
.LC70:
	.string	"\nCreated Date : %s"
.LC71:
	.string	"\nProcessed Date: %s\n"
	.text
	.p2align 4
	.globl	viewRequests
	.type	viewRequests, @function
viewRequests:
.LFB36:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC64(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	__printf_chk@PLT
	movl	requestCount(%rip), %eax
	testl	%eax, %eax
	jle	.L495
	leaq	12+requests(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	.LC65(%rip), %r15
	leaq	.LC66(%rip), %r14
	leaq	.LC67(%rip), %r13
	leaq	.LC68(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L497:
	movl	-12(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	call	__printf_chk@PLT
	movl	-8(%rbx), %edx
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	-4(%rbx), %edx
	movq	%r13, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	50(%rbx), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC69(%rip), %rsi
	call	__printf_chk@PLT
	leaq	70(%rbx), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC70(%rip), %rsi
	call	__printf_chk@PLT
	leaq	90(%rbx), %rdx
	xorl	%eax, %eax
	movl	$2, %edi
	leaq	.LC71(%rip), %rsi
	addq	$124, %rbx
	call	__printf_chk@PLT
	cmpl	%ebp, requestCount(%rip)
	jg	.L497
.L495:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE36:
	.size	viewRequests, .-viewRequests
	.section	.rodata.str1.1
.LC72:
	.string	"Distribution Storage Full!\n"
.LC73:
	.string	"Enter Approved Request ID: "
.LC74:
	.string	"Approved"
.LC75:
	.string	"Request Is Not Approved.\n"
	.section	.rodata.str1.8
	.align 8
.LC76:
	.string	"Insufficient Stock. Supply Not Distributed.\n"
	.section	.rodata.str1.1
.LC77:
	.string	"Supply request distributed"
	.section	.rodata.str1.8
	.align 8
.LC78:
	.string	"Supply Distributed Successfully!\n"
	.text
	.p2align 4
	.globl	distributeSupply
	.type	distributeSupply, @function
distributeSupply:
.LFB37:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	cmpl	$99, distributionCount(%rip)
	jg	.L542
	leaq	.LC8(%rip), %rbp
	movl	$2, %edi
	xorl	%eax, %eax
	movq	%rbp, %rsi
	leaq	.LC73(%rip), %rdx
	call	__printf_chk@PLT
	xorl	%eax, %eax
	leaq	12(%rsp), %rsi
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L505
	jmp	.L506
	.p2align 4,,10
	.p2align 3
.L543:
	cmpl	$-1, %eax
	je	.L524
.L506:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L543
.L524:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L502:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L541
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L544:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L525
.L505:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L544
.L525:
	movl	requestCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L510
	leaq	requests(%rip), %r13
	movl	12(%rsp), %esi
	xorl	%eax, %eax
	movq	%r13, %rdx
	jmp	.L519
	.p2align 4,,10
	.p2align 3
.L511:
	addl	$1, %eax
	addq	$124, %rdx
	cmpl	%ecx, %eax
	je	.L510
.L519:
	cmpl	%esi, (%rdx)
	jne	.L511
	movslq	%eax, %rbx
	leaq	.LC74(%rip), %rsi
	movq	%rbx, %r14
	salq	$5, %r14
	subq	%rbx, %r14
	salq	$2, %r14
	leaq	62(%r13,%r14), %r12
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L545
	movl	itemCount(%rip), %ecx
	movl	4(%r13,%r14), %esi
	testl	%ecx, %ecx
	jle	.L513
	leaq	inventory(%rip), %rdi
	movq	%rdi, %rdx
	jmp	.L515
	.p2align 4,,10
	.p2align 3
.L546:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%eax, %ecx
	je	.L513
.L515:
	cmpl	(%rdx), %esi
	jne	.L546
	movq	%rbx, %rdx
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$5, %rdx
	subq	%rbx, %rdx
	salq	$4, %rax
	leaq	(%rdi,%rax), %r8
	leaq	0(%r13,%rdx,4), %rbx
	movl	84(%r8), %ecx
	movl	8(%rbx), %edx
	cmpl	%edx, %ecx
	jge	.L547
	leaq	.LC76(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L542:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L541
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	leaq	.LC72(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L510:
	.cfi_restore_state
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L547:
	subl	%edx, %ecx
	movd	%esi, %xmm1
	leaq	distributions(%rip), %r15
	movl	$50, %esi
	movl	%ecx, 84(%r8)
	movslq	distributionCount(%rip), %r8
	movq	%r8, %rcx
	movq	%r8, %rdx
	addl	$1, %ecx
	salq	$4, %rdx
	addq	%r8, %rdx
	movd	%ecx, %xmm0
	leaq	4(%rdi,%rax), %rcx
	xorl	%eax, %eax
	punpckldq	%xmm1, %xmm0
	salq	$3, %rdx
	movq	%xmm0, (%r15,%rdx)
	leaq	8(%r15,%rdx), %rdi
	movq	%rbp, %rdx
	call	snprintf@PLT
	leaq	12(%r13,%r14), %rcx
	movl	$50, %esi
	movslq	distributionCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$4, %rax
	addq	%rdx, %rax
	movl	8(%rbx), %edx
	salq	$3, %rax
	movl	%edx, 60(%r15,%rax)
	leaq	64(%r15,%rax), %rdi
	movq	%rbp, %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movslq	distributionCount(%rip), %rdx
	xorl	%edi, %edi
	movq	%rdx, %rax
	salq	$4, %rax
	addq	%rdx, %rax
	leaq	114(%r15,%rax,8), %rbx
	call	time@PLT
	leaq	16(%rsp), %rdi
	movq	%rax, 16(%rsp)
	call	localtime@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L540
	leaq	.LC3(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L517
.L540:
	movb	$0, (%rbx)
.L517:
	movl	$6579572, 8(%r12)
	leaq	.LC77(%rip), %rdi
	movabsq	$8458438990456121668, %rax
	movq	%rax, (%r12)
	addl	$1, distributionCount(%rip)
	call	logEvent
	leaq	.LC78(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L545:
	leaq	.LC75(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L502
	.p2align 4,,10
	.p2align 3
.L513:
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L502
.L541:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE37:
	.size	distributeSupply, .-distributeSupply
	.section	.rodata.str1.8
	.align 8
.LC79:
	.string	"\n----- DISTRIBUTION HISTORY -----\n"
	.section	.rodata.str1.1
.LC80:
	.string	"\nDistribution ID : %d"
.LC81:
	.string	"\nItem ID         : %d"
.LC82:
	.string	"\nItem Name       : %s"
.LC83:
	.string	"\nQuantity        : %d"
.LC84:
	.string	"\nDepartment      : %s\n"
.LC85:
	.string	"Distributed Date: %s\n"
	.text
	.p2align 4
	.globl	viewDistributionHistory
	.type	viewDistributionHistory, @function
viewDistributionHistory:
.LFB38:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC79(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	call	__printf_chk@PLT
	movl	distributionCount(%rip), %eax
	testl	%eax, %eax
	jle	.L548
	leaq	8+distributions(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	.LC80(%rip), %r15
	leaq	.LC81(%rip), %r14
	leaq	.LC82(%rip), %r13
	leaq	.LC83(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L550:
	movl	-8(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addl	$1, %ebp
	call	__printf_chk@PLT
	movl	-4(%rbx), %edx
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r13, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	52(%rbx), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	56(%rbx), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC84(%rip), %rsi
	call	__printf_chk@PLT
	leaq	106(%rbx), %rdx
	xorl	%eax, %eax
	movl	$2, %edi
	leaq	.LC85(%rip), %rsi
	addq	$136, %rbx
	call	__printf_chk@PLT
	cmpl	%ebp, distributionCount(%rip)
	jg	.L550
.L548:
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE38:
	.size	viewDistributionHistory, .-viewDistributionHistory
	.section	.rodata.str1.8
	.align 8
.LC86:
	.string	"\n===================================="
	.align 8
.LC87:
	.string	"\n MEDICAL SUPPLY MANAGEMENT SYSTEM"
	.section	.rodata.str1.1
.LC88:
	.string	"\n1. Add Item"
.LC89:
	.string	"\n2. View Inventory"
.LC90:
	.string	"\n3. Search Item"
.LC91:
	.string	"\n4. Update Item"
.LC92:
	.string	"\n5. Remove Item"
.LC93:
	.string	"\n6. Receive Stock"
.LC94:
	.string	"\n7. Low Stock Items"
.LC95:
	.string	"\n8. Out Of Stock Items"
.LC96:
	.string	"\n9. Create Supply Request"
.LC97:
	.string	"\n10. Process Request"
.LC98:
	.string	"\n11. View Requests"
.LC99:
	.string	"\n12. Distribute Supplies"
	.section	.rodata.str1.8
	.align 8
.LC100:
	.string	"\n13. View Distribution History"
	.section	.rodata.str1.1
.LC101:
	.string	"\n14. Exit"
.LC102:
	.string	"\nEnter Choice: "
.LC103:
	.string	""
.LC104:
	.string	"Exiting System...\n"
.LC105:
	.string	"Invalid Choice!\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	.LC87(%rip), %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	.LC88(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leaq	.LC89(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	.LC90(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	.L564(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	.LC86(%rip), %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	20(%rsp), %rax
	movq	%rax, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L560:
	movq	%rbx, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r15, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r13, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC91(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC92(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC93(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC94(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC95(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC96(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC97(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC98(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC99(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC100(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	movl	$2, %edi
	leaq	.LC101(%rip), %rsi
	call	__printf_chk@PLT
	leaq	.LC102(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	leaq	.LC8(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	leaq	.LC103(%rip), %rdx
	call	__printf_chk@PLT
	movq	8(%rsp), %rsi
	xorl	%eax, %eax
	leaq	.LC9(%rip), %rdi
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L557
	jmp	.L558
	.p2align 4,,10
	.p2align 3
.L594:
	cmpl	$10, %eax
	je	.L580
.L558:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L594
.L580:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L595:
	cmpl	$-1, %eax
	je	.L581
.L557:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L595
.L581:
	cmpl	$14, 20(%rsp)
	ja	.L562
	movl	20(%rsp), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L564:
	.long	.L562-.L564
	.long	.L577-.L564
	.long	.L576-.L564
	.long	.L575-.L564
	.long	.L574-.L564
	.long	.L573-.L564
	.long	.L572-.L564
	.long	.L571-.L564
	.long	.L570-.L564
	.long	.L569-.L564
	.long	.L568-.L564
	.long	.L567-.L564
	.long	.L566-.L564
	.long	.L565-.L564
	.long	.L563-.L564
	.section	.text.startup
	.p2align 4,,10
	.p2align 3
.L563:
	xorl	%eax, %eax
	leaq	.LC104(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L596
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L565:
	.cfi_restore_state
	call	viewDistributionHistory
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L566:
	call	distributeSupply
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L567:
	call	viewRequests
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L568:
	call	processRequest
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L569:
	call	createRequest
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L570:
	call	outOfStockItems
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L571:
	call	lowStockItems
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L572:
	call	receiveStock
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L573:
	call	deleteItem
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L574:
	call	updateItem
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L575:
	call	searchItem
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L576:
	call	viewInventory
	jmp	.L560
	.p2align 4,,10
	.p2align 3
.L577:
	call	addItem
	jmp	.L560
.L562:
	leaq	.LC105(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L560
.L596:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.globl	distributionCount
	.bss
	.align 4
	.type	distributionCount, @object
	.size	distributionCount, 4
distributionCount:
	.zero	4
	.globl	requestCount
	.align 4
	.type	requestCount, @object
	.size	requestCount, 4
requestCount:
	.zero	4
	.globl	itemCount
	.align 4
	.type	itemCount, @object
	.size	itemCount, 4
itemCount:
	.zero	4
	.globl	distributions
	.align 32
	.type	distributions, @object
	.size	distributions, 13600
distributions:
	.zero	13600
	.globl	requests
	.align 32
	.type	requests, @object
	.size	requests, 12400
requests:
	.zero	12400
	.globl	inventory
	.align 32
	.type	inventory, @object
	.size	inventory, 14400
inventory:
	.zero	14400
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
