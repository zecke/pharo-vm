weakness and ephemerality
allUnscannedEphemeronsAreActive
	unscannedEphemerons start to: unscannedEphemerons top - self bytesPerOop do:
		[:p| | key |
		key := self keyOfEphemeron: (self longAt: p).
		((self isImmediate: key) or: [self isMarked: key]) ifTrue:
			[^false]].
	^true