Class {
	#name : #MJEast,
	#superclass : #MJFace,
	#category : #'MahjongModel-Tiles'
}

{ #category : #representations }
MJEast class >> numericRepresentation [
	^ 1
]

{ #category : #accessing }
MJEast class >> suit [
	^ #east
]

{ #category : #equality }
MJEast >> valueSort [
	^ 4294967296
]
