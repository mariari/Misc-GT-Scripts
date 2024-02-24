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
		ifNone: [ tiles addLast: (MJGroup only: tile) ]
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
