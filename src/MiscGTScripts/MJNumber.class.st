Class {
	#name : #MJNumber,
	#superclass : #MJTile,
	#instVars : [
		'suit',
		'number'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJNumber class >> man: num [
	^ self new suit: #man number: num
]

{ #category : #accessing }
MJNumber class >> new: num [
	^ self new new: num
]

{ #category : #accessing }
MJNumber class >> pin: num [
	^ self new suit: #pin number: num
]

{ #category : #accessing }
MJNumber class >> wan: num [
	^ self man: num
]

{ #category : #accessing }
MJNumber class >> zhu: num [
	^ self new suit: #zhu number: num
]

{ #category : #accessing }
MJNumber class >> 竹: num [
	^ self zhu: num
]

{ #category : #accessing }
MJNumber class >> 萬: num [
	^ self man: num
]

{ #category : #accessing }
MJNumber >> image: aView [
	<gtView>
	^ self visualize image: aView
]

{ #category : #predicates }
MJNumber >> isSpecial [
	^ false
]

{ #category : #accessing }
MJNumber >> kind [
	^ suit
]

{ #category : #accessing }
MJNumber >> new: num [
	suit := 'pin'.	"random default"
	number := num
]

{ #category : #accessing }
MJNumber >> number [
	^ number isZero ifTrue: [ 5 ] ifFalse: [ number ]
]

{ #category : #creating }
MJNumber >> number: num [
	^ self class new suit: self suit number: num
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
	^ self class = tile class and: [ self suit = tile suit ]
]

{ #category : #accessing }
MJNumber >> suit [
	^ self kind
]

{ #category : #accessing }
MJNumber >> suit: su number: num [
	number := num.
	suit := su.
	^ self
]

{ #category : #accessing }
MJNumber >> uniqueHash [
	^ self number hash + self valueSort hash
]

{ #category : #accessing }
MJNumber >> value [
	^ number
]

{ #category : #accessing }
MJNumber >> valueSort [
	#man = suit ifTrue: [ ^ 256 * self number ].
	#pin = suit ifTrue: [ ^ 65536 * self number ].
	#zhu = suit ifTrue: [ ^ 16777216 * self number ]
]

{ #category : #accessing }
MJNumber >> visualize [
	^ MJTileVisualizerTenhou suit: suit number: number
]
