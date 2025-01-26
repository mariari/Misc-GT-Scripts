Class {
	#name : #NockCell,
	#superclass : #Array,
	#type : #variable,
	#traits : 'NockBehavior',
	#classTraits : 'NockBehavior classTrait',
	#category : #'Urbit-Core-Nock'
}

{ #category : #encoding }
NockCell >> jamWith: aContext and: aBitStream [
	"We need to make cells from the rest, we need an index to keep move things on. The Context and bitBuffer are mutable."

	"We are in the binary noun case."

	<argument: #aContext isKindOf: #JamContextAbstract>
	<argument: #bitBuffer isKindOf: #BitStream>
	| jamHead jamTail restCell |
	restCell := self size = 2 ifTrue: [ self second ] ifFalse: [ self allButFirst ].

	aContext addCell: self.
	jamHead := self first
			jamWith: aContext
			and: (aBitStream species on: NockBinaryAtom new).
	jamTail := restCell
			jamWith: aContext
			and: (aBitStream species on: NockBinaryAtom new).
	aBitStream nextPutBitStream: (jamTail at: 2).
	aBitStream nextPutBitStream: (jamHead at: 2).
	aBitStream nextPutBit: 0.
	aBitStream nextPutBit: 1.
	aContext finalizeCell: self.
	^ {aContext.
		aBitStream}
]
