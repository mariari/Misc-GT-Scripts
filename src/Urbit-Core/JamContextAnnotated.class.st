"
I focus on providing annotations to better illustrate how Jam ought to look
"
Class {
	#name : #JamContextAnnotated,
	#superclass : #JamContextAbstract,
	#category : #'Urbit-Core-Nock'
}

{ #category : #add }
JamContextAnnotated >> addAtom: atom size: atomSize lenSize: atomLenSize [
	| newOffset |
	newOffset := atomLenSize * 2 + atomSize + offset + 1.
	dictionary
		at: atom
		put: (JamAtom new
				data: atom;
				lenSize: atomLenSize;
				start: offset;
				end: newOffset).
	offset := newOffset
]

{ #category : #add }
JamContextAnnotated >> addNoun: noun withSize: aSize [
	| newOffset |
	newOffset := offset + aSize + 2.
	dictionary
		at: noun
		put: (JamNoun new
				data: noun;
				start: offset;
				end: newOffset).
	offset := newOffset
]

{ #category : #'as yet unclassified' }
JamContextAnnotated >> annotations [
	^ dictionary values
]
