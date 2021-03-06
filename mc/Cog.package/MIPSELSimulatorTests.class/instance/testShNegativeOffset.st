tests - memory
testShNegativeOffset
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler shR: A1 base: A0 offset: -4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  A485FFFC  sh a1, -4(a0)
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			simulator call: 0 with: 16rE8 with: 16r2B2A with: 0 with: 0.
			self should: [simulator call: 0 with: 16rE9 with: 0 with: 0 with: 0] raise: Error.
			simulator call: 0 with: 16rEA with: 16r2D2C with: 0 with: 0.
			self should: [simulator call: 0 with: 16rEB with: 0 with: 0 with: 0] raise: Error.
			simulator call: 0 with: 16rF8 with: -16r2A2A with: 0 with: 0.
			self should: [simulator call: 0 with: 16rF9 with: 0 with: 0 with: 0] raise: Error.
			simulator call: 0 with: 16rFA with: -16r2C2C with: 0 with: 0.
			self should: [simulator call: 0 with: 16rFB with: 0 with: 0 with: 0] raise: Error.
			self assert: (simulator memory at: 16rE4 + 1) equals: 42.
			self assert: (simulator memory at: 16rE5 + 1) equals: 43.
			self assert: (simulator memory at: 16rE6 + 1) equals: 44.
			self assert: (simulator memory at: 16rE7 + 1) equals: 45.
			self assert: (simulator memory at: 16rF4 + 1) equals: 16r100 - 42.
			self assert: (simulator memory at: 16rF5 + 1) equals: 16r100 - 43.
			self assert: (simulator memory at: 16rF6 + 1) equals: 16r100 - 44.
			self assert: (simulator memory at: 16rF7 + 1) equals: 16r100 - 45].