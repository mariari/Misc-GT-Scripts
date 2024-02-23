Class {
	#name : #MJHand,
	#superclass : #MJTiles,
	#category : #MiscGTScripts
}

{ #category : #accessing }
MJHand class >> allTiles [
	^ '123456789m123456789p123456789s1234567z' asMJHand
]

{ #category : #accessing }
MJHand class >> with: aCollection [
	^ self new withHand: aCollection
]

{ #category : #accessing }
MJHand >> accepts [
	| permutations groups acceptHands ordered |
	permutations := Array
			streamContents: [ :stream | tiles permutationsDo: [ :each | stream nextPut: each copy ] ].

	groups := permutations collect: [ :hand | MJGroups with: hand ].
	acceptHands := groups collect: [ :group | group accepts ].
	ordered := OrderedCollection new.
	acceptHands do: [ :hand | ordered addAll: hand tiles ].
	^ (MJHand with: ordered) unique
]

{ #category : #accessing }
MJHand >> acceptsComplete [
	| permutations groups acceptHands ordered |
	permutations := Array
			streamContents: [ :stream | tiles permutationsDo: [ :each | stream nextPut: each copy ] ].

	groups := permutations collect: [ :hand | MJGroups with: hand ].
	acceptHands := groups collect: [ :group | group acceptsComplete ].
	ordered := OrderedCollection new.
	acceptHands do: [ :hand | ordered addAll: hand tiles ].
	^ (MJHand with: ordered) unique
]

{ #category : #visualization }
MJHand >> visualizeAccepts: view [
	^ self visualizeHandAccepts: self accepts withView: view
]

{ #category : #visualization }
MJHand >> visualizeAcceptsComplete: view [
	^ self visualizeHandAccepts: self acceptsComplete withView: view.
]

{ #category : #accessing }
MJHand >> visualizeAcceptsView: aView [
	<gtView>
	self accepts tiles isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]

{ #category : #accessing }
MJHand >> visualizeAcceptsViewComplete: aView [
	<gtView>
	self acceptsComplete tiles  isEmpty ifTrue: [ ^ aView empty ].
	^ aView mondrian
		title: 'Accepts Complete';
		painting: [ :view | self visualizeAcceptsComplete: view ]
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

{ #category : #accessing }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
