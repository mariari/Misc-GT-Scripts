Class {
	#name : #JamBackref,
	#superclass : #JamAtomKind,
	#instVars : [
		'referencedAtom'
	],
	#category : #'Urbit-Core-Nock'
}

{ #category : #annotation }
JamBackref >> tagLength [
	^ 2
]
