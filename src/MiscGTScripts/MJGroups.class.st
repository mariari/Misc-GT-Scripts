Class {
	#name : #MJGroups,
	#superclass : #MJTiles,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #creating }
MJGroups class >> new [
	^ super new new
]

{ #category : #creation }
MJGroups class >> with: aCollection [
	| instance |
	instance := self new.
	aCollection do: [ :tile | instance add: tile ].
	^ instance
]

{ #category : #accepting }
MJGroups >> accepts [
	| set |
	set := OrderedCollection new.
	tiles do: [ :group | group acceptsTiles tiles do: [ :tile | set add: tile ] ].
	^ (MJHand with: set) unique
]

{ #category : #predicates }
MJGroups >> accepts: tile [
	^ tiles anySatisfy: [ :obj | obj accepts: tile ]
]

{ #category : #accepting }
MJGroups >> acceptsComplete [
	| noComplete |
	noComplete := tiles reject: [ :group | group tiles size > 2 ].
	noComplete size > 1 ifTrue: [ ^ MJHand with: OrderedCollection new ].
	(noComplete reject: [ :group | group tiles size = 2 ]) size ~= 0
		ifTrue: [ ^ MJHand with: OrderedCollection new ].
	^ self accepts
]

{ #category : #adding }
MJGroups >> add: tile [
	^ tiles
		detect: [ :obj | obj accepts: tile ]
		ifOne: [ :obj | obj add: tile ]
		ifNone: [ self addIndependently: tile ]
]

{ #category : #adding }
MJGroups >> addGroupIndependently: group [
	^ tiles addLast: group
]

{ #category : #adding }
MJGroups >> addIndependently: tile [
	^ self addGroupIndependently: (MJGroup only: tile)
]

{ #category : #accessing }
MJGroups >> naturalLayout: view [
	view nodes
		shape: [ :each | each asBlElement padding: (BlInsets all: 15) ];
		with: tiles.
	^ view
]

{ #category : #creating }
MJGroups >> new [
	tiles := OrderedCollection new.
	^ self
]

{ #category : #predicates }
MJGroups >> noRedundantPairs [
	" can only happen on kans that are split into 2 groups "

	| duos |
	duos := tiles reject: [ :x | 2 ~= x size ].
	^ duos
		allSatisfy: [ :d | duos noneSatisfy: [ :d2 | (d == d2) not & (d accepts: (d2 tiles at: 1)) ] ]
]

{ #category : #predicates }
MJGroups >> noRedundantSingles [
	| singles |
	singles := tiles reject: [ :x | 1 ~= x size ].

	^ singles
		allSatisfy: [ :single | 
			tiles
				noneSatisfy: [ :obj | (obj == single) not & (obj accepts: (single tiles at: 1)) ] ]
]

{ #category : #iterating }
MJGroups >> onAccepting: tile doIndependently: block [
	| accepts|
	^ self
]

{ #category : #predicates }
MJGroups >> valid [
	^ self noRedundantPairs & self noRedundantSingles
]

{ #category : #visualization }
MJGroups >> visualizeAccepts: view [
	tiles do: [ :group | group visualizeAccepts: view ].
	^ view
]

{ #category : #visualization }
MJGroups >> visualizeAcceptsView: aView [
	<gtView>
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]
