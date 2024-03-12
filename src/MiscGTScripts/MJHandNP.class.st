Class {
	#name : #MJHandNP,
	#superclass : #MJHand,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #accessing }
MJHandNP >> groups [
	^ (tiles size / 3) ceiling
]

{ #category : #accessing }
MJHandNP >> pair [
	^ false
]
