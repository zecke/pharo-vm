object access primitives
primitiveObjectPointsTo
	| rcvr thang lastField |
	thang := self popStack.
	rcvr := self popStack.
	(self isIntegerObject: rcvr) ifTrue: [^self pushBool: false].

	lastField := self lastPointerOf: rcvr.
	self baseHeaderSize to: lastField by: self wordSize do:
		[:i | (self longAt: rcvr + i) = thang
			ifTrue: [^ self pushBool: true]].
	self pushBool: false.