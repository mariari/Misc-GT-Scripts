Class {
	#name : #MJGreen,
	#superclass : #MJFace,
	#category : #'MahjongModel-Tiles'
}

{ #category : #representations }
MJGreen class >> numericRepresentation [
	^ 6
]

{ #category : #accessing }
MJGreen class >> suit [
	^ #green
]

{ #category : #equality }
MJGreen >> valueSort [
	^ 4294967296 * (2 bitShift: 5)
]
