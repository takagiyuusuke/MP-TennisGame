	.file	1 "test.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	softfloat
	.module	nooddspreg
	.text
 #APP
	.global __start__		
	__start__:			
		lui $sp, 0		
		ori $sp, 0xff00		
		li $gp, 0		
		li $k0, 0x02000101	
		mtc0 $k0, $12		
	
 #NO_APP
	.align	2
	.globl	__reset__
	.set	nomips16
	.set	nomicromips
	.ent	__reset__
	.type	__reset__, @function
__reset__:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	lui	$2,%hi(__sbackup)
	addiu	$2,$2,%lo(__sbackup)
	sw	$2,0($fp)
	lui	$2,%hi(__sdata)
	addiu	$2,$2,%lo(__sdata)
	sw	$2,4($fp)
	b	$L2
$L3:
	lw	$3,0($fp)
	#nop
	addiu	$2,$3,4
	sw	$2,0($fp)
	lw	$2,4($fp)
	#nop
	addiu	$4,$2,4
	sw	$4,4($fp)
	lw	$3,0($3)
	#nop
	sw	$3,0($2)
$L2:
	lw	$3,4($fp)
	lui	$2,%hi(__edata)
	addiu	$2,$2,%lo(__edata)
	sltu	$2,$3,$2
	bne	$2,$0,$L3
	lui	$2,%hi(__sbss)
	addiu	$2,$2,%lo(__sbss)
	sw	$2,4($fp)
	b	$L4
$L5:
	lw	$2,4($fp)
	#nop
	sw	$0,0($2)
	lw	$2,4($fp)
	#nop
	addiu	$2,$2,4
	sw	$2,4($fp)
$L4:
	lw	$3,4($fp)
	lui	$2,%hi(__ebss)
	addiu	$2,$2,%lo(__ebss)
	sltu	$2,$3,$2
	bne	$2,$0,$L5
 #APP
 # 24 "crt0.c" 1
	j main
 # 0 "" 2
 #NO_APP
	.set	noreorder
	nop
	.set	reorder
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	.end	__reset__
	.size	__reset__, .-__reset__
 #APP
	nop			
		nop			
		nop			
		nop			
		nop			
	__vector__:			
	.set noat			
		move $k0, $sp		
		lui $sp, 0		
		ori $sp, 0xc000		
		addiu $sp, $sp, -128	
		sw $k0, 124($sp)	
		sw $at, 120($sp)	
	.set at			
		sw $v0, 116($sp)	
		sw $v1, 112($sp)	
		sw $a0, 108($sp)	
		sw $a1, 104($sp)	
		sw $a2, 100($sp)	
		sw $a3,  96($sp)	
		sw $t0,  92($sp)	
		sw $t1,  88($sp)	
		sw $t2,  84($sp)	
		sw $t3,  80($sp)	
		sw $t4,  76($sp)	
		sw $t5,  72($sp)	
		sw $t6,  68($sp)	
		sw $t7,  64($sp)	
		sw $s0,  60($sp)	
		sw $s1,  56($sp)	
		sw $s2,  52($sp)	
		sw $s3,  48($sp)	
		sw $s4,  44($sp)	
		sw $s5,  40($sp)	
		sw $s6,  36($sp)	
		sw $s7,  32($sp)	
		sw $t8,  28($sp)	
		sw $t9,  24($sp)	
		sw $gp,  20($sp)	
		sw $s8,  16($sp)	
		sw $ra,  12($sp)	
		jal interrupt_handler	
		lw $ra,  12($sp)	
		lw $s8,  16($sp)	
		lw $gp,  20($sp)	
		lw $t9,  24($sp)	
		lw $t8,  28($sp)	
		lw $s7,  32($sp)	
		lw $s6,  36($sp)	
		lw $s5,  40($sp)	
		lw $s4,  44($sp)	
		lw $s3,  48($sp)	
		lw $s2,  52($sp)	
		lw $s1,  56($sp)	
		lw $s0,  60($sp)	
		lw $t7,  64($sp)	
		lw $t6,  68($sp)	
		lw $t5,  72($sp)	
		lw $t4,  76($sp)	
		lw $t3,  80($sp)	
		lw $t2,  84($sp)	
		lw $t1,  88($sp)	
		lw $t0,  92($sp)	
		lw $a3,  96($sp)	
		lw $a2, 100($sp)	
		lw $a1, 104($sp)	
		lw $a0, 108($sp)	
		lw $v1, 112($sp)	
		lw $v0, 116($sp)	
	.set noat			
		lw $at, 120($sp)	
		lw $k0, 124($sp)	
		move $sp, $k0		
		mfc0 $k1, $14		
		nop			
		rfe			
		nop			
		jr $k1			
		nop			
	
 #NO_APP
	.align	2
	.globl	memcpy
	.set	nomips16
	.set	nomicromips
	.ent	memcpy
	.type	memcpy, @function
memcpy:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$5,20($fp)
	sw	$6,24($fp)
	lw	$2,16($fp)
	nop
	sw	$2,0($fp)
	lw	$2,20($fp)
	nop
	sw	$2,4($fp)
	b	$L7
	nop

$L8:
	lw	$3,4($fp)
	nop
	addiu	$2,$3,1
	sw	$2,4($fp)
	lw	$2,0($fp)
	nop
	addiu	$4,$2,1
	sw	$4,0($fp)
	lb	$3,0($3)
	nop
	sb	$3,0($2)
$L7:
	lw	$2,24($fp)
	nop
	addiu	$3,$2,-1
	sw	$3,24($fp)
	bne	$2,$0,$L8
	nop

	lw	$2,16($fp)
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	memcpy
	.size	memcpy, .-memcpy
	.globl	font8x8
	.rdata
	.align	2
	.type	font8x8, @object
	.size	font8x8, 768
