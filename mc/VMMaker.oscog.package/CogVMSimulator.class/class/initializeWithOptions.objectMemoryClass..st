class initialization
initializeWithOptions: optionsDictionaryOrArray objectMemoryClass: objectMemoryClassOrNil
	"The relevant ObjectMemory, Interpreter and Cogit classes must be initialized in order.
	 This happens notionally every time we start the simulator,
	 but in fact happens when ever we instantiate a simulator."
	initializationOptions := optionsDictionaryOrArray isArray
							ifTrue: [Dictionary newFromPairs: optionsDictionaryOrArray]
							ifFalse: [optionsDictionaryOrArray].
	(objectMemoryClassOrNil ifNil: [self objectMemoryClass])
		initializeWithOptions: initializationOptions.

	self initializeWithOptions: initializationOptions.

	((initializationOptions at: #COGMTVM ifAbsent: [false])
			ifTrue: [CoInterpreterMT]
			ifFalse: [CoInterpreter])
		initializeWithOptions: initializationOptions.

	ByteCountsPerMicrosecond := initializationOptions
										at: #ByteCountsPerMicrosecond
										ifAbsent: [10].

	(self cogitClass withAllSuperclasses copyUpTo: Cogit) reverseDo:
		[:c| c initializeWithOptions: initializationOptions]