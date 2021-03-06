primitive support
positive64BitIntegerFor: integerValue
	<api>
	<var: 'integerValue' type: #sqLong>
	"Answer a Large Positive Integer object for the given integer value.  N.B. will *not* cause a GC."
	| newLargeInteger highWord sz |
	objectMemory hasSixtyFourBitImmediates
		ifTrue:
			[(integerValue >= 0 and: [objectMemory isIntegerValue: integerValue]) ifTrue:
				[^objectMemory integerObjectOf: integerValue].
			 sz := 8]
		ifFalse:
			[(highWord := integerValue >>> 32) = 0 ifTrue:
				[^self positive32BitIntegerFor: integerValue].
			 sz := 5.
			 (highWord := highWord >> 8) = 0 ifFalse:
				[sz := sz + 1.
				 (highWord := highWord >> 8) = 0 ifFalse:
					[sz := sz + 1.
					 (highWord := highWord >> 8) = 0 ifFalse:[sz := sz + 1]]]].
	newLargeInteger := objectMemory
							eeInstantiateSmallClassIndex: ClassLargePositiveIntegerCompactIndex
							format: (objectMemory byteFormatForNumBytes: sz)
							numSlots: 8 / objectMemory bytesPerOop.
	self cppIf: VMBIGENDIAN
		ifTrue:
			[objectMemory
				storeByte: 7 ofObject: newLargeInteger withValue: (integerValue >> 56 bitAnd: 16rFF);
				storeByte: 6 ofObject: newLargeInteger withValue: (integerValue >> 48 bitAnd: 16rFF);
				storeByte: 5 ofObject: newLargeInteger withValue: (integerValue >> 40 bitAnd: 16rFF);
				storeByte: 4 ofObject: newLargeInteger withValue: (integerValue >> 32 bitAnd: 16rFF);
				storeByte: 3 ofObject: newLargeInteger withValue: (integerValue >> 24 bitAnd: 16rFF);
				storeByte: 2 ofObject: newLargeInteger withValue: (integerValue >> 16 bitAnd: 16rFF);
				storeByte: 1 ofObject: newLargeInteger withValue: (integerValue >>   8 bitAnd: 16rFF);
				storeByte: 0 ofObject: newLargeInteger withValue: (integerValue ">> 0" bitAnd: 16rFF)]
		ifFalse:
			[objectMemory storeLong64: 0 ofObject: newLargeInteger withValue: integerValue].
	^newLargeInteger
