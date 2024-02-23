Class {
	#name : #MJGroup,
	#superclass : #MJTiles,
	#instVars : [
		'kind'
	],
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJGroup class >> new [
	^ super new new
]

{ #category : #accessing }
MJGroup class >> with: aCollection [
	| instance |
	instance := self new.
	aCollection do: [ :tile | instance add: tile ].
	^ instance
]

{ #category : #accessing }
MJGroup >> accepts: tile [
	^ (tiles allSatisfy: [ :aTile | self predicate value: aTile value: tile ])
		or: [ tiles isEmpty ]
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
	| accepts |
	tiles isEmpty ifTrue: [ ^ MJHand allTiles ].
	accepts := OrderedCollection empty.

	kind = 'run' ifTrue: [ self acceptsRunWith: accepts ].
	kind = 'triples' | (tiles at: 1) isSpecial
		ifTrue: [ self acceptsTripleWith: accepts ].
	kind isNil & (tiles at: 1) isSpecial not
		ifTrue: [ self acceptsRunWith: accepts ].
	^ MJHand with: accepts
]

{ #category : #'private - missing' }
MJGroup >> acceptsTripleWith: accepts [
	accepts addLast: (tiles at: 1) shallowCopy
]

{ #category : #accessing }
MJGroup >> add: tile [
	(self accepts: tile) ifFalse: [ ^ self ].
	tiles addLast: tile.
	tiles size = 2
		ifTrue: [ ((tiles at: 1) sameAs: (tiles at: 2))
				ifTrue: [ kind := 'triples' ]
				ifFalse: [ kind := 'run' ] ].
	^ self
]

{ #category : #accessing }
MJGroup >> new [
	tiles := OrderedCollection new
]

{ #category : #accessing }
MJGroup >> predicate [
	kind = 'run' ifTrue: [ ^ [ :v1 :v2 | v1 runsWith: v2 ] ].
	kind = 'triples' ifTrue: [ ^ [ :v1 :v2 | v1 sameAs: v2 ] ].
	^ [ :v1 :v2 | v1 combinesWith: v2 ]
]

{ #category : #views }
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

{ #category : #views }
MJGroup >> visualizeAcceptsView: aView [
	<gtView>
	self acceptsTiles tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]
