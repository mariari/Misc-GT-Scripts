Class {
	#name : #MJWhite,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJWhite >> name [
	^ #white
]

{ #category : #equality }
MJWhite >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 6)
]

{ #category : #visualization }
MJWhite >> visualizationNumber [
	^ 5
]
