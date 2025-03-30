Extension { #name : #LanguageLinkCommunicationHandler }

{ #category : #'*MiscGTScripts' }
LanguageLinkCommunicationHandler >> gtAllInterestingSlots [
	^ OrderedCollection new
		addAll: self gtInterestingSlots;
		addAll: (self gtInterestingSlots flatCollect: [ :value | value gtInterestingSlots ]);
		yourself
]

{ #category : #'*MiscGTScripts' }
LanguageLinkCommunicationHandler >> gtInterestingSlots [
	^ {messageBroker}
]
