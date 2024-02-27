Class {
	#name : #MJSouth,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJSouth >> name [
	^ #south
]

{ #category : #equality }
MJSouth >> valueSort [
	^ 4294967296 * (2 bitShift: 5 * 4)
]

{ #category : #visualization }
MJSouth >> visualizationNumber [
	^ 2
]
