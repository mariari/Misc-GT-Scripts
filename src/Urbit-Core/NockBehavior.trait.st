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
	^ ((self jamWith: JamContextFast new and: (BitStream on: NockBinaryAtom new))
		at: 2) finalizeWithBytePaddingStart reversed
]

{ #category : #encoding }
NockBehavior >> jamAnnotated [
	| aResult |
	aResult := self
			jamWith: JamContextAnnotated new
			and: (BitStream on: NockBinaryAtom new).
	^ {aResult at: 1.
		(aResult at: 2) finalizeWithBytePaddingStart reversed}
]

{ #category : #presentation }
NockBehavior >> jamAnnotatedText [
	| annotation text jam |
	annotation := self jamAnnotated.
	jam := annotation at: 2.
	text := jam asBitString asRopedText.
	(annotation at: 1) annotations
		do: [ :jamStar | jamStar annotateFullJam: text paddingAdded: 8 - (jam bitSize rem: 8) ].
	^ text
]

{ #category : #encoding }
NockBehavior >> jamWith: aContext and: aBitStream [
	<argument: #aContext isKindOf: #JamContextAbstract>
	<argument: #bitBuffer isKindOf: #BitStream>
	^ self explicitRequirement
]
