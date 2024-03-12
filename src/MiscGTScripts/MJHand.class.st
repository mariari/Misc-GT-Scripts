"
I am a generic Mahjong hand. I can serve most needs one may ask for, however
"
Class {
	#name : #MJHand,
	#superclass : #MJTiles,
	#category : #'MiscGTScripts-Tiles'
}

{ #category : #instance }
MJHand class >> allTiles [
	^ '123456789m123456789p123456789s1234567z' asMJHand
]

{ #category : #creation }
MJHand class >> empty [
	^ self new withHand: {}
]

{ #category : #creation }
MJHand class >> with: aCollection [
	^ self new withHand: aCollection
]

{ #category : #deprecated }
MJHand >> acceptPermutations [
	| grouped |
	grouped := tiles groupedBy: [ :v | v suit ].
	^ Array
		streamContents: [ :stream | 
			grouped values
				do: [ :kind | kind permutationsDo: [ :each | stream nextPut: each copy ] ] ]
]

{ #category : #accepting }
MJHand >> accepts [
	^ self chunkedGroupBackTrackerwith: #accepts
]

{ #category : #accepting }
MJHand >> acceptsComplete [
	^ self chunkedGroupBackTrackerwith: #acceptsComplete
]

{ #category : #deprecated }
MJHand >> acceptsPermutation [
	| predicate |
	predicate := [ :group | group accepts ].
	^ self fromPermutations: self acceptPermutations withAcceptance: predicate
]

{ #category : #deprecated }
MJHand >> acceptsPermutationComplete [
	| predicate |
	predicate := [ :group | group acceptsComplete ].
	^ self fromPermutations: self acceptPermutations withAcceptance: predicate
]

{ #category : #accepting }
MJHand >> acceptsShanten [
	| arr |
	arr := (self shantenBackTrack: MJGroups new index: 1) at: 1.
	^ (self class with: arr) unique
]

{ #category : #'private - accepting' }
MJHand >> chunkedGroupBackTrackerwith: aBlock [
	"the aBlock should be an acceptor like #accepts or #acceptsComplete"

	| grouped collected |
	grouped := tiles groupedBy: [ :v | v suit ].
	collected := grouped values
			collect: [ :kindArr | 
				(kindArr at: 1) isSpecial
					ifTrue: [ (aBlock value: (MJGroups with: kindArr)) tiles ]
					ifFalse: [ MJHand new
							withHand: kindArr;
							groupBackTrack: MJGroups new
								index: 1
								withAcceptor: aBlock ] ].
	^ (MJHand with: (collected flatCollect: [ :obj | obj ])) unique
]

{ #category : #deprecated }
MJHand >> fromPermutations: permutations withAcceptance: predicate [
	| set ordered acceptHands |
	set := self uniqueSet.
	permutations do: [ :hand | set add: (MJGroups with: hand) ].

	acceptHands := set collect: predicate.
	ordered := OrderedCollection new.
	acceptHands do: [ :hand | ordered addAll: hand tiles ].
	^ (MJHand with: ordered) unique
]

{ #category : #'private - accepting' }
MJHand >> groupBackTrack: aGroup index: currentTile [
	"Does backtracking for seeing what tiles the hand accepts.
	The index is simply where in the array we are cdring down"

	^ self
		groupBackTrack: aGroup
		index: currentTile
		withAcceptor: #accepts
]

{ #category : #'private - accepting' }
MJHand >> groupBackTrack: aGroup index: currentTile withAcceptor: anAcceptor [
	"Does backtracking for seeing what tiles the hand accepts.
	The index is simply where in the array we are cdring down
	The acceptor are things like #accepts or #acceptsComplete"

	| tile accepting recurse |
	currentTile > tiles size & aGroup valid not ifTrue: [ ^ {} ].
	currentTile > tiles size ifTrue: [ ^ (anAcceptor value: aGroup) tiles ].

	tile := tiles at: currentTile.

	recurse := [ :groups | 
		self
			groupBackTrack: groups
			index: currentTile + 1
			withAcceptor: anAcceptor ].

	accepting := aGroup
			onAccepting: tile
			doIndependently: [ :groups :group | 
				group add: tile.
				recurse value: groups ].


	accepting := accepting flatCollect: [ :each | each ].
	aGroup addIndependently: tile.

	accepting addAll: (recurse value: aGroup).
	^ accepting
]

{ #category : #accessing }
MJHand >> groups [
	^ self subclassResponsibility
]

{ #category : #accessing }
MJHand >> pair [
	^ self subclassResponsibility
]

{ #category : #accepting }
MJHand >> shanten [
	^ (self shantenGroups: MJGroups new index: 1) at: 2
]

{ #category : #'private - accepting' }
MJHand >> shantenBackTrack: aGroup index: currentTile [
	"Does backtracking for seeing what tiles the hand accepts.
	The index is simply where in the array we are cdring down"

	| anArr |
	anArr := self shantenGroups: aGroup index: currentTile.
	^ {(anArr at: 1) flatCollect: [ :group | group acceptsShanten tiles].
		anArr at: 2}
]

{ #category : #accepting }
MJHand >> shantenGroups [
	^ (self shantenGroups: MJGroups new index: 1) at: 1
]

{ #category : #'private - accepting' }
MJHand >> shantenGroups: aGroup index: currentTile [
	"Does backtracking for seeing what tiles the hand accepts.
	The index is simply where in the array we are cdring down"

	| tile accepting recurse min |
	currentTile > tiles size
		ifTrue: [ ^ {aGroup.
				aGroup shanten: self groups assumePair: self pair not} ].

	tile := tiles at: currentTile.

	recurse := [ :groups | self shantenGroups: groups index: currentTile + 1 ].

	accepting := aGroup
			onAccepting: tile
			doIndependently: [ :groups :group | 
				group add: tile.
				recurse value: groups ].
	aGroup addIndependently: tile.
	accepting add: (recurse value: aGroup).

	min := (accepting collect: [ :each | each at: 2 ]) min.

	accepting := accepting
			select: [ :ele | (ele at: 2) = min ]
			thenCollect: [ :each | each at: 1 ].
	^ {accepting flattened.
		min}
]

{ #category : #unique }
MJHand >> uniqueSet [
	| set |
	set := PluggableSet new.
	set equalBlock: [ :a :b | a valueSort = b valueSort ].
	set hashBlock: [ :ele | ele uniqueHash ].
	^ set
]

{ #category : #visualization }
MJHand >> visualizeAccepts: view [
	^ self visualizeHandAccepts: self accepts withView: view
]

{ #category : #visualization }
MJHand >> visualizeAcceptsComplete: view [
	^ self visualizeHandAccepts: self acceptsComplete withView: view.
]

{ #category : #visualization }
MJHand >> visualizeAcceptsShanten: view [
	^ self visualizeHandAccepts: self acceptsShanten withView: view.
]

{ #category : #visualization }
MJHand >> visualizeAcceptsShantenView: aView [
	<gtView>
	self acceptsShanten tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAcceptsShanten: view ]
]

{ #category : #visualization }
MJHand >> visualizeAcceptsView: aView [
	<gtView>
	self accepts tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts All';
		painting: [ :view | self visualizeAccepts: view ]
]

{ #category : #visualization }
MJHand >> visualizeAcceptsViewComplete: aView [
	<gtView>
	self acceptsComplete tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts Complete';
		painting: [ :view | self visualizeAcceptsComplete: view ]
]

{ #category : #visualization }
MJHand >> visualizeGroups: aView [
	<gtView>
	| groups |
	groups := self shantenGroups.
	^ aView columnedList
		title: 'Groups';
		items: [ groups ];
		column: 'Groupings'
			stencil: [ :group | group asBlElement ].
]

{ #category : #visualization }
MJHand >> visualizeHandAccepts: needs withView: view [
	| nodes |
	nodes := needs tiles copy.
	nodes addLast: self.

	MahjongExamples new
		basicGraph: nodes
		edges: (needs tiles collect: [ :tile | self -> tile ])
		withView: view.
	^ view
]

{ #category : #creation }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
