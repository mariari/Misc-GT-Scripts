Class {
	#name : #MJNumber,
	#superclass : #MJTile,
	#instVars : [
		'number'
	],
	#category : #'MahjongModel-Tiles'
}

{ #category : #creation }
MJNumber class >> dora [
	^ self subclassResponsibility
]

{ #category : #creation }
MJNumber class >> new: aNumber [
	^ aNumber isZero
		ifTrue: [ self dora new ]
		ifFalse: [ self new number: aNumber ]
]

{ #category : #private }
MJNumber class >> resolveSuit: kind with: aNum [
	^ self subclasses
		detect: [ :each | kind = each suit ]
		ifFound: [ :aClass | aClass new: aNum ]
		ifNone: [ NotFound error ]
]

{ #category : #visualization }
MJNumber >> image: aView [
	<gtView>
	^ self visualize image: aView
]

{ #category : #predicates }
MJNumber >> isSpecial [
	^ false
]

{ #category : #accessing }
MJNumber >> number [
	^ number
]

{ #category : #creating }
MJNumber >> number: num [
	number := num.
	^ self
]

{ #category : #visualization }
MJNumber >> numericRepresentation [
	^ number
]

{ #category : #predicates }
MJNumber >> runsWith: tile [
	| num |
	num := self number.
	^ (self sameSuit: tile)
		and: [ (self sameAs: tile) not and: [ tile number between: num - 2 and: num + 2 ] ]
]

{ #category : #predicates }
MJNumber >> sameAs: tile [
	^ (self sameSuit: tile) and: [ tile number = self number ]
]

{ #category : #predicates }
MJNumber >> sameSuit: tile [
	^ self suit = tile suit
]

{ #category : #equality }
MJNumber >> uniqueHash [
	^ self number hash + self valueSort hash
]

{ #category : #accessing }
MJNumber >> value [
	^ number
]

{ #category : #visualization }
MJNumber >> visualize [
	^ MJTileVisualizerTenhou suit: self suit number: self numericRepresentation
]
