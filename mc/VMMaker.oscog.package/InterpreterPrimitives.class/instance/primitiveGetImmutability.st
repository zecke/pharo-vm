object access primitives
primitiveGetImmutability
	<option: #IMMUTABILITY>
	| rcvr bool |
	rcvr := self stackValue: 0.
	bool := (objectMemory isOopImmutable: rcvr)
		ifTrue: [ TrueObject ]
		ifFalse: [ FalseObject ].
	self pop: argumentCount + 1 thenPush: (objectMemory splObj: bool)