Class {
	#name : #MJHandP,
	#superclass : #MJHand,
	#category : #'MahjongModel-Tiles'
}

{ #category : #accessing }
MJHandP >> groups [
	^ (tiles size / 3) floor
]

{ #category : #accessing }
MJHandP >> pair [
	^ true
]
