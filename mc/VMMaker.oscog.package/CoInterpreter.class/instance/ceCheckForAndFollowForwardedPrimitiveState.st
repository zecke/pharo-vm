cog jit support
ceCheckForAndFollowForwardedPrimitiveState
	"In Spur a primitive may fail due to encountering a forwarder.
	 On failure check the accessorDepth for the primitive and
	 if non-negative scan the args to the depth, following any
	 forwarders.  Answer if any are found so the prim can be retried."
	<api>
	<option: #SpurObjectMemory>
	^self cCode: [self checkForAndFollowForwardedPrimitiveState]
		inSmalltalk: [(self checkForAndFollowForwardedPrimitiveState)
						ifTrue: [1]
						ifFalse: [0]]