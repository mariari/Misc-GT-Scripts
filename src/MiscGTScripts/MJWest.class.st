Class {
	#name : #MJWest,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJWest >> name [
	^ #west
]

{ #category : #equality }
MJWest >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 5)
]

{ #category : #visualization }
MJWest >> visualizationNumber [
	^ 3
]
