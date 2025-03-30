Extension { #name : #LanguageLinkApplication }

{ #category : #'*MiscGTScripts' }
LanguageLinkApplication >> gtAllInterestingSlots [
	^ OrderedCollection new
		addAll: self gtInterestingSlots;
		addAll: (self gtInterestingSlots flatCollect: [: x | x gtInterestingSlots]);
		yourself
]

{ #category : #'*MiscGTScripts' }
LanguageLinkApplication >> gtInterestingSlots [
	^ {communicationHandler.
		executionHandler.
		loggingHandler.
		processHandler.
		settings}
]
