Class {
	#name : #NockIntegerAtom,
	#superclass : #Object,
	#traits : 'NockBehavior',
	#classTraits : 'NockBehavior classTrait',
	#instVars : [
		'data'
	],
	#category : #'Urbit-Core-Nock'
}

{ #category : #conversion }
NockIntegerAtom >> asBinary [
	^ NockBinaryAtom newFromArray: data asByteArray reversed
]

{ #category : #bits }
NockIntegerAtom >> bitSize [
	^ data highBit
]

{ #category : #accessing }
NockIntegerAtom >> data [
	^ data
]

{ #category : #accessing }
NockIntegerAtom >> data: anObject [
	data := anObject
]

{ #category : #views }
NockIntegerAtom >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Atom Info';
		object: [ self asBinary ];
		view: #gtJamInfo:
]

{ #category : #predicates }
NockIntegerAtom >> isAtom [
	^ true
]

{ #category : #predicates }
NockIntegerAtom >> isCell [
	^ false
]

{ #category : #encoding }
NockIntegerAtom >> jamWith: aContext and: aBitStream [
	<argument: #aContext isKindOf: #JamContextAbstract>
	<argument: #bitBuffer isKindOf: #BitStream>
	^ self asBinary jamWith: aContext and: aBitStream
]

{ #category : #printing }
NockIntegerAtom >> printOn: aStream [
	data printOn: aStream
]

{ #category : #printing }
NockIntegerAtom >> printString [
	^ data printString
]
