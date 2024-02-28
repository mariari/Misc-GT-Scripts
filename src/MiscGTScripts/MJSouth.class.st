Class {
	#name : #MJSouth,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJSouth class >> numericRepresentation [
	^ 2
]

{ #category : #accessing }
MJSouth class >> suit [
	^ #south
]

{ #category : #equality }
MJSouth >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 4)
]
