Extension { #name : #LanguageLinkExecutionHandler }

{ #category : #'*MiscGTScripts' }
LanguageLinkExecutionHandler >> gtInterestingSlots [
	^ {commandQueue.
		mapperFactory.
		objectRegistry.
		promiseRegistry.
		weakRegistry}
]
