	.file	"medical.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d-%m-%Y %H:%M:%S"
	.text
	.type	currentDate, @function
currentDate:
.LFB19:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movl	$0, %edi
	call	time@PLT
	movq	%rax, (%rsp)
	movq	%rsp, %rdi
	call	localtime@PLT
	testq	%rax, %rax
	je	.L7
	movq	%rax, %rcx
	leaq	.LC0(%rip), %rdx
	movl	$20, %esi
	movq	%rbx, %rdi
	call	strftime@PLT
	testq	%rax, %rax
	jne	.L1
	movb	$0, (%rbx)
.L1:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L8
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	movb	$0, (%rbx)
	jmp	.L1
.L8:
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
	.type	logEvent, @function
logEvent:
.LFB20:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %r12
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	fopen@PLT
	testq	%rax, %rax
	je	.L16
	movq	%rax, %rbx
	movq	%rsp, %rbp
	movq	%rbp, %rdi
	call	currentDate
	movq	%r12, %r8
	movq	%rbp, %rcx
	leaq	.LC4(%rip), %rdx
	movl	$2, %esi
	movq	%rbx, %rdi
	movl	$0, %eax
	call	__fprintf_chk@PLT
	testl	%eax, %eax
	js	.L17
.L12:
	movq	%rbx, %rdi
	call	fclose@PLT
	testl	%eax, %eax
	jne	.L18
.L9:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L19
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
.L16:
	.cfi_restore_state
	leaq	.LC3(%rip), %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	__fprintf_chk@PLT
	jmp	.L9
.L17:
	leaq	.LC5(%rip), %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	__fprintf_chk@PLT
	jmp	.L12
.L18:
	leaq	.LC6(%rip), %rdx
	movl	$2, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	__fprintf_chk@PLT
	jmp	.L9
.L19:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE20:
	.size	logEvent, .-logEvent
	.section	.rodata.str1.1
.LC7:
	.string	"%2d/%2d/%4d%c"
	.text
	.globl	validateDate
	.type	validateDate, @function
validateDate:
.LFB21:
	.cfi_startproc
	endbr64
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movaps	%xmm0, 16(%rsp)
	movaps	%xmm0, 32(%rsp)
	movaps	%xmm0, 48(%rsp)
	movq	$0, 64(%rsp)
	testq	%rdi, %rdi
	je	.L20
	leaq	8(%rsp), %rcx
	leaq	4(%rsp), %rdx
	leaq	3(%rsp), %r9
	leaq	12(%rsp), %r8
	leaq	.LC7(%rip), %rsi
	call	__isoc99_sscanf@PLT
	movl	%eax, %edx
	movl	$0, %eax
	cmpl	$3, %edx
	jne	.L20
	movl	12(%rsp), %edx
	cmpl	$1899, %edx
	jle	.L20
	movl	8(%rsp), %ecx
	leal	-1(%rcx), %esi
	cmpl	$11, %esi
	jbe	.L31
.L20:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L32
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L31:
	.cfi_restore_state
	movl	4(%rsp), %esi
	leal	-1(%rsi), %edi
	cmpl	$30, %edi
	ja	.L20
	subl	$1900, %edx
	movl	%edx, 36(%rsp)
	subl	$1, %ecx
	movl	%ecx, 32(%rsp)
	movl	%esi, 28(%rsp)
	movl	$-1, 48(%rsp)
	leaq	16(%rsp), %rdi
	call	mktime@PLT
	movl	12(%rsp), %eax
	leal	-1900(%rax), %edx
	movl	$0, %eax
	cmpl	%edx, 36(%rsp)
	jne	.L20
	movl	8(%rsp), %eax
	leal	-1(%rax), %edx
	movl	$0, %eax
	cmpl	%edx, 32(%rsp)
	jne	.L20
	movl	4(%rsp), %eax
	cmpl	%eax, 28(%rsp)
	sete	%al
	movzbl	%al, %eax
	jmp	.L20
.L32:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
	.size	validateDate, .-validateDate
	.globl	discardInput
	.type	discardInput, @function
