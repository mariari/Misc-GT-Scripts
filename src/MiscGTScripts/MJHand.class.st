Class {
	#name : #MJHand,
	#superclass : #MJTiles,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJHand class >> hand: aCollection [
	^ self new withHand: aCollection
]

{ #category : #accessing }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
