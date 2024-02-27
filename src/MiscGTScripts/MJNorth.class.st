Class {
	#name : #MJNorth,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJNorth >> name [
	^ #north
]

{ #category : #equality }
MJNorth >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 2)
]

{ #category : #visualization }
MJNorth >> visualizationNumber [
	^ 4
]
