simulation stack
ssPushConstant: literal
	self ssPush: 1.
	self updateSimSpillBase.
	self ssTop
		type: SSConstant;
		spilled: false;
		annotateUse: false;
		constant: literal;
		bcptr: bytecodePC.
	^0