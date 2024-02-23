Class {
	#name : #MJHand,
	#superclass : #MJTiles,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJHand class >> allTiles [
	^ '123456789m123456789p123456789s1234567z' asMJHand
]

{ #category : #accessing }
MJHand class >> with: aCollection [
	^ self new withHand: aCollection
]

{ #category : #accessing }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
