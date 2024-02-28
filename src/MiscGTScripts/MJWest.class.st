Class {
	#name : #MJWest,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJWest class >> numericRepresentation [
	^ 3
]

{ #category : #accessing }
MJWest class >> suit [
	^ #west
]

{ #category : #equality }
MJWest >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 5)
]
