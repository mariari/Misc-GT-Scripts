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
MJHand class >> with: aCollection [
	^ self new withHand: aCollection
]

{ #category : #'private - accepting' }
MJHand >> acceptPermutations [
	| grouped |
	grouped := tiles groupedBy: [ :v | v kind ].
	^ Array
		streamContents: [ :stream | 
			grouped values
				do: [ :kind | kind permutationsDo: [ :each | stream nextPut: each copy ] ] ]
]

{ #category : #accepting }
MJHand >> accepts [
	| predicate |
	predicate := [ :group | group accepts ].
	^ self fromPermutations: self acceptPermutations withAcceptance: predicate
]

{ #category : #accepting }
MJHand >> acceptsComplete [
	| predicate |
	predicate := [ :group | group acceptsComplete ].
	^ self fromPermutations: self acceptPermutations withAcceptance: predicate
]

{ #category : #'private - permutations' }
MJHand >> fromPermutations: permutations withAcceptance: predicate [
	| set ordered acceptHands |
	set := self uniqueSet.
	permutations do: [ :hand | set add: (MJGroups with: hand) ].

	acceptHands := set collect: predicate.
	ordered := OrderedCollection new.
	acceptHands do: [ :hand | ordered addAll: hand tiles ].
	^ (MJHand with: ordered) unique
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
MJHand >> visualizeAcceptsView: aView [
	<gtView>
	"self accepts tiles isEmpty ifTrue: [ ^ aView empty ]."
	^ aView mondrian
		title: 'Accepts';
		painting: [ :view | self visualizeAccepts: view ]
]

{ #category : #visualization }
MJHand >> visualizeAcceptsViewComplete: aView [
	<gtView>
	"self acceptsComplete tiles  isEmpty ifTrue: [ ^ aView empty ]."
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

{ #category : #creation }
MJHand >> withHand: aCollection [
	tiles := aCollection
]
