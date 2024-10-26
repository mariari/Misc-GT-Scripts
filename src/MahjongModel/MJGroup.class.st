Class {
	#name : #MJGroup,
	#superclass : #MJTiles,
	#instVars : [
		'simpleTiles',
		'kind'
	],
	#category : #'MahjongModel-Tiles'
}

{ #category : #creation }
MJGroup class >> new [
	^ super new new
]

{ #category : #creation }
MJGroup class >> only: tile [
	^ self new startWith: tile
]

{ #category : #creation }
MJGroup class >> with: aCollection [
	| instance |
	instance := self new.
	aCollection do: [ :tile | instance add: tile ].
	^ instance
]

{ #category : #predicates }
MJGroup >> accepts: tile [
	^ kind = tile suit & ((MJGroupCache at: simpleTiles asArray) includes: tile value)
]

{ #category : #'private  - missing' }
MJGroup >> acceptsRunWith: accepts [
	1
		to: 9
		do: [ :i | 
			| new |
			new := (tiles at: 1) number: i.
			(self accepts: new) ifTrue: [ accepts addLast: new ] ]
]

{ #category : #missing }
MJGroup >> acceptsTiles [
	^ MJHand with: self rawAccepts asOrderedCollection
]

{ #category : #'private - missing' }
MJGroup >> acceptsTripleWith: accepts [
	accepts addLast: (tiles at: 1) shallowCopy
]

{ #category : #adding }
MJGroup >> add: tile [
	tiles isEmpty ifTrue: [ ^ self startWith: tile ].
	(self accepts: tile) ifTrue: [ self addTile: tile].
	^ self
]

{ #category : #adding }
MJGroup >> addTile: tile [
	tiles addLast: tile.
	simpleTiles addLast: tile value
]

{ #category : #predicates }
MJGroup >> isComplete [
	^ 3 <= tiles size
]

{ #category : #predicates }
MJGroup >> isPair [
	^ 2 = tiles size and: [ (tiles at: 1) valueSort = (tiles at: 2) valueSort ]
]

{ #category : #accessing }
MJGroup >> kind [
	^ kind
]

{ #category : #creation }
MJGroup >> new [
	tiles := OrderedCollection new.
	simpleTiles := OrderedCollection new
]

{ #category : #private }
MJGroup >> rawAccepts [
	^ (MJGroupCache at: simpleTiles asArray)
		collect: [ :v | 
			kind = v
				ifTrue: [ MJFace convertKind: kind ]
				ifFalse: [ MJNumber resolveSuit: kind with: v ] ]
]

{ #category : #predicates }
MJGroup >> sameAs: group [
	^ self valueSort = group valueSort
]

{ #category : #predicates }
MJGroup >> size [
	^ tiles size
]

{ #category : #accessing }
MJGroup >> startWith: tile [
	self addTile: tile.
	kind := tile suit.
	^ self
]

{ #category : #visualization }
MJGroup >> visualizeAccepts: view [
	| needs nodes |
	needs := self acceptsTiles.
	nodes := needs tiles copy.
	nodes addLast: self.

	tiles isEmpty
		ifTrue: [ needs naturalLayout: view ]
		ifFalse: [ MahjongExamples new
				basicGraph: nodes
				edges: (needs tiles collect: [ :tile | self -> tile ])
				withView: view ].
	^ view
]

{ #category : #visualization }
MJGroup >> visualizeAcceptsView: aView [
	<gtView>
	self acceptsTiles tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]
