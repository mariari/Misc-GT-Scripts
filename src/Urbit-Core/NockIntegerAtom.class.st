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

{ #category : #predicates }
NockIntegerAtom >> isAtom [
	^ true
]

{ #category : #predicates }
NockIntegerAtom >> isCell [
	^ false
]

{ #category : #printing }
NockIntegerAtom >> printOn: aStream [
	data printOn: aStream
]

{ #category : #printing }
NockIntegerAtom >> printString [
	^ data printString
]
