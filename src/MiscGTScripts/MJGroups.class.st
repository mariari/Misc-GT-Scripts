"
I am the generic groups class. I cover most of the use case of groups one can imagine.
"
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

{ #category : #accepting }
MJGroups >> acceptsShanten [
	| set |
	set := OrderedCollection new.
	tiles do: [ :group | group acceptsTiles tiles do: [ :tile | set add: tile ] ].
	^ (MJHand with: set) unique
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

{ #category : #visualization }
MJGroups >> asBlElement [
	| ele |
	ele := self naturalHandLayout asElement.
	^ ele
]

{ #category : #shanten }
MJGroups >> completeSets [
	^ tiles inject: 0 into: [ :sum :tile | sum + tile isComplete asBit ]
]

{ #category : #accessing }
MJGroups >> find: aBlock [
	"finds a given block"

	^ tiles detect: aBlock ifOne: [ :obj | obj ]
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
	duos := tiles select: [ :x | 2 = x size ].
	^ duos
		allSatisfy: [ :d | duos noneSatisfy: [ :d2 | (d == d2) not & (d accepts: (d2 tiles at: 1)) ] ]
]

{ #category : #predicates }
MJGroups >> noRedundantSingles [
	| singles |
	singles := tiles select: [ :x | 1 = x size ].

	^ singles
		allSatisfy: [ :single | 
			tiles
				noneSatisfy: [ :obj | (obj == single) not & (obj accepts: (single tiles at: 1)) ] ]
]

{ #category : #iterating }
MJGroups >> onAccepting: tile doIndependently: block [
	| indexed |
	indexed := tiles
			withIndexCollect: [ :each :index | 
				{each.
					index} ].
	^ indexed
		select: [ :group | (group at: 1) accepts: tile ]
		thenCollect: [ :indexedGroup | 
			| copiedGroups copiedGroup |
			copiedGroups := self deepCopy.
			copiedGroup := copiedGroups tiles at: (indexedGroup at: 2).
			block value: copiedGroups value: copiedGroup ]
]

{ #category : #shanten }
MJGroups >> pairNumber [
	"we can have at max 1, any more is part of a set"

	tiles do: [ :tile | tile isPair ifTrue: [ ^ 1 ] ].
	^ 0
]

{ #category : #shanten }
MJGroups >> partialSets [
	^ tiles inject: 0 into: [ :sum :tile | sum + (tile size = 2) asBit ]
]

{ #category : #shanten }
MJGroups >> shanten: groups assumePair: aBool [
	| sets partialSets pairs |
	pairs := aBool ifTrue: [ 1 ] ifFalse: [ self pairNumber ].
	sets := self completeSets.
	partialSets := self partialSets - (aBool ifTrue: [ 0 ] ifFalse: [ pairs ])
			min: groups - sets.
	^ groups * 2 - (2 * sets) - (1 * partialSets) - pairs
]

{ #category : #shanten }
MJGroups >> shantenNoPair: numGroups [
	^ self shanten: numGroups assumePair: true
]

{ #category : #shanten }
MJGroups >> shantenPair: numGroups [
	^ self shanten: numGroups assumePair: false
]

{ #category : #predicates }
MJGroups >> valid [
	^ self noRedundantPairs & self noRedundantSingles
]

{ #category : #equality }
MJGroups >> valueSort [
	"Fixup we need to shift the values by the index"
	| index | 
	index := 0.
	^ tiles inject: 0 into: [ :sum :b | index := index + 1. sum + (b valueSort * index) ]
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
