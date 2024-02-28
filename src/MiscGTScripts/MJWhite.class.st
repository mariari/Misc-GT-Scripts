Class {
	#name : #MJWhite,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJWhite class >> numericRepresentation [
	^ 5
]

{ #category : #accessing }
MJWhite class >> suit [
	^ #white
]

{ #category : #equality }
MJWhite >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 6)
]