font8x8:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	95
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	42
	.byte	85
	.byte	107
	.byte	85
	.byte	42
	.byte	60
	.byte	64
	.byte	64
	.byte	60
	.byte	42
	.byte	85
	.byte	107
	.byte	85
	.byte	42
	.byte	28
	.byte	0
	.byte	60
	.byte	126
	.byte	126
	.byte	126
	.byte	126
	.byte	60
	.byte	0
	.byte	14
	.byte	31
	.byte	63
	.byte	124
	.byte	63
	.byte	31
	.byte	14
	.byte	0
	.byte	0
	.byte	0
	.byte	60
	.byte	0
	.byte	0
	.byte	60
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	0
	.byte	0
	.byte	21
	.byte	21
	.byte	14
	.byte	14
	.byte	21
	.byte	21
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	62
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	80
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	32
	.byte	16
	.byte	8
	.byte	4
	.byte	2
	.byte	1
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	65
	.byte	65
	.byte	62
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	66
	.byte	97
	.byte	81
	.byte	73
	.byte	110
	.byte	0
	.byte	0
	.byte	0
	.byte	34
	.byte	65
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	20
	.byte	18
	.byte	127
	.byte	16
	.byte	0
	.byte	0
	.byte	0
	.byte	39
	.byte	73
	.byte	73
	.byte	73
	.byte	113
	.byte	0
	.byte	0
	.byte	0
	.byte	60
	.byte	74
	.byte	73
	.byte	72
	.byte	112
	.byte	0
	.byte	0
	.byte	0
	.byte	67
	.byte	33
	.byte	17
	.byte	13
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	54
	.byte	73
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	9
	.byte	73
	.byte	41
	.byte	30
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	18
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	82
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	20
	.byte	20
	.byte	34
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	34
	.byte	20
	.byte	20
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	1
	.byte	89
	.byte	5
	.byte	2
	.byte	0
	.byte	0
	.byte	62
	.byte	65
	.byte	93
	.byte	85
	.byte	77
	.byte	81
	.byte	46
	.byte	0
	.byte	64
	.byte	124
	.byte	74
	.byte	9
	.byte	74
	.byte	124
	.byte	64
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	54
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	0
	.byte	65
	.byte	127
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	73
	.byte	93
	.byte	65
	.byte	99
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	29
	.byte	1
	.byte	3
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	73
	.byte	73
	.byte	58
	.byte	8
	.byte	0
	.byte	65
	.byte	127
	.byte	8
	.byte	8
	.byte	8
	.byte	127
	.byte	65
	.byte	0
	.byte	0
	.byte	65
	.byte	65
	.byte	127
	.byte	65
	.byte	65
	.byte	0
	.byte	0
	.byte	48
	.byte	64
	.byte	65
	.byte	65
	.byte	63
	.byte	1
	.byte	1
	.byte	0
	.byte	65
	.byte	127
	.byte	8
	.byte	12
	.byte	18
	.byte	97
	.byte	65
	.byte	0
	.byte	65
	.byte	127
	.byte	65
	.byte	64
	.byte	64
	.byte	64
	.byte	96
	.byte	0
	.byte	65
	.byte	127
	.byte	66
	.byte	12
	.byte	66
	.byte	127
	.byte	65
	.byte	0
	.byte	65
	.byte	127
	.byte	66
	.byte	12
	.byte	17
	.byte	127
	.byte	1
	.byte	0
	.byte	28
	.byte	34
	.byte	65
	.byte	65
	.byte	65
	.byte	34
	.byte	28
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	9
	.byte	9
	.byte	6
	.byte	0
	.byte	12
	.byte	18
	.byte	33
	.byte	33
	.byte	97
	.byte	82
	.byte	76
	.byte	0
	.byte	65
	.byte	127
	.byte	9
	.byte	9
	.byte	25
	.byte	105
	.byte	70
	.byte	0
	.byte	102
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	73
	.byte	51
	.byte	0
	.byte	3
	.byte	1
	.byte	65
	.byte	127
	.byte	65
	.byte	1
	.byte	3
	.byte	0
	.byte	1
	.byte	63
	.byte	65
	.byte	64
	.byte	65
	.byte	63
	.byte	1
	.byte	0
	.byte	1
	.byte	15
	.byte	49
	.byte	64
	.byte	49
	.byte	15
	.byte	1
	.byte	0
	.byte	1
	.byte	31
	.byte	97
	.byte	20
	.byte	97
	.byte	31
	.byte	1
	.byte	0
	.byte	65
	.byte	65
	.byte	54
	.byte	8
	.byte	54
	.byte	65
	.byte	65
	.byte	0
	.byte	1
	.byte	3
	.byte	68
	.byte	120
	.byte	68
	.byte	3
	.byte	1
	.byte	0
	.byte	67
	.byte	97
	.byte	81
	.byte	73
	.byte	69
	.byte	67
	.byte	97
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	65
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	65
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	4
	.byte	0
	.byte	0
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	1
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	52
	.byte	74
	.byte	74
	.byte	74
	.byte	60
	.byte	64
	.byte	0
	.byte	0
	.byte	65
	.byte	63
	.byte	72
	.byte	72
	.byte	72
	.byte	48
	.byte	0
	.byte	0
	.byte	60
	.byte	66
	.byte	66
	.byte	66
	.byte	36
	.byte	0
	.byte	0
	.byte	0
	.byte	48
	.byte	72
	.byte	72
	.byte	73
	.byte	63
	.byte	64
	.byte	0
	.byte	0
	.byte	60
	.byte	74
	.byte	74
	.byte	74
	.byte	44
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	72
	.byte	126
	.byte	73
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	38
	.byte	73
	.byte	73
	.byte	73
	.byte	63
	.byte	1
	.byte	0
	.byte	65
	.byte	127
	.byte	72
	.byte	4
	.byte	68
	.byte	120
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	68
	.byte	125
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	68
	.byte	61
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	16
	.byte	24
	.byte	36
	.byte	66
	.byte	66
	.byte	0
	.byte	0
	.byte	64
	.byte	65
	.byte	127
	.byte	64
	.byte	64
	.byte	0
	.byte	0
	.byte	66
	.byte	126
	.byte	2
	.byte	124
	.byte	2
	.byte	126
	.byte	64
	.byte	0
	.byte	66
	.byte	126
	.byte	68
	.byte	2
	.byte	66
	.byte	124
	.byte	64
	.byte	0
	.byte	0
	.byte	60
	.byte	66
	.byte	66
	.byte	66
	.byte	60
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	127
	.byte	73
	.byte	9
	.byte	9
	.byte	6
	.byte	0
	.byte	0
	.byte	6
	.byte	9
	.byte	9
	.byte	73
	.byte	127
	.byte	65
	.byte	0
	.byte	0
	.byte	66
	.byte	126
	.byte	68
	.byte	2
	.byte	2
	.byte	4
	.byte	0
	.byte	0
	.byte	100
	.byte	74
	.byte	74
	.byte	74
	.byte	54
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	63
	.byte	68
	.byte	68
	.byte	32
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	62
	.byte	64
	.byte	64
	.byte	34
	.byte	126
	.byte	64
	.byte	2
	.byte	14
	.byte	50
	.byte	64
	.byte	50
	.byte	14
	.byte	2
	.byte	0
	.byte	2
	.byte	30
	.byte	98
	.byte	24
	.byte	98
	.byte	30
	.byte	2
	.byte	0
	.byte	66
	.byte	98
	.byte	20
	.byte	8
	.byte	20
	.byte	98
	.byte	66
	.byte	0
	.byte	1
	.byte	67
	.byte	69
	.byte	56
	.byte	5
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	70
	.byte	98
	.byte	82
	.byte	74
	.byte	70
	.byte	98
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	54
	.byte	65
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	65
	.byte	54
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	8
	.byte	8
	.byte	16
	.byte	16
	.byte	24
	.byte	0
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85
	.byte	-86
	.byte	85

	.comm	state,4,4

	.comm	posx,4,4

	.comm	posy,4,4

	.comm	p1_pos,4,4

	.comm	p2_pos,4,4

	.comm	p1_pos_x,4,4

	.comm	p2_pos_x,4,4

	.comm	a,4,4

	.comm	vecx,4,4

	.comm	vecy,4,4

	.comm	point1,4,4

	.comm	point2,4,4

	.comm	life1,4,4

	.comm	life2,4,4

	.comm	angle1,4,4

	.comm	angle2,4,4

	.comm	mode,4,4

	.comm	charged,4,4
	.globl	rte_ptr1
	.data
	.align	2
	.type	rte_ptr1, @object
	.size	rte_ptr1, 4
rte_ptr1:
	.word	65300
	.globl	rte_ptr2
	.align	2
	.type	rte_ptr2, @object
	.size	rte_ptr2, 4
rte_ptr2:
	.word	65308
	.globl	kypd_ptr
	.align	2
	.type	kypd_ptr, @object
	.size	kypd_ptr, 4
kypd_ptr:
	.word	65328
	.globl	led_ptr
	.align	2
	.type	led_ptr, @object
	.size	led_ptr, 4
led_ptr:
	.word	65288

	.comm	lcd_vbuf,6144,4
	.text
	.align	2
	.globl	interrupt_handler
	.set	nomips16
	.set	nomicromips
	.ent	interrupt_handler
	.type	interrupt_handler, @function
interrupt_handler:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,65316			# 0xff24
	sw	$2,16($fp)
	jal	lcd_init
	nop

	lui	$2,%hi(state)
	lw	$2,%lo(state)($2)
	nop
	beq	$2,$0,$L11
	nop

	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L11
	nop

	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L11
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	addu	$2,$3,$2
	bltz	$2,$L13
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	addu	$2,$3,$2
	slt	$2,$2,12
	beq	$2,$0,$L13
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posx)
	sw	$3,%lo(posx)($2)
	lui	$2,%hi(vecx)
	lw	$3,%lo(vecx)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L14
	nop

	lui	$2,%hi(vecx)
	li	$3,2			# 0x2
	sw	$3,%lo(vecx)($2)
$L14:
	lui	$2,%hi(vecx)
	lw	$3,%lo(vecx)($2)
	li	$2,-3			# 0xfffffffffffffffd
	bne	$3,$2,$L16
	nop

	lui	$2,%hi(vecx)
	li	$3,-2			# 0xfffffffffffffffe
	sw	$3,%lo(vecx)($2)
	b	$L16
	nop

$L13:
	lui	$2,%hi(posx)
	lw	$2,%lo(posx)($2)
	nop
	bgtz	$2,$L17
	nop

	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	addiu	$3,$2,-1
	lui	$2,%hi(life1)
	sw	$3,%lo(life1)($2)
	lui	$2,%hi(vecx)
	li	$3,1			# 0x1
	sw	$3,%lo(vecx)($2)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	lw	$2,16($fp)
	nop
	sw	$0,0($2)
$L17:
	lui	$2,%hi(posx)
	lw	$2,%lo(posx)($2)
	nop
	slt	$2,$2,11
	bne	$2,$0,$L18
	nop

	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	addiu	$3,$2,-1
	lui	$2,%hi(life2)
	sw	$3,%lo(life2)($2)
	lui	$2,%hi(vecx)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(vecx)($2)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	lw	$2,16($fp)
	nop
	sw	$0,0($2)
$L18:
	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posx)
	sw	$3,%lo(posx)($2)
$L16:
	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(vecy)
	lw	$2,%lo(vecy)($2)
	nop
	addu	$2,$3,$2
	blez	$2,$L19
	nop

	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(vecy)
	lw	$2,%lo(vecy)($2)
	nop
	addu	$2,$3,$2
	slt	$2,$2,8
	beq	$2,$0,$L19
	nop

	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(vecy)
	lw	$2,%lo(vecy)($2)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posy)
	sw	$3,%lo(posy)($2)
	b	$L20
	nop

$L19:
	lui	$2,%hi(vecy)
	lw	$2,%lo(vecy)($2)
	nop
	subu	$3,$0,$2
	lui	$2,%hi(vecy)
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(vecy)
	lw	$2,%lo(vecy)($2)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posy)
	sw	$3,%lo(posy)($2)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	lw	$2,16($fp)
	nop
	sw	$0,0($2)
