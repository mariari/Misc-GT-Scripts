Class {
	#name : #MJPin,
	#superclass : #MJNumber,
	#category : #'MahjongModel-Tiles'
}

{ #category : #representations }
MJPin class >> characterRepresentation [
	^ $p
]

{ #category : #creation }
MJPin class >> dora [
	^ MJDoraPin
]

{ #category : #accessing }
MJPin class >> suit [
	^ #pin
]

{ #category : #equality }
MJPin >> valueSort [
	^ (2 bitShift: 7 + 8) * self number
]
