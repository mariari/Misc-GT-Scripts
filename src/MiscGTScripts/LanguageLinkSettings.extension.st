Extension { #name : #LanguageLinkSettings }

{ #category : #'*MiscGTScripts' }
LanguageLinkSettings >> gtInterestingSlots [
	^ {commandClass.
		commandFactoryClass.
		deserializerClass.
		messageBroker.
		messageBrokerStrategy.
		parserClass.
		platform.
		serializerClass.
		serverProcessClass}
]
