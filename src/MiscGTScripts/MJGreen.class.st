Class {
	#name : #MJGreen,
	#superclass : #MJFace,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJGreen >> name [
	^ #green
]

{ #category : #equality }
MJGreen >> valueSort [
	^ 4294967296 * (2 bitShift: 5)
]

{ #category : #visualization }
MJGreen >> visualizationNumber [
	^ 6
]
