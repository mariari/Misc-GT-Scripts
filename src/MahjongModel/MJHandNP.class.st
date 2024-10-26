Class {
	#name : #MJHandNP,
	#superclass : #MJHand,
	#category : #'MahjongModel-Tiles'
}

{ #category : #accessing }
MJHandNP >> groups [
	^ (tiles size / 3) ceiling
]

{ #category : #accessing }
MJHandNP >> pair [
	^ false
]
