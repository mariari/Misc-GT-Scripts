Class {
	#name : #MJRed,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJRed class >> numericRepresentation [
	^ 7
]

{ #category : #accessing }
MJRed class >> suit [
	^ #red
]

{ #category : #equality }
MJRed >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 3)
]
