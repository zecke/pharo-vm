ARM convenience instructions
ldrh: destReg rn: baseReg rm: offsetReg
"	LDRH destReg, [baseReg, +offsetReg]
	The contents of offsetReg are assumed to be correctly signed"
	^self memM16xr: AL reg: destReg  base: baseReg p: 1 u: 1  w: 0 l: 1 rm: offsetReg