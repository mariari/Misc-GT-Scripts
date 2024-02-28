Class {
	#name : #MJNorth,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #representations }
MJNorth class >> numericRepresentation [
	^ 4
]

{ #category : #accessing }
MJNorth class >> suit [
	^ #north
]

{ #category : #equality }
MJNorth >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 2)
]
