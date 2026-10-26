	.file	"medical.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d-%m-%Y %H:%M:%S"
	.text
	.p2align 4
	.type	currentDate, @function
currentDate:
.LFB19:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	xorl	%edi, %edi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	time@PLT
	movq	%rsp, %rdi
	movq	%rax, (%rsp)
	call	localtime@PLT
	testq	%rax, %rax
	je	.L7
	movq	%rax, %rcx
	leaq	.LC0(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	je	.L7
.L1:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L9
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.cfi_restore_state
	movb	$0, (%rbx)
	jmp	.L1
.L9:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE19:
	.size	currentDate, .-currentDate
	.section	.rodata.str1.1
.LC1:
	.string	"a"
.LC2:
	.string	"medical.log"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"Warning: unable to open medical.log\n"
	.section	.rodata.str1.1
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
	leaq	.LC1(%rip), %rsi
	movq	%rdi, %r12
	leaq	.LC2(%rip), %rdi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L21
	movq	%rsp, %rbp
	movq	%rax, %rbx
	movq	%rbp, %rdi
	call	currentDate
	xorl	%eax, %eax
	movq	%r12, %r8
	movq	%rbp, %rcx
	leaq	.LC4(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	call	__fprintf_chk@PLT
	testl	%eax, %eax
	js	.L22
.L13:
	movq	%rbx, %rdi
	call	fclose@PLT
	testl	%eax, %eax
	jne	.L23
.L10:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L20
	addq	$32, %rsp
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
.L23:
	.cfi_restore_state
	movq	stderr(%rip), %rdi
	leaq	.LC6(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L22:
	movq	stderr(%rip), %rdi
	leaq	.LC5(%rip), %rdx
	movl	$2, %esi
	xorl	%eax, %eax
	call	__fprintf_chk@PLT
	jmp	.L13
.L21:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L20
	movq	stderr(%rip), %rdi
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	leaq	.LC3(%rip), %rdx
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	movl	$2, %esi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	__fprintf_chk@PLT
.L20:
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
	je	.L27
	xorl	%eax, %eax
	leaq	8(%rsp), %rcx
	leaq	4(%rsp), %rdx
	leaq	3(%rsp), %r9
	leaq	12(%rsp), %r8
	leaq	.LC7(%rip), %rsi
	call	__isoc99_sscanf@PLT
	cmpl	$3, %eax
	je	.L30
.L27:
	xorl	%eax, %eax
.L24:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L31
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L30:
	.cfi_restore_state
	movl	12(%rsp), %edx
	cmpl	$1899, %edx
	jle	.L27
	movl	8(%rsp), %eax
	subl	$1, %eax
	cmpl	$11, %eax
	ja	.L27
	movl	4(%rsp), %ecx
	leal	-1(%rcx), %esi
	cmpl	$30, %esi
	ja	.L27
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
	jne	.L27
	movl	8(%rsp), %eax
	subl	$1, %eax
	cmpl	%eax, 32(%rsp)
	jne	.L27
	movl	4(%rsp), %eax
	cmpl	%eax, 28(%rsp)
	sete	%al
	movzbl	%al, %eax
	jmp	.L24
.L31:
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
	jmp	.L33
	.p2align 4,,10
	.p2align 3
.L40:
	cmpl	$10, %eax
	je	.L32
.L33:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L40
.L32:
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
	jne	.L43
	movl	%eax, %ebx
	jmp	.L42
	.p2align 4,,10
	.p2align 3
.L60:
	cmpl	$10, %eax
	je	.L41
.L42:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	jne	.L60
.L41:
	movl	%ebx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L61:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L47
.L43:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L61
.L47:
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
	je	.L63
	movq	%rbx, %rdi
	call	strlen@PLT
	testq	%rax, %rax
	je	.L66
	leaq	-1(%rbx,%rax), %rax
	cmpb	$10, (%rax)
	jne	.L66
	movb	$0, (%rax)
.L65:
	cmpb	$0, (%rbx)
	movl	$1, %eax
	je	.L82
.L62:
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
.L83:
	.cfi_restore_state
	cmpl	$-1, %eax
	je	.L65
.L66:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$10, %eax
	jne	.L83
	cmpb	$0, (%rbx)
	movl	$1, %eax
	jne	.L62
.L82:
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
.L63:
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
	jle	.L87
	leaq	inventory(%rip), %rdx
	xorl	%eax, %eax
	jmp	.L86
	.p2align 4,,10
	.p2align 3
.L89:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	je	.L87
.L86:
	cmpl	%edi, (%rdx)
	jne	.L89
	ret
	.p2align 4,,10
	.p2align 3
.L87:
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
	movslq	itemCount(%rip), %rax
	cmpl	$99, %eax
	jg	.L116
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	(%rax,%rax,8), %rsi
	leaq	.LC13(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	salq	$4, %rsi
	leaq	inventory(%rip), %rbx
	addq	%rbx, %rsi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	readInt
	testl	%eax, %eax
	je	.L90
	movslq	itemCount(%rip), %rdi
	leaq	(%rdi,%rdi,8), %rax
	movq	%rdi, %rcx
	salq	$4, %rax
	movl	(%rbx,%rax), %esi
	testl	%edi, %edi
	jle	.L94
	movq	%rbx, %rax
	xorl	%edx, %edx
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L117:
	addl	$1, %edx
	addq	$144, %rax
	cmpl	%edx, %ecx
	je	.L94
.L96:
	cmpl	(%rax), %esi
	jne	.L117
	leaq	.LC22(%rip), %rsi
.L115:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L94:
	.cfi_restore_state
	leaq	(%rdi,%rdi,8), %rax
	movl	$50, %edx
	leaq	.LC14(%rip), %rdi
	salq	$4, %rax
	leaq	4(%rbx,%rax), %rsi
	call	readText
	testl	%eax, %eax
	jne	.L118
.L90:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L116:
	.cfi_restore 3
	.cfi_restore 6
	leaq	.LC12(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L118:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movslq	itemCount(%rip), %rax
	movl	$30, %edx
	leaq	.LC15(%rip), %rdi
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	54(%rbx,%rax), %rsi
	call	readText
	testl	%eax, %eax
	je	.L90
	movslq	itemCount(%rip), %rax
	leaq	.LC16(%rip), %rdi
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	84(%rbx,%rax), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L90
	movslq	itemCount(%rip), %rax
	leaq	.LC17(%rip), %rsi
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	movl	84(%rbx,%rax), %edx
	testl	%edx, %edx
	js	.L115
	leaq	88(%rbx,%rax), %rsi
	movl	$15, %edx
	leaq	.LC18(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L90
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	88(%rbx,%rax), %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L119
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	103(%rbx,%rax), %rdi
	call	currentDate
	movslq	itemCount(%rip), %rax
	movl	$14400, %esi
	movq	$-123, %rcx
	leaq	(%rax,%rax,8), %rdx
	movq	%rax, %rbp
	salq	$4, %rdx
	leaq	123(%rdx), %rax
	subq	%rdx, %rcx
	cmpq	%rsi, %rax
	leaq	(%rbx,%rax), %rdi
	cmovnb	%rax, %rsi
	addl	$1, %ebp
	addq	%rsi, %rcx
	leaq	103(%rbx,%rdx), %rsi
	movl	$20, %edx
	call	__memcpy_chk@PLT
	leaq	.LC20(%rip), %rdi
	movl	%ebp, itemCount(%rip)
	call	logEvent
	movl	itemCount(%rip), %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	leaq	.LC21(%rip), %rsi
	movl	$2, %edi
	subl	$1, %eax
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	103(%rbx,%rax), %rdx
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
.L119:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	leaq	.LC19(%rip), %rsi
	movl	$2, %edi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
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
	je	.L130
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
	jle	.L120
	.p2align 4,,10
	.p2align 3
.L124:
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
	jl	.L124
.L120:
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
.L130:
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
	leaq	.LC13(%rip), %rdi
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
	leaq	4(%rsp), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L131
	movl	itemCount(%rip), %ecx
	movl	4(%rsp), %esi
	testl	%ecx, %ecx
	jle	.L133
	leaq	inventory(%rip), %rbp
	xorl	%eax, %eax
	movq	%rbp, %rdx
	jmp	.L135
	.p2align 4,,10
	.p2align 3
.L143:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	je	.L133
.L135:
	cmpl	(%rdx), %esi
	jne	.L143
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
.L131:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L144
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
.L133:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L131
.L144:
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
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC13(%rip), %rdi
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
	movq	%rsp, %rsi
	call	readInt
	testl	%eax, %eax
	je	.L145
	movl	itemCount(%rip), %edx
	movl	(%rsp), %ecx
	testl	%edx, %edx
	jle	.L147
	leaq	inventory(%rip), %rbp
	xorl	%ebx, %ebx
	movq	%rbp, %rax
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L168:
	addl	$1, %ebx
	addq	$144, %rax
	cmpl	%edx, %ebx
	je	.L147
.L149:
	cmpl	(%rax), %ecx
	jne	.L168
	leaq	4(%rsp), %rsi
	leaq	.LC37(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L145
	movl	4(%rsp), %eax
	testl	%eax, %eax
	js	.L169
	movslq	%ebx, %rbx
	movl	$15, %edx
	leaq	.LC34(%rip), %rdi
	leaq	(%rbx,%rbx,8), %rbx
	salq	$4, %rbx
	leaq	88(%rbp,%rbx), %r12
	movq	%r12, %rsi
	call	readText
	testl	%eax, %eax
	jne	.L170
	.p2align 4,,10
	.p2align 3
.L145:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L171
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
.L170:
	.cfi_restore_state
	movq	%r12, %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L172
	movl	4(%rsp), %eax
	leaq	123(%rbp,%rbx), %rdi
	movl	%eax, 84(%rbp,%rbx)
	call	currentDate
	leaq	.LC35(%rip), %rdi
	call	logEvent
	leaq	.LC36(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L147:
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L145
	.p2align 4,,10
	.p2align 3
.L169:
	leaq	.LC17(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L145
.L172:
	leaq	.LC19(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	jmp	.L145
.L171:
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
	leaq	.LC13(%rip), %rdi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L173
	movl	itemCount(%rip), %ecx
	movl	4(%rsp), %esi
	testl	%ecx, %ecx
	jle	.L175
	leaq	inventory(%rip), %rdi
	xorl	%eax, %eax
	movq	%rdi, %rdx
	jmp	.L177
	.p2align 4,,10
	.p2align 3
.L187:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	je	.L175
.L177:
	cmpl	(%rdx), %esi
	jne	.L187
	leal	-1(%rcx), %ebx
	cmpl	%eax, %ebx
	jle	.L180
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
.L180:
	leaq	.LC38(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	movl	%ebx, itemCount(%rip)
	call	__printf_chk@PLT
.L173:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L188
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
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
	jmp	.L173
.L188:
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	.LC13(%rip), %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rsi
	call	readInt
	testl	%eax, %eax
	je	.L189
	movl	itemCount(%rip), %edx
	movl	(%rsp), %ecx
	testl	%edx, %edx
	jle	.L191
	leaq	inventory(%rip), %rbp
	xorl	%ebx, %ebx
	movq	%rbp, %rax
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L209:
	addl	$1, %ebx
	addq	$144, %rax
	cmpl	%edx, %ebx
	je	.L191
.L193:
	cmpl	(%rax), %ecx
	jne	.L209
	leaq	4(%rsp), %rsi
	leaq	.LC43(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L189
	movl	4(%rsp), %eax
	testl	%eax, %eax
	jle	.L210
	movslq	%ebx, %rbx
	movl	$2147483647, %ecx
	leaq	(%rbx,%rbx,8), %rdx
	salq	$4, %rdx
	leaq	0(%rbp,%rdx), %rsi
	movl	84(%rsi), %edi
	subl	%edi, %ecx
	cmpl	%ecx, %eax
	jg	.L211
	addl	%edi, %eax
	leaq	123(%rbp,%rdx), %rdi
	movl	%eax, 84(%rsi)
	call	currentDate
	leaq	.LC41(%rip), %rdi
	call	logEvent
	leaq	.LC42(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L189:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L212
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L211:
	.cfi_restore_state
	leaq	.LC40(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L189
	.p2align 4,,10
	.p2align 3
.L191:
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L189
.L210:
	leaq	.LC39(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L189
.L212:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	receiveStock, .-receiveStock
	.section	.rodata.str1.1
.LC44:
	.string	"\n----- LOW STOCK ITEMS -----\n"
.LC45:
	.string	"%d - %s (Qty: %d)\n"
.LC46:
	.string	"No Low Stock Items.\n"
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
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	__printf_chk@PLT
	movl	itemCount(%rip), %eax
	testl	%eax, %eax
	jle	.L214
	leaq	4+inventory(%rip), %rbx
	xorl	%edx, %edx
	xorl	%ebp, %ebp
	leaq	.LC45(%rip), %r12
	jmp	.L216
	.p2align 4,,10
	.p2align 3
.L215:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, itemCount(%rip)
	jle	.L224
.L216:
	movl	80(%rbx), %r8d
	leal	-1(%r8), %eax
	cmpl	$9, %eax
	ja	.L215
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	$1, %edx
	jmp	.L215
	.p2align 4,,10
	.p2align 3
.L224:
	testl	%edx, %edx
	je	.L214
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
.L214:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	.LC46(%rip), %rsi
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
	.string	"%d - %s\n"
.LC49:
	.string	"No Out Of Stock Items.\n"
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
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	__printf_chk@PLT
	movl	itemCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L226
	leaq	4+inventory(%rip), %rbx
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	leaq	.LC48(%rip), %r12
	jmp	.L228
	.p2align 4,,10
	.p2align 3
.L227:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, itemCount(%rip)
	jle	.L236
.L228:
	movl	80(%rbx), %edx
	testl	%edx, %edx
	jne	.L227
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L227
	.p2align 4,,10
	.p2align 3
.L236:
	testl	%eax, %eax
	je	.L226
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
.L226:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	.LC49(%rip), %rsi
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
	movslq	requestCount(%rip), %rax
	cmpl	$99, %eax
	jg	.L260
	movq	%rax, %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	requests(%rip), %rbx
	leaq	.LC51(%rip), %rdi
	salq	$5, %rdx
	subq	%rax, %rdx
	leaq	(%rbx,%rdx,4), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L237
	movslq	requestCount(%rip), %rsi
	testl	%esi, %esi
	jle	.L241
	movq	%rsi, %rax
	salq	$5, %rax
	subq	%rsi, %rax
	leaq	(%rbx,%rax,4), %rdx
	movq	%rbx, %rax
	movl	(%rdx), %ecx
	jmp	.L243
	.p2align 4,,10
	.p2align 3
.L242:
	addq	$124, %rax
	cmpq	%rdx, %rax
	je	.L241
.L243:
	cmpl	%ecx, (%rax)
	jne	.L242
	leaq	.LC52(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L241:
	.cfi_restore_state
	movq	%rsi, %rax
	leaq	.LC13(%rip), %rdi
	salq	$5, %rax
	subq	%rsi, %rax
	leaq	4(%rbx,%rax,4), %rsi
	call	readInt
	testl	%eax, %eax
	jne	.L261
.L237:
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L260:
	.cfi_restore 3
	leaq	.LC50(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	jmp	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L261:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movslq	requestCount(%rip), %rdx
	leaq	.LC53(%rip), %rdi
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	8(%rbx,%rax,4), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L237
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	0(,%rax,4), %rdx
	movl	8(%rbx,%rax,4), %eax
	testl	%eax, %eax
	jle	.L262
	leaq	12(%rbx,%rdx), %rsi
	leaq	.LC54(%rip), %rdi
	movl	$50, %edx
	call	readText
	testl	%eax, %eax
	je	.L237
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	82(%rbx,%rax,4), %rdi
	call	currentDate
	movslq	requestCount(%rip), %rdx
	movabsq	$29113321536775504, %rdi
	addl	$1, requestCount(%rip)
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	salq	$2, %rax
	movq	%rdi, 62(%rbx,%rax)
	leaq	.LC55(%rip), %rdi
	movb	$0, 102(%rbx,%rax)
	call	logEvent
	leaq	.LC56(%rip), %rsi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	movl	$2, %edi
	jmp	__printf_chk@PLT
.L262:
	.cfi_restore_state
	leaq	.LC39(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	leaq	.LC51(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	call	readInt
	testl	%eax, %eax
	je	.L263
	movl	requestCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L265
	leaq	requests(%rip), %r8
	movl	4(%rsp), %esi
	xorl	%eax, %eax
	movq	%r8, %rdx
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L266:
	addl	$1, %eax
	addq	$124, %rdx
	cmpl	%ecx, %eax
	je	.L265
.L270:
	cmpl	%esi, (%rdx)
	jne	.L266
	cltq
	movl	itemCount(%rip), %esi
	movq	%rax, %rdx
	salq	$5, %rdx
	subq	%rax, %rdx
	movl	4(%r8,%rdx,4), %edi
	testl	%esi, %esi
	jle	.L267
	leaq	inventory(%rip), %r9
	xorl	%edx, %edx
	movq	%r9, %rcx
	jmp	.L269
	.p2align 4,,10
	.p2align 3
.L282:
	addl	$1, %edx
	addq	$144, %rcx
	cmpl	%esi, %edx
	je	.L267
.L269:
	cmpl	(%rcx), %edi
	jne	.L282
	movq	%rax, %rcx
	movslq	%edx, %rdx
	salq	$5, %rcx
	leaq	(%rdx,%rdx,8), %rdx
	subq	%rax, %rcx
	salq	$4, %rdx
	leaq	0(,%rcx,4), %rax
	leaq	62(%r8,%rax), %rcx
	leaq	102(%r8,%rax), %rdi
	movl	8(%r8,%rax), %eax
	cmpl	%eax, 84(%r9,%rdx)
	jl	.L283
	movabsq	$7234318597473988673, %rax
	movb	$0, 8(%rcx)
	movq	%rax, (%rcx)
	call	currentDate
	leaq	.LC59(%rip), %rdi
	call	logEvent
	leaq	.LC60(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L263:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L284
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L265:
	.cfi_restore_state
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L263
	.p2align 4,,10
	.p2align 3
.L283:
	movabsq	$7234316346692625746, %rax
	movb	$0, 8(%rcx)
	movq	%rax, (%rcx)
	call	currentDate
	leaq	.LC61(%rip), %rdi
	call	logEvent
	leaq	.LC62(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L263
	.p2align 4,,10
	.p2align 3
.L267:
	movabsq	$7234316346692625746, %rdi
	movq	%rax, %rdx
	salq	$5, %rdx
	subq	%rax, %rdx
	leaq	0(,%rdx,4), %rax
	leaq	62(%r8,%rax), %rdx
	movq	%rdi, (%rdx)
	leaq	102(%r8,%rax), %rdi
	movb	$0, 8(%rdx)
	call	currentDate
	leaq	.LC57(%rip), %rdi
	call	logEvent
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L263
.L284:
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
	jle	.L285
	leaq	12+requests(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	.LC65(%rip), %r15
	leaq	.LC66(%rip), %r14
	leaq	.LC67(%rip), %r13
	leaq	.LC68(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L287:
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
	jg	.L287
.L285:
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpl	$99, distributionCount(%rip)
	jg	.L315
	leaq	4(%rsp), %rsi
	leaq	.LC73(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L292
	movl	requestCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L296
	leaq	requests(%rip), %r12
	movl	4(%rsp), %esi
	xorl	%eax, %eax
	movq	%r12, %rdx
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L297:
	addl	$1, %eax
	addq	$124, %rdx
	cmpl	%ecx, %eax
	je	.L296
.L302:
	cmpl	%esi, (%rdx)
	jne	.L297
	movslq	%eax, %rbx
	leaq	.LC74(%rip), %rsi
	movq	%rbx, %r13
	salq	$5, %r13
	subq	%rbx, %r13
	salq	$2, %r13
	leaq	62(%r12,%r13), %rbp
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L316
	movl	itemCount(%rip), %ecx
	movl	4(%r12,%r13), %esi
	testl	%ecx, %ecx
	jle	.L299
	leaq	inventory(%rip), %rdi
	movq	%rdi, %rdx
	jmp	.L301
	.p2align 4,,10
	.p2align 3
.L317:
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%eax, %ecx
	je	.L299
.L301:
	cmpl	(%rdx), %esi
	jne	.L317
	movq	%rbx, %rdx
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$5, %rdx
	subq	%rbx, %rdx
	salq	$4, %rax
	leaq	(%rdi,%rax), %r8
	leaq	(%r12,%rdx,4), %rbx
	movl	84(%r8), %ecx
	movl	8(%rbx), %edx
	cmpl	%edx, %ecx
	jge	.L318
	leaq	.LC76(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L292:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L314
	addq	$24, %rsp
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
.L315:
	.cfi_restore_state
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L314
	addq	$24, %rsp
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
.L296:
	.cfi_restore_state
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L318:
	subl	%edx, %ecx
	movd	%esi, %xmm1
	leaq	distributions(%rip), %r14
	movl	$50, %esi
	movl	%ecx, 84(%r8)
	movslq	distributionCount(%rip), %r8
	leaq	.LC8(%rip), %r15
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
	movq	%xmm0, (%r14,%rdx)
	leaq	8(%r14,%rdx), %rdi
	movq	%r15, %rdx
	call	snprintf@PLT
	leaq	12(%r12,%r13), %rcx
	movl	$50, %esi
	movslq	distributionCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$4, %rax
	addq	%rdx, %rax
	movl	8(%rbx), %edx
	salq	$3, %rax
	movl	%edx, 60(%r14,%rax)
	leaq	64(%r14,%rax), %rdi
	movq	%r15, %rdx
	xorl	%eax, %eax
	call	snprintf@PLT
	movslq	distributionCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$4, %rax
	addq	%rdx, %rax
	leaq	114(%r14,%rax,8), %rdi
	call	currentDate
	movl	$6579572, 8(%rbp)
	movabsq	$8458438990456121668, %rax
	leaq	.LC77(%rip), %rdi
	movq	%rax, 0(%rbp)
	addl	$1, distributionCount(%rip)
	call	logEvent
	leaq	.LC78(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L316:
	leaq	.LC75(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L292
	.p2align 4,,10
	.p2align 3
.L299:
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L292
.L314:
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
	jle	.L319
	leaq	8+distributions(%rip), %rbx
	xorl	%ebp, %ebp
	leaq	.LC80(%rip), %r15
	leaq	.LC81(%rip), %r14
	leaq	.LC82(%rip), %r13
	leaq	.LC83(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L321:
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
	jg	.L321
.L319:
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
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	.L331(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	.LC86(%rip), %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %r12
	.p2align 4,,10
	.p2align 3
.L328:
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
	leaq	.LC90(%rip), %rsi
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
	movq	%r12, %rsi
	leaq	.LC103(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L328
	cmpl	$14, 4(%rsp)
	ja	.L329
	movl	4(%rsp), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L331:
	.long	.L329-.L331
	.long	.L344-.L331
	.long	.L343-.L331
	.long	.L342-.L331
	.long	.L341-.L331
	.long	.L340-.L331
	.long	.L339-.L331
	.long	.L338-.L331
	.long	.L337-.L331
	.long	.L336-.L331
	.long	.L335-.L331
	.long	.L334-.L331
	.long	.L333-.L331
	.long	.L332-.L331
	.long	.L330-.L331
	.section	.text.startup
	.p2align 4,,10
	.p2align 3
.L330:
	xorl	%eax, %eax
	leaq	.LC104(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L351
	addq	$24, %rsp
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
.L332:
	.cfi_restore_state
	call	viewDistributionHistory
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L333:
	call	distributeSupply
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L334:
	call	viewRequests
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L335:
	call	processRequest
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L336:
	call	createRequest
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L337:
	call	outOfStockItems
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L338:
	call	lowStockItems
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L339:
	call	receiveStock
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L340:
	call	deleteItem
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L341:
	call	updateItem
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L342:
	call	searchItem
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L343:
	call	viewInventory
	jmp	.L328
	.p2align 4,,10
	.p2align 3
.L344:
	call	addItem
	jmp	.L328
.L329:
	leaq	.LC105(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L328
.L351:
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
