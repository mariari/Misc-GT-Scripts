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
JamContextAnnotated >> addCell: cell [
	dictionary
		at: cell
		put: (JamNoun new
				data: cell;
				start: offset).
	offset := offset + 2
]

{ #category : #'as yet unclassified' }
JamContextAnnotated >> annotations [
	^ dictionary values
]

{ #category : #add }
JamContextAnnotated >> finalizeCell: noun [
	"The offset has been mutated so this should be enough info to know when the cell is over"

	(dictionary at: noun) end: offset
]
