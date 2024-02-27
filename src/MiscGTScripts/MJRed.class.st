Class {
	#name : #MJRed,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJRed >> name [
	^ #red
]

{ #category : #equality }
MJRed >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 3)
]

{ #category : #visualization }
MJRed >> visualizationNumber [
	^ 7
]
