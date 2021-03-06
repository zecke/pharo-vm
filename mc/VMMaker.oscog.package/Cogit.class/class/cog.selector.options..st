in-image compilation
cog: aCompiledMethod selector: aSelector options: optionsDictionaryOrArray
	"StackToRegisterMappingCogit cog: (Integer >> #benchFib) selector: #benchFib options: #(COGMTVM false)"
	| initOptions coInterpreter cogit |
	initOptions := self asOptionsDictionary: optionsDictionaryOrArray.
	CoInterpreter initializeWithOptions: initOptions.
	CoInterpreter objectMemoryClass initializeWithOptions: initOptions.
	self initializeWithOptions: initOptions.
	coInterpreter := CurrentImageCoInterpreterFacade forCogit: (cogit := self new).
	[cogit
		setInterpreter: coInterpreter;
		singleStep: true;
		initializeCodeZoneFrom: 1024 upTo: coInterpreter memory size / 2. "leave space for rump C stack"
	 cogit methodZone freeStart: (cogit methodZone freeStart roundUpTo: 1024)]
		on: Notification
		do: [:ex|
			(ex messageText beginsWith: 'cannot find receiver for') ifTrue:
				[ex resume: coInterpreter].
			ex pass].
	^{ coInterpreter.
		cogit.
		cogit cog: (coInterpreter oopForObject: aCompiledMethod) selector: (coInterpreter oopForObject: aSelector) }