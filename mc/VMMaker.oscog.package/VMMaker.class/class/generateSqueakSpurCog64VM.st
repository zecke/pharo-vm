configurations
generateSqueakSpurCog64VM
	"No primitives since we can use those for the Cog VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(ObjectMemory Spur64BitCoMemoryManager)
		to: (FileDirectory default pathFromURI: self sourceTree, '/spur64src')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#()