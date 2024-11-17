Trait {
	#name : #NockBehavior,
	#category : #'Urbit-Core-Nock'
}

{ #category : #predicates }
NockBehavior >> isAtom [
	^ self explicitRequirement
]

{ #category : #predicates }
NockBehavior >> isCell [
	^ self explicitRequirement
]
