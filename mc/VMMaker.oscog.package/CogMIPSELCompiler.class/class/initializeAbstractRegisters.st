class initialization
initializeAbstractRegisters
	"Assign the abstract registers with the identities/indices of the relevant concrete registers."

	"See MIPSConstants>>initializeRegisters for a description of the C ABI."

	"Note we can fit all of the abstract registers in C preserved registers, and
	 not need to save or restore them at runtime calls."
	super initializeAbstractRegisters.

	ReceiverResultReg		:= S0.
	Arg0Reg				:= S1.
	Arg1Reg				:= S2.
	ClassReg				:= S3.
	SendNumArgsReg		:= S4.
	TempReg				:= S5.
	VarBaseReg			:= S6. "Must be callee saved"
	SPReg					:= SP.
	FPReg					:= FP.
	RISCTempReg			:= AT.
	LinkReg					:= RA.

	self flag: #todo.
	"Scratch0Reg			:= ??.
	Scratch1Reg			:= ??.
	Scratch2Reg			:= ??.
	Scratch3Reg			:= ??.
	Scratch4Reg			:= ??.
	Scratch5Reg			:= ??.
	Scratch6Reg			:= ??.
	Scratch7Reg			:= ??."

	self flag: #todo.
	"DPFPReg0				:= ??.
	DPFPReg1				:= ??.
	DPFPReg2				:= ??.
	DPFPReg3				:= ??.
	DPFPReg4				:= ??.
	DPFPReg5				:= ??.
	DPFPReg6				:= ??.
	DPFPReg7				:= ??.
	DPFPReg8				:= ??.
	DPFPReg9				:= ??.
	DPFPReg10				:= ??.
	DPFPReg11				:= ??.
	DPFPReg12				:= ??.
	DPFPReg13				:= ??.
	DPFPReg14				:= ??.
	DPFPReg15				:= ??"