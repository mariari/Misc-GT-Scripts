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

{ #category : #accessing }
NockIntegerAtom >> data [
	^ data
]

{ #category : #accessing }
NockIntegerAtom >> data: anObject [
	data := anObject
]
