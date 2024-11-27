Trait {
	#name : #NockBehavior,
	#category : #'Urbit-Core-Nock'
}

{ #category : #encoding }
NockBehavior >> cue [
	^ self explicitRequirement
]

{ #category : #predicates }
NockBehavior >> isAtom [
	^ self explicitRequirement
]

{ #category : #predicates }
NockBehavior >> isCell [
	^ self explicitRequirement
]

{ #category : #encoding }
NockBehavior >> jam [
	^ ((self jamWith: Dictionary new) at: 2) finalizeWithBytePaddingStart reversed
]

{ #category : #encoding }
NockBehavior >> jamWith: aContext [
	^ self jamWith: aContext and: (BitStream on: NockBinaryAtom new)
]

{ #category : #encoding }
NockBehavior >> jamWith: aContext and: aBitStream [
	<argument: #aContext isKindOf: #Dictionary>
	<argument: #bitBuffer isKindOf: #BitStream>
	^ self explicitRequirement
]
