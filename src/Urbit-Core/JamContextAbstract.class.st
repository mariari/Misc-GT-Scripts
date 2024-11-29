Class {
	#name : #JamContextAbstract,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'offset'
	],
	#category : #'Urbit-Core-Nock'
}

{ #category : #add }
JamContextAbstract >> addAtom: atom size: atomSize lenSize: atomLenSize [
	^ self subclassResponsibility
]

{ #category : #add }
JamContextAbstract >> addBackref: location originalAtom: atom LocationSize: locSize [
	^ self subclassResponsibility
]

{ #category : #add }
JamContextAbstract >> addCell: aCell [
	^ self subclassResponsibility
]

{ #category : #accesing }
JamContextAbstract >> at: aNoun [
	^ self subclassResponsibility
]

{ #category : #add }
JamContextAbstract >> finalizeCell: aCell [
	^ SubclassResponsibility
]

{ #category : #initalization }
JamContextAbstract >> initialize [
	dictionary := Dictionary new.
	offset := 0
]