$L20:
	lui	$2,%hi(mode)
	lw	$2,%lo(mode)($2)
	nop
	slt	$2,$2,3
	bne	$2,$0,$L21
	nop

	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(p2_pos)
	sw	$3,%lo(p2_pos)($2)
	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	li	$2,10			# 0xa
	bne	$3,$2,$L21
	nop

	lui	$2,%hi(vecx)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(vecx)($2)
	lui	$2,%hi(angle2)
	lw	$3,%lo(angle2)($2)
	lui	$2,%hi(vecy)
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	bgtz	$2,$L22
	nop

	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(angle2)
	sw	$3,%lo(angle2)($2)
	b	$L21
	nop

$L22:
	lui	$2,%hi(angle2)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(angle2)($2)
$L21:
	jal	show_player
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	move	$5,$2
	move	$4,$3
	jal	show_ball
	nop

$L11:
	jal	lcd_sync_vbuf
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	interrupt_handler
	.size	interrupt_handler, .-interrupt_handler
	.align	2
	.globl	lcd_digit3
	.set	nomips16
	.set	nomicromips
	.ent	lcd_digit3
	.type	lcd_digit3, @function
lcd_digit3:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	lw	$2,48($fp)
	nop
	sltu	$2,$2,100
	bne	$2,$0,$L24
	nop

	lw	$3,48($fp)
	li	$2,1000			# 0x3e8
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	li	$2,100			# 0x64
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$2,$2,48
	b	$L25
	nop

$L24:
	li	$2,32			# 0x20
$L25:
	sw	$2,16($fp)
	lw	$2,48($fp)
	nop
	sltu	$2,$2,10
	bne	$2,$0,$L26
	nop

	lw	$3,48($fp)
	li	$2,100			# 0x64
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	move	$3,$2
	li	$2,10			# 0xa
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$2,$2,48
	b	$L27
	nop

$L26:
	li	$2,32			# 0x20
$L27:
	sw	$2,20($fp)
	lw	$3,48($fp)
	li	$2,10			# 0xa
	divu	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$2,$2,48
	sw	$2,24($fp)
	lw	$6,16($fp)
	move	$5,$0
	move	$4,$0
	jal	lcd_putc
	nop

	lw	$6,20($fp)
	li	$5,1			# 0x1
	move	$4,$0
	jal	lcd_putc
	nop

	lw	$6,24($fp)
	li	$5,2			# 0x2
	move	$4,$0
	jal	lcd_putc
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_digit3
	.size	lcd_digit3, .-lcd_digit3
	.rdata
	.align	2
$LC0:
	.ascii	"TENNIS GAME\000"
	.align	2
$LC1:
	.ascii	"SELECT MODE\000"
	.align	2
$LC2:
	.ascii	"\000"
	.align	2
$LC3:
	.ascii	" 1:2P EASY\000"
	.align	2
$LC4:
	.ascii	" 2:2P HARD\000"
	.align	2
$LC5:
	.ascii	" 3:1P EASY\000"
	.align	2
$LC6:
	.ascii	" 4:1P HARD\000"
	.align	2
$LC7:
	.ascii	"GAME IS OVER\000"
	.align	2
$LC8:
	.ascii	"PLAYER2 WIN!\000"
	.align	2
$LC9:
	.ascii	"PLAYER1 WIN!\000"
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,48,$31		# vars= 16, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$fp,40($sp)
	move	$fp,$sp
	lui	$2,%hi(state)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(state)($2)
	lui	$2,%hi(posx)
	li	$3,2			# 0x2
	sw	$3,%lo(posx)($2)
	lui	$2,%hi(posy)
	li	$3,4			# 0x4
	sw	$3,%lo(posy)($2)
	lui	$2,%hi(p1_pos)
	li	$3,4			# 0x4
	sw	$3,%lo(p1_pos)($2)
	lui	$2,%hi(p2_pos)
	li	$3,4			# 0x4
	sw	$3,%lo(p2_pos)($2)
	lui	$2,%hi(p1_pos_x)
	li	$3,1			# 0x1
	sw	$3,%lo(p1_pos_x)($2)
	lui	$2,%hi(p2_pos_x)
	li	$3,10			# 0xa
	sw	$3,%lo(p2_pos_x)($2)
	lui	$2,%hi(vecx)
	li	$3,1			# 0x1
	sw	$3,%lo(vecx)($2)
	lui	$2,%hi(vecy)
	li	$3,1			# 0x1
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(point1)
	sw	$0,%lo(point1)($2)
	lui	$2,%hi(point2)
	sw	$0,%lo(point2)($2)
	lui	$2,%hi(life1)
	li	$3,4			# 0x4
	sw	$3,%lo(life1)($2)
	lui	$2,%hi(life2)
	li	$3,4			# 0x4
	sw	$3,%lo(life2)($2)
	lui	$2,%hi(angle1)
	li	$3,1			# 0x1
	sw	$3,%lo(angle1)($2)
	lui	$2,%hi(angle2)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(angle2)($2)
	lui	$2,%hi(mode)
	sw	$0,%lo(mode)($2)
	lui	$2,%hi(rte_ptr1)
	li	$3,65300			# 0xff14
	sw	$3,%lo(rte_ptr1)($2)
	lui	$2,%hi(rte_ptr2)
	li	$3,65308			# 0xff1c
	sw	$3,%lo(rte_ptr2)($2)
	lui	$2,%hi(kypd_ptr)
	li	$3,65328			# 0xff30
	sw	$3,%lo(kypd_ptr)($2)
	lui	$2,%hi(led_ptr)
	li	$3,65288			# 0xff08
	sw	$3,%lo(led_ptr)($2)
	li	$2,65316			# 0xff24
	sw	$2,36($fp)
	jal	lcd_init
	nop

$L55:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L29
	nop

	lui	$2,%hi(state)
	sw	$0,%lo(state)($2)
$L29:
	lui	$2,%hi(state)
	lw	$2,%lo(state)($2)
	nop
	bne	$2,$0,$L30
	nop

	lui	$2,%hi(state)
	li	$3,1			# 0x1
	sw	$3,%lo(state)($2)
	sw	$0,24($fp)
	b	$L31
	nop

$L34:
	sw	$0,28($fp)
	b	$L32
	nop

