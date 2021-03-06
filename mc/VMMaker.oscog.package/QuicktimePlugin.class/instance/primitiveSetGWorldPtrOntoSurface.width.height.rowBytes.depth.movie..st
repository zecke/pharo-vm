system primitives
primitiveSetGWorldPtrOntoSurface: bitMapPtr width: width height: height rowBytes: rowBytes depth: depth movie: moviePtr
	| buffer movie results |

	<var: #buffer type: #'char *'>
	<var: #movie type: #'long'>
	self primitive: 'primitiveSetGWorldPtrOntoSurface'  parameters:#(Oop SmallInteger SmallInteger SmallInteger SmallInteger Oop).
	buffer := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: bitMapPtr) to: 'char *'.
	movie := self cCoerce: (interpreterProxy positiveMachineIntegerValueOf: moviePtr) to: 'long'.
	results := self stQuicktimeSetSurface: buffer width: width height: height rowBytes: rowBytes depth: depth movie: movie.
	^results asOop: SmallInteger 