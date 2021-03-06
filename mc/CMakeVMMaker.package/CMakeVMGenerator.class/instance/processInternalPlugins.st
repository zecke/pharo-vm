processing plugins
processInternalPlugins

	| libs |
	libs := OrderedCollection new.

	config internalPlugins collect: [:each | | plugin gen |
		plugin := Smalltalk at: each.
		gen := plugin generateFor: self internal: true.
		gen doNotGenerate ifFalse: [
			libs add: plugin moduleNameForGenerate.
			self addSubdirectory: plugin moduleNameForGenerate.
			 ].
		].
	
	self cmd: 'target_link_libraries' params:  config executableName , ' ' ,
		(libs inject: '' into: [:res :ea | res, ' ' , ea ]) .

	self generateExportsH: libs.