$L33:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,24($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,28($fp)
	nop
	addu	$2,$3,$2
	sb	$0,0($2)
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L32:
	lw	$2,28($fp)
	nop
	slt	$2,$2,96
	bne	$2,$0,$L33
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L31:
	lw	$2,24($fp)
	nop
	slt	$2,$2,64
	bne	$2,$0,$L34
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,255			# 0xff
	sw	$2,16($sp)
	li	$7,255			# 0xff
	lui	$2,%hi($LC0)
	addiu	$6,$2,%lo($LC0)
	move	$5,$0
	move	$4,$0
	jal	lcd_puts
	nop

	li	$2,128			# 0x80
	sw	$2,20($sp)
	li	$2,128			# 0x80
	sw	$2,16($sp)
	li	$7,128			# 0x80
	lui	$2,%hi($LC1)
	addiu	$6,$2,%lo($LC1)
	move	$5,$0
	li	$4,2			# 0x2
	jal	lcd_puts
	nop

	li	$2,128			# 0x80
	sw	$2,20($sp)
	li	$2,128			# 0x80
	sw	$2,16($sp)
	li	$7,128			# 0x80
	lui	$2,%hi($LC2)
	addiu	$6,$2,%lo($LC2)
	move	$5,$0
	li	$4,3			# 0x3
	jal	lcd_puts
	nop

	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	lui	$2,%hi($LC3)
	addiu	$6,$2,%lo($LC3)
	move	$5,$0
	li	$4,4			# 0x4
	jal	lcd_puts
	nop

	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,255			# 0xff
	sw	$2,16($sp)
	li	$7,64			# 0x40
	lui	$2,%hi($LC4)
	addiu	$6,$2,%lo($LC4)
	move	$5,$0
	li	$4,5			# 0x5
	jal	lcd_puts
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	lui	$2,%hi($LC5)
	addiu	$6,$2,%lo($LC5)
	move	$5,$0
	li	$4,6			# 0x6
	jal	lcd_puts
	nop

	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,160			# 0xa0
	sw	$2,16($sp)
	li	$7,160			# 0xa0
	lui	$2,%hi($LC6)
	addiu	$6,$2,%lo($LC6)
	move	$5,$0
	li	$4,7			# 0x7
	jal	lcd_puts
	nop

	b	$L35
	nop

$L39:
	jal	kypd_scan
	nop

	move	$3,$2
	lui	$2,%hi(a)
	sw	$3,%lo(a)($2)
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L36
	nop

	lui	$2,%hi(mode)
	li	$3,1			# 0x1
	sw	$3,%lo(mode)($2)
	b	$L35
	nop

$L36:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L37
	nop

	lui	$2,%hi(mode)
	li	$3,2			# 0x2
	sw	$3,%lo(mode)($2)
	b	$L35
	nop

$L37:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L38
	nop

	lui	$2,%hi(mode)
	li	$3,3			# 0x3
	sw	$3,%lo(mode)($2)
	b	$L35
	nop

$L38:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,4			# 0x4
	bne	$3,$2,$L35
	nop

	lui	$2,%hi(mode)
	li	$3,4			# 0x4
	sw	$3,%lo(mode)($2)
$L35:
	lui	$2,%hi(mode)
	lw	$2,%lo(mode)($2)
	nop
	beq	$2,$0,$L39
	nop

	b	$L55
	nop

$L30:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,1			# 0x1
	bne	$3,$2,$L41
	nop

	lui	$2,%hi(p1_pos)
	lw	$3,%lo(p1_pos)($2)
	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	move	$5,$2
	move	$4,$3
	jal	show_player
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	move	$5,$2
	move	$4,$3
	jal	show_ball
	nop

	jal	play_song
	nop

	lui	$2,%hi(state)
	li	$3,2			# 0x2
	sw	$3,%lo(state)($2)
	b	$L55
	nop

$L41:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,2			# 0x2
	bne	$3,$2,$L42
	nop

	jal	play
	nop

	lui	$2,%hi(state)
	li	$3,3			# 0x3
	sw	$3,%lo(state)($2)
	lw	$2,36($fp)
	li	$3,6			# 0x6
	sw	$3,0($2)
	lw	$2,36($fp)
	li	$3,2			# 0x2
	sw	$3,0($2)
	b	$L55
	nop

$L42:
	lui	$2,%hi(state)
	lw	$3,%lo(state)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L55
	nop

	jal	lcd_clear_vbuf
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,255			# 0xff
	sw	$2,16($sp)
	li	$7,255			# 0xff
	lui	$2,%hi($LC7)
	addiu	$6,$2,%lo($LC7)
	move	$5,$0
	move	$4,$0
	jal	lcd_puts
	nop

	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	bne	$2,$0,$L43
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	lui	$2,%hi($LC8)
	addiu	$6,$2,%lo($LC8)
	move	$5,$0
	li	$4,2			# 0x2
	jal	lcd_puts
	nop

	b	$L44
	nop

$L43:
	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	lui	$2,%hi($LC9)
	addiu	$6,$2,%lo($LC9)
	move	$5,$0
	li	$4,2			# 0x2
	jal	lcd_puts
	nop

$L44:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	blez	$2,$L45
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,1			# 0x1
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L45:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,2
	bne	$2,$0,$L46
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,2			# 0x2
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L46:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,3
	bne	$2,$0,$L47
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,3			# 0x3
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L47:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,4
	bne	$2,$0,$L48
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,4			# 0x4
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L48:
	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,100			# 0x64
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$3,$2,48
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	move	$6,$3
	li	$5,1			# 0x1
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$3
	li	$2,10			# 0xa
	nop
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	move	$6,$3
	li	$5,2			# 0x2
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	move	$6,$3
	li	$5,3			# 0x3
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,100			# 0x64
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$2
	addiu	$3,$2,48
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	move	$6,$3
	li	$5,8			# 0x8
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$3
	li	$2,10			# 0xa
	nop
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	move	$6,$3
	li	$5,9			# 0x9
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	move	$6,$3
	li	$5,10			# 0xa
	li	$4,4			# 0x4
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,4
	bne	$2,$0,$L49
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,7			# 0x7
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L49:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,3
	bne	$2,$0,$L50
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,8			# 0x8
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L50:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,2
	bne	$2,$0,$L51
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,9			# 0x9
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L51:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	blez	$2,$L52
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,10			# 0xa
	li	$4,5			# 0x5
	jal	lcd_putc_with_color
	nop

$L52:
	sw	$0,32($fp)
	b	$L53
	nop

$L54:
	jal	kypd_scan
	nop

	sw	$2,32($fp)
$L53:
	lw	$2,32($fp)
	nop
	beq	$2,$0,$L54
	nop

	lui	$2,%hi(state)
	sw	$0,%lo(state)($2)
	lui	$2,%hi(posx)
	li	$3,2			# 0x2
	sw	$3,%lo(posx)($2)
	lui	$2,%hi(posy)
	li	$3,4			# 0x4
	sw	$3,%lo(posy)($2)
	lui	$2,%hi(p1_pos)
	li	$3,4			# 0x4
	sw	$3,%lo(p1_pos)($2)
	lui	$2,%hi(p2_pos)
	li	$3,4			# 0x4
	sw	$3,%lo(p2_pos)($2)
	lui	$2,%hi(p1_pos_x)
	li	$3,1			# 0x1
	sw	$3,%lo(p1_pos_x)($2)
	lui	$2,%hi(p2_pos_x)
	li	$3,10			# 0xa
	sw	$3,%lo(p2_pos_x)($2)
	lui	$2,%hi(vecx)
	li	$3,1			# 0x1
	sw	$3,%lo(vecx)($2)
	lui	$2,%hi(vecy)
	li	$3,1			# 0x1
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(point1)
	sw	$0,%lo(point1)($2)
	lui	$2,%hi(point2)
	sw	$0,%lo(point2)($2)
	lui	$2,%hi(life1)
	li	$3,4			# 0x4
	sw	$3,%lo(life1)($2)
	lui	$2,%hi(life2)
	li	$3,4			# 0x4
	sw	$3,%lo(life2)($2)
	lui	$2,%hi(angle1)
	li	$3,1			# 0x1
	sw	$3,%lo(angle1)($2)
	lui	$2,%hi(angle2)
	li	$3,-1			# 0xffffffffffffffff
	sw	$3,%lo(angle2)($2)
	lui	$2,%hi(mode)
	sw	$0,%lo(mode)($2)
	b	$L55
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.align	2
	.globl	play
	.set	nomips16
	.set	nomicromips
	.ent	play
	.type	play, @function
play:
	.frame	$fp,56,$31		# vars= 32, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	li	$2,1			# 0x1
	sw	$2,24($fp)
	li	$2,1020			# 0x3fc
	sw	$2,28($fp)
	sw	$0,16($fp)
	sw	$0,20($fp)
	lui	$2,%hi(mode)
	lw	$3,%lo(mode)($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L57
	nop

	lui	$2,%hi(mode)
	lw	$3,%lo(mode)($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L58
	nop

$L57:
	li	$2,1			# 0x1
	b	$L59
	nop

$L58:
	move	$2,$0
$L59:
	sw	$2,32($fp)
	li	$2,65316			# 0xff24
	sw	$2,36($fp)
	b	$L60
	nop

$L93:
	jal	kypd_scan
	nop

	move	$3,$2
	lui	$2,%hi(a)
	sw	$3,%lo(a)($2)
	lui	$2,%hi(rte_ptr1)
	lw	$2,%lo(rte_ptr1)($2)
	nop
	lw	$3,0($2)
	lw	$2,24($fp)
	nop
	and	$2,$3,$2
	beq	$2,$0,$L61
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(p1_pos_x)
	lw	$2,%lo(p1_pos_x)($2)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L61
	nop

	lui	$2,%hi(p1_pos_x)
	lw	$3,%lo(p1_pos_x)($2)
	lw	$2,32($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posx)
	lw	$2,%lo(posx)($2)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L61
	nop

	lui	$2,%hi(p1_pos)
	lw	$3,%lo(p1_pos)($2)
	lw	$2,32($fp)
	nop
	subu	$3,$3,$2
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L61
	nop

	lui	$2,%hi(p1_pos)
	lw	$3,%lo(p1_pos)($2)
	lw	$2,32($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L61
	nop

	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	bgez	$2,$L61
	nop

	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	bne	$2,$0,$L62
	nop

	lui	$2,%hi(point1)
	lw	$2,%lo(point1)($2)
	nop
	blez	$2,$L62
	nop

	li	$2,3			# 0x3
	b	$L63
	nop

$L62:
	li	$2,1			# 0x1
$L63:
	lui	$3,%hi(vecx)
	sw	$2,%lo(vecx)($3)
	lui	$2,%hi(angle1)
	lw	$3,%lo(angle1)($2)
	lui	$2,%hi(vecy)
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(p1_pos)
	lw	$2,%lo(p1_pos)($2)
	nop
	bne	$3,$2,$L64
	nop

	lui	$2,%hi(point1)
	lw	$2,%lo(point1)($2)
	nop
	addiu	$3,$2,2
	lui	$2,%hi(point1)
	sw	$3,%lo(point1)($2)
	b	$L65
	nop

$L64:
	lui	$2,%hi(point1)
	lw	$2,%lo(point1)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(point1)
	sw	$3,%lo(point1)($2)
$L65:
	lw	$2,36($fp)
	li	$3,3			# 0x3
	sw	$3,0($2)
	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	li	$3,3			# 0x3
	sw	$3,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	nop
	sw	$0,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	li	$3,3			# 0x3
	sw	$3,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	nop
	sw	$0,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lw	$2,36($fp)
	nop
	sw	$0,0($2)
$L61:
	lui	$2,%hi(rte_ptr2)
	lw	$2,%lo(rte_ptr2)($2)
	nop
	lw	$3,0($2)
	lw	$2,24($fp)
	nop
	and	$2,$3,$2
	beq	$2,$0,$L66
	nop

	lui	$2,%hi(p2_pos_x)
	lw	$3,%lo(p2_pos_x)($2)
	lw	$2,32($fp)
	nop
	subu	$3,$3,$2
	lui	$2,%hi(posx)
	lw	$2,%lo(posx)($2)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L66
	nop

	lui	$2,%hi(posx)
	lw	$3,%lo(posx)($2)
	lui	$2,%hi(p2_pos_x)
	lw	$2,%lo(p2_pos_x)($2)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L66
	nop

	lui	$2,%hi(p2_pos)
	lw	$3,%lo(p2_pos)($2)
	lw	$2,32($fp)
	nop
	subu	$3,$3,$2
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	slt	$2,$2,$3
	bne	$2,$0,$L66
	nop

	lui	$2,%hi(p2_pos)
	lw	$3,%lo(p2_pos)($2)
	lw	$2,32($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(posy)
	lw	$2,%lo(posy)($2)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L66
	nop

	lui	$2,%hi(vecx)
	lw	$2,%lo(vecx)($2)
	nop
	blez	$2,$L66
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	bne	$2,$0,$L67
	nop

	lui	$2,%hi(point2)
	lw	$2,%lo(point2)($2)
	nop
	blez	$2,$L67
	nop

	li	$2,-3			# 0xfffffffffffffffd
	b	$L68
	nop

$L67:
	li	$2,-1			# 0xffffffffffffffff
$L68:
	lui	$3,%hi(vecx)
	sw	$2,%lo(vecx)($3)
	lui	$2,%hi(angle2)
	lw	$3,%lo(angle2)($2)
	lui	$2,%hi(vecy)
	sw	$3,%lo(vecy)($2)
	lui	$2,%hi(posy)
	lw	$3,%lo(posy)($2)
	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	bne	$3,$2,$L69
	nop

	lui	$2,%hi(point2)
	lw	$2,%lo(point2)($2)
	nop
	addiu	$3,$2,2
	lui	$2,%hi(point2)
	sw	$3,%lo(point2)($2)
	b	$L70
	nop

$L69:
	lui	$2,%hi(point2)
	lw	$2,%lo(point2)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(point2)
	sw	$3,%lo(point2)($2)
$L70:
	lw	$2,36($fp)
	li	$3,4			# 0x4
	sw	$3,0($2)
	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	li	$3,12			# 0xc
	sw	$3,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	nop
	sw	$0,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	li	$3,12			# 0xc
	sw	$3,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lui	$2,%hi(led_ptr)
	lw	$2,%lo(led_ptr)($2)
	nop
	sw	$0,0($2)
	li	$2,65536			# 0x10000
	ori	$4,$2,0x86a0
	jal	lcd_wait
	nop

	lw	$2,36($fp)
	nop
	sw	$0,0($2)
$L66:
	lui	$2,%hi(rte_ptr1)
	lw	$2,%lo(rte_ptr1)($2)
	nop
	lw	$3,0($2)
	lw	$2,28($fp)
	nop
	and	$2,$3,$2
	sra	$2,$2,2
	sw	$2,40($fp)
	lw	$3,40($fp)
	lw	$2,16($fp)
	nop
	slt	$2,$3,$2
	beq	$2,$0,$L71
	nop

	lw	$2,40($fp)
	nop
	sw	$2,16($fp)
	lui	$2,%hi(angle1)
	lw	$2,%lo(angle1)($2)
	nop
	bgtz	$2,$L73
	nop

	lui	$2,%hi(angle1)
	lw	$2,%lo(angle1)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(angle1)
	sw	$3,%lo(angle1)($2)
	b	$L73
	nop

$L71:
	lw	$3,40($fp)
	lw	$2,16($fp)
	nop
	slt	$2,$2,$3
	beq	$2,$0,$L73
	nop

	lw	$2,40($fp)
	nop
	sw	$2,16($fp)
	lui	$2,%hi(angle1)
	lw	$2,%lo(angle1)($2)
	nop
	bltz	$2,$L73
	nop

	lui	$2,%hi(angle1)
	lw	$2,%lo(angle1)($2)
	nop
	addiu	$3,$2,-1
	lui	$2,%hi(angle1)
	sw	$3,%lo(angle1)($2)
$L73:
	lui	$2,%hi(rte_ptr2)
	lw	$2,%lo(rte_ptr2)($2)
	nop
	lw	$3,0($2)
	lw	$2,28($fp)
	nop
	and	$2,$3,$2
	sra	$2,$2,2
	sw	$2,40($fp)
	lw	$3,40($fp)
	lw	$2,20($fp)
	nop
	slt	$2,$2,$3
	beq	$2,$0,$L74
	nop

	lw	$2,40($fp)
	nop
	sw	$2,20($fp)
	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	bgtz	$2,$L76
	nop

	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	addiu	$3,$2,1
	lui	$2,%hi(angle2)
	sw	$3,%lo(angle2)($2)
	b	$L76
	nop

$L74:
	lw	$3,40($fp)
	lw	$2,20($fp)
	nop
	slt	$2,$3,$2
	beq	$2,$0,$L76
	nop

	lw	$2,40($fp)
	nop
	sw	$2,20($fp)
	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	bltz	$2,$L76
	nop

	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	addiu	$3,$2,-1
	lui	$2,%hi(angle2)
	sw	$3,%lo(angle2)($2)
$L76:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,4			# 0x4
	bne	$3,$2,$L77
	nop

	lui	$2,%hi(p1_pos)
	lw	$2,%lo(p1_pos)($2)
	nop
	slt	$3,$2,2
	beq	$3,$0,$L78
	nop

	li	$2,2			# 0x2
$L78:
	addiu	$3,$2,-1
	lui	$2,%hi(p1_pos)
	sw	$3,%lo(p1_pos)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L79
	nop

$L77:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,8			# 0x8
	bne	$3,$2,$L80
	nop

	lui	$2,%hi(p1_pos)
	lw	$2,%lo(p1_pos)($2)
	nop
	slt	$3,$2,7
	bne	$3,$0,$L81
	nop

	li	$2,6			# 0x6
$L81:
	addiu	$3,$2,1
	lui	$2,%hi(p1_pos)
	sw	$3,%lo(p1_pos)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L79
	nop

$L80:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,5			# 0x5
	bne	$3,$2,$L82
	nop

	lui	$2,%hi(p1_pos_x)
	lw	$2,%lo(p1_pos_x)($2)
	nop
	slt	$3,$2,5
	bne	$3,$0,$L83
	nop

	li	$2,4			# 0x4
$L83:
	addiu	$3,$2,1
	lui	$2,%hi(p1_pos_x)
	sw	$3,%lo(p1_pos_x)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L79
	nop

$L82:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,7			# 0x7
	bne	$3,$2,$L79
	nop

	lui	$2,%hi(p1_pos_x)
	lw	$2,%lo(p1_pos_x)($2)
	nop
	slt	$3,$2,2
	beq	$3,$0,$L84
	nop

	li	$2,2			# 0x2
$L84:
	addiu	$3,$2,-1
	lui	$2,%hi(p1_pos_x)
	sw	$3,%lo(p1_pos_x)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

$L79:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,6			# 0x6
	bne	$3,$2,$L85
	nop

	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	slt	$3,$2,2
	beq	$3,$0,$L86
	nop

	li	$2,2			# 0x2
$L86:
	addiu	$3,$2,-1
	lui	$2,%hi(p2_pos)
	sw	$3,%lo(p2_pos)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L60
	nop

$L85:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,12			# 0xc
	bne	$3,$2,$L87
	nop

	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	slt	$3,$2,7
	bne	$3,$0,$L88
	nop

	li	$2,6			# 0x6
$L88:
	addiu	$3,$2,1
	lui	$2,%hi(p2_pos)
	sw	$3,%lo(p2_pos)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L60
	nop

$L87:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,11			# 0xb
	bne	$3,$2,$L89
	nop

	lui	$2,%hi(p2_pos_x)
	lw	$2,%lo(p2_pos_x)($2)
	nop
	slt	$3,$2,10
	bne	$3,$0,$L90
	nop

	li	$2,9			# 0x9
$L90:
	addiu	$3,$2,1
	lui	$2,%hi(p2_pos_x)
	sw	$3,%lo(p2_pos_x)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

	b	$L60
	nop

$L89:
	lui	$2,%hi(a)
	lw	$3,%lo(a)($2)
	li	$2,9			# 0x9
	bne	$3,$2,$L60
	nop

	lui	$2,%hi(p2_pos_x)
	lw	$2,%lo(p2_pos_x)($2)
	nop
	slt	$3,$2,7
	beq	$3,$0,$L91
	nop

	li	$2,7			# 0x7
$L91:
	addiu	$3,$2,-1
	lui	$2,%hi(p2_pos_x)
	sw	$3,%lo(p2_pos_x)($2)
	li	$2,196608			# 0x30000
	ori	$4,$2,0xd40
	jal	lcd_wait
	nop

$L60:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	beq	$2,$0,$L94
	nop

	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	bne	$2,$0,$L93
	nop

$L94:
	nop
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	play
	.size	play, .-play
	.align	2
	.globl	show_ball
	.set	nomips16
	.set	nomicromips
	.ent	show_ball
	.type	show_ball, @function
show_ball:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	lw	$2,32($fp)
	nop
	bgez	$2,$L96
	nop

	sw	$0,32($fp)
$L96:
	lw	$2,32($fp)
	nop
	slt	$2,$2,12
	bne	$2,$0,$L97
	nop

	li	$2,11			# 0xb
	sw	$2,32($fp)
$L97:
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,255			# 0xff
	sw	$2,16($sp)
	li	$7,128			# 0x80
	li	$6,36			# 0x24
	lw	$5,32($fp)
	lw	$4,36($fp)
	jal	lcd_putc_with_color
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,255			# 0xff
	sw	$2,16($sp)
	li	$7,255			# 0xff
	li	$6,38			# 0x26
	lw	$5,32($fp)
	lw	$4,36($fp)
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	blez	$2,$L98
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,2			# 0x2
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L98:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,2
	bne	$2,$0,$L99
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,3			# 0x3
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L99:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,3
	bne	$2,$0,$L100
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,4			# 0x4
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L100:
	lui	$2,%hi(life1)
	lw	$2,%lo(life1)($2)
	nop
	slt	$2,$2,4
	bne	$2,$0,$L101
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	li	$7,255			# 0xff
	li	$6,37			# 0x25
	li	$5,5			# 0x5
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L101:
	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$3
	li	$2,10			# 0xa
	nop
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	move	$6,$3
	move	$5,$0
	move	$4,$0
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point1)
	lw	$3,%lo(point1)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	move	$6,$3
	li	$5,1			# 0x1
	move	$4,$0
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	mflo	$3
	li	$2,10			# 0xa
	nop
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	move	$6,$3
	li	$5,10			# 0xa
	move	$4,$0
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(point2)
	lw	$3,%lo(point2)($2)
	li	$2,10			# 0xa
	div	$0,$3,$2
	bne	$2,$0,1f
	nop
	break	7
1:
	mfhi	$2
	addiu	$3,$2,48
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	move	$6,$3
	li	$5,11			# 0xb
	move	$4,$0
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,4
	bne	$2,$0,$L102
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,6			# 0x6
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L102:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,3
	bne	$2,$0,$L103
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,7			# 0x7
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L103:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	slt	$2,$2,2
	bne	$2,$0,$L104
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,8			# 0x8
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L104:
	lui	$2,%hi(life2)
	lw	$2,%lo(life2)($2)
	nop
	blez	$2,$L106
	nop

	li	$2,255			# 0xff
	sw	$2,20($sp)
	sw	$0,16($sp)
	move	$7,$0
	li	$6,37			# 0x25
	li	$5,9			# 0x9
	move	$4,$0
	jal	lcd_putc_with_color
	nop

$L106:
	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	show_ball
	.size	show_ball, .-show_ball
	.align	2
	.globl	show_player
	.set	nomips16
	.set	nomicromips
	.ent	show_player
	.type	show_player, @function
show_player:
	.frame	$fp,56,$31		# vars= 24, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	jal	lcd_clear_vbuf
	nop

	lui	$2,%hi(p1_pos)
	lw	$3,%lo(p1_pos)($2)
	lui	$2,%hi(p1_pos_x)
	lw	$4,%lo(p1_pos_x)($2)
	li	$2,64			# 0x40
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,255			# 0xff
	li	$6,35			# 0x23
	move	$5,$4
	move	$4,$3
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(p2_pos)
	lw	$3,%lo(p2_pos)($2)
	lui	$2,%hi(p2_pos_x)
	lw	$4,%lo(p2_pos_x)($2)
	li	$2,255			# 0xff
	sw	$2,20($sp)
	li	$2,64			# 0x40
	sw	$2,16($sp)
	li	$7,64			# 0x40
	li	$6,34			# 0x22
	move	$5,$4
	move	$4,$3
	jal	lcd_putc_with_color
	nop

	lui	$2,%hi(p1_pos_x)
	lw	$2,%lo(p1_pos_x)($2)
	nop
	sll	$2,$2,3
	addiu	$2,$2,4
	sw	$2,36($fp)
	lui	$2,%hi(p1_pos)
	lw	$2,%lo(p1_pos)($2)
	nop
	sll	$2,$2,3
	addiu	$2,$2,3
	sw	$2,40($fp)
	li	$2,11			# 0xb
	sw	$2,24($fp)
	lui	$2,%hi(angle1)
	lw	$2,%lo(angle1)($2)
	nop
	bne	$2,$0,$L108
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,3
	sw	$2,24($fp)
$L108:
	li	$2,3			# 0x3
	sw	$2,28($fp)
	b	$L109
	nop

$L111:
	lui	$2,%hi(angle1)
	lw	$3,%lo(angle1)($2)
	lw	$2,28($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$2,$3,$2
	slt	$2,$2,8
	bne	$2,$0,$L110
	nop

	lui	$2,%hi(angle1)
	lw	$3,%lo(angle1)($2)
	lw	$2,28($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$2,$3,$2
	slt	$2,$2,65
	beq	$2,$0,$L110
	nop

	lui	$2,%hi(angle1)
	lw	$3,%lo(angle1)($2)
	lw	$2,28($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$4,$3,$2
	lw	$3,36($fp)
	lw	$2,28($fp)
	nop
	addu	$2,$3,$2
	sw	$0,16($sp)
	move	$7,$0
	li	$6,255			# 0xff
	move	$5,$2
	jal	lcd_set_vbuf_pixel
	nop

$L110:
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L109:
	lw	$3,28($fp)
	lw	$2,24($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L111
	nop

	lui	$2,%hi(p2_pos_x)
	lw	$2,%lo(p2_pos_x)($2)
	nop
	sll	$2,$2,3
	addiu	$2,$2,4
	sw	$2,36($fp)
	lui	$2,%hi(p2_pos)
	lw	$2,%lo(p2_pos)($2)
	nop
	sll	$2,$2,3
	addiu	$2,$2,3
	sw	$2,40($fp)
	li	$2,11			# 0xb
	sw	$2,24($fp)
	lui	$2,%hi(angle2)
	lw	$2,%lo(angle2)($2)
	nop
	bne	$2,$0,$L112
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,3
	sw	$2,24($fp)
$L112:
	li	$2,3			# 0x3
	sw	$2,32($fp)
	b	$L113
	nop

$L115:
	lui	$2,%hi(angle2)
	lw	$3,%lo(angle2)($2)
	lw	$2,32($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$2,$3,$2
	slt	$2,$2,8
	bne	$2,$0,$L114
	nop

	lui	$2,%hi(angle2)
	lw	$3,%lo(angle2)($2)
	lw	$2,32($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$2,$3,$2
	slt	$2,$2,65
	beq	$2,$0,$L114
	nop

	lui	$2,%hi(angle2)
	lw	$3,%lo(angle2)($2)
	lw	$2,32($fp)
	nop
	mult	$3,$2
	lw	$2,40($fp)
	mflo	$3
	addu	$4,$3,$2
	lw	$3,36($fp)
	lw	$2,32($fp)
	nop
	subu	$3,$3,$2
	li	$2,255			# 0xff
	sw	$2,16($sp)
	move	$7,$0
	move	$6,$0
	move	$5,$3
	jal	lcd_set_vbuf_pixel
	nop

$L114:
	lw	$2,32($fp)
	nop
	addiu	$2,$2,1
	sw	$2,32($fp)
$L113:
	lw	$3,32($fp)
	lw	$2,24($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L115
	nop

	nop
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	show_player
	.size	show_player, .-show_player
	.align	2
	.globl	btn_check_0
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_0
	.type	btn_check_0, @function
btn_check_0:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_0
	.size	btn_check_0, .-btn_check_0
	.align	2
	.globl	btn_check_1
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_1
	.type	btn_check_1, @function
btn_check_1:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_1
	.size	btn_check_1, .-btn_check_1
	.align	2
	.globl	btn_check_3
	.set	nomips16
	.set	nomicromips
	.ent	btn_check_3
	.type	btn_check_3, @function
btn_check_3:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	li	$2,65284			# 0xff04
	sw	$2,0($fp)
	lw	$2,0($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	sltu	$2,$0,$2
	andi	$2,$2,0x00ff
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	btn_check_3
	.size	btn_check_3, .-btn_check_3
	.align	2
	.globl	led_set
	.set	nomips16
	.set	nomicromips
	.ent	led_set
	.type	led_set, @function
led_set:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	li	$2,65288			# 0xff08
	sw	$2,0($fp)
	lw	$2,0($fp)
	lw	$3,16($fp)
	nop
	sw	$3,0($2)
	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	led_set
	.size	led_set, .-led_set
	.align	2
	.globl	led_blink
	.set	nomips16
	.set	nomicromips
	.ent	led_blink
	.type	led_blink, @function
led_blink:
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$4,15			# 0xf
	jal	led_set
	nop

	sw	$0,16($fp)
	b	$L124
	nop

$L125:
	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L124:
	lw	$3,16($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L125
	nop

	move	$4,$0
	jal	led_set
	nop

	sw	$0,20($fp)
	b	$L126
	nop

$L127:
	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L126:
	lw	$3,20($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L127
	nop

	li	$4,15			# 0xf
	jal	led_set
	nop

	sw	$0,24($fp)
	b	$L128
	nop

$L129:
	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L128:
	lw	$3,24($fp)
	li	$2,262144			# 0x40000
	ori	$2,$2,0x93e0
	slt	$2,$3,$2
	bne	$2,$0,$L129
	nop

	move	$4,$0
	jal	led_set
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	led_blink
	.size	led_blink, .-led_blink
	.align	2
	.globl	lcd_wait
	.set	nomips16
	.set	nomicromips
	.ent	lcd_wait
	.type	lcd_wait, @function
lcd_wait:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	sw	$0,0($fp)
	b	$L131
	nop

$L132:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L131:
	lw	$3,0($fp)
	lw	$2,16($fp)
	nop
	slt	$2,$3,$2
	bne	$2,$0,$L132
	nop

	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_wait
	.size	lcd_wait, .-lcd_wait
	.align	2
	.globl	lcd_cmd
	.set	nomips16
	.set	nomicromips
	.ent	lcd_cmd
	.type	lcd_cmd, @function
lcd_cmd:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,32($fp)
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lbu	$3,32($fp)
	lw	$2,16($fp)
	nop
	sw	$3,0($2)
	li	$4,1000			# 0x3e8
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_cmd
	.size	lcd_cmd, .-lcd_cmd
	.align	2
	.globl	lcd_data
	.set	nomips16
	.set	nomicromips
	.ent	lcd_data
	.type	lcd_data, @function
lcd_data:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	move	$2,$4
	sb	$2,32($fp)
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lbu	$2,32($fp)
	nop
	ori	$3,$2,0x100
	lw	$2,16($fp)
	nop
	sw	$3,0($2)
	li	$4,200			# 0xc8
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_data
	.size	lcd_data, .-lcd_data
	.align	2
	.globl	lcd_pwr_on
	.set	nomips16
	.set	nomicromips
	.ent	lcd_pwr_on
	.type	lcd_pwr_on, @function
lcd_pwr_on:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,65292			# 0xff0c
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,512			# 0x200
	sw	$3,0($2)
	li	$2,655360			# 0xa0000
	ori	$4,$2,0xae60
	jal	lcd_wait
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_pwr_on
	.size	lcd_pwr_on, .-lcd_pwr_on
	.align	2
	.globl	lcd_init
	.set	nomips16
	.set	nomicromips
	.ent	lcd_init
	.type	lcd_init, @function
lcd_init:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	jal	lcd_pwr_on
	nop

	li	$4,160			# 0xa0
	jal	lcd_cmd
	nop

	li	$4,32			# 0x20
	jal	lcd_cmd
	nop

	li	$4,21			# 0x15
	jal	lcd_cmd
	nop

	move	$4,$0
	jal	lcd_cmd
	nop

	li	$4,95			# 0x5f
	jal	lcd_cmd
	nop

	li	$4,117			# 0x75
	jal	lcd_cmd
	nop

	move	$4,$0
	jal	lcd_cmd
	nop

	li	$4,63			# 0x3f
	jal	lcd_cmd
	nop

	li	$4,175			# 0xaf
	jal	lcd_cmd
	nop

	nop
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addiu	$sp,$sp,24
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_init
	.size	lcd_init, .-lcd_init
	.align	2
	.globl	lcd_set_vbuf_pixel
	.set	nomips16
	.set	nomicromips
	.ent	lcd_set_vbuf_pixel
	.type	lcd_set_vbuf_pixel, @function
lcd_set_vbuf_pixel:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	sw	$5,12($fp)
	sw	$6,16($fp)
	sw	$7,20($fp)
	lw	$2,16($fp)
	nop
	sra	$2,$2,5
	sw	$2,16($fp)
	lw	$2,20($fp)
	nop
	sra	$2,$2,5
	sw	$2,20($fp)
	lw	$2,24($fp)
	nop
	sra	$2,$2,6
	sw	$2,24($fp)
	lw	$2,16($fp)
	nop
	sll	$2,$2,5
	sll	$3,$2,24
	sra	$3,$3,24
	lw	$2,20($fp)
	nop
	sll	$2,$2,2
	sll	$2,$2,24
	sra	$2,$2,24
	or	$2,$3,$2
	sll	$3,$2,24
	sra	$3,$3,24
	lw	$2,24($fp)
	nop
	sll	$2,$2,24
	sra	$2,$2,24
	or	$2,$3,$2
	sll	$2,$2,24
	sra	$2,$2,24
	andi	$4,$2,0x00ff
	lui	$5,%hi(lcd_vbuf)
	lw	$3,8($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$5,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,12($fp)
	nop
	addu	$2,$3,$2
	sb	$4,0($2)
	nop
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_set_vbuf_pixel
	.size	lcd_set_vbuf_pixel, .-lcd_set_vbuf_pixel
	.align	2
	.globl	lcd_clear_vbuf
	.set	nomips16
	.set	nomicromips
	.ent	lcd_clear_vbuf
	.type	lcd_clear_vbuf, @function
lcd_clear_vbuf:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-16
	sw	$fp,12($sp)
	move	$fp,$sp
	sw	$0,0($fp)
	b	$L139
	nop

$L148:
	sw	$0,4($fp)
	b	$L140
	nop

$L147:
	lw	$3,4($fp)
	li	$2,47			# 0x2f
	beq	$3,$2,$L141
	nop

	lw	$2,4($fp)
	nop
	beq	$2,$0,$L141
	nop

	lw	$3,4($fp)
	li	$2,95			# 0x5f
	bne	$3,$2,$L142
	nop

$L141:
	lw	$2,0($fp)
	nop
	slt	$2,$2,9
	beq	$2,$0,$L143
	nop

$L142:
	lw	$3,0($fp)
	li	$2,9			# 0x9
	beq	$3,$2,$L143
	nop

	lw	$3,0($fp)
	li	$2,63			# 0x3f
	bne	$3,$2,$L144
	nop

$L143:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,0($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,4($fp)
	nop
	addu	$2,$3,$2
	li	$3,-1			# 0xffffffffffffffff
	sb	$3,0($2)
	b	$L145
	nop

$L144:
	lw	$2,0($fp)
	nop
	slt	$2,$2,10
	bne	$2,$0,$L146
	nop

	lui	$4,%hi(lcd_vbuf)
	lw	$3,0($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,4($fp)
	nop
	addu	$2,$3,$2
	li	$3,4			# 0x4
	sb	$3,0($2)
	b	$L145
	nop

$L146:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,0($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,4($fp)
	nop
	addu	$2,$3,$2
	sb	$0,0($2)
$L145:
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L140:
	lw	$2,4($fp)
	nop
	slt	$2,$2,96
	bne	$2,$0,$L147
	nop

	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L139:
	lw	$2,0($fp)
	nop
	slt	$2,$2,64
	bne	$2,$0,$L148
	nop

	nop
	move	$sp,$fp
	lw	$fp,12($sp)
	addiu	$sp,$sp,16
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_clear_vbuf
	.size	lcd_clear_vbuf, .-lcd_clear_vbuf
	.align	2
	.globl	lcd_sync_vbuf
	.set	nomips16
	.set	nomicromips
	.ent	lcd_sync_vbuf
	.type	lcd_sync_vbuf, @function
lcd_sync_vbuf:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$0,16($fp)
	b	$L150
	nop

$L153:
	sw	$0,20($fp)
	b	$L151
	nop

$L152:
	lui	$4,%hi(lcd_vbuf)
	lw	$3,16($fp)
	nop
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	sll	$2,$2,5
	addiu	$3,$4,%lo(lcd_vbuf)
	addu	$3,$2,$3
	lw	$2,20($fp)
	nop
	addu	$2,$3,$2
	lbu	$2,0($2)
	nop
	move	$4,$2
	jal	lcd_data
	nop

	lw	$2,20($fp)
	nop
	addiu	$2,$2,1
	sw	$2,20($fp)
$L151:
	lw	$2,20($fp)
	nop
	slt	$2,$2,96
	bne	$2,$0,$L152
	nop

	lw	$2,16($fp)
	nop
	addiu	$2,$2,1
	sw	$2,16($fp)
$L150:
	lw	$2,16($fp)
	nop
	slt	$2,$2,64
	bne	$2,$0,$L153
	nop

	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_sync_vbuf
	.size	lcd_sync_vbuf, .-lcd_sync_vbuf
	.align	2
	.globl	lcd_putc
	.set	nomips16
	.set	nomicromips
	.ent	lcd_putc
	.type	lcd_putc, @function
lcd_putc:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	sw	$0,24($fp)
	b	$L155
	nop

$L159:
	sw	$0,28($fp)
	b	$L156
	nop

$L158:
	lw	$2,48($fp)
	nop
	addiu	$2,$2,-32
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(font8x8)
	addiu	$2,$2,%lo(font8x8)
	addu	$2,$3,$2
	lbu	$2,0($2)
	nop
	move	$3,$2
	lw	$2,24($fp)
	nop
	sra	$2,$3,$2
	andi	$2,$2,0x1
	beq	$2,$0,$L157
	nop

	lw	$2,40($fp)
	nop
	sll	$3,$2,3
	lw	$2,24($fp)
	nop
	addu	$4,$3,$2
	lw	$2,44($fp)
	nop
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$2,$3,$2
	sw	$0,16($sp)
	li	$7,255			# 0xff
	move	$6,$0
	move	$5,$2
	jal	lcd_set_vbuf_pixel
	nop

$L157:
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L156:
	lw	$2,28($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L158
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L155:
	lw	$2,24($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L159
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_putc
	.size	lcd_putc, .-lcd_putc
	.align	2
	.globl	lcd_putc_with_color
	.set	nomips16
	.set	nomicromips
	.ent	lcd_putc_with_color
	.type	lcd_putc_with_color, @function
lcd_putc_with_color:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	sw	$7,52($fp)
	sw	$0,24($fp)
	b	$L161
	nop

$L165:
	sw	$0,28($fp)
	b	$L162
	nop

$L164:
	lw	$2,48($fp)
	nop
	addiu	$2,$2,-32
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$3,$3,$2
	lui	$2,%hi(font8x8)
	addiu	$2,$2,%lo(font8x8)
	addu	$2,$3,$2
	lbu	$2,0($2)
	nop
	move	$3,$2
	lw	$2,24($fp)
	nop
	sra	$2,$3,$2
	andi	$2,$2,0x1
	beq	$2,$0,$L163
	nop

	lw	$2,40($fp)
	nop
	sll	$3,$2,3
	lw	$2,24($fp)
	nop
	addu	$4,$3,$2
	lw	$2,44($fp)
	nop
	sll	$3,$2,3
	lw	$2,28($fp)
	nop
	addu	$3,$3,$2
	lw	$2,60($fp)
	nop
	sw	$2,16($sp)
	lw	$7,56($fp)
	lw	$6,52($fp)
	move	$5,$3
	jal	lcd_set_vbuf_pixel
	nop

$L163:
	lw	$2,28($fp)
	nop
	addiu	$2,$2,1
	sw	$2,28($fp)
$L162:
	lw	$2,28($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L164
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L161:
	lw	$2,24($fp)
	nop
	slt	$2,$2,8
	bne	$2,$0,$L165
	nop

	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_putc_with_color
	.size	lcd_putc_with_color, .-lcd_putc_with_color
	.align	2
	.globl	lcd_puts
	.set	nomips16
	.set	nomicromips
	.ent	lcd_puts
	.type	lcd_puts, @function
lcd_puts:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 24, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$6,48($fp)
	sw	$7,52($fp)
	lw	$2,44($fp)
	nop
	sw	$2,24($fp)
	b	$L167
	nop

$L170:
	lw	$2,24($fp)
	lw	$3,48($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	slt	$2,$2,32
	bne	$2,$0,$L171
	nop

	lw	$2,24($fp)
	lw	$3,48($fp)
	nop
	addu	$2,$3,$2
	lb	$2,0($2)
	nop
	move	$3,$2
	lw	$2,60($fp)
	nop
	sw	$2,20($sp)
	lw	$2,56($fp)
	nop
	sw	$2,16($sp)
	lw	$7,52($fp)
	move	$6,$3
	lw	$5,24($fp)
	lw	$4,40($fp)
	jal	lcd_putc_with_color
	nop

	lw	$2,24($fp)
	nop
	addiu	$2,$2,1
	sw	$2,24($fp)
$L167:
	lw	$2,24($fp)
	nop
	slt	$2,$2,12
	bne	$2,$0,$L170
	nop

	b	$L169
	nop

$L171:
	nop
$L169:
	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	lcd_puts
	.size	lcd_puts, .-lcd_puts
	.align	2
	.globl	kypd_scan
	.set	nomips16
	.set	nomicromips
	.ent	kypd_scan
	.type	kypd_scan, @function
kypd_scan:
	.frame	$fp,32,$31		# vars= 24, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$fp,28($sp)
	move	$fp,$sp
	li	$2,65304			# 0xff18
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,7			# 0x7
	sw	$3,0($2)
	sw	$0,0($fp)
	b	$L173
	nop

$L174:
	lw	$2,0($fp)
	nop
	addiu	$2,$2,1
	sw	$2,0($fp)
$L173:
	lw	$2,0($fp)
	nop
	blez	$2,$L174
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L175
	nop

	li	$2,1			# 0x1
	b	$L176
	nop

$L175:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L177
	nop

	li	$2,4			# 0x4
	b	$L176
	nop

$L177:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L178
	nop

	li	$2,7			# 0x7
	b	$L176
	nop

$L178:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L179
	nop

	move	$2,$0
	b	$L176
	nop

$L179:
	lw	$2,16($fp)
	li	$3,11			# 0xb
	sw	$3,0($2)
	sw	$0,4($fp)
	b	$L180
	nop

$L181:
	lw	$2,4($fp)
	nop
	addiu	$2,$2,1
	sw	$2,4($fp)
$L180:
	lw	$2,4($fp)
	nop
	blez	$2,$L181
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L182
	nop

	li	$2,2			# 0x2
	b	$L176
	nop

$L182:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L183
	nop

	li	$2,5			# 0x5
	b	$L176
	nop

$L183:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L184
	nop

	li	$2,8			# 0x8
	b	$L176
	nop

$L184:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L185
	nop

	li	$2,15			# 0xf
	b	$L176
	nop

$L185:
	lw	$2,16($fp)
	li	$3,13			# 0xd
	sw	$3,0($2)
	sw	$0,8($fp)
	b	$L186
	nop

$L187:
	lw	$2,8($fp)
	nop
	addiu	$2,$2,1
	sw	$2,8($fp)
$L186:
	lw	$2,8($fp)
	nop
	blez	$2,$L187
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L188
	nop

	li	$2,3			# 0x3
	b	$L176
	nop

$L188:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L189
	nop

	li	$2,6			# 0x6
	b	$L176
	nop

$L189:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L190
	nop

	li	$2,9			# 0x9
	b	$L176
	nop

$L190:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L191
	nop

	li	$2,14			# 0xe
	b	$L176
	nop

$L191:
	lw	$2,16($fp)
	li	$3,14			# 0xe
	sw	$3,0($2)
	sw	$0,12($fp)
	b	$L192
	nop

$L193:
	lw	$2,12($fp)
	nop
	addiu	$2,$2,1
	sw	$2,12($fp)
$L192:
	lw	$2,12($fp)
	nop
	blez	$2,$L193
	nop

	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x80
	bne	$2,$0,$L194
	nop

	li	$2,10			# 0xa
	b	$L176
	nop

$L194:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x40
	bne	$2,$0,$L195
	nop

	li	$2,11			# 0xb
	b	$L176
	nop

$L195:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x20
	bne	$2,$0,$L196
	nop

	li	$2,12			# 0xc
	b	$L176
	nop

$L196:
	lw	$2,16($fp)
	nop
	lw	$2,0($2)
	nop
	andi	$2,$2,0x10
	bne	$2,$0,$L197
	nop

	li	$2,13			# 0xd
	b	$L176
	nop

$L197:
	move	$2,$0
$L176:
	move	$sp,$fp
	lw	$fp,28($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	kypd_scan
	.size	kypd_scan, .-kypd_scan
	.align	2
	.globl	play_song
	.set	nomips16
	.set	nomicromips
	.ent	play_song
	.type	play_song, @function
play_song:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	li	$2,65316			# 0xff24
	sw	$2,16($fp)
	lw	$2,16($fp)
	li	$3,5			# 0x5
	sw	$3,0($2)
	lw	$2,16($fp)
	nop
	sw	$0,0($2)
	li	$4,13000			# 0x32c8
	jal	lcd_wait
	nop

	lw	$2,16($fp)
	li	$3,1			# 0x1
	sw	$3,0($2)
	nop
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	play_song
	.size	play_song, .-play_song
	.data
	.align	2
	.type	led_ptr.1484, @object
	.size	led_ptr.1484, 4
led_ptr.1484:
	.word	65288
	.ident	"GCC: (GNU) 7.4.0"