discardInput:
.LFB22:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
.L34:
	movq	stdin(%rip), %rdi
	call	getc@PLT
	cmpl	$-1, %eax
	je	.L33
	cmpl	$10, %eax
	jne	.L34
.L33:
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
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rsi
	leaq	.LC9(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	cmpl	$1, %eax
	je	.L39
	movl	$0, %eax
	call	discardInput
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$0, %ebx
.L38:
	movl	%ebx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L39:
	.cfi_restore_state
	movl	%eax, %ebx
	movl	$0, %eax
	call	discardInput
	jmp	.L38
	.cfi_endproc
.LFE23:
	.size	readInt, .-readInt
	.section	.rodata.str1.1
.LC11:
	.string	"Value cannot be empty.\n"
	.text
	.globl	readText
	.type	readText, @function
readText:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rbx
	movl	%edx, %ebp
	movq	%rdi, %rdx
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	stdin(%rip), %rdx
	movl	%ebp, %esi
	movq	%rbx, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	je	.L46
	movq	%rbx, %rdi
	call	strlen@PLT
	testq	%rax, %rax
	je	.L44
	leaq	-1(%rbx,%rax), %rax
	cmpb	$10, (%rax)
	je	.L49
.L44:
	movl	$0, %eax
	call	discardInput
.L45:
	movl	$1, %eax
	cmpb	$0, (%rbx)
	je	.L50
.L42:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L49:
	.cfi_restore_state
	movb	$0, (%rax)
	jmp	.L45
.L50:
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$0, %eax
	jmp	.L42
.L46:
	movl	$0, %eax
	jmp	.L42
	.cfi_endproc
.LFE24:
	.size	readText, .-readText
	.globl	findItem
	.type	findItem, @function
findItem:
.LFB25:
	.cfi_startproc
	endbr64
	movl	itemCount(%rip), %ecx
	testl	%ecx, %ecx
	jle	.L54
	leaq	inventory(%rip), %rdx
	movl	$0, %eax
.L53:
	cmpl	%edi, (%rdx)
	je	.L51
	addl	$1, %eax
	addq	$144, %rdx
	cmpl	%ecx, %eax
	jne	.L53
	movl	$-1, %eax
	ret
.L54:
	movl	$-1, %eax
.L51:
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
	.string	"Item ID already exists!\n"
.LC15:
	.string	"Enter Item Name: "
.LC16:
	.string	"Enter Category: "
.LC17:
	.string	"Enter Quantity: "
.LC18:
	.string	"Quantity cannot be negative!\n"
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"Enter Expiry Date (DD/MM/YYYY): "
	.align 8
.LC20:
	.string	"Invalid date. Use DD/MM/YYYY.\n"
	.section	.rodata.str1.1
.LC21:
	.string	"Inventory item added"
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"Item Added Successfully at %s!\n"
	.text
	.globl	addItem
	.type	addItem, @function
addItem:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	itemCount(%rip), %eax
	cmpl	$99, %eax
	jg	.L63
	cltq
	leaq	(%rax,%rax,8), %rsi
	salq	$4, %rsi
	leaq	inventory(%rip), %rax
	addq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L56
	movl	itemCount(%rip), %ebx
	movslq	%ebx, %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	movl	(%rdx,%rax), %edi
	call	findItem
	cmpl	$-1, %eax
	je	.L59
	leaq	.LC14(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L56
.L63:
	leaq	.LC12(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L56:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L59:
	.cfi_restore_state
	movslq	%ebx, %rbx
	leaq	(%rbx,%rbx,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	leaq	4(%rdx,%rax), %rsi
	movl	$50, %edx
	leaq	.LC15(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L56
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	leaq	54(%rdx,%rax), %rsi
	movl	$30, %edx
	leaq	.LC16(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L56
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	leaq	84(%rdx,%rax), %rsi
	leaq	.LC17(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L56
	movl	itemCount(%rip), %eax
	movslq	%eax, %rdx
	leaq	(%rdx,%rdx,8), %rdx
	salq	$4, %rdx
	leaq	inventory(%rip), %rcx
	cmpl	$0, 84(%rcx,%rdx)
	js	.L64
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	leaq	88(%rdx,%rax), %rsi
	movl	$15, %edx
	leaq	.LC19(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L56
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rdx
	leaq	88(%rdx,%rax), %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L65
	movslq	itemCount(%rip), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	inventory(%rip), %rbx
	leaq	103(%rbx,%rax), %rdi
	call	currentDate
	movl	itemCount(%rip), %ebp
	movslq	%ebp, %rax
	leaq	(%rax,%rax,8), %rdx
	salq	$4, %rdx
	leaq	123(%rdx), %rax
	movq	$-123, %rcx
	subq	%rdx, %rcx
	movl	$14400, %esi
	cmpq	%rsi, %rax
	cmovnb	%rax, %rsi
	addq	%rsi, %rcx
	leaq	103(%rbx,%rdx), %rsi
	leaq	(%rax,%rbx), %rdi
	movl	$20, %edx
	call	__memcpy_chk@PLT
	addl	$1, %ebp
	movl	%ebp, itemCount(%rip)
	leaq	.LC21(%rip), %rdi
	call	logEvent
	movl	itemCount(%rip), %eax
	subl	$1, %eax
	cltq
	leaq	(%rax,%rax,8), %rax
	salq	$4, %rax
	leaq	103(%rbx,%rax), %rdx
	leaq	.LC22(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L56
.L64:
	leaq	.LC18(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L56
.L65:
	leaq	.LC20(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	jmp	.L56
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
	.globl	viewInventory
	.type	viewInventory, @function
viewInventory:
.LFB27:
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	cmpl	$0, itemCount(%rip)
	je	.L72
	leaq	.LC24(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpl	$0, itemCount(%rip)
	jle	.L66
	leaq	4+inventory(%rip), %rbx
	movl	$0, %ebp
	leaq	.LC25(%rip), %r15
	leaq	.LC26(%rip), %r14
	leaq	.LC27(%rip), %r13
	leaq	.LC28(%rip), %r12
.L69:
	movl	-4(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r14, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	50(%rbx), %rdx
	movq	%r13, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	80(%rbx), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	84(%rbx), %rdx
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	99(%rbx), %rdx
	leaq	.LC30(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	119(%rbx), %rdx
	leaq	.LC31(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, itemCount(%rip)
	jg	.L69
.L66:
	addq	$8, %rsp
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
.L72:
	.cfi_restore_state
	leaq	.LC23(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L66
	.cfi_endproc
.LFE27:
	.size	viewInventory, .-viewInventory
	.section	.rodata.str1.1
.LC32:
	.string	"Item Not Found!\n"
.LC33:
	.string	"\nExpiry Date: %s\n"
	.text
	.globl	searchItem
	.type	searchItem, @function
searchItem:
.LFB28:
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
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L73
	movl	4(%rsp), %edi
	call	findItem
	cmpl	$-1, %eax
	je	.L79
	leaq	inventory(%rip), %r12
	movslq	%eax, %rbx
	leaq	0(,%rbx,8), %rbp
	leaq	0(%rbp,%rbx), %rax
	salq	$4, %rax
	movl	(%r12,%rax), %edx
	leaq	.LC25(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	0(%rbp,%rbx), %r13
	salq	$4, %r13
	leaq	4(%r12,%r13), %rdx
	leaq	.LC26(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	54(%r12,%r13), %rdx
	leaq	.LC27(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	84(%r12,%r13), %edx
	leaq	.LC28(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	88(%r12,%r13), %rdx
	leaq	.LC33(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L73:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L80
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
.L79:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L73
.L80:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE28:
	.size	searchItem, .-searchItem
	.section	.rodata.str1.1
.LC34:
	.string	"Enter New Quantity: "
.LC35:
	.string	"Enter New Expiry Date: "
.LC36:
	.string	"Inventory item updated"
.LC37:
	.string	"Item Updated Successfully!\n"
	.text
	.globl	updateItem
	.type	updateItem, @function
updateItem:
.LFB29:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
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
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L81
	movl	(%rsp), %edi
	call	findItem
	movl	%eax, %ebx
	cmpl	$-1, %eax
	je	.L89
	leaq	4(%rsp), %rsi
	leaq	.LC34(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L81
	cmpl	$0, 4(%rsp)
	js	.L90
	movslq	%ebx, %rax
	leaq	(%rax,%rax,8), %rbp
	salq	$4, %rbp
	leaq	inventory(%rip), %rax
	leaq	88(%rax,%rbp), %r12
	movl	$15, %edx
	movq	%r12, %rsi
	leaq	.LC35(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L81
	movq	%r12, %rdi
	call	validateDate
	testl	%eax, %eax
	je	.L91
	leaq	inventory(%rip), %rdx
	movslq	%ebx, %rbx
	leaq	(%rbx,%rbx,8), %rax
	salq	$4, %rax
	movl	4(%rsp), %ecx
	movl	%ecx, 84(%rdx,%rax)
	leaq	123(%rdx,%rbp), %rdi
	call	currentDate
	leaq	.LC36(%rip), %rdi
	call	logEvent
	leaq	.LC37(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L81
.L89:
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L81:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L92
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
.L90:
	.cfi_restore_state
	leaq	.LC18(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L81
.L91:
	leaq	.LC20(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
	jmp	.L81
.L92:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE29:
	.size	updateItem, .-updateItem
	.section	.rodata.str1.1
.LC38:
	.string	"Item Removed Successfully!\n"
	.text
	.globl	deleteItem
	.type	deleteItem, @function
deleteItem:
.LFB30:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L93
	movl	4(%rsp), %edi
	call	findItem
	cmpl	$-1, %eax
	je	.L95
	movl	itemCount(%rip), %ecx
	leal	-1(%rcx), %edi
	cmpl	%edi, %eax
	jge	.L97
	movslq	%eax, %rsi
	leaq	(%rsi,%rsi,8), %rdx
	salq	$4, %rdx
	leaq	inventory(%rip), %r8
	addq	%r8, %rdx
	subl	$2, %ecx
	subl	%eax, %ecx
	addq	%rsi, %rcx
	leaq	(%rcx,%rcx,8), %rax
	salq	$4, %rax
	leaq	144(%r8), %rcx
	addq	%rcx, %rax
.L98:
	movdqa	144(%rdx), %xmm0
	movaps	%xmm0, (%rdx)
	movdqa	160(%rdx), %xmm1
	movaps	%xmm1, 16(%rdx)
	movdqa	176(%rdx), %xmm2
	movaps	%xmm2, 32(%rdx)
	movdqa	192(%rdx), %xmm3
	movaps	%xmm3, 48(%rdx)
	movdqa	208(%rdx), %xmm4
	movaps	%xmm4, 64(%rdx)
	movdqa	224(%rdx), %xmm5
	movaps	%xmm5, 80(%rdx)
	movdqa	240(%rdx), %xmm6
	movaps	%xmm6, 96(%rdx)
	movdqa	256(%rdx), %xmm7
	movaps	%xmm7, 112(%rdx)
	movdqa	272(%rdx), %xmm0
	movaps	%xmm0, 128(%rdx)
	addq	$144, %rdx
	cmpq	%rax, %rdx
	jne	.L98
.L97:
	movl	%edi, itemCount(%rip)
	leaq	.LC38(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L93:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L103
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L95:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L93
.L103:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE30:
	.size	deleteItem, .-deleteItem
	.section	.rodata.str1.1
.LC39:
	.string	"Enter Quantity Received: "
.LC40:
	.string	"Quantity must be positive!\n"
	.section	.rodata.str1.8
	.align 8
.LC41:
	.string	"Quantity exceeds the supported limit.\n"
	.section	.rodata.str1.1
.LC42:
	.string	"Inventory stock received"
.LC43:
	.string	"Stock Updated Successfully!\n"
	.text
	.globl	receiveStock
	.type	receiveStock, @function
receiveStock:
.LFB31:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rsi
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L104
	movl	(%rsp), %edi
	call	findItem
	movl	%eax, %ebx
	cmpl	$-1, %eax
	je	.L112
	leaq	4(%rsp), %rsi
	leaq	.LC39(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L104
	movl	4(%rsp), %eax
	testl	%eax, %eax
	jle	.L113
	movslq	%ebx, %rdx
	leaq	(%rdx,%rdx,8), %rdx
	salq	$4, %rdx
	leaq	inventory(%rip), %rcx
	movl	84(%rcx,%rdx), %ecx
	movl	$2147483647, %edx
	subl	%ecx, %edx
	cmpl	%edx, %eax
	jg	.L114
	leaq	inventory(%rip), %rdi
	movslq	%ebx, %rbx
	leaq	0(,%rbx,8), %rdx
	leaq	(%rdx,%rbx), %rsi
	salq	$4, %rsi
	addl	%ecx, %eax
	movl	%eax, 84(%rdi,%rsi)
	leaq	123(%rdi,%rsi), %rdi
	call	currentDate
	leaq	.LC42(%rip), %rdi
	call	logEvent
	leaq	.LC43(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L104:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L115
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L112:
	.cfi_restore_state
	leaq	.LC32(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L104
.L113:
	leaq	.LC40(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L104
.L114:
	leaq	.LC41(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L104
.L115:
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
	.globl	lowStockItems
	.type	lowStockItems, @function
lowStockItems:
.LFB32:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	leaq	.LC44(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpl	$0, itemCount(%rip)
	jle	.L117
	leaq	4+inventory(%rip), %rbx
	movl	$0, %edx
	movl	$0, %ebp
	leaq	.LC45(%rip), %r12
	jmp	.L119
.L118:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, itemCount(%rip)
	jle	.L123
.L119:
	movl	80(%rbx), %r8d
	leal	-1(%r8), %eax
	cmpl	$9, %eax
	ja	.L118
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$1, %edx
	jmp	.L118
.L123:
	testl	%edx, %edx
	je	.L117
.L116:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L117:
	.cfi_restore_state
	leaq	.LC46(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L116
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
	.globl	outOfStockItems
	.type	outOfStockItems, @function
outOfStockItems:
.LFB33:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	leaq	.LC47(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpl	$0, itemCount(%rip)
	jle	.L125
	leaq	4+inventory(%rip), %rbx
	movl	$0, %eax
	movl	$0, %ebp
	leaq	.LC48(%rip), %r12
	jmp	.L127
.L126:
	addl	$1, %ebp
	addq	$144, %rbx
	cmpl	%ebp, itemCount(%rip)
	jle	.L131
.L127:
	cmpl	$0, 80(%rbx)
	jne	.L126
	movl	-4(%rbx), %edx
	movq	%rbx, %rcx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L126
.L131:
	testl	%eax, %eax
	je	.L125
.L124:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L125:
	.cfi_restore_state
	leaq	.LC49(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L124
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
	.globl	createRequest
	.type	createRequest, @function
createRequest:
.LFB34:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	requestCount(%rip), %eax
	cmpl	$99, %eax
	jg	.L141
	cltq
	movq	%rax, %rdx
	salq	$5, %rdx
	subq	%rax, %rdx
	leaq	requests(%rip), %rax
	leaq	(%rax,%rdx,4), %rsi
	leaq	.LC51(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L132
	movl	requestCount(%rip), %esi
	testl	%esi, %esi
	jle	.L135
	leaq	requests(%rip), %rdi
	movslq	%esi, %r8
	movq	%r8, %rcx
	salq	$5, %rcx
	movq	%rcx, %rax
	subq	%r8, %rax
	movl	(%rdi,%rax,4), %edx
	movq	%rdi, %rax
	subq	%r8, %rcx
	leaq	(%rdi,%rcx,4), %rcx
.L137:
	cmpl	%edx, (%rax)
	je	.L142
	addq	$124, %rax
	cmpq	%rcx, %rax
	jne	.L137
.L135:
	movslq	%esi, %rsi
	movq	%rsi, %rax
	salq	$5, %rax
	subq	%rsi, %rax
	leaq	requests(%rip), %rdx
	leaq	4(%rdx,%rax,4), %rsi
	leaq	.LC13(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L132
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	requests(%rip), %rdx
	leaq	8(%rdx,%rax,4), %rsi
	leaq	.LC53(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L132
	movl	requestCount(%rip), %eax
	movslq	%eax, %rcx
	movq	%rcx, %rdx
	salq	$5, %rdx
	subq	%rcx, %rdx
	leaq	requests(%rip), %rcx
	cmpl	$0, 8(%rcx,%rdx,4)
	jle	.L143
	cltq
	movq	%rax, %rdx
	salq	$5, %rdx
	subq	%rax, %rdx
	leaq	requests(%rip), %rax
	leaq	12(%rax,%rdx,4), %rsi
	movl	$50, %edx
	leaq	.LC54(%rip), %rdi
	call	readText
	testl	%eax, %eax
	je	.L132
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	requests(%rip), %rbx
	leaq	82(%rbx,%rax,4), %rdi
	call	currentDate
	movslq	requestCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	movq	%rax, %rcx
	subq	%rdx, %rcx
	movb	$0, 102(%rbx,%rcx,4)
	movabsq	$29113321536775504, %rdi
	movq	%rdi, 62(%rbx,%rcx,4)
	addl	$1, requestCount(%rip)
	leaq	.LC55(%rip), %rdi
	call	logEvent
	leaq	.LC56(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L132
.L141:
	leaq	.LC50(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L132:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L142:
	.cfi_restore_state
	leaq	.LC52(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L132
.L143:
	leaq	.LC40(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L132
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
	.globl	processRequest
	.type	processRequest, @function
processRequest:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	leaq	.LC51(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L144
	movl	requestCount(%rip), %edx
	testl	%edx, %edx
	jle	.L146
	movl	4(%rsp), %ecx
	leaq	requests(%rip), %rax
	movl	$0, %ebx
.L150:
	cmpl	%ecx, (%rax)
	je	.L155
	addl	$1, %ebx
	addq	$124, %rax
	cmpl	%edx, %ebx
	jne	.L150
.L146:
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L144:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L156
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L155:
	.cfi_restore_state
	movslq	%ebx, %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	requests(%rip), %rdx
	movl	4(%rdx,%rax,4), %edi
	call	findItem
	cmpl	$-1, %eax
	je	.L157
	cltq
	leaq	(%rax,%rax,8), %rdx
	salq	$4, %rdx
	movslq	%ebx, %rcx
	movq	%rcx, %rax
	salq	$5, %rax
	subq	%rcx, %rax
	leaq	inventory(%rip), %rsi
	leaq	requests(%rip), %rcx
	movl	8(%rcx,%rax,4), %eax
	cmpl	%eax, 84(%rsi,%rdx)
	jl	.L149
	movslq	%ebx, %rbx
	movq	%rbx, %rax
	salq	$5, %rax
	subq	%rbx, %rax
	salq	$2, %rax
	movq	%rcx, %rdx
	leaq	62(%rcx,%rax), %rcx
	movabsq	$7234318597473988673, %rsi
	movq	%rsi, (%rcx)
	movb	$0, 8(%rcx)
	leaq	102(%rdx,%rax), %rdi
	call	currentDate
	leaq	.LC59(%rip), %rdi
	call	logEvent
	leaq	.LC60(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L144
.L157:
	movslq	%ebx, %rbx
	movq	%rbx, %rax
	salq	$5, %rax
	subq	%rbx, %rax
	salq	$2, %rax
	leaq	requests(%rip), %rdx
	leaq	62(%rdx,%rax), %rcx
	movabsq	$7234316346692625746, %rsi
	movq	%rsi, (%rcx)
	movb	$0, 8(%rcx)
	leaq	102(%rdx,%rax), %rdi
	call	currentDate
	leaq	.LC57(%rip), %rdi
	call	logEvent
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L144
.L149:
	movslq	%ebx, %rbx
	movq	%rbx, %rax
	salq	$5, %rax
	subq	%rbx, %rax
	salq	$2, %rax
	leaq	requests(%rip), %rdx
	leaq	62(%rdx,%rax), %rcx
	movabsq	$7234316346692625746, %rsi
	movq	%rsi, (%rcx)
	movb	$0, 8(%rcx)
	leaq	102(%rdx,%rax), %rdi
	call	currentDate
	leaq	.LC61(%rip), %rdi
	call	logEvent
	leaq	.LC62(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L144
.L156:
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
	.globl	viewRequests
	.type	viewRequests, @function
viewRequests:
.LFB36:
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	leaq	.LC64(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpl	$0, requestCount(%rip)
	jle	.L158
	leaq	12+requests(%rip), %rbx
	movl	$0, %ebp
	leaq	.LC65(%rip), %r15
	leaq	.LC66(%rip), %r14
	leaq	.LC67(%rip), %r13
	leaq	.LC68(%rip), %r12
.L160:
	movl	-12(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	-8(%rbx), %edx
	movq	%r14, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	-4(%rbx), %edx
	movq	%r13, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	50(%rbx), %rdx
	leaq	.LC69(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	70(%rbx), %rdx
	leaq	.LC70(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	90(%rbx), %rdx
	leaq	.LC71(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addl	$1, %ebp
	addq	$124, %rbx
	cmpl	%ebp, requestCount(%rip)
	jg	.L160
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
	.globl	distributeSupply
	.type	distributeSupply, @function
distributeSupply:
.LFB37:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpl	$99, distributionCount(%rip)
	jg	.L176
	leaq	4(%rsp), %rsi
	leaq	.LC73(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L163
	movl	requestCount(%rip), %edx
	testl	%edx, %edx
	jle	.L166
	movl	4(%rsp), %ecx
	leaq	requests(%rip), %rax
	movl	$0, %ebx
.L171:
	cmpl	%ecx, (%rax)
	je	.L177
	addl	$1, %ebx
	addq	$124, %rax
	cmpl	%edx, %ebx
	jne	.L171
.L166:
	leaq	.LC63(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L163
.L176:
	leaq	.LC72(%rip), %rsi
	movl	$2, %edi
	call	__printf_chk@PLT
.L163:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L178
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L177:
	.cfi_restore_state
	movslq	%ebx, %rax
	movq	%rax, %rbp
	salq	$5, %rbp
	subq	%rax, %rbp
	salq	$2, %rbp
	leaq	requests(%rip), %rax
	leaq	62(%rax,%rbp), %r12
	leaq	.LC74(%rip), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L179
	movslq	%ebx, %rdx
	movq	%rdx, %rax
	salq	$5, %rax
	subq	%rdx, %rax
	leaq	requests(%rip), %rdx
	movl	4(%rdx,%rax,4), %r13d
	movl	%r13d, %edi
	call	findItem
	cmpl	$-1, %eax
	je	.L180
	movslq	%eax, %rdx
	leaq	(%rdx,%rdx,8), %rdx
	salq	$4, %rdx
	leaq	inventory(%rip), %rcx
	movl	84(%rcx,%rdx), %esi
	movslq	%ebx, %rcx
	movq	%rcx, %rdx
	salq	$5, %rdx
	subq	%rcx, %rdx
	leaq	requests(%rip), %rcx
	movl	8(%rcx,%rdx,4), %ecx
	cmpl	%ecx, %esi
	jge	.L170
	leaq	.LC76(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L163
.L179:
	leaq	.LC75(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L163
.L180:
	leaq	.LC58(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L163
.L170:
	leaq	inventory(%rip), %rdi
	movslq	%eax, %r8
	leaq	0(,%r8,8), %rax
	leaq	(%rax,%r8), %r9
	salq	$4, %r9
	subl	%ecx, %esi
	movl	%esi, 84(%rdi,%r9)
	movl	distributionCount(%rip), %esi
	leaq	distributions(%rip), %r14
	movslq	%esi, %rcx
	movq	%rcx, %rdx
	salq	$4, %rdx
	leaq	(%rdx,%rcx), %r9
	addl	$1, %esi
	movl	%esi, (%r14,%r9,8)
	movl	%r13d, 4(%r14,%r9,8)
	addq	%r8, %rax
	salq	$4, %rax
	leaq	4(%rdi,%rax), %rax
	leaq	8(%r14,%r9,8), %rdi
	movq	%rax, %rcx
	leaq	.LC8(%rip), %r13
	movq	%r13, %rdx
	movl	$50, %esi
	movl	$0, %eax
	call	snprintf@PLT
	movslq	distributionCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$4, %rax
	leaq	(%rax,%rdx), %rdi
	leaq	requests(%rip), %rsi
	movslq	%ebx, %rbx
	movq	%rbx, %rcx
	salq	$5, %rcx
	subq	%rbx, %rcx
	movl	8(%rsi,%rcx,4), %ecx
	movl	%ecx, 60(%r14,%rdi,8)
	leaq	12(%rsi,%rbp), %rcx
	leaq	64(%r14,%rdi,8), %rdi
	movq	%r13, %rdx
	movl	$50, %esi
	movl	$0, %eax
	call	snprintf@PLT
	movslq	distributionCount(%rip), %rdx
	movq	%rdx, %rax
	salq	$4, %rax
	addq	%rdx, %rax
	leaq	114(%r14,%rax,8), %rdi
	call	currentDate
	addl	$1, distributionCount(%rip)
	movabsq	$8458438990456121668, %rax
	movq	%rax, (%r12)
	movl	$6579572, 8(%r12)
	leaq	.LC77(%rip), %rdi
	call	logEvent
	leaq	.LC78(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L163
.L178:
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
	.globl	viewDistributionHistory
	.type	viewDistributionHistory, @function
viewDistributionHistory:
.LFB38:
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	leaq	.LC79(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	cmpl	$0, distributionCount(%rip)
	jle	.L181
	leaq	8+distributions(%rip), %rbx
	movl	$0, %ebp
	leaq	.LC80(%rip), %r15
	leaq	.LC81(%rip), %r14
	leaq	.LC82(%rip), %r13
	leaq	.LC83(%rip), %r12
.L183:
	movl	-8(%rbx), %edx
	movq	%r15, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	-4(%rbx), %edx
	movq	%r14, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rdx
	movq	%r13, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	52(%rbx), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	56(%rbx), %rdx
	leaq	.LC84(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	106(%rbx), %rdx
	leaq	.LC85(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addl	$1, %ebp
	addq	$136, %rbx
	cmpl	%ebp, distributionCount(%rip)
	jg	.L183
.L181:
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB39:
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
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	.LC86(%rip), %rbx
	leaq	.LC87(%rip), %r13
	leaq	.LC88(%rip), %r12
	leaq	.LC89(%rip), %rbp
	jmp	.L188
.L204:
	call	addItem
.L188:
	movq	%rbx, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%r13, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbx, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	%rbp, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC90(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC91(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC92(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC93(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC94(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC95(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC96(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC97(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC98(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC99(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC100(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC101(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	.LC102(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	leaq	4(%rsp), %rsi
	leaq	.LC103(%rip), %rdi
	call	readInt
	testl	%eax, %eax
	je	.L188
	cmpl	$14, 4(%rsp)
	ja	.L189
	movl	4(%rsp), %eax
	leaq	.L191(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L191:
	.long	.L189-.L191
	.long	.L204-.L191
	.long	.L203-.L191
	.long	.L202-.L191
	.long	.L201-.L191
	.long	.L200-.L191
	.long	.L199-.L191
	.long	.L198-.L191
	.long	.L197-.L191
	.long	.L196-.L191
	.long	.L195-.L191
	.long	.L194-.L191
	.long	.L193-.L191
	.long	.L192-.L191
	.long	.L190-.L191
	.text
.L203:
	call	viewInventory
	jmp	.L188
.L202:
	call	searchItem
	jmp	.L188
.L201:
	call	updateItem
	jmp	.L188
.L200:
	call	deleteItem
	jmp	.L188
.L199:
	call	receiveStock
	jmp	.L188
.L198:
	call	lowStockItems
	jmp	.L188
.L197:
	call	outOfStockItems
	jmp	.L188
.L196:
	call	createRequest
	jmp	.L188
.L195:
	call	processRequest
	jmp	.L188
.L194:
	call	viewRequests
	jmp	.L188
.L193:
	call	distributeSupply
	jmp	.L188
.L192:
	call	viewDistributionHistory
	jmp	.L188
.L190:
	leaq	.LC104(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L210
	movl	$0, %eax
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
.L189:
	.cfi_restore_state
	leaq	.LC105(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L188
.L210:
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
