"
I focus on trying to be a fast cache for computing backrefs
"
Class {
	#name : #JamContextFast,
	#superclass : #JamContextAbstract,
	#category : #'Urbit-Core-Nock'
}

{ #category : #add }
JamContextFast >> addAtom: atom size: atomSize lenSize: atomLenSize [
	"TODO double check the math with an example"

	dictionary at: atom put: offset.
	offset := atomLenSize * 2 + atomSize + offset + 1
]

{ #category : #add }
JamContextFast >> addBackref: location originalAtom: atom LocationSize: locSize [
	"we don't need to store backrefs"

	^ self
]

{ #category : #add }
JamContextFast >> addCell: cell [
	dictionary at: cell put: offset.
	offset := offset + 2
]

{ #category : #accesing }
JamContextFast >> at: aNoun [
	^ dictionary at: aNoun
]

{ #category : #add }
JamContextFast >> finalizeCell: noun [
	"no op, no need to store this information"

	
]
